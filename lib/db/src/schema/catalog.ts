import { pgTable, serial, text, boolean, integer } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const catalogItemsTable = pgTable("catalog_items", {
  id: serial("id").primaryKey(),
  name: text("name").notNull().unique(),
  icon: text("icon"),
  color: text("color"),
  isDefault: boolean("is_default").default(false).notNull(),
});

export const brandsTable = pgTable("brands", {
  id: serial("id").primaryKey(),
  catalogItemId: integer("catalog_item_id").notNull().references(() => catalogItemsTable.id),
  name: text("name").notNull(),
  isDefault: boolean("is_default").default(false).notNull(),
});

export const insertCatalogItemSchema = createInsertSchema(catalogItemsTable).omit({ id: true });
export type InsertCatalogItem = z.infer<typeof insertCatalogItemSchema>;
export type CatalogItem = typeof catalogItemsTable.$inferSelect;

export const insertBrandSchema = createInsertSchema(brandsTable).omit({ id: true });
export type InsertBrand = z.infer<typeof insertBrandSchema>;
export type Brand = typeof brandsTable.$inferSelect;
