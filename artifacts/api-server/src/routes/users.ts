import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { usersTable } from "@workspace/db/schema";
import { requireRole } from "../middlewares/auth.js";

const router: IRouter = Router();

router.get(
  "/",
  requireRole("warehouse", "marketing", "rep"),
  async (_req: Request, res: Response) => {
    try {
      const rows = await db
        .select({
          id: usersTable.id,
          username: usersTable.username,
          role: usersTable.role,
          displayName: usersTable.displayName,
        })
        .from(usersTable)
        .orderBy(usersTable.username);
      res.json(rows);
    } catch (err) {
      console.error("[users GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
