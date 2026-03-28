import express, { type Express } from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import session from "express-session";
import router from "./routes/index.js";
import path from "path";

// Build output: /app/artifacts/api-server/dist/index.js
// Frontend build: /app/artifacts/brewasset/dist/public
const distPath = path.resolve(process.cwd(), "../../brewasset/dist/public");

const app: Express = express();

app.use(cors({ origin: true, credentials: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use(session({
  secret: process.env.SESSION_SECRET || "brewasset-secret-2026",
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: false,
    httpOnly: true,
    maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
  },
}));

// Serve API routes
app.use("/api", router);

// Health check
app.get("/health", (_req, res) => res.json({ status: "ok" }));

// Serve frontend static files from brewasset dist
app.use(express.static(distPath));

// Fallback to index.html for SPA routes
app.get("*", (_req, res) => {
  res.sendFile(path.join(distPath, "index.html"));
});

export default app;
