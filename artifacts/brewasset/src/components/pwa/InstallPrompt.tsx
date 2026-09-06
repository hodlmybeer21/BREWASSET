import { Download, X } from "lucide-react";
import { useState } from "react";
import { usePwaInstall } from "@/lib/pwa";
import { Button } from "@/components/ui/core";
import { useToast } from "@/hooks/use-toast";

export function InstallPrompt() {
  const { canInstall, installed, install } = usePwaInstall();
  const [dismissed, setDismissed] = useState(false);
  const { toast } = useToast();

  if (installed || !canInstall || dismissed) return null;

  return (
    <div
      className="fixed bottom-24 left-3 right-3 sm:left-auto sm:right-4 sm:w-80 z-50 bg-surface border border-border rounded-lg shadow-lg p-3 flex items-center gap-3"
      role="dialog"
      aria-label="Install BrewAsset"
    >
      <Download className="w-5 h-5 text-primary shrink-0" />
      <div className="flex-1 min-w-0">
        <div className="text-sm font-medium">Install BrewAsset</div>
        <div className="text-xs text-muted-foreground">
          Add to home screen for camera + voice
        </div>
      </div>
      <Button
        size="sm"
        onClick={async () => {
          const ok = await install();
          toast({
            title: ok ? "Installed" : "Skipped",
            description: ok
              ? "BrewAsset is on your home screen."
              : "You can install later from your browser menu.",
          });
        }}
      >
        Install
      </Button>
      <button
        type="button"
        onClick={() => setDismissed(true)}
        className="text-muted-foreground hover:text-foreground"
        aria-label="Dismiss install prompt"
      >
        <X className="w-4 h-4" />
      </button>
    </div>
  );
}
