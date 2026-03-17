import { readFileSync, writeFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import { pool } from "@workspace/db";

const __dirname = dirname(fileURLToPath(import.meta.url));
const XLSX = await import("xlsx");

const XLSX_PATH = "/home/runner/workspace/attached_assets/Customers_TDUBUQUE_20260317_0848490331926_1773758938130.xlsx";

// Rep full name → username mapping (29 reps)
const FULL_NAME_TO_USERNAME: Record<string, string> = {
  "Alex Martin": "amartin",
  "Ben Germano": "bgermano",
  "Dustin Dooling": "ddooling",
  "Ethan Leahy": "eleahy",
  "Ethan Platt": "eplatt",
  "Gary Gage": "ggage",
  "Jack Malloy": "jmalloy",
  "Jason Cannamucio": "jcannamucio",
  "Jeff Austin": "jaustin",
  "Jerry Smoyer": "jsmoyer",
  "Jesse Johnson": "jjohnson",
  "Jim Morse": "jmorse",
  "Joe Caron": "jcaron",
  "Joe Giuffrida": "jgiuffrida",
  "John Sweeney": "jsweeney",
  "Jon Grumblatt": "jgrumblatt",
  "Josh Sewall": "jsewall",
  "Justin Meharg": "jmeharg",
  "Luis Ortiz": "lortiz",
  "Luke Norton": "lnorton",
  "Mark Anderson": "maanderson",
  "Nathan Moore": "nmoore",
  "Paul Belanger": "pbelanger",
  "Paul Wollert": "pwollert",
  "Richard Marique": "rmarique",
  "Ricky Constant": "rconstant",
  "Scott Camuso": "scamuso",
  "Steve Shaunessy": "sshaunessy",
  "Tyler Chagnon": "tchagnon",
};

// Parse the Excel
const buf = readFileSync(XLSX_PATH);
const wb = XLSX.read(buf, { type: "buffer" });
const rows: any[] = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]], { defval: "" });

// Build master account name set (exact casing from Excel)
const masterAccountNames = new Set<string>(rows.map((r: any) => (r["Customer Name"] as string).trim()));
console.log("Master list has", masterAccountNames.size, "unique account names");

// Build CUSTOMERS_BY_REP from the new file
const customersByRep: Record<string, string[]> = {};
for (const r of rows) {
  const fullName = (r["Salesman"] as string).trim();
  const username = FULL_NAME_TO_USERNAME[fullName];
  if (!username) {
    console.warn("  WARNING: Unknown rep full name:", fullName);
    continue;
  }
  if (!customersByRep[username]) customersByRep[username] = [];
  customersByRep[username].push((r["Customer Name"] as string).trim());
}

// Sort accounts within each rep
for (const username of Object.keys(customersByRep)) {
  customersByRep[username].sort();
}

console.log("\nCustomers per rep:");
let totalCustomers = 0;
for (const [username, accounts] of Object.entries(customersByRep).sort()) {
  console.log(`  ${username}: ${accounts.length} accounts`);
  totalCustomers += accounts.length;
}
console.log("  TOTAL:", totalCustomers);

// Save updated customers-by-rep-data.json
const outputPath = join(__dirname, "customers-by-rep-data.json");
writeFileSync(outputPath, JSON.stringify(customersByRep, null, 2));
console.log("\nSaved updated customers-by-rep-data.json");

// Check what's in the DB that is NOT in the master list
console.log("\nChecking DB for accounts not in master list...");
const { rows: dbRows } = await pool.query(
  `SELECT DISTINCT account FROM account_assets ORDER BY account`
);
const dbAccountNames: string[] = dbRows.map((r: any) => r.account);
console.log("Unique accounts in DB:", dbAccountNames.length);

const notInMaster = dbAccountNames.filter(name => !masterAccountNames.has(name));
console.log("Accounts in DB NOT in master list:", notInMaster.length);

if (notInMaster.length > 0) {
  console.log("Removing:");
  notInMaster.slice(0, 30).forEach(n => console.log("  -", n));
  if (notInMaster.length > 30) console.log(`  ... and ${notInMaster.length - 30} more`);

  // Delete account_assets rows for non-master accounts
  const placeholders = notInMaster.map((_, i) => `$${i + 1}`).join(", ");
  const { rowCount } = await pool.query(
    `DELETE FROM account_assets WHERE account IN (${placeholders})`,
    notInMaster
  );
  console.log(`Deleted ${rowCount} account_asset rows.`);
}

// Final count
const { rows: countRows } = await pool.query(`SELECT COUNT(*) FROM account_assets`);
console.log("\nFinal account_assets count:", countRows[0].count);

await pool.end();
console.log("\n✓ Done! Master account list synced.");
