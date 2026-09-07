export class Account {
  id: string = "default";
  name: string = "main";
  balance: number = 0;
  currency: string = "VND";
  icon: string = "";

  constructor(id: string, name: string, balance: number, currency: string, icon: string) {
    this.id = id;
    this.name = name;
    this.balance = balance;
    this.currency = currency;
    this.icon = icon;
  }
}
