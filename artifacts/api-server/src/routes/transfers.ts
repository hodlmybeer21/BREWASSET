import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { transfersTable, inventoryTable, receiveHistoryTable, usersTable, accountAssetsTable } from "@workspace/db/schema";
import { eq, and, desc } from "drizzle-orm";
import { z } from "zod";

const router: IRouter = Router();

router.get("/", async (req: Request, res: Response) => {
  const rows = await db.select().from(transfersTable).orderBy(desc(transfersTable.createdAt));
  const filtered = req.query.repUsername
    ? rows.filter(r => r.repUsername === req.query.repUsername)
    : rows;
  res.json(filtered.map(r => ({ ...r, createdAt: r.createdAt.toISOString() })));
});

const createSchema = z.object({
  itemType: z.string(),
  brand: z.string(),
  quantity: z.number().int().positive(),
  fromAccount: z.string(),
  toAccount: z.string(),
});

router.post("/", async (req: Request, res: Response) => {
  try {
    const body = createSchema.parse(req.body);
    const userId = (req as any).session?.userId;
    const users = await db.select().from(usersTable).where(eq(usersTable.id, userId));
    const user = users[0];
    if (!user) { res.status(401).json({ error: "Not authenticated" }); return; }

    const isReturn = body.toAccount === "⬡ MAIN WAREHOUSE";

    if (isReturn) {
      // Return to inventory
      const inv = await db
        .select()
        .from(inventoryTable)
        .where(and(eq(inventoryTable.itemType, body.itemType), eq(inventoryTable.brand, body.brand)));
      if (inv[0]) {
        await db.update(inventoryTable)
          .set({ quantity: inv[0].quantity + body.quantity })
          .where(eq(inventoryTable.id, inv[0].id));
      } else {
        await db.insert(inventoryTable).values({
          itemType: body.itemType,
          brand: body.brand,
          quantity: body.quantity,
          catalogItemId: 0,
          brandId: 0,
        });
      }
      await db.insert(receiveHistoryTable).values({
        itemType: body.itemType,
        brand: body.brand,
        quantity: body.quantity,
        note: `Returned by ${user.username} from ${body.fromAccount}`,
      });
    }

    // Update account assets
    async function adjustAsset(account: string, delta: number) {
      const existing = await db.select().from(accountAssetsTable)
        .where(and(
          eq(accountAssetsTable.repUsername, user.username),
          eq(accountAssetsTable.account, account),
          eq(accountAssetsTable.itemType, body.itemType),
          eq(accountAssetsTable.brand, body.brand)
        ));
      if (existing[0]) {
        const newCount = Math.max(0, existing[0].count + delta);
        await db.update(accountAssetsTable)
          .set({ count: newCount })
          .where(eq(accountAssetsTable.id, existing[0].id));
      } else if (delta > 0) {
        await db.insert(accountAssetsTable).values({
          repUsername: user.username,
          account,
          itemType: body.itemType,
          brand: body.brand,
          count: delta,
        });
      }
    }

    await adjustAsset(body.fromAccount, -body.quantity);
    if (!isReturn) await adjustAsset(body.toAccount, body.quantity);

    const [created] = await db.insert(transfersTable).values({
      repUsername: user.username,
      itemType: body.itemType,
      brand: body.brand,
      quantity: body.quantity,
      fromAccount: body.fromAccount,
      toAccount: body.toAccount,
      isReturn,
    }).returning();

    res.json({ ...created, createdAt: created.createdAt.toISOString() });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

export default router;
