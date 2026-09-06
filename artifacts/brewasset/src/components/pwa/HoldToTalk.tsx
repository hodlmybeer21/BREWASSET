import { useEffect, useRef, useState } from "react";
import { Mic, Square } from "lucide-react";
import { Button } from "@/components/ui/core";
import { useToast } from "@/hooks/use-toast";

/**
 * HoldToTalk — Chunk 1 STUB.
 * - Captures a webm/opus blob from the user's microphone.
 * - STT + agent pipeline lands in Chunk 2 (will POST to /api/agent/stt).
 * - On stop, surface file size + duration via toast so the manager sees
 *   the recording actually landed before the agent call arrives.
 */
export function HoldToTalk() {
  const [recording, setRecording] = useState(false);
  const [duration, setDuration] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const recRef = useRef<MediaRecorder | null>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const chunksRef = useRef<BlobPart[]>([]);
  const startRef = useRef<number>(0);
  const tickRef = useRef<number | null>(null);
  const { toast } = useToast();

  useEffect(() => {
    return () => {
      // Cleanup on unmount
      if (tickRef.current) window.clearInterval(tickRef.current);
      if (streamRef.current) {
        streamRef.current.getTracks().forEach((t) => t.stop());
      }
      if (recRef.current && recRef.current.state !== "inactive") {
        try {
          recRef.current.stop();
        } catch {
          // ignore
        }
      }
    };
  }, []);

  async function start() {
    if (recording) return;
    setError(null);
    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: { echoCancellation: true, noiseSuppression: true },
      });
      streamRef.current = stream;
      const mimeType = MediaRecorder.isTypeSupported(
        "audio/webm;codecs=opus",
      )
        ? "audio/webm;codecs=opus"
        : MediaRecorder.isTypeSupported("audio/webm")
          ? "audio/webm"
          : "";
      const mr = mimeType
        ? new MediaRecorder(stream, { mimeType })
        : new MediaRecorder(stream);
      chunksRef.current = [];
      mr.ondataavailable = (e) => {
        if (e.data && e.data.size > 0) chunksRef.current.push(e.data);
      };
      mr.onstop = () => {
        stream.getTracks().forEach((t) => t.stop());
        streamRef.current = null;
        const blob = new Blob(chunksRef.current, {
          type: mimeType || "audio/webm",
        });
        const kb = (blob.size / 1024).toFixed(1);
        const secs = duration.toFixed(1);
        toast({
          title: `Captured ${kb} KB (${secs}s)`,
          description:
            "STT + agent pipeline lands in Chunk 2. Blob ready to ship.",
        });
      };
      mr.start(250);
      recRef.current = mr;
      startRef.current = Date.now();
      setRecording(true);
      setDuration(0);
      tickRef.current = window.setInterval(() => {
        setDuration((Date.now() - startRef.current) / 1000);
      }, 100);
    } catch (err: any) {
      const msg =
        err?.name === "NotAllowedError"
          ? "Microphone permission denied"
          : "Could not start microphone";
      setError(msg);
      toast({ title: msg, variant: "destructive" });
    }
  }

  function stop() {
    if (tickRef.current) {
      window.clearInterval(tickRef.current);
      tickRef.current = null;
    }
    if (recRef.current && recRef.current.state !== "inactive") {
      recRef.current.stop();
    }
    setRecording(false);
  }

  return (
    <Button
      type="button"
      variant={recording ? "destructive" : "default"}
      size="lg"
      className="w-full justify-center gap-2 select-none"
      aria-label={recording ? "Stop recording" : "Hold to talk"}
      aria-pressed={recording}
      onPointerDown={(e) => {
        e.preventDefault();
        if (!recording) start();
      }}
      onPointerUp={() => recording && stop()}
      onPointerCancel={() => recording && stop()}
      onPointerLeave={() => recording && stop()}
    >
      {recording ? (
        <>
          <Square className="w-4 h-4" />
          Recording {duration.toFixed(1)}s
        </>
      ) : (
        <>
          <Mic className="w-4 h-4" />
          {error ? "Tap to retry mic" : "Hold to talk"}
        </>
      )}
    </Button>
  );
}
