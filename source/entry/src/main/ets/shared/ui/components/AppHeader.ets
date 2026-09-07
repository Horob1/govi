import { AppColors } from "../theme/AppTheme";
import { t } from "../../utils/I18n";

@Component
export struct AppHeader {
  @Prop title: string = "";
  @Prop subtitle: string = "";

  build(): void {
    Column() {
      Text(this.title.length > 0 ? this.title : t("app_name"))
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
      if (this.subtitle.length > 0) {
        Text(this.subtitle)
          .fontSize(13)
          .fontColor("rgba(255,255,255,0.85)")
          .margin({ top: 2 })
      }
    }
    .width("100%")
    .padding({ left: 16, right: 16, top: 14, bottom: 14 })
    .backgroundColor(AppColors.primary)
  }
}
