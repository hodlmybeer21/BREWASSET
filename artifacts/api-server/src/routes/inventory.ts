import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import {
  inventoryTable,
  receiveHistoryTable,
  brandsTable,
  catalogItemsTable,
} from "@workspace/db/schema";
import { eq, and, desc } from "drizzle-orm";
import { z } from "zod";
import { requireRole } from "../middlewares/auth.js";

const router: IRouter = Router();

router.get(
  "/",
  requireRole("warehouse", "marketing", "rep"),
  async (_req: Request, res: Response) => {
    try {
      const rows = await db
        .select({
          id: inventoryTable.id,
          itemType: inventoryTable.itemType,
          brand: inventoryTable.brand,
          quantity: inventoryTable.quantity,
          catalogItemId: inventoryTable.catalogItemId,
          brandId: inventoryTable.brandId,
        })
        .from(inventoryTable)
        .orderBy(inventoryTable.itemType, inventoryTable.brand);
      res.json(rows);
    } catch (err) {
      console.error("[inventory GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const receiveSchema = z.object({
  itemType: z.string(),
  brand: z.string(),
  quantity: z.number().int().positive(),
  note: z.string().optional(),
});

router.post(
  "/receive",
  requireRole("warehouse"),
  async (req: Request, res: Response) => {
    try {
      const body = receiveSchema.parse(req.body);

      await db.transaction(async (tx) => {
        const existing = await tx
          .select()
          .from(inventoryTable)
          .where(
            and(
              eq(inventoryTable.itemType, body.itemType),
              eq(inventoryTable.brand, body.brand),
            ),
          );

        if (existing.length > 0) {
          await tx
            .update(inventoryTable)
            .set({ quantity: existing[0].quantity + body.quantity })
            .where(eq(inventoryTable.id, existing[0].id));
        } else {
          const catItems = await tx
            .select()
            .from(catalogItemsTable)
            .where(eq(catalogItemsTable.name, body.itemType));
          const catItem = catItems[0];
          const brands = catItem
            ? await tx
                .select()
                .from(brandsTable)
                .where(
                  and(
                    eq(brandsTable.catalogItemId, catItem.id),
                    eq(brandsTable.name, body.brand),
                  ),
                )
            : [];
          const brand = brands[0];

          await tx.insert(inventoryTable).values({
            itemType: body.itemType,
            brand: body.brand,
            quantity: body.quantity,
            catalogItemId: catItem?.id ?? 0,
            brandId: brand?.id ?? 0,
          });
        }

        await tx.insert(receiveHistoryTable).values({
          itemType: body.itemType,
          brand: body.brand,
          quantity: body.quantity,
          note: body.note,
        });
      });

      res.json({ success: true, message: "Stock received" });
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[inventory receive]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.get(
  "/history",
  requireRole("warehouse", "marketing"),
  async (_req: Request, res: Response) => {
    try {
      const rows = await db
        .select()
        .from(receiveHistoryTable)
        .orderBy(desc(receiveHistoryTable.createdAt))
        .limit(200);
      res.json(
        rows.map((r) => ({
          ...r,
          createdAt: r.createdAt.toISOString(),
        })),
      );
    } catch (err) {
      console.error("[inventory history]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
