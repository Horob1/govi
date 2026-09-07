export interface ValidationResult {
  valid: boolean;
  message: string;
}

export class Validation {
  static required(value: string, fieldName: string): ValidationResult {
    if (value.trim().length === 0) {
      return { valid: false, message: fieldName + " is required" };
    }
    return { valid: true, message: "" };
  }

  static positiveAmount(value: string): ValidationResult {
    const digits: string = value.replace(/[^0-9]/g, "");
    if (digits.length === 0) {
      return { valid: false, message: "Amount is required" };
    }
    const n: number = parseInt(digits, 10);
    if (n <= 0) {
      return { valid: false, message: "Amount must be greater than 0" };
    }
    return { valid: true, message: "" };
  }

  static amount(value: number): ValidationResult {
    if (value <= 0) {
      return { valid: false, message: "Amount must be greater than 0" };
    }
    return { valid: true, message: "" };
  }

  static category(categoryId: string): ValidationResult {
    if (categoryId.length === 0) {
      return { valid: false, message: "Please select a category" };
    }
    return { valid: true, message: "" };
  }

  static combine(...results: ValidationResult[]): ValidationResult {
    for (let i: number = 0; i < results.length; i++) {
      if (!results[i].valid) {
        return results[i];
      }
    }
    return { valid: true, message: "" };
  }
}
