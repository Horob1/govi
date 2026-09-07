export class Budget {
  id: string = "";
  categoryId: string = "";
  limit: number = 0;
  spent: number = 0;
  month: string = "";

  constructor(id: string, categoryId: string, limit: number, spent: number, month: string) {
    this.id = id;
    this.categoryId = categoryId;
    this.limit = limit;
    this.spent = spent;
    this.month = month;
  }
}
