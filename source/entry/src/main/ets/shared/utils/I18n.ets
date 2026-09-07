type LocaleMap = Record<string, string>;

const enMap: LocaleMap = {
  "app_name": "GOVI",
  "app_name_full": "GOVI - Expense Manager",
  "balance_title": "Balance this month",
  "income": "Income",
  "expense": "Expense",
  "refresh": "Refresh",
  "empty_title": "No transactions yet",
  "empty_hint": "Tap + to add your first expense",
  "delete": "Delete",
  "back": "Back",
  "add_expense": "Add expense",
  "add_income": "Add income",
  "expense_label": "Expense",
  "income_label": "Income",
  "amount": "Amount",
  "category": "Category",
  "note_hint": "Note (optional)",
  "saving": "Saving...",
  "save": "Save transaction",
  "month_label": "Month",
  "cat_food": "Food",
  "cat_transport": "Transport",
  "cat_shopping": "Shopping",
  "cat_housing": "Housing",
  "cat_entertainment": "Entertainment",
  "cat_salary": "Salary",
  "cat_bonus": "Bonus",
  "cat_other": "Other",
  "currency_vnd": "VND",
  "error_amount": "Amount must be greater than 0",
  "error_category": "Please select a category"
};

const viMap: LocaleMap = {
  "app_name": "GOVI",
  "app_name_full": "GOVI - Quan ly thu chi",
  "balance_title": "So du thang nay",
  "income": "Thu",
  "expense": "Chi",
  "refresh": "Lam moi",
  "empty_title": "Chua co giao dich",
  "empty_hint": "Nhan + de them chi tieu dau tien",
  "delete": "Xoa",
  "back": "Quay lai",
  "add_expense": "Them chi tieu",
  "add_income": "Them thu nhap",
  "expense_label": "Chi tieu",
  "income_label": "Thu nhap",
  "amount": "So tien",
  "category": "Danh muc",
  "note_hint": "Ghi chu (tuy chon)",
  "saving": "Dang luu...",
  "save": "Luu giao dich",
  "month_label": "Thang",
  "cat_food": "An uong",
  "cat_transport": "Di chuyen",
  "cat_shopping": "Mua sam",
  "cat_housing": "Nha cua",
  "cat_entertainment": "Giai tri",
  "cat_salary": "Luong",
  "cat_bonus": "Thuong",
  "cat_other": "Khac",
  "currency_vnd": "VND",
  "error_amount": "So tien phai lon hon 0",
  "error_category": "Vui long chon danh muc"
};

const zhMap: LocaleMap = {
  "app_name": "GOVI",
  "app_name_full": "GOVI - \u679C\u7EF4\u8BB0\u8D26",
  "balance_title": "\u672C\u6708\u4F59\u989D",
  "income": "\u6536\u5165",
  "expense": "\u652F\u51FA",
  "refresh": "\u5237\u65B0",
  "empty_title": "\u6682\u65E0\u4EA4\u6613",
  "empty_hint": "\u70B9\u51FB + \u6DFB\u52A0\u7B2C\u4E00\u7B14\u652F\u51FA",
  "delete": "\u5220\u9664",
  "back": "\u8FD4\u56DE",
  "add_expense": "\u6DFB\u52A0\u652F\u51FA",
  "add_income": "\u6DFB\u52A0\u6536\u5165",
  "expense_label": "\u652F\u51FA",
  "income_label": "\u6536\u5165",
  "amount": "\u91D1\u989D",
  "category": "\u5206\u7C7B",
  "note_hint": "\u5907\u6CE8\uFF08\u53EF\u9009\uFF09",
  "saving": "\u4FDD\u5B58\u4E2D...",
  "save": "\u4FDD\u5B58\u4EA4\u6613",
  "month_label": "\u6708",
  "cat_food": "\u9910\u996E",
  "cat_transport": "\u4EA4\u901A",
  "cat_shopping": "\u8D2D\u7269",
  "cat_housing": "\u4F4F\u623F",
  "cat_entertainment": "\u5A31\u4E50",
  "cat_salary": "\u5DE5\u8D44",
  "cat_bonus": "\u5956\u91D1",
  "cat_other": "\u5176\u4ED6",
  "currency_vnd": "VND",
  "error_amount": "\u91D1\u989D\u5FC5\u987B\u5927\u4E8E0",
  "error_category": "\u8BF7\u9009\u62E9\u5206\u7C7B"
};

const locales: Record<string, LocaleMap> = {
  "vi": viMap,
  "en": enMap,
  "zh-CN": zhMap,
  "zh_CN": zhMap
};

let currentLocale: string = "en";

export function setLocale(locale: string): void {
  if (locales[locale]) {
    currentLocale = locale;
  } else if (locale.startsWith("en")) {
    currentLocale = "en";
  } else if (locale.startsWith("zh")) {
    currentLocale = "zh-CN";
  } else if (locale.startsWith("vi")) {
    currentLocale = "vi";
  } else {
    currentLocale = "en";
  }
}

export function getLocale(): string {
  return currentLocale;
}

export function t(key: string): string {
  const map: LocaleMap | undefined = locales[currentLocale];
  if (map && map[key]) {
    return map[key];
  }
  return enMap[key] ?? key;
}

export function getString(key: string): string {
  return t(key);
}

export function r(key: string): Resource {
  const value: string = t(key.replace("app.string.", ""));
  return value as Object as Resource;
}