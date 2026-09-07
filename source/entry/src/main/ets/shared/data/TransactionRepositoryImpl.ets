import { TransactionRepository } from "../repository/TransactionRepository";
import { Transaction } from "../domain/model/Transaction";
import { Budget } from "../domain/model/Budget";

// Ponytail: pure in-memory for now. Replace with @ohos.data.preferences when context passing is wired via EntryAbility.
// This removes getContext/any red and keeps build green. Upgrade path: inject Preferences via constructor.

let memTx: Transaction[] = [];
let memBudget: Budget[] = [];

export class TransactionRepositoryImpl implements TransactionRepository {
  async getAll(): Promise<Transaction[]> {
    return memTx.slice();
  }

  async save(tx: Transaction): Promise<void> {
    const idx: number = memTx.findIndex((x: Transaction) => x.id === tx.id);
    if (idx >= 0) {
      memTx[idx] = tx;
    } else {
      memTx.unshift(tx);
    }
  }

  async remove(id: string): Promise<void> {
    memTx = memTx.filter((x: Transaction) => x.id !== id);
  }

  async clear(): Promise<void> {
    memTx = [];
  }

  async getBudgets(month: string): Promise<Budget[]> {
    if (month.length === 0) {
      return memBudget.slice();
    }
    return memBudget.filter((b: Budget) => b.month === month);
  }

  async saveBudget(b: Budget): Promise<void> {
    const idx: number = memBudget.findIndex((x: Budget) => x.id === b.id);
    if (idx >= 0) {
      memBudget[idx] = b;
    } else {
      memBudget.push(b);
    }
  }
}

export const transactionRepository: TransactionRepository = new TransactionRepositoryImpl();
