import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import {
  transfersTable,
  inventoryTable,
  receiveHistoryTable,
  accountAssetsTable,
} from "@workspace/db/schema";
import { eq, and, desc } from "drizzle-orm";
import { z } from "zod";
import { requireRole, resolveRepUsername } from "../middlewares/auth.js";

const router: IRouter = Router();

router.get(
  "/",
  requireRole("rep", "warehouse", "marketing"),
  async (req: Request, res: Response) => {
    try {
      const rows = await db
        .select()
        .from(transfersTable)
        .orderBy(desc(transfersTable.createdAt));
      const ownedRep = resolveRepUsername(
        req,
        req.query.repUsername as string | undefined,
      );
      const filtered = ownedRep
        ? rows.filter((r) => r.repUsername === ownedRep)
        : rows;
      res.json(
        filtered.map((r) => ({ ...r, createdAt: r.createdAt.toISOString() })),
      );
    } catch (err) {
      console.error("[transfers GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const createSchema = z.object({
  itemType: z.string(),
  brand: z.string(),
  quantity: z.number().int().positive(),
  fromAccount: z.string(),
  toAccount: z.string(),
});

router.post("/", requireRole("rep"), async (req: Request, res: Response) => {
  try {
    const body = createSchema.parse(req.body);
    const user = req.user!;

    const created = await db.transaction(async (tx) => {
      const isReturn =
        body.toAccount === "MAIN WAREHOUSE" ||
        body.toAccount === "⬡ MAIN WAREHOUSE";

      if (isReturn) {
        const inv = await tx
          .select()
          .from(inventoryTable)
          .where(
            and(
              eq(inventoryTable.itemType, body.itemType),
              eq(inventoryTable.brand, body.brand),
            ),
          );
        if (inv[0]) {
          await tx
            .update(inventoryTable)
            .set({ quantity: inv[0].quantity + body.quantity })
            .where(eq(inventoryTable.id, inv[0].id));
        } else {
          await tx.insert(inventoryTable).values({
            itemType: body.itemType,
            brand: body.brand,
            quantity: body.quantity,
            catalogItemId: 0,
            brandId: 0,
          });
        }
        await tx.insert(receiveHistoryTable).values({
          itemType: body.itemType,
          brand: body.brand,
          quantity: body.quantity,
          note: `Returned by ${user.username} from ${body.fromAccount}`,
        });
      }

      async function adjustAsset(account: string, delta: number) {
        const now = new Date();
        const dateStr =
          now.toLocaleDateString("en-US") +
          " " +
          now.toLocaleTimeString("en-US", {
            hour: "numeric",
            minute: "2-digit",
            hour12: true,
          });
        const existing = await tx
          .select()
          .from(accountAssetsTable)
          .where(
            and(
              eq(accountAssetsTable.repUsername, user.username),
              eq(accountAssetsTable.account, account),
              eq(accountAssetsTable.itemType, body.itemType),
              eq(accountAssetsTable.brand, body.brand),
            ),
          );
        if (existing[0]) {
          const newCount = Math.max(0, existing[0].count + delta);
          const updateFields: Record<string, unknown> = {
            count: newCount,
            updatedAt: now,
          };
          if (delta > 0) updateFields.lastDate = dateStr;
          await tx
            .update(accountAssetsTable)
            .set(updateFields)
            .where(eq(accountAssetsTable.id, existing[0].id));
        } else if (delta > 0) {
          await tx.insert(accountAssetsTable).values({
            repUsername: user.username,
            account,
            itemType: body.itemType,
            brand: body.brand,
            count: delta,
            lastDate: dateStr,
          });
        }
      }

      await adjustAsset(body.fromAccount, -body.quantity);
      if (!isReturn) await adjustAsset(body.toAccount, body.quantity);

      const [row] = await tx
        .insert(transfersTable)
        .values({
          repUsername: user.username,
          itemType: body.itemType,
          brand: body.brand,
          quantity: body.quantity,
          fromAccount: body.fromAccount,
          toAccount: body.toAccount,
          isReturn,
        })
        .returning();
      return row;
    });

    res.json({ ...created, createdAt: created.createdAt.toISOString() });
  } catch (err) {
    if (err instanceof z.ZodError) {
      res.status(400).json({ error: "Invalid request", details: err.flatten() });
      return;
    }
    console.error("[transfers POST]", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

export default router;
