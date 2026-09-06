import { useRef } from "react";
import { Camera, ImagePlus } from "lucide-react";
import { Button } from "@/components/ui/core";
import { useToast } from "@/hooks/use-toast";

/**
 * CameraCapture — Chunk 1 STUB.
 * - Mobile: opens rear camera via <input capture="environment">.
 * - Desktop: opens file picker.
 * - Vision pipeline + R2 upload lands in Chunk 3 (will POST to /api/agent/vision).
 * - For now, surface filename + size so the manager gets immediate feedback.
 */
export function CameraCapture({
  label = "Snap to inventory",
}: {
  label?: string;
}) {
  const inputRef = useRef<HTMLInputElement>(null);
  const { toast } = useToast();

  function onPick() {
    inputRef.current?.click();
  }

  return (
    <>
      <input
        ref={inputRef}
        type="file"
        accept="image/*"
        capture="environment"
        className="sr-only"
        onChange={(e) => {
          const f = e.target.files?.[0];
          if (!f) return;
          const kb = (f.size / 1024).toFixed(1);
          toast({
            title: `Snap: ${f.name} (${kb} KB)`,
            description:
              "Vision + R2 upload lands in Chunk 3. Blob ready to ship.",
          });
          e.target.value = "";
        }}
      />
      <Button
        type="button"
        variant="outline"
        size="lg"
        className="w-full justify-center gap-2"
        aria-label={label}
        onClick={onPick}
      >
        <Camera className="w-4 h-4" />
        {label}
      </Button>
    </>
  );
}

/** Reuse the file input for "upload an existing photo" — warehouse managers
 *  sometimes snap with their default camera and want to push it into the system. */
export function UploadExisting() {
  const inputRef = useRef<HTMLInputElement>(null);
  const { toast } = useToast();
  return (
    <>
      <input
        ref={inputRef}
        type="file"
        accept="image/*"
        className="sr-only"
        onChange={(e) => {
          const f = e.target.files?.[0];
          if (!f) return;
          toast({
            title: `Uploaded: ${f.name} (${(f.size / 1024).toFixed(1)} KB)`,
            description: "Existing-photo upload lands in Chunk 3.",
          });
          e.target.value = "";
        }}
      />
      <Button
        type="button"
        variant="ghost"
        size="sm"
        className="gap-2"
        onClick={() => inputRef.current?.click()}
      >
        <ImagePlus className="w-4 h-4" />
        Upload existing photo
      </Button>
    </>
  );
}
