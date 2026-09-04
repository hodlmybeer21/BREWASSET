import app from "./app";

export default app;

// On Vercel the platform invokes the exported app; only listen for Render/Replit/local.
if (!process.env.VERCEL) {
  console.log("[STARTUP] index.ts running");
  console.log("[STARTUP] PORT:", process.env.PORT);
  console.log("[STARTUP] DATABASE_URL:", process.env.DATABASE_URL ? "SET" : "MISSING");
  console.log("[STARTUP] CWD:", process.cwd());

  const rawPort = process.env["PORT"];

  if (!rawPort) {
    throw new Error(
      "PORT environment variable is required but was not provided.",
    );
  }

  const port = Number(rawPort);

  if (Number.isNaN(port) || port <= 0) {
    throw new Error(`Invalid PORT value: "${rawPort}"`);
  }

  console.log("[STARTUP] About to listen on port", port);

  app.listen(port, () => {
    console.log(`[STARTUP] Server listening on port ${port}`);
  });
}
