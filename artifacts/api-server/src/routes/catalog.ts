import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { catalogItemsTable, brandsTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";
import { z } from "zod";
import { requireRole } from "../middlewares/auth.js";

const router: IRouter = Router();

router.get(
  "/items",
  requireRole("warehouse", "marketing", "rep"),
  async (_req: Request, res: Response) => {
    try {
      const items = await db
        .select()
        .from(catalogItemsTable)
        .orderBy(catalogItemsTable.name);
      const brands = await db.select().from(brandsTable).orderBy(brandsTable.name);

      res.json(
        items.map((item) => ({
          ...item,
          brands: brands.filter((b) => b.catalogItemId === item.id),
        })),
      );
    } catch (err) {
      console.error("[catalog GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const createItemSchema = z.object({
  name: z.string(),
  icon: z.string().optional().nullable(),
});

router.post(
  "/items",
  requireRole("warehouse"),
  async (req: Request, res: Response) => {
    try {
      const body = createItemSchema.parse(req.body);
      const [created] = await db
        .insert(catalogItemsTable)
        .values({
          name: body.name,
          icon: body.icon ?? null,
          color: null,
          isDefault: false,
        })
        .returning();
      res.json({ ...created, brands: [] });
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[catalog POST items]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.delete(
  "/items/:id",
  requireRole("warehouse"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      await db.delete(brandsTable).where(eq(brandsTable.catalogItemId, id));
      await db.delete(catalogItemsTable).where(eq(catalogItemsTable.id, id));
      res.json({ success: true, message: "Item type removed" });
    } catch (err) {
      console.error("[catalog DELETE items]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const addBrandSchema = z.object({
  catalogItemId: z.number().int(),
  name: z.string(),
});

router.post(
  "/brands",
  requireRole("warehouse"),
  async (req: Request, res: Response) => {
    try {
      const body = addBrandSchema.parse(req.body);
      const [created] = await db
        .insert(brandsTable)
        .values({
          catalogItemId: body.catalogItemId,
          name: body.name,
          isDefault: false,
        })
        .returning();
      res.json({ success: true, message: "Brand added", data: created });
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[catalog POST brands]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.delete(
  "/brands/:id",
  requireRole("warehouse"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      await db.delete(brandsTable).where(eq(brandsTable.id, id));
      res.json({ success: true, message: "Brand removed" });
    } catch (err) {
      console.error("[catalog DELETE brands]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
