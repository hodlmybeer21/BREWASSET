import { pgTable, serial, text, integer, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const eventReportsTable = pgTable("event_reports", {
  id: serial("id").primaryKey(),
  eventId: integer("event_id").notNull(),
  staffName: text("staff_name").notNull(),
  attendeeCount: integer("attendee_count"),
  servedCount: integer("served_count"),
  brandComments: text("brand_comments"),
  totalSpend: text("total_spend"),
  imageUrls: text("image_urls").default("[]").notNull(),
  submittedAt: timestamp("submitted_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const insertEventReportSchema = createInsertSchema(eventReportsTable).omit({
  id: true, submittedAt: true, updatedAt: true,
});
export type InsertEventReport = z.infer<typeof insertEventReportSchema>;
export type EventReport = typeof eventReportsTable.$inferSelect;
