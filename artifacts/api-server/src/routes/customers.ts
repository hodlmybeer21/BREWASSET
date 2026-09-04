import { Router, type IRouter, type Request, type Response } from "express";
import { pool } from "@workspace/db";
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

      let query: string;
      let params: unknown[];

      if (ownedRep) {
        query = `
          SELECT id, name, rep_username AS "repUsername", chain, customer_type AS "customerType", active
          FROM customers
          WHERE rep_username = $1 AND active = true
          ORDER BY name ASC
        `;
        params = [ownedRep];
      } else {
        query = `
          SELECT id, name, rep_username AS "repUsername", chain, customer_type AS "customerType", active
          FROM customers
          WHERE active = true
          ORDER BY rep_username, name ASC
        `;
        params = [];
      }

      const { rows } = await pool.query(query, params);
      res.json(rows);
    } catch (err) {
      console.error("[customers GET]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

router.patch(
  "/:id",
  requireRole("marketing", "warehouse"),
  async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const { repUsername, active } = req.body;

      const updates: string[] = [];
      const values: unknown[] = [];
      let idx = 1;

      if (repUsername !== undefined) {
        updates.push(`rep_username = $${idx++}`);
        values.push(repUsername);
      }
      if (active !== undefined) {
        updates.push(`active = $${idx++}`);
        values.push(active);
      }

      if (updates.length === 0) {
        res.status(400).json({ error: "No fields to update" });
        return;
      }

      updates.push(`updated_at = NOW()`);
      values.push(Number(id));

      const { rows } = await pool.query(
        `UPDATE customers SET ${updates.join(", ")} WHERE id = $${idx} RETURNING *`,
        values,
      );

      if (rows.length === 0) {
        res.status(404).json({ error: "Customer not found" });
        return;
      }

      res.json(rows[0]);
    } catch (err) {
      console.error("[customers PATCH]", err);
      res.status(500).json({ error: "Internal server error" });
    }
  },
);

export default router;
