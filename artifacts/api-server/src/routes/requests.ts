import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { posRequestsTable, inventoryTable } from "@workspace/db/schema";
import { eq, and, desc } from "drizzle-orm";
import { z } from "zod";

const router: IRouter = Router();

router.get("/", async (req: Request, res: Response) => {
  const rows = await db
    .select()
    .from(posRequestsTable)
    .orderBy(desc(posRequestsTable.createdAt));

  const filtered = req.query.repUsername
    ? rows.filter(r => r.repUsername === req.query.repUsername)
    : rows;

  res.json(filtered.map(r => ({
    ...r,
    createdAt: r.createdAt.toISOString(),
    fulfilledAt: r.fulfilledAt ? r.fulfilledAt.toISOString() : null,
  })));
});

const createSchema = z.object({
  customer: z.string(),
  itemType: z.string(),
  brand: z.string(),
  quantity: z.number().int().positive(),
});

router.post("/", async (req: Request, res: Response) => {
  try {
    const body = createSchema.parse(req.body);
    const userId = (req as any).session?.userId;

    // Get rep username from session
    const { db: dbClient } = await import("@workspace/db");
    const { usersTable } = await import("@workspace/db/schema");
    const users = await dbClient.select().from(usersTable).where(eq(usersTable.id, userId));
    const user = users[0];
    if (!user) { res.status(401).json({ error: "Not authenticated" }); return; }

    // Check inventory
    const inv = await db
      .select()
      .from(inventoryTable)
      .where(and(eq(inventoryTable.itemType, body.itemType), eq(inventoryTable.brand, body.brand)));

    const current = inv[0];
    if (!current || current.quantity < body.quantity) {
      res.status(400).json({ error: "Insufficient stock" });
      return;
    }

    // Deduct from inventory
    await db
      .update(inventoryTable)
      .set({ quantity: current.quantity - body.quantity })
      .where(eq(inventoryTable.id, current.id));

    // Create request
    const [created] = await db.insert(posRequestsTable).values({
      repUsername: user.username,
      customer: body.customer,
      itemType: body.itemType,
      brand: body.brand,
      quantity: body.quantity,
      status: "Pending",
    }).returning();

    res.json({ ...created, createdAt: created.createdAt.toISOString(), fulfilledAt: null });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.post("/:id/fulfill", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id);
  await db.update(posRequestsTable)
    .set({ status: "Fulfilled", fulfilledAt: new Date() })
    .where(eq(posRequestsTable.id, id));
  res.json({ success: true, message: "Request fulfilled" });
});

router.post("/:id/cancel", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id);

  // Get the request to restore inventory
  const reqs = await db.select().from(posRequestsTable).where(eq(posRequestsTable.id, id));
  const req2 = reqs[0];
  if (req2 && req2.status === "Pending") {
    // Restore inventory
    const inv = await db
      .select()
      .from(inventoryTable)
      .where(and(eq(inventoryTable.itemType, req2.itemType), eq(inventoryTable.brand, req2.brand)));
    if (inv[0]) {
      await db.update(inventoryTable)
        .set({ quantity: inv[0].quantity + req2.quantity })
        .where(eq(inventoryTable.id, inv[0].id));
    }
  }

  await db.update(posRequestsTable)
    .set({ status: "Cancelled" })
    .where(eq(posRequestsTable.id, id));

  res.json({ success: true, message: "Request cancelled" });
});

export default router;
