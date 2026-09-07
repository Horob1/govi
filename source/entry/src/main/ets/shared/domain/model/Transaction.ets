export enum TransactionType {
  EXPENSE = 0,
  INCOME = 1
}

export class Transaction {
  id: string = "";
  amount: number = 0;
  categoryId: string = "c8";
  note: string = "";
  date: number = 0;
  type: TransactionType = TransactionType.EXPENSE;
  createdAt: number = 0;

  constructor(id: string, amount: number, categoryId: string, note: string, date: number, txType: TransactionType, createdAt: number) {
    this.id = id;
    this.amount = amount;
    this.categoryId = categoryId;
    this.note = note;
    this.date = date;
    this.type = txType;
    this.createdAt = createdAt;
  }
}

export function newTransactionId(): string {
  return "tx_" + Date.now().toString() + "_" + Math.floor(Math.random() * 10000).toString();
}
