import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { eventsTable, usersTable } from "@workspace/db/schema";
import { eq, desc } from "drizzle-orm";
import { z } from "zod";

const router: IRouter = Router();

function parseEvent(e: typeof eventsTable.$inferSelect) {
  return {
    ...e,
    posItems: JSON.parse(e.posItems || "[]"),
    staffAssigned: JSON.parse(e.staffAssigned || "[]"),
    createdAt: e.createdAt.toISOString(),
    approvedAt: e.approvedAt ? e.approvedAt.toISOString() : null,
  };
}

router.get("/", async (req: Request, res: Response) => {
  const rows = await db.select().from(eventsTable).orderBy(desc(eventsTable.createdAt));
  const filtered = req.query.repUsername
    ? rows.filter(r => r.repUsername === req.query.repUsername)
    : rows;
  res.json(filtered.map(parseEvent));
});

const createEventSchema = z.object({
  title: z.string(),
  account: z.string(),
  brand: z.string().optional().nullable(),
  date: z.string(),
  startTime: z.string(),
  endTime: z.string(),
  notes: z.string().optional().nullable(),
  posItems: z.array(z.string()),
  staffRequested: z.number().int().min(1),
});

router.post("/", async (req: Request, res: Response) => {
  try {
    const body = createEventSchema.parse(req.body);
    const userId = (req as any).session?.userId;
    const users = await db.select().from(usersTable).where(eq(usersTable.id, userId));
    const user = users[0];
    if (!user) { res.status(401).json({ error: "Not authenticated" }); return; }

    const [created] = await db.insert(eventsTable).values({
      title: body.title,
      account: body.account,
      brand: body.brand ?? null,
      date: body.date,
      startTime: body.startTime,
      endTime: body.endTime,
      notes: body.notes ?? null,
      posItems: JSON.stringify(body.posItems),
      staffRequested: body.staffRequested,
      repUsername: user.username,
      status: "pending",
      staffAssigned: "[]",
      posApproved: false,
      posRequested: body.posItems.length > 0,
    }).returning();

    res.json(parseEvent(created));
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.post("/:id/approve", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id);
  await db.update(eventsTable)
    .set({ status: "approved", approvedAt: new Date(), approvedBy: "Marketing Manager" })
    .where(eq(eventsTable.id, id));
  res.json({ success: true, message: "Event approved" });
});

router.post("/:id/cancel", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id);
  await db.update(eventsTable).set({ status: "cancelled" }).where(eq(eventsTable.id, id));
  res.json({ success: true, message: "Event cancelled" });
});

const toggleStaffSchema = z.object({ staffName: z.string() });

router.post("/:id/staff", async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id);
    const body = toggleStaffSchema.parse(req.body);

    const events = await db.select().from(eventsTable).where(eq(eventsTable.id, id));
    const evt = events[0];
    if (!evt) { res.status(404).json({ error: "Event not found" }); return; }

    const staff: string[] = JSON.parse(evt.staffAssigned || "[]");
    const newStaff = staff.includes(body.staffName)
      ? staff.filter(s => s !== body.staffName)
      : [...staff, body.staffName];

    await db.update(eventsTable)
      .set({ staffAssigned: JSON.stringify(newStaff) })
      .where(eq(eventsTable.id, id));

    res.json({ success: true, message: "Staff updated" });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.post("/:id/approve-pos", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id);
  await db.update(eventsTable).set({ posApproved: true }).where(eq(eventsTable.id, id));
  res.json({ success: true, message: "POS approved" });
});

export default router;
