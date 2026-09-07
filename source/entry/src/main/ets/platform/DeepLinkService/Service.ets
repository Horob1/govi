import router from "@ohos.router";
export class DeepLinkService {
  static handle(url:string):void{
    try{ const u=new URL(url); const path=u.pathname; if(path.includes("transaction")) router.pushUrl({url:"pages/Index"}); else router.pushUrl({url:"pages/Index"});}catch(_e){ router.pushUrl({url:"pages/Index"});}
  }
}
