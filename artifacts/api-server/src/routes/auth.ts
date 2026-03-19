import { Router, type IRouter, type Request, type Response, type NextFunction } from "express";
import { db } from "@workspace/db";
import { usersTable, promoStaffTable } from "@workspace/db/schema";

import { eq } from "drizzle-orm";
import { hashPassword, verifyPassword } from "../lib/auth.js";
import { z } from "zod";


const router: IRouter = Router();

declare module "express-session" {
  interface SessionData {
    userId?: number;
    staffId?: number;
  }
}

const loginSchema = z.object({
  username: z.string().min(1),
  password: z.string().min(1),
});

router.post("/login", async (req: Request, res: Response) => {
  try {
    const body = loginSchema.parse(req.body);
    const users = await db.select().from(usersTable).where(eq(usersTable.username, body.username));
    const user = users[0];
    if (!user || !verifyPassword(body.password, user.passwordHash)) {
      res.status(401).json({ error: "Invalid username or password" });
      return;
    }
    req.session.userId = user.id;
    res.json({ user: { id: user.id, username: user.username, role: user.role, displayName: user.displayName } });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

const staffLoginSchema = z.object({
  staffName: z.string().min(1),
  password: z.string().min(1),
});

router.post("/staff-login", async (req: Request, res: Response) => {
  try {
    const body = staffLoginSchema.parse(req.body);
    const rows = await db.select().from(promoStaffTable).where(eq(promoStaffTable.name, body.staffName));
    const staff = rows[0];
    if (!staff) {
      res.status(401).json({ error: "Invalid name or password" });
      return;
    }
    if (!staff.passwordHash || !verifyPassword(body.password, staff.passwordHash)) {
      res.status(401).json({ error: "Invalid name or password" });
      return;
    }
    req.session.staffId = staff.id;
    req.session.userId = undefined;
    res.json({ id: staff.id, username: staff.name, role: "staff", displayName: staff.name });
  } catch (err) {
    res.status(400).json({ error: "Invalid request" });
  }
});

router.post("/logout", (req: Request, res: Response) => {
  req.session.destroy(() => {
    res.json({ success: true, message: "Logged out" });
  });
});

router.get("/me", async (req: Request, res: Response) => {
  if (req.session.staffId) {
    const rows = await db.select().from(promoStaffTable).where(eq(promoStaffTable.id, req.session.staffId));
    const staff = rows[0];
    if (staff) {
      res.json({ id: staff.id, username: staff.name, role: "staff", displayName: staff.name });
      return;
    }
  }
  if (!req.session.userId) {
    res.status(401).json({ error: "Not authenticated" });
    return;
  }
  const users = await db.select().from(usersTable).where(eq(usersTable.id, req.session.userId));
  const user = users[0];
  if (!user) {
    res.status(401).json({ error: "User not found" });
    return;
  }
  res.json({ id: user.id, username: user.username, role: user.role, displayName: user.displayName });
});

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  if (!req.session.userId && !req.session.staffId) {
    res.status(401).json({ error: "Not authenticated" });
    return;
  }
  next();
}

export default router;
