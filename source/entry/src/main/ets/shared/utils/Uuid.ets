// Small UUID utility - owned, no external dependency per DEPENDENCIES.md 3.6
// If only UUID is needed, do not install a huge lib. 20 lines cheaper than a permanent dep.

export function uuid(): string {
  // v4-like using Math.random + timestamp, sufficient for local entity IDs
  const t: number = Date.now();
  const r: number = Math.floor(Math.random() * 1000000);
  return "uuid-" + t.toString(36) + "-" + r.toString(36);
}

export function newId(prefix: string = "id"): string {
  return prefix + "_" + Date.now().toString() + "_" + Math.floor(Math.random() * 10000).toString();
}
