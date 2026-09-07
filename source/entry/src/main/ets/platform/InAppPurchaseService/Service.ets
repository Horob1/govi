export interface PurchaseResult { productId:string; success:boolean; orderId?:string }
export class InAppPurchaseService {
  static async purchase(productId:string):Promise<PurchaseResult>{ return { productId, success:true, orderId:"order_"+Date.now()}; }
  static async restorePurchases():Promise<PurchaseResult[]>{ return []; }
}
