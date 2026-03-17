import { readFileSync } from "fs";
import { join } from "path";
import { fileURLToPath } from "url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const XLSX = await import("xlsx");

const filePath = "/home/runner/workspace/attached_assets/Customers_TDUBUQUE_20260317_0848490331926_1773758938130.xlsx";
const buf = readFileSync(filePath);
const wb = XLSX.read(buf, { type: "buffer" });
const rows: any[] = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]], { defval: "" });

const statusCounts: Record<string, number> = {};
rows.forEach((r: any) => { statusCounts[r["Account Status"]] = (statusCounts[r["Account Status"]] || 0) + 1; });
console.log("Status counts:", JSON.stringify(statusCounts));

const active = rows.filter((r: any) => r["Account Status"] === "Active");
console.log("Active accounts:", active.length);

const inactive = rows.filter((r: any) => r["Account Status"] !== "Active");
console.log("Non-active:", inactive.length);
if (inactive.length) {
  console.log("Sample inactive:", inactive.slice(0, 5).map((r: any) => `${r["Customer Name"]} [${r["Account Status"]}]`));
}

const reps = [...new Set(active.map((r: any) => r["Salesman"] as string))].sort();
console.log("\nUnique reps (" + reps.length + "):", reps.join(", "));
