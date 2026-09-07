import router from "@ohos.router";
import { AppColors } from "../shared/ui/theme/AppTheme";
import { AppHeader } from "../shared/ui/components/AppHeader";
import { StatCard } from "../shared/ui/components/StatCard";
import { TransactionCard } from "../shared/ui/components/TransactionCard";
import { appStore, AppStore } from "../shared/state/AppStore";
import { Transaction } from "../shared/domain/model/Transaction";
import { formatCurrency } from "../shared/utils/FormatUtils";
import { monthLabel } from "../shared/utils/DateUtils";
import { t } from "../shared/utils/I18n";

@Entry
@Component
struct Index {
  @State currentMonth: string = appStore.currentMonth;
  @State income: number = 0;
  @State expense: number = 0;
  @State txList: Transaction[] = [];

  aboutToAppear(): void {
    this.refresh();
  }

  private async refresh(): Promise<void> {
    await appStore.load();
    this.currentMonth = appStore.currentMonth;
    this.income = appStore.income;
    this.expense = appStore.expense;
    this.txList = appStore.transactions;
  }

  build(): void {
    Column() {
      AppHeader({ title: t("app_name"), subtitle: monthLabel(this.currentMonth) })

      Column() {
        Text(t("balance_title")).fontSize(13).fontColor("rgba(255,255,255,0.9)")
        Text(formatCurrency(this.getBalance())).fontSize(26).fontWeight(FontWeight.Bold).fontColor(Color.White).margin({ top: 4 })
        Row() {
          StatCard({ label: t("income"), value: this.income, color: AppColors.success, icon: "+" })
          Blank().width(12)
          StatCard({ label: t("expense"), value: this.expense, color: AppColors.danger, icon: "-" })
        }.width("92%").margin({ top: 12 })
      }
      .width("100%")
      .padding({ left: 16, right: 16, bottom: 16, top: 8 })
      .backgroundColor(AppColors.primary)

      Row() {
        Text("<").fontSize(20).fontColor(AppColors.primary).padding(8).onClick((): void => { this.shiftMonth(-1); })
        Text(monthLabel(this.currentMonth)).fontSize(14).fontWeight(FontWeight.Medium).layoutWeight(1).textAlign(TextAlign.Center)
        Text(">").fontSize(20).fontColor(AppColors.primary).padding(8).onClick((): void => { this.shiftMonth(1); })
        Text(t("refresh")).fontSize(12).fontColor(AppColors.primary).margin({ left: 8 }).onClick((): void => { this.refresh(); })
      }.width("92%").padding({ top: 10, bottom: 6 })

      if (this.txList.length === 0) {
        Column() {
          Text(t("empty_title")).fontSize(14).fontColor(AppColors.textSecondary).margin({ top: 24 })
          Text(t("empty_hint")).fontSize(12).fontColor(AppColors.textSecondary).margin({ top: 4 })
        }.width("100%").margin({ top: 20 })
      } else {
        List({ space: 0 }) {
          ForEach(this.txList, (tx: Transaction): void => {
            ListItem() {
              TransactionCard({ tx: tx, onDelete: (id: string): void => { this.deleteTx(id); } })
            }
          }, (tx: Transaction): string => tx.id)
        }
        .width("92%")
        .layoutWeight(1)
        .margin({ top: 4 })
        .scrollBar(BarState.Off)
      }

      Row() {
        Blank()
        Text("+")
          .fontSize(28)
          .fontColor(Color.White)
          .width(56)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.primary)
          .borderRadius(28)
          .shadow({ radius: 8, color: "rgba(0,0,0,0.2)" })
          .onClick((): void => { router.pushUrl({ url: "shared/ui/pages/AddTransactionPage" }); })
          .margin({ right: 16, bottom: 16 })
      }.width("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppColors.background)
  }

  private getBalance(): number {
    return this.income - this.expense;
  }

  private shiftMonth(delta: number): void {
    const parts: string[] = this.currentMonth.split("-");
    const y: number = parseInt(parts[0], 10);
    const m: number = parseInt(parts[1], 10);
    const d: Date = new Date(y, m - 1 + delta, 1);
    const mm: string = (d.getMonth() + 1).toString().padStart(2, "0");
    const next: string = d.getFullYear().toString() + "-" + mm;
    appStore.setMonth(next);
    this.refresh();
  }

  private async deleteTx(id: string): Promise<void> {
    await appStore.removeTx(id);
    await this.refresh();
  }
}
