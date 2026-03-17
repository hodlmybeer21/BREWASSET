export const ITEM_TYPES = [
  "Coaster",
  "Display/ Display Enhancer",
  "Glass",
  "Illuminated Sign",
  "Large Tap Marker",
  "Mirror",
  "Other",
  "Promo Item",
  "Small Tap Marker",
  "Umbrella"
];

export const ITEM_ICONS: Record<string, string> = {
  "Coaster": "⭕",
  "Display/ Display Enhancer": "🖼️",
  "Glass": "🥂",
  "Illuminated Sign": "💡",
  "Large Tap Marker": "🍺",
  "Mirror": "🪞",
  "Other": "📦",
  "Promo Item": "🎁",
  "Small Tap Marker": "🔵",
  "Umbrella": "☂️"
};

export const ITEM_COLORS: Record<string, string> = {
  "Coaster": "#e8a020",
  "Display/ Display Enhancer": "#60b880",
  "Glass": "#60a0e8",
  "Illuminated Sign": "#f0d020",
  "Large Tap Marker": "#e05050",
  "Mirror": "#c080e0",
  "Other": "#808080",
  "Promo Item": "#e070a0",
  "Small Tap Marker": "#40c0c0",
  "Umbrella": "#4080d0"
};

export const ALL_REPS = [
  "adennis","amartin","aparente","bgermano","bhanscom","ddooling","dtaylor",
  "eleahy","epaquette","eplatt","gconnor","ggage","jarquiett","jaustin",
  "jcannamucio","jcaron","jgiuffrida","jgrumblatt","jjohnson","jmeharg",
  "jmorse","jsewall","kford","kpeacock","krogers","lnorton","lortiz",
  "maanderson","mbertolami","mblais","mcanavan","ncavallo","pbelanger",
  "pvoniderstin","pwollert","rconstant","rdouzanis","rwallace","scamuso",
  "sclark","sshaunessy","svisentin","tchagnon","tpiermarini","wmonty"
];

export const CUSTOMERS_BY_REP: Record<string, string[]> = {
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

export const BRANDS_BY_ITEM: Record<string, string[]> = {
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
