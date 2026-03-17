import { readFileSync } from "fs";
import { pool } from "@workspace/db";

const XLSX_PATH = "/home/runner/workspace/attached_assets/Customers_TDUBUQUE_20260317_0848490331926_1773758938130.xlsx";

const FULL_NAME_TO_USERNAME: Record<string, string> = {
  "Alex Martin": "amartin",
  "Alisha Herbert": "aherbert",
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
  "Joe Bellavance IV": "jbellavance",
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
  "Nichole Chauvette": "nchauvette",
  "Paul Belanger": "pbelanger",
  "Paul Wollert": "pwollert",
  "Richard Marique": "rmarique",
  "Ricky Constant": "rconstant",
  "Scott Camuso": "scamuso",
  "Steve Shaunessy": "sshaunessy",
  "Tyler Chagnon": "tchagnon",
};

const XLSX = await import("xlsx");
const buf = readFileSync(XLSX_PATH);
const wb = XLSX.read(buf, { type: "buffer" });
const rows: any[] = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]], { defval: "" });

console.log(`Seeding customers table from ${rows.length} Excel rows...`);

let inserted = 0;
let skipped = 0;
let warned = 0;

for (const r of rows) {
  const name = (r["Customer Name"] as string).trim();
  const fullName = (r["Salesman"] as string).trim();
  const chain = (r["Chain"] as string).trim() || null;
  const customerType = (r["Customer Type"] as string).trim() || null;
  const active = (r["Account Status"] as string).trim() === "Active";
  const repUsername = FULL_NAME_TO_USERNAME[fullName];

  if (!repUsername) {
    console.warn(`  WARNING: Unknown rep "${fullName}" for account "${name}"`);
    warned++;
    continue;
  }

  await pool.query(
    `INSERT INTO customers (name, rep_username, chain, customer_type, active)
     VALUES ($1, $2, $3, $4, $5)
     ON CONFLICT (name) DO UPDATE SET
       rep_username = EXCLUDED.rep_username,
       chain = EXCLUDED.chain,
       customer_type = EXCLUDED.customer_type,
       active = EXCLUDED.active,
       updated_at = NOW()`,
    [name, repUsername, chain, customerType, active]
  );
  inserted++;
}

const { rows: countRows } = await pool.query(`SELECT COUNT(*) FROM customers`);
console.log(`\n✓ Done!`);
console.log(`  Inserted/updated: ${inserted}`);
if (warned > 0) console.log(`  Warnings (unknown reps): ${warned}`);
console.log(`  Total customers in DB: ${countRows[0].count}`);

await pool.end();
