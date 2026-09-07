import router from "@ohos.router";

export const Routes = {
  HOME: `pages/Index`,
  ADD: `shared/ui/pages/AddTransactionPage`,
  STATS: `shared/ui/pages/StatsPage`,
} as const;

export function goHome(): void { router.pushUrl({ url: `pages/Index` }); }
export function goAdd(): void { router.pushUrl({ url: `shared/ui/pages/AddTransactionPage` }); }
export function goBack(): void { router.back(); }
