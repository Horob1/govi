import { hilog } from "@kit.PerformanceAnalysisKit";
export class AnalyticsService {
  static trackEvent(name:string,params?:object):void{ hilog.info(0x0000,"GOVI-Analytics","%{public}s %{public}s",name,JSON.stringify(params??{})); }
  static trackError(err:string):void{ hilog.error(0x0000,"GOVI-Analytics","%{public}s",err); }
}
