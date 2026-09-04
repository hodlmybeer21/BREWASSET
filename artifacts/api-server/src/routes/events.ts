import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { eventsTable, eventReportsTable } from "@workspace/db/schema";
import { eq, desc } from "drizzle-orm";
import { z } from "zod";
import { requireRole, resolveRepUsername } from "../middlewares/auth.js";

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

router.get(
  "/",
  requireRole("rep", "warehouse", "marketing", "staff"),
  async (req: Request, res: Response) => {
    try {
      const rows = await db
        .select()
        .from(eventsTable)
        .orderBy(desc(eventsTable.createdAt));
      let filtered = rows;
      const user = req.user!;

      if (user.role === "rep") {
        filtered = rows.filter((r) => r.repUsername === user.username);
      } else if (user.role === "staff") {
        filtered = rows.filter((r) => {
          const assigned: string[] = JSON.parse(r.staffAssigned || "[]");
          return assigned.includes(user.username);
        });
      } else {
        const repUsername = resolveRepUsername(
          req,
          req.query.repUsername as string | undefined,
        );
        const staffNameParam = req.query.staffName as string | undefined;
        if (repUsername) {
          filtered = rows.filter((r) => r.repUsername === repUsername);
        } else if (staffNameParam) {
          filtered = rows.filter((r) => {
            const assigned: string[] = JSON.parse(r.staffAssigned || "[]");
            return assigned.includes(staffNameParam);
          });
        }
      }
      res.json(filtered.map(parseEvent));
    } catch (err) {
      console.error("[events GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const createEventSchema = z.object({
  title: z.string(),
  account: z.string(),
  brand: z.string().optional().nullable(),
  date: z.string(),
  startTime: z.string(),
  endTime: z.string(),
  notes: z.string().optional().nullable(),
  posItems: z.array(z.string()),
  staffRequested: z.number().int().min(0),
  repOrSupplierPresent: z.boolean().optional().default(false),
});

router.post("/", requireRole("rep"), async (req: Request, res: Response) => {
  try {
    const body = createEventSchema.parse(req.body);
    const user = req.user!;

    const [created] = await db
      .insert(eventsTable)
      .values({
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
        repOrSupplierPresent: body.repOrSupplierPresent ?? false,
      })
      .returning();

    res.json(parseEvent(created));
  } catch (err) {
    if (err instanceof z.ZodError) {
      res.status(400).json({ error: "Invalid request", details: err.flatten() });
      return;
    }
    console.error("[events POST]", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

router.post(
  "/:id/approve",
  requireRole("marketing"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      await db
        .update(eventsTable)
        .set({
          status: "approved",
          approvedAt: new Date(),
          approvedBy: req.user!.displayName,
        })
        .where(eq(eventsTable.id, id));
      res.json({ success: true, message: "Event approved" });
    } catch (err) {
      console.error("[events approve]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.post(
  "/:id/cancel",
  requireRole("marketing", "rep"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const user = req.user!;
      if (user.role === "rep") {
        const events = await db
          .select()
          .from(eventsTable)
          .where(eq(eventsTable.id, id));
        if (!events[0] || events[0].repUsername !== user.username) {
          res.status(403).json({ error: "Forbidden" });
          return;
        }
      }
      await db
        .update(eventsTable)
        .set({ status: "cancelled" })
        .where(eq(eventsTable.id, id));
      res.json({ success: true, message: "Event cancelled" });
    } catch (err) {
      console.error("[events cancel]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const toggleStaffSchema = z.object({ staffName: z.string() });

router.post(
  "/:id/staff",
  requireRole("marketing"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const body = toggleStaffSchema.parse(req.body);

      const events = await db
        .select()
        .from(eventsTable)
        .where(eq(eventsTable.id, id));
      const evt = events[0];
      if (!evt) {
        res.status(404).json({ error: "Event not found" });
        return;
      }

      const staff: string[] = JSON.parse(evt.staffAssigned || "[]");
      const newStaff = staff.includes(body.staffName)
        ? staff.filter((s) => s !== body.staffName)
        : [...staff, body.staffName];

      await db
        .update(eventsTable)
        .set({ staffAssigned: JSON.stringify(newStaff) })
        .where(eq(eventsTable.id, id));

      res.json({ success: true, message: "Staff updated" });
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[events staff]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.post(
  "/:id/approve-pos",
  requireRole("marketing"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      await db
        .update(eventsTable)
        .set({ posApproved: true })
        .where(eq(eventsTable.id, id));
      res.json({ success: true, message: "POS approved" });
    } catch (err) {
      console.error("[events approve-pos]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.get(
  "/reports",
  requireRole("marketing"),
  async (_req: Request, res: Response) => {
    try {
      const reports = await db
        .select()
        .from(eventReportsTable)
        .orderBy(desc(eventReportsTable.submittedAt));
      const events = await db.select().from(eventsTable);
      const eventsById = Object.fromEntries(events.map((e) => [e.id, e]));
      res.json(
        reports.map((r) => ({
          ...r,
          imageUrls: JSON.parse(r.imageUrls || "[]"),
          event: eventsById[r.eventId] ? parseEvent(eventsById[r.eventId]) : null,
        })),
      );
    } catch (err) {
      console.error("[events reports]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const reportSchema = z.object({
  staffName: z.string().optional(),
  attendeeCount: z.number().int().nullable().optional(),
  servedCount: z.number().int().nullable().optional(),
  brandComments: z.string().nullable().optional(),
  totalSpend: z.string().nullable().optional(),
  imageUrls: z.array(z.string()).optional(),
});

router.get(
  "/:id/report",
  requireRole("marketing", "staff"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const user = req.user!;
      const staffName =
        user.role === "staff"
          ? user.username
          : (req.query.staffName as string | undefined);
      const reports = await db
        .select()
        .from(eventReportsTable)
        .where(eq(eventReportsTable.eventId, id));
      const report = staffName
        ? reports.find((r) => r.staffName === staffName)
        : reports[0];
      if (!report) {
        res.status(404).json({ error: "No report found" });
        return;
      }
      res.json({ ...report, imageUrls: JSON.parse(report.imageUrls || "[]") });
    } catch (err) {
      console.error("[events GET report]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.post(
  "/:id/report",
  requireRole("staff", "marketing"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const body = reportSchema.parse(req.body);
      const user = req.user!;
      const staffName =
        user.role === "staff" ? user.username : body.staffName || user.username;

      const existing = await db
        .select()
        .from(eventReportsTable)
        .where(eq(eventReportsTable.eventId, id));
      const existingForStaff = existing.find((r) => r.staffName === staffName);

      const values = {
        eventId: id,
        staffName,
        attendeeCount: body.attendeeCount ?? null,
        servedCount: body.servedCount ?? null,
        brandComments: body.brandComments ?? null,
        totalSpend: body.totalSpend ?? null,
        imageUrls: JSON.stringify(body.imageUrls || []),
        updatedAt: new Date(),
      };

      if (existingForStaff) {
        const [updated] = await db
          .update(eventReportsTable)
          .set(values)
          .where(eq(eventReportsTable.id, existingForStaff.id))
          .returning();
        res.json({
          ...updated,
          imageUrls: JSON.parse(updated.imageUrls || "[]"),
        });
      } else {
        const [created] = await db
          .insert(eventReportsTable)
          .values(values)
          .returning();
        res.json({
          ...created,
          imageUrls: JSON.parse(created.imageUrls || "[]"),
        });
      }
    } catch (err) {
      if (err instanceof z.ZodError) {
        res.status(400).json({ error: "Invalid request", details: err.flatten() });
        return;
      }
      console.error("[events POST report]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
