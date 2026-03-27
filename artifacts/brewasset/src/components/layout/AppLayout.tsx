import { useLocation } from "wouter";
import { useGetMe, useLogout, getGetMeQueryKey } from "@workspace/api-client-react";
import { useQueryClient } from "@tanstack/react-query";
import { Button } from "@/components/ui/core";
import { Hexagon, LogOut, Loader2 } from "lucide-react";

interface AppLayoutProps {
  children: React.ReactNode;
  navItems: { id: string; label: string; icon?: React.ReactNode }[];
  currentTab: string;
  onTabChange: (id: string) => void;
}

export function AppLayout({ children, navItems, currentTab, onTabChange }: AppLayoutProps) {
  const [, setLocation] = useLocation();
  const queryClient = useQueryClient();
  const { data: user, isLoading } = useGetMe();
  const logoutMutation = useLogout({
    mutation: {
      onSuccess: () => {
        queryClient.setQueryData(getGetMeQueryKey(), null);
        queryClient.clear();
        setLocation("/");
      }
    }
  });

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="w-8 h-8 text-primary animate-spin" />
      </div>
    );
  }

  const roleLabels = {
    warehouse: "🏭 Warehouse Staff",
    rep: "👤 Sales Rep",
    marketing: "📅 Marketing Mgr"
  };

  return (
    <div className="min-h-screen bg-background flex flex-col text-foreground font-mono">
      {/* Top Header */}
      <header className="h-14 bg-surface border-b-2 border-b-primary px-4 sm:px-6 flex items-center justify-between sticky top-0 z-40 shadow-sm">
        <div className="flex items-center gap-6 sm:gap-10">
          <div className="flex items-center gap-2 text-primary font-bold tracking-[0.2em] uppercase">
            <Hexagon className="w-5 h-5 fill-primary/20" />
            <span className="hidden sm:inline">BrewAsset</span>
          </div>
          
          <nav className="hidden md:flex items-center gap-1">
            {navItems.map(item => (
              <button
                key={item.id}
                onClick={() => onTabChange(item.id)}
                className={`px-3 py-1.5 rounded text-xs font-bold tracking-wider uppercase transition-colors ${
                  currentTab === item.id 
                    ? "bg-primary/10 text-primary border border-primary/20" 
                    : "text-muted-foreground hover:text-foreground hover:bg-surface2 border border-transparent"
                }`}
              >
                <div className="flex items-center gap-2">
                  {item.icon}
                  {item.label}
                </div>
              </button>
            ))}
          </nav>
        </div>

        <div className="flex items-center gap-4">
          {user && (
            <div className="hidden sm:flex flex-col items-end">
              <span className="text-xs font-bold">{user.displayName || user.username}</span>
              <span className="text-[10px] text-muted-foreground tracking-widest uppercase">
                {roleLabels[user.role as keyof typeof roleLabels] || user.role}
              </span>
            </div>
          )}
          <Button 
            variant="ghost" 
            size="sm" 
            onClick={() => logoutMutation.mutate(undefined)}
            disabled={logoutMutation.isPending}
            className="text-muted-foreground hover:text-destructive"
          >
            <LogOut className="w-4 h-4 sm:mr-2" />
            <span className="hidden sm:inline">Sign Out</span>
          </Button>
        </div>
      </header>
      
      {/* Mobile Nav */}
      <div className="md:hidden flex overflow-x-auto bg-surface border-b border-border p-2 gap-2 scrollbar-none">
        {navItems.map(item => (
          <button
            key={item.id}
            onClick={() => onTabChange(item.id)}
            className={`whitespace-nowrap px-3 py-2 rounded text-[10px] font-bold tracking-wider uppercase transition-colors ${
              currentTab === item.id 
                ? "bg-primary/10 text-primary border border-primary/20" 
                : "text-muted-foreground bg-surface2 border border-transparent"
            }`}
          >
            {item.label}
          </button>
        ))}
      </div>

      {/* Main Content */}
      <main className="flex-1 w-full max-w-7xl mx-auto p-4 sm:p-6 lg:p-8">
        {children}
      </main>
    </div>
  );
}
