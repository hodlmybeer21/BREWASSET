import type { Request, Response, NextFunction } from "express";
import { db } from "@workspace/db";
import { usersTable, promoStaffTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";

export type AppRole = "rep" | "warehouse" | "marketing" | "staff";

export type AuthedUser = {
  id: number;
  username: string;
  role: AppRole;
  displayName: string;
};

declare module "express-session" {
  interface SessionData {
    userId?: number;
    staffId?: number;
  }
}

declare global {
  namespace Express {
    interface Request {
      user?: AuthedUser;
    }
  }
}

/** Load session user/staff onto req.user; 401 if missing. */
export async function requireAuth(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  try {
    if (req.session.staffId) {
      const rows = await db
        .select()
        .from(promoStaffTable)
        .where(eq(promoStaffTable.id, req.session.staffId));
      const staff = rows[0];
      if (!staff) {
        res.status(401).json({ error: "Not authenticated" });
        return;
      }
      req.user = {
        id: staff.id,
        username: staff.name,
        role: "staff",
        displayName: staff.name,
      };
      next();
      return;
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
      res.status(401).json({ error: "Not authenticated" });
      return;
    }

    req.user = {
      id: user.id,
      username: user.username,
      role: user.role as AppRole,
      displayName: user.displayName,
    };
    next();
  } catch (err) {
    console.error("[requireAuth]", err);
    res.status(500).json({ error: "Authentication check failed" });
  }
}

/** Require one of the given roles (must run after requireAuth). */
export function requireRole(...roles: AppRole[]) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.user) {
      res.status(401).json({ error: "Not authenticated" });
      return;
    }
    if (!roles.includes(req.user.role)) {
      res.status(403).json({ error: "Forbidden" });
      return;
    }
    next();
  };
}

/**
 * For reps, force ownership by session username.
 * Warehouse/marketing may pass any repUsername; staff cannot impersonate.
 */
export function resolveRepUsername(
  req: Request,
  queryOrBodyUsername?: string | null,
): string | undefined {
  const user = req.user;
  if (!user) return undefined;
  if (user.role === "rep") return user.username;
  if (user.role === "staff") return undefined;
  return queryOrBodyUsername || undefined;
}
