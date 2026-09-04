import express, { type Express } from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import session from "express-session";
import router from "./routes/index.js";
import path from "path";
import { fileURLToPath } from "url";

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

app.use(cors({ origin: true, credentials: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.set("trust proxy", 1);

app.use(
  session({
    secret: process.env.SESSION_SECRET || "brewasset-secret-2026",
    resave: false,
    saveUninitialized: false,
    cookie: {
      secure: onVercel,
      httpOnly: true,
      sameSite: "lax",
      maxAge: 7 * 24 * 60 * 60 * 1000,
    },
  }),
);

app.use("/api", router);
app.get("/health", (_req, res) => res.json({ status: "ok" }));
app.use(express.static(distPath));
app.get("/{*splat}", (_req, res) => {
  res.sendFile(path.join(distPath, "index.html"));
});

export default app;
