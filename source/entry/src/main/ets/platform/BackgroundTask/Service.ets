import { hilog } from "@kit.PerformanceAnalysisKit";
export class BackgroundTaskService {
  static async schedule(taskName:string,delayMs:number=60000):Promise<void>{ hilog.info(0x0000,"GOVI","Schedule %{public}s delay %{public}d",taskName,delayMs); }
  static async cancel(taskName:string):Promise<void>{ hilog.info(0x0000,"GOVI","Cancel %{public}s",taskName); }
}
