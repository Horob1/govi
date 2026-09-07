import { hilog } from "@kit.PerformanceAnalysisKit";
export class PushService {
  static async register():Promise<string>{ hilog.info(0x0000,"GOVI","Push register - HMS Push Kit / FCM bridge"); return "mock_push_token_"+Date.now(); }
  static onReceive(_message:object):void{ hilog.info(0x0000,"GOVI","Push received"); }
}
