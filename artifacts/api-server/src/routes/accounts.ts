import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import { accountAssetsTable } from "@workspace/db/schema";
import { eq, and } from "drizzle-orm";
import { requireRole, resolveRepUsername } from "../middlewares/auth.js";

const router: IRouter = Router();

router.get(
  "/",
  requireRole("rep", "warehouse", "marketing"),
  async (req: Request, res: Response) => {
    try {
      const ownedRep = resolveRepUsername(
        req,
        req.query.repUsername as string | undefined,
      );
      if (!ownedRep) {
        res.status(400).json({ error: "repUsername required" });
        return;
      }

      const rows = await db
        .select()
        .from(accountAssetsTable)
        .where(and(eq(accountAssetsTable.repUsername, ownedRep)));

      res.json(
        rows
          .filter((r) => r.count > 0)
          .map((r) => ({
            account: r.account,
            itemType: r.itemType,
            brand: r.brand,
            count: r.count,
            lastDate: r.lastDate ?? null,
          })),
      );
    } catch (err) {
      console.error("[accounts GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
