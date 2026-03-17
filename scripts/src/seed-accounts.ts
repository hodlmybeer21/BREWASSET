import { db } from "@workspace/db";
import { accountAssetsTable } from "@workspace/db/schema";
import { eq } from "drizzle-orm";

const CUSTOMERS_BY_REP: Record<string, string[]> = {
  "maanderson": ["PEDDLER'S DAUGHTER","FRIENDLY RED'S - HUDSON","FODY'S TAVERN - NASHUA","SHORTY'S - NASHUA","MARGARITAS - NASHUA"],
  "adennis": ["COMMON MAN - MERRIMACK","COPPER DOOR - BEDFORD","STUMBLE INN - LONDONDERRY","T-BONES - DERRY","T-BONES - LONDONDERRY"],
  "amartin": ["ANOMALY BREWING","WOODSTOCK INN","COMMON MAN - LINCOLN","GYPSY CAFÉ","GRANITE GRILLE"],
  "aparente": ["COMMON MAN - CONCORD","GUN AND TACKLE","COMMON MAN - TILTON","TEMPT - LACONIA","COMMON MAN - ASHLAND"],
  "bgermano": ["COPPER DOOR - SALEM","FIRE AND ICE","LOBSTER TRAP","COPPER DOOR - WINDHAM","FIREFLY"],
  "bhanscom": ["RACKS BAR AND GRILLE","THE POINT","PORTSMITH","MR. MAC'S","FLATBREAD PORTSMOUTH"],
  "ddooling": ["THE GOAT","AREA 23","CONCORD CRAFT BREWING","GRANITE STATE CANDY","HERMANOS"],
  "dtaylor": ["FRATELLO'S - MANCHESTER","BEDFORD VILLAGE INN","DERRYFIELD","SMUTTYNOSE","STRANGE BREW"],
  "eleahy": ["RED ARROW DINER","ELM HOUSE","PENUCHE'S","RESTORATION","SHASKEEN"],
  "epaquette": ["JOKERS WILD","MARGARITAS - MANCHESTER","RESTORATION CAFE","T-BONES - MANCHESTER","UNION STREET"],
  "eplatt": ["ANCHOR SPORTS PUB","BARLEY HOUSE","CAFE FRENCH PRESS","COMMON MAN - HOOKSETT","NIKOS"],
  "gconnor": ["HAMPTON BEACH CASINO","SURF","WALLY'S","THE BEACH PLUM","BROWN'S LOBSTER POUND"],
  "ggage": ["STRANGE BREW TAVERN","STARK BREWING CO","MILL YARD BREWERY","THE YARD","BLUE MOON EVOLUTION"],
  "jarquiett": ["PITMAN'S FREIGHT ROOM","ELK ROOM","BUCKLEY'S GREAT STEAKS","MCINTYRE SKI AREA","METRO LOUNGE"],
  "jaustin": ["WILD ROVER","COPPER DOOR - HUDSON","MURPHY'S TAPROOM","HARP & BARD","THE PRESSROOM"],
  "jcannamucio": ["COPPER DOOR - MANCHESTER","CORNER BAR","HANOVER STREET CHOPHOUSE","STARK BREWING","THE EXECUTIVE"],
  "jcaron": ["BENTLEY'S ROADHOUSE","COUNTRY TAVERN","GRANITE STATE ARTS","MANCHESTER ATHLETIC CLUB","THE FOUNDRY"],
  "jgiuffrida": ["PORTSMOUTH GAS LIGHT","KOTO SUSHI","POCO'S BOW ST. CANTINA","JUMPIN' JAY'S","BG'S BOATHOUSE"],
  "jgrumblatt": ["COMMON MAN - WINDHAM","COPPER DOOR - DERRY","STUMBLE INN - HOOKSETT","THE COMMON MAN - WINDHAM","WICKS PIZZA"],
  "jjohnson": ["SMUTTYNOSE BREWING","THROWBACK BREWERY","EARTHCRAFT BREWING","LOADED QUESTION BREWING","GREAT NORTH ALEWORKS"],
  "jmeharg": ["NORTH END PIZZERIA","GREENLEAF PORTSMOUTH","ROUNDABOUT DINER","RAO'S CAFE","YOUNG'S RESTAURANT"],
  "jmorse": ["AIRPORT DINER","UNION DINER","THE JEWEL","THE GREEK'S","MAIN STREET GRILL"],
  "jsewall": ["CACTUS JACK'S","GRILL 603","LONGHORN STEAKHOUSE","NINETY-NINE RESTAURANT","OLIVE GARDEN"],
  "kford": ["OUTBACK STEAKHOUSE","RED LOBSTER","APPLEBEES","BUFFALO WILD WINGS","CHILI'S"],
  "kpeacock": ["TGI FRIDAYS","BONEFISH GRILL","CARRABBA'S","RUBY TUESDAY","DENNY'S"],
  "krogers": ["MARGARITAS - CONCORD","COMMON MAN - CONCORD","REVIVAL KITCHEN","BREAD AND CHOCOLATE","STAGE"],
  "lnorton": ["DOWNTOWN DINER","VETERANS ASSOCIATION","AMERICAN LEGION POST","VFW POST","ELKS LODGE"],
  "lortiz": ["FRATELLO'S - NASHUA","EL RINCON","LOS PRIMOS","MI TIERRA","COLOSSEUM"],
  "mbertolami": ["WOODMAN'S OF ESSEX","PORTSIDE GRILL","MARKEY'S","AMERICAN FLATBREAD","LOCO"],
  "mblais": ["COMMON MAN - WINDHAM","MOODY'S DINER","WEATHERVANE","MOULTON FARM","STEAKS & MORE"],
  "mcanavan": ["CRAFT","COMMONS","TRATTORIAENTO","THE PLACE","RISTORANTE MASSIMO"],
  "ncavallo": ["THE PEDDLER'S DAUGHTER","BARLEY PUB","CONCORD BREWERY","GRANITE TAPROOM","FIELD HOUSE"],
  "pbelanger": ["HIGHLAND GOLF LINKS","LACONIA CC","BROTHERHOOD OF RAILROADERS","BELKNAP COUNTY NURSING HOME","GILFORD VILLAGE INN"],
  "pvoniderstin": ["MILL FALLS MARKETPLACE","LAKE OPECHEE INN","COMMON MAN - ASHLAND","LAKEVIEW NEURO","MEREDITH"],
  "pwollert": ["FAT CAT RESTAURANT","LAKESIDE LANDING","TWIN FARMS","NORTH WOODS INN","SQUAM LAKE INN"],
  "rconstant": ["COMMON MAN - CLAREMONT","COMMON MAN - SUNAPEE","JOHN HAY ESTATE","NEWBURY HARBOR","LAKE SUNAPEE BANK"],
  "rdouzanis": ["COMMON MAN - KEENE","MARGARITAS - KEENE","STAGE RESTAURANT","LINDY'S DINER","TIMOLEON'S"],
  "rwallace": ["THE POINTE AT CASTLE LANDINGS","GUNSTOCK INN","TWIN BARNS BREWING","HERMIT WOODS WINERY","MILL CITY PARK"],
  "scamuso": ["MCGARVEY'S","KILOWATT","METRO LOUNGE","BONFIRE","MANCHVEGAS"],
  "sclark": ["SMUTTYNOSE ROCKINGHAM PARK","ANOMALY","PORTSMOUTH BREWERY","EARTH EAGLE BREWINGS","LOADED QUESTION"],
  "sshaunessy": ["STONYFIELD CAFE","ROUNDABOUT DINER","MARGARITAS - MILFORD","MARO'S PLACE","ELDA"],
  "svisentin": ["PORTSMOUTH DINING","THREE CHIMNEYS INN","PEIRCE ISLAND","BLUE MERMAID","BLUE EYE CRAB"],
  "tchagnon": ["MARGARITAS - ROCHESTER","FAT BELLY'S","JORGENSEN'S","BLAKE'S","BARLEY HEAD"],
  "tpiermarini": ["BARRINGTON BREWERY","GOVERNOR'S INN","EAST ROCHESTER GRILLE","UNION STREET CAFE","COCHECO CC"],
  "wmonty": ["COMMON MAN - DOVER","THE GARRISON CITY BEERWORKS","DOVER BRICKHOUSE","MOMBO","YOUNG'S"],
};

const BRANDS_BY_ITEM: Record<string, string[]> = {
  "Coaster": ["Bud Light","Budweiser","Mich Ultra","Heineken","Stella Artois","Busch Light","Dos Equis","Fiddlehead - IPA","Kona - Big Wave","Stoneface - IPA","Jack's Abby - Banner"],
  "Large Tap Marker": ["Bud Light","Budweiser","Mich Ultra","Heineken","Stella Artois","Fiddlehead - IPA","Kona - Big Wave","Stoneface - IPA","Tuckerman - Pale Ale","Tuckerman - Headwall Alt","Jack's Abby - Copper Legend"],
  "Small Tap Marker": ["Bud Light","Budweiser","Mich Ultra","Heineken","Stella Artois","Fiddlehead - IPA","Kona - Big Wave","Stoneface - IPA","Tuckerman - Pale Ale"],
  "Glass": ["Bud Light","Budweiser","Heineken","Mich Ultra","Stella Artois","Dos Equis","Fiddlehead - IPA","Kona - Big Wave"],
  "Promo Item": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois","Fiddlehead - IPA"],
  "Illuminated Sign": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois"],
  "Display/ Display Enhancer": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois"],
  "Mirror": ["Bud Light","Budweiser","Heineken","Stella Artois"],
  "Umbrella": ["Bud Light","Budweiser","Busch Light","Heineken","Mich Ultra","Stella Artois"],
};

const ALL_DATES = [
  "Sep 5, 2025","Sep 12, 2025","Sep 19, 2025","Sep 30, 2025",
  "Oct 3, 2025","Oct 10, 2025","Oct 17, 2025","Oct 24, 2025","Oct 30, 2025",
  "Nov 6, 2025","Nov 14, 2025","Nov 21, 2025","Nov 28, 2025",
  "Dec 5, 2025","Dec 12, 2025","Dec 19, 2025",
  "Jan 8, 2026","Jan 15, 2026","Jan 22, 2026",
  "Feb 5, 2026","Feb 12, 2026","Feb 19, 2026","Feb 26, 2026",
  "Mar 3, 2026","Mar 10, 2026","Mar 17, 2026",
];

// Seeded pseudo-random (deterministic by rep+account+item so re-runs are consistent)
function seededInt(seed: string, min: number, max: number): number {
  let h = 0;
  for (let i = 0; i < seed.length; i++) h = (Math.imul(31, h) + seed.charCodeAt(i)) | 0;
  return min + (Math.abs(h) % (max - min + 1));
}
function pick<T>(arr: T[], seed: string): T {
  return arr[seededInt(seed, 0, arr.length - 1)];
}

// Curated historical data for maanderson and adennis (preserve existing)
const CURATED: Record<string, Record<string, Array<{itemType:string;brand:string;count:number;lastDate:string}>>> = {
  "maanderson": {
    "PEDDLER'S DAUGHTER": [
      {itemType:"Coaster",brand:"Bud Light",count:4,lastDate:"Oct 30, 2025"},
      {itemType:"Large Tap Marker",brand:"Stoneface - IPA",count:2,lastDate:"Oct 30, 2025"},
      {itemType:"Coaster",brand:"Mich Ultra",count:1,lastDate:"Feb 26, 2026"},
      {itemType:"Large Tap Marker",brand:"Tuckerman - Pale Ale",count:1,lastDate:"Nov 26, 2025"},
    ],
    "FRIENDLY RED'S - HUDSON": [
      {itemType:"Coaster",brand:"Bud Light",count:12,lastDate:"Sep 17, 2025"},
      {itemType:"Large Tap Marker",brand:"Bud Light",count:2,lastDate:"Sep 17, 2025"},
      {itemType:"Small Tap Marker",brand:"Heineken",count:3,lastDate:"Jan 8, 2026"},
    ],
    "FODY'S TAVERN - NASHUA": [
      {itemType:"Coaster",brand:"Stella Artois",count:6,lastDate:"Nov 14, 2025"},
      {itemType:"Small Tap Marker",brand:"Bud Light",count:2,lastDate:"Dec 5, 2025"},
      {itemType:"Glass",brand:"Heineken",count:8,lastDate:"Oct 10, 2025"},
    ],
    "SHORTY'S - NASHUA": [
      {itemType:"Coaster",brand:"Budweiser",count:8,lastDate:"Dec 19, 2025"},
      {itemType:"Large Tap Marker",brand:"Fiddlehead - IPA",count:1,lastDate:"Jan 22, 2026"},
      {itemType:"Promo Item",brand:"Bud Light",count:4,lastDate:"Feb 5, 2026"},
    ],
    "MARGARITAS - NASHUA": [
      {itemType:"Coaster",brand:"Dos Equis",count:10,lastDate:"Oct 24, 2025"},
      {itemType:"Large Tap Marker",brand:"Dos Equis",count:2,lastDate:"Oct 24, 2025"},
      {itemType:"Small Tap Marker",brand:"Mich Ultra",count:3,lastDate:"Mar 3, 2026"},
    ],
  },
  "adennis": {
    "COMMON MAN - MERRIMACK": [
      {itemType:"Coaster",brand:"Bud Light",count:6,lastDate:"Nov 15, 2025"},
      {itemType:"Large Tap Marker",brand:"Bud Light",count:2,lastDate:"Nov 15, 2025"},
      {itemType:"Promo Item",brand:"Busch Light",count:3,lastDate:"Feb 12, 2026"},
    ],
    "COPPER DOOR - BEDFORD": [
      {itemType:"Coaster",brand:"Mich Ultra",count:4,lastDate:"Dec 10, 2025"},
      {itemType:"Glass",brand:"Heineken",count:12,lastDate:"Oct 5, 2025"},
      {itemType:"Small Tap Marker",brand:"Stella Artois",count:2,lastDate:"Jan 15, 2026"},
    ],
    "STUMBLE INN - LONDONDERRY": [
      {itemType:"Coaster",brand:"Busch Light",count:8,lastDate:"Sep 30, 2025"},
      {itemType:"Large Tap Marker",brand:"Mich Ultra",count:1,lastDate:"Oct 17, 2025"},
    ],
    "T-BONES - DERRY": [
      {itemType:"Coaster",brand:"Budweiser",count:10,lastDate:"Dec 5, 2025"},
      {itemType:"Promo Item",brand:"Bud Light",count:5,lastDate:"Jan 8, 2026"},
      {itemType:"Glass",brand:"Bud Light",count:6,lastDate:"Feb 26, 2026"},
    ],
    "T-BONES - LONDONDERRY": [
      {itemType:"Coaster",brand:"Heineken",count:6,lastDate:"Nov 6, 2025"},
      {itemType:"Large Tap Marker",brand:"Heineken",count:2,lastDate:"Nov 6, 2025"},
    ],
  },
};

// Item type pools by account category (for variety)
const COMMON_ITEMS = ["Coaster","Large Tap Marker","Small Tap Marker"];
const OCCASIONAL_ITEMS = ["Glass","Promo Item","Display/ Display Enhancer","Illuminated Sign","Umbrella","Mirror"];

function generateAccountAssets(rep: string, account: string): Array<{itemType:string;brand:string;count:number;lastDate:string}> {
  const seed = `${rep}::${account}`;
  const numItems = seededInt(seed + "n", 2, 5);
  const results: Array<{itemType:string;brand:string;count:number;lastDate:string}> = [];
  const usedTypes = new Set<string>();

  // Always add 1-2 coasters
  const coasterBrand = pick(BRANDS_BY_ITEM["Coaster"], seed + "coa");
  results.push({
    itemType: "Coaster",
    brand: coasterBrand,
    count: seededInt(seed + "coa_cnt", 4, 20),
    lastDate: pick(ALL_DATES, seed + "coa_d"),
  });
  usedTypes.add("Coaster");

  // Usually a tap marker
  if (numItems >= 2) {
    const tapType = seededInt(seed + "tap_t", 0, 1) === 0 ? "Large Tap Marker" : "Small Tap Marker";
    const tapBrand = pick(BRANDS_BY_ITEM[tapType], seed + "tap");
    results.push({
      itemType: tapType,
      brand: tapBrand,
      count: seededInt(seed + "tap_cnt", 1, 4),
      lastDate: pick(ALL_DATES, seed + "tap_d"),
    });
    usedTypes.add(tapType);
  }

  // Add extra items for accounts with more history
  for (let i = 2; i < numItems; i++) {
    const pool = [...COMMON_ITEMS, ...OCCASIONAL_ITEMS].filter(t => !usedTypes.has(t));
    if (pool.length === 0) break;
    const itemType = pick(pool, seed + `extra${i}`);
    const brands = BRANDS_BY_ITEM[itemType] || ["Bud Light"];
    const brand = pick(brands, seed + `extra${i}_brand`);
    results.push({
      itemType,
      brand,
      count: seededInt(seed + `extra${i}_cnt`, 1, 12),
      lastDate: pick(ALL_DATES, seed + `extra${i}_d`),
    });
    usedTypes.add(itemType);
  }

  return results;
}

async function main() {
  console.log("Seeding account assets for all reps...");

  // Clear existing account assets
  await db.delete(accountAssetsTable);
  console.log("Cleared existing account_assets");

  let total = 0;

  for (const [rep, customers] of Object.entries(CUSTOMERS_BY_REP)) {
    for (const account of customers) {
      // Use curated data if available, otherwise generate
      const curated = CURATED[rep]?.[account];
      const assets = curated ?? generateAccountAssets(rep, account);

      for (const asset of assets) {
        await db.insert(accountAssetsTable).values({
          repUsername: rep,
          account,
          itemType: asset.itemType,
          brand: asset.brand,
          count: asset.count,
          lastDate: asset.lastDate,
        });
        total++;
      }
    }
    console.log(`  ✓ ${rep}: ${customers.length} accounts`);
  }

  console.log(`\n✓ Done! Inserted ${total} account asset records for ${Object.keys(CUSTOMERS_BY_REP).length} reps`);
  process.exit(0);
}

main().catch(err => {
  console.error("Seed failed:", err);
  process.exit(1);
});
