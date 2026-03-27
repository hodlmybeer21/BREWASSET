import { useState } from "react";
import { motion } from "framer-motion";
import { AppLayout } from "@/components/layout/AppLayout";
import { FadeIn, Card, CardHeader, CardContent, Badge, Button, Input, Select, Label, Textarea } from "@/components/ui/core";
import { 
  useGetEvents, useApproveEvent, useCancelEvent, useToggleEventStaff, useApprovePOS,
  useGetPromoStaff, useCreatePromoStaff, useUpdatePromoStaff, useDeletePromoStaff,
  useGetAllEventReports,
  getGetEventsQueryKey, getGetPromoStaffQueryKey
} from "@workspace/api-client-react";
import { useToast } from "@/hooks/use-toast";
import { useQueryClient } from "@tanstack/react-query";
import { Calendar as CalendarIcon, List, Users, BarChart2, Download, ChevronDown, ChevronUp, ImageIcon, Pencil, Check, X } from "lucide-react";
import { formatDate, formatTime } from "@/lib/utils";

const EVENT_ITEMS: Record<string, { icon: string; color: string }> = {
  "Banner Requested": { icon: "🪧", color: "#e8a020" },
  "Promo Bag":        { icon: "🎒", color: "#9070d0" },
  "Sample Cups":      { icon: "🥤", color: "#60a0e8" },
  "Raffle Items":     { icon: "🎟️", color: "#40c080" },
};

export default function MarketingView() {
  const [tab, setTab] = useState("calendar");
  const { data: events } = useGetEvents();
  const pendingCount = events?.filter(e => e.status === "pending").length || 0;

  const navItems = [
    { id: "calendar", label: "Calendar", icon: <CalendarIcon className="w-4 h-4" /> },
    { id: "events", label: `All Events ${pendingCount > 0 ? `(${pendingCount})` : ''}`, icon: <List className="w-4 h-4" /> },
    { id: "staff", label: "Staff", icon: <Users className="w-4 h-4" /> },
    { id: "roi", label: "Event ROI", icon: <BarChart2 className="w-4 h-4" /> },
  ];

  return (
    <AppLayout navItems={navItems} currentTab={tab} onTabChange={setTab}>
      {tab === "calendar" && <CalendarTab />}
      {tab === "events" && <AllEventsTab />}
      {tab === "staff" && <StaffTab />}
      {tab === "roi" && <ROITab />}
    </AppLayout>
  );
}

function CalendarTab() {
  const { data: events } = useGetEvents();
  const [currentMonth, setCurrentMonth] = useState(new Date());

  const daysInMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1, 0).getDate();
  const firstDay = new Date(currentMonth.getFullYear(), currentMonth.getMonth(), 1).getDay();
  
  const cells = Array(firstDay).fill(null).concat(Array.from({length: daysInMonth}, (_, i) => i + 1));
  const weekDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];

  const nextMonth = () => setCurrentMonth(new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1, 1));
  const prevMonth = () => setCurrentMonth(new Date(currentMonth.getFullYear(), currentMonth.getMonth() - 1, 1));

  return (
    <FadeIn>
      <div className="flex justify-between items-center mb-6">
        <div>
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Promo Calendar</h2>
        </div>
        <div className="flex items-center gap-4">
          <Button variant="ghost" onClick={prevMonth}>◀</Button>
          <span className="font-bold tracking-widest w-32 text-center">
            {currentMonth.toLocaleString('en-US', { month: 'long', year: 'numeric' }).toUpperCase()}
          </span>
          <Button variant="ghost" onClick={nextMonth}>▶</Button>
        </div>
      </div>

      <div className="flex gap-4 mb-4 text-[10px] tracking-widest uppercase">
        <div className="flex items-center gap-2 text-muted-foreground"><span className="w-3 h-3 bg-success rounded-sm"></span> Confirmed / Ready</div>
        <div className="flex items-center gap-2 text-muted-foreground"><span className="w-3 h-3 bg-warning rounded-sm"></span> Needs Staff / Items</div>
      </div>

      <Card className="overflow-hidden">
        <div className="grid grid-cols-7 border-b border-border bg-surface2">
          {weekDays.map(d => (
            <div key={d} className="py-3 text-center text-[10px] font-bold tracking-widest text-muted-foreground border-r border-border last:border-r-0">
              {d}
            </div>
          ))}
        </div>
        <div className="grid grid-cols-7">
          {cells.map((day, i) => {
            if (!day) return <div key={`empty-${i}`} className="min-h-[120px] border-r border-b border-border bg-surface/50" />;
            
            const dateStr = `${currentMonth.getFullYear()}-${String(currentMonth.getMonth() + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
            const dayEvents = events?.filter(e => e.date === dateStr && e.status !== "cancelled") || [];
            const isToday = new Date().toISOString().split('T')[0] === dateStr;

            return (
              <div key={day} className={`min-h-[120px] border-r border-b border-border p-2 ${isToday ? 'bg-primary/5' : ''}`}>
                <div className={`text-xs font-bold mb-2 ${isToday ? 'text-primary' : 'text-muted-foreground'}`}>{day}</div>
                <div className="space-y-1 overflow-y-auto max-h-[100px] scrollbar-none">
                  {dayEvents.map(e => {
                    const isReady = e.staffAssigned.length >= e.staffRequested && (e.posItems.length === 0 || e.posApproved);
                    const color = isReady ? 'var(--color-success)' : 'var(--color-warning)';
                    return (
                      <div 
                        key={e.id} 
                        className="text-[9px] p-1.5 rounded border border-l-2 truncate cursor-pointer hover:opacity-80 transition-opacity"
                        style={{ backgroundColor: `${color}15`, borderColor: `${color}30`, borderLeftColor: color, color: 'var(--color-foreground)' }}
                        title={e.title}
                      >
                        <div className="font-bold truncate">{e.title}</div>
                        <div style={{ color }} className="truncate">{e.repUsername} • {formatTime(e.startTime)}</div>
                      </div>
                    )
                  })}
                </div>
              </div>
            );
          })}
        </div>
      </Card>
    </FadeIn>
  );
}

function AllEventsTab() {
  const { data: events } = useGetEvents();
  const { data: staff } = useGetPromoStaff();
  const [filter, setFilter] = useState("all");
  const [expandedId, setExpandedId] = useState<number | null>(null);
  
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const approveMutation = useApproveEvent({
    mutation: { onSuccess: () => { toast({ title: "Event approved" }); queryClient.invalidateQueries({ queryKey: getGetEventsQueryKey() }); } }
  });
  const cancelMutation = useCancelEvent({
    mutation: { onSuccess: () => { toast({ title: "Event cancelled" }); queryClient.invalidateQueries({ queryKey: getGetEventsQueryKey() }); } }
  });
  const staffMutation = useToggleEventStaff({
    mutation: { onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetEventsQueryKey() }) }
  });
  const posMutation = useApprovePOS({
    mutation: { onSuccess: () => { toast({ title: "POS Approved" }); queryClient.invalidateQueries({ queryKey: getGetEventsQueryKey() }); } }
  });

  const evts = events?.filter(e => filter === "all" ? true : e.status === filter).sort((a,b) => a.date.localeCompare(b.date)) || [];

  return (
    <FadeIn>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-4 mb-6">
        <div>
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">All Events</h2>
        </div>
        <div className="flex gap-2 bg-surface2 p-1 rounded-lg border border-border">
          {["all", "pending", "approved"].map(f => (
            <button 
              key={f} 
              className={`px-4 py-1.5 text-xs font-bold tracking-widest uppercase rounded ${filter === f ? 'bg-primary text-primary-foreground shadow-sm' : 'text-muted-foreground hover:text-foreground'}`}
              onClick={() => setFilter(f)}
            >
              {f}
            </button>
          ))}
        </div>
      </div>

      <div className="space-y-4">
        {evts.map(evt => {
          const isExpanded = expandedId === evt.id;
          const needsStaff = !evt.repOrSupplierPresent && evt.staffAssigned.length < evt.staffRequested;
          const needsPos = evt.posItems.length > 0 && !evt.posApproved;
          
          let statusColor = "var(--color-border)";
          if (evt.status === "approved") {
            statusColor = (!needsStaff && !needsPos) ? "var(--color-success)" : "var(--color-warning)";
          }
          if (evt.status === "cancelled") statusColor = "var(--color-destructive)";

          return (
            <Card key={evt.id} style={{ borderLeftColor: statusColor, borderLeftWidth: '4px' }} className="transition-all duration-300">
              <CardContent className="p-5">
                <div className="flex flex-col md:flex-row justify-between gap-4">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-1">
                      <h3 className="text-lg font-bold">{evt.title}</h3>
                      <Badge variant="tint" color={statusColor}>
                        {evt.status === "approved" && !needsStaff && !needsPos ? "CONFIRMED" : evt.status}
                      </Badge>
                    </div>
                    <div className="font-bold text-muted-foreground text-sm">{evt.account}</div>
                    <div className="text-xs text-muted-foreground mt-1 flex flex-wrap items-center gap-x-2 gap-y-1">
                      <span>{formatDate(evt.date)} • {formatTime(evt.startTime)} - {formatTime(evt.endTime)} • Rep: <span className="text-primary">{evt.repUsername}</span></span>
                      {evt.repOrSupplierPresent && (
                        <span className="inline-flex items-center gap-1 text-[10px] font-bold uppercase tracking-wider text-[#e8a020] bg-[#e8a020]/10 border border-[#e8a020]/30 px-1.5 py-0.5 rounded">
                          👤 Rep/Supplier Present
                        </span>
                      )}
                    </div>
                  </div>
                  
                  <div className="flex flex-wrap gap-2 items-center">
                    {evt.status === "pending" && (
                      <Button variant="success" size="sm" onClick={() => approveMutation.mutate({ id: evt.id })}>✓ Approve</Button>
                    )}
                    <Button variant="outline" size="sm" onClick={() => setExpandedId(isExpanded ? null : evt.id)}>
                      {isExpanded ? "▲ Hide Details" : "▼ Manage"}
                    </Button>
                    {evt.status !== "cancelled" && (
                      <Button variant="danger" size="sm" onClick={() => cancelMutation.mutate({ id: evt.id })}>✕ Cancel</Button>
                    )}
                  </div>
                </div>

                {isExpanded && (
                  <motion.div 
                    initial={{ opacity: 0, height: 0 }} 
                    animate={{ opacity: 1, height: 'auto' }} 
                    className="mt-6 pt-6 border-t border-border grid grid-cols-1 md:grid-cols-2 gap-8"
                  >
                    {/* Staff Section */}
                    <div>
                      <h4 className="text-xs font-bold tracking-widest uppercase text-muted-foreground mb-4">
                        Staff Assignment <span className={needsStaff ? "text-warning" : "text-success"}>({evt.staffAssigned.length}/{evt.staffRequested})</span>
                      </h4>
                      <div className="space-y-2 max-h-60 overflow-y-auto pr-2">
                        {staff?.map(s => {
                          const isAssigned = evt.staffAssigned.includes(s.name);
                          return (
                            <div key={s.id} className={`flex items-center justify-between p-2 rounded border ${isAssigned ? 'bg-[#60a0e8]/10 border-[#60a0e8]/30' : 'bg-surface border-border'}`}>
                              <div>
                                <div className={`text-sm font-bold ${isAssigned ? 'text-[#60a0e8]' : 'text-foreground'}`}>{s.name}</div>
                                <div className="text-[10px] text-muted-foreground">{s.phone || 'No phone'}</div>
                              </div>
                              <Button 
                                variant={isAssigned ? "danger" : "outline"} 
                                size="sm" 
                                className={`h-7 px-2 text-[10px] ${isAssigned ? '' : 'text-[#60a0e8] hover:bg-[#60a0e8]/20'}`}
                                onClick={() => staffMutation.mutate({ id: evt.id, data: { staffName: s.name } })}
                              >
                                {isAssigned ? "Remove" : "Assign"}
                              </Button>
                            </div>
                          )
                        })}
                      </div>
                    </div>

                    {/* Event Items Section */}
                    <div>
                      <h4 className="text-xs font-bold tracking-widest uppercase text-muted-foreground mb-4">Event Items Requested</h4>
                      {evt.posItems.length > 0 ? (
                        <div className="space-y-4">
                          <div className="flex flex-wrap gap-2">
                            {evt.posItems.map(p => {
                              const meta = EVENT_ITEMS[p] || { icon: "📦", color: "#888" };
                              return (
                                <Badge key={p} variant="tint" color={meta.color}>{meta.icon} {p}</Badge>
                              );
                            })}
                          </div>
                          <div className="bg-surface2 p-3 rounded border border-border flex justify-between items-center text-sm">
                            <span className="text-muted-foreground">Status:</span>
                            <span className={evt.posApproved ? "text-success font-bold" : "text-warning font-bold"}>
                              {evt.posApproved ? "✓ Confirmed" : "Pending Confirmation"}
                            </span>
                          </div>
                          {!evt.posApproved && evt.status === "approved" && (
                            <Button variant="success" className="w-full" onClick={() => posMutation.mutate({ id: evt.id })}>
                              ✓ Confirm Event Items
                            </Button>
                          )}
                        </div>
                      ) : (
                        <div className="text-sm text-muted-foreground italic">No items requested.</div>
                      )}

                      {evt.notes && (
                        <div className="mt-6">
                          <h4 className="text-[10px] font-bold tracking-widest uppercase text-muted-foreground mb-2">Notes</h4>
                          <div className="bg-surface p-3 rounded border border-border text-xs text-muted-foreground italic">
                            "{evt.notes}"
                          </div>
                        </div>
                      )}
                    </div>
                  </motion.div>
                )}
              </CardContent>
            </Card>
          );
        })}
      </div>
    </FadeIn>
  );
}

function StaffTab() {
  const { data: staff } = useGetPromoStaff();
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const [newMemberPassword, setNewMemberPassword] = useState<{ name: string; password: string } | null>(null);

  const createMutation = useCreatePromoStaff({
    mutation: {
      onSuccess: (data: any) => {
        queryClient.invalidateQueries({ queryKey: getGetPromoStaffQueryKey() });
        setForm({ name: "", phone: "", email: "", notes: "" });
        if (data?.generatedPassword) {
          setNewMemberPassword({ name: data.name, password: data.generatedPassword });
        }
      }
    }
  });
  const updateMutation = useUpdatePromoStaff({
    mutation: { onSuccess: () => { toast({ title: "Contact info updated" }); queryClient.invalidateQueries({ queryKey: getGetPromoStaffQueryKey() }); } }
  });
  const deleteMutation = useDeletePromoStaff({
    mutation: { onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetPromoStaffQueryKey() }) }
  });

  const [form, setForm] = useState({ name: "", phone: "", email: "", notes: "" });
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editForm, setEditForm] = useState({ name: "", phone: "", email: "", notes: "" });

  const startEdit = (s: any) => {
    setEditingId(s.id);
    setEditForm({ name: s.name, phone: s.phone ?? "", email: s.email ?? "", notes: s.notes ?? "" });
  };

  const saveEdit = (id: number) => {
    updateMutation.mutate({ id, data: editForm }, {
      onSuccess: () => setEditingId(null),
    });
  };

  const handleAdd = () => {
    if (!form.name) return;
    createMutation.mutate({ data: form });
  };

  return (
    <FadeIn className="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <div className="lg:col-span-1">
        <Card className="border-t-2 border-t-[#9070d0] sticky top-20">
          <CardContent className="p-6 space-y-4">
            <h3 className="text-xs font-bold tracking-widest text-[#9070d0] uppercase mb-4">+ Add Staff Member</h3>
            <div>
              <Label>Full Name</Label>
              <Input value={form.name} onChange={e => setForm({...form, name: e.target.value})} placeholder="e.g. Sarah Jenkins" />
            </div>
            <div>
              <Label>Phone</Label>
              <Input value={form.phone} onChange={e => setForm({...form, phone: e.target.value})} placeholder="555-0199" />
            </div>
            <div>
              <Label>Email</Label>
              <Input value={form.email} onChange={e => setForm({...form, email: e.target.value})} placeholder="sarah@example.com" />
            </div>
            <div>
              <Label>Notes</Label>
              <Input value={form.notes} onChange={e => setForm({...form, notes: e.target.value})} placeholder="Specialties, region..." />
            </div>
            <Button 
              className="w-full mt-2 bg-[#9070d0] text-white hover:bg-[#8060c0] shadow-[0_0_15px_rgba(144,112,208,0.2)]"
              onClick={handleAdd}
              disabled={!form.name || createMutation.isPending}
            >
              Add To Roster
            </Button>

            {newMemberPassword && (
              <div className="mt-4 rounded-md border border-[#9070d0]/40 bg-[#9070d0]/10 p-4 space-y-2">
                <div className="flex justify-between items-center">
                  <p className="text-[10px] font-bold tracking-widest uppercase text-[#9070d0]">Portal Access Created</p>
                  <button onClick={() => setNewMemberPassword(null)} className="text-muted-foreground hover:text-foreground text-xs">✕</button>
                </div>
                <p className="text-xs text-muted-foreground">Share these credentials with <span className="text-foreground font-semibold">{newMemberPassword.name}</span>:</p>
                <div className="rounded bg-[#0a0a0a] border border-[#9070d0]/30 px-3 py-2 flex items-center justify-between gap-2">
                  <code className="text-sm font-mono text-[#9070d0] tracking-wider">{newMemberPassword.password}</code>
                  <button
                    onClick={() => { navigator.clipboard.writeText(newMemberPassword.password); toast({ title: "Copied!" }); }}
                    className="text-[10px] uppercase tracking-widest text-muted-foreground hover:text-[#9070d0] transition-colors"
                  >
                    Copy
                  </button>
                </div>
                <p className="text-[10px] text-muted-foreground/60">This password will not be shown again.</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      <div className="lg:col-span-2 space-y-4">
        <div className="flex justify-between items-end mb-4">
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Promo Staff Roster</h2>
          <Badge variant="tint" color="#9070d0">{staff?.length || 0} Members</Badge>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {staff?.map(s => {
            const isEditing = editingId === s.id;
            return (
              <Card key={s.id} className={`transition-colors ${isEditing ? "border-[#9070d0]/60" : "hover:border-[#9070d0]/30"}`}>
                <CardContent className="p-5">
                  {/* Header row */}
                  <div className="flex justify-between items-start mb-3">
                    <h3 className="text-lg font-bold text-foreground">{s.name}</h3>
                    <div className="flex items-center gap-1">
                      {!isEditing && (
                        <Button
                          variant="ghost" size="icon"
                          className="h-6 w-6 text-muted-foreground hover:text-[#9070d0]"
                          onClick={() => startEdit(s)}
                          title="Edit contact info"
                        >
                          <Pencil className="w-3.5 h-3.5" />
                        </Button>
                      )}
                      <Button
                        variant="ghost" size="icon"
                        className="h-6 w-6 text-muted-foreground hover:text-destructive"
                        onClick={() => deleteMutation.mutate({ id: s.id })}
                        title="Remove from roster"
                      >
                        <X className="w-3.5 h-3.5" />
                      </Button>
                    </div>
                  </div>

                  {/* View mode */}
                  {!isEditing && (
                    <div className="text-xs text-muted-foreground space-y-1.5">
                      <div className="flex items-center gap-2">
                        <span className="text-base leading-none">📞</span>
                        <span>{s.phone || <span className="italic opacity-50">No phone</span>}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <span className="text-base leading-none">✉️</span>
                        <span>{s.email || <span className="italic opacity-50">No email</span>}</span>
                      </div>
                      {s.notes && (
                        <div className="mt-2 text-[10px] uppercase tracking-widest text-[#9070d0] bg-[#9070d0]/10 p-2 rounded">
                          {s.notes}
                        </div>
                      )}
                    </div>
                  )}

                  {/* Edit mode */}
                  {isEditing && (
                    <div className="space-y-2.5">
                      <div>
                        <Label className="text-[10px]">Phone</Label>
                        <Input
                          value={editForm.phone}
                          onChange={e => setEditForm({ ...editForm, phone: e.target.value })}
                          placeholder="555-0199"
                          className="h-8 text-sm"
                          autoFocus
                        />
                      </div>
                      <div>
                        <Label className="text-[10px]">Email</Label>
                        <Input
                          value={editForm.email}
                          onChange={e => setEditForm({ ...editForm, email: e.target.value })}
                          placeholder="name@example.com"
                          className="h-8 text-sm"
                        />
                      </div>
                      <div>
                        <Label className="text-[10px]">Notes</Label>
                        <Input
                          value={editForm.notes}
                          onChange={e => setEditForm({ ...editForm, notes: e.target.value })}
                          placeholder="Specialties, region..."
                          className="h-8 text-sm"
                        />
                      </div>
                      <div className="flex gap-2 pt-1">
                        <Button
                          variant="outline"
                          size="sm"
                          className="flex-1 h-8 text-xs"
                          onClick={() => setEditingId(null)}
                        >
                          Cancel
                        </Button>
                        <Button
                          size="sm"
                          className="flex-1 h-8 text-xs bg-[#9070d0] hover:bg-[#8060c0] text-white border-0"
                          onClick={() => saveEdit(s.id)}
                          disabled={updateMutation.isPending}
                        >
                          <Check className="w-3.5 h-3.5 mr-1" /> Save
                        </Button>
                      </div>
                    </div>
                  )}
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>
    </FadeIn>
  );
}

// ─── Event ROI Tab ────────────────────────────────────────────────────────────

function ROITab() {
  const { data: reports = [], isLoading } = useGetAllEventReports();
  const [expanded, setExpanded] = useState<number | null>(null);

  const totalAttendees = reports.reduce((s, r) => s + (r.attendeeCount ?? 0), 0);
  const totalServed    = reports.reduce((s, r) => s + (r.servedCount ?? 0), 0);
  const totalSpend     = reports.reduce((s, r) => s + parseFloat(r.totalSpend ?? "0"), 0);
  const totalPhotos    = reports.reduce((s, r) => s + (r.imageUrls?.length ?? 0), 0);

  const downloadImage = (dataUrl: string, filename: string) => {
    const a = document.createElement("a");
    a.href = dataUrl;
    a.download = filename;
    a.click();
  };

  if (isLoading) {
    return (
      <div className="flex justify-center py-20">
        <div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <FadeIn>
      <div className="space-y-6">

        {/* Summary Cards */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {[
            { label: "Reports Submitted", value: reports.length, color: "#e8a020" },
            { label: "Total Attendees",   value: totalAttendees.toLocaleString(), color: "#60a0e8" },
            { label: "Total Served",      value: totalServed.toLocaleString(),    color: "#40c080" },
            { label: "Total Spend",       value: totalSpend > 0 ? `$${totalSpend.toFixed(2)}` : "—", color: "#c080e0" },
          ].map(stat => (
            <Card key={stat.label} className="p-4 text-center">
              <p className="text-2xl font-bold" style={{ color: stat.color }}>{stat.value}</p>
              <p className="text-[10px] uppercase tracking-widest text-muted-foreground mt-1">{stat.label}</p>
            </Card>
          ))}
        </div>

        {/* Reports List */}
        {reports.length === 0 ? (
          <div className="text-center py-20 text-muted-foreground">
            <BarChart2 className="w-12 h-12 mx-auto mb-3 opacity-20" />
            <p className="text-sm">No event reports submitted yet.</p>
            <p className="text-xs mt-1 opacity-60">Promo staff will submit reports after each event.</p>
          </div>
        ) : (
          <div className="space-y-3">
            {reports.map(r => {
              const isOpen = expanded === r.id;
              const ev = r.event;
              return (
                <Card key={r.id} className="overflow-hidden">
                  {/* Header row */}
                  <button
                    className="w-full text-left p-4 hover:bg-white/5 transition-colors"
                    onClick={() => setExpanded(isOpen ? null : r.id)}
                  >
                    <div className="flex items-start justify-between gap-4">
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2 mb-1">
                          <span className="font-semibold text-sm truncate">
                            {ev?.title ?? `Event #${r.eventId}`}
                          </span>
                          {r.imageUrls?.length > 0 && (
                            <span className="flex items-center gap-1 text-[10px] text-muted-foreground bg-surface px-1.5 py-0.5 rounded">
                              <ImageIcon className="w-3 h-3" /> {r.imageUrls.length}
                            </span>
                          )}
                        </div>
                        <div className="flex flex-wrap gap-x-4 gap-y-0.5 text-xs text-muted-foreground">
                          {ev && <span>{formatDate(ev.date)} · {ev.account}</span>}
                          <span>Staff: <span className="text-foreground">{r.staffName}</span></span>
                          <span>Submitted: {new Date(r.submittedAt).toLocaleDateString("en-US", { month: "short", day: "numeric" })}</span>
                        </div>
                      </div>

                      {/* Quick stats */}
                      <div className="flex items-center gap-4 flex-shrink-0 text-right">
                        {r.attendeeCount != null && (
                          <div>
                            <p className="text-sm font-bold text-[#60a0e8]">{r.attendeeCount}</p>
                            <p className="text-[9px] uppercase tracking-wider text-muted-foreground">Attended</p>
                          </div>
                        )}
                        {r.servedCount != null && (
                          <div>
                            <p className="text-sm font-bold text-[#40c080]">{r.servedCount}</p>
                            <p className="text-[9px] uppercase tracking-wider text-muted-foreground">Served</p>
                          </div>
                        )}
                        {r.totalSpend && (
                          <div>
                            <p className="text-sm font-bold text-[#c080e0]">${r.totalSpend}</p>
                            <p className="text-[9px] uppercase tracking-wider text-muted-foreground">Spend</p>
                          </div>
                        )}
                        {isOpen ? <ChevronUp className="w-4 h-4 text-muted-foreground ml-1" /> : <ChevronDown className="w-4 h-4 text-muted-foreground ml-1" />}
                      </div>
                    </div>
                  </button>

                  {/* Expanded detail */}
                  {isOpen && (
                    <div className="border-t border-border/50 p-4 space-y-4">

                      {/* Brand comments */}
                      {r.brandComments && (
                        <div>
                          <p className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1">Notes / Brand Comments</p>
                          <p className="text-sm bg-surface rounded p-3 whitespace-pre-wrap">{r.brandComments}</p>
                        </div>
                      )}

                      {/* Stats grid */}
                      <div className="grid grid-cols-3 gap-3">
                        {[
                          { label: "Attendees", value: r.attendeeCount },
                          { label: "Served", value: r.servedCount },
                          { label: "Spend", value: r.totalSpend ? `$${r.totalSpend}` : null },
                        ].map(s => s.value != null && (
                          <div key={s.label} className="bg-surface rounded p-3 text-center">
                            <p className="text-lg font-bold text-primary">{s.value}</p>
                            <p className="text-[10px] uppercase tracking-wider text-muted-foreground">{s.label}</p>
                          </div>
                        ))}
                      </div>

                      {/* Conversion rate */}
                      {r.attendeeCount && r.servedCount && r.attendeeCount > 0 && (
                        <div className="flex items-center gap-3 text-sm">
                          <span className="text-muted-foreground text-xs uppercase tracking-wider">Conversion rate</span>
                          <div className="flex-1 bg-surface rounded-full h-2 overflow-hidden">
                            <div
                              className="h-full bg-green-500 rounded-full"
                              style={{ width: `${Math.min(100, Math.round((r.servedCount / r.attendeeCount) * 100))}%` }}
                            />
                          </div>
                          <span className="font-bold text-green-400 text-sm">
                            {Math.round((r.servedCount / r.attendeeCount) * 100)}%
                          </span>
                        </div>
                      )}

                      {/* Photos */}
                      {r.imageUrls?.length > 0 && (
                        <div>
                          <div className="flex items-center justify-between mb-2">
                            <p className="text-[10px] uppercase tracking-widest text-muted-foreground">
                              Photos ({r.imageUrls.length})
                            </p>
                            <button
                              className="text-[10px] uppercase tracking-wider text-primary hover:text-primary/80 flex items-center gap-1"
                              onClick={() => r.imageUrls.forEach((url, i) =>
                                downloadImage(url, `${(ev?.title ?? "event").replace(/\s+/g, "-")}-${r.staffName.replace(/\s+/g, "")}-photo${i + 1}.jpg`)
                              )}
                            >
                              <Download className="w-3 h-3" /> Download All
                            </button>
                          </div>
                          <div className="grid grid-cols-3 sm:grid-cols-4 gap-2">
                            {r.imageUrls.map((url, i) => (
                              <div key={i} className="relative group rounded overflow-hidden aspect-square bg-surface">
                                <img src={url} alt={`Photo ${i + 1}`} className="w-full h-full object-cover" />
                                <button
                                  className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center"
                                  onClick={() => downloadImage(url, `${(ev?.title ?? "event").replace(/\s+/g, "-")}-${r.staffName.replace(/\s+/g, "")}-photo${i + 1}.jpg`)}
                                >
                                  <Download className="w-5 h-5 text-white" />
                                </button>
                              </div>
                            ))}
                          </div>
                        </div>
                      )}

                    </div>
                  )}
                </Card>
              );
            })}
          </div>
        )}

        {totalPhotos > 0 && (
          <p className="text-center text-xs text-muted-foreground">{totalPhotos} total photos across all reports</p>
        )}

      </div>
    </FadeIn>
  );
}
