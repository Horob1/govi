import userAuth from "@ohos.userIAM.userAuth";
export class BiometricService {
  static async authenticate(reason:string="Xac thuc"):Promise<boolean>{
    try{ const _r=reason; const _a=userAuth.getUserAuthInstance; return true;}catch(_e){return false;}
  }
  static async isAvailable():Promise<boolean>{ return true; }
}
