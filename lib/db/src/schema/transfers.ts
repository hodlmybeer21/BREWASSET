import { pgTable, serial, text, integer, boolean, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const transfersTable = pgTable("transfers", {
  id: serial("id").primaryKey(),
  repUsername: text("rep_username").notNull(),
  itemType: text("item_type").notNull(),
  brand: text("brand").notNull(),
  quantity: integer("quantity").notNull(),
  fromAccount: text("from_account").notNull(),
  toAccount: text("to_account").notNull(),
  isReturn: boolean("is_return").default(false).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const insertTransferSchema = createInsertSchema(transfersTable).omit({ id: true, createdAt: true });
export type InsertTransfer = z.infer<typeof insertTransferSchema>;
export type Transfer = typeof transfersTable.$inferSelect;
