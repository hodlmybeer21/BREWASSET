import { pool } from "@workspace/db";
import { createHash, randomBytes } from "crypto";

function hashPassword(password: string): string {
  const salt = randomBytes(16).toString("hex");
  const hash = createHash("sha256").update(salt + password).digest("hex");
  return `${salt}:${hash}`;
}

// Initial password = first name + "2026"
// Disambiguates duplicate first names (2x Ethan, 2x Joe, 2x Paul)
const REP_PASSWORDS: Array<{ username: string; displayName: string; password: string }> = [
  { username: "amartin",    displayName: "Alex Martin",       password: "Alex2026" },
  { username: "bgermano",   displayName: "Ben Germano",       password: "Ben2026" },
  { username: "ddooling",   displayName: "Dustin Dooling",    password: "Dustin2026" },
  { username: "eleahy",     displayName: "Ethan Leahy",       password: "EthanL2026" },
  { username: "eplatt",     displayName: "Ethan Platt",       password: "EthanP2026" },
  { username: "ggage",      displayName: "Gary Gage",         password: "Gary2026" },
  { username: "jaustin",    displayName: "Jeff Austin",       password: "Jeff2026" },
  { username: "jcannamucio",displayName: "Jason Cannamucio",  password: "Jason2026" },
  { username: "jcaron",     displayName: "Joe Caron",         password: "JoeC2026" },
  { username: "jgiuffrida", displayName: "Joe Giuffrida",     password: "JoeG2026" },
  { username: "jgrumblatt", displayName: "Jon Grumblatt",     password: "Jon2026" },
  { username: "jjohnson",   displayName: "Jesse Johnson",     password: "Jesse2026" },
  { username: "jmalloy",    displayName: "Jack Malloy",       password: "Jack2026" },
  { username: "jmeharg",    displayName: "Justin Meharg",     password: "Justin2026" },
  { username: "jmorse",     displayName: "Jim Morse",         password: "Jim2026" },
  { username: "jsewall",    displayName: "Josh Sewall",       password: "Josh2026" },
  { username: "jsmoyer",    displayName: "Jerry Smoyer",      password: "Jerry2026" },
  { username: "jsweeney",   displayName: "John Sweeney",      password: "John2026" },
  { username: "lnorton",    displayName: "Luke Norton",       password: "Luke2026" },
  { username: "lortiz",     displayName: "Luis Ortiz",        password: "Luis2026" },
  { username: "maanderson", displayName: "Mark Anderson",     password: "Mark2026" },
  { username: "nmoore",     displayName: "Nathan Moore",      password: "Nathan2026" },
  { username: "pbelanger",  displayName: "Paul Belanger",     password: "PaulB2026" },
  { username: "pwollert",   displayName: "Paul Wollert",      password: "PaulW2026" },
  { username: "rconstant",  displayName: "Ricky Constant",    password: "Ricky2026" },
  { username: "rmarique",   displayName: "Richard Marique",   password: "Richard2026" },
  { username: "scamuso",    displayName: "Scott Camuso",      password: "Scott2026" },
  { username: "sshaunessy", displayName: "Steve Shaunessy",   password: "Steve2026" },
  { username: "tchagnon",   displayName: "Tyler Chagnon",     password: "Tyler2026" },
];

async function main() {
  console.log("Setting individual rep passwords...\n");

  for (const rep of REP_PASSWORDS) {
    const hash = hashPassword(rep.password);
    await pool.query(
      "UPDATE users SET password_hash = $1 WHERE username = $2",
      [hash, rep.username]
    );
  }

  console.log("✓ Done! Initial passwords set:\n");
  console.log("─".repeat(54));
  console.log(
    "Name".padEnd(22) +
    "Username".padEnd(16) +
    "Initial Password"
  );
  console.log("─".repeat(54));
  for (const rep of REP_PASSWORDS) {
    console.log(
      rep.displayName.padEnd(22) +
      rep.username.padEnd(16) +
      rep.password
    );
  }
  console.log("─".repeat(54));
  console.log("\nWarehouse login → password: warehouse123");
  console.log("Marketing login → password: marketing123\n");

  await pool.end();
  process.exit(0);
}

main().catch(err => { console.error(err); process.exit(1); });
