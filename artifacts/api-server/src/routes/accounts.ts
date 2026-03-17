import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { accountAssetsTable } from "@workspace/db/schema";
import { eq, and } from "drizzle-orm";

const router: IRouter = Router();

router.get("/", async (req: Request, res: Response) => {
  const repUsername = req.query.repUsername as string;
  if (!repUsername) {
    res.status(400).json({ error: "repUsername required" });
    return;
  }

  const rows = await db
    .select()
    .from(accountAssetsTable)
    .where(and(eq(accountAssetsTable.repUsername, repUsername)));

  res.json(rows.filter(r => r.count > 0).map(r => ({
    account: r.account,
    itemType: r.itemType,
    brand: r.brand,
    count: r.count,
    lastDate: r.lastDate ?? null,
  })));
});

export default router;
