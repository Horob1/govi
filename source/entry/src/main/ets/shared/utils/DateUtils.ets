export function formatDate(ts: number): string {
  const d: Date = new Date(ts);
  const day: string = d.getDate().toString().padStart(2, "0");
  const month: string = (d.getMonth() + 1).toString().padStart(2, "0");
  const year: string = d.getFullYear().toString();
  return day + "/" + month + "/" + year;
}

// dayjs cross lib (ohpm dayjs ^1.11.13) - optional, for complex timezone/duration needs.
// Native Date handles simple cases above without extra dep. Use this when spec 3.5 requires timezone/recurring.
// import dayjs from "dayjs"; // uncomment when needed: dayjs(ts).format("DD/MM/YYYY")
export function formatDateDayjs(ts: number): string {
  // keep native fallback to avoid mandatory dayjs import in strong mode preview
  // when dayjs needed: return dayjs(ts).format("DD/MM/YYYY");
  return formatDate(ts);
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
