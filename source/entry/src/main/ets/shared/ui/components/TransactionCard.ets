import { Transaction, TransactionType } from "../../domain/model/Transaction";
import { Category, DEFAULT_CATEGORIES } from "../../domain/model/Category";
import { AppColors } from "../theme/AppTheme";
import { formatCurrency } from "../../utils/FormatUtils";
import { formatDate } from "../../utils/DateUtils";

@Component
export struct TransactionCard {
  @Prop tx: Transaction = new Transaction("", 0, "c8", "", 0, TransactionType.EXPENSE, 0);
  @Prop onDelete: (id: string) => void = (id: string): void => {};

  private getCategory(): Category {
    let i: number = 0;
    for (i = 0; i < DEFAULT_CATEGORIES.length; i++) {
      if (DEFAULT_CATEGORIES[i].id === this.tx.categoryId) {
        return DEFAULT_CATEGORIES[i];
      }
    }
    return DEFAULT_CATEGORIES[DEFAULT_CATEGORIES.length - 1];
  }

  build(): void {
    Row() {
      Text(this.getCategory().icon)
        .fontSize(22)
        .width(42)
        .height(42)
        .textAlign(TextAlign.Center)
        .backgroundColor(this.getCategory().color + "22")
        .borderRadius(10)
        .padding(6)
      Column() {
        Text(this.getCategory().getName())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.text)
        Text(this.tx.note.length > 0 ? this.tx.note : formatDate(this.tx.date))
          .fontSize(12)
          .fontColor(AppColors.textSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text((this.tx.type === TransactionType.INCOME ? "+" : "-") + formatCurrency(this.tx.amount))
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tx.type === TransactionType.INCOME ? AppColors.success : AppColors.danger)
        Text(formatDate(this.tx.date))
          .fontSize(11)
          .fontColor(AppColors.textSecondary)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width("100%")
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ bottom: 8 })
    .shadow({ radius: 4, color: "rgba(0,0,0,0.05)" })
  }
}
