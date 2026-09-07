import router from "@ohos.router";
import { TransactionType } from "../../domain/model/Transaction";
import { DEFAULT_CATEGORIES, CategoryType } from "../../domain/model/Category";
import { transactionUseCase } from "../../domain/usecase/TransactionUseCase";
import { AppColors } from "../theme/AppTheme";
import { AnalyticsService } from "../../../platform/AnalyticsService/Service";
import { t } from "../../utils/I18n";
import { Category } from "../../domain/model/Category";

interface AddTransactionEventParams {
  amount: number;
  type: TransactionType;
}

@Entry
@Component
struct AddTransactionPage {
  @State amountText: string = "";
  @State note: string = "";
  @State selectedCatId: string = "c1";
  @State txType: TransactionType = TransactionType.EXPENSE;
  @State isSaving: boolean = false;

  build(): void {
    Column() {
      Row() {
        Text(t("back")).fontSize(14).fontColor(AppColors.primary).onClick((): void => { router.back(); })
        Blank()
        Text(this.txType === TransactionType.EXPENSE ? t("add_expense") : t("add_income")).fontSize(16).fontWeight(FontWeight.Bold)
        Blank()
        Text(" ").width(60)
      }.width("100%").padding(12).backgroundColor(Color.White)

      Row() {
        Text(t("expense_label"))
          .fontColor(this.txType === TransactionType.EXPENSE ? Color.White : AppColors.text)
          .backgroundColor(this.txType === TransactionType.EXPENSE ? AppColors.danger : Color.White)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(20)
          .onClick((): void => { this.txType = TransactionType.EXPENSE; this.selectedCatId = "c1"; })
        Text(t("income_label"))
          .fontColor(this.txType === TransactionType.INCOME ? Color.White : AppColors.text)
          .backgroundColor(this.txType === TransactionType.INCOME ? AppColors.success : Color.White)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(20)
          .margin({ left: 8 })
          .onClick((): void => { this.txType = TransactionType.INCOME; this.selectedCatId = "c6"; })
      }.margin({ top: 12 })

      Column() {
        Text(t("amount")).fontSize(12).fontColor(AppColors.textSecondary)
        Row() {
          TextInput({ placeholder: "0", text: this.amountText })
            .type(InputType.Number)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width("70%")
            .backgroundColor(Color.Transparent)
            .onChange((v: string): void => { this.amountText = v; })
          Text(t("currency_vnd")).fontSize(14).fontColor(AppColors.textSecondary).margin({ left: 8 })
        }.width("100%").justifyContent(FlexAlign.Center)
      }
      .width("92%")
      .padding(16)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ top: 12 })

      Text(t("category")).fontSize(13).fontColor(AppColors.textSecondary).width("92%").margin({ top: 12 }).textAlign(TextAlign.Start)
      Grid() {
        ForEach(this.getFilteredCategories(), (cat: Category): void => {
          GridItem() {
            Column() {
              Text(cat.icon).fontSize(20)
              Text(cat.getName()).fontSize(11).margin({ top: 4 }).fontColor(this.selectedCatId === cat.id ? AppColors.primary : AppColors.text)
            }
            .padding(8)
            .backgroundColor(this.selectedCatId === cat.id ? AppColors.primary + "14" : Color.White)
            .border({ width: 1, color: this.selectedCatId === cat.id ? AppColors.primary : "#EFEFEF", radius: 10 })
            .onClick((): void => { this.selectedCatId = cat.id; })
          }
        }, (cat: Category): string => cat.id)
      }.columnsTemplate("1fr 1fr 1fr 1fr").rowsGap(8).columnsGap(8).width("92%").margin({ top: 8 })

      TextInput({ placeholder: t("note_hint"), text: this.note })
        .width("92%")
        .height(42)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .margin({ top: 12 })
        .onChange((v: string): void => { this.note = v; })

      Blank()

      Button(this.isSaving ? t("saving") : t("save"))
        .width("92%")
        .height(48)
        .backgroundColor(AppColors.primary)
        .fontColor(Color.White)
        .borderRadius(12)
        .margin({ bottom: 24 })
        .enabled(!this.isSaving)
        .onClick((): void => { this.save(); })
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppColors.background)
  }

  private getFilteredCategories(): Category[] {
    return DEFAULT_CATEGORIES.filter((c: Category) => {
      if (this.txType === TransactionType.EXPENSE) {
        return c.type === CategoryType.EXPENSE;
      }
      return c.type === CategoryType.INCOME;
    });
  }

  private async save(): Promise<void> {
    let digits: string = "";
    let i: number = 0;
    for (i = 0; i < this.amountText.length; i++) {
      const ch: string = this.amountText.charAt(i);
      if (ch >= "0" && ch <= "9") {
        digits += ch;
      }
    }
    if (digits.length === 0) {
      return;
    }
    const amount: number = parseInt(digits, 10);
    if (amount <= 0) {
      return;
    }
    this.isSaving = true;
    try {
      await transactionUseCase.add(amount, this.selectedCatId, this.note, this.txType, Date.now());
      const evt: AddTransactionEventParams = { amount: amount, type: this.txType };
      AnalyticsService.trackEvent("add_transaction", evt);
      router.back();
    } finally {
      this.isSaving = false;
    }
  }
}