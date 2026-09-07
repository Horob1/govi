import { hilog } from "@kit.PerformanceAnalysisKit";
import notificationManager from "@ohos.notificationManager";

export interface NotificationOptions {
  title: string;
  text: string;
  id?: number;
}

export class NotificationService {
  static async send(opts: NotificationOptions): Promise<void> {
    try {
      const req: notificationManager.NotificationRequest = {
        id: opts.id ?? Math.floor(Math.random() * 100000),
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: { title: opts.title, text: opts.text }
        }
      };
      await notificationManager.publish(req);
    } catch (e: Error) {
      hilog.warn(0x0000, "GOVI", "Notification fallback: %{public}s", JSON.stringify(e));
    }
  }

  static async cancel(id: number): Promise<void> {
    try {
      await notificationManager.cancel(id);
    } catch (e: Error) {
    }
  }
}