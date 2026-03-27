import { Router, type IRouter, type Request, type Response } from "express";
import { pool } from "@workspace/db";

const router: IRouter = Router();

// GET /customers?repUsername=xxx  — returns all customers for a rep (or all if omitted)
router.get("/", async (req: Request, res: Response) => {
  const repUsername = req.query.repUsername as string | undefined;

  let query: string;
  let params: any[];

  if (repUsername) {
    query = `
      SELECT id, name, rep_username AS "repUsername", chain, customer_type AS "customerType", active
      FROM customers
      WHERE rep_username = $1 AND active = true
      ORDER BY name ASC
    `;
    params = [repUsername];
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
});

// PATCH /customers/:id — update rep assignment (for future territory changes)
router.patch("/:id", async (req: Request, res: Response) => {
  const { id } = req.params;
  const { repUsername, active } = req.body;

  const updates: string[] = [];
  const values: any[] = [];
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
    values
  );

  if (rows.length === 0) {
    res.status(404).json({ error: "Customer not found" });
    return;
  }

  res.json(rows[0]);
});

export default router;
