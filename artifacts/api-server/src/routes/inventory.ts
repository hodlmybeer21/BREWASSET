import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { inventoryTable, receiveHistoryTable, brandsTable, catalogItemsTable } from "@workspace/db/schema";
import { eq, and, desc } from "drizzle-orm";
import { z } from "zod";

const router: IRouter = Router();

router.get("/", async (_req: Request, res: Response) => {
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
});

const receiveSchema = z.object({
  itemType: z.string(),
  brand: z.string(),
  quantity: z.number().int().positive(),
  note: z.string().optional(),
});

router.post("/receive", async (req: Request, res: Response) => {
  try {
    const body = receiveSchema.parse(req.body);

    // Find or create inventory row
    const existing = await db
      .select()
      .from(inventoryTable)
      .where(and(eq(inventoryTable.itemType, body.itemType), eq(inventoryTable.brand, body.brand)));

    if (existing.length > 0) {
      await db
        .update(inventoryTable)
        .set({ quantity: existing[0].quantity + body.quantity })
        .where(eq(inventoryTable.id, existing[0].id));
    } else {
      // Look up catalog ids
      const catItems = await db.select().from(catalogItemsTable).where(eq(catalogItemsTable.name, body.itemType));
      const catItem = catItems[0];
      const brands = catItem
        ? await db.select().from(brandsTable).where(and(eq(brandsTable.catalogItemId, catItem.id), eq(brandsTable.name, body.brand)))
        : [];
      const brand = brands[0];

      await db.insert(inventoryTable).values({
        itemType: body.itemType,
        brand: body.brand,
        quantity: body.quantity,
        catalogItemId: catItem?.id ?? 0,
        brandId: brand?.id ?? 0,
      });
    }

    // Log history
    await db.insert(receiveHistoryTable).values({
      itemType: body.itemType,
      brand: body.brand,
      quantity: body.quantity,
      note: body.note,
    });

    res.json({ success: true, message: "Stock received" });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.get("/history", async (_req: Request, res: Response) => {
  const rows = await db
    .select()
    .from(receiveHistoryTable)
    .orderBy(desc(receiveHistoryTable.createdAt))
    .limit(200);
  res.json(rows.map(r => ({
    ...r,
    createdAt: r.createdAt.toISOString(),
  })));
});

export default router;
