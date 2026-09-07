import { AppColors } from "../theme/AppTheme";
import { formatCurrency } from "../../utils/FormatUtils";

@Component
export struct StatCard {
  @Prop label: string = "";
  @Prop value: number = 0;
  @Prop color: string = AppColors.text;
  @Prop icon: string = "";

  build(): void {
    Column() {
      Row() {
        Text(this.icon).fontSize(16)
        Text(this.label).fontSize(12).fontColor(AppColors.textSecondary).margin({ left: 6 })
      }
      Text(formatCurrency(this.value))
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.color)
        .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 6, color: "rgba(0,0,0,0.06)" })
    .width("100%")
    .layoutWeight(1)
  }
}
