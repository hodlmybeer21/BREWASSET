import { useState, useEffect } from "react";
import { useLocation } from "wouter";
import { useLogin, useGetMe, useStaffLogin, useGetPromoStaff } from "@workspace/api-client-react";
import { Card, Button, Input, Select, FadeIn } from "@/components/ui/core";
import { Hexagon, Warehouse, Users, CalendarDays, Star, Loader2, Eye, EyeOff, X } from "lucide-react";
import { ALL_REPS, REP_DISPLAY_NAMES } from "@/lib/constants";
import { useToast } from "@/hooks/use-toast";

type ActivePanel = "rep" | "warehouse" | "marketing" | "staff" | null;

export default function Login() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [selectedRep, setSelectedRep] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [activePanel, setActivePanel] = useState<ActivePanel>(null);

  const { data: user, isLoading } = useGetMe();

  const { data: promoStaff } = useGetPromoStaff();
  const [selectedStaff, setSelectedStaff] = useState("");

  useEffect(() => {
    if (user) {
      if (user.role === "warehouse") setLocation("/warehouse");
      else if (user.role === "marketing") setLocation("/marketing");
      else if (user.role === "staff") setLocation("/staff");
      else setLocation("/rep");
    }
  }, [user, setLocation]);

  const loginMutation = useLogin({
    mutation: {
      onSuccess: (data) => {
        if (data.user.role === "warehouse") setLocation("/warehouse");
        else if (data.user.role === "marketing") setLocation("/marketing");
        else if (data.user.role === "staff") setLocation("/staff");
        else setLocation("/rep");
      },
      onError: () => {
        toast({
          title: "Login Failed",
          description: "Incorrect password. Please try again.",
          variant: "destructive"
        });
        setPassword("");
      }
    }
  });

  const staffLoginMutation = useStaffLogin({
    mutation: {
      onSuccess: () => setLocation("/staff"),
      onError: () => {
        toast({ title: "Login Failed", description: "Incorrect password. Please try again.", variant: "destructive" });
        setPassword("");
      }
    }
  });

  const handleSubmit = (username: string) => {
    if (!password) return;
    loginMutation.mutate({ data: { username, password } });
  };

  const openPanel = (panel: ActivePanel) => {
    setActivePanel(panel);
    setPassword("");
    setShowPassword(false);
  };

  const closePanel = () => {
    setActivePanel(null);
    setPassword("");
    setShowPassword(false);
    setSelectedRep("");
    setSelectedStaff("");
  };

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="w-8 h-8 text-primary animate-spin" />
      </div>
    );
  }

  const PasswordField = ({ onSubmit }: { onSubmit: () => void }) => (
    <div className="relative">
      <Input
        type={showPassword ? "text" : "password"}
        placeholder="Enter your password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        onKeyDown={(e) => e.key === "Enter" && password && onSubmit()}
        className="h-12 pr-10 bg-background/50"
        autoFocus
      />
      <button
        type="button"
        className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
        onClick={() => setShowPassword(v => !v)}
      >
        {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
      </button>
    </div>
  );

  return (
    <div className="min-h-screen flex items-center justify-center relative overflow-hidden bg-background">
      <div className="absolute inset-0 z-0">
        <img
          src={`${import.meta.env.BASE_URL}images/login-bg.png`}
          alt="Brewery Warehouse"
          className="w-full h-full object-cover opacity-30"
          onError={(e) => {
            e.currentTarget.src = "https://images.unsplash.com/photo-1588685121404-325b9e0787e9?q=80&w=2000&auto=format&fit=crop";
          }}
        />
        <div className="absolute inset-0 bg-gradient-to-t from-background via-background/80 to-background/40" />
      </div>

      <FadeIn className="relative z-10 w-full max-w-md p-6">
        <div className="text-center mb-8">
          <Hexagon className="w-16 h-16 mx-auto text-primary mb-4" />
          <h1 className="text-3xl font-bold tracking-[0.2em] text-primary uppercase mb-2">BrewAsset</h1>
          <p className="text-xs text-muted-foreground tracking-[0.3em] uppercase">POS Room Inventory System</p>
        </div>

        <Card className="p-8 backdrop-blur-md bg-surface/80 border-primary/20 shadow-2xl">
          <div className="space-y-5">

            {/* Warehouse */}
            {activePanel === "warehouse" ? (
              <div className="space-y-3 p-4 rounded-lg border border-primary/30 bg-primary/5">
                <div className="flex items-center justify-between mb-1">
                  <div className="flex items-center gap-2 text-primary">
                    <Warehouse className="w-4 h-4" />
                    <span className="text-xs font-bold tracking-widest uppercase">Warehouse Staff</span>
                  </div>
                  <button onClick={closePanel} className="text-muted-foreground hover:text-foreground">
                    <X className="w-4 h-4" />
                  </button>
                </div>
                <PasswordField onSubmit={() => handleSubmit("warehouse")} />
                <Button
                  className="w-full h-11 text-sm"
                  onClick={() => handleSubmit("warehouse")}
                  disabled={!password || loginMutation.isPending}
                >
                  {loginMutation.isPending ? <Loader2 className="w-4 h-4 animate-spin" /> : "Sign In"}
                </Button>
              </div>
            ) : (
              <Button
                className="w-full h-14 text-sm"
                onClick={() => openPanel("warehouse")}
                disabled={loginMutation.isPending}
              >
                <Warehouse className="w-5 h-5 mr-3 opacity-70" />
                Warehouse Staff Login
              </Button>
            )}

            {/* Rep */}
            {activePanel === "rep" ? (
              <div className="space-y-3 p-4 rounded-lg border border-primary/30 bg-primary/5">
                <div className="flex items-center justify-between mb-1">
                  <div className="flex items-center gap-2 text-primary">
                    <Users className="w-4 h-4" />
                    <span className="text-xs font-bold tracking-widest uppercase">Sales Rep</span>
                  </div>
                  <button onClick={closePanel} className="text-muted-foreground hover:text-foreground">
                    <X className="w-4 h-4" />
                  </button>
                </div>
                <Select
                  value={selectedRep}
                  onChange={(e) => { setSelectedRep(e.target.value); setPassword(""); }}
                  className="h-11 bg-background/50"
                >
                  <option value="">Select your name...</option>
                  {[...ALL_REPS]
                    .sort((a, b) => (REP_DISPLAY_NAMES[a] || a).localeCompare(REP_DISPLAY_NAMES[b] || b))
                    .map(rep => (
                      <option key={rep} value={rep}>{REP_DISPLAY_NAMES[rep] || rep}</option>
                    ))}
                </Select>
                {selectedRep && (
                  <PasswordField onSubmit={() => handleSubmit(selectedRep)} />
                )}
                <Button
                  className="w-full h-11 text-sm"
                  onClick={() => handleSubmit(selectedRep)}
                  disabled={!selectedRep || !password || loginMutation.isPending}
                >
                  {loginMutation.isPending ? <Loader2 className="w-4 h-4 animate-spin" /> : "Sign In"}
                </Button>
              </div>
            ) : (
              <Button
                className="w-full h-14 text-sm"
                onClick={() => openPanel("rep")}
                disabled={loginMutation.isPending}
              >
                <Users className="w-5 h-5 mr-3 opacity-70" />
                Sales Rep Login
              </Button>
            )}

            {/* Promo Staff */}
            {activePanel === "staff" ? (
              <div className="space-y-3 p-4 rounded-lg border border-purple-500/30 bg-purple-500/5">
                <div className="flex items-center justify-between mb-1">
                  <div className="flex items-center gap-2 text-purple-400">
                    <Star className="w-4 h-4" />
                    <span className="text-xs font-bold tracking-widest uppercase">Promo Staff</span>
                  </div>
                  <button onClick={closePanel} className="text-muted-foreground hover:text-foreground">
                    <X className="w-4 h-4" />
                  </button>
                </div>
                <Select
                  value={selectedStaff}
                  onChange={(e) => setSelectedStaff(e.target.value)}
                  className="h-11 bg-background/50"
                >
                  <option value="">Select your name...</option>
                  {promoStaff?.map((s: any) => (
                    <option key={s.id} value={s.name}>{s.name}</option>
                  ))}
                </Select>
                <PasswordField onSubmit={() => selectedStaff && staffLoginMutation.mutate({ data: { staffName: selectedStaff, password } })} />
                <Button
                  className="w-full h-11 text-sm bg-purple-600 hover:bg-purple-700 text-white border-0"
                  onClick={() => staffLoginMutation.mutate({ data: { staffName: selectedStaff, password } })}
                  disabled={!selectedStaff || !password || staffLoginMutation.isPending}
                >
                  {staffLoginMutation.isPending ? <Loader2 className="w-4 h-4 animate-spin" /> : "Sign In"}
                </Button>
              </div>
            ) : (
              <Button
                variant="secondary"
                className="w-full h-12 text-purple-400 border-purple-500/20 bg-purple-500/5 hover:bg-purple-500/10"
                onClick={() => openPanel("staff")}
                disabled={loginMutation.isPending}
              >
                <Star className="w-4 h-4 mr-3 opacity-70" />
                Promo Staff Login
              </Button>
            )}

            {/* Marketing */}
            {activePanel === "marketing" ? (
              <div className="space-y-3 p-4 rounded-lg border border-[#60a0e8]/30 bg-[#60a0e8]/5">
                <div className="flex items-center justify-between mb-1">
                  <div className="flex items-center gap-2 text-[#60a0e8]">
                    <CalendarDays className="w-4 h-4" />
                    <span className="text-xs font-bold tracking-widest uppercase">Marketing Manager</span>
                  </div>
                  <button onClick={closePanel} className="text-muted-foreground hover:text-foreground">
                    <X className="w-4 h-4" />
                  </button>
                </div>
                <PasswordField onSubmit={() => handleSubmit("marketing")} />
                <Button
                  variant="secondary"
                  className="w-full h-11 text-[#60a0e8] border-[#60a0e8]/20 bg-[#60a0e8]/5 hover:bg-[#60a0e8]/10"
                  onClick={() => handleSubmit("marketing")}
                  disabled={!password || loginMutation.isPending}
                >
                  {loginMutation.isPending ? <Loader2 className="w-4 h-4 animate-spin" /> : "Sign In"}
                </Button>
              </div>
            ) : (
              <Button
                variant="secondary"
                className="w-full h-12 text-[#60a0e8] border-[#60a0e8]/20 bg-[#60a0e8]/5 hover:bg-[#60a0e8]/10"
                onClick={() => openPanel("marketing")}
                disabled={loginMutation.isPending}
              >
                <CalendarDays className="w-4 h-4 mr-3 opacity-70" />
                Marketing Manager
              </Button>
            )}

          </div>
        </Card>
      </FadeIn>
    </div>
  );
}
