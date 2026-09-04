import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { promoStaffTable, eventsTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";
import { z } from "zod";
import { randomBytes } from "crypto";
import { hashPassword } from "../lib/auth.js";
import { requireRole } from "../middlewares/auth.js";

const router: IRouter = Router();

function publicStaff<T extends { passwordHash?: string | null }>(row: T) {
  const { passwordHash: _omit, ...rest } = row;
  return rest;
}

router.get(
  "/",
  requireRole("marketing", "warehouse"),
  async (_req: Request, res: Response) => {
    try {
      const rows = await db
        .select({
          id: promoStaffTable.id,
          name: promoStaffTable.name,
          phone: promoStaffTable.phone,
          email: promoStaffTable.email,
          notes: promoStaffTable.notes,
        })
        .from(promoStaffTable)
        .orderBy(promoStaffTable.name);
      res.json(rows);
    } catch (err) {
      console.error("[staff GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const createSchema = z.object({
  name: z.string().min(1),
  /** Optional; if omitted a one-time random password is generated and returned once. */
  password: z.string().min(8).optional(),
  phone: z.string().nullable().optional(),
  email: z.string().nullable().optional(),
  notes: z.string().nullable().optional(),
});

router.post(
  "/",
  requireRole("marketing"),
  async (req: Request, res: Response) => {
    try {
      const body = createSchema.parse(req.body);
      // One-time random password (not a predictable name+year pattern)
      const plainPassword =
        body.password ?? randomBytes(12).toString("base64url");
      const passwordHash = await hashPassword(plainPassword);
      const [created] = await db
        .insert(promoStaffTable)
        .values({
          name: body.name,
          passwordHash,
          phone: body.phone ?? null,
          email: body.email ?? null,
          notes: body.notes ?? null,
        })
        .returning();
      // Return password once for admin to share; never persist plaintext or hash in response
      res.json({ ...publicStaff(created), generatedPassword: plainPassword });
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[staff POST]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const updateSchema = z.object({
  name: z.string().min(1),
  phone: z.string().nullable().optional(),
  email: z.string().nullable().optional(),
  notes: z.string().nullable().optional(),
  password: z.string().min(8).optional(),
});

router.put(
  "/:id",
  requireRole("marketing"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const body = updateSchema.parse(req.body);

      const existing = await db
        .select()
        .from(promoStaffTable)
        .where(eq(promoStaffTable.id, id));
      if (existing[0] && existing[0].name !== body.name) {
        const events = await db.select().from(eventsTable);
        for (const evt of events) {
          const staff: string[] = JSON.parse(evt.staffAssigned || "[]");
          if (staff.includes(existing[0].name)) {
            const newStaff = staff.map((s) =>
              s === existing[0].name ? body.name : s,
            );
            await db
              .update(eventsTable)
              .set({ staffAssigned: JSON.stringify(newStaff) })
              .where(eq(eventsTable.id, evt.id));
          }
        }
      }

      const patch: Record<string, unknown> = {
        name: body.name,
        phone: body.phone ?? null,
        email: body.email ?? null,
        notes: body.notes ?? null,
      };
      if (body.password) {
        patch.passwordHash = await hashPassword(body.password);
      }

      const [updated] = await db
        .update(promoStaffTable)
        .set(patch)
        .where(eq(promoStaffTable.id, id))
        .returning();
      res.json(publicStaff(updated));
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[staff PUT]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.delete(
  "/:id",
  requireRole("marketing"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const existing = await db
        .select()
        .from(promoStaffTable)
        .where(eq(promoStaffTable.id, id));
      if (existing[0]) {
        const events = await db.select().from(eventsTable);
        for (const evt of events) {
          const staff: string[] = JSON.parse(evt.staffAssigned || "[]");
          if (staff.includes(existing[0].name)) {
            const newStaff = staff.filter((s) => s !== existing[0].name);
            await db
              .update(eventsTable)
              .set({ staffAssigned: JSON.stringify(newStaff) })
              .where(eq(eventsTable.id, evt.id));
          }
        }
      }
      await db.delete(promoStaffTable).where(eq(promoStaffTable.id, id));
      res.json({ success: true, message: "Staff removed" });
    } catch (err) {
      console.error("[staff DELETE]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
