import http from "@ohos.net.http";
export class NetworkService {
  static async get(url:string):Promise<string>{
    return new Promise((resolve,reject)=>{
      const req=http.createHttp();
      req.request(url,{method:http.RequestMethod.GET},(err,data)=>{ req.destroy(); if(err) reject(err); else resolve(data.result as string); });
    });
  }
  static async post(url:string,body:string):Promise<string>{
    return new Promise((resolve,reject)=>{
      const req=http.createHttp();
      req.request(url,{method:http.RequestMethod.POST, extraData:body, header:{"Content-Type":"application/json"}},(err,data)=>{ req.destroy(); if(err) reject(err); else resolve(data.result as string); });
    });
  }
}
