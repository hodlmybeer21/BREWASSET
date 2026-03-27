import { db } from "@workspace/db";
import {
  usersTable,
  catalogItemsTable,
  brandsTable,
  inventoryTable,
  promoStaffTable,
  accountAssetsTable,
} from "@workspace/db/schema";
import { createHash, randomBytes } from "crypto";

function hashPassword(password: string): string {
  const salt = randomBytes(16).toString("hex");
  const hash = createHash("sha256").update(salt + password).digest("hex");
  return `${salt}:${hash}`;
}

const ITEM_TYPES = [
  { name: "Coaster", icon: "⭕", color: "#e8a020" },
  { name: "Display/ Display Enhancer", icon: "🖼️", color: "#60b880" },
  { name: "Glass", icon: "🥂", color: "#60a0e8" },
  { name: "Illuminated Sign", icon: "💡", color: "#f0d020" },
  { name: "Large Tap Marker", icon: "🍺", color: "#e05050" },
  { name: "Mirror", icon: "🪞", color: "#c080e0" },
  { name: "Other", icon: "📦", color: "#808080" },
  { name: "Promo Item", icon: "🎁", color: "#e070a0" },
  { name: "Small Tap Marker", icon: "🔵", color: "#40c0c0" },
  { name: "Umbrella", icon: "☂️", color: "#4080d0" },
];

const BRANDS_BY_ITEM: Record<string, string[]> = {
  "Coaster": ["Athletic - Lite","Bud American Ale","Bud Ice","Bud Light","Bud Light Seltzer Sangria Splash Variety","Budweiser","Busch Light","Dos Equis","Dos Equis Amber","Fiddlehead - Hodad","Fiddlehead - IPA","Gold Road Mango Cart","Good Boy Vodka","Heineken","Hoop Tea","Jack's Abby - Banner","Jack's Abby - Copper Legend","Kona - Big Wave","Mich Ultra","Mich Ultra Org","Mich Ultra Zero","Nutrl","Nutrl Orange","Nutrl Pineapple","Stella Artois","Stoneface - IPA"],
  "Display/ Display Enhancer": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois"],
  "Glass": ["Bud Light","Budweiser","Heineken","Mich Ultra","Stella Artois","Dos Equis","Fiddlehead - IPA","Kona - Big Wave"],
  "Illuminated Sign": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois","Dos Equis"],
  "Large Tap Marker": ["Athletic - Lite","Bud Light","Budweiser","Busch Light","Dos Equis","Fiddlehead - Hodad","Fiddlehead - IPA","Gold Road Mango Cart","Heineken","Jack's Abby - Banner","Jack's Abby - Copper Legend","Kona - Big Wave","Mich Ultra","Mich Ultra Org","Mich Ultra Zero","Stella Artois","Stoneface - IPA","Tuckerman - Pale Ale","Tuckerman - Headwall Alt"],
  "Mirror": ["Bud Light","Budweiser","Heineken","Stella Artois"],
  "Other": ["Bud Light","Budweiser","Various"],
  "Promo Item": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois","Fiddlehead - IPA"],
  "Small Tap Marker": ["Athletic - Lite","Bud Light","Budweiser","Busch Light","Dos Equis","Fiddlehead - Hodad","Fiddlehead - IPA","Heineken","Jack's Abby - Banner","Kona - Big Wave","Mich Ultra","Stella Artois","Stoneface - IPA","Tuckerman - Pale Ale"],
  "Umbrella": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois"],
};

const ALL_REPS = ["adennis","amartin","aparente","bgermano","bhanscom","ddooling","dtaylor","eleahy","epaquette","eplatt","gconnor","ggage","jarquiett","jaustin","jcannamucio","jcaron","jgiuffrida","jgrumblatt","jjohnson","jmeharg","jmorse","jsewall","kford","kpeacock","krogers","lnorton","lortiz","maanderson","mbertolami","mblais","mcanavan","ncavallo","pbelanger","pvoniderstin","pwollert","rconstant","rdouzanis","rwallace","scamuso","sclark","sshaunessy","svisentin","tchagnon","tpiermarini","wmonty"];

const ACCOUNT_ASSETS: Record<string, Record<string, Array<{item:string;brand:string;count:number;last:string}>>> = {
  "maanderson": {
    "PEDDLER'S DAUGHTER": [
      {"item":"Coaster","brand":"Bud Light","count":4,"last":"Oct 30, 2025"},
      {"item":"Large Tap Marker","brand":"Stoneface - IPA","count":2,"last":"Oct 30, 2025"},
      {"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 26, 2026"},
      {"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Nov 26, 2025"}
    ],
    "FRIENDLY RED'S - HUDSON": [
      {"item":"Coaster","brand":"Bud Light","count":12,"last":"Sep 17, 2025"},
      {"item":"Large Tap Marker","brand":"Bud Light","count":2,"last":"Sep 17, 2025"},
      {"item":"Small Tap Marker","brand":"Heineken","count":3,"last":"Jan 8, 2026"}
    ],
  },
  "adennis": {
    "COMMON MAN - MERRIMACK": [
      {"item":"Coaster","brand":"Bud Light","count":6,"last":"Nov 15, 2025"},
      {"item":"Large Tap Marker","brand":"Bud Light","count":2,"last":"Nov 15, 2025"},
    ],
    "COPPER DOOR - BEDFORD": [
      {"item":"Coaster","brand":"Mich Ultra","count":4,"last":"Dec 10, 2025"},
      {"item":"Glass","brand":"Heineken","count":12,"last":"Oct 5, 2025"},
    ],
  },
};

async function main() {
  console.log("Seeding database...");

  // 1. Create users
  const defaultPassword = hashPassword("brewasset2026");

  // Check if users already exist
  const existingUsers = await db.select().from(usersTable);
  if (existingUsers.length === 0) {
    console.log("Creating users...");

    // Warehouse staff
    await db.insert(usersTable).values({
      username: "warehouse",
      passwordHash: hashPassword("warehouse123"),
      role: "warehouse",
      displayName: "Warehouse Staff",
    });

    // Marketing manager
    await db.insert(usersTable).values({
      username: "marketing",
      passwordHash: hashPassword("marketing123"),
      role: "marketing",
      displayName: "Marketing Manager",
    });

    // All reps
    for (const rep of ALL_REPS) {
      await db.insert(usersTable).values({
        username: rep,
        passwordHash: defaultPassword,
        role: "rep",
        displayName: rep.charAt(0).toUpperCase() + rep.slice(1),
      }).onConflictDoNothing();
    }
    console.log(`Created ${ALL_REPS.length + 2} users`);
  } else {
    console.log("Users already exist, skipping...");
  }

  // 2. Create catalog items and brands
  const existingItems = await db.select().from(catalogItemsTable);
  if (existingItems.length === 0) {
    console.log("Creating catalog...");
    for (const itemType of ITEM_TYPES) {
      const [catalogItem] = await db.insert(catalogItemsTable).values({
        name: itemType.name,
        icon: itemType.icon,
        color: itemType.color,
        isDefault: true,
      }).returning();

      const brands = BRANDS_BY_ITEM[itemType.name] || [];
      for (const brandName of brands) {
        await db.insert(brandsTable).values({
          catalogItemId: catalogItem.id,
          name: brandName,
          isDefault: true,
        }).onConflictDoNothing();
      }
    }
    console.log("Catalog created");
  } else {
    console.log("Catalog already exists, skipping...");
  }

  // 3. Seed some initial inventory
  const existingInventory = await db.select().from(inventoryTable);
  if (existingInventory.length === 0) {
    console.log("Seeding inventory...");
    const catalogItems = await db.select().from(catalogItemsTable);
    const brands = await db.select().from(brandsTable);
    const brandMap = new Map(brands.map(b => [`${b.catalogItemId}:${b.name}`, b]));
    const itemMap = new Map(catalogItems.map(i => [i.name, i]));

    const inventorySeed: Array<{item: string, brand: string, qty: number}> = [
      { item: "Coaster", brand: "Bud Light", qty: 150 },
      { item: "Coaster", brand: "Mich Ultra", qty: 80 },
      { item: "Coaster", brand: "Heineken", qty: 60 },
      { item: "Coaster", brand: "Budweiser", qty: 45 },
      { item: "Large Tap Marker", brand: "Bud Light", qty: 25 },
      { item: "Large Tap Marker", brand: "Mich Ultra", qty: 18 },
      { item: "Large Tap Marker", brand: "Fiddlehead - IPA", qty: 12 },
      { item: "Large Tap Marker", brand: "Heineken", qty: 10 },
      { item: "Small Tap Marker", brand: "Bud Light", qty: 30 },
      { item: "Small Tap Marker", brand: "Stella Artois", qty: 20 },
      { item: "Glass", brand: "Heineken", qty: 48 },
      { item: "Glass", brand: "Budweiser", qty: 24 },
      { item: "Promo Item", brand: "Bud Light", qty: 50 },
      { item: "Promo Item", brand: "Busch Light", qty: 35 },
      { item: "Illuminated Sign", brand: "Bud Light", qty: 8 },
      { item: "Illuminated Sign", brand: "Heineken", qty: 5 },
      { item: "Umbrella", brand: "Bud Light", qty: 4 },
      { item: "Umbrella", brand: "Mich Ultra", qty: 3 },
    ];

    for (const seed of inventorySeed) {
      const catItem = itemMap.get(seed.item);
      if (!catItem) continue;
      const brand = brandMap.get(`${catItem.id}:${seed.brand}`);
      await db.insert(inventoryTable).values({
        itemType: seed.item,
        brand: seed.brand,
        quantity: seed.qty,
        catalogItemId: catItem.id,
        brandId: brand?.id ?? 0,
      }).onConflictDoNothing();
    }
    console.log("Inventory seeded");
  } else {
    console.log("Inventory already exists, skipping...");
  }

  // 4. Seed promo staff
  const existingStaff = await db.select().from(promoStaffTable);
  if (existingStaff.length === 0) {
    console.log("Seeding promo staff...");
    const staffSeed = [
      { name: "Alyssa M.", phone: "603-555-0101", email: "alyssa@promo.com", notes: "" },
      { name: "Brianna K.", phone: "603-555-0102", email: "brianna@promo.com", notes: "" },
      { name: "Carla T.", phone: "603-555-0103", email: "carla@promo.com", notes: "" },
      { name: "Dana S.", phone: "603-555-0104", email: "dana@promo.com", notes: "" },
      { name: "Emma R.", phone: "603-555-0105", email: "emma@promo.com", notes: "" },
      { name: "Faith L.", phone: "603-555-0106", email: "faith@promo.com", notes: "" },
      { name: "Grace P.", phone: "603-555-0107", email: "grace@promo.com", notes: "" },
      { name: "Hailey N.", phone: "603-555-0108", email: "hailey@promo.com", notes: "" },
      { name: "Isabel W.", phone: "603-555-0109", email: "isabel@promo.com", notes: "" },
      { name: "Jenna C.", phone: "603-555-0110", email: "jenna@promo.com", notes: "" },
      { name: "Kayla D.", phone: "603-555-0111", email: "kayla@promo.com", notes: "" },
      { name: "Lauren H.", phone: "603-555-0112", email: "lauren@promo.com", notes: "" },
    ];
    for (const s of staffSeed) {
      await db.insert(promoStaffTable).values(s).onConflictDoNothing();
    }
    console.log("Promo staff seeded");
  }

  // 5. Seed account assets from historical data
  const existingAssets = await db.select().from(accountAssetsTable);
  if (existingAssets.length === 0) {
    console.log("Seeding account assets...");
    for (const [repUsername, accounts] of Object.entries(ACCOUNT_ASSETS)) {
      for (const [account, assets] of Object.entries(accounts)) {
        for (const asset of assets) {
          await db.insert(accountAssetsTable).values({
            repUsername,
            account,
            itemType: asset.item,
            brand: asset.brand,
            count: asset.count,
            lastDate: asset.last,
          }).onConflictDoNothing();
        }
      }
    }
    console.log("Account assets seeded");
  }

  console.log("✓ Seed complete!");
  process.exit(0);
}

main().catch(err => {
  console.error("Seed failed:", err);
  process.exit(1);
});
