import { pgTable, serial, text } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod/v4";

export const promoStaffTable = pgTable("promo_staff", {
  id: serial("id").primaryKey(),
  name: text("name").notNull().unique(),
  passwordHash: text("password_hash"),
  phone: text("phone"),
  email: text("email"),
  notes: text("notes"),
});

export const insertPromoStaffSchema = createInsertSchema(promoStaffTable).omit({ id: true });
export type InsertPromoStaff = z.infer<typeof insertPromoStaffSchema>;
export type PromoStaff = typeof promoStaffTable.$inferSelect;
