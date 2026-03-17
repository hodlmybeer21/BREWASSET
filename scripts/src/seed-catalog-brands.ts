import { db, pool } from "@workspace/db";
import { catalogItemsTable, brandsTable } from "@workspace/db/schema";
import { readFileSync } from "fs";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __dirname = dirname(fileURLToPath(import.meta.url));
const BRANDS_BY_ITEM: Record<string, string[]> = JSON.parse(
  readFileSync(join(__dirname, "brands-data.json"), "utf8")
);

async function main() {
  console.log("Updating catalog brands from Excel data...");

  const catalogItems = await db.select().from(catalogItemsTable);
  const itemMap = new Map(catalogItems.map(i => [i.name, i]));

  for (const [itemName, brands] of Object.entries(BRANDS_BY_ITEM)) {
    const catalogItem = itemMap.get(itemName);
    if (!catalogItem) {
      console.log(`  Skipping unknown item type: ${itemName}`);
      continue;
    }

    await pool.query("DELETE FROM brands WHERE catalog_item_id = $1", [catalogItem.id]);
    console.log(`  Cleared brands for ${itemName}, inserting ${brands.length}...`);

    for (const brandName of brands) {
      await db.insert(brandsTable).values({
        catalogItemId: catalogItem.id,
        name: brandName,
        isDefault: true,
      }).onConflictDoNothing();
    }
  }

  const total = await pool.query("SELECT COUNT(*) as cnt FROM brands");
  console.log(`Done! Catalog now has ${total.rows[0].cnt} total brands`);
  process.exit(0);
}

main().catch(err => {
  console.error(err.message);
  process.exit(1);
});
