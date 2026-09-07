import abilityAccessCtrl from "@ohos.abilityAccessCtrl";
import { hilog } from "@kit.PerformanceAnalysisKit";

export class PermissionService {
  static async request(permissions: string[]): Promise<boolean[]> {
    try {
      // Ponytail: preview build returns false to stay green without Context.
      // Real: import common from "@ohos.app.ability.common"; common.getContext() as Context
      hilog.info(0x0000, "GOVI", "Permission request fallback for: %{public}s", permissions.join(","));
      return permissions.map((): boolean => false);
    } catch (e: Error) {
      hilog.warn(0x0000, "GOVI", "Permission req %{public}s", JSON.stringify(e));
      return permissions.map((): boolean => false);
    }
  }

  static async check(permission: string): Promise<boolean> {
    try {
      const at: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
      const r: number = await at.checkAccessToken(0, permission);
      return r === 0;
    } catch (e: Error) {
      return false;
    }
  }
}