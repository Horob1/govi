import { SVGImageView } from '@ohos/svg';

/**
 * Cross-platform SVG icon.
 * ArkTS Image cannot render full SVG 1.1 (gradients, masks) on HarmonyOS native - this wraps @ohos/svg (cross, ArkTS pure).
 * No BridgePlugin needed - works on HarmonyOS + ArkUI-X Android/iOS (pure ArkTS).
 * For system icons, prefer SymbolGlyph (4000+ HarmonyOS symbols, no install). Use SvgIcon for custom SVG assets in rawfile.
 */
@Component
export struct SvgIcon {
  @Prop svgName: string = "";
  @Prop width: number = 24;
  @Prop height: number = 24;

  private model: SVGImageView.SVGImageViewModel = new SVGImageView.SVGImageViewModel();

  aboutToAppear(): void {
    if (this.svgName.length > 0) {
      // rawfile assets: entry/src/main/resources/rawfile/*.svg
      this.model.setImageRawfile(this.svgName);
    }
  }

  build(): void {
    SVGImageView({ model: this.model })
      .width(this.width)
      .height(this.height)
  }
}
