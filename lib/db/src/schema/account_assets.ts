import { pgTable, serial, text, integer, timestamp } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const accountAssetsTable = pgTable("account_assets", {
  id: serial("id").primaryKey(),
  repUsername: text("rep_username").notNull(),
  account: text("account").notNull(),
  itemType: text("item_type").notNull(),
  brand: text("brand").notNull(),
  count: integer("count").default(0).notNull(),
  lastDate: text("last_date"),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const insertAccountAssetSchema = createInsertSchema(accountAssetsTable).omit({ id: true, updatedAt: true });
export type InsertAccountAsset = z.infer<typeof insertAccountAssetSchema>;
export type AccountAsset = typeof accountAssetsTable.$inferSelect;
