export function formatCurrency(amount: number, currency: string = "VND"): string {
  // Use manual formatting to avoid Intl red in ArkTS strong mode preview
  let s: string = amount.toString();
  let result: string = "";
  let count: number = 0;
  let i: number = s.length - 1;
  for (i = s.length - 1; i >= 0; i--) {
    result = s.charAt(i) + result;
    count++;
    if (count % 3 === 0 && i !== 0) {
      result = "." + result;
    }
  }
  return result + " " + currency;
}

export function formatCompact(n: number): string {
  if (n >= 1000000000) {
    return (n / 1000000000).toFixed(1) + "B";
  }
  if (n >= 1000000) {
    return (n / 1000000).toFixed(1) + "M";
  }
  if (n >= 1000) {
    return (n / 1000).toFixed(1) + "K";
  }
  return n.toString();
}

export function parseAmount(input: string): number {
  let digits: string = "";
  let i: number = 0;
  for (i = 0; i < input.length; i++) {
    const c: string = input.charAt(i);
    if (c >= "0" && c <= "9") {
      digits += c;
    }
  }
  if (digits.length === 0) {
    return 0;
  }
  return parseInt(digits, 10);
}
