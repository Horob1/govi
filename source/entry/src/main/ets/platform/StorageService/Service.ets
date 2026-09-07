import { hilog } from "@kit.PerformanceAnalysisKit";

// Ponytail: pure in-memory to keep build green without UIAbility context wiring.
// Real implementation would use: import preferences from "@ohos.data.preferences" + injected context.
// Upgrade: inject context from EntryAbility via AppStorage or constructor.

const memoryStore: Record<string, string> = {};

export class StorageService {
  static async set(key: string, value: string): Promise<void> {
    try {
      memoryStore[key] = value;
    } catch (e: Error) {
      hilog.error(0x0000, "GOVI", "Storage set error %{public}s", JSON.stringify(e));
    }
  }

  static async get(key: string, def: string = ""): Promise<string> {
    try {
      const v: string | undefined = memoryStore[key];
      return v ?? def;
    } catch (e: Error) {
      return def;
    }
  }

  static async remove(key: string): Promise<void> {
    try {
      delete memoryStore[key];
    } catch (e: Error) {
    }
  }
}

export class SecureStorageService {
  static async storeSecure(key: string, data: string): Promise<void> {
    await StorageService.set("sec_" + key, data);
  }

  static async retrieveSecure(key: string): Promise<string> {
    return await StorageService.get("sec_" + key, "");
  }
}