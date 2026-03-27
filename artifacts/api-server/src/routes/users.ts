import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { usersTable } from "@workspace/db/schema";

const router: IRouter = Router();

router.get("/", async (_req: Request, res: Response) => {
  const rows = await db.select({
    id: usersTable.id,
    username: usersTable.username,
    role: usersTable.role,
    displayName: usersTable.displayName,
  }).from(usersTable).orderBy(usersTable.username);
  res.json(rows);
});

export default router;
