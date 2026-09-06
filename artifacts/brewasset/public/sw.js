/* BrewAsset service worker — Chunk 1
 * Caches the app shell + same-origin static assets. Never caches /api/*.
 * Navigation: network-first with cached shell fallback.
 * Other GETs: cache-first with network fallback, populating cache opportunistically.
 */
const CACHE = "brewasset-shell-v1";
const SHELL = ["/", "/manifest.webmanifest", "/favicon.svg"];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches
      .open(CACHE)
      .then((c) => c.addAll(SHELL).catch(() => {}))
      .then(() => self.skipWaiting()),
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))),
      )
      .then(() => self.clients.claim()),
  );
});

self.addEventListener("fetch", (event) => {
  const req = event.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);

  // Never cache the API
  if (url.pathname.startsWith("/api/")) return;

  // SPA navigations: network-first, fall back to the cached shell
  if (req.mode === "navigate") {
    event.respondWith(
      fetch(req).catch(() =>
        caches.match("/").then(
          (r) => r || new Response("Offline", { status: 503 }),
        ),
      ),
    );
    return;
  }

  // Static assets: cache-first, populate from network when possible
  event.respondWith(
    caches.match(req).then((cached) => {
      if (cached) return cached;
      return fetch(req)
        .then((resp) => {
          if (resp.ok && url.origin === self.location.origin) {
            const copy = resp.clone();
            caches
              .open(CACHE)
              .then((c) => c.put(req, copy))
              .catch(() => {});
          }
          return resp;
        })
        .catch(
          () => cached || new Response("Offline", { status: 503 }),
        );
    }),
  );
});
