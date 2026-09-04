import { Router, type IRouter, type Request, type Response } from "express";
import { db } from "@workspace/db";
import {
  posRequestsTable,
  inventoryTable,
  accountAssetsTable,
} from "@workspace/db/schema";
import { eq, and, desc } from "drizzle-orm";
import { z } from "zod";
import { requireRole, resolveRepUsername } from "../middlewares/auth.js";

const router: IRouter = Router();

router.get(
  "/",
  requireRole("rep", "warehouse", "marketing"),
  async (req: Request, res: Response) => {
    try {
      const rows = await db
        .select()
        .from(posRequestsTable)
        .orderBy(desc(posRequestsTable.createdAt));

      const ownedRep = resolveRepUsername(
        req,
        req.query.repUsername as string | undefined,
      );
      const filtered = ownedRep
        ? rows.filter((r) => r.repUsername === ownedRep)
        : rows;

      res.json(
        filtered.map((r) => ({
          ...r,
          createdAt: r.createdAt.toISOString(),
          fulfilledAt: r.fulfilledAt ? r.fulfilledAt.toISOString() : null,
        })),
      );
    } catch (err) {
      console.error("[requests GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

const createSchema = z.object({
  customer: z.string(),
  itemType: z.string(),
  brand: z.string(),
  quantity: z.number().int().positive(),
});

router.post("/", requireRole("rep"), async (req: Request, res: Response) => {
  try {
    const body = createSchema.parse(req.body);
    const user = req.user!;

    const created = await db.transaction(async (tx) => {
      const inv = await tx
        .select()
        .from(inventoryTable)
        .where(
          and(
            eq(inventoryTable.itemType, body.itemType),
            eq(inventoryTable.brand, body.brand),
          ),
        );

      const current = inv[0];
      if (!current || current.quantity < body.quantity) {
        throw Object.assign(new Error("Insufficient stock"), {
          status: 400,
          code: "INSUFFICIENT_STOCK",
        });
      }

      await tx
        .update(inventoryTable)
        .set({ quantity: current.quantity - body.quantity })
        .where(eq(inventoryTable.id, current.id));

      const [row] = await tx
        .insert(posRequestsTable)
        .values({
          repUsername: user.username,
          customer: body.customer,
          itemType: body.itemType,
          brand: body.brand,
          quantity: body.quantity,
          status: "Pending",
        })
        .returning();
      return row;
    });

    res.json({
      ...created,
      createdAt: created.createdAt.toISOString(),
      fulfilledAt: null,
    });
  } catch (err: any) {
    if (err instanceof z.ZodError) {
      res.status(400).json({ error: "Invalid request", details: err.flatten() });
      return;
    }
    if (err?.code === "INSUFFICIENT_STOCK") {
      res.status(400).json({ error: "Insufficient stock" });
      return;
    }
    console.error("[requests POST]", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

router.post(
  "/:id/fulfill",
  requireRole("warehouse"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const now = new Date();
      const dateStr =
        now.toLocaleDateString("en-US") +
        " " +
        now.toLocaleTimeString("en-US", {
          hour: "numeric",
          minute: "2-digit",
          hour12: true,
        });

      await db.transaction(async (tx) => {
        const reqs = await tx
          .select()
          .from(posRequestsTable)
          .where(eq(posRequestsTable.id, id));
        const request = reqs[0];
        if (!request) {
          throw Object.assign(new Error("Not found"), {
            status: 404,
            code: "NOT_FOUND",
          });
        }
        if (request.status !== "Pending") {
          throw Object.assign(new Error("Request is not pending"), {
            status: 400,
            code: "BAD_STATUS",
          });
        }

        await tx
          .update(posRequestsTable)
          .set({ status: "Fulfilled", fulfilledAt: now })
          .where(eq(posRequestsTable.id, id));

        const existing = await tx
          .select()
          .from(accountAssetsTable)
          .where(
            and(
              eq(accountAssetsTable.repUsername, request.repUsername),
              eq(accountAssetsTable.account, request.customer),
              eq(accountAssetsTable.itemType, request.itemType),
              eq(accountAssetsTable.brand, request.brand),
            ),
          );
        if (existing[0]) {
          await tx
            .update(accountAssetsTable)
            .set({
              count: existing[0].count + request.quantity,
              lastDate: dateStr,
              updatedAt: now,
            })
            .where(eq(accountAssetsTable.id, existing[0].id));
        } else {
          await tx.insert(accountAssetsTable).values({
            repUsername: request.repUsername,
            account: request.customer,
            itemType: request.itemType,
            brand: request.brand,
            count: request.quantity,
            lastDate: dateStr,
          });
        }
      });

      res.json({ success: true, message: "Request fulfilled" });
    } catch (err: any) {
      if (err?.code === "NOT_FOUND") {
        res.status(404).json({ error: "Request not found" });
        return;
      }
      if (err?.code === "BAD_STATUS") {
        res.status(400).json({ error: err.message });
        return;
      }
      console.error("[requests fulfill]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.post(
  "/:id/cancel",
  requireRole("warehouse", "rep"),
  async (req: Request, res: Response) => {
    try {
      const id = parseInt(req.params.id as string, 10);
      const user = req.user!;

      await db.transaction(async (tx) => {
        const reqs = await tx
          .select()
          .from(posRequestsTable)
          .where(eq(posRequestsTable.id, id));
        const req2 = reqs[0];
        if (!req2) {
          throw Object.assign(new Error("Not found"), {
            status: 404,
            code: "NOT_FOUND",
          });
        }
        if (user.role === "rep" && req2.repUsername !== user.username) {
          throw Object.assign(new Error("Forbidden"), {
            status: 403,
            code: "FORBIDDEN",
          });
        }
        if (req2.status === "Pending") {
          const inv = await tx
            .select()
            .from(inventoryTable)
            .where(
              and(
                eq(inventoryTable.itemType, req2.itemType),
                eq(inventoryTable.brand, req2.brand),
              ),
            );
          if (inv[0]) {
            await tx
              .update(inventoryTable)
              .set({ quantity: inv[0].quantity + req2.quantity })
              .where(eq(inventoryTable.id, inv[0].id));
          }
        }

        await tx
          .update(posRequestsTable)
          .set({ status: "Cancelled" })
          .where(eq(posRequestsTable.id, id));
      });

      res.json({ success: true, message: "Request cancelled" });
    } catch (err: any) {
      if (err?.code === "NOT_FOUND") {
        res.status(404).json({ error: "Request not found" });
        return;
      }
      if (err?.code === "FORBIDDEN") {
        res.status(403).json({ error: "Forbidden" });
        return;
      }
      console.error("[requests cancel]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
