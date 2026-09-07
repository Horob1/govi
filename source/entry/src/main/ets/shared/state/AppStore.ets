import { Transaction } from "../domain/model/Transaction";
import { MonthlySummary, transactionUseCase } from "../domain/usecase/TransactionUseCase";
import { formatMonth } from "../utils/DateUtils";

@Observed
export class AppStore {
  transactions: Transaction[] = [];
  currentMonth: string = formatMonth(Date.now());
  income: number = 0;
  expense: number = 0;
  isLoading: boolean = false;

  getBalance(): number {
    return this.income - this.expense;
  }

  async load(): Promise<void> {
    this.isLoading = true;
    try {
      const s: MonthlySummary =
        await transactionUseCase.monthlySummary(this.currentMonth);
      this.transactions = s.list;
      this.income = s.income;
      this.expense = s.expense;
    } finally {
      this.isLoading = false;
    }
  }

  async refresh(): Promise<void> {
    await this.load();
  }

  setMonth(m: string): void {
    this.currentMonth = m;
    this.load();
  }

  async removeTx(id: string): Promise<void> {
    await transactionUseCase.remove(id);
    await this.load();
  }
}

export const appStore: AppStore = new AppStore();
