import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { eventsTable, usersTable, eventReportsTable } from "@workspace/db/schema";
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
  let filtered = rows;
  if (req.query.repUsername) {
    filtered = rows.filter(r => r.repUsername === req.query.repUsername);
  } else if (req.query.staffName) {
    const name = req.query.staffName as string;
    filtered = rows.filter(r => {
      const assigned: string[] = JSON.parse(r.staffAssigned || "[]");
      return assigned.includes(name);
    });
  }
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

router.get("/reports", async (req: Request, res: Response) => {
  const reports = await db.select().from(eventReportsTable).orderBy(desc(eventReportsTable.submittedAt));
  const events = await db.select().from(eventsTable);
  const eventsById = Object.fromEntries(events.map(e => [e.id, e]));
  res.json(reports.map(r => ({
    ...r,
    imageUrls: JSON.parse(r.imageUrls || "[]"),
    event: eventsById[r.eventId] ? parseEvent(eventsById[r.eventId]) : null,
  })));
});

const reportSchema = z.object({
  staffName: z.string(),
  attendeeCount: z.number().int().nullable().optional(),
  servedCount: z.number().int().nullable().optional(),
  brandComments: z.string().nullable().optional(),
  totalSpend: z.string().nullable().optional(),
  imageUrls: z.array(z.string()).optional(),
});

router.get("/:id/report", async (req: Request, res: Response) => {
  const id = parseInt(req.params.id);
  const staffName = req.query.staffName as string | undefined;
  let query = db.select().from(eventReportsTable).where(eq(eventReportsTable.eventId, id));
  const reports = await query;
  const report = staffName ? reports.find(r => r.staffName === staffName) : reports[0];
  if (!report) { res.status(404).json({ error: "No report found" }); return; }
  res.json({ ...report, imageUrls: JSON.parse(report.imageUrls || "[]") });
});

router.post("/:id/report", async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id);
    const body = reportSchema.parse(req.body);

    const existing = await db.select().from(eventReportsTable)
      .where(eq(eventReportsTable.eventId, id));
    const existingForStaff = existing.find(r => r.staffName === body.staffName);

    const values = {
      eventId: id,
      staffName: body.staffName,
      attendeeCount: body.attendeeCount ?? null,
      servedCount: body.servedCount ?? null,
      brandComments: body.brandComments ?? null,
      totalSpend: body.totalSpend ?? null,
      imageUrls: JSON.stringify(body.imageUrls || []),
      updatedAt: new Date(),
    };

    if (existingForStaff) {
      const [updated] = await db.update(eventReportsTable)
        .set(values)
        .where(eq(eventReportsTable.id, existingForStaff.id))
        .returning();
      res.json({ ...updated, imageUrls: JSON.parse(updated.imageUrls || "[]") });
    } else {
      const [created] = await db.insert(eventReportsTable).values(values).returning();
      res.json({ ...created, imageUrls: JSON.parse(created.imageUrls || "[]") });
    }
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

export default router;
