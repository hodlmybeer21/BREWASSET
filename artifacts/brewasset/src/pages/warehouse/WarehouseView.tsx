import { useState } from "react";
import { AppLayout } from "@/components/layout/AppLayout";
import { FadeIn, Card, CardHeader, CardContent, Badge, Button, Input, Select, Label } from "@/components/ui/core";
import { 
  useGetInventory, useReceiveStock, useGetReceiveHistory, useGetRequests, useFulfillRequest, useCancelRequest, useGetCatalogItems, useCreateCatalogItem, useDeleteCatalogItem, useAddBrand, useDeleteBrand, getGetInventoryQueryKey, getGetReceiveHistoryQueryKey, getGetRequestsQueryKey, getGetCatalogItemsQueryKey 
} from "@workspace/api-client-react";
import { ITEM_TYPES, ITEM_ICONS, ITEM_COLORS } from "@/lib/constants";
import { useToast } from "@/hooks/use-toast";
import { useQueryClient } from "@tanstack/react-query";
import { Package, History, CheckSquare, PlusSquare, Search, Box } from "lucide-react";
import { formatDate } from "@/lib/utils";

export default function WarehouseView() {
  const [tab, setTab] = useState("inventory");
  const { data: requests } = useGetRequests();
  const pendingCount = requests?.filter(r => r.status === "Pending").length || 0;
  
  const navItems = [
    { id: "inventory", label: "Inventory", icon: <Package className="w-4 h-4" /> },
    { id: "receive", label: "Receive Stock", icon: <PlusSquare className="w-4 h-4" /> },
    { id: "requests", label: `Requests ${pendingCount > 0 ? `(${pendingCount})` : ''}`, icon: <CheckSquare className="w-4 h-4" /> },
    { id: "history", label: "History", icon: <History className="w-4 h-4" /> },
    { id: "catalog", label: "Catalog", icon: <Box className="w-4 h-4" /> },
  ];

  return (
    <AppLayout navItems={navItems} currentTab={tab} onTabChange={setTab}>
      {tab === "inventory" && <InventoryTab />}
      {tab === "receive" && <ReceiveTab />}
      {tab === "requests" && <RequestsTab />}
      {tab === "history" && <HistoryTab />}
      {tab === "catalog" && <CatalogTab />}
    </AppLayout>
  );
}

function InventoryTab() {
  const { data: inventory } = useGetInventory();
  const { data: requests } = useGetRequests();
  const [filterType, setFilterType] = useState<string>("All");
  const [search, setSearch] = useState("");

  const pendingRequests = requests?.filter(r => r.status === "Pending") || [];
  
  const items = inventory || [];
  const types = [...new Set(items.map(i => i.itemType))];

  const filteredItems = items
    .filter(i => filterType === "All" || i.itemType === filterType)
    .filter(i => !search || i.brand.toLowerCase().includes(search.toLowerCase()) || i.itemType.toLowerCase().includes(search.toLowerCase()))
    .sort((a, b) => b.quantity - a.quantity);

  return (
    <FadeIn>
      <div className="mb-6">
        <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Inventory Overview</h2>
        <p className="text-xs text-muted-foreground tracking-widest mt-1 uppercase">{items.filter(i => i.quantity > 0).length} SKUs in stock</p>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3 mb-6">
        <div 
          onClick={() => setFilterType("All")}
          className={`p-4 rounded-lg border cursor-pointer transition-all ${filterType === "All" ? "bg-primary/10 border-primary" : "bg-surface border-border hover:border-muted-foreground"}`}
        >
          <div className="text-xl mb-1">📦</div>
          <div className="text-[10px] text-muted-foreground uppercase tracking-widest">All Items</div>
          <div className="text-2xl font-bold mt-1">{items.reduce((sum, i) => sum + i.quantity, 0)}</div>
        </div>
        {types.map(t => {
          const count = items.filter(i => i.itemType === t).reduce((s, i) => s + i.quantity, 0);
          const color = ITEM_COLORS[t] || "#888";
          const isSelected = filterType === t;
          return (
            <div 
              key={t}
              onClick={() => setFilterType(t)}
              className={`p-4 rounded-lg border cursor-pointer transition-all`}
              style={{
                backgroundColor: isSelected ? `${color}15` : '',
                borderColor: isSelected ? color : '',
              }}
            >
              <div className="text-xl mb-1">{ITEM_ICONS[t] || "📦"}</div>
              <div className="text-[10px] text-muted-foreground uppercase tracking-widest truncate" title={t}>{t}</div>
              <div className="text-2xl font-bold mt-1" style={{ color }}>{count}</div>
            </div>
          );
        })}
      </div>

      <div className="mb-4">
        <div className="relative max-w-md">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input 
            placeholder="Search brand or item type..." 
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="pl-10"
          />
        </div>
      </div>

      <Card>
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-border bg-surface2 text-[10px] tracking-widest text-muted-foreground uppercase">
                <th className="px-4 py-3 font-semibold">Item Type</th>
                <th className="px-4 py-3 font-semibold">Brand</th>
                <th className="px-4 py-3 font-semibold">In Stock</th>
                <th className="px-4 py-3 font-semibold">Pending Requests</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border/50">
              {filteredItems.length === 0 ? (
                <tr>
                  <td colSpan={4} className="px-4 py-8 text-center text-muted-foreground text-xs uppercase tracking-widest">
                    No items found
                  </td>
                </tr>
              ) : (
                filteredItems.map(row => {
                  const color = ITEM_COLORS[row.itemType] || "#888";
                  const pendingCount = pendingRequests.filter(r => r.itemType === row.itemType && r.brand === row.brand).reduce((s, r) => s + r.quantity, 0);
                  
                  return (
                    <tr key={row.id} className="hover:bg-surface2/50 transition-colors">
                      <td className="px-4 py-3">
                        <Badge variant="tint" color={color}>
                          <span className="mr-1.5">{ITEM_ICONS[row.itemType] || "📦"}</span>
                          {row.itemType}
                        </Badge>
                      </td>
                      <td className="px-4 py-3 font-bold">{row.brand}</td>
                      <td className="px-4 py-3">
                        <span className={`text-lg font-bold ${row.quantity === 0 ? 'text-muted-foreground' : row.quantity < 5 ? 'text-destructive' : 'text-success'}`}>
                          {row.quantity}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-xs">
                        {pendingCount > 0 ? (
                          <span className="text-warning font-bold">{pendingCount} pending</span>
                        ) : (
                          <span className="text-muted-foreground">—</span>
                        )}
                      </td>
                    </tr>
                  )
                })
              )}
            </tbody>
          </table>
        </div>
      </Card>
    </FadeIn>
  );
}

function ReceiveTab() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const { data: catalog } = useGetCatalogItems();
  const { data: history } = useGetReceiveHistory();
  const receiveMutation = useReceiveStock({
    mutation: {
      onSuccess: () => {
        toast({ title: "Stock received successfully" });
        queryClient.invalidateQueries({ queryKey: getGetInventoryQueryKey() });
        queryClient.invalidateQueries({ queryKey: getGetReceiveHistoryQueryKey() });
        setQty(1);
      },
      onError: (err: any) => {
        toast({ title: "Failed to receive stock", description: err.error, variant: "destructive" });
      }
    }
  });

  const [itemType, setItemType] = useState("");
  const [brand, setBrand] = useState("");
  const [qty, setQty] = useState(1);

  const catalogItems = catalog || [];
  const selectedCatalogItem = catalogItems.find(c => c.name === itemType);
  const brands = selectedCatalogItem?.brands || [];

  const handleReceive = () => {
    if (!itemType || !brand || qty < 1) {
      toast({ title: "Please fill all fields", variant: "destructive" });
      return;
    }
    receiveMutation.mutate({ data: { itemType, brand, quantity: qty } });
  };

  return (
    <FadeIn className="grid grid-cols-1 md:grid-cols-2 gap-8">
      <div>
        <div className="mb-6">
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Receive Stock</h2>
          <p className="text-xs text-muted-foreground tracking-widest mt-1 uppercase">Log incoming deliveries</p>
        </div>

        <Card>
          <CardContent className="space-y-4">
            <div>
              <Label>Item Type</Label>
              <Select value={itemType} onChange={e => { setItemType(e.target.value); setBrand(""); }}>
                <option value="">Select item type...</option>
                {catalogItems.map(c => (
                  <option key={c.id} value={c.name}>{c.icon || "📦"} {c.name}</option>
                ))}
                {/* Fallback to static if catalog empty */}
                {catalogItems.length === 0 && ITEM_TYPES.map(t => (
                  <option key={t} value={t}>{ITEM_ICONS[t]} {t}</option>
                ))}
              </Select>
            </div>
            
            <div>
              <Label>Brand</Label>
              <Select value={brand} onChange={e => setBrand(e.target.value)} disabled={!itemType}>
                <option value="">Select brand...</option>
                {brands.map(b => <option key={b.id} value={b.name}>{b.name}</option>)}
                {/* Fallback */}
                {brands.length === 0 && itemType && (BRANDS_BY_ITEM[itemType] || []).map(b => (
                  <option key={b} value={b}>{b}</option>
                ))}
              </Select>
            </div>

            <div>
              <Label>Quantity</Label>
              <Input type="number" min={1} value={qty} onChange={e => setQty(parseInt(e.target.value) || 1)} />
            </div>

            <Button 
              className="w-full mt-4" 
              onClick={handleReceive}
              disabled={receiveMutation.isPending || !itemType || !brand}
            >
              {receiveMutation.isPending ? "Receiving..." : "✓ Receive Into Stock"}
            </Button>
          </CardContent>
        </Card>
      </div>

      <div>
        <div className="mb-6">
          <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Recent Activity</h2>
        </div>
        
        <Card>
          <div className="divide-y divide-border">
            {history?.slice(0, 8).map(h => {
              const color = ITEM_COLORS[h.itemType] || "#888";
              return (
                <div key={h.id} className="p-4 flex items-center justify-between hover:bg-surface2/50">
                  <div>
                    <div className="flex items-center gap-2 mb-1">
                      <span>{ITEM_ICONS[h.itemType] || "📦"}</span>
                      <span className="font-bold">{h.brand}</span>
                      <span className="text-[10px] text-muted-foreground uppercase">{h.itemType}</span>
                    </div>
                    <div className="text-[10px] text-muted-foreground">{formatDate(h.createdAt)}</div>
                  </div>
                  <div className="text-right">
                    <div className="text-lg font-bold text-success">+{h.quantity}</div>
                  </div>
                </div>
              );
            })}
            {(!history || history.length === 0) && (
              <div className="p-8 text-center text-xs text-muted-foreground tracking-widest uppercase">
                No recent receives
              </div>
            )}
          </div>
        </Card>
      </div>
    </FadeIn>
  );
}

function RequestsTab() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const { data: requests } = useGetRequests();
  
  const fulfillMutation = useFulfillRequest({
    mutation: {
      onSuccess: () => {
        toast({ title: "Request fulfilled", variant: "default", className: "bg-success text-success-foreground" });
        queryClient.invalidateQueries({ queryKey: getGetRequestsQueryKey() });
        queryClient.invalidateQueries({ queryKey: getGetInventoryQueryKey() });
      }
    }
  });

  const cancelMutation = useCancelRequest({
    mutation: {
      onSuccess: () => {
        toast({ title: "Request cancelled" });
        queryClient.invalidateQueries({ queryKey: getGetRequestsQueryKey() });
        queryClient.invalidateQueries({ queryKey: getGetInventoryQueryKey() });
      }
    }
  });

  const pending = requests?.filter(r => r.status === "Pending") || [];
  const fulfilled = requests?.filter(r => r.status !== "Pending") || [];

  return (
    <FadeIn>
      <div className="mb-6">
        <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Rep Requests</h2>
        <p className="text-xs text-muted-foreground tracking-widest mt-1 uppercase">{pending.length} Pending to load</p>
      </div>

      {pending.length > 0 && (
        <div className="mb-8 space-y-3">
          <h3 className="text-xs font-bold tracking-widest uppercase text-warning mb-4">⏳ Needs Action</h3>
          {pending.map(req => {
            const color = ITEM_COLORS[req.itemType] || "#888";
            return (
              <Card key={req.id} className="border-l-4 border-l-warning">
                <CardContent className="p-4 flex flex-col sm:flex-row gap-4 justify-between items-start sm:items-center">
                  <div>
                    <div className="flex items-center gap-2 mb-1 flex-wrap">
                      <span className="text-xl">{ITEM_ICONS[req.itemType] || "📦"}</span>
                      <span className="font-bold text-lg">{req.quantity}x {req.brand}</span>
                      <Badge variant="tint" color={color}>{req.itemType}</Badge>
                    </div>
                    <div className="text-xs text-muted-foreground mb-1">
                      <span className="text-primary font-bold">{req.repUsername}</span> → <span className="font-bold text-foreground">{req.customer}</span>
                    </div>
                    <div className="text-[10px] text-muted-foreground tracking-widest uppercase">{formatDate(req.createdAt)}</div>
                  </div>
                  <div className="flex gap-2 w-full sm:w-auto">
                    <Button 
                      variant="success" 
                      className="flex-1 sm:flex-none"
                      onClick={() => fulfillMutation.mutate({ id: req.id })}
                      disabled={fulfillMutation.isPending || cancelMutation.isPending}
                    >
                      ✓ Loaded
                    </Button>
                    <Button 
                      variant="danger" 
                      className="px-3"
                      onClick={() => cancelMutation.mutate({ id: req.id })}
                      disabled={fulfillMutation.isPending || cancelMutation.isPending}
                    >
                      ✕
                    </Button>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      )}

      {pending.length === 0 && (
        <Card className="mb-8 bg-surface2/50 border-dashed">
          <CardContent className="p-12 text-center text-muted-foreground uppercase tracking-widest text-xs">
            No pending requests
          </CardContent>
        </Card>
      )}

      {fulfilled.length > 0 && (
        <div>
          <h3 className="text-xs font-bold tracking-widest uppercase text-muted-foreground mb-4">Recent History</h3>
          <Card>
            <div className="divide-y divide-border">
              {fulfilled.slice(0, 10).map(req => (
                <div key={req.id} className="p-3 px-4 flex justify-between items-center text-sm hover:bg-surface2/50">
                  <div className="flex items-center gap-3">
                    <span>{ITEM_ICONS[req.itemType] || "📦"}</span>
                    <div>
                      <span className="font-bold mr-2">{req.quantity}x {req.brand}</span>
                      <span className="text-muted-foreground text-xs">{req.repUsername} → {req.customer}</span>
                    </div>
                  </div>
                  <Badge variant="tint" color={req.status === "Fulfilled" ? "#44cc88" : "#ff4d4d"}>
                    {req.status}
                  </Badge>
                </div>
              ))}
            </div>
          </Card>
        </div>
      )}
    </FadeIn>
  );
}

function HistoryTab() {
  const { data: history } = useGetReceiveHistory();

  return (
    <FadeIn>
      <div className="mb-6">
        <h2 className="text-xl font-bold tracking-widest uppercase text-foreground">Receive History</h2>
      </div>

      <Card>
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-border bg-surface2 text-[10px] tracking-widest text-muted-foreground uppercase">
                <th className="px-4 py-3 font-semibold">Date</th>
                <th className="px-4 py-3 font-semibold">Item Type</th>
                <th className="px-4 py-3 font-semibold">Brand</th>
                <th className="px-4 py-3 font-semibold text-right">Qty Received</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border/50">
              {history?.map(h => (
                <tr key={h.id} className="hover:bg-surface2/50 transition-colors">
                  <td className="px-4 py-3 text-xs text-muted-foreground">{formatDate(h.createdAt)}</td>
                  <td className="px-4 py-3">
                    <Badge variant="tint" color={ITEM_COLORS[h.itemType] || "#888"}>{h.itemType}</Badge>
                  </td>
                  <td className="px-4 py-3 font-bold">{h.brand}</td>
                  <td className="px-4 py-3 text-right">
                    <span className="text-lg font-bold text-success">+{h.quantity}</span>
                  </td>
                </tr>
              ))}
              {(!history || history.length === 0) && (
                <tr>
                  <td colSpan={4} className="px-4 py-8 text-center text-muted-foreground text-xs uppercase tracking-widest">
                    No history found
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

function CatalogTab() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const { data: catalog } = useGetCatalogItems();
  
  const createItemMutation = useCreateCatalogItem({
    mutation: {
      onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetCatalogItemsQueryKey() })
    }
  });
  const deleteItemMutation = useDeleteCatalogItem({
    mutation: {
      onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetCatalogItemsQueryKey() })
    }
  });
  const addBrandMutation = useAddBrand({
    mutation: {
      onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetCatalogItemsQueryKey() })
    }
  });
  const deleteBrandMutation = useDeleteBrand({
    mutation: {
      onSuccess: () => queryClient.invalidateQueries({ queryKey: getGetCatalogItemsQueryKey() })
    }
  });

  const [newItemName, setNewItemName] = useState("");
  const [newItemIcon, setNewItemIcon] = useState("📦");
  const [selectedItem, setSelectedItem] = useState<number | null>(null);
  const [newBrand, setNewBrand] = useState("");

  const items = catalog || [];
  const selectedObj = items.find(i => i.id === selectedItem);

  const handleAddItem = () => {
    if (!newItemName) return;
    createItemMutation.mutate({ data: { name: newItemName, icon: newItemIcon } });
    setNewItemName("");
  };

  const handleAddBrand = () => {
    if (!selectedItem || !newBrand) return;
    addBrandMutation.mutate({ data: { catalogItemId: selectedItem, name: newBrand } });
    setNewBrand("");
  };

  return (
    <FadeIn className="grid grid-cols-1 lg:grid-cols-2 gap-6">
      {/* Left: Items */}
      <div>
        <Card className="border-t-2 border-t-primary mb-6">
          <CardContent className="p-5">
            <h3 className="text-xs font-bold tracking-widest text-primary uppercase mb-4">+ New Item Type</h3>
            <div className="space-y-4">
              <div>
                <Label>Name</Label>
                <Input value={newItemName} onChange={e => setNewItemName(e.target.value)} placeholder="e.g. Koozie" />
              </div>
              <div>
                <Label>Icon Emoji</Label>
                <div className="flex gap-2">
                  <Input value={newItemIcon} onChange={e => setNewItemIcon(e.target.value)} className="w-16 text-center text-xl p-0" />
                  <div className="flex-1 flex gap-2 overflow-x-auto pb-2 scrollbar-none">
                    {["🍺","🥤","🎽","👒","🏷️","🪧","💡","🧊","📦"].map(em => (
                      <button key={em} onClick={() => setNewItemIcon(em)} className={`flex-shrink-0 w-10 h-10 rounded border text-xl flex items-center justify-center transition-colors ${newItemIcon === em ? 'bg-primary/20 border-primary' : 'bg-surface border-border hover:bg-surface2'}`}>
                        {em}
                      </button>
                    ))}
                  </div>
                </div>
              </div>
              <Button className="w-full" onClick={handleAddItem} disabled={!newItemName || createItemMutation.isPending}>Add Item Type</Button>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <h3 className="text-xs font-bold tracking-widest text-muted-foreground uppercase">Item Types</h3>
          </CardHeader>
          <div className="divide-y divide-border max-h-[500px] overflow-y-auto">
            {items.map(item => (
              <div 
                key={item.id} 
                onClick={() => setSelectedItem(item.id)}
                className={`p-3 px-4 flex items-center gap-3 cursor-pointer transition-colors ${selectedItem === item.id ? 'bg-primary/10 border-l-2 border-l-primary' : 'hover:bg-surface2 border-l-2 border-l-transparent'}`}
              >
                <span className="text-2xl">{item.icon || "📦"}</span>
                <div className="flex-1">
                  <div className="font-bold text-sm">{item.name}</div>
                  <div className="text-[10px] text-muted-foreground uppercase tracking-wider">{item.brands.length} brands</div>
                </div>
                {!item.isDefault && (
                  <button 
                    className="p-2 text-muted-foreground hover:text-destructive transition-colors"
                    onClick={(e) => { e.stopPropagation(); deleteItemMutation.mutate({ id: item.id }); }}
                  >
                    ✕
                  </button>
                )}
              </div>
            ))}
          </div>
        </Card>
      </div>

      {/* Right: Brands */}
      <div>
        {selectedObj ? (
          <FadeIn>
            <Card className="border-t-2 mb-6" style={{ borderTopColor: ITEM_COLORS[selectedObj.name] || '#e8a020' }}>
              <CardContent className="p-5">
                <div className="flex items-center gap-4 mb-6">
                  <span className="text-4xl">{selectedObj.icon || "📦"}</span>
                  <div>
                    <h2 className="text-xl font-bold tracking-widest uppercase">{selectedObj.name}</h2>
                    <p className="text-xs text-muted-foreground tracking-widest uppercase">{selectedObj.brands.length} Brands</p>
                  </div>
                </div>
                
                <h3 className="text-xs font-bold tracking-widest text-primary uppercase mb-3">+ Add Brand</h3>
                <div className="flex gap-2">
                  <Input value={newBrand} onChange={e => setNewBrand(e.target.value)} placeholder="Enter brand name..." onKeyDown={e => e.key === 'Enter' && handleAddBrand()} />
                  <Button onClick={handleAddBrand} disabled={!newBrand || addBrandMutation.isPending}>Add</Button>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <h3 className="text-xs font-bold tracking-widest text-muted-foreground uppercase">Brands for {selectedObj.name}</h3>
              </CardHeader>
              <div className="divide-y divide-border max-h-[400px] overflow-y-auto">
                {selectedObj.brands.map(brand => (
                  <div key={brand.id} className="p-3 px-5 flex justify-between items-center hover:bg-surface2 transition-colors">
                    <span className="font-bold text-sm">{brand.name}</span>
                    {!brand.isDefault && (
                      <button 
                        className="text-muted-foreground hover:text-destructive text-sm"
                        onClick={() => deleteBrandMutation.mutate({ id: brand.id })}
                      >
                        ✕
                      </button>
                    )}
                  </div>
                ))}
                {selectedObj.brands.length === 0 && (
                  <div className="p-8 text-center text-xs text-muted-foreground tracking-widest uppercase">No brands added yet</div>
                )}
              </div>
            </Card>
          </FadeIn>
        ) : (
          <Card className="h-full border-dashed bg-surface2/30 flex flex-col items-center justify-center p-12 text-center min-h-[300px]">
            <div className="text-4xl mb-4 text-muted-foreground">←</div>
            <h3 className="text-sm font-bold tracking-widest uppercase text-muted-foreground mb-2">Select an Item Type</h3>
            <p className="text-xs text-muted-foreground/60">Click any item type on the left to manage its brands</p>
          </Card>
        )}
      </div>
    </FadeIn>
  );
}
