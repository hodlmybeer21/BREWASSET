import { pgTable, serial, text, integer, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const posRequestsTable = pgTable("pos_requests", {
  id: serial("id").primaryKey(),
  repUsername: text("rep_username").notNull(),
  customer: text("customer").notNull(),
  itemType: text("item_type").notNull(),
  brand: text("brand").notNull(),
  quantity: integer("quantity").notNull(),
  status: text("status").default("Pending").notNull(), // Pending | Fulfilled | Cancelled
  createdAt: timestamp("created_at").defaultNow().notNull(),
  fulfilledAt: timestamp("fulfilled_at"),
});

export const insertPosRequestSchema = createInsertSchema(posRequestsTable).omit({ id: true, createdAt: true, fulfilledAt: true });
export type InsertPosRequest = z.infer<typeof insertPosRequestSchema>;
export type PosRequest = typeof posRequestsTable.$inferSelect;
