import { hilog } from "@kit.PerformanceAnalysisKit";

const DOMAIN: number = 0x0001;
const TAG: string = "GOVI";

export class Logger {
  static debug(msg: string, ...args: Object[]): void {
    hilog.debug(DOMAIN, TAG, msg, ...args);
  }

  static info(msg: string, ...args: Object[]): void {
    hilog.info(DOMAIN, TAG, msg, ...args);
  }

  static warn(msg: string, ...args: Object[]): void {
    hilog.warn(DOMAIN, TAG, msg, ...args);
  }

  static error(msg: string, ...args: Object[]): void {
    hilog.error(DOMAIN, TAG, msg, ...args);
  }
}
