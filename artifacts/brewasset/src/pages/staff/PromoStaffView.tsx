import { useState, useRef } from "react";
import { useLocation } from "wouter";
import {
  useGetMe,
  useLogout,
  useGetEvents,
  useGetEventReport,
  useSubmitEventReport,
} from "@workspace/api-client-react";
import { Card, Button, Input } from "@/components/ui/core";
import {
  Hexagon, LogOut, Star, CalendarDays, MapPin, Clock, Users,
  ChevronDown, ChevronUp, Camera, Send, CheckCircle, Loader2, ImagePlus, X,
} from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { formatTime } from "@/lib/utils";

// ─── Report Form ──────────────────────────────────────────────────────────────

function ReportForm({ eventId, staffName, onDone }: { eventId: number; staffName: string; onDone: () => void }) {
  const { toast } = useToast();
  const { data: existing, refetch } = useGetEventReport(eventId, { staffName }, {
    query: { retry: false }
  });

  const [attendeeCount, setAttendeeCount] = useState<string>(existing?.attendeeCount?.toString() ?? "");
  const [servedCount, setServedCount] = useState<string>(existing?.servedCount?.toString() ?? "");
  const [brandComments, setBrandComments] = useState(existing?.brandComments ?? "");
  const [totalSpend, setTotalSpend] = useState(existing?.totalSpend ?? "");
  const [images, setImages] = useState<string[]>(existing?.imageUrls ?? []);

  const fileInputRef = useRef<HTMLInputElement>(null);
  const submitMutation = useSubmitEventReport({
    mutation: {
      onSuccess: () => {
        toast({ title: "Report Saved", description: "Your event report has been submitted." });
        refetch();
        onDone();
      },
      onError: () => toast({ title: "Error", description: "Failed to save report.", variant: "destructive" }),
    },
  });

  const handleImageAdd = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files ?? []);
    files.forEach(file => {
      const reader = new FileReader();
      reader.onload = (ev) => {
        const img = new Image();
        img.onload = () => {
          const canvas = document.createElement("canvas");
          const MAX = 800;
          const ratio = Math.min(MAX / img.width, MAX / img.height, 1);
          canvas.width = img.width * ratio;
          canvas.height = img.height * ratio;
          const ctx = canvas.getContext("2d")!;
          ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
          const dataUrl = canvas.toDataURL("image/jpeg", 0.72);
          setImages(prev => [...prev, dataUrl]);
        };
        img.src = ev.target?.result as string;
      };
      reader.readAsDataURL(file);
    });
    e.target.value = "";
  };

  const handleSubmit = () => {
    submitMutation.mutate({
      id: eventId,
      data: {
        staffName,
        attendeeCount: attendeeCount ? parseInt(attendeeCount) : null,
        servedCount: servedCount ? parseInt(servedCount) : null,
        brandComments: brandComments || null,
        totalSpend: totalSpend || null,
        imageUrls: images,
      },
    });
  };

  return (
    <div className="mt-3 space-y-3 p-4 rounded-lg bg-background/60 border border-purple-500/20">
      <p className="text-[11px] uppercase tracking-widest text-purple-400 font-bold mb-2">Event Report</p>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <label className="text-[10px] uppercase tracking-wider text-muted-foreground mb-1 block">Attendees</label>
          <Input
            type="number"
            placeholder="0"
            value={attendeeCount}
            onChange={e => setAttendeeCount(e.target.value)}
            className="h-10 bg-background/50 text-sm"
          />
        </div>
        <div>
          <label className="text-[10px] uppercase tracking-wider text-muted-foreground mb-1 block">Served</label>
          <Input
            type="number"
            placeholder="0"
            value={servedCount}
            onChange={e => setServedCount(e.target.value)}
            className="h-10 bg-background/50 text-sm"
          />
        </div>
      </div>

      <div>
        <label className="text-[10px] uppercase tracking-wider text-muted-foreground mb-1 block">Brand / Comments</label>
        <textarea
          className="w-full h-24 bg-background/50 border border-input rounded-md px-3 py-2 text-sm resize-none focus:outline-none focus:ring-1 focus:ring-ring"
          placeholder="Notes on brands poured, customer reactions, highlights..."
          value={brandComments}
          onChange={e => setBrandComments(e.target.value)}
        />
      </div>

      <div>
        <label className="text-[10px] uppercase tracking-wider text-muted-foreground mb-1 block">Total Spend ($)</label>
        <Input
          placeholder="0.00"
          value={totalSpend}
          onChange={e => setTotalSpend(e.target.value)}
          className="h-10 bg-background/50 text-sm"
        />
      </div>

      <div>
        <label className="text-[10px] uppercase tracking-wider text-muted-foreground mb-1 block">Photos ({images.length})</label>
        <div className="flex flex-wrap gap-2">
          {images.map((img, i) => (
            <div key={i} className="relative w-16 h-16 rounded overflow-hidden border border-border">
              <img src={img} alt="" className="w-full h-full object-cover" />
              <button
                className="absolute top-0 right-0 bg-black/70 rounded-bl p-0.5"
                onClick={() => setImages(prev => prev.filter((_, idx) => idx !== i))}
              >
                <X className="w-3 h-3 text-white" />
              </button>
            </div>
          ))}
          <button
            className="w-16 h-16 rounded border border-dashed border-purple-500/40 flex items-center justify-center text-purple-400 hover:bg-purple-500/10 transition-colors"
            onClick={() => fileInputRef.current?.click()}
          >
            <ImagePlus className="w-5 h-5" />
          </button>
          <input ref={fileInputRef} type="file" accept="image/*" multiple className="hidden" onChange={handleImageAdd} />
        </div>
      </div>

      <div className="flex gap-2 pt-1">
        <Button
          variant="outline"
          className="flex-1 h-10 text-sm"
          onClick={onDone}
        >
          Cancel
        </Button>
        <Button
          className="flex-1 h-10 text-sm bg-purple-600 hover:bg-purple-700 text-white border-0"
          onClick={handleSubmit}
          disabled={submitMutation.isPending}
        >
          {submitMutation.isPending ? <Loader2 className="w-4 h-4 animate-spin mr-2" /> : <Send className="w-4 h-4 mr-2" />}
          Submit Report
        </Button>
      </div>
    </div>
  );
}

// ─── Event Card ───────────────────────────────────────────────────────────────

function EventCard({ event, staffName }: { event: any; staffName: string }) {
  const [open, setOpen] = useState(false);
  const { data: report } = useGetEventReport(event.id, { staffName }, {
    query: { retry: false }
  });

  const dateObj = new Date(event.date + "T12:00:00");
  const dateStr = dateObj.toLocaleDateString("en-US", { weekday: "short", month: "short", day: "numeric" });
  const isPast = dateObj < new Date();

  return (
    <Card className="p-4 border-border/60">
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            <span className={`w-2 h-2 rounded-full flex-shrink-0 ${isPast ? "bg-muted-foreground" : "bg-green-500"}`} />
            <h3 className="font-semibold text-sm truncate">{event.title}</h3>
            {report && (
              <span className="flex items-center gap-1 text-[10px] uppercase tracking-wider text-green-500 font-bold">
                <CheckCircle className="w-3 h-3" /> Reported
              </span>
            )}
          </div>

          <div className="space-y-1">
            <div className="flex items-center gap-2 text-xs text-muted-foreground">
              <CalendarDays className="w-3 h-3 flex-shrink-0" />
              <span>{dateStr}</span>
              {event.startTime && (
                <>
                  <Clock className="w-3 h-3 flex-shrink-0 ml-1" />
                  <span>{formatTime(event.startTime)}</span>
                </>
              )}
            </div>
            {event.account && (
              <div className="flex items-center gap-2 text-xs text-muted-foreground">
                <MapPin className="w-3 h-3 flex-shrink-0" />
                <span className="truncate">{event.account}</span>
              </div>
            )}
            {event.staffAssigned?.length > 0 && (
              <div className="flex items-center gap-2 text-xs text-muted-foreground">
                <Users className="w-3 h-3 flex-shrink-0" />
                <span>{event.staffAssigned.join(", ")}</span>
              </div>
            )}
          </div>
        </div>

        <button
          className="flex-shrink-0 flex items-center gap-1 text-xs text-purple-400 hover:text-purple-300 transition-colors"
          onClick={() => setOpen(v => !v)}
        >
          {open ? (
            <><ChevronUp className="w-4 h-4" /></>
          ) : (
            <>{report ? "Edit" : "Report"}<ChevronDown className="w-4 h-4" /></>
          )}
        </button>
      </div>

      {report && !open && (
        <div className="mt-2 p-2 rounded bg-green-500/5 border border-green-500/10 text-xs text-muted-foreground grid grid-cols-2 gap-x-4 gap-y-0.5">
          {report.attendeeCount != null && <span>Attendees: <span className="text-foreground">{report.attendeeCount}</span></span>}
          {report.servedCount != null && <span>Served: <span className="text-foreground">{report.servedCount}</span></span>}
          {report.totalSpend && <span>Spend: <span className="text-foreground">${report.totalSpend}</span></span>}
          {report.imageUrls?.length > 0 && <span>Photos: <span className="text-foreground">{report.imageUrls.length}</span></span>}
        </div>
      )}

      {open && <ReportForm eventId={event.id} staffName={staffName} onDone={() => setOpen(false)} />}
    </Card>
  );
}

// ─── Main View ────────────────────────────────────────────────────────────────

export default function PromoStaffView() {
  const [, setLocation] = useLocation();
  const { data: me, isLoading: meLoading } = useGetMe();
  const logoutMutation = useLogout({ mutation: { onSuccess: () => setLocation("/") } });
  const [filter, setFilter] = useState<"upcoming" | "past" | "all">("upcoming");

  const staffName = me?.displayName ?? me?.username ?? "";

  const { data: events, isLoading: eventsLoading } = useGetEvents(
    { staffName: staffName || undefined },
    { query: { enabled: !!staffName } }
  );

  if (meLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="w-8 h-8 text-primary animate-spin" />
      </div>
    );
  }

  if (!me || me.role !== "staff") {
    setLocation("/");
    return null;
  }

  const now = new Date();
  const filtered = (events ?? []).filter(ev => {
    const d = new Date(ev.date + "T12:00:00");
    if (filter === "upcoming") return d >= now;
    if (filter === "past") return d < now;
    return true;
  });

  const sorted = [...filtered].sort((a, b) => {
    const da = new Date(a.date + "T12:00:00").getTime();
    const db = new Date(b.date + "T12:00:00").getTime();
    return filter === "past" ? db - da : da - db;
  });

  return (
    <div className="min-h-screen bg-background text-foreground">
      {/* Header */}
      <header className="sticky top-0 z-40 border-b border-border/50 bg-surface/90 backdrop-blur-md">
        <div className="max-w-2xl mx-auto px-4 h-14 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <Hexagon className="w-6 h-6 text-primary" />
            <div>
              <p className="text-[11px] uppercase tracking-widest text-muted-foreground leading-none">Promo Staff</p>
              <p className="text-sm font-semibold leading-tight">{staffName}</p>
            </div>
          </div>
          <button
            className="flex items-center gap-1.5 text-xs text-muted-foreground hover:text-foreground transition-colors"
            onClick={() => logoutMutation.mutate()}
          >
            <LogOut className="w-4 h-4" />
            Logout
          </button>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 py-6 space-y-4">
        {/* Filter Tabs */}
        <div className="flex gap-2">
          {(["upcoming", "past", "all"] as const).map(f => (
            <button
              key={f}
              onClick={() => setFilter(f)}
              className={`px-4 py-2 rounded-lg text-xs uppercase tracking-widest font-bold transition-colors ${
                filter === f
                  ? "bg-purple-600 text-white"
                  : "bg-surface text-muted-foreground hover:text-foreground border border-border/60"
              }`}
            >
              {f}
            </button>
          ))}
        </div>

        {/* Summary */}
        <div className="flex items-center gap-2 text-xs text-muted-foreground">
          <Star className="w-3.5 h-3.5 text-purple-400" />
          <span>{sorted.length} event{sorted.length !== 1 ? "s" : ""} assigned to you</span>
        </div>

        {/* Event List */}
        {eventsLoading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="w-8 h-8 text-primary animate-spin" />
          </div>
        ) : sorted.length === 0 ? (
          <div className="text-center py-16 text-muted-foreground">
            <Star className="w-10 h-10 mx-auto mb-3 opacity-20" />
            <p className="text-sm">No {filter === "all" ? "" : filter} events assigned to you.</p>
          </div>
        ) : (
          <div className="space-y-3">
            {sorted.map(ev => (
              <EventCard key={ev.id} event={ev} staffName={staffName} />
            ))}
          </div>
        )}
      </main>
    </div>
  );
}
