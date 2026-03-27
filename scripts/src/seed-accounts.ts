import { db } from "@workspace/db";
import { accountAssetsTable, usersTable, inventoryTable } from "@workspace/db/schema";
import { createHash, randomBytes } from "crypto";
import { readFileSync } from "fs";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

function hashPassword(password: string): string {
  const salt = randomBytes(16).toString("hex");
  const hash = createHash("sha256").update(salt + password).digest("hex");
  return `${salt}:${hash}`;
}

const __dirname = dirname(fileURLToPath(import.meta.url));
const ASSET_DATA: Array<{rep:string;account:string;item:string;brand:string;count:number;lastDate:string}> =
  JSON.parse(readFileSync(join(__dirname, "account-assets-data.json"), "utf8"));

async function main() {
  console.log(`Seeding account assets from Excel data (${ASSET_DATA.length} rows)...`);

  const defaultPw = hashPassword("brewasset2026");
  const newReps = [
    { username: "tjebol", displayName: "T. Jebol" },
    { username: "tpiccinono", displayName: "T. Piccinono" },
  ];
  for (const r of newReps) {
    await db.insert(usersTable).values({
      username: r.username,
      passwordHash: defaultPw,
      role: "rep" as const,
      displayName: r.displayName,
    }).onConflictDoNothing();
  }
  console.log("Ensured new rep users exist (tjebol, tpiccinono)");

  await db.update(inventoryTable).set({ quantity: 0 });
  console.log("Zeroed all inventory quantities");

  await db.delete(accountAssetsTable);
  console.log("Cleared existing account_assets");

  let i = 0;
  for (const row of ASSET_DATA) {
    await db.insert(accountAssetsTable).values({
      repUsername: row.rep,
      account: row.account,
      itemType: row.item,
      brand: row.brand,
      count: row.count,
      lastDate: row.lastDate,
    });
    i++;
    if (i % 500 === 0) console.log(`  ... ${i} / ${ASSET_DATA.length}`);
  }

  console.log(`Done! Inserted ${i} account asset records`);
  process.exit(0);
}

main().catch(err => {
  console.error(err.message);
  process.exit(1);
});
