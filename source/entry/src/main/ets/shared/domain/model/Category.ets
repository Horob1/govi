import { t } from "../../utils/I18n";

export enum CategoryType {
  EXPENSE = 0,
  INCOME = 1
}

export class Category {
  id: string = "";
  nameKey: string = "";
  icon: string = "";
  color: string = "";
  type: CategoryType = CategoryType.EXPENSE;

  constructor(id: string, nameKey: string, icon: string, color: string, type: CategoryType) {
    this.id = id;
    this.nameKey = nameKey;
    this.icon = icon;
    this.color = color;
    this.type = type;
  }

  getName(): string {
    return t(this.nameKey);
  }
}

export const DEFAULT_CATEGORIES: Category[] = [
  new Category("c1", "cat_food", "\u{1F35C}", "#FF6B6B", CategoryType.EXPENSE),
  new Category("c2", "cat_transport", "\u{1F695}", "#4ECDC4", CategoryType.EXPENSE),
  new Category("c3", "cat_shopping", "\u{1F6CD}", "#FFD166", CategoryType.EXPENSE),
  new Category("c4", "cat_housing", "\u{1F3E0}", "#06D6A0", CategoryType.EXPENSE),
  new Category("c5", "cat_entertainment", "\u{1F3AE}", "#9B59B6", CategoryType.EXPENSE),
  new Category("c6", "cat_salary", "\u{1F4BC}", "#2ECC71", CategoryType.INCOME),
  new Category("c7", "cat_bonus", "\u{1F381}", "#3498DB", CategoryType.INCOME),
  new Category("c8", "cat_other", "\u{1F4E6}", "#95A5A6", CategoryType.EXPENSE)
];
