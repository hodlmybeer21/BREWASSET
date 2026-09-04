import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { usersTable, promoStaffTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";
import {
  hashPassword,
  verifyPassword,
  needsRehash,
} from "../lib/auth.js";
import { z } from "zod";

const router: IRouter = Router();

const loginSchema = z.object({
  username: z.string().min(1),
  password: z.string().min(1),
});

function zodOrServerError(err: unknown, res: Response) {
  if (err instanceof z.ZodError) {
    res.status(400).json({ error: "Invalid request", details: err.flatten() });
    return;
  }
  console.error("[auth]", err);
  res.status(500).json({ error: "Internal server error" });
}

router.post("/login", async (req: Request, res: Response) => {
  try {
    const body = loginSchema.parse(req.body);
    const users = await db
      .select()
      .from(usersTable)
      .where(eq(usersTable.username, body.username));
    const user = users[0];
    if (!user || !(await verifyPassword(body.password, user.passwordHash))) {
      res.status(401).json({ error: "Invalid username or password" });
      return;
    }

    // Upgrade legacy SHA-256 hashes to bcrypt on successful login
    if (needsRehash(user.passwordHash)) {
      const upgraded = await hashPassword(body.password);
      await db
        .update(usersTable)
        .set({ passwordHash: upgraded })
        .where(eq(usersTable.id, user.id));
    }

    req.session.userId = user.id;
    req.session.staffId = undefined;
    res.json({
      user: {
        id: user.id,
        username: user.username,
        role: user.role,
        displayName: user.displayName,
      },
    });
  } catch (err) {
    zodOrServerError(err, res);
  }
});

const staffLoginSchema = z.object({
  staffName: z.string().min(1),
  password: z.string().min(1),
});

router.post("/staff-login", async (req: Request, res: Response) => {
  try {
    const body = staffLoginSchema.parse(req.body);
    const rows = await db
      .select()
      .from(promoStaffTable)
      .where(eq(promoStaffTable.name, body.staffName));
    const staff = rows[0];
    if (
      !staff ||
      !staff.passwordHash ||
      !(await verifyPassword(body.password, staff.passwordHash))
    ) {
      res.status(401).json({ error: "Invalid name or password" });
      return;
    }

    if (needsRehash(staff.passwordHash)) {
      const upgraded = await hashPassword(body.password);
      await db
        .update(promoStaffTable)
        .set({ passwordHash: upgraded })
        .where(eq(promoStaffTable.id, staff.id));
    }

    req.session.staffId = staff.id;
    req.session.userId = undefined;
    res.json({
      id: staff.id,
      username: staff.name,
      role: "staff",
      displayName: staff.name,
    });
  } catch (err) {
    zodOrServerError(err, res);
  }
});

router.post("/logout", (req: Request, res: Response) => {
  req.session.destroy(() => {
    res.json({ success: true, message: "Logged out" });
  });
});

router.get("/me", async (req: Request, res: Response) => {
  try {
    if (req.session.staffId) {
      const rows = await db
        .select()
        .from(promoStaffTable)
        .where(eq(promoStaffTable.id, req.session.staffId));
      const staff = rows[0];
      if (staff) {
        res.json({
          id: staff.id,
          username: staff.name,
          role: "staff",
          displayName: staff.name,
        });
        return;
      }
    }
    if (!req.session.userId) {
      res.status(401).json({ error: "Not authenticated" });
      return;
    }
    const users = await db
      .select()
      .from(usersTable)
      .where(eq(usersTable.id, req.session.userId));
    const user = users[0];
    if (!user) {
      res.status(401).json({ error: "User not found" });
      return;
    }
    res.json({
      id: user.id,
      username: user.username,
      role: user.role,
      displayName: user.displayName,
    });
  } catch (err) {
    console.error("[auth/me]", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

export default router;
