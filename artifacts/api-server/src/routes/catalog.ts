import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { catalogItemsTable, brandsTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";
import { z } from "zod";

const router: IRouter = Router();

router.get("/items", async (_req: Request, res: Response) => {
  const items = await db.select().from(catalogItemsTable).orderBy(catalogItemsTable.name);
  const brands = await db.select().from(brandsTable).orderBy(brandsTable.name);

  res.json(items.map(item => ({
    ...item,
    brands: brands.filter(b => b.catalogItemId === item.id),
  })));
});

const createItemSchema = z.object({
  name: z.string(),
  icon: z.string().optional().nullable(),
});

router.post("/items", async (req: Request, res: Response) => {
  try {
    const body = createItemSchema.parse(req.body);
    const [created] = await db.insert(catalogItemsTable).values({
      name: body.name,
      icon: body.icon ?? null,
      color: null,
      isDefault: false,
    }).returning();
    res.json({ ...created, brands: [] });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.delete("/items/:id", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id as string);
  await db.delete(brandsTable).where(eq(brandsTable.catalogItemId, id));
  await db.delete(catalogItemsTable).where(eq(catalogItemsTable.id, id));
  res.json({ success: true, message: "Item type removed" });
});

const addBrandSchema = z.object({
  catalogItemId: z.number().int(),
  name: z.string(),
});

router.post("/brands", async (req: Request, res: Response) => {
  try {
    const body = addBrandSchema.parse(req.body);
    const [created] = await db.insert(brandsTable).values({
      catalogItemId: body.catalogItemId,
      name: body.name,
      isDefault: false,
    }).returning();
    res.json({ success: true, message: "Brand added", data: created });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.delete("/brands/:id", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id as string);
  await db.delete(brandsTable).where(eq(brandsTable.id, id));
  res.json({ success: true, message: "Brand removed" });
});

export default router;
