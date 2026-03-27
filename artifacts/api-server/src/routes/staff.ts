import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { promoStaffTable, eventsTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";
import { z } from "zod";
import { hashPassword } from "../lib/auth.js";

const router: IRouter = Router();

router.get("/", async (_req: Request, res: Response) => {
  const rows = await db.select().from(promoStaffTable).orderBy(promoStaffTable.name);
  res.json(rows);
});

const createSchema = z.object({
  name: z.string(),
  phone: z.string().nullable().optional(),
  email: z.string().nullable().optional(),
  notes: z.string().nullable().optional(),
});

router.post("/", async (req: Request, res: Response) => {
  try {
    const body = createSchema.parse(req.body);
    const firstName = body.name.trim().split(/\s+/)[0];
    const plainPassword = `${firstName}2026`;
    const passwordHash = hashPassword(plainPassword);
    const [created] = await db.insert(promoStaffTable).values({
      name: body.name,
      passwordHash,
      phone: body.phone ?? null,
      email: body.email ?? null,
      notes: body.notes ?? null,
    }).returning();
    res.json({ ...created, generatedPassword: plainPassword });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.put("/:id", async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id as string);
    const body = createSchema.parse(req.body);

    // If name changed, update event assignments
    const existing = await db.select().from(promoStaffTable).where(eq(promoStaffTable.id, id));
    if (existing[0] && existing[0].name !== body.name) {
      const events = await db.select().from(eventsTable);
      for (const evt of events) {
        const staff: string[] = JSON.parse(evt.staffAssigned || "[]");
        if (staff.includes(existing[0].name)) {
          const newStaff = staff.map(s => s === existing[0].name ? body.name : s);
          await db.update(eventsTable)
            .set({ staffAssigned: JSON.stringify(newStaff) })
            .where(eq(eventsTable.id, evt.id));
        }
      }
    }

    const [updated] = await db.update(promoStaffTable)
      .set({ name: body.name, phone: body.phone ?? null, email: body.email ?? null, notes: body.notes ?? null })
      .where(eq(promoStaffTable.id, id))
      .returning();
    res.json(updated);
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.delete("/:id", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id as string);
  const existing = await db.select().from(promoStaffTable).where(eq(promoStaffTable.id, id));
  if (existing[0]) {
    // Remove from events
    const events = await db.select().from(eventsTable);
    for (const evt of events) {
      const staff: string[] = JSON.parse(evt.staffAssigned || "[]");
      if (staff.includes(existing[0].name)) {
        const newStaff = staff.filter(s => s !== existing[0].name);
        await db.update(eventsTable)
          .set({ staffAssigned: JSON.stringify(newStaff) })
          .where(eq(eventsTable.id, evt.id));
      }
    }
  }
  await db.delete(promoStaffTable).where(eq(promoStaffTable.id, id));
  res.json({ success: true, message: "Staff removed" });
});

export default router;
