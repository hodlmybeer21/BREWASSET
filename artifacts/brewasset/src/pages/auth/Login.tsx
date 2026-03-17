import { useState, useEffect } from "react";
import { useLocation } from "wouter";
import { useLogin, useGetMe } from "@workspace/api-client-react";
import { Card, Button, Input, Select, FadeIn } from "@/components/ui/core";
import { Hexagon, Warehouse, Users, CalendarDays, Loader2 } from "lucide-react";
import { ALL_REPS } from "@/lib/constants";
import { useToast } from "@/hooks/use-toast";

export default function Login() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [selectedRep, setSelectedRep] = useState("");
  
  const { data: user, isLoading } = useGetMe();

  useEffect(() => {
    if (user) {
      if (user.role === "warehouse") setLocation("/warehouse");
      else if (user.role === "marketing") setLocation("/marketing");
      else setLocation("/rep");
    }
  }, [user, setLocation]);

  const loginMutation = useLogin({
    mutation: {
      onSuccess: (data) => {
        if (data.user.role === "warehouse") setLocation("/warehouse");
        else if (data.user.role === "marketing") setLocation("/marketing");
        else setLocation("/rep");
      },
      onError: (err: any) => {
        toast({
          title: "Login Failed",
          description: (err?.data as any)?.error || "Invalid credentials",
          variant: "destructive"
        });
      }
    }
  });

  const handleLogin = (role: string, username: string) => {
    let password = "brewasset2026";
    if (role === "warehouse") password = "warehouse123";
    if (role === "marketing") password = "marketing123";
    loginMutation.mutate({ data: { username, password } });
  };

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="w-8 h-8 text-primary animate-spin" />
      </div>
    );
  }

  return (
    <div className="min-h-screen flex items-center justify-center relative overflow-hidden bg-background">
      {/* Background Image with Dark Wash */}
      <div className="absolute inset-0 z-0">
        {/* landing page hero scenic industrial brewery warehouse */}
        <img 
          src={`${import.meta.env.BASE_URL}images/login-bg.png`}
          alt="Brewery Warehouse"
          className="w-full h-full object-cover opacity-30"
          onError={(e) => {
            // Fallback to Unsplash if AI image fails to load
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
          <div className="space-y-6">
            <Button 
              className="w-full h-14 text-sm" 
              onClick={() => handleLogin("warehouse", "warehouse")}
              disabled={loginMutation.isPending}
            >
              <Warehouse className="w-5 h-5 mr-3 opacity-70" />
              Warehouse Staff Login
            </Button>

            <div className="relative">
              <div className="absolute inset-0 flex items-center">
                <span className="w-full border-t border-border" />
              </div>
              <div className="relative flex justify-center text-[10px] uppercase tracking-widest">
                <span className="bg-surface px-2 text-muted-foreground">Or log in as rep</span>
              </div>
            </div>

            <div className="space-y-3">
              <Select 
                value={selectedRep} 
                onChange={(e) => setSelectedRep(e.target.value)}
                className="h-12 bg-background/50"
              >
                <option value="">Select your name...</option>
                {ALL_REPS.map(rep => (
                  <option key={rep} value={rep}>{rep}</option>
                ))}
              </Select>
              <Button 
                variant="outline"
                className="w-full h-12" 
                disabled={!selectedRep || loginMutation.isPending}
                onClick={() => handleLogin("rep", selectedRep)}
              >
                <Users className="w-4 h-4 mr-3 opacity-70" />
                Rep Login
              </Button>
            </div>

            <div className="relative">
              <div className="absolute inset-0 flex items-center">
                <span className="w-full border-t border-border" />
              </div>
            </div>

            <Button 
              variant="secondary"
              className="w-full h-12 text-[#60a0e8] border-[#60a0e8]/20 bg-[#60a0e8]/5 hover:bg-[#60a0e8]/10" 
              onClick={() => handleLogin("marketing", "marketing")}
              disabled={loginMutation.isPending}
            >
              <CalendarDays className="w-4 h-4 mr-3 opacity-70" />
              Marketing Manager
            </Button>
          </div>
        </Card>
      </FadeIn>
    </div>
  );
}
