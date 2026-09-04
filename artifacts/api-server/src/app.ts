import express, { type Express, type Request, type Response } from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import session from "express-session";
import connectPgSimple from "connect-pg-simple";
import router from "./routes/index.js";
import path from "path";
import { fileURLToPath } from "url";
import { pool } from "@workspace/db";

// Bundled at: artifacts/api-server/dist/index.cjs
// Frontend at: artifacts/brewasset/dist/public
const moduleDir =
  typeof __dirname !== "undefined"
    ? __dirname
    : path.dirname(fileURLToPath(import.meta.url));

const distPath = process.env.VERCEL
  ? path.join(process.cwd(), "artifacts/brewasset/dist/public")
  : path.resolve(moduleDir, "../../brewasset/dist/public");

const app: Express = express();
const onVercel = Boolean(process.env.VERCEL);
const isProduction =
  onVercel || process.env.NODE_ENV === "production";

const sessionSecret = process.env.SESSION_SECRET;
if (!sessionSecret) {
  if (isProduction) {
    throw new Error(
      "SESSION_SECRET environment variable is required when VERCEL or NODE_ENV=production",
    );
  }
  console.warn(
    "[WARN] SESSION_SECRET not set; using insecure local-dev fallback (do not use in production)",
  );
}

const ALLOWED_ORIGINS = new Set([
  "https://brewasset.vercel.app",
  "http://localhost:3000",
  "http://localhost:5173",
  "http://localhost:8080",
  "http://127.0.0.1:3000",
  "http://127.0.0.1:5173",
  "http://127.0.0.1:8080",
]);

app.use(
  cors({
    origin(origin, callback) {
      // Non-browser / same-origin requests may omit Origin
      if (!origin || ALLOWED_ORIGINS.has(origin)) {
        callback(null, true);
        return;
      }
      callback(new Error("Not allowed by CORS"));
    },
    credentials: true,
  }),
);
app.use(express.json({ limit: "2mb" }));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.set("trust proxy", 1);

const PgSession = connectPgSimple(session);

app.use(
  session({
    store: new PgSession({
      pool,
      tableName: "session",
      createTableIfMissing: true,
    }),
    secret: sessionSecret || "local-dev-only-insecure-secret",
    resave: false,
    saveUninitialized: false,
    cookie: {
      secure: onVercel || process.env.NODE_ENV === "production",
      httpOnly: true,
      sameSite: "lax",
      maxAge: 7 * 24 * 60 * 60 * 1000,
    },
  }),
);

async function healthHandler(_req: Request, res: Response) {
  try {
    await pool.query("SELECT 1");
    res.json({ status: "ok" });
  } catch (err) {
    console.error("[health] database check failed", err);
    res.status(503).json({ status: "error", error: "database unavailable" });
  }
}

app.get("/health", healthHandler);
app.use("/api", router);
app.use(express.static(distPath));
app.get("/{*splat}", (_req, res) => {
  res.sendFile(path.join(distPath, "index.html"));
});

export default app;
