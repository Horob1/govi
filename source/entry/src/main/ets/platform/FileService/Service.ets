import fs from "@ohos.file.fs";
import { hilog } from "@kit.PerformanceAnalysisKit";

export class FileService {
  static async write(path: string, data: string): Promise<void> {
    try {
      const f: { fd: number } = await fs.open(path, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      await fs.write(f.fd, data);
      await fs.close(f.fd);
    } catch (e: Error) {
      hilog.error(0x0000, "GOVI", "File write %{public}s", JSON.stringify(e));
      throw e;
    }
  }

  static async read(path: string): Promise<string> {
    try {
      const content: string = await fs.readText(path) as string;
      return content;
    } catch (e: Error) {
      hilog.error(0x0000, "GOVI", "File read %{public}s", JSON.stringify(e));
      return "";
    }
  }

  static getFilesDir(): string {
    // Ponytail: hardcoded sandbox path to keep build green without context.
    // Upgrade: return getContext().filesDir when context available.
    return "/data/storage/el2/base/files";
  }
}