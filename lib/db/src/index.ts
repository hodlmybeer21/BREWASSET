import { drizzle } from "drizzle-orm/node-postgres";
import pg from "pg";
import * as schema from "./schema";

const { Pool } = pg;

if (!process.env.DATABASE_URL) {
  throw new Error(
    "DATABASE_URL must be set. Did you forget to provision a database?",
  );
}

const connectionString = process.env.DATABASE_URL;

/** Hosted Postgres (Neon, Supabase, Render, Vercel, RDS) typically needs SSL. */
function shouldUseSsl(url: string): boolean {
  if (process.env.DATABASE_SSL === "true") return true;
  if (process.env.DATABASE_SSL === "false") return false;
  if (process.env.VERCEL) return true;
  return /neon\.tech|supabase\.co|amazonaws\.com|render\.com|vercel-storage|postgres\.vercel|\.pooler\./i.test(
    url,
  );
}

export const pool = new Pool({
  connectionString,
  ...(shouldUseSsl(connectionString)
    ? { ssl: { rejectUnauthorized: false } }
    : {}),
});

export const db = drizzle(pool, { schema });

export * from "./schema";
