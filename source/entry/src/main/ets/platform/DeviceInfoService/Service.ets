import deviceInfo from "@ohos.deviceInfo";
import { hilog } from "@kit.PerformanceAnalysisKit";

export class DeviceInfoService {
  static getOSVersion(): string {
    try {
      return deviceInfo.osFullName;
    } catch (e: Error) {
      hilog.warn(0x0000, "GOVI", "getOSVersion fallback");
      return "HarmonyOS";
    }
  }

  static getDeviceModel(): string {
    try {
      return deviceInfo.marketName;
    } catch (e: Error) {
      return "Unknown";
    }
  }

  static getUUID(): string {
    try {
      const id: string = deviceInfo.odid;
      return id.length > 0 ? id : "uuid-" + Date.now().toString();
    } catch (e: Error) {
      return "uuid-" + Date.now().toString();
    }
  }
}