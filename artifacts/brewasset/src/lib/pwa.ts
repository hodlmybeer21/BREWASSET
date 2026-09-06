"use client";

import { useEffect, useState } from "react";

export interface BeforeInstallPromptEvent extends Event {
  prompt(): Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
}

/** Capture the browser's beforeinstallprompt event into state.
 *  Used by InstallPrompt.tsx to render an "Install BrewAsset" dock. */
export function usePwaInstall() {
  const [installPrompt, setInstallPrompt] =
    useState<BeforeInstallPromptEvent | null>(null);
  const [installed, setInstalled] = useState(false);

  useEffect(() => {
    if (typeof window === "undefined") return;
    function onBeforeInstall(e: Event) {
      e.preventDefault();
      setInstallPrompt(e as BeforeInstallPromptEvent);
    }
    function onAppInstalled() {
      setInstalled(true);
      setInstallPrompt(null);
    }
    window.addEventListener("beforeinstallprompt", onBeforeInstall);
    window.addEventListener("appinstalled", onAppInstalled);
    return () => {
      window.removeEventListener("beforeinstallprompt", onBeforeInstall);
      window.removeEventListener("appinstalled", onAppInstalled);
    };
  }, []);

  async function install(): Promise<boolean> {
    if (!installPrompt) return false;
    await installPrompt.prompt();
    const { outcome } = await installPrompt.userChoice;
    setInstallPrompt(null);
    return outcome === "accepted";
  }

  return { canInstall: !!installPrompt, installed, install };
}

/** Register the service worker. PWA install only works on https:// or localhost.
 *  Called once on app load. */
export function registerServiceWorker() {
  if (typeof window === "undefined") return;
  if (!("serviceWorker" in navigator)) return;
  const host = window.location.hostname;
  if (
    window.location.protocol !== "https:" &&
    host !== "localhost" &&
    host !== "127.0.0.1"
  ) {
    return;
  }
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js", { scope: "/" })
      .catch(() => {
        // SW registration is non-critical; surface in console only.
      });
  });
}
