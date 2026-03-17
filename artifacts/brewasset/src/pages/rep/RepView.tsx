import { useState } from "react";
import { AppLayout } from "@/components/layout/AppLayout";
import { FadeIn, Card, CardHeader, CardContent, Badge, Button, Input, Select, Label, Modal, Textarea } from "@/components/ui/core";
import { 
  useGetMe, useGetInventory, useGetRequests, useCreateRequest, useCancelRequest,
  useGetAccountAssets, useGetTransfers, useCreateTransfer, useGetEvents, useCreateEvent, useCancelEvent,
  useGetCustomers,
  getGetRequestsQueryKey, getGetAccountAssetsQueryKey, getGetTransfersQueryKey, getGetEventsQueryKey
} from "@workspace/api-client-react";
import { ITEM_TYPES, ITEM_ICONS, ITEM_COLORS, BRANDS_BY_ITEM } from "@/lib/constants";
import { useToast } from "@/hooks/use-toast";
import { useQueryClient } from "@tanstack/react-query";
import { PackageOpen, ListOrdered, Building2, Repeat, CalendarDays, Search } from "lucide-react";
import { formatDate } from "@/lib/utils";

export default function RepView() {
  const [tab, setTab] = useState("request");
  const { data: user } = useGetMe();
  const { data: requests } = useGetRequests({ repUsername: user?.username });
  
  const pendingCount = requests?.filter(r => r.status === "Pending").length || 0;

  const navItems = [
    { id: "request", label: "Request Items", icon: <PackageOpen className="w-4 h-4" /> },
    { id: "my-requests", label: `My Requests ${pendingCount > 0 ? `(${pendingCount})` : ''}`, icon: <ListOrdered className="w-4 h-4" /> },
    { id: "accounts", label: "My Accounts", icon: <Building2 className="w-4 h-4" /> },
    { id: "transfers", label: "Transfers", icon: <Repeat className="w-4 h-4" /> },
    { id: "events", label: "Events", icon: <CalendarDays className="w-4 h-4" /> },
  ];

  return (
    <AppLayout navItems={navItems} currentTab={tab} onTabChange={setTab}>
      {tab === "request" && <RequestItemsTab />}
      {tab === "my-requests" && <MyRequestsTab />}
      {tab === "accounts" && <AccountsTab />}
      {tab === "transfers" && <TransfersTab />}
      {tab === "events" && <EventsTab />}
    </AppLayout>
  );
}

function RequestItemsTab() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const { data: user } = useGetMe();
  const { data: inventory } = useGetInventory();
  
  const requestMutation = useCreateRequest({
    mutation: {
      onSuccess: () => {
        toast({ title: "Request submitted successfully", className: "bg-success text-success-foreground" });
        queryClient.invalidateQueries({ queryKey: getGetRequestsQueryKey() });
        setQty(1);
        setCustomer("");
        setSearch("");
      },
      onError: (err: any) => {
        toast({ title: "Failed to submit", description: err.error, variant: "destructive" });
      }
    }
  });

  const [itemType, setItemType] = useState(ITEM_TYPES[0]);
  const [brand, setBrand] = useState("");
  const [qty, setQty] = useState(1);
  const [customer, setCustomer] = useState("");
  const [search, setSearch] = useState("");

  const { data: customerData } = useGetCustomers(
    { repUsername: user?.username },
    { query: { enabled: !!user?.username } }
  );

  const items = inventory || [];
  const availBrands = [...new Set(items.filter(i => i.itemType === itemType).map(i => i.brand))];
  // Fallback to static if empty
  const brandsList = availBrands.length > 0 ? availBrands : (BRANDS_BY_ITEM[itemType] || []);

  const customers = (customerData || []).map(c => c.name);
  const filteredCustomers = customers.filter(c => c.toLowerCase().includes(search.toLowerCase()));

  const availQty = items.find(i => i.itemType === itemType && i.brand === brand)?.quantity || 0;

  const handleSubmit = () => {
    if (!itemType || !brand || !customer || qty < 1) {
      toast({ title: "Fill all fields", variant: "destructive" });
      return;
    }
    requestMutation.mutate({ data: { itemType, brand, customer, quantity: qty } });
  };

  return (
    <FadeIn className="max-w-2xl mx-auto">
      <div className="mb-6">
        <h2 className="text-2xl font-bold tracking-widest uppercase text-foreground">Request Items</h2>
        <p className="text-xs text-muted-foreground tracking-widest mt-1 uppercase">Order POS for your next delivery</p>
      </div>

      <Card>
        <CardContent className="space-y-6 p-6">
          <div>
            <Label>1. Item Type</Label>
            <div className="flex flex-wrap gap-2">
              {ITEM_TYPES.map(t => {
                const color = ITEM_COLORS[t] || "#888";
                const isSelected = itemType === t;
                return (
                  <button 
                    key={t}
                    onClick={() => { setItemType(t); setBrand(""); }}
                    className={`px-3 py-2 rounded border text-xs font-bold transition-colors`}
                    style={{
                      backgroundColor: isSelected ? `${color}22` : 'transparent',
                      borderColor: isSelected ? color : 'var(--color-border)',
                      color: isSelected ? color : 'var(--color-foreground)'
                    }}
                  >
                    {ITEM_ICONS[t]} {t}
                  </button>
                );
              })}
            </div>
          </div>

          <div>
            <Label>2. Brand</Label>
            <Select value={brand} onChange={e => setBrand(e.target.value)}>
              <option value="">Select brand...</option>
              {brandsList.map(b => {
                const stock = items.find(i => i.itemType === itemType && i.brand === b)?.quantity || 0;
                return <option key={b} value={b} disabled={stock === 0}>{b} {stock === 0 ? '(Out of stock)' : `(${stock} avail)`}</option>
              })}
            </Select>
          </div>

          <div>
            <Label>3. Account / Customer</Label>
            <Input 
              placeholder="Search your accounts..." 
              value={search}
              onChange={e => { setSearch(e.target.value); setCustomer(""); }}
              className="mb-2"
            />
            {search && !customer && (
              <div className="max-h-40 overflow-y-auto border border-border rounded-md bg-surface divide-y divide-border">
                {filteredCustomers.map(c => (
                  <div 
                    key={c} 
                    className="p-2 text-sm hover:bg-surface2 cursor-pointer transition-colors"
                    onClick={() => { setCustomer(c); setSearch(c); }}
                  >
                    {c}
                  </div>
                ))}
              </div>
            )}
            {customer && <div className="text-xs text-success font-bold mt-1">✓ Selected: {customer}</div>}
          </div>

          <div>
            <Label>4. Quantity</Label>
            <div className="flex gap-2">
              {[1, 2, 3, 5, 10].map(q => (
                <Button 
                  key={q} 
                  variant={qty === q ? "primary" : "outline"} 
                  onClick={() => setQty(q)}
                  disabled={brand ? q > availQty : false}
                >
                  {q}
                </Button>
              ))}
              <Input 
                type="number" 
                className="w-20" 
                value={qty} 
                onChange={e => setQty(parseInt(e.target.value) || 1)} 
                max={availQty || 99}
              />
            </div>
          </div>

          {brand && (
            <div className="bg-surface2 p-4 rounded-md border border-border flex justify-between items-center">
              <span className="text-sm text-muted-foreground">Available in warehouse:</span>
              <span className={`text-xl font-bold ${availQty > 0 ? 'text-success' : 'text-destructive'}`}>{availQty}</span>
            </div>
          )}

          <Button 
            className="w-full h-14 text-sm tracking-widest" 
            onClick={handleSubmit}
            disabled={requestMutation.isPending || !itemType || !brand || !customer}
          >
            {requestMutation.isPending ? "Submitting..." : "Submit Request For Next Truck"}
          </Button>
        </CardContent>
      </Card>
    </FadeIn>
  );
}

function MyRequestsTab() {
  const { data: user } = useGetMe();
  const { data: requests } = useGetRequests({ repUsername: user?.username });
  const queryClient = useQueryClient();
  const { toast } = useToast();

  const cancelMutation = useCancelRequest({
    mutation: {
      onSuccess: () => {
        toast({ title: "Request cancelled" });
        queryClient.invalidateQueries({ queryKey: getGetRequestsQueryKey() });
      }
    }
  });

  const reqs = requests || [];

  return (
    <FadeIn>
      <div className="mb-6">
        <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">My Requests</h2>
      </div>

      {reqs.length === 0 ? (
        <Card className="bg-surface2/50 border-dashed">
          <CardContent className="p-16 text-center">
            <p className="text-muted-foreground uppercase tracking-widest text-xs">No requests yet. Submit one to get started.</p>
          </CardContent>
        </Card>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {reqs.map(req => {
            const isPending = req.status === "Pending";
            const isFulfilled = req.status === "Fulfilled";
            const color = ITEM_COLORS[req.itemType] || "#888";
            
            let statusColor = "var(--color-warning)";
            if (isFulfilled) statusColor = "var(--color-success)";
            if (req.status === "Cancelled") statusColor = "var(--color-destructive)";

            return (
              <Card key={req.id} className="relative overflow-hidden" style={{ borderLeftColor: statusColor, borderLeftWidth: '4px' }}>
                <CardContent className="p-5">
                  <div className="flex justify-between items-start mb-3">
                    <div className="flex items-center gap-2 flex-wrap">
                      <span className="text-2xl">{ITEM_ICONS[req.itemType] || "📦"}</span>
                      <h3 className="text-lg font-bold">{req.quantity}x {req.brand}</h3>
                      <Badge variant="tint" color={color}>{req.itemType}</Badge>
                    </div>
                    {isPending && (
                      <Button 
                        variant="danger" 
                        size="sm" 
                        onClick={() => cancelMutation.mutate({ id: req.id })}
                        disabled={cancelMutation.isPending}
                      >
                        Cancel
                      </Button>
                    )}
                  </div>
                  
                  <div className="space-y-1 text-sm">
                    <div className="text-muted-foreground">For: <span className="text-foreground font-bold">{req.customer}</span></div>
                    <div className="text-muted-foreground text-xs">Status: <span className="font-bold uppercase tracking-widest" style={{ color: statusColor }}>{req.status}</span></div>
                    <div className="text-muted-foreground text-[10px] uppercase tracking-widest mt-2 block">
                      Req: {formatDate(req.createdAt)} {req.fulfilledAt && `• Fulf: ${formatDate(req.fulfilledAt)}`}
                    </div>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      )}
    </FadeIn>
  );
}

function AccountsTab() {
  const { data: user } = useGetMe();
  const { data: assets } = useGetAccountAssets({ repUsername: user?.username || "" });
  const { data: customers } = useGetCustomers(
    { repUsername: user?.username },
    { query: { enabled: !!user?.username } }
  );
  const [filterType, setFilterType] = useState("All");
  const [search, setSearch] = useState("");
  const [transferModal, setTransferModal] = useState<{fromAccount: string, itemType: string, brand: string, maxQty: number} | null>(null);
  const [expandedAccounts, setExpandedAccounts] = useState<Set<string>>(new Set());
  const ITEMS_PREVIEW = 4;

  const toggleExpand = (account: string) => {
    setExpandedAccounts(prev => {
      const next = new Set(prev);
      next.has(account) ? next.delete(account) : next.add(account);
      return next;
    });
  };

  // Group assets by account, then merge in all assigned accounts from DB (even with no items)
  const accountsMap: Record<string, typeof assets> = {};
  // Seed all assigned accounts from DB customers table first (empty arrays)
  const assignedAccounts = (customers || []).map(c => c.name);
  assignedAccounts.forEach(acct => { accountsMap[acct] = []; });
  // Overlay actual asset data
  if (assets) {
    assets.forEach(a => {
      if (!accountsMap[a.account]) accountsMap[a.account] = [];
      accountsMap[a.account]!.push(a);
    });
  }

  const sortedAccounts = Object.entries(accountsMap)
    .filter(([name]) => !search || name.toLowerCase().includes(search.toLowerCase()))
    // Sort: accounts with items first (by item count desc), then empty accounts alphabetically
    .sort((a, b) => {
      const aLen = a[1]?.length || 0;
      const bLen = b[1]?.length || 0;
      if (aLen !== bLen) return bLen - aLen;
      return a[0].localeCompare(b[0]);
    });

  return (
    <FadeIn>
      <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-4 mb-6">
        <div>
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">My Accounts</h2>
          <p className="text-xs text-muted-foreground tracking-widest mt-1 uppercase">Track POS assets by location</p>
        </div>
        <div className="relative w-full md:w-64">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input 
            placeholder="Search accounts..." 
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="pl-10"
          />
        </div>
      </div>

      <div className="flex flex-wrap gap-2 mb-6">
        <Badge 
          variant={filterType === "All" ? "default" : "outline"} 
          className="cursor-pointer px-3 py-1.5"
          onClick={() => setFilterType("All")}
        >
          All Items
        </Badge>
        {ITEM_TYPES.map(t => (
          <Badge 
            key={t}
            variant={filterType === t ? "tint" : "outline"}
            color={ITEM_COLORS[t]}
            className="cursor-pointer px-3 py-1.5"
            onClick={() => setFilterType(filterType === t ? "All" : t)}
          >
            {ITEM_ICONS[t]} {t}
          </Badge>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-6">
        {sortedAccounts.map(([account, accAssets]) => {
          const allAssets = accAssets || [];
          const filtered = filterType === "All" ? allAssets : allAssets.filter(a => a.itemType === filterType);
          // When filtering by type, skip accounts that don't have that item type
          if (filterType !== "All" && filtered.length === 0) return null;

          const totalItems = filtered.reduce((s, a) => s + a.count, 0);
          const isEmpty = allAssets.length === 0;
          const isExpanded = expandedAccounts.has(account);
          const hasMore = filtered.length > ITEMS_PREVIEW;
          const visibleItems = isExpanded ? filtered : filtered.slice(0, ITEMS_PREVIEW);

          return (
            <Card key={account} className={`flex flex-col ${isEmpty ? "opacity-50" : ""}`}>
              <CardHeader className="flex flex-row justify-between items-start">
                <div>
                  <h3 className="font-bold text-lg leading-tight mb-2 text-primary">{account}</h3>
                  <div className="flex flex-wrap gap-1">
                    {isEmpty
                      ? <span className="text-[9px] text-muted-foreground tracking-widest uppercase">No items on file</span>
                      : [...new Set(filtered.map(a => a.itemType))].map(t => (
                          <Badge key={t} variant="tint" color={ITEM_COLORS[t] || "#888"} className="text-[8px] px-1 py-0">{ITEM_ICONS[t]}</Badge>
                        ))
                    }
                  </div>
                </div>
                <div className="text-right">
                  <div className="text-2xl font-bold text-foreground leading-none">{isEmpty ? "—" : totalItems}</div>
                  <div className="text-[9px] text-muted-foreground tracking-widest uppercase">Items</div>
                </div>
              </CardHeader>
              {!isEmpty && (
                <div className="flex-1 divide-y divide-border">
                  {visibleItems.map((a, i) => (
                    <div key={i} className="p-3 px-4 flex justify-between items-center hover:bg-surface2/50 transition-colors">
                      <div className="flex items-center gap-3 overflow-hidden">
                        <span className="text-xl flex-shrink-0">{ITEM_ICONS[a.itemType] || "📦"}</span>
                        <div className="min-w-0">
                          <div className="font-bold text-sm truncate">{a.brand}</div>
                          <div className="text-[10px] text-muted-foreground uppercase truncate">{a.itemType}</div>
                          {a.lastDate && (
                            <div className="text-[9px] text-muted-foreground/60 tracking-wide mt-0.5">
                              {a.lastDate.split(" ")[0]}
                            </div>
                          )}
                        </div>
                      </div>
                      <div className="flex items-center gap-4 flex-shrink-0">
                        <div className="text-right">
                          <div className="font-bold text-lg" style={{ color: ITEM_COLORS[a.itemType] || '#888' }}>{a.count}</div>
                        </div>
                        <Button 
                          variant="outline" 
                          size="sm" 
                          className="h-7 text-[10px] px-2 text-[#60a0e8] border-[#60a0e8]/30 hover:bg-[#60a0e8]/10 hover:border-[#60a0e8]"
                          onClick={() => setTransferModal({ fromAccount: account, itemType: a.itemType, brand: a.brand, maxQty: a.count })}
                        >
                          ⇄ Move
                        </Button>
                      </div>
                    </div>
                  ))}
                  {hasMore && (
                    <button
                      onClick={() => toggleExpand(account)}
                      className="w-full py-2.5 text-[10px] tracking-widest uppercase text-muted-foreground hover:text-primary hover:bg-surface2/50 transition-colors flex items-center justify-center gap-1.5"
                    >
                      {isExpanded ? (
                        <><span>▲</span> Show less</>
                      ) : (
                        <><span>▼</span> Show {filtered.length - ITEMS_PREVIEW} more</>
                      )}
                    </button>
                  )}
                </div>
              )}
            </Card>
          );
        })}
        {sortedAccounts.length === 0 && (
          <div className="col-span-full py-12 text-center text-muted-foreground uppercase tracking-widest">
            No accounts found matching filters
          </div>
        )}
      </div>

      {transferModal && (
        <TransferModal 
          isOpen={true} 
          onClose={() => setTransferModal(null)} 
          data={transferModal} 
        />
      )}
    </FadeIn>
  );
}

function TransferModal({ isOpen, onClose, data }: { isOpen: boolean, onClose: () => void, data: { fromAccount: string, itemType: string, brand: string, maxQty: number } }) {
  const [qty, setQty] = useState(1);
  const [toSearch, setToSearch] = useState("");
  const [toAccount, setToAccount] = useState("");
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const { data: user } = useGetMe();
  const { data: customerData } = useGetCustomers(
    { repUsername: user?.username },
    { query: { enabled: !!user?.username } }
  );

  const transferMutation = useCreateTransfer({
    mutation: {
      onSuccess: () => {
        toast({ title: "Transfer logged successfully", className: "bg-success text-success-foreground" });
        queryClient.invalidateQueries({ queryKey: getGetAccountAssetsQueryKey() });
        queryClient.invalidateQueries({ queryKey: getGetTransfersQueryKey() });
        onClose();
      }
    }
  });

  const customers = (customerData || []).map(c => c.name);
  const filteredOptions = customers.filter(c => c !== data.fromAccount && (!toSearch || c.toLowerCase().includes(toSearch.toLowerCase()))).slice(0, 10);
  const showWarehouseOption = !toSearch || "main warehouse".includes(toSearch.toLowerCase());

  const handleTransfer = () => {
    if (!toAccount || qty < 1 || qty > data.maxQty) return;
    transferMutation.mutate({ 
      data: { 
        itemType: data.itemType, 
        brand: data.brand, 
        quantity: qty, 
        fromAccount: data.fromAccount, 
        toAccount: toAccount 
      } 
    });
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="⇄ Move Asset">
      <div className="space-y-6">
        <div className="bg-surface2 p-4 rounded-lg border border-border">
          <div className="text-[10px] text-muted-foreground tracking-widest uppercase mb-3">Moving</div>
          <div className="flex items-center gap-3">
            <span className="text-3xl">{ITEM_ICONS[data.itemType] || "📦"}</span>
            <div>
              <div className="font-bold text-lg text-foreground">{data.brand}</div>
              <div className="text-xs text-muted-foreground">{data.itemType}</div>
            </div>
          </div>
          <div className="mt-3 pt-3 border-t border-border/50 text-sm">
            From: <span className="text-warning font-bold">{data.fromAccount}</span>
          </div>
        </div>

        <div>
          <Label>Quantity to move (Max {data.maxQty})</Label>
          <div className="flex gap-2">
            {[...Array(Math.min(data.maxQty, 5))].map((_, i) => (
              <Button key={i+1} variant={qty === i+1 ? "primary" : "outline"} onClick={() => setQty(i+1)}>{i+1}</Button>
            ))}
            {data.maxQty > 5 && (
              <Input type="number" className="w-20" value={qty} onChange={e => setQty(Math.min(data.maxQty, parseInt(e.target.value)||1))} max={data.maxQty} />
            )}
          </div>
        </div>

        <div>
          <Label>Destination</Label>
          <Input 
            placeholder="Search accounts or warehouse..." 
            value={toSearch}
            onChange={e => { setToSearch(e.target.value); setToAccount(""); }}
            className="mb-2"
          />
          <div className="max-h-48 overflow-y-auto border border-border rounded-md bg-surface divide-y divide-border">
            {showWarehouseOption && (
              <div 
                className={`p-3 text-sm cursor-pointer flex justify-between items-center transition-colors ${toAccount === "MAIN WAREHOUSE" ? "bg-warning/20 text-warning" : "hover:bg-surface2 text-[#b0a060]"}`}
                onClick={() => { setToAccount("MAIN WAREHOUSE"); setToSearch("MAIN WAREHOUSE"); }}
              >
                <span className="font-bold flex items-center gap-2">🏭 MAIN WAREHOUSE</span>
                <Badge variant="tint" color="#ffaa00" className="text-[8px]">RETURN</Badge>
              </div>
            )}
            {filteredOptions.map(c => (
              <div 
                key={c} 
                className={`p-3 text-sm cursor-pointer transition-colors ${toAccount === c ? "bg-primary/20 text-primary font-bold" : "hover:bg-surface2"}`}
                onClick={() => { setToAccount(c); setToSearch(c); }}
              >
                {c}
              </div>
            ))}
          </div>
        </div>

        <div className="flex gap-3 pt-4">
          <Button variant="ghost" className="flex-1" onClick={onClose}>Cancel</Button>
          <Button className="flex-1" onClick={handleTransfer} disabled={!toAccount || transferMutation.isPending}>
            Confirm Transfer
          </Button>
        </div>
      </div>
    </Modal>
  );
}

function TransfersTab() {
  const { data: user } = useGetMe();
  const { data: transfers } = useGetTransfers({ repUsername: user?.username });

  return (
    <FadeIn>
      <div className="mb-6">
        <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Transfer History</h2>
        <p className="text-xs text-muted-foreground tracking-widest mt-1 uppercase">Direct account-to-account moves</p>
      </div>

      <Card>
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-border bg-surface2 text-[10px] tracking-widest text-muted-foreground uppercase">
                <th className="px-4 py-3 font-semibold">Date</th>
                <th className="px-4 py-3 font-semibold">Item</th>
                <th className="px-4 py-3 font-semibold">Brand</th>
                <th className="px-4 py-3 font-semibold text-center">Qty</th>
                <th className="px-4 py-3 font-semibold">From</th>
                <th className="px-4 py-3 font-semibold">To</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border/50">
              {transfers?.map(t => (
                <tr key={t.id} className={`hover:bg-surface2/50 transition-colors ${t.isReturn ? 'bg-warning/5' : ''}`}>
                  <td className="px-4 py-3 text-xs text-muted-foreground whitespace-nowrap">{formatDate(t.createdAt)}</td>
                  <td className="px-4 py-3">
                    <Badge variant="tint" color={ITEM_COLORS[t.itemType] || "#888"}>{ITEM_ICONS[t.itemType]} {t.itemType}</Badge>
                  </td>
                  <td className="px-4 py-3 font-bold">{t.brand}</td>
                  <td className="px-4 py-3 text-center">
                    <span className={`text-lg font-bold ${t.isReturn ? 'text-warning' : 'text-[#60a0e8]'}`}>{t.quantity}</span>
                  </td>
                  <td className="px-4 py-3 text-muted-foreground text-xs max-w-[150px] truncate" title={t.fromAccount}>{t.fromAccount}</td>
                  <td className="px-4 py-3 text-xs font-bold flex items-center gap-2 max-w-[150px] truncate" title={t.toAccount}>
                    {t.isReturn ? (
                      <span className="text-warning flex items-center gap-1">🏭 {t.toAccount}</span>
                    ) : (
                      <span className="text-success">{t.toAccount}</span>
                    )}
                  </td>
                </tr>
              ))}
              {(!transfers || transfers.length === 0) && (
                <tr>
                  <td colSpan={6} className="px-4 py-8 text-center text-muted-foreground text-xs uppercase tracking-widest">
                    No transfers logged
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </Card>
    </FadeIn>
  );
}

function EventsTab() {
  const [view, setView] = useState<"list" | "new">("list");
  const { data: user } = useGetMe();
  const { data: events } = useGetEvents({ repUsername: user?.username });
  const { toast } = useToast();
  const queryClient = useQueryClient();

  const createEventMutation = useCreateEvent({
    mutation: {
      onSuccess: () => {
        toast({ title: "Event submitted for approval", className: "bg-success text-success-foreground" });
        queryClient.invalidateQueries({ queryKey: getGetEventsQueryKey() });
        setView("list");
        setEvtForm({ title: "", account: "", brand: "", date: "", startTime: "18:00", endTime: "21:00", notes: "", posItems: [], staffRequested: 1 });
      }
    }
  });
  
  const cancelEventMutation = useCancelEvent({
    mutation: {
      onSuccess: () => {
        toast({ title: "Event cancelled" });
        queryClient.invalidateQueries({ queryKey: getGetEventsQueryKey() });
      }
    }
  });

  const [evtForm, setEvtForm] = useState({
    title: "", account: "", brand: "", date: "", startTime: "18:00", endTime: "21:00", notes: "", posItems: [] as string[], staffRequested: 1
  });
  const [searchAccount, setSearchAccount] = useState("");

  const { data: customerData } = useGetCustomers(
    { repUsername: user?.username },
    { query: { enabled: !!user?.username } }
  );
  const customers = (customerData || []).map(c => c.name);
  const allBrands = Object.values(BRANDS_BY_ITEM).flat();

  const handleSubmit = () => {
    if (!evtForm.title || !evtForm.account || !evtForm.date) return;
    createEventMutation.mutate({ data: evtForm });
  };

  if (view === "new") {
    return (
      <FadeIn className="max-w-2xl mx-auto">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Book Promo Event</h2>
          <Button variant="ghost" onClick={() => setView("list")}>← Back</Button>
        </div>

        <Card>
          <CardContent className="space-y-5 p-6">
            <div>
              <Label>Event Title</Label>
              <Input value={evtForm.title} onChange={e => setEvtForm({...evtForm, title: e.target.value})} placeholder="e.g. Fiddlehead Tap Takeover" />
            </div>

            <div>
              <Label>Account</Label>
              <Input 
                value={searchAccount} 
                onChange={e => { setSearchAccount(e.target.value); setEvtForm({...evtForm, account: ""}); }} 
                placeholder="Search account..." 
                className="mb-2"
              />
              {searchAccount && !evtForm.account && (
                <div className="max-h-32 overflow-y-auto border border-border rounded bg-surface divide-y divide-border">
                  {customers.filter(c => c.toLowerCase().includes(searchAccount.toLowerCase())).map(c => (
                    <div key={c} className="p-2 text-sm cursor-pointer hover:bg-surface2" onClick={() => { setEvtForm({...evtForm, account: c}); setSearchAccount(c); }}>
                      {c}
                    </div>
                  ))}
                </div>
              )}
              {evtForm.account && <div className="text-xs text-success font-bold mt-1">✓ {evtForm.account}</div>}
            </div>

            <div>
              <Label>Featured Brand</Label>
              <Select value={evtForm.brand} onChange={e => setEvtForm({...evtForm, brand: e.target.value})}>
                <option value="">Select brand...</option>
                {allBrands.map(b => <option key={b} value={b}>{b}</option>)}
              </Select>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <Label>Date</Label>
                <Input type="date" value={evtForm.date} onChange={e => setEvtForm({...evtForm, date: e.target.value})} />
              </div>
              <div>
                <Label>Start Time</Label>
                <Input type="time" value={evtForm.startTime} onChange={e => setEvtForm({...evtForm, startTime: e.target.value})} />
              </div>
              <div>
                <Label>End Time</Label>
                <Input type="time" value={evtForm.endTime} onChange={e => setEvtForm({...evtForm, endTime: e.target.value})} />
              </div>
            </div>

            <div>
              <Label>Promo Staff Needed</Label>
              <div className="flex gap-2">
                {[1,2,3,4].map(n => (
                  <Button key={n} variant={evtForm.staffRequested === n ? "primary" : "outline"} onClick={() => setEvtForm({...evtForm, staffRequested: n})}>
                    {n}
                  </Button>
                ))}
              </div>
            </div>

            <div>
              <Label>POS Materials Needed</Label>
              <div className="flex flex-wrap gap-2">
                {ITEM_TYPES.map(t => {
                  const sel = evtForm.posItems.includes(t);
                  return (
                    <Badge 
                      key={t} 
                      variant={sel ? "tint" : "outline"} 
                      color={ITEM_COLORS[t] || "#888"}
                      className="cursor-pointer px-2 py-1.5"
                      onClick={() => setEvtForm({...evtForm, posItems: sel ? evtForm.posItems.filter(x => x !== t) : [...evtForm.posItems, t]})}
                    >
                      {ITEM_ICONS[t]} {t}
                    </Badge>
                  )
                })}
              </div>
            </div>

            <div>
              <Label>Notes for Marketing</Label>
              <Textarea value={evtForm.notes || ""} onChange={e => setEvtForm({...evtForm, notes: e.target.value})} placeholder="Special requirements..." />
            </div>

            <Button className="w-full h-14" onClick={handleSubmit} disabled={!evtForm.title || !evtForm.account || !evtForm.date || createEventMutation.isPending}>
              Submit For Approval
            </Button>
          </CardContent>
        </Card>
      </FadeIn>
    );
  }

  return (
    <FadeIn>
      <div className="flex justify-between items-center mb-6">
        <div>
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Events & Promos</h2>
        </div>
        <Button onClick={() => setView("new")}>+ Book Event</Button>
      </div>

      <div className="grid grid-cols-1 gap-4">
        {events?.map(evt => {
          let statusColor = "var(--color-border)";
          if (evt.status === "approved") statusColor = "var(--color-primary)";
          if (evt.status === "cancelled") statusColor = "var(--color-destructive)";
          
          return (
            <Card key={evt.id} style={{ borderLeftColor: statusColor, borderLeftWidth: '4px' }}>
              <CardContent className="p-5 flex flex-col md:flex-row justify-between gap-4">
                <div>
                  <div className="flex items-center gap-3 mb-2">
                    <h3 className="text-lg font-bold">{evt.title}</h3>
                    <Badge variant="tint" color={statusColor}>{evt.status}</Badge>
                  </div>
                  <div className="text-muted-foreground text-sm font-bold">{evt.account}</div>
                  <div className="text-muted-foreground text-xs mt-1">
                    {formatDate(evt.date)} • {evt.startTime} - {evt.endTime} {evt.brand ? `• ${evt.brand}` : ''}
                  </div>
                </div>
                <div className="text-xs text-muted-foreground text-right space-y-1">
                  <div>Staff: <span className={evt.staffAssigned.length >= evt.staffRequested ? 'text-success font-bold' : 'text-warning font-bold'}>{evt.staffAssigned.length}/{evt.staffRequested}</span></div>
                  <div>POS: {evt.posItems.length === 0 ? "None" : evt.posApproved ? <span className="text-success font-bold">✓ Approved</span> : <span className="text-warning">Pending</span>}</div>
                </div>
              </CardContent>
            </Card>
          )
        })}
        {(!events || events.length === 0) && (
          <Card className="bg-surface2/50 border-dashed">
            <CardContent className="p-16 text-center text-muted-foreground text-xs uppercase tracking-widest">
              No events booked
            </CardContent>
          </Card>
        )}
      </div>
    </FadeIn>
  );
}
