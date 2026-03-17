import { useState } from "react";
import { motion } from "framer-motion";
import { AppLayout } from "@/components/layout/AppLayout";
import { FadeIn, Card, CardHeader, CardContent, Badge, Button, Input, Select, Label, Textarea } from "@/components/ui/core";
import { 
  useGetEvents, useApproveEvent, useCancelEvent, useToggleEventStaff, useApprovePOS,
  useGetPromoStaff, useCreatePromoStaff, useUpdatePromoStaff, useDeletePromoStaff,
  getGetEventsQueryKey, getGetPromoStaffQueryKey
} from "@workspace/api-client-react";
import { useToast } from "@/hooks/use-toast";
import { useQueryClient } from "@tanstack/react-query";
import { Calendar as CalendarIcon, List, Users } from "lucide-react";
import { formatDate } from "@/lib/utils";
import { ITEM_ICONS, ITEM_COLORS } from "@/lib/constants";

export default function MarketingView() {
  const [tab, setTab] = useState("calendar");
  const { data: events } = useGetEvents();
  const pendingCount = events?.filter(e => e.status === "pending").length || 0;

  const navItems = [
    { id: "calendar", label: "Calendar", icon: <CalendarIcon className="w-4 h-4" /> },
    { id: "events", label: `All Events ${pendingCount > 0 ? `(${pendingCount})` : ''}`, icon: <List className="w-4 h-4" /> },
    { id: "staff", label: "Staff", icon: <Users className="w-4 h-4" /> },
  ];

  return (
    <AppLayout navItems={navItems} currentTab={tab} onTabChange={setTab}>
      {tab === "calendar" && <CalendarTab />}
      {tab === "events" && <AllEventsTab />}
      {tab === "staff" && <StaffTab />}
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
        <div className="flex items-center gap-2 text-muted-foreground"><span className="w-3 h-3 bg-warning rounded-sm"></span> Needs Staff / POS</div>
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
                        <div style={{ color }} className="truncate">{e.repUsername} • {e.startTime}</div>
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
          const needsStaff = evt.staffAssigned.length < evt.staffRequested;
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
                    <div className="text-xs text-muted-foreground mt-1">
                      {formatDate(evt.date)} • {evt.startTime} - {evt.endTime} • Rep: <span className="text-primary">{evt.repUsername}</span>
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

                    {/* POS Section */}
                    <div>
                      <h4 className="text-xs font-bold tracking-widest uppercase text-muted-foreground mb-4">POS Materials</h4>
                      {evt.posItems.length > 0 ? (
                        <div className="space-y-4">
                          <div className="flex flex-wrap gap-2">
                            {evt.posItems.map(p => (
                              <Badge key={p} variant="tint" color={ITEM_COLORS[p] || "#888"}>{ITEM_ICONS[p]} {p}</Badge>
                            ))}
                          </div>
                          <div className="bg-surface2 p-3 rounded border border-border flex justify-between items-center text-sm">
                            <span className="text-muted-foreground">Status:</span>
                            <span className={evt.posApproved ? "text-success font-bold" : "text-warning font-bold"}>
                              {evt.posApproved ? "✓ Approved" : "Pending Approval"}
                            </span>
                          </div>
                          {!evt.posApproved && evt.status === "approved" && (
                            <Button variant="success" className="w-full" onClick={() => posMutation.mutate({ id: evt.id })}>
                              ✓ Approve POS Release
                            </Button>
                          )}
                        </div>
                      ) : (
                        <div className="text-sm text-muted-foreground italic">No POS requested.</div>
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

  const createMutation = useCreatePromoStaff({
    mutation: { onSuccess: () => { toast({ title: "Staff added" }); queryClient.invalidateQueries({ queryKey: getGetPromoStaffQueryKey() }); setForm({ name: "", phone: "", email: "", notes: "" }); } }
  });
  const deleteMutation = useDeletePromoStaff({
    mutation: { onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetPromoStaffQueryKey() }) }
  });

  const [form, setForm] = useState({ name: "", phone: "", email: "", notes: "" });

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
          </CardContent>
        </Card>
      </div>

      <div className="lg:col-span-2 space-y-4">
        <div className="flex justify-between items-end mb-4">
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Promo Staff Roster</h2>
          <Badge variant="tint" color="#9070d0">{staff?.length || 0} Members</Badge>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {staff?.map(s => (
            <Card key={s.id} className="hover:border-[#9070d0]/50 transition-colors">
              <CardContent className="p-5 flex flex-col justify-between h-full">
                <div>
                  <div className="flex justify-between items-start mb-2">
                    <h3 className="text-lg font-bold text-foreground">{s.name}</h3>
                    <Button variant="ghost" size="icon" className="h-6 w-6 text-muted-foreground hover:text-destructive" onClick={() => deleteMutation.mutate({ id: s.id })}>✕</Button>
                  </div>
                  <div className="text-xs text-muted-foreground space-y-1">
                    {s.phone && <div>📞 {s.phone}</div>}
                    {s.email && <div>✉️ {s.email}</div>}
                  </div>
                  {s.notes && (
                    <div className="mt-3 text-[10px] uppercase tracking-widest text-[#9070d0] bg-[#9070d0]/10 p-2 rounded">
                      {s.notes}
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </FadeIn>
  );
}
