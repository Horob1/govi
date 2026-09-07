import geoLocationManager from "@ohos.geoLocationManager";
export interface Location { latitude:number; longitude:number }
export class LocationService {
  static async getCurrentLocation():Promise<Location>{
    return new Promise((resolve,reject)=>{
      try{ geoLocationManager.getCurrentLocation({requestPriority:geoLocationManager.LocationRequestPriority.FIRST_FIX},(err,loc)=>{ if(err) reject(err); else resolve({latitude:loc.latitude, longitude:loc.longitude});}); }catch(e){reject(e);}
    });
  }
}
