import { pgTable, serial, text, integer, boolean, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const eventsTable = pgTable("events", {
  id: serial("id").primaryKey(),
  title: text("title").notNull(),
  account: text("account").notNull(),
  brand: text("brand"),
  date: text("date").notNull(),
  startTime: text("start_time").notNull(),
  endTime: text("end_time").notNull(),
  notes: text("notes"),
  posItems: text("pos_items").default("[]").notNull(), // JSON array
  staffRequested: integer("staff_requested").default(1).notNull(),
  repUsername: text("rep_username").notNull(),
  status: text("status").default("pending").notNull(), // pending | approved | cancelled
  staffAssigned: text("staff_assigned").default("[]").notNull(), // JSON array of names
  posApproved: boolean("pos_approved").default(false).notNull(),
  posRequested: boolean("pos_requested").default(false).notNull(),
  repOrSupplierPresent: boolean("rep_or_supplier_present").default(false).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  approvedAt: timestamp("approved_at"),
  approvedBy: text("approved_by"),
});

export const insertEventSchema = createInsertSchema(eventsTable).omit({ id: true, createdAt: true, approvedAt: true });
export type InsertEvent = z.infer<typeof insertEventSchema>;
export type Event = typeof eventsTable.$inferSelect;
