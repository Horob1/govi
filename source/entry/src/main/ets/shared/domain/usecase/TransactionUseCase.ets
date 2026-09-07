import { Transaction, TransactionType, newTransactionId } from "../model/Transaction";
import { transactionRepository } from "../../data/TransactionRepositoryImpl";
import { formatMonth } from "../../utils/DateUtils";
import { t } from "../../utils/I18n";

export interface MonthlySummary {
  income: number;
  expense: number;
  balance: number;
  list: Transaction[];
}

export class TransactionUseCase {
  async list(): Promise<Transaction[]> {
    return await transactionRepository.getAll();
  }

  async add(amount: number, categoryId: string, note: string, txType: TransactionType, date: number): Promise<Transaction> {
    if (amount <= 0) {
      throw new Error(t("error_amount"));
    }
    if (categoryId.length === 0) {
      throw new Error(t("error_category"));
    }
    const tx: Transaction = new Transaction(newTransactionId(), amount, categoryId, note, date, txType, Date.now());
    await transactionRepository.save(tx);
    return tx;
  }

  async remove(id: string): Promise<void> {
    await transactionRepository.remove(id);
  }

  async monthlySummary(month: string): Promise<MonthlySummary> {
    const all: Transaction[] = await transactionRepository.getAll();
    const list: Transaction[] = all.filter((tx: Transaction) => formatMonth(tx.date) === month);
    let income: number = 0;
    let expense: number = 0;
    let i: number = 0;
    for (i = 0; i < list.length; i++) {
      const tx: Transaction = list[i];
      if (tx.type === TransactionType.INCOME) {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }
    const result: MonthlySummary = {
      income: income,
      expense: expense,
      balance: income - expense,
      list: list
    };
    return result;
  }
}

export const transactionUseCase: TransactionUseCase = new TransactionUseCase();
