export function formatDate(ts: number): string {
  const d: Date = new Date(ts);
  const day: string = d.getDate().toString().padStart(2, "0");
  const month: string = (d.getMonth() + 1).toString().padStart(2, "0");
  const year: string = d.getFullYear().toString();
  return day + "/" + month + "/" + year;
}

export function formatMonth(ts: number): string {
  const d: Date = new Date(ts);
  const m: string = (d.getMonth() + 1).toString().padStart(2, "0");
  return d.getFullYear().toString() + "-" + m;
}

export function isSameMonth(a: number, b: number): boolean {
  return formatMonth(a) === formatMonth(b);
}

export function monthLabel(yyyyMm: string): string {
  const parts: string[] = yyyyMm.split("-");
  return parts[1] + "/" + parts[0];
}
