import { Transaction } from "../domain/model/Transaction";
import { Budget } from "../domain/model/Budget";

export interface TransactionRepository {
  getAll(): Promise<Transaction[]>;
  save(tx: Transaction): Promise<void>;
  remove(id: string): Promise<void>;
  clear(): Promise<void>;
  getBudgets(month: string): Promise<Budget[]>;
  saveBudget(b: Budget): Promise<void>;
}
