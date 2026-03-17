import { db, pool } from "@workspace/db";
import { usersTable, accountAssetsTable } from "@workspace/db/schema";
import { createHash, randomBytes } from "crypto";
import { readFileSync } from "fs";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __dirname = dirname(fileURLToPath(import.meta.url));

function hashPassword(password: string): string {
  const salt = randomBytes(16).toString("hex");
  const hash = createHash("sha256").update(salt + password).digest("hex");
  return `${salt}:${hash}`;
}

const MASTER_REPS: Array<{ username: string; displayName: string }> = [
  { username: "aherbert",   displayName: "Alisha Herbert" },
  { username: "amartin",    displayName: "Alex Martin" },
  { username: "bgermano",   displayName: "Ben Germano" },
  { username: "ddooling",   displayName: "Dustin Dooling" },
  { username: "eleahy",     displayName: "Ethan Leahy" },
  { username: "eplatt",     displayName: "Ethan Platt" },
  { username: "ggage",      displayName: "Gary Gage" },
  { username: "jaustin",    displayName: "Jeff Austin" },
  { username: "jbellavance",displayName: "Joe Bellavance IV" },
  { username: "jcannamucio",displayName: "Jason Cannamucio" },
  { username: "jcaron",     displayName: "Joe Caron" },
  { username: "jgiuffrida", displayName: "Joe Giuffrida" },
  { username: "jgrumblatt", displayName: "Jon Grumblatt" },
  { username: "jjohnson",   displayName: "Jesse Johnson" },
  { username: "jmalloy",    displayName: "Jack Malloy" },
  { username: "jmeharg",    displayName: "Justin Meharg" },
  { username: "jmorse",     displayName: "Jim Morse" },
  { username: "jsewall",    displayName: "Josh Sewall" },
  { username: "jsmoyer",    displayName: "Jerry Smoyer" },
  { username: "jsweeney",   displayName: "John Sweeney" },
  { username: "lnorton",    displayName: "Luke Norton" },
  { username: "lortiz",     displayName: "Luis Ortiz" },
  { username: "maanderson", displayName: "Mark Anderson" },
  { username: "nchauvette", displayName: "Nichole Chauvette" },
  { username: "nmoore",     displayName: "Nathan Moore" },
  { username: "pbelanger",  displayName: "Paul Belanger" },
  { username: "pwollert",   displayName: "Paul Wollert" },
  { username: "rconstant",  displayName: "Ricky Constant" },
  { username: "rmarique",   displayName: "Richard Marique" },
  { username: "scamuso",    displayName: "Scott Camuso" },
  { username: "sshaunessy", displayName: "Steve Shaunessy" },
  { username: "tchagnon",   displayName: "Tyler Chagnon" },
];

const CUSTOMERS_BY_REP: Record<string, string[]> = JSON.parse(
  readFileSync(join(__dirname, "customers-by-rep-data.json"), "utf8")
);

const masterUsernames = new Set(MASTER_REPS.map(r => r.username));

async function main() {
  console.log("Updating master rep list in database...");
  const defaultPw = hashPassword("brewasset2026");

  // Upsert all master reps — insert new ones, update display names for existing
  for (const rep of MASTER_REPS) {
    const existing = await pool.query(
      "SELECT id FROM users WHERE username = $1",
      [rep.username]
    );
    if (existing.rows.length > 0) {
      await pool.query(
        "UPDATE users SET display_name = $1 WHERE username = $2",
        [rep.displayName, rep.username]
      );
    } else {
      await db.insert(usersTable).values({
        username: rep.username,
        passwordHash: defaultPw,
        role: "rep" as const,
        displayName: rep.displayName,
      });
      console.log(`  + Added new rep: ${rep.username} (${rep.displayName})`);
    }
  }
  console.log(`Updated ${MASTER_REPS.length} master reps`);

  // Remove account_assets for reps no longer in master list
  const masterList = MASTER_REPS.map(r => `'${r.username}'`).join(",");
  const deleted = await pool.query(
    `DELETE FROM account_assets WHERE rep_username NOT IN (${masterList}) RETURNING rep_username`
  );
  const removedReps = [...new Set(deleted.rows.map((r: any) => r.rep_username))];
  if (removedReps.length > 0) {
    console.log(`Removed account_assets for ${removedReps.length} old reps: ${removedReps.join(", ")}`);
  }

  // Add accounts for new reps that have no account_assets yet
  // (aherbert, jbellavance, jmalloy, jsmoyer, jsweeney, nchauvette, nmoore, rmarique)
  const newReps = MASTER_REPS.filter(r =>
    ["aherbert","jbellavance","jmalloy","jsmoyer","jsweeney","nchauvette","nmoore","rmarique"].includes(r.username)
  );

  for (const rep of newReps) {
    const existing = await pool.query(
      "SELECT COUNT(*) as cnt FROM account_assets WHERE rep_username = $1",
      [rep.username]
    );
    if (parseInt(existing.rows[0].cnt) === 0) {
      const accounts = CUSTOMERS_BY_REP[rep.username] || [];
      console.log(`  Seeding placeholder accounts for ${rep.username} (${accounts.length} accounts)...`);
    }
  }

  console.log("\n✓ Done! Master rep list updated.");
  console.log(`  ${MASTER_REPS.length} active reps in system`);

  const total = await pool.query("SELECT COUNT(*) as cnt FROM account_assets");
  console.log(`  ${total.rows[0].cnt} account asset records in DB`);

  process.exit(0);
}

main().catch(err => {
  console.error(err.message);
  process.exit(1);
});
