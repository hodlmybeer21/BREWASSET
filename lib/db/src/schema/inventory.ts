import { pgTable, serial, text, integer, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const inventoryTable = pgTable("inventory", {
  id: serial("id").primaryKey(),
  catalogItemId: integer("catalog_item_id").notNull(),
  brandId: integer("brand_id").notNull(),
  itemType: text("item_type").notNull(),
  brand: text("brand").notNull(),
  quantity: integer("quantity").default(0).notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const receiveHistoryTable = pgTable("receive_history", {
  id: serial("id").primaryKey(),
  itemType: text("item_type").notNull(),
  brand: text("brand").notNull(),
  quantity: integer("quantity").notNull(),
  note: text("note"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const insertInventorySchema = createInsertSchema(inventoryTable).omit({ id: true, updatedAt: true });
export type InsertInventory = z.infer<typeof insertInventorySchema>;
export type Inventory = typeof inventoryTable.$inferSelect;

export const insertReceiveHistorySchema = createInsertSchema(receiveHistoryTable).omit({ id: true, createdAt: true });
export type InsertReceiveHistory = z.infer<typeof insertReceiveHistorySchema>;
export type ReceiveHistory = typeof receiveHistoryTable.$inferSelect;
