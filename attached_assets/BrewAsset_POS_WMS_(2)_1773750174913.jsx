import { useState, useRef } from "react";

const BRANDS_BY_ITEM = {"Coaster":["Athletic - Lite","Bud American Ale","Bud Ice","Bud Light","Bud Light Seltzer Sangria Splash Variety","Budweiser","Busch Light","Dos Equis","Dos Equis Amber","Fiddlehead - Hodad","Fiddlehead - IPA","Gold Road Mango Cart","Good Boy Vodka","Heineken","Hoop Tea","Jack's Abby - Banner","Jack's Abby - Copper Legend","Kona - Big Wave","Mich Ultra","Mich Ultra Org","Mich Ultra Zero","Nutrl","Nutrl Orange","Nutrl Pineapple","Stella Artois","Stoneface - IPA","Wicked Weed","Zero Gravity - Cone Head"],"Display/ Display Enhancer":["603 Brew - Winni","Able - Auburn","Athletic - All Out","Athletic - Free Wave","Athletic - Lite","Athletic - Run Wild","BeatBox Vrty","Beatbox Hard T","Bud Light","Bud Lt Lemon-Ade-Rita","Bud Lt Lime-A-Rita","Bud Lt Straw-Ber-Rita","Bud Lt Summer Rita","Budweiser","Busch Light","Cabot","Citizen Cider - Unified Press","Clubtails","Cutwater Mojito","Cutwater Tequila Paloma","Cutwater Variety","Cutwater Vodka Mule","Daily's Cocktails","Deep River","Devils BB - Orng Smash","Devils BB - Vrty","Dos Equis","Downeast - Original","Downeast - Overboard","Fiddlehead - IPA","Ghost Energy","Gold Road Mango Cart","Good 2 grow","Good Boy J Daly","Guinness Pretzel Pieces","Happy Dad Variety","Heineken","Heineken Silver","Jack's Abby - Banner","Johny Bootlegger","Kona - Big Wave","Links Drinks","Mas+ by Messi","Mich Ultra","Mich Ultra Zero","Murphy's Irish","NOCA","NOCA - Alcolo","Natty Daddy","Natural Ice","Natural Light","New Belgium - Fat Tire","New Belgium - Juice Force","Nutrl","Nutrl Lemonade Vrty","Nutrl Lime","Phorm Energy Blue Blitz","Phorm Energy Freedom","Poland Spring","Popwell","Revitalyte","Ryse Energy + Protein","Ryse Fuel","Ryse Protein","Shipyard - Pumpkin Head","Sparkling Ice","Sparkling Ice Caf","Sparkling Ice Energy","Stella Artois","Super Coffee","The Beast - Mean Green","Tivoli - Outlaw","Wormtown - Irish Red"],"Glass":["Bud Light","Busch Light","Concord Craft - Safe Space","Fiddlehead - IPA","Stella Artois","Stoneface - IPA"],"Illuminated Sign":["BL Seltzer Variety","Bud Light","Budweiser","Busch Light","Dos Equis","Fiddlehead - IPA","Good 2 grow","Heineken","Hoop Tea","Kona - Big Wave","Lagunitas - Daytime","Mich Ultra","New Belgium - Fat Tire","Nutrl","Stella Artois"],"Large Tap Marker":["14th Star - Maple Br","14th Star - Mexican Lager","14th Star - N Maple Br","14th Star - Oktoberfest","14th Star - Remix","14th Star - Tribute","14th Star - Valor","1911 - Cider Donut","1911 - Haunted Hayride","1911 - Maple Bourbon Cider","21 Amend - Hell High Water","603 Brew - APL","603 Brew - As You Wish","603 Brew - Beer Hall","603 Brew - Coffee Cake Porter","603 Brew - Hard Seltzer","603 Brew - IPA","603 Brew - Irish Hello","603 Brew - Knuckle","603 Brew - Lono Tiki","603 Brew - Mighty Oak","603 Brew - Mitz BA RIS","603 Brew - Mitz RIS","603 Brew - Octoberfest","603 Brew - Pipes & Drums","603 Brew - Scenic","603 Brew - Seltzer Black Cherry","603 Brew - Slightly Tstd","603 Brew - Smoketoberfest","603 Brew - Straw Wheat","603 Brew - Summa","603 Brew - Toast Pumpkin","603 Brew - Winni","603 Brew - Wood Devil IPA","Able - Auburn","Able - Broad Arrow","Able - Burn the Ships","Able - Emma Wood","Able - Fighting 69th","Able - Gemultich German Lager","Able - Glory Not Prey","Able - Homecoming Pumpkin Ale","Able - Lady of the Lake","Able - Victory Nor Defeat","Athletic - Run Wild","Austin Street - Anniversary","Austin Street - DDH Patina","Austin Street - Florens","Austin Street - Fox Street","Austin Street - Instant Crush","Austin Street - Offset","Austin Street - Patina","Ayinger","BBCO - Barista","BBCO - Creatures Magic","BBCO - Dank Wizard","BBCO - Doom Wizard","BBCO - Elaborate","BBCO - Enchanted","BBCO - Good Company","BBCO - Lighthouse","BBCO - Little Wizard","BBCO - Lunar Wizard","BBCO - Phantom Glow","BBCO - Straw Whale","BBCO - Time Chimp","BBCO - Uncanny Valley","BBCO - Wizard","Banded - Charm","Banded - Dakaiju","Banded - Greenwarden","Banded - Wicked","Banded - Zealot","Battery - Blueberry","Battery - Endless","Battery - Flume","Battery - Flume*2","Battery - Golden Path","Bells - Big hearted","Bells - Christmas Ale","Bells - Kalamazo","Bells - Oberon","Bells - Two Hearted","Berkshire - Apuckalips","Berkshire - Coffehouse Porter","Berkshire - Dandelion","Berkshire - Marzen","Berkshire - Pumpkin","Berkshire - Steel Rail","Bitburger - Premium Pils","Breck Christmas","Breck Vanilla Porter","Bud Light","Bud Select","Budweiser","Busch Light","Captain Eli's","Carlsberg - Lager","Carlson - Berry","Carlson - Harvard Harvest","Carlson - Honey Crisp","Carlson - Oak Hill","Champlain Orch - Kingston Dry","Champlain Orch - Original","Cigar City - Jai Alai","Cigar City - Maduro","Cigar City - Oatmeal Raisin Cookie","Citizen Cider - B Cider","Citizen Cider - BD Apple Pie","Citizen Cider - BD Donut","Citizen Cider - Cran Crush","Citizen Cider - Juicy Haze","Citizen Cider - Mimosa Crush","Citizen Cider - Peach Crush","Citizen Cider - Raspberry Crush","Citizen Cider - Strawb Haze","Citizen Cider - Unified Press","Concord Craft - Apple Crisp","Concord Craft - Blue Coggler","Concord Craft - Conquered","Concord Craft - Four Rivers","Concord Craft - Irish Stout","Concord Craft - Kapital Kolsch","Concord Craft - Oktoberfest","Concord Craft - Pandora Kettle","Concord Craft - Pina Colada","Concord Craft - Pond Hockey","Concord Craft - Safe Space","Concord Craft - Squirrel Fights","Concord Craft - White Mtn White","Deciduous - Easier Operator","Deciduous - Easy Operator","Deciduous - Lollipop Rasp","Deciduous - NH Lager","Dos Equis","Dos Equis Amber","Downeast - Apple Pie","Downeast - Black Cherry","Downeast - Blackberry","Downeast - Caramel Apple","Downeast - Cider Donut","Downeast - Cranberry","Downeast - Drier Side","Downeast - Guava Passion","Downeast - Original","Downeast - Peach Mango","Downeast - Pomegranate","Downeast - Prickly Pear","Downeast - Pumpkin","Downeast - Winter","Elysian Space Dust","Epigram - Liam's Lager","Epigram - Rowdy House","Epigram - Temptation","Equilibrium - Coastline Chromatics","Equilibrium - Dream Wave","Equilibrium - Einsteins Quartet","Equilibrium - Element Carbon","Equilibrium - Field Theory","Equilibrium - Fluctuations","Equilibrium - Light at the end of the Tunnel","Equilibrium - MC2","Equilibrium - Mmm...Osa","Equilibrium - POG Bubbles","Equilibrium - Space Station Dream Lab","Equilibrium - Tidal Balance","Equilibrium - Tomorrow","Equilibrium - Wavelength","Equilibrium - eMCee","Exhibit A - Cats Meow","Exhibit A - Goody Shoes","Exhibit A - Panda Punch","Fiddlehead - Hodad","Fiddlehead - IPA","Fiddlehead - Mastermind","Fiddlehead - Second","Fiddlehead - White","Foundation - Berry Trifle","Foundation - Burnside","Foundation - Epiphany","Foundation - Fetch","Foundation - Raspberry","Founders - All Day Grapefruit IPA","Founders - All Day IPA","Founders - All Day Shandy","Founders - Breakfast Stout","Founders - CBS","Founders - Curmudgeon Old Ale 2016","Founders - Imperial Thorn","Founders - KBS","Founders - Mortal Bloom","Founders - Nitro Rubaeus Rasp Ale","Founders - Porter","Frost - Brown","Frost - Dented","Frost - Double Ponyboy","Frost - Little Lush","Frost - Lush","Frost - Plush","Frost - Research IPA","Frost - Starchild","Gold Road Belgian White","Gold Road Mango Cart","Golden Road AF Mango","Goose - Bourb County","Hacker-Pschorr","Henniker - Ambr App","Henniker - Damn Sure","Henniker - Dinger","Henniker - Dustoff","Henniker - First One Today","Henniker - Flap Jack","Henniker - Flyway","Henniker - Footy Pj's","Henniker - Henni Light","Henniker - Hop Slinger IPA","Henniker - Hugs From","Henniker - King Misanthrope","Henniker - Kolsch","Henniker - Miles & Miles","Henniker - Oktoberfest","Henniker - Picnic","Henniker - Roast","Henniker - Seltzer Baboosic","Henniker - Sour Flower","Henniker - Space Race","Henniker - Trail Buddy","Henniker - West Coast Colab","Henniker - Wrking Man Porter","Industrial - Wrench","Jack's Abby - Banner","Jack's Abby - Blood Orange Wheat","Jack's Abby - Brite as Hell","Jack's Abby - Citrus Wave","Jack's Abby - Copper Legend","Jack's Abby - Extra Layer","Jack's Abby - Framinghammer","Jack's Abby - House Lager","Jack's Abby - Lavenade","Jack's Abby - Porch Fest","Jack's Abby - Post Shift","Jack's Abby - Radler","Jack's Abby - Toy Soldier","Kelsen - Battle Axe","Kelsen - Gallowglass","Kelsen - Paradigm","Kelsen - Spacetown","Kentucky - BBA Imp Milk Stout","Kentucky - Bourbon Barrel Tart Cherry Wheat","Kentucky - Cocoa Porter","Kentucky - Vanilla Cream","Kona - Big Wave","Left Hand - Candy Cane Nitro","Left Hand - Coconut Milk Stout","Left Hand - Man/Hibiscus Belg White Nitro","Left Hand - Mexican Hot Choc Milk Stout","Left Hand - Milk Stout","Lord Hobo - 617 IPA","Lord Hobo - Atomic Black","Lord Hobo - Boomsauce","Lord Hobo - Doomsauce","Lord Hobo - Good Jake","Lord Hobo - Hop Tobaggin","Maine Beer Co - Another One","Maine Beer Co - Dinner","Maine Beer Co - Fall","Maine Beer Co - Lunch","Maine Beer Co - MO","Maine Beer Co - N Mean Tom","Maine Beer Co - Peeper","Maine Beer Co - Red IPA","Maine Beer Co - Spring","Maine Beer Co - Tiny","Maine Beer Co - Waters","Maine Beer Co - Whaleboat","Maine Beer Co - Wolfe's Neck","Mich Ultra","Mighty Squirrel - Cloud Candy","Mighty Squirrel - Dbl Cloud Candy","Mighty Squirrel - Fluff","Mighty Squirrel - Gourdgeous Pumpkin","Mighty Squirrel - Hammer","Mighty Squirrel - Heart","Mighty Squirrel - Kiwi White","Mighty Squirrel - Magic Rain","Mighty Squirrel - Mango Lassi","Mighty Squirrel - Oktoberfest","Mighty Squirrel - Sour Face","Moretti","New Belgium - Fat Tire","New Belgium - Holiday Ale","New Belgium - Juice Force","New Belgium - Juicy Haze","New Belgium - VR 1985 Mango","Newburyport - Plum Island","Old Speckled Hen","Orono - Tubular","Orono - Wicked","Oskar Blues - Dales Pale","Oskar Blues - Dbl Dales Pale","Other Half - Big Necatron Vibes","Other Half - Broccoli","Other Half - Green City","Other Half - Hop Showers","Other Half - Ideal Wave","Other Half - Juice Brawl","Other Half - LACEd in Space","Other Half - Motueka + Galaxy","Other Half - Superfun!","Other Half - Tall Kiwi","Other Half - Tens of Hundreds","Other Half - Ticker Shock","Other Half - We're Happy to Juice You","Paulaner","Peak - Sweet Tarts","Sea Dog - Blood Orange","Sea Dog - Blueberry","Sea Dog - Sun Fish","Shipyard - American Pale Ale","Shipyard - Boatload Berry","Shipyard - Finder Session","Shipyard - Prelude","Shipyard - Pumpkin Head","Shipyard - Signature Series","Shipyard - Smashed Pumpkin","Shipyard - Summer","Shocktop","Shocktop - Pretzel","Some - PB Whoopie","Southern - Caramel Cookie Bar","Southern - Caramel Pumking","Southern - Chestnut Praline","Southern - Irish Cream","Southern - Mokah","Southern - Orange Twist","Southern - Pumking","Southern - Tiramasu","Southern - Warlock","Spaten","Stella Artois","Stoneface - Astral Surf","Stoneface - Berliner Weisse","Stoneface - Coral Star","Stoneface - DDH Full Clip","Stoneface - DDH Mozz","Stoneface - Double Clip","Stoneface - Duct Tape","Stoneface - Duderino","Stoneface - Dwaynes World","Stoneface - Full Clip","Stoneface - Green Duct Tape","Stoneface - IPA","Stoneface - Imaginary Cartwheel","Stoneface - Neon Slick","Stoneface - Oktoberfest","Stoneface - Pink Duct Tape","Stoneface - Porter","Stoneface - Reg Sch Pro","Stoneface - Sunday Sauce","Stoneface - Treat Me","Throwback - Cheek Squeezer","Throwback - Rule Roost","Throwback - Wallis White","True North - Any Tang","True North - Bog Moon","True North - Bright & Early","True North - Coast to Coast","True North - Down By The Bay","True North - Northern","True North - Violet","True North - Winter Woods","True North - Witch","Tuckerman - Headwall Alt","Tuckerman - Pale Ale","Tuckerman - Rock Pile IPA","Upper Pass - Blue Lemon","Upper Pass - Cloud Drop","Upper Pass - First Drop","Victory - Golden Monkey","Von Trapp - Dortmunder","Von Trapp - NZ Pilsner","Von Trapp - Polotmavy","Von Trapp - West Coast","Weihenstephaner - Fiestbier","Weihenstephaner - Hefe","Weihenstephaner - Hefe Dunkel","Weihenstephaner - Kristalweiss","Wicked Weed Pernicious","Wicked Weed Pernicious Haze","Widowmaker - Blue Comet","Widowmaker - Blue Wizard","Widowmaker - Fear","Widowmaker - Green Wizard","Widowmaker - Mindcrawler","Widowmaker - Mt. Doom","Widowmaker - Return to Dust","Widowmaker - Riff","Widowmaker - Riff City","Widowmaker - Spring Wake","Woodland - Festbier","Woodland - NA Beer","Woodland - Ruby Slippers","Wormtown - Be Hoppy","Wormtown - Be Juicy","Wormtown - Be Smooth","Wormtown - Beach Fix","Wormtown - Blizzard","Wormtown - Fresh Patch","Wormtown - Fresh Patch_2","Wormtown - Irish Red","Wormtown - Irish Red_2","Wormtown - Summer","Wormtown - Yard Party","Zero Gravity - 40 Thieves","Zero Gravity - Cone Head","Zero Gravity - Cone Head Haze","Zero Gravity - Duck Duck","Zero Gravity - Evergreen","Zero Gravity - Extra Stout","Zero Gravity - Green State","Zero Gravity - Green State Light","Zero Gravity - Jaws Czech","Zero Gravity - Madonna","Zero Gravity - Oktoberfest","Zero Gravity - Pisolino","Zero Gravity - Powder Jones","Zero Gravity - Shandy","Zero Gravity - Woodchuck","von Trapp - Dunkel","von Trapp - Echo Love","von Trapp - Helles","von Trapp - Oktober","von Trapp - Pilsner","von Trapp - Pine 1769","von Trapp - Radler","von Trapp - Schwarz","von Trapp - Stowe Style","von Trapp - Trosten","von Trapp - Vienna"],"Mirror":["BeatBox Vrty","Bud Light","Budweiser"],"Other":["603 Brew - Coffee Cake Porter","603 Brew - IPA","603 Brew - Knuckle","603 Brew - Sparkle Bomb","603 Brew - Summa","603 Brew - Toast Pumpkin","603 Brew - Winni","Arizona","Arizona Hard Lemon T","Athletic - Free Wave","Athletic - Geralts Gold","Athletic - Lite","Athletic - Oktoberfest","Athletic - Run Wild","Athletic - Upside Dawn","Bud Light","Bud Light Next","Budweiser","Busch","Busch Light","Busch Light Peach","Cabot","Citizen Cider - Dirty Mayor","Clearly Canadian Country Raspberry","Clearly Canadian Mountain Blackberry","Clubtails","Concord Craft - Pond Hockey","Concord Craft - White Mtn White","Daily's Cocktails","Deep River","Dos Equis","Dos Equis Amber","Downeast - Blackberry","Downeast - Caramel Apple","Downeast - Cider Donut","Downeast - Cranberry","Downeast - Original","Downeast - Peach Mango","Downeast - Pomegranate","Downeast - Prickly Pear","Downeast - Pumpkin","Downeast - Winter","Fiddlehead - IPA","Ghost Energy","Gold Road Mango Cart","Good 2 grow","Good Boy J Daly","Heineken","Henniker - Flap Jack","Henniker - Picnic","Henniker - Sour Flower","Henniker - Wrking Man Porter","Jack's Abby - Extra Layer","Joe Tea","Johny Bootlegger","Kona - Big Wave","Lagunitas - Hoppy Refresher","MISC Encompass Conv Items","Mich Ultra","Misc Keg Other","Natty Daddy","Nutrl","Nutrl Lemonade Vrty","Phorm Energy Freedom","Popwell","Shipyard - Pumpkin Head","Snapple","Sparkling Ice","Sparkling Ice Caf","Stella Artois","Stoneface - Astral Surf","Stoneface - Crown Shy","Stoneface - Duderino","Stoneface - IPA","Stoneface - Sunday Sauce","Stoneface - Town Car","Tivoli - Outlaw","von Trapp - Dunkel"],"Promo Item":["Athletic - Run Wild","Bud Light","Budweiser","Dos Equis","Downeast - Original","Fiddlehead - IPA","Kona - Big Wave","Mich Ultra","Nutrl","Popwell","Stoneface - IPA"],"Small Tap Marker":["14th Star - Valor","1911 - Cider Donut","603 Brew - Coffee Cake Porter","603 Brew - IPA","603 Brew - Summa","603 Brew - Toast Pumpkin","603 Brew - Winni","Able - Burn the Ships","Athletic - Run Wild","Berkshire - Coffehouse Porter","Berkshire - Marzen","Bud Light","Bud Select","Budweiser","Captain Eli's","Concord Craft - Four Rivers","Concord Craft - White Mtn White","Deciduous - Lollipop Rasp","Downeast - Apple Pie","Downeast - Blackberry","Downeast - Cider Donut","Downeast - Guava Passion","Downeast - Original","Downeast - Pomegranate","Downeast - Winter","Elysian Space Dust","Fiddlehead - IPA","Fiddlehead - Second","Fiddlehead - White","Frost - Lush","Frost - Research DIPA","Gold Road Mango Cart","Goose - Bourb County","Jack's Abby - Extra Layer","Jack's Abby - Porch Fest","Kelsen - Battle Axe","Kona - Big Wave","Lord Hobo - Boomsauce","Maine Beer Co - Dinner","Maine Beer Co - Lunch","Mich Ultra","Mighty Squirrel - Cloud Candy","New Belgium - Fat Tire","New Belgium - Juicy Haze","Sea Dog - Blueberry","Shipyard - Pumpkin Head","Some - PB Whoopie","Stella Artois","Stoneface - Green Duct Tape","Stoneface - IPA","Throwback - Wallis White","Tuckerman - Rock Pile IPA","Wormtown - Be Hoppy","Wormtown - Blizzard","Wormtown - Blizzard_2","Wormtown - Fresh Patch","Zero Gravity - Green State","Zero Gravity - Jaws Czech","Zero Gravity - Pisolino","von Trapp - Dunkel","von Trapp - Pilsner","von Trapp - Radler"],"Umbrella":["BL Seltzer Variety","BUD LIGHT SELTZER PINK LEMONADE","Bud Light","Budweiser","Dos Equis","Fiddlehead - IPA","Kona - Big Wave","Landshark Lager","Mich Ultra","Mighty Squirrel - Cloud Candy","NOCA","Nutrl","Poland Spring","Sparkling Ice","Stella Artois","Zero Gravity - Cone Head"]};
const CUSTOMERS_BY_REP = {"adennis":["1750-TAPHOUSE","AMERICAN LEGION POST 98 - MERRIMACK","BLUE BEAR HOSPITALITY LLC","BUCKLEY'S GREAT STEAKS","COLLEGE CONVENIENCE","COMMON MAN - MERRIMACK","COPPER DOOR - BEDFORD","DON RAMON","DW HIGHWAY MOBIL INC","FRONTERA GRILL OF NASHUA","GAME CHANGER SPORTS BAR & GRILL","GIABELLA'S","GIORGIO'S TRATTORIA - MERRIMACK","HANNAFORD #8436 - BEDFORD - KILTON RD","HOMESTEAD RESTAURANT & TAVERN","JADE DRAGON-MERRIMACK","K2 MOBIL MART","LA VAKA MEXICAN RESTAURANT","LEO'S BAR & GRILL","LOBSTER BOAT RESTAURANT","MERRIMACK TEN PIN CENTER","NEW HARVESTER MARKET INC","NEW WA TOY","PASSACONAWAY COUNTRY CLUB","PINARDVILLE ATHLETIC CLUB","PIZZICO - MERRIMACK","PRESSED CAFE - BEDFORD","RIVER ROAD TAVERN","SHAW'S #3505 - MERRIMACK - DWH","SMOKE SHACK CAFE","T-BONES - BEDFORD","TAVERN IN THE SQUARE BEDFORD LLC","THIRSTY MOOSE","TOMAHAWK BUTCHERY & TAVERN (REST)","TORTILLA FLAT","TWINS SMOKE SHOP","UNO PIZZERIA & GRILL - AMHERST ST - NASHUA","VFW #8641 - MERRIMACK","VILLAGE TRESTLE (THE)","WILLIE JEWELL'S OLD SCHOOL BBQ"],"amartin":["77 SPORTS BAR & LOUNGE","AMERICAN LEGION POST 3 - NASHUA","BACKSTREET BAR & GRILL LLC","BAR","CASA VIEJA MEXICAN GRILL","CASEY MAGEE'S","CHICKEN N CHIP'S","FODY'S TAVERN (NASHUA)","HANNAFORD #8183 - HUDSON","LA CARRETA - NASHUA","LA HACIENDA DEL RIO","LATIN BAKERY & MULTISERVICE INC","LYNN'S 102 TAVERN","MIKES ITALIAN KITCHEN","NEW NAN KING RESTAURANT","ODD FELLOWS BREWING COMPANY","PANDA GOURMET","PHO TAI LOC","RIVERWALK BAKERY & CAFE","ROYAL PIZZA","SAKURA","SAN FRANCISCO KITCHEN INC","SHAW'S #0113 - NASHUA - MAIN ST","SLADES FOOD & SPIRITS","SPECTACLE MANAGEMENT INC","SURF RESTAURANT INC","T&T WAY","TOSTAO'S TAPAS BAR","UNION PUBLIC HOUSE","WHOLE FOODS MARKET - NASHUA - BAR"],"aparente":["50 EAST DERRY RD CONVENIENCE - REST","ANGUS LEA GOLF COURSE","APPLEBEES - DERRY","BACKSTREET BAR & GRILL LLC","BAR","CHICKEN N CHIP'S","CIRCLE K #7234 - DERRY - 28 BYPASS","COACH STOP","DESTINATION INDIA RESTAURANT & BAR","DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)","FANG CHEN'S RESTAURANT","FODY'S TAVERN (DERRY)","FODY'S TAVERN (NASHUA)","FRIENDLY REDS - DERRY","GRUMPY'S BAR & GRILL","HARE OF THE DAWG BAR & GRILL","HIDDEN CREEK COUNTRY CLUB","HIDDEN PIG (THE)","KINGSTON VETS CLUB INC","LA CARRETA - DERRY","LUCKY MOOSE CASINO & TAVERN (THE)","LUI LUI - NASHUA","LUK'S BAR & GRILL","LYNN'S 102 TAVERN","MICKEY'S NY PIZZA","NATIONAL CLUB (THE)","NEW NAN KING RESTAURANT","PANDA GOURMET","PASSACONAWAY COUNTRY CLUB","PEDDLER'S DAUGHTER","PENUCHE'S ALE HOUSE-NASHUA","PIZZICO - ITALIAN RESTAURANT - NASHUA","PIZZICO - MERRIMACK","PRESSED CAFE - BEDFORD","RED ROBIN BURGERS #515 NASHUA","RICK'S THE SPIRIT OF KINGSTON","RIVER CASINO & SPORTS BAR (THE)","RIVER ROAD TAVERN","ROMANO'S PIZZA LLC","SAKURA","SAYDES RESTAURANT INC.","SHAW'S #0113 - NASHUA - MAIN ST","SHAW'S #3483- DERRY","SHAW'S #3510 - NASHUA - ROYAL RIDGE","SUN ASIAN BISTRO","T-BONES - DERRY","T-BONES - HUDSON","THE NEST PUB AND GRILL","THIRSTY MOOSE","TOOKY MILLS PUB","TUPELO VENUE","TWINS SMOKE SHOP"],"bgermano":["ATHEN'S PIZZA","BEAVER STREET MARKET","BRETWOOD GOLF COURSE","CHESHIRE VILLAGE PIZZA","COURTYARD KEENE DOWNTOWN","CRAFT MARKET AT RIVERSIDE","CUMBERLAND FM #5425 - KEENE","DOG DAYS CRAFT BEER","HANNAFORD #8163 - KEENE","MARKET BASKET #64 SWANZEY","PRICE CHOPPER #208 - KEENE","SEVEN ELEV #32504 - KEENE","SEVEN ELEV #32504 B- KEENE","STAGE HANDS RESTAURANT","SWANZEY NEIGHBOR","T-BIRD MINI MART - KEENE","T-BIRD MINI MART - W. SWANZEY","WAL-MART #3549 - KEENE"],"bhanscom":["AYASOFIA MEDITERRANEAN RESTAURANT","COMMON MAN - WINDHAM","FRIENDLY RED'S - WINDHAM","OLD SCHOOL BAR AND GRILL","ON THE CORNER GRILL","WASABI SUSHI HIBACHI INC.","WINDHAM RESTAURANT (THE)"],"ddooling":["BEER STORE LLC (THE) - SALEM","CAMPBELL'S SCOTTISH HIGHLAND GOLF COURSE","CANOBIE LAKE PARK","CHILI'S - SALEM","CITY LINE MARKET (NEW)","COPPER DOOR - SALEM","DERRY SALEM ELKS 2226","DUSTY'S CONVENIENCE INC.","FIGARO'S MARTINI BAR + KITCHEN","FUEGO LATIN FUSION BAR & RESTAURANT","GERARDO'S TRATTORIA AMALF","GRANFANALLYS -PIZZA PUB","GRANFANALLYS PIZZA PUB","HOWIE GLYNN - DERRY","HOWIE GLYNN - SALEM","HOWIE GLYNN - WINDHAM - COBBETS RD.","ISLAND POND CONVENIENCE","KEV'S COUNTRY STORE","LIVE! CASINO SALEM","MCKINNON'S MARKET PLACE","MICHAELS FLATBREAD PIZZA CO.","NEW CHIEF WOK","OLD SCHOOL BAR AND GRILL","ON THE CORNER GRILL","PELHAM STREET BLACK WATER GRILL","PEPPERS PUB (NEW)","PRESSED CAFE - SALEM","RALPHIE'S CAFE ITALIANO","SALEM CONVENIENCE STORE","SAYDES RESTAURANT INC.","SEVMAR MEDITERRANEAN BISTRO","SMOKE N BARLEY - SALEM","STATELINE PAYSAVER","T-BONES - SALEM","TAVERN IN THE SQUARE SALEM LLC","TIO JUAN'S MARGARITAS MEXICAN REST-SALEM"],"dtaylor":["BUFFALO WILD WINGS GRILL & BAR - NASHUA"],"eleahy":["50 EAST DERRY RD CONVENIENCE - REST","50 EAST DERRY ROAD CONVENIENCE","AMPHORA RESTAURANT","APPLEBEES - DERRY","CUMBERLAND FM #5545 - PLAISTOW","DERRY QUICK MART","FANG CHEN'S RESTAURANT","FODY'S TAVERN (DERRY)","FRIENDLY REDS - DERRY","HALCYON CLUB","HARE OF THE DAWG BAR & GRILL","HOWIE GLYNN & SONS CONVENIENCE","HYLA BROOK ESTATE","LA CARRETA - DERRY","MARKET BASKET #25 PLAISTOW","PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD","PLAISTOW CIGAR COMPANY","PPC KITCHEN & BAR","SHAW'S #3483- DERRY","SHAW'S #3669 - PLAISTOW","SPEEDWAY #46190 - DERRY","SUMO SUSHI","SUN ASIAN BISTRO","SUSHI TIME RESTAURANT","T-BONES - DERRY"],"epaquette":["99 REST - W.LEB","APPLEBEES - W.LEB #6732","BRADFORD MARKET","BUBBA'S BAR AND GRILLE","CASA JALISCO BAR & GRILL","CHILI'S - W.LEB","DADDY'S PIZZA","FORBES TAVERN AND EVENTS","FORESTERS OF AMERICA","GUSANOZ MEXICAN REST","HELEN'S PLACE","IMPERIAL BUFFET & LOUNGE","JALISCO MEXICAN BAR & GRILL","LEBANON LODGE OF ELKS","LEBANON VILLAGE PIZZA","MOLLYS RESTAURANT","PETER CHRISTIANS TAVERN","POLISH AMER CITIZENS CLUB-CLAREMONT","RANCHO VIEJO MEXICAN FOOD AND CANTINA","SAKANA JAPANESE RESTAURANT","SALT HILL PUB - NEWBURY","SALT HILL PUB - NEWPORT","SAWTOOTH KITCHEN LLC","STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)","STOCKWELL RESTAURANT","SWEET FIRE BARBECUE AND TAKE OUT","T-BIRD MINI MART - CLAREMONT-WASHINGTON ST","THREE TOMATOES TRATTORIA","ZIGGY'S PIZZA - W. LEB"],"eplatt":["MARKET BASKET #25 PLAISTOW","PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD","PLAISTOW MINI EXPRESS","PPC KITCHEN & BAR","SHAW'S #3669 - PLAISTOW","THE KITCHEN BY JTAPS"],"gconnor":["99 REST - SALEM","DREO FOOD AND DRINK","KASHMIR INDIAN CUISINE","LIM'S SPORTS BAR & CAFE","LUNA BISTRO","MARKET BASKET #06 SALEM","MARKET BASKET #31 SALEM","PAR28","RED ROBIN GOURMET BURGERS - SALEM","SHAKING SEAFOOD","TOMO STEAKHOUSE"],"ggage":["99 REST - NASHUA","ALAMO TEXAS BAR-B-QUE & TEQUILA BAR","AMERICAN LEGION POST 10 - WILTON","AMERICAN LEGION POST 13 - GREENVILLE","AMERICAN LEGION POST 23 - MILFORD","CHRYSANTHI'S","DRIVING RANGE (THE) & MARTY'S ICE CREAM","FAMILY PIZZA AND ROAST BEEF OF NASHUA","GATE CITY CASINO","GIORGIO'S RISTORANTE - MILFORD","HAMPSHIRE DOME (THE)","KEGLERS DEN","NASHUA ELKS LODGE 720","OLDE KILKENNY PUB","OLDE TOWNE TAVERN","PIZZERIA ZACHARIA","ROUTE 13 STATELINE CONV MART","STONECUTTERS PUB","THE BRICKHOUSE RESTAURANT AND BREWERY","TJ'S DELI AND CATERING PIZZA AND SUBS (CATERING)","VFW #4368 - MILFORD"],"jarquiett":["110 GRILL - W. LEB","99 REST - W.LEB","AMERICAN LEGION POST 29 - CLAREMONT","APPLEBEES - W.LEB #6732","BOLOCO","DADDY'S PIZZA","DUNK'S SPORTS GRILL","GUSANOZ MEXICAN REST","HELEN'S PLACE","IMPERIAL BUFFET & LOUNGE","JESSES STEAKHOUSE","KITCHEN 56","LEBANON VILLAGE PIZZA","LITTLE BROTHERS BURGERS","LUI LUI - WEST LEBANON","MOLLYS RESTAURANT","MURPHY'S ON THE GREEN","NEWPORT VILLAGE PIZZA","PETER CHRISTIANS TAVERN","PLEASANT ST SMOKE & BEER","POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES","PROCTORS GENERAL STORE","SALT HILL PUB - LEBANON","SALT HILL PUB - NEWBURY","SAWTOOTH KITCHEN LLC","SNAX","STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)","SUNA RESTAURANT","SWEET FIRE BARBECUE AND TAKE OUT","TAVERNE ON THE SQUARE LLC","THE REFINERY","ZIGGY'S PIZZA - W. LEB"],"jaustin":["A-1 PIZZA & GRILL HINSDALE","ALLTOWN MARKET 202767- WINCHESTER","AMERICAN LEGION POST 4 - KEENE","APPLEBEES - KEENE #6714","BIG DEAL - KEENE","BIG DEAL - SPOFFORD","BRICKHOUSE PIZZA & WINGS","CARRS STORE (TBIRD DUBLIN)","CHILI'S - KEENE","CLIFFY'S PUB","DIPLOMAT (THE)","DOLLAR GENER #17668 - TROY","GET-N-GO","GUERRILLA GRILL","KEENE COUNTRY CLUB INC","KILKENNY PUB - KEENE","LAB'N LAGER KEENE","LOCAL BURGER OF KEENE","LONGHORN STEAK #0003 - KEENE","MAIN CRUST CO.","MAIN STREET MARKETPLACE","MAIN STREET MINI MART","MARGARITA'S - KEENE","MARLBOROUGH CTRY CONVENIENCE","MARLBOROUGH FOOD MART","MI JALISCO - KEENE","MINUTE MART","NOBLE RAMEN HOUSE","PARK AVE DELI + MARKET","PIERRE'S PLACE","RIVERSIDE GROCERY","RTE. 63 COUNTRY STORE","RUSTIC TABLE (THE)","SANDRI STOP - HINSDALE","SANDRI STOP MART - KEENE","SMOKING TROUT (THE)","SUMMIT STORES - KEENE","T-BIRD MINI MART - HINSDALE","TEMPESTA'S","THE NUCHE TAVERN","THE PERCH","TOWN SQUARE TAVERN","TROY DELI & MARKET PLACE","VFW #3968 - WINCHESTER","VFW #799 - KEENE","WAL-MART #1907 - HINSDALE","WEST CHESTERFIELD SHELL #200643","YANKEE LANES / KEENE BOWL","YELLOW BELL CAFE"],"jcannamucio":["ATKINSON RESORT AND COUNTRY CLUB","ATKINSON SUNOCO","AXE TOWNE","CARRIAGE TOWN BAR & GRILL","DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)","FLACO'S MEXICAN RESTUARANT & CANTINA","GRUMPY'S BAR & GRILL","HANNAFORD #8190 - HAMPSTEAD","HENHOUSE BAR & GRILL","JAMISON'S","KINGSTON VETS CLUB INC","NOURIA ENERGY # 1268 - HAMPSTEAD","RICK'S THE SPIRIT OF KINGSTON","SADDLE UP SALOON","THE NEST PUB AND GRILL"],"jcaron":["AMIGOS MEXICAN CANTINA","MARKET BASKET #39 NASHUA - NORTHWEST BLVD","SHAW'S #2492 - MILFORD","SMOKE HAUS"],"jgiuffrida":["99 REST - SALEM","AR SMOKE BEER & CIGAR","DREO FOOD AND DRINK","LIM'S SPORTS BAR & CAFE","LONGHORN STEAK #5278 - AMHERST","MARKET BASKET #06 SALEM","MARKET BASKET #31 SALEM","NAJI'S PIZZA","PAR28","PENALTY BOX BAR & GRILL","RED ROBIN GOURMET BURGERS - SALEM","SAL'S PIZZA OF MILFORD","SHAKING SEAFOOD","STONECUTTERS PUB","TOMO STEAKHOUSE"],"jgrumblatt":["APPLESEED LAKESIDE REST","BRADFORD MARKET","BUBBA'S BAR AND GRILLE","CIRCLE K #7247 - ANDOVER","FORESTERS OF AMERICA","GD CATERING LLC","HANNAFORD #8246 - NEW LONDON","JAKES MARKET AND DELI - GEORGES MILLS","JAKES MARKET AND DELI- NEW LONDON","JALISCO MEXICAN BAR & GRILL","LAKE SUNAPEE COUNTRY CLUB","LAKE SUNAPEE YACHT CLUB","LITTLE BROTHERS BURGERS","LOYAL ORDER OF MOOSE - NEWPORT","MARKET BASKET #53 CLAREMNT","NEW LONDON INN/COACH HOUSE RESTAURANT","NEWBURY DELI","NEWBURY PALACE PIZZA","NEWPORT GOLF CLUB","NEWPORT VETERAN'S CLUB","PETER CHRISTIANS TAVERN","RAGGED MOUNTAIN","SALT HILL PUB - NEWBURY","SALT HILL PUB - NEWPORT","SHAW'S #4534 - NEWPORT","STOCKWELL RESTAURANT","SUNA RESTAURANT","THE BLUE CANOE","THE REFINERY","VAIL RESORT/ MOUNT SUNAPEE","WILDWOOD SMOKEHOUSE"],"jjohnson":["AMERICAN LEGION POST 22 - GRAFTON","BARK & BEVY CO.","CANTORE'S PIZZA","ENTERTAINMENT CINEMAS - LEBANON","GUSANOZ MEXICAN REST","HANOVER INN","JESSE'S STEAKHOUSE","JESSES STEAKHOUSE","KITCHEN 56","MICKEYS 603","MOLLYS RESTAURANT","MURPHY'S ON THE GREEN","POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES","RAMUNTO'S BRICK & BRICK & BREW PIZZERIA-HANOVER","SNAX","UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO","ZIGGY'S PIZZA - W. LEB"],"jmeharg":["ALL IN ONE MARKET LLC","AMERICAN LEGION POST 59 - HILLSBORO","ANGUS LEA GOLF COURSE","ANTRIM MARKET","APPLESEED LAKESIDE REST","BLACK BIRD MARKET AND DELI","BLUE BEAR HOSPITALITY LLC","BLUE BEAR INN","BRADFORD MARKET","BUFFALO BO'S","CHARTWELL'S DINING SERVICES","CIRCLE K #7230 - HILLSBORO","COUNTRY SPIRIT RESTAURANT & TAVERN","CROTCHED MOUNTAIN SKI AREA","DANIEL'S PUB INC","DELAY'S HARVESTER MARKET","HANNAFORD #8311 - GOFFSTOWN","HILLSBORO HOUSE OF PIZZA","KAT'S COUNTRY CORNER","LEO'S BAR & GRILL","MOBIL ON THE RUN #200626 - HENNIKER","MOLLY'S TAVERN & RESTAURANT","NEW HARVESTER MARKET INC","PATS PEAK","RIVERSIDE GRILLE","RUSTIC ROSE TAVERN","SAMPAN CHINESE RESTAURANT","SHAW'S #4514 - HILLSBORO","SNACKSHOT CATERING","STONEBRIDGE COUNTRY CLUB","SULLY'S SUPERETTE","T-BIRD MINI MART - ANTRIM","TAVERN ON THE GREENS","TOLL BOOTH TAVERN (THE)","TOOKY MILLS PUB","U.S. 202 EXPRESS MINI MART INC","VILLAGE TRESTLE (THE)","WASHINGTON GENERAL STORE REST","ZOOMIES CORNER MARKET"],"jmorse":["AMERICAN LEGION POST 29 - CLAREMONT","AR VILLAGE STORE","BIRNEY'S MINI MART","CASA JALISCO BAR & GRILL","CIRCLE K #7204 - NEWPORT","CIRCLE K #7240 - GRANTHAM","CLAREMONT COUNTRY CLUB","CLAREMONT LODGE OF ELKS","CLAREMONT MOBIL","CLAREMONT OPERA HOUSE","COMMON MAN - CLAREMONT","CROYDON GENERAL STORE","CrowBAR","DADDY'S PIZZA","FORBES TAVERN AND EVENTS","HANNAFORD #8119 - CLAREMNT","HELEN'S PLACE","IMPERIAL BUFFET & LOUNGE","JIFFY MART #200431 - CLAREMONT","KJ'S PIZZA & SUBS","LEO'S ONE STOP","MARKET BASKET #53 CLAREMNT","MDP MOTORSPORTS PROMOTIONS LLC","MERIDEN DELI MART","NEWPORT MEAT MARKET","OM SHELL FOOD","PLEASANT ST MOBIL","PLEASANT ST SMOKE & BEER","POLISH AMER CITIZENS CLUB-CLAREMONT","POOR THOMS TAVERN","RAMUNTOS - CLAREMONT","RANCHO VIEJO MEXICAN FOOD AND CANTINA","RUM BROOK MARKET","RUM BROOK-MARKET","SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )","SHOP EXPRESS","SUGAR RIVER MARKET & DELI","SWEET FIRE BARBECUE AND TAKE OUT","T-BIRD MINI MART - CLAREMONT-CHARLESTOWN RD","T-BIRD MINI MART - CLAREMONT-WASHINGTON ST","TAVERNE ON THE SQUARE LLC","THE 12% SOLUTION","TREMONT HOUSE OF PIZZA","VFW #808 - CLAREMONT","WAL-MART #1975 - CLAREMONT"],"jsewall":["110 GRILL - W. LEB","99 REST - W.LEB","APPLEBEES - W.LEB #6732","APPLEKNOCKERS STORE","ARIANA'S RESTAURANT","BLACK MAGIC MEXICAN","BUDDY T'S","CHILI'S - W.LEB","CIRCLE K #7245 - HANOVER","CIRCLE K #7246 - W.LEB","DISCOUNT BEVERAGE KING W. LEB","DOWD'S COUNTRY INN & LATHAM HOUSE TAVERN","DUNK'S SPORTS GRILL","FOUR CORNERS GENERAL STORE","HANNAFORD #8266 - W.LEB","LEBANON LODGE OF ELKS","LEBANON VILLAGE PIZZA","LUI LUI - WEST LEBANON","LYME COUNTRY STORE","MERIDEN DELI MART","MOLLYS RESTAURANT","NEST KITCHEN & CAFE (THE)","NH-VT SMOKE & BEVERAGE OUTLET INC","ORE MILL BAR & GRILLE","PATTERSON GROCERY & DELI","PEYTON PLACE RESTAURANT","POOR THOMS TAVERN","REVO CASINO AND SOCIAL HOUSE","SALT HILL PUB - LEBANON","SAWTOOTH KITCHEN LLC","SHAW'S #4555 - W.LEB","SHAWNEE GENERAL STORE","STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)","STILL NORTH BOOKS & BAR","STINSON'S VILLAGE STORE","TACOS Y TEQUILA HANOVER","TARGET # 3401 - W. LEBANON","THREE TOMATOES TRATTORIA","UPPER VALLEY EVENT CENTER","WEATHERVANE - W.LEB","WICKED TASTY","WICKED TASTY (CATERING)"],"kford":["HOUSE SALES","SUN BAR & GRILL"],"kpeacock":["JAMISON'S","THIRSTY MOOSE"],"krogers":["1750-TAPHOUSE","BUDGET GAS & FOOD MART","CIRCLE K #7263 - BEDFORD - WHITE AVE","COPPER DOOR - BEDFORD","HANNAFORD #8436 - BEDFORD - KILTON RD","K2 MOBIL MART","MARKET BASKET #71 BEDFORD","MURPHY'S TAPROOM AND CARRIAGE HOUSE","NEW WA TOY","PINARDVILLE ATHLETIC CLUB","PRESSED CAFE - BEDFORD","RIVER ROAD TAVERN","T-BONES - BEDFORD","X-GOLF BEDFORD"],"lnorton":["1750-TAPHOUSE","BEDFORD VILLAGE INN & REST.","CHEN YANG LI RESTAURANT BY KFZ","CIRCLE K #7233 - GOFFSTOWN","CIRCLE K #7259 - BEDFORD - TECHNOLOGY DR","CIRCLE K #7263 - BEDFORD - WHITE AVE","COPPER DOOR - BEDFORD","ENERGY NORTH #2219 - SALEM - N.BROADWAY","EVVIVA TRATTORIA - BEDFORD","FRIENDLY RED'S - WINDHAM","HANNAFORD #8311 - GOFFSTOWN","HANNAFORD #8436 - BEDFORD - KILTON RD","KARMA SMOKE BEER & WINE","LA VAKA MEXICAN RESTAURANT","MANCHESTER COUNTRY CLUB","MARKET BASKET #71 BEDFORD","MURPHY'S TAPROOM AND CARRIAGE HOUSE","NEW WA TOY","NH SPORTSPLEX","OLD SCHOOL BAR AND GRILL","ON THE CORNER GRILL","PINARDVILLE ATHLETIC CLUB","PRESSED CAFE - BEDFORD","RIVER ROAD TAVERN","SHAW'S #0686 - WINDHAM","SUNSHUI ASIAN CUISINE","T-BONES - BEDFORD","THE FRIENDLY TOAST - BEDFORD","VILLAGE TRESTLE (THE)","WINDHAM RESTAURANT (THE)","X-GOLF BEDFORD"],"lortiz":["BUFFALO WILD WINGS GRILL & BAR - NASHUA","BURTON'S GRILL","CHILI'S - NASHUA - DW HWY","LONGHORN STEAK #5457 - NASHUA","LUI LUI - NASHUA","MARKET BASKET #13 NASHUA - DW HWY","NOT YOUR AVERAGE JOE'S","PIZZICO - ITALIAN RESTAURANT - NASHUA","QUICK MART - NASHUA","RED ROBIN BURGERS #515 NASHUA","SHAW'S #3510 - NASHUA - ROYAL RIDGE","TARGET #1228 - NASHUA - DWH","THE FRIENDLY TOAST - NASHUA"],"maanderson":["ACE DISCOUNT CIGARETTES","AMERICAN LEGION POST 100 - PELHAM","AXE PLAY","AYOTTES & SMOKIN' JOES PREMIUM CIGARS","CALI B HUDSON","FRIENDLY RED'S - HUDSON","GAGE HILL FARM","GOLDEN DRAGON RESTAURANT","GRUMPY'S CIGARS AND LOUNGE","HIDDEN PIG (THE)","JUKK INC","KETTLEHEAD BREWING CO - NASHUA","LUCKY MOOSE CASINO & TAVERN (THE)","LUK'S BAR & GRILL","MAIN ST GYRO","MARGARITAS MEXICAN RESTAURANT-NASHUA","NASH CASINO","NASHUA COUNTRY CLUB","NATIONAL CLUB (THE)","NEW NAN KING RESTAURANT","PATEL'S MAMMOTH CONVENIENCE","PEDDLER'S DAUGHTER","PENUCHE'S ALE HOUSE-NASHUA","PINE VALLEY GOLF COURSE","R & B SUPERETTE","RAY'S STATE LINE","RUSTY LANTER MARKET #0004","SOHO RESTAURANT","SPIT BROOK MARKET","STROKERS","T-BONES - HUDSON","THE SPICE","TOBACCO JUNCTION - HUDSON","ZO'S PLACE"],"mbertolami":["21B BAR AND GRILL","APPLEBEES - KEENE #6714","BRICKHOUSE PIZZA & WINGS","CHA'S GEM SHOP AND CONV","CHILI'S - KEENE","DIAMOND PIZZA","DINNER TABLE REST","DIPLOMAT (THE)","EMMAS 321","GUERRILLA GRILL","ITALIAN CLUB","KEENE COUNTRY CLUB INC","KILKENNY PUB - KEENE","MAIN CRUST CO.","MAMA MCDONOUGH'S IRISH PUB","MARGARITA'S - KEENE","MEXICA MEXICAN RESTAURANT","TEMPESTA'S","THE NUCHE TAVERN","VFW #3968 - WINCHESTER"],"mblais":["FRIENDLY RED'S - WINDHAM","INDIAN ROCK MARKET & SMOKE SHOP"],"mcanavan":["LUK'S BAR & GRILL","NATIONAL CLUB (THE)"],"ncavallo":["102 SMOKE SHOP & MARKET","50 EAST DERRY RD CONVENIENCE - REST","50 EAST DERRY ROAD CONVENIENCE","AMPHORA RESTAURANT","APPLEBEES - DERRY","BILL FLYNNS WINDHAM CC INC","BUXTONS PIZZA","CUMBERLAND FM #5409 - DERRY","DESTINATION INDIA RESTAURANT & BAR","FANG CHEN'S RESTAURANT","FODY'S TAVERN (DERRY)","FRIENDLY REDS - DERRY","HANNAFORD #8016 - DERRY","HARE OF THE DAWG BAR & GRILL","HIDDEN VALLEY BAR & GRILL","HYLA BROOK ESTATE","JR'S CONVENIENCE","LA CARRETA - DERRY","MICKEY'S NY PIZZA","NEW ENGLAND SPORTS CENTER","SHAW'S #3483- DERRY","SUN ASIAN BISTRO","T-BONES - DERRY","TUPELO VENUE","VFW #1617 - DERRY","WAL-MART #1753 - DERRY"],"pbelanger":["ALLTOWN MARKET #200311- PETERBOROUGH","ALLTOWN MARKET 202767- WINCHESTER","ARLINGTON INN & TAVERN (THE)","BANTAM GRILL","BOWLING ACRES","BRADYS BAR AND GRILL","CHA'S GEM SHOP AND CONV","COOPER'S HILL","EMMAS 321","FAMILY DOLLAR #8262 - WINCHESTER","HANNAFORD #8180 - RINDGE","HARLOWS PUBLIC HOUSE","HOMETOWN IRVING","JM NORTH OF THE BORDER","MAIN STREET MINI MART","MAMA MCDONOUGH'S IRISH PUB","MARKET BASKET #47 RINDGE","MEXICA MEXICAN RESTAURANT","MI JALISCO - PETERBORO","MONADNOCK COUNTRY CLUB","MR MIKE'S - FITZWILLIAM","MR MIKE'S - JAFFREY","NEW WORLD GAS - RINDGE","PAPAGALLOS RESTAURANT","PHOENIX SMOKEHOUSE AND TAQUERIA","RUSTIC TABLE (THE)","SHATTUCK GOLF AND DUBLIN ROAD TAPROOM","SHAW'S #4694 - PETERBORO","STATELINE GROCERY'S","T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676","VFW #3968 - WINCHESTER","VFW SOCIAL CLUB","WAL-MART #2057 - RINDGE","WATERHOUSE BISTRO","WEST OF THE BORDER","WHIRLING VAPORS","WOODBOUND INN"],"pvoniderstin":["AMERICAN LEGION POST 23 - MILFORD","AMHERST COUNTRY CLUB","AMIGO'S MEXICAN CANTINA","AMIGOS MEXICAN CANTINA","APPLEBEES - NASHUA Amherst St","BAR ONE","BIRCHWOOD INN (THE)","BISTRO 603","BOWLING ACRES","CASEY MAGEE'S","CHILI'S - NASHUA - DW HWY","CHRYSANTHI'S","COURTYARD BY MARRIOTT - NASHUA","EL TAPATIO RESTAURANTE MEXICANO LLC","EVVIVA TRATTORIA - NASHUA","FODY'S TAVERN (NASHUA)","GIORGIO'S RISTORANTE - MILFORD","GRILL 603","HALUWA","KAT'S COUNTRY CORNER","LAFAYETTE CLUB A.C.","MI JALISCO - PETERBORO","MILANO HOUSE OF PIZZA-NASHUA","NATIONAL CLUB (THE)","OLDE KILKENNY PUB","OLDE TOWNE TAVERN","POLISH AMERICAN CLUB-NASHUA","RILEY'S PLACE","ROUTE 13 STATELINE CONV MART","SAKE HOUSE","SAMPAN CHINESE RESTAURANT","SHAW'S #0484 - LONDERRY","SHORTY'S MEXICAN ROADHOUSE","SURF RESTAURANT INC","TACO TIME COCINA & CANTINA","TEQUILA JALISCO MEXICAN CUISINE AND CANTINA","THE BRICKHOUSE RESTAURANT AND BREWERY","THE HANCOCK MARKET","THE OVERLOOK GOLF CLUB","THIRSTY MOOSE","TOOKY MILLS PUB","VFW #4368 - MILFORD","WAL-MART #1796 - AMHERST","WATERHOUSE BISTRO","WILLIE JEWELL'S OLD SCHOOL BBQ"],"pwollert":["21 ROXBURY BAR & GRILL","ALSTEAD GENERAL STORE","ALYSONS ORCHARD","AMERICAN LEGION POST 4 - KEENE","BENDER'S BAR AND GRILL","BIRDIES","CIRCLE K # 7257 - KEENE","DIAMOND PIZZA","DREWSVILLE GENERAL STORE","FRATERNAL ORDER OF EAGLES","GRANITE GORGE PARTNERSHIP","HUNGRY DINER (THE)","ITALIAN CLUB","JIFFY MART #200459 - WALPOLE","JIFFY MART #200691 - WESTMORELAND","JIFFY MART #200692 - KEENE","KEENE DISCOUNT MART","KEENE LODGE OF ELKS","MADAME SHERRI'S","MAMA MCDONOUGH'S IRISH PUB","MILL VILLAGE CTRY STORE","MOBIL MART SHOP","MR MIKE'S - STODDARD","POUR HOUSE (THE)","RALPH'S SUPERMARKET","RESTAURANT AT BURDICKS","SAKA HIBACHI STEAKHOUSE","SHAW'S #3533 - WALPOLE","SPENCERS PLACE","STATELINE GROCERY","T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676","TARGET #2120 - KEENE","THE CLUBHOUSE BAR AND GRILLE","WALPOLE GROCERY","WATKINS INN & TAVERN"],"rconstant":["99 REST - LONDONDERRY","A AND S FOODMART","AJ'S SPORTS BAR & GRILL","ALLTOWN #202152 - LONDONDERRY","AMERICAN LEGION POST 27 - LONDONDERRY","BEER & WINE NATION - LONDONDERRY","CIRCLE K #7261 - HUDSON","COACH STOP","CONVENIENCE PLUS LONDONDERRY","DAY OF THE DEAD MEXICAN TAQUERIA","GAME CHANGER SPORTS BAR & GRILL","GIABELLA'S","HANNAFORD #8185 - LONDERY","HIDDEN CREEK COUNTRY CLUB","HUDSON SPEEDWAY (THE)","HUDSONS NORTH SIDE GRILLE","LA CARRETA - LONDONDERRY","LI'L LOBSTER BOAT","MARKET BASKET #42 LONDERRY","NUTFIELD COUNTRY STORE","O'NEIL CINEMAS","PASQUALE'S RISTORANTE","PASSACONAWAY COUNTRY CLUB","PATRIOT GAS","PROFESSOR SPORTS PUB","RENEGADES PUB","ROCCO'S PIZZA","ROMANO'S PIZZA LLC","SEVEN ELEV #32502 - LITCHFIELD","SEVEN ELEV #37392 - LONDONDERY - ROCKINGHAM RD","SHAW'S #0484 - LONDERRY","SMOKE SHACK CAFE","STUMBLE INN BAR & GRILL","SUPPAS PIZZA LONDONDERRY","TWINS SMOKE SHOP","WHIP-POOR WILL GOLF CLUB"],"rdouzanis":["FRANKIES DINER/ STONECUTTERS PUB","GRILL 603","JADE DRAGON-MILFORD","SAKE HOUSE"],"rwallace":["AMERICAN LEGION POST 11 - JAFFREY","AMIGO'S MEXICAN CANTINA","BAR ONE","BOWLING ACRES","BRADYS BAR AND GRILL","COOPER'S HILL","HAMPSHIRE HILLS S&F CLUB","HARLOWS DELI & CAFE","MI JALISCO - MILFORD","MI JALISCO - PETERBORO","TACO TIME COCINA & CANTINA","UNION COFFEE COMPANY","WATERHOUSE BISTRO"],"scamuso":["APPLEBEES - NASHUA Amherst St","BISTRO 603","BOBOLA RESTAURANT","COURTYARD BY MARRIOTT - NASHUA","DOUBLETREE BY HILTON NASHUA","EL TAPATIO RESTAURANTE MEXICANO LLC","EVVIVA TRATTORIA - NASHUA","FAMILY PIZZA AND ROAST BEEF OF NASHUA","FRONTERA GRILL OF NASHUA","GIORGIO'S TRATTORIA - MERRIMACK","HALUWA","KINSLEY HOUSE OF PIZZA","KSONES THAI DINING","LAFAYETTE CLUB A.C.","MILANO HOUSE OF PIZZA-NASHUA","NASHUA CONVENIENCE","NATIONAL CLUB (THE)","PINE STREET EATERY","PIZZERIA ZACHARIA","POLISH AMERICAN CLUB-NASHUA","SHORTY'S MEXICAN ROADHOUSE","SUNNYSIDE - STOP","TEQUILA JALISCO MEXICAN CUISINE AND CANTINA","TEXAS ROADHOUSE"],"sclark":["21B BAR AND GRILL","A-1 PIZZA & GRILL HINSDALE","ALLTOWN MARKET 202767- WINCHESTER","APPLEBEES - KEENE #6714","ARLINGTON INN & TAVERN (THE)","BEAVER STREET MARKET","BIRDIES","BOWLING ACRES","BRICKHOUSE PIZZA & WINGS","CHA'S GEM SHOP AND CONV","CHILI'S - KEENE","CLIFFY'S PUB","COOPER'S HILL","DIPLOMAT (THE)","EMMAS 321","GUERRILLA GRILL","HARLOWS PUBLIC HOUSE","ITALIAN CLUB","KEENE LODGE OF ELKS","LONGHORN STEAK #0003 - KEENE","MAIN CRUST CO.","MAMA MCDONOUGH'S IRISH PUB","MEXICA MEXICAN RESTAURANT","MI JALISCO - KEENE","MI JALISCO - PETERBORO","MR MIKE'S - STODDARD","NEW WORLD GAS - RINDGE","PEARL RESTAURANT & OYSTER","PHOENIX SMOKEHOUSE AND TAQUERIA","POUR HOUSE (THE)","PRICE CHOPPER #208 - KEENE","RESTAURANT AT BURDICKS","SMOKING TROUT (THE)","T-BIRD MINI MART - W. SWANZEY","TEMPESTA'S","TROY DELI & MARKET PLACE","VFW #799 - KEENE","WATKINS INN & TAVERN","WESTMORELAND GENERAL STORE","YANKEE LANES / KEENE BOWL","YELLOW BELL CAFE"],"sshaunessy":["99 REST - NASHUA","A & P CORNER MARKET LLC","AMERICAN LEGION POST 10 - WILTON","AMERICAN LEGION POST 11 - JAFFREY","AMHERST COUNTRY CLUB","AMHERST STREET SHELL #1123 - 190 AMHERST - NASHUA","AMIGO'S MEXICAN CANTINA","AMIGOS MEXICAN CANTINA","BAR ONE","BIRCHWOOD INN (THE)","BOWLING ACRES","BRADYS BAR AND GRILL","BROAD ST. PETROLEUM LLC","CIRCLE K #7236 - MILFORD","COOPER'S HILL","COPPER KETTLE","CUMBERLAND FARMS #5450 -NASHUA - AMHERST ST","DEL ROSSI'S TRATTORIA OF DUBLIN","DIYA MART","DUBLIN SMOKE HAUS","HALUWA","HAMPSHIRE HILLS S&F CLUB","HANNAFORD #8186 - NASHUA","HAR HAR MAHADEV INC","HARLOWS PUBLIC HOUSE","HILLTOP CAFE","LA PINATA MEXICAN GRILL","LAFAYETTE CLUB A.C.","MAIN DUNSTABLE SHELL #1124","MARKET BASKET #57 MILFORD","MI JALISCO - PETERBORO","MONADNOCK COUNTRY CLUB","NASHUA SHELL #1127 - 620 AMHERST ST","NOURIA ENERGY #1122 - NASH - BROAD ST","PEARL RESTAURANT & OYSTER","PINE STREET EATERY","PIZZA PEDDLER & MINI MART","POLISH AMERICAN CLUB-NASHUA","POST & BEAM","RILEY'S PLACE","RITE AID #10285 - PETERBOROUGH","RITE AID #1653 - JAFFREY","RIVIERA NAYARITA MEXICAN-STYLE SEAFOOD","SHAW'S #4694 - PETERBORO","SHORTY'S MEXICAN ROADHOUSE","SUN BAR & GRILL","SUNNYSIDE STOP","SUPER SHELL FOOD MART #1128 - HARRIS RD - NASHUA","TJ'S DELI AND CATERING","TOWN HALL TAPHOUSE AND EATERY","UNION COFFEE COMPANY","UNWINED","WATERHOUSE BISTRO","WEST HOLLIS STREET SHELL #1126"],"svisentin":["BUCKLEY'S GREAT STEAKS","CALIFORNIA BURRITOS-AMHERST","EL TAPATIO RESTAURANTE MEXICANO LLC","GIORGIO'S TRATTORIA - MERRIMACK","HOMESTEAD RESTAURANT & TAVERN","JADE DRAGON-MERRIMACK","KSONES THAI DINING","LOS PRIMOS MEXICAN RESTAURANT","LOST COWBOY BREWING","LUCKY DISCOUNT MART","PIZZICO - MERRIMACK","TEXAS ROADHOUSE","THIRSTY MOOSE","TORTILLA FLAT","UNO PIZZERIA & GRILL - AMHERST ST - NASHUA","VFW #8641 - MERRIMACK","WILLIE JEWELL'S OLD SCHOOL BBQ","ZHONG'S RESTAURANT"],"tchagnon":["AMERICAN LEGION POST 100 - PELHAM","AMERICAN LEGION POST 98 - MERRIMACK","BUDGET LUCKY MART","COMMON MAN - MERRIMACK","DON RAMON","DW HIGHWAY MOBIL INC","HAFFNERS- ENERGY NORTH","HANNAFORD #8015 - PELHAM","HOMESTEAD RESTAURANT & TAVERN","JADE DRAGON-MERRIMACK","KELARI TAVERNA & BAR","LOBSTER BOAT RESTAURANT","LOS PRIMOS MEXICAN RESTAURANT","MANCHESTER COUNTRY CLUB","MARKET BASKET #33 HUDSON","NH SPORTSPLEX","OTTO PORTLAND","PIZZICO - MERRIMACK","PRESSED CAFE - BEDFORD","REED'S FERRY MARKET","RIVER ROAD TAVERN","SHAW'S #0678 - MERRIMACK - CONTINENTAL","SHAW'S #3505 - MERRIMACK - DWH","TAVERN IN THE SQUARE BEDFORD LLC","THIRSTY MOOSE","TOMAHAWK BUTCHERY & TAVERN (REST)","VFW #8641 - MERRIMACK"],"tjebol":["THE CITY TOBACCO AND BEVERAGE CENTER #7 - PLAISTOW"],"tpiccinono":["99 REST - SALEM","ATKINSON RESORT AND COUNTRY CLUB","CARRIAGE TOWN BAR & GRILL","DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)","DREO FOOD AND DRINK","FRIENDLY RED'S - WINDHAM","GRANFANALLYS -PIZZA PUB","JAMISON'S","KINGSTON VETS CLUB INC","MARKET BASKET #06 SALEM","MARKET BASKET #25 PLAISTOW","MARKET BASKET #84 SALEM","MICHAELS FLATBREAD PIZZA CO.","OLD SCHOOL BAR AND GRILL","PAR28","PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD","PELHAM STREET BLACK WATER GRILL","PEPPERS PUB (NEW)","PIZZICO - MERRIMACK","PLAISTOW QUICK MART","PPC KITCHEN & BAR","RED ROBIN GOURMET BURGERS - SALEM","RICK'S THE SPIRIT OF KINGSTON","SADDLE UP SALOON","SHAW'S #3669 - PLAISTOW","T-BONES - SALEM","TAVERN IN THE SQUARE SALEM LLC","THE KITCHEN BY JTAPS","THE NEST PUB AND GRILL","TOMO STEAKHOUSE","VFW #1088 - KINGSTON","WINDHAM RESTAURANT (THE)"]};
const ACCOUNT_ASSETS = {"maanderson":{"PEDDLER'S DAUGHTER":[{"item":"Coaster","brand":"Bud Light","count":4,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":2,"last":"Oct 30, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 26, 2026"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Nov 26, 2025"}],"FRIENDLY RED'S - HUDSON":[{"item":"Coaster","brand":"Bud Light","count":12,"last":"Sep 17, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":3,"last":"Feb 02, 2026"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Jan 14, 2026"}],"AMERICAN LEGION POST 100 - PELHAM":[{"item":"Coaster","brand":"Mich Ultra","count":2,"last":"Feb 24, 2026"},{"item":"Coaster","brand":"Bud Light","count":2,"last":"Nov 04, 2025"}],"PINE VALLEY GOLF COURSE":[{"item":"Large Tap Marker","brand":"603 Brew - APL","count":2,"last":"Oct 28, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 10, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 28, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Feb 10, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Jan 06, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Slightly Tstd","count":1,"last":"Oct 14, 2025"},{"item":"Other","brand":"Nutrl","count":1,"last":"Feb 10, 2026"}],"LUK'S BAR & GRILL":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Jan 21, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 07, 2026"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 11, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 19, 2025"}],"MARGARITAS MEXICAN RESTAURANT-NASHUA":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Sep 25, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":2,"last":"Nov 26, 2025"}],"CALI B HUDSON":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Jan 21, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 25, 2025"},{"item":"Coaster","brand":"Heineken","count":1,"last":"Nov 12, 2025"}],"ZO'S PLACE":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 17, 2025"}],"NATIONAL CLUB (THE)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 18, 2025"},{"item":"Large Tap Marker","brand":"Hacker-Pschorr","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Oct 06, 2025"}],"JUKK INC":[{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Dec 29, 2025"},{"item":"Display/ Display Enhancer","brand":"BeatBox Vrty","count":1,"last":"Dec 29, 2025"},{"item":"Other","brand":"Fiddlehead - IPA","count":1,"last":"Dec 29, 2025"}],"AXE PLAY":[{"item":"Illuminated Sign","brand":"Nutrl","count":1,"last":"Oct 22, 2025"}],"STROKERS":[{"item":"Large Tap Marker","brand":"Shocktop","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Jan 13, 2026"}],"PENUCHE'S ALE HOUSE-NASHUA":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 15, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Shocktop - Pretzel","count":1,"last":"Sep 25, 2025"}],"NASH CASINO":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Nov 13, 2025"}],"GAGE HILL FARM":[{"item":"Other","brand":"Bud Light","count":1,"last":"Mar 03, 2026"}],"NASHUA COUNTRY CLUB":[{"item":"Small Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Feb 11, 2026"}]},"rconstant":{"99 REST - LONDONDERRY":[{"item":"Coaster","brand":"Nutrl","count":3,"last":"Dec 01, 2025"},{"item":"Coaster","brand":"Bud Light","count":3,"last":"Jan 05, 2026"},{"item":"Small Tap Marker","brand":"Bud Select","count":1,"last":"Nov 06, 2025"},{"item":"Small Tap Marker","brand":"Bud Light","count":1,"last":"Nov 06, 2025"},{"item":"Small Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Nov 06, 2025"}],"PROFESSOR SPORTS PUB":[{"item":"Coaster","brand":"Nutrl","count":3,"last":"Jan 21, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Feb 26, 2026"},{"item":"Large Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Feb 19, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Nov 19, 2025"},{"item":"Other","brand":"Nutrl","count":1,"last":"Jan 08, 2026"}],"HUDSONS NORTH SIDE GRILLE":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Oct 01, 2025"},{"item":"Other","brand":"Nutrl","count":2,"last":"Jan 08, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 12, 2026"},{"item":"Large Tap Marker","brand":"Widowmaker - Return to Dust","count":1,"last":"Feb 18, 2026"},{"item":"Large Tap Marker","brand":"Citizen Cider - Mimosa Crush","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Jan 21, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Boatload Berry","count":1,"last":"Jan 21, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Pond Hockey","count":1,"last":"Jan 07, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 07, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Mastermind","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Widowmaker - Blue Comet","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Bells - Christmas Ale","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"New Belgium - Juicy Haze","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Founders - CBS","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Fresh Patch","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Epigram - Temptation","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Founders - Imperial Thorn","count":1,"last":"Sep 24, 2025"}],"STUMBLE INN BAR & GRILL":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Feb 16, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 09, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 24, 2025"}],"AMERICAN LEGION POST 27 - LONDONDERRY":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Mar 09, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 05, 2026"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Dec 22, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Nov 11, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Jan 27, 2026"}],"LA CARRETA - LONDONDERRY":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Feb 18, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Mar 11, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Dec 03, 2025"}],"AJ'S SPORTS BAR & GRILL":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Jan 15, 2026"},{"item":"Other","brand":"Bud Light","count":2,"last":"Jan 15, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Budweiser","count":1,"last":"Feb 26, 2026"},{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Nov 26, 2025"},{"item":"Promo Item","brand":"Mich Ultra","count":1,"last":"Jan 15, 2026"}],"GAME CHANGER SPORTS BAR & GRILL":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Jan 21, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 14, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 05, 2025"}],"ROCCO'S PIZZA":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Sep 29, 2025"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Nov 10, 2025"}],"RENEGADES PUB":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Dec 02, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 23, 2025"}],"COACH STOP":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Nov 05, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Nov 05, 2025"},{"item":"Other","brand":"Nutrl","count":1,"last":"Feb 18, 2026"}],"MARKET BASKET #42 LONDERRY":[{"item":"Display/ Display Enhancer","brand":"Super Coffee","count":2,"last":"Oct 02, 2025"}],"SHAW'S #0484 - LONDERRY":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Feb 02, 2026"},{"item":"Display/ Display Enhancer","brand":"Ryse Fuel","count":1,"last":"Mar 02, 2026"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Feb 02, 2026"}],"CIRCLE K #7261 - HUDSON":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 09, 2026"}],"A AND S FOODMART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 18, 2025"}],"NUTFIELD COUNTRY STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"SEVEN ELEV #37392 - LONDONDERY - ROCKINGHAM RD":[{"item":"Display/ Display Enhancer","brand":"Phorm Energy Blue Blitz","count":1,"last":"Oct 07, 2025"}],"ALLTOWN #202152 - LONDONDERRY":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Sep 29, 2025"}],"TWINS SMOKE SHOP":[{"item":"Large Tap Marker","brand":"603 Brew - APL","count":2,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Mitz RIS","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Southern - Chestnut Praline","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Shocktop","count":1,"last":"Dec 15, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Dec 08, 2025"},{"item":"Large Tap Marker","brand":"Breck Christmas","count":1,"last":"Dec 08, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Maple Br","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"Goose - Bourb County","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Mitz BA RIS","count":1,"last":"Nov 10, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Blue Coggler","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"Left Hand - Mexican Hot Choc Milk Stout","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"Cigar City - Maduro","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Smashed Pumpkin","count":1,"last":"Oct 20, 2025"}],"SMOKE SHACK CAFE":[{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":2,"last":"Nov 11, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Feb 17, 2026"}],"O'NEIL CINEMAS":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Jan 14, 2026"},{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Jan 14, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 14, 2026"}],"SUPPAS PIZZA LONDONDERRY":[{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Dec 02, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cider Donut","count":1,"last":"Oct 21, 2025"}],"PASQUALE'S RISTORANTE":[{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Nov 05, 2025"}],"GIABELLA'S":[{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Oct 15, 2025"}],"HANNAFORD #8185 - LONDERY":[{"item":"Other","brand":"Mich Ultra","count":1,"last":"Feb 09, 2026"}],"PATRIOT GAS":[{"item":"Other","brand":"Natty Daddy","count":1,"last":"Nov 11, 2025"}],"SEVEN ELEV #32502 - LITCHFIELD":[{"item":"Other","brand":"Phorm Energy Freedom","count":1,"last":"Oct 16, 2025"},{"item":"Other","brand":"Natty Daddy","count":1,"last":"Oct 16, 2025"}],"ROMANO'S PIZZA LLC":[{"item":"Promo Item","brand":"Bud Light","count":1,"last":"Jan 22, 2026"}]},"lnorton":{"T-BONES - BEDFORD":[{"item":"Coaster","brand":"Bud Light","count":32,"last":"Sep 15, 2025"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Jan 22, 2026"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Sep 22, 2025"},{"item":"Small Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Mar 05, 2026"},{"item":"Small Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 19, 2026"},{"item":"Small Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Dec 18, 2025"},{"item":"Small Tap Marker","brand":"Downeast - Original","count":1,"last":"Oct 30, 2025"}],"LA VAKA MEXICAN RESTAURANT":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Nov 11, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 30, 2025"}],"VILLAGE TRESTLE (THE)":[{"item":"Coaster","brand":"Bud Light","count":6,"last":"Nov 04, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Dec 09, 2025"}],"PINARDVILLE ATHLETIC CLUB":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Oct 28, 2025"}],"RIVER ROAD TAVERN":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 18, 2025"},{"item":"Large Tap Marker","brand":"Able - Gemultich German Lager","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"1911 - Maple Bourbon Cider","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Other Half - Ticker Shock","count":1,"last":"Oct 09, 2025"},{"item":"Large Tap Marker","brand":"Other Half - LACEd in Space","count":1,"last":"Oct 09, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Fresh Patch","count":1,"last":"Oct 02, 2025"},{"item":"Large Tap Marker","brand":"Southern - Pumking","count":1,"last":"Sep 18, 2025"},{"item":"Large Tap Marker","brand":"Founders - Imperial Thorn","count":1,"last":"Sep 18, 2025"}],"MARKET BASKET #71 BEDFORD":[{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":2,"last":"Oct 29, 2025"},{"item":"Display/ Display Enhancer","brand":"Super Coffee","count":1,"last":"Mar 05, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Jan 22, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 19, 2025"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Dec 30, 2025"}],"HANNAFORD #8311 - GOFFSTOWN":[{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Nov 13, 2025"}],"MURPHY'S TAPROOM AND CARRIAGE HOUSE":[{"item":"Large Tap Marker","brand":"Founders - Breakfast Stout","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Feb 19, 2026"}],"COPPER DOOR - BEDFORD":[{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Nov 05, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Slightly Tstd","count":1,"last":"Oct 22, 2025"},{"item":"Small Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 21, 2026"}],"EVVIVA TRATTORIA - BEDFORD":[{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 24, 2025"}],"1750-TAPHOUSE":[{"item":"Large Tap Marker","brand":"Downeast - Cranberry","count":1,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - Pink Duct Tape","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Barista","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Cigar City - Oatmeal Raisin Cookie","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Hacker-Pschorr","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Other Half - Ideal Wave","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Lollipop Rasp","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Spaten","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"True North - Witch","count":1,"last":"Sep 24, 2025"},{"item":"Promo Item","brand":"Bud Light","count":1,"last":"Sep 24, 2025"}],"X-GOLF BEDFORD":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 02, 2025"}],"NH SPORTSPLEX":[{"item":"Large Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Oct 29, 2025"}]},"scamuso":{"NATIONAL CLUB (THE)":[{"item":"Coaster","brand":"Bud Light","count":4,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 09, 2026"}],"KINSLEY HOUSE OF PIZZA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 04, 2026"}],"FAMILY PIZZA AND ROAST BEEF OF NASHUA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 28, 2025"}],"EL TAPATIO RESTAURANTE MEXICANO LLC":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 18, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 12, 2026"}],"KSONES THAI DINING":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 03, 2025"}],"PIZZERIA ZACHARIA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 01, 2025"}],"GIORGIO'S TRATTORIA - MERRIMACK":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 13, 2025"}],"HALUWA":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Oct 09, 2025"}],"EVVIVA TRATTORIA - NASHUA":[{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Mar 11, 2026"},{"item":"Large Tap Marker","brand":"Jack's Abby - House Lager","count":1,"last":"Oct 29, 2025"}],"TEXAS ROADHOUSE":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Nov 12, 2025"}],"FRONTERA GRILL OF NASHUA":[{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Jan 21, 2026"}],"BISTRO 603":[{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Southern - Pumking","count":1,"last":"Sep 25, 2025"}],"DOUBLETREE BY HILTON NASHUA":[{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Nov 17, 2025"}],"BOBOLA RESTAURANT":[{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Oct 22, 2025"}],"COURTYARD BY MARRIOTT - NASHUA":[{"item":"Large Tap Marker","brand":"603 Brew - Wood Devil IPA","count":1,"last":"Oct 16, 2025"}],"NASHUA CONVENIENCE":[{"item":"Other","brand":"Budweiser","count":1,"last":"Dec 04, 2025"}]},"ddooling":{"MICHAELS FLATBREAD PIZZA CO.":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Dec 15, 2025"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Sep 15, 2025"},{"item":"Large Tap Marker","brand":"New Belgium - Fat Tire","count":1,"last":"Sep 15, 2025"}],"DERRY SALEM ELKS 2226":[{"item":"Large Tap Marker","brand":"New Belgium - Juicy Haze","count":2,"last":"Mar 04, 2026"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Mar 10, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Feb 03, 2026"}],"PEPPERS PUB (NEW)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Smashed Pumpkin","count":1,"last":"Oct 23, 2025"}],"T-BONES - SALEM":[{"item":"Coaster","brand":"Bud Light","count":10,"last":"Sep 29, 2025"},{"item":"Coaster","brand":"Budweiser","count":7,"last":"Oct 02, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Mar 12, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Feb 12, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Nov 13, 2025"}],"ON THE CORNER GRILL":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Stoneface - Sunday Sauce","count":1,"last":"Nov 05, 2025"}],"NEW CHIEF WOK":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Feb 19, 2026"},{"item":"Coaster","brand":"Bud Ice","count":1,"last":"Nov 13, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 16, 2025"}],"OLD SCHOOL BAR AND GRILL":[{"item":"Small Tap Marker","brand":"603 Brew - Winni","count":2,"last":"Oct 06, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 20, 2025"},{"item":"Small Tap Marker","brand":"New Belgium - Juicy Haze","count":1,"last":"Jan 19, 2026"},{"item":"Small Tap Marker","brand":"New Belgium - Fat Tire","count":1,"last":"Jan 15, 2026"},{"item":"Small Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 16, 2025"}],"CHILI'S - SALEM":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Feb 16, 2026"}],"STATELINE PAYSAVER":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":3,"last":"Nov 06, 2025"}],"SALEM CONVENIENCE STORE":[{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Nov 24, 2025"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"},{"item":"Illuminated Sign","brand":"Budweiser","count":1,"last":"Jan 07, 2026"}],"TAVERN IN THE SQUARE SALEM LLC":[{"item":"Display/ Display Enhancer","brand":"Gold Road Mango Cart","count":1,"last":"Nov 17, 2025"}],"GRANFANALLYS -PIZZA PUB":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Goose - Bourb County","count":1,"last":"Nov 26, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - Second","count":1,"last":"Nov 23, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - House Lager","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Frost - Starchild","count":1,"last":"Nov 06, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Doom Wizard","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"Southern - Pumking","count":1,"last":"Sep 25, 2025"},{"item":"Large Tap Marker","brand":"Epigram - Liam's Lager","count":1,"last":"Sep 15, 2025"},{"item":"Small Tap Marker","brand":"Fiddlehead - Second","count":1,"last":"Nov 17, 2025"}],"BEER STORE LLC (THE) - SALEM":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 06, 2025"},{"item":"Other","brand":"Gold Road Mango Cart","count":1,"last":"Oct 09, 2025"}],"CITY LINE MARKET (NEW)":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 06, 2025"}],"ISLAND POND CONVENIENCE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"}],"HOWIE GLYNN - DERRY":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"},{"item":"Other","brand":"MISC Encompass Conv Items","count":1,"last":"Jan 07, 2026"},{"item":"Other","brand":"Bud Light","count":1,"last":"Oct 01, 2025"}],"HOWIE GLYNN - SALEM":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"}],"SMOKE N BARLEY - SALEM":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"}],"KEV'S COUNTRY STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"}],"GRANFANALLYS PIZZA PUB":[{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Mar 12, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"Founders - Mortal Bloom","count":1,"last":"Dec 15, 2025"}],"PELHAM STREET BLACK WATER GRILL":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Nov 24, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Sep 18, 2025"}],"RALPHIE'S CAFE ITALIANO":[{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Mar 02, 2026"}],"FIGARO'S MARTINI BAR + KITCHEN":[{"item":"Large Tap Marker","brand":"Deciduous - Easier Operator","count":1,"last":"Feb 19, 2026"},{"item":"Small Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 13, 2025"}],"LIVE! CASINO SALEM":[{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Dec 22, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Banner","count":1,"last":"Nov 06, 2025"}],"COPPER DOOR - SALEM":[{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Nov 10, 2025"}],"SEVMAR MEDITERRANEAN BISTRO":[{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Nov 05, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Oct 01, 2025"}],"TIO JUAN'S MARGARITAS MEXICAN REST-SALEM":[{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 23, 2025"},{"item":"Other","brand":"Dos Equis","count":1,"last":"Oct 09, 2025"}],"PRESSED CAFE - SALEM":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Oct 22, 2025"}]},"jaustin":{"TEMPESTA'S":[{"item":"Coaster","brand":"Mich Ultra","count":4,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":2,"last":"Jan 08, 2026"},{"item":"Other","brand":"Downeast - Pomegranate","count":2,"last":"Feb 11, 2026"},{"item":"Other","brand":"Downeast - Cranberry","count":2,"last":"Nov 26, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 10, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Dec 10, 2025"},{"item":"Other","brand":"Downeast - Winter","count":1,"last":"Dec 17, 2025"}],"CHILI'S - KEENE":[{"item":"Coaster","brand":"Mich Ultra","count":6,"last":"Nov 26, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Pumpkin","count":2,"last":"Oct 13, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 03, 2025"},{"item":"Other","brand":"Downeast - Blackberry","count":1,"last":"Jan 05, 2026"},{"item":"Other","brand":"Downeast - Cranberry","count":1,"last":"Dec 15, 2025"},{"item":"Other","brand":"Downeast - Caramel Apple","count":1,"last":"Nov 03, 2025"}],"APPLEBEES - KEENE #6714":[{"item":"Coaster","brand":"Mich Ultra","count":5,"last":"Sep 17, 2025"}],"LAB'N LAGER KEENE":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Feb 02, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 08, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 23, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Jan 19, 2026"}],"GUERRILLA GRILL":[{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":2,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":2,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":2,"last":"Oct 23, 2025"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Jan 29, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - IPA","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Founders - All Day IPA","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Irish Stout","count":1,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Mastermind","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"Bells - Big hearted","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Nov 20, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Nov 20, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cranberry","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"Southern - Caramel Pumking","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Woodchuck","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Barista","count":1,"last":"Oct 02, 2025"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Sep 25, 2025"},{"item":"Other","brand":"Downeast - Pumpkin","count":1,"last":"Dec 31, 2025"},{"item":"Other","brand":"Downeast - Caramel Apple","count":1,"last":"Nov 13, 2025"},{"item":"Other","brand":"Downeast - Cranberry","count":1,"last":"Oct 30, 2025"},{"item":"Other","brand":"Stoneface - Crown Shy","count":1,"last":"Oct 08, 2025"}],"KILKENNY PUB - KEENE":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 22, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Dec 01, 2025"},{"item":"Other","brand":"603 Brew - Winni","count":1,"last":"Jan 19, 2026"}],"MI JALISCO - KEENE":[{"item":"Coaster","brand":"Mich Ultra","count":4,"last":"Oct 08, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 30, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Nov 12, 2025"}],"MAIN CRUST CO.":[{"item":"Large Tap Marker","brand":"Paulaner","count":2,"last":"Nov 25, 2025"},{"item":"Other","brand":"Henniker - Flap Jack","count":2,"last":"Nov 05, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 21, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Feb 11, 2026"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Feb 04, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 07, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Dec 23, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Dec 23, 2025"},{"item":"Large Tap Marker","brand":"Upper Pass - First Drop","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Throwback - Rule Roost","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Champlain Orch - Kingston Dry","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - Full Clip","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Hacker-Pschorr","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Spaten","count":1,"last":"Nov 05, 2025"}],"CLIFFY'S PUB":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 15, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Irish Hello","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Jan 15, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Dec 08, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Dec 08, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cider Donut","count":1,"last":"Sep 29, 2025"},{"item":"Large Tap Marker","brand":"Upper Pass - First Drop","count":1,"last":"Sep 22, 2025"}],"A-1 PIZZA & GRILL HINSDALE":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 13, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 04, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 16, 2025"},{"item":"Other","brand":"Downeast - Cranberry","count":1,"last":"Nov 04, 2025"}],"VFW #799 - KEENE":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 07, 2026"}],"VFW #3968 - WINCHESTER":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Dec 03, 2025"}],"RUSTIC TABLE (THE)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Nov 24, 2025"}],"YANKEE LANES / KEENE BOWL":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Dos Equis Amber","count":1,"last":"Nov 17, 2025"}],"BRICKHOUSE PIZZA & WINGS":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 04, 2026"},{"item":"Other","brand":"Downeast - Pomegranate","count":1,"last":"Feb 11, 2026"},{"item":"Other","brand":"Downeast - Winter","count":1,"last":"Dec 23, 2025"},{"item":"Other","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 23, 2025"}],"AMERICAN LEGION POST 4 - KEENE":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Oct 14, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Sep 16, 2025"},{"item":"Other","brand":"Budweiser","count":1,"last":"Oct 15, 2025"}],"MARGARITA'S - KEENE":[{"item":"Coaster","brand":"Dos Equis","count":1,"last":"Oct 08, 2025"}],"BIG DEAL - SPOFFORD":[{"item":"Display/ Display Enhancer","brand":"Budweiser","count":2,"last":"Nov 24, 2025"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Mar 10, 2026"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Jan 06, 2026"},{"item":"Display/ Display Enhancer","brand":"Heineken","count":1,"last":"Dec 16, 2025"},{"item":"Display/ Display Enhancer","brand":"Ryse Protein","count":1,"last":"Dec 02, 2025"}],"BIG DEAL - KEENE":[{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Mar 02, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 09, 2026"}],"TROY DELI & MARKET PLACE":[{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":2,"last":"Oct 29, 2025"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 12, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Jan 07, 2026"}],"GET-N-GO":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Jan 13, 2026"},{"item":"Other","brand":"Bud Light","count":1,"last":"Oct 07, 2025"}],"RIVERSIDE GROCERY":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 10, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 11, 2025"}],"T-BIRD MINI MART - HINSDALE":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":3,"last":"Nov 10, 2025"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Nov 03, 2025"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Jan 05, 2026"}],"WEST CHESTERFIELD SHELL #200643":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Nov 11, 2025"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Jan 27, 2026"}],"MINUTE MART":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Jan 07, 2026"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Oct 15, 2025"}],"ALLTOWN MARKET 202767- WINCHESTER":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Dec 09, 2025"},{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Jan 06, 2026"}],"SANDRI STOP MART - KEENE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 03, 2025"}],"MAIN STREET MINI MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 02, 2025"}],"MARLBOROUGH FOOD MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 19, 2025"}],"SANDRI STOP - HINSDALE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 10, 2025"}],"RTE. 63 COUNTRY STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 06, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Oct 16, 2025"}],"CARRS STORE (TBIRD DUBLIN)":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"}],"NOBLE RAMEN HOUSE":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Deciduous - Lollipop Rasp","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Other Half - Broccoli","count":1,"last":"Oct 07, 2025"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Oct 07, 2025"}],"LOCAL BURGER OF KEENE":[{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Helles","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Widowmaker - Blue Comet","count":1,"last":"Sep 17, 2025"}],"THE PERCH":[{"item":"Large Tap Marker","brand":"BBCO - Lighthouse","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Nov 20, 2025"},{"item":"Other","brand":"Dos Equis","count":1,"last":"Sep 18, 2025"}],"YELLOW BELL CAFE":[{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Jan 05, 2026"}],"KEENE COUNTRY CLUB INC":[{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Nov 13, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Nov 13, 2025"}],"TOWN SQUARE TAVERN":[{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 20, 2025"}],"DIPLOMAT (THE)":[{"item":"Small Tap Marker","brand":"Downeast - Cider Donut","count":2,"last":"Sep 18, 2025"},{"item":"Other","brand":"Downeast - Prickly Pear","count":1,"last":"Feb 05, 2026"},{"item":"Other","brand":"Concord Craft - White Mtn White","count":1,"last":"Jan 08, 2026"},{"item":"Other","brand":"Downeast - Cranberry","count":1,"last":"Nov 26, 2025"},{"item":"Other","brand":"Heineken","count":1,"last":"Oct 02, 2025"}]},"ggage":{"CHRYSANTHI'S":[{"item":"Coaster","brand":"Mich Ultra","count":11,"last":"Oct 20, 2025"},{"item":"Coaster","brand":"Bud Light","count":5,"last":"Sep 16, 2025"},{"item":"Coaster","brand":"Fiddlehead - IPA","count":1,"last":"Oct 14, 2025"},{"item":"Large Tap Marker","brand":"Founders - All Day IPA","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Dec 22, 2025"}],"STONECUTTERS PUB":[{"item":"Coaster","brand":"Heineken","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Feb 04, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 23, 2025"}],"AMERICAN LEGION POST 23 - MILFORD":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 18, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Oktober","count":1,"last":"Oct 21, 2025"}],"OLDE TOWNE TAVERN":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 07, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Jan 27, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Jan 06, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Dec 01, 2025"}],"ALAMO TEXAS BAR-B-QUE & TEQUILA BAR":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":2,"last":"Dec 22, 2025"},{"item":"Large Tap Marker","brand":"Able - Auburn","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Bud Select","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cranberry","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Carlson - Berry","count":1,"last":"Nov 17, 2025"}],"AMERICAN LEGION POST 10 - WILTON":[{"item":"Large Tap Marker","brand":"BBCO - Little Wizard","count":1,"last":"Mar 01, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Picnic","count":1,"last":"Nov 16, 2025"},{"item":"Large Tap Marker","brand":"1911 - Cider Donut","count":1,"last":"Nov 02, 2025"}],"GIORGIO'S RISTORANTE - MILFORD":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Jan 27, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Nov 04, 2025"}],"HAMPSHIRE DOME (THE)":[{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":2,"last":"Dec 23, 2025"},{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Nov 10, 2025"}],"VFW #4368 - MILFORD":[{"item":"Large Tap Marker","brand":"New Belgium - Fat Tire","count":1,"last":"Dec 16, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Sep 16, 2025"}],"OLDE KILKENNY PUB":[{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 05, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Sep 23, 2025"}],"ROUTE 13 STATELINE CONV MART":[{"item":"Large Tap Marker","brand":"Bells - Two Hearted","count":1,"last":"Oct 09, 2025"}],"THE BRICKHOUSE RESTAURANT AND BREWERY":[{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Oct 07, 2025"}]},"lortiz":{"RED ROBIN BURGERS #515 NASHUA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 09, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Dec 15, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 20, 2025"}],"CHILI'S - NASHUA - DW HWY":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Oct 13, 2025"}],"MARKET BASKET #13 NASHUA - DW HWY":[{"item":"Display/ Display Enhancer","brand":"Athletic - Free Wave","count":1,"last":"Jan 14, 2026"},{"item":"Display/ Display Enhancer","brand":"Heineken","count":1,"last":"Nov 06, 2025"},{"item":"Display/ Display Enhancer","brand":"Natural Light","count":1,"last":"Nov 06, 2025"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Nov 06, 2025"}],"SHAW'S #3510 - NASHUA - ROYAL RIDGE":[{"item":"Display/ Display Enhancer","brand":"Super Coffee","count":1,"last":"Dec 30, 2025"}],"BUFFALO WILD WINGS GRILL & BAR - NASHUA":[{"item":"Large Tap Marker","brand":"Busch Light","count":1,"last":"Jan 07, 2026"}],"BURTON'S GRILL":[{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Nov 12, 2025"}],"LUI LUI - NASHUA":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Oct 23, 2025"}],"LONGHORN STEAK #5457 - NASHUA":[{"item":"Small Tap Marker","brand":"Maine Beer Co - Lunch","count":2,"last":"Oct 13, 2025"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Oct 20, 2025"},{"item":"Small Tap Marker","brand":"Bud Light","count":1,"last":"Oct 13, 2025"}]},"jmeharg":{"TAVERN ON THE GREENS":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Jan 19, 2026"},{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Dec 28, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 27, 2025"}],"HILLSBORO HOUSE OF PIZZA":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Sep 29, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 20, 2025"}],"TOOKY MILLS PUB":[{"item":"Coaster","brand":"Bud Light","count":11,"last":"Sep 15, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Dec 01, 2025"}],"CROTCHED MOUNTAIN SKI AREA":[{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":2,"last":"Jan 06, 2026"},{"item":"Coaster","brand":"Fiddlehead - IPA","count":1,"last":"Dec 23, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - Hodad","count":1,"last":"Feb 04, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Prickly Pear","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Dec 10, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Dec 10, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Dec 10, 2025"}],"VILLAGE TRESTLE (THE)":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Sep 16, 2025"}],"SHAW'S #4514 - HILLSBORO":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Jan 22, 2026"},{"item":"Display/ Display Enhancer","brand":"Ryse Fuel","count":1,"last":"Feb 19, 2026"},{"item":"Display/ Display Enhancer","brand":"Popwell","count":1,"last":"Sep 18, 2025"}],"MOBIL ON THE RUN #200626 - HENNIKER":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Oct 06, 2025"}],"ZOOMIES CORNER MARKET":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 16, 2025"}],"HANNAFORD #8311 - GOFFSTOWN":[{"item":"Display/ Display Enhancer","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 09, 2025"}],"KAT'S COUNTRY CORNER":[{"item":"Illuminated Sign","brand":"Budweiser","count":1,"last":"Feb 25, 2026"}],"BUFFALO BO'S":[{"item":"Illuminated Sign","brand":"Dos Equis","count":1,"last":"Dec 31, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Seltzer Black Cherry","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Hop Slinger IPA","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Henni Light","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Dos Equis","count":1,"last":"Dec 11, 2025"}],"COUNTRY SPIRIT RESTAURANT & TAVERN":[{"item":"Large Tap Marker","brand":"Shipyard - Prelude","count":2,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Smashed Pumpkin","count":2,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Henniker - First One Today","count":1,"last":"Mar 12, 2026"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Breck Vanilla Porter","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Jack's Abby - Framinghammer","count":1,"last":"Jan 15, 2026"},{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Dec 31, 2025"},{"item":"Large Tap Marker","brand":"Able - Broad Arrow","count":1,"last":"Nov 20, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Nov 06, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 02, 2025"}],"RUSTIC ROSE TAVERN":[{"item":"Large Tap Marker","brand":"Henniker - First One Today","count":1,"last":"Mar 12, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Dec 18, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cider Donut","count":1,"last":"Sep 18, 2025"}],"APPLESEED LAKESIDE REST":[{"item":"Large Tap Marker","brand":"Henniker - First One Today","count":1,"last":"Mar 10, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Feb 03, 2026"}],"MOLLY'S TAVERN & RESTAURANT":[{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Able - Fighting 69th","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Feb 11, 2026"},{"item":"Large Tap Marker","brand":"Upper Pass - Cloud Drop","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Nov 19, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - IPA","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Oct 08, 2025"}],"SNACKSHOT CATERING":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Feb 17, 2026"}],"AMERICAN LEGION POST 59 - HILLSBORO":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Mar 02, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 27, 2025"}],"PATS PEAK":[{"item":"Large Tap Marker","brand":"Henniker - Miles & Miles","count":1,"last":"Feb 23, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Dec 23, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Dec 23, 2025"}],"TOLL BOOTH TAVERN (THE)":[{"item":"Large Tap Marker","brand":"603 Brew - Hard Seltzer","count":1,"last":"Feb 11, 2026"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Feb 11, 2026"}],"CHARTWELL'S DINING SERVICES":[{"item":"Large Tap Marker","brand":"Captain Eli's","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 29, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Seltzer Baboosic","count":1,"last":"Sep 22, 2025"}],"DANIEL'S PUB INC":[{"item":"Large Tap Marker","brand":"Henniker - King Misanthrope","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Henniker - West Coast Colab","count":1,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Henni Light","count":1,"last":"Oct 02, 2025"}],"BLUE BEAR HOSPITALITY LLC":[{"item":"Large Tap Marker","brand":"von Trapp - Pilsner","count":1,"last":"Nov 19, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Vienna","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Able - Homecoming Pumpkin Ale","count":1,"last":"Oct 08, 2025"}],"STONEBRIDGE COUNTRY CLUB":[{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Oct 14, 2025"}],"LEO'S BAR & GRILL":[{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 22, 2025"}],"ANTRIM MARKET":[{"item":"Mirror","brand":"Bud Light","count":1,"last":"Jan 28, 2026"}],"WASHINGTON GENERAL STORE REST":[{"item":"Other","brand":"Bud Light","count":1,"last":"Dec 30, 2025"}],"BRADFORD MARKET":[{"item":"Other","brand":"Bud Light","count":1,"last":"Nov 18, 2025"}]},"eleahy":{"T-BONES - DERRY":[{"item":"Coaster","brand":"Bud Light","count":7,"last":"Sep 25, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 12, 2026"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Dec 08, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Dec 15, 2025"}],"50 EAST DERRY RD CONVENIENCE - REST":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 04, 2026"}],"APPLEBEES - DERRY":[{"item":"Coaster","brand":"Bud Light","count":6,"last":"Sep 15, 2025"}],"FANG CHEN'S RESTAURANT":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Feb 11, 2026"}],"HARE OF THE DAWG BAR & GRILL":[{"item":"Coaster","brand":"Bud Light Seltzer Sangria Splash Variety","count":1,"last":"Feb 18, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 21, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Nov 05, 2025"}],"FRIENDLY REDS - DERRY":[{"item":"Coaster","brand":"Bud Light","count":6,"last":"Sep 15, 2025"}],"FODY'S TAVERN (DERRY)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 02, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Seltzer Black Cherry","count":1,"last":"Jan 20, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 04, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Sep 16, 2025"},{"item":"Small Tap Marker","brand":"Bud Light","count":1,"last":"Jan 12, 2026"}],"LA CARRETA - DERRY":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 19, 2025"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Oct 29, 2025"},{"item":"Promo Item","brand":"Bud Light","count":1,"last":"Oct 01, 2025"}],"AMPHORA RESTAURANT":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 30, 2025"}],"SUMO SUSHI":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 23, 2025"}],"SUN ASIAN BISTRO":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 18, 2025"}],"50 EAST DERRY ROAD CONVENIENCE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 17, 2025"}],"SPEEDWAY #46190 - DERRY":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 08, 2025"}],"DERRY QUICK MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 01, 2025"}],"HOWIE GLYNN & SONS CONVENIENCE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 18, 2025"}],"HYLA BROOK ESTATE":[{"item":"Large Tap Marker","brand":"603 Brew - Beer Hall","count":1,"last":"Mar 03, 2026"}]},"sclark":{"COOPER'S HILL":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Mar 03, 2026"}],"KEENE LODGE OF ELKS":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 07, 2025"}],"MR MIKE'S - STODDARD":[{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Jan 14, 2026"}],"T-BIRD MINI MART - W. SWANZEY":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Oct 02, 2025"}],"CHA'S GEM SHOP AND CONV":[{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Oct 02, 2025"},{"item":"Illuminated Sign","brand":"Budweiser","count":1,"last":"Sep 18, 2025"}],"PHOENIX SMOKEHOUSE AND TAQUERIA":[{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Mar 11, 2026"}],"EMMAS 321":[{"item":"Large Tap Marker","brand":"Jack's Abby - Porch Fest","count":1,"last":"Mar 11, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Mar 11, 2026"}],"HARLOWS PUBLIC HOUSE":[{"item":"Large Tap Marker","brand":"Fiddlehead - Hodad","count":1,"last":"Mar 10, 2026"}],"MI JALISCO - PETERBORO":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 10, 2026"}],"PEARL RESTAURANT & OYSTER":[{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Mar 03, 2026"}],"BOWLING ACRES":[{"item":"Large Tap Marker","brand":"BBCO - Wizard","count":1,"last":"Mar 03, 2026"}],"DIPLOMAT (THE)":[{"item":"Large Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Feb 26, 2026"}],"TEMPESTA'S":[{"item":"Large Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Feb 25, 2026"}],"MAIN CRUST CO.":[{"item":"Large Tap Marker","brand":"BBCO - Wizard","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"BBCO - Lunar Wizard","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Founders - Porter","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Widowmaker - Blue Comet","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"True North - Witch","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Orono - Tubular","count":1,"last":"Oct 01, 2025"}],"POUR HOUSE (THE)":[{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Frost - Lush","count":1,"last":"Jan 13, 2026"}],"WATKINS INN & TAVERN":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 12, 2026"}],"RESTAURANT AT BURDICKS":[{"item":"Large Tap Marker","brand":"14th Star - Valor","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Von Trapp - Polotmavy","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Other Half - Superfun!","count":1,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Dec 11, 2025"}],"MAMA MCDONOUGH'S IRISH PUB":[{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Oct 09, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Oct 02, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Sep 18, 2025"}]},"pwollert":{"ITALIAN CLUB":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 24, 2026"}],"HUNGRY DINER (THE)":[{"item":"Coaster","brand":"Zero Gravity - Cone Head","count":2,"last":"Oct 30, 2025"}],"AMERICAN LEGION POST 4 - KEENE":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 11, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Feb 04, 2026"}],"KEENE LODGE OF ELKS":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 21, 2025"}],"T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676":[{"item":"Display/ Display Enhancer","brand":"Nutrl","count":1,"last":"Mar 05, 2026"},{"item":"Display/ Display Enhancer","brand":"Devils BB - Vrty","count":1,"last":"Feb 26, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Dec 23, 2025"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Nov 20, 2025"}],"SHAW'S #3533 - WALPOLE":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":4,"last":"Dec 31, 2025"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":2,"last":"Dec 18, 2025"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":2,"last":"Nov 20, 2025"},{"item":"Display/ Display Enhancer","brand":"Busch Light","count":1,"last":"Feb 26, 2026"},{"item":"Display/ Display Enhancer","brand":"Heineken","count":1,"last":"Nov 06, 2025"}],"KEENE DISCOUNT MART":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Jan 27, 2026"}],"STATELINE GROCERY":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Dec 31, 2025"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Jan 29, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 26, 2025"}],"JIFFY MART #200691 - WESTMORELAND":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 01, 2025"}],"JIFFY MART #200459 - WALPOLE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 01, 2025"}],"ALSTEAD GENERAL STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 25, 2025"}],"MR MIKE'S - STODDARD":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 19, 2025"}],"MOBIL MART SHOP":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 19, 2025"}],"RALPH'S SUPERMARKET":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Sep 24, 2025"}],"DIAMOND PIZZA":[{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Feb 26, 2026"}],"MAMA MCDONOUGH'S IRISH PUB":[{"item":"Large Tap Marker","brand":"Downeast - Black Cherry","count":1,"last":"Feb 11, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Feb 11, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Nov 19, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 19, 2025"}],"POUR HOUSE (THE)":[{"item":"Large Tap Marker","brand":"Throwback - Cheek Squeezer","count":1,"last":"Feb 10, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Feb 10, 2026"},{"item":"Large Tap Marker","brand":"Frost - Little Lush","count":1,"last":"Jan 27, 2026"},{"item":"Large Tap Marker","brand":"Athletic - Run Wild","count":1,"last":"Jan 06, 2026"}],"MADAME SHERRI'S":[{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":2,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Jan 27, 2026"},{"item":"Large Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Jan 27, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Boatload Berry","count":1,"last":"Dec 29, 2025"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Dec 29, 2025"}],"RESTAURANT AT BURDICKS":[{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"BBCO - Wizard","count":1,"last":"Jan 08, 2026"}],"21 ROXBURY BAR & GRILL":[{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":2,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":2,"last":"Nov 26, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":2,"last":"Nov 26, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 09, 2025"}],"FRATERNAL ORDER OF EAGLES":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Dec 02, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Sep 23, 2025"}],"THE CLUBHOUSE BAR AND GRILLE":[{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Oct 15, 2025"},{"item":"Promo Item","brand":"Bud Light","count":1,"last":"Feb 02, 2026"}]},"tchagnon":{"THIRSTY MOOSE":[{"item":"Coaster","brand":"Mich Ultra","count":6,"last":"Jan 20, 2026"},{"item":"Coaster","brand":"Bud Light","count":5,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Porch Fest","count":1,"last":"Mar 10, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Black Cherry","count":1,"last":"Mar 10, 2026"},{"item":"Large Tap Marker","brand":"BBCO - Lighthouse","count":1,"last":"Mar 10, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Apple Pie","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Irish Red","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"BBCO - Little Wizard","count":1,"last":"Feb 17, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Pond Hockey","count":1,"last":"Feb 17, 2026"},{"item":"Large Tap Marker","brand":"Left Hand - Candy Cane Nitro","count":1,"last":"Feb 17, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Irish Hello","count":1,"last":"Feb 12, 2026"},{"item":"Large Tap Marker","brand":"Cigar City - Jai Alai","count":1,"last":"Feb 03, 2026"},{"item":"Large Tap Marker","brand":"Oskar Blues - Dbl Dales Pale","count":1,"last":"Feb 03, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Mastermind","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Bitburger - Premium Pils","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Banded - Charm","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Carlsberg - Lager","count":1,"last":"Jan 06, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Red IPA","count":1,"last":"Jan 06, 2026"},{"item":"Large Tap Marker","brand":"Citizen Cider - BD Apple Pie","count":1,"last":"Dec 29, 2025"},{"item":"Large Tap Marker","brand":"New Belgium - Fat Tire","count":1,"last":"Dec 29, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Dec 23, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Dec 22, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - MO","count":1,"last":"Dec 09, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Prelude","count":1,"last":"Dec 02, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Rock Pile IPA","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Helles","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Founders - Mortal Bloom","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Boatload Berry","count":1,"last":"Nov 24, 2025"}],"LOBSTER BOAT RESTAURANT":[{"item":"Coaster","brand":"Mich Ultra","count":2,"last":"Jan 14, 2026"}],"DON RAMON":[{"item":"Coaster","brand":"Dos Equis","count":1,"last":"Feb 20, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 17, 2025"}],"PIZZICO - MERRIMACK":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 14, 2026"}],"LOS PRIMOS MEXICAN RESTAURANT":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Jan 07, 2026"}],"AMERICAN LEGION POST 98 - MERRIMACK":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Dec 10, 2025"}],"JADE DRAGON-MERRIMACK":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 09, 2025"},{"item":"Other","brand":"Budweiser","count":1,"last":"Feb 03, 2026"}],"RIVER ROAD TAVERN":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 21, 2025"},{"item":"Display/ Display Enhancer","brand":"Able - Auburn","count":1,"last":"Feb 26, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Able - Fighting 69th","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Apple Pie","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Epigram - Rowdy House","count":1,"last":"Feb 19, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Pilsner","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Pond Hockey","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"Widowmaker - Blue Comet","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"Epigram - Temptation","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"Athletic - Run Wild","count":1,"last":"Jan 02, 2026"}],"AMERICAN LEGION POST 100 - PELHAM":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Oct 07, 2025"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Oct 24, 2025"}],"SHAW'S #0678 - MERRIMACK - CONTINENTAL":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Jan 07, 2026"},{"item":"Other","brand":"Good 2 grow","count":1,"last":"Dec 10, 2025"}],"SHAW'S #3505 - MERRIMACK - DWH":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 11, 2026"}],"DW HIGHWAY MOBIL INC":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"MARKET BASKET #33 HUDSON":[{"item":"Glass","brand":"Busch Light","count":1,"last":"Oct 28, 2025"},{"item":"Illuminated Sign","brand":"Nutrl","count":1,"last":"Oct 24, 2025"},{"item":"Other","brand":"Sparkling Ice","count":1,"last":"Oct 09, 2025"}],"REED'S FERRY MARKET":[{"item":"Illuminated Sign","brand":"Mich Ultra","count":1,"last":"Nov 21, 2025"},{"item":"Illuminated Sign","brand":"Nutrl","count":1,"last":"Nov 12, 2025"}],"BUDGET LUCKY MART":[{"item":"Illuminated Sign","brand":"Nutrl","count":1,"last":"Nov 12, 2025"}],"OTTO PORTLAND":[{"item":"Large Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Orono - Tubular","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Feb 02, 2026"}],"PRESSED CAFE - BEDFORD":[{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Jack's Abby - House Lager","count":1,"last":"Feb 18, 2026"}],"TAVERN IN THE SQUARE BEDFORD LLC":[{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":2,"last":"Dec 31, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - Sunday Sauce","count":1,"last":"Feb 18, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Jan 22, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Mastermind","count":1,"last":"Jan 19, 2026"}],"MANCHESTER COUNTRY CLUB":[{"item":"Large Tap Marker","brand":"Epigram - Temptation","count":1,"last":"Feb 17, 2026"}],"TOMAHAWK BUTCHERY & TAVERN (REST)":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Feb 02, 2026"}],"COMMON MAN - MERRIMACK":[{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Jan 27, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Nov 17, 2025"}],"VFW #8641 - MERRIMACK":[{"item":"Large Tap Marker","brand":"Jack's Abby - House Lager","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Seltzer Black Cherry","count":1,"last":"Dec 16, 2025"}],"NH SPORTSPLEX":[{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Jan 08, 2026"}],"HOMESTEAD RESTAURANT & TAVERN":[{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Nov 12, 2025"}]},"jjohnson":{"ZIGGY'S PIZZA - W. LEB":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Throwback - Cheek Squeezer","count":2,"last":"Oct 20, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Lollipop Rasp","count":2,"last":"Oct 06, 2025"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Feb 02, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Sep 29, 2025"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Sep 18, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"Frost - Lush","count":1,"last":"Nov 20, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Doom Wizard","count":1,"last":"Nov 06, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Mexican Lager","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Epigram - Temptation","count":1,"last":"Oct 09, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - Sunday Sauce","count":1,"last":"Sep 22, 2025"}],"JESSE'S STEAKHOUSE":[{"item":"Large Tap Marker","brand":"Von Trapp - West Coast","count":2,"last":"Jan 19, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 19, 2026"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Bells - Two Hearted","count":1,"last":"Mar 09, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Hodad","count":1,"last":"Mar 02, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Schwarz","count":1,"last":"Feb 12, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 15, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Oct 09, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 02, 2025"},{"item":"Large Tap Marker","brand":"Von Trapp - Polotmavy","count":1,"last":"Oct 02, 2025"}],"AMERICAN LEGION POST 22 - GRAFTON":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Dec 15, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Sep 25, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Jan 15, 2026"}],"GUSANOZ MEXICAN REST":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Oct 27, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 15, 2025"}],"POOR HOUSE BAR-B-QUE RESTAURANT AND SUPPLIES":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Apple Pie","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Sep 24, 2025"}],"SNAX":[{"item":"Large Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Mar 02, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Schwarz","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Dec 15, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Dec 15, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Equilibrium - MC2","count":1,"last":"Sep 22, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 22, 2025"},{"item":"Other","brand":"Downeast - Cider Donut","count":1,"last":"Sep 22, 2025"}],"MURPHY'S ON THE GREEN":[{"item":"Large Tap Marker","brand":"Stoneface - Sunday Sauce","count":1,"last":"Feb 19, 2026"},{"item":"Large Tap Marker","brand":"Sea Dog - Blueberry","count":1,"last":"Feb 19, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Mexican Lager","count":1,"last":"Sep 25, 2025"}],"BARK & BEVY CO.":[{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Feb 18, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Jan 12, 2026"}],"HANOVER INN":[{"item":"Large Tap Marker","brand":"Athletic - Run Wild","count":1,"last":"Jan 29, 2026"}],"UPPER VALLEY SNOW SPORTS FOUNDATION @ WHALEBACK MO":[{"item":"Large Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Zero Gravity - Powder Jones","count":1,"last":"Jan 21, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 06, 2026"},{"item":"Large Tap Marker","brand":"Zero Gravity - Evergreen","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Upper Pass - First Drop","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Remix","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Oktoberfest","count":1,"last":"Sep 16, 2025"}],"MOLLYS RESTAURANT":[{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 15, 2025"},{"item":"Large Tap Marker","brand":"Frost - Lush","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"Henniker - West Coast Colab","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Able - Victory Nor Defeat","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Pisolino","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Oct 09, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - Mastermind","count":1,"last":"Oct 06, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Oktober","count":1,"last":"Sep 15, 2025"}],"KITCHEN 56":[{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Nov 25, 2025"}],"ENTERTAINMENT CINEMAS - LEBANON":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Nov 20, 2025"}]},"sshaunessy":{"LAFAYETTE CLUB A.C.":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Mar 02, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 05, 2026"}],"HALUWA":[{"item":"Coaster","brand":"Bud Light","count":5,"last":"Nov 13, 2025"},{"item":"Coaster","brand":"Nutrl","count":1,"last":"Jan 29, 2026"}],"AMIGOS MEXICAN CANTINA":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Oct 20, 2025"}],"MI JALISCO - PETERBORO":[{"item":"Coaster","brand":"Bud Light","count":4,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Oct 22, 2025"}],"SUN BAR & GRILL":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 14, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 29, 2025"}],"BRADYS BAR AND GRILL":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Oct 29, 2025"}],"HANNAFORD #8186 - NASHUA":[{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Jan 08, 2026"}],"SUNNYSIDE STOP":[{"item":"Display/ Display Enhancer","brand":"BeatBox Vrty","count":1,"last":"Jan 08, 2026"}],"SUPER SHELL FOOD MART #1128 - HARRIS RD - NASHUA":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 11, 2025"}],"MAIN DUNSTABLE SHELL #1124":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 11, 2025"}],"A & P CORNER MARKET LLC":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 10, 2025"}],"DIYA MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 10, 2025"}],"AMHERST STREET SHELL #1123 - 190 AMHERST - NASHUA":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 10, 2025"}],"BROAD ST. PETROLEUM LLC":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 09, 2025"}],"NASHUA SHELL #1127 - 620 AMHERST ST":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 08, 2025"}],"WEST HOLLIS STREET SHELL #1126":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 08, 2025"}],"NOURIA ENERGY #1122 - NASH - BROAD ST":[{"item":"Illuminated Sign","brand":"Good 2 grow","count":1,"last":"Dec 08, 2025"}],"TJ'S DELI AND CATERING":[{"item":"Illuminated Sign","brand":"Mich Ultra","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Dec 11, 2025"}],"99 REST - NASHUA":[{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Mar 11, 2026"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Nov 05, 2025"}],"SHORTY'S MEXICAN ROADHOUSE":[{"item":"Large Tap Marker","brand":"BBCO - Wizard","count":1,"last":"Mar 09, 2026"}],"RIVIERA NAYARITA MEXICAN-STYLE SEAFOOD":[{"item":"Large Tap Marker","brand":"Dos Equis Amber","count":1,"last":"Jan 21, 2026"}],"PINE STREET EATERY":[{"item":"Large Tap Marker","brand":"Downeast - Cranberry","count":1,"last":"Nov 06, 2025"}],"BOWLING ACRES":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Kelsen - Paradigm","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Oktoberfest","count":1,"last":"Sep 17, 2025"}],"AMERICAN LEGION POST 11 - JAFFREY":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 28, 2025"}],"RILEY'S PLACE":[{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Oct 27, 2025"}],"HARLOWS PUBLIC HOUSE":[{"item":"Large Tap Marker","brand":"Austin Street - Patina","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"14th Star - N Maple Br","count":1,"last":"Sep 24, 2025"}],"DEL ROSSI'S TRATTORIA OF DUBLIN":[{"item":"Large Tap Marker","brand":"Stoneface - Duderino","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Citizen Cider - Unified Press","count":1,"last":"Oct 21, 2025"}],"POST & BEAM":[{"item":"Large Tap Marker","brand":"603 Brew - Smoketoberfest","count":1,"last":"Sep 24, 2025"}],"UNION COFFEE COMPANY":[{"item":"Large Tap Marker","brand":"Wormtown - Fresh Patch","count":1,"last":"Sep 22, 2025"}],"COOPER'S HILL":[{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 17, 2025"}],"HAMPSHIRE HILLS S&F CLUB":[{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Sep 16, 2025"}]},"jcaron":{"AMIGOS MEXICAN CANTINA":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Feb 16, 2026"}],"MARKET BASKET #39 NASHUA - NORTHWEST BLVD":[{"item":"Display/ Display Enhancer","brand":"Wormtown - Irish Red","count":1,"last":"Mar 01, 2026"},{"item":"Display/ Display Enhancer","brand":"Nutrl Lime","count":1,"last":"Mar 01, 2026"},{"item":"Display/ Display Enhancer","brand":"Murphy's Irish","count":1,"last":"Mar 01, 2026"},{"item":"Display/ Display Enhancer","brand":"Athletic - All Out","count":1,"last":"Feb 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 11, 2026"}],"SHAW'S #2492 - MILFORD":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Feb 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Feb 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Athletic - All Out","count":1,"last":"Feb 11, 2026"}],"SMOKE HAUS":[{"item":"Small Tap Marker","brand":"Deciduous - Lollipop Rasp","count":1,"last":"Mar 11, 2026"}]},"jmorse":{"RAMUNTOS - CLAREMONT":[{"item":"Coaster","brand":"Bud Light","count":5,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Helles","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Nov 17, 2025"},{"item":"Other","brand":"Downeast - Original","count":1,"last":"Sep 29, 2025"},{"item":"Other","brand":"Fiddlehead - IPA","count":1,"last":"Sep 22, 2025"}],"TREMONT HOUSE OF PIZZA":[{"item":"Large Tap Marker","brand":"Downeast - Black Cherry","count":2,"last":"Feb 19, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Prickly Pear","count":2,"last":"Jan 22, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Heart","count":2,"last":"Dec 01, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Peeper","count":1,"last":"Feb 23, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Another One","count":1,"last":"Feb 23, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Feb 03, 2026"},{"item":"Large Tap Marker","brand":"Citizen Cider - BD Apple Pie","count":1,"last":"Jan 06, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 14, 2025"}],"DADDY'S PIZZA":[{"item":"Coaster","brand":"Bud Light","count":7,"last":"Sep 23, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Oct 07, 2025"}],"SHAKER & FORK RESTAURANT & BAR (TIME-OUT SPORTS )":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Nov 22, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":2,"last":"Sep 29, 2025"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 26, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Hodad","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Nov 16, 2025"},{"item":"Large Tap Marker","brand":"Shocktop","count":1,"last":"Oct 13, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 13, 2025"},{"item":"Other","brand":"Kona - Big Wave","count":1,"last":"Mar 03, 2026"}],"CASA JALISCO BAR & GRILL":[{"item":"Other","brand":"Dos Equis","count":2,"last":"Jan 06, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 18, 2025"},{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Mar 03, 2026"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Mar 03, 2026"}],"HELEN'S PLACE":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Nov 12, 2025"}],"CLAREMONT COUNTRY CLUB":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 06, 2025"}],"FORBES TAVERN AND EVENTS":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"Henniker - First One Today","count":1,"last":"Mar 11, 2026"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Apple Pie","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Feb 04, 2026"},{"item":"Large Tap Marker","brand":"Stoneface - Sunday Sauce","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - Hodad","count":1,"last":"Jan 14, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 14, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Pond Hockey","count":1,"last":"Dec 30, 2025"},{"item":"Large Tap Marker","brand":"Founders - Porter","count":1,"last":"Dec 30, 2025"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Heart","count":1,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Waters","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Tiny","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - NH Lager","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"True North - Witch","count":1,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flap Jack","count":1,"last":"Sep 17, 2025"},{"item":"Other","brand":"Fiddlehead - IPA","count":1,"last":"Sep 24, 2025"}],"IMPERIAL BUFFET & LOUNGE":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 16, 2025"},{"item":"Illuminated Sign","brand":"Mich Ultra","count":1,"last":"Oct 14, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 14, 2025"}],"NEWPORT MEAT MARKET":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Nov 05, 2025"},{"item":"Other","brand":"Cabot","count":1,"last":"Dec 23, 2025"}],"SHOP EXPRESS":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"},{"item":"Other","brand":"Cabot","count":1,"last":"Dec 23, 2025"}],"CIRCLE K #7204 - NEWPORT":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 05, 2025"}],"BIRNEY'S MINI MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"T-BIRD MINI MART - CLAREMONT-WASHINGTON ST":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Sep 29, 2025"}],"T-BIRD MINI MART - CLAREMONT-CHARLESTOWN RD":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Sep 30, 2025"}],"MARKET BASKET #53 CLAREMNT":[{"item":"Illuminated Sign","brand":"Bud Light","count":2,"last":"Feb 12, 2026"},{"item":"Illuminated Sign","brand":"Fiddlehead - IPA","count":1,"last":"Jan 29, 2026"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Nov 20, 2025"}],"CROYDON GENERAL STORE":[{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Dec 03, 2025"}],"TAVERNE ON THE SQUARE LLC":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":2,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Vienna","count":2,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Apple Pie","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Jan 05, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Jan 05, 2026"},{"item":"Large Tap Marker","brand":"Stoneface - Berliner Weisse","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Sep 16, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Jan 05, 2026"}],"RANCHO VIEJO MEXICAN FOOD AND CANTINA":[{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Mar 03, 2026"}],"AMERICAN LEGION POST 29 - CLAREMONT":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 03, 2026"}],"POLISH AMER CITIZENS CLUB-CLAREMONT":[{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Nov 10, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Nov 10, 2025"}],"WAL-MART #1975 - CLAREMONT":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Shocktop","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Frost - Lush","count":1,"last":"Oct 09, 2025"}],"RUM BROOK MARKET":[{"item":"Other","brand":"Cabot","count":1,"last":"Dec 23, 2025"}],"JIFFY MART #200431 - CLAREMONT":[{"item":"Other","brand":"Bud Light","count":1,"last":"Nov 20, 2025"}],"CLAREMONT MOBIL":[{"item":"Other","brand":"Bud Light","count":1,"last":"Oct 30, 2025"}],"THE 12% SOLUTION":[{"item":"Other","brand":"Clearly Canadian Mountain Blackberry","count":1,"last":"Sep 29, 2025"},{"item":"Other","brand":"Clearly Canadian Country Raspberry","count":1,"last":"Sep 22, 2025"}],"COMMON MAN - CLAREMONT":[{"item":"Small Tap Marker","brand":"Downeast - Winter","count":1,"last":"Dec 08, 2025"},{"item":"Small Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 29, 2025"}]},"jgrumblatt":{"BUBBA'S BAR AND GRILLE":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 26, 2026"},{"item":"Promo Item","brand":"Athletic - Run Wild","count":1,"last":"Dec 09, 2025"}],"SALT HILL PUB - NEWBURY":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 21, 2025"}],"JALISCO MEXICAN BAR & GRILL":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Feb 03, 2026"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Oct 07, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 30, 2025"}],"SALT HILL PUB - NEWPORT":[{"item":"Coaster","brand":"Budweiser","count":2,"last":"Oct 23, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Dec 31, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Nov 13, 2025"}],"FORESTERS OF AMERICA":[{"item":"Coaster","brand":"Budweiser","count":2,"last":"Jan 06, 2026"}],"HANNAFORD #8246 - NEW LONDON":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Mar 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Mar 11, 2026"}],"SHAW'S #4534 - NEWPORT":[{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Jan 15, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Jan 08, 2026"}],"JAKES MARKET AND DELI - GEORGES MILLS":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 09, 2025"}],"JAKES MARKET AND DELI- NEW LONDON":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 09, 2025"}],"CIRCLE K #7247 - ANDOVER":[{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Dec 07, 2025"}],"RAGGED MOUNTAIN":[{"item":"Large Tap Marker","brand":"Left Hand - Coconut Milk Stout","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Dec 30, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 24, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Dec 10, 2025"}],"PETER CHRISTIANS TAVERN":[{"item":"Large Tap Marker","brand":"Zero Gravity - Extra Stout","count":1,"last":"Jan 21, 2026"},{"item":"Large Tap Marker","brand":"14th Star - Maple Br","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Oct 01, 2025"},{"item":"Other","brand":"Concord Craft - White Mtn White","count":1,"last":"Feb 25, 2026"},{"item":"Other","brand":"Concord Craft - Pond Hockey","count":1,"last":"Jan 21, 2026"},{"item":"Other","brand":"Bud Light","count":1,"last":"Nov 25, 2025"}],"SUNA RESTAURANT":[{"item":"Large Tap Marker","brand":"von Trapp - Pilsner","count":2,"last":"Dec 10, 2025"}],"WILDWOOD SMOKEHOUSE":[{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Dec 10, 2025"}],"LITTLE BROTHERS BURGERS":[{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Oktoberfest","count":1,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Octoberfest","count":1,"last":"Sep 17, 2025"}],"VAIL RESORT/ MOUNT SUNAPEE":[{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Nov 22, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Flyway","count":1,"last":"Nov 22, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Miles & Miles","count":1,"last":"Nov 22, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Green State Light","count":1,"last":"Nov 22, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Nov 22, 2025"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 01, 2025"},{"item":"Other","brand":"Nutrl","count":1,"last":"Nov 22, 2025"},{"item":"Other","brand":"Mich Ultra","count":1,"last":"Nov 22, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Nov 22, 2025"},{"item":"Small Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Nov 22, 2025"}],"THE REFINERY":[{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":2,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Lighthouse","count":1,"last":"Nov 19, 2025"}],"STOCKWELL RESTAURANT":[{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Sep 24, 2025"}],"NEWBURY DELI":[{"item":"Other","brand":"Athletic - Upside Dawn","count":1,"last":"Sep 30, 2025"}]},"amartin":{"PANDA GOURMET":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Sep 25, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 26, 2026"}],"LYNN'S 102 TAVERN":[{"item":"Coaster","brand":"Nutrl","count":2,"last":"Jan 08, 2026"},{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 26, 2026"},{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Nov 20, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Oct 09, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Sep 18, 2025"}],"BACKSTREET BAR & GRILL LLC":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 26, 2026"},{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Jan 15, 2026"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 15, 2026"},{"item":"Other","brand":"Bud Light","count":1,"last":"Dec 04, 2025"},{"item":"Small Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Mar 12, 2026"}],"ODD FELLOWS BREWING COMPANY":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 25, 2026"}],"BAR":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 19, 2026"}],"NEW NAN KING RESTAURANT":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 10, 2025"},{"item":"Small Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Feb 04, 2026"}],"ROYAL PIZZA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 05, 2025"}],"FODY'S TAVERN (NASHUA)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Oct 29, 2025"}],"LA HACIENDA DEL RIO":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 26, 2025"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Oct 30, 2025"}],"SAKURA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 17, 2025"}],"PHO TAI LOC":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 17, 2025"}],"SHAW'S #0113 - NASHUA - MAIN ST":[{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Jan 15, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 18, 2025"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Dec 18, 2025"},{"item":"Display/ Display Enhancer","brand":"Heineken","count":1,"last":"Nov 20, 2025"},{"item":"Display/ Display Enhancer","brand":"Stella Artois","count":1,"last":"Nov 20, 2025"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Nov 20, 2025"},{"item":"Display/ Display Enhancer","brand":"Super Coffee","count":1,"last":"Oct 02, 2025"},{"item":"Other","brand":"Athletic - Run Wild","count":1,"last":"Dec 18, 2025"},{"item":"Other","brand":"Heineken","count":1,"last":"Dec 18, 2025"}],"SPECTACLE MANAGEMENT INC":[{"item":"Large Tap Marker","brand":"New Belgium - Fat Tire","count":1,"last":"Feb 18, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Nov 12, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Fresh Patch","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Maple Br","count":1,"last":"Oct 15, 2025"}],"SURF RESTAURANT INC":[{"item":"Large Tap Marker","brand":"Breck Christmas","count":2,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Jan 29, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 22, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Copper Legend","count":1,"last":"Sep 18, 2025"}],"RIVERWALK BAKERY & CAFE":[{"item":"Large Tap Marker","brand":"1911 - Cider Donut","count":1,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 17, 2025"}],"T&T WAY":[{"item":"Other","brand":"Dos Equis","count":1,"last":"Feb 26, 2026"}],"CASEY MAGEE'S":[{"item":"Small Tap Marker","brand":"von Trapp - Pilsner","count":1,"last":"Dec 04, 2025"}]},"pbelanger":{"BRADYS BAR AND GRILL":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Feb 17, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Jan 20, 2026"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 18, 2025"}],"EMMAS 321":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Irish Stout","count":1,"last":"Dec 30, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Evergreen","count":1,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"Widowmaker - Green Wizard","count":1,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Nov 05, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Citizen Cider - BD Donut","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"Citizen Cider - B Cider","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Kelsen - Gallowglass","count":1,"last":"Oct 01, 2025"}],"MI JALISCO - PETERBORO":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Jan 06, 2026"}],"MEXICA MEXICAN RESTAURANT":[{"item":"Coaster","brand":"Dos Equis","count":1,"last":"Feb 16, 2026"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Little Wizard","count":1,"last":"Nov 17, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 01, 2025"}],"COOPER'S HILL":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Jan 20, 2026"},{"item":"Coaster","brand":"Fiddlehead - IPA","count":1,"last":"Nov 24, 2025"}],"RUSTIC TABLE (THE)":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Sep 30, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - House Lager","count":1,"last":"Oct 14, 2025"}],"VFW SOCIAL CLUB":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Sep 22, 2025"},{"item":"Small Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 27, 2025"}],"PAPAGALLOS RESTAURANT":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 25, 2025"}],"SHAW'S #4694 - PETERBORO":[{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Mar 05, 2026"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Jan 15, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Dec 31, 2025"}],"MR MIKE'S - FITZWILLIAM":[{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Jan 06, 2026"},{"item":"Other","brand":"Good 2 grow","count":1,"last":"Dec 01, 2025"}],"ALLTOWN MARKET #200311- PETERBOROUGH":[{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Jan 06, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 09, 2025"}],"MR MIKE'S - JAFFREY":[{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Jan 06, 2026"}],"T-BIRD MINI MART - SWANZEY MONADNOCK HIGHWAY #676":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Oct 27, 2025"}],"CHA'S GEM SHOP AND CONV":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Oct 23, 2025"}],"WEST OF THE BORDER":[{"item":"Illuminated Sign","brand":"Mich Ultra","count":1,"last":"Nov 25, 2025"},{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Nov 25, 2025"}],"NEW WORLD GAS - RINDGE":[{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Nov 19, 2025"},{"item":"Illuminated Sign","brand":"Mich Ultra","count":1,"last":"Nov 19, 2025"}],"BOWLING ACRES":[{"item":"Large Tap Marker","brand":"Henniker - Wrking Man Porter","count":1,"last":"Feb 10, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"Widowmaker - Green Wizard","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Goose - Bourb County","count":1,"last":"Nov 24, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 18, 2025"},{"item":"Large Tap Marker","brand":"Able - Victory Nor Defeat","count":1,"last":"Nov 04, 2025"},{"item":"Large Tap Marker","brand":"Widowmaker - Blue Comet","count":1,"last":"Nov 04, 2025"}],"PHOENIX SMOKEHOUSE AND TAQUERIA":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Feb 04, 2026"}],"BANTAM GRILL":[{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Feb 03, 2026"}],"WOODBOUND INN":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Nov 05, 2025"},{"item":"Small Tap Marker","brand":"Stella Artois","count":1,"last":"Oct 22, 2025"}],"WATERHOUSE BISTRO":[{"item":"Large Tap Marker","brand":"Founders - Porter","count":1,"last":"Jan 27, 2026"}],"HARLOWS PUBLIC HOUSE":[{"item":"Large Tap Marker","brand":"Maine Beer Co - N Mean Tom","count":1,"last":"Jan 20, 2026"},{"item":"Large Tap Marker","brand":"Goose - Bourb County","count":1,"last":"Nov 24, 2025"}],"MONADNOCK COUNTRY CLUB":[{"item":"Other","brand":"Bud Light","count":1,"last":"Feb 03, 2026"}],"STATELINE GROCERY'S":[{"item":"Other","brand":"Busch Light","count":1,"last":"Oct 13, 2025"}]},"mcanavan":{"LUK'S BAR & GRILL":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 18, 2026"}],"NATIONAL CLUB (THE)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 03, 2025"}]},"aparente":{"SAYDES RESTAURANT INC.":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Feb 18, 2026"}],"LYNN'S 102 TAVERN":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Feb 12, 2026"}],"PEDDLER'S DAUGHTER":[{"item":"Coaster","brand":"Stella Artois","count":1,"last":"Oct 01, 2025"}],"NATIONAL CLUB (THE)":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Sep 29, 2025"}],"HIDDEN PIG (THE)":[{"item":"Large Tap Marker","brand":"Downeast - Original","count":2,"last":"Dec 04, 2025"}],"COACH STOP":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Oct 29, 2025"}],"RIVER ROAD TAVERN":[{"item":"Large Tap Marker","brand":"True North - Witch","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Henniker - West Coast Colab","count":1,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Able - Broad Arrow","count":1,"last":"Oct 16, 2025"}],"PRESSED CAFE - BEDFORD":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Oct 16, 2025"}]},"epaquette":{"RANCHO VIEJO MEXICAN FOOD AND CANTINA":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 17, 2026"}],"MOLLYS RESTAURANT":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Feb 09, 2026"},{"item":"Small Tap Marker","brand":"Downeast - Pomegranate","count":1,"last":"Feb 09, 2026"}],"FORESTERS OF AMERICA":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Jan 27, 2026"}],"JALISCO MEXICAN BAR & GRILL":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Nov 04, 2025"}],"BUBBA'S BAR AND GRILLE":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 30, 2025"}],"DADDY'S PIZZA":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Feb 17, 2026"}],"LEBANON VILLAGE PIZZA":[{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Feb 12, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Nov 10, 2025"}],"STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)":[{"item":"Large Tap Marker","brand":"Frost - Little Lush","count":1,"last":"Feb 10, 2026"}],"SAWTOOTH KITCHEN LLC":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Nov 13, 2025"}],"SALT HILL PUB - NEWBURY":[{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Nov 04, 2025"}],"SALT HILL PUB - NEWPORT":[{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Oct 30, 2025"}],"FORBES TAVERN AND EVENTS":[{"item":"Large Tap Marker","brand":"Downeast - Pumpkin","count":1,"last":"Oct 22, 2025"},{"item":"Large Tap Marker","brand":"Upper Pass - First Drop","count":1,"last":"Oct 22, 2025"}],"CHILI'S - W.LEB":[{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cider Donut","count":1,"last":"Oct 15, 2025"}],"99 REST - W.LEB":[{"item":"Large Tap Marker","brand":"Stella Artois","count":2,"last":"Oct 13, 2025"}],"SAKANA JAPANESE RESTAURANT":[{"item":"Other","brand":"Kona - Big Wave","count":1,"last":"Nov 04, 2025"}],"T-BIRD MINI MART - CLAREMONT-WASHINGTON ST":[{"item":"Other","brand":"Good 2 grow","count":1,"last":"Oct 20, 2025"}]},"eplatt":{"PPC KITCHEN & BAR":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Oct 01, 2025"},{"item":"Large Tap Marker","brand":"Foundation - Epiphany","count":2,"last":"Nov 25, 2025"},{"item":"Large Tap Marker","brand":"Epigram - Temptation","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Heart","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"BBCO - Phantom Glow","count":1,"last":"Dec 03, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Cranberry","count":1,"last":"Nov 05, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 05, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easier Operator","count":1,"last":"Oct 29, 2025"},{"item":"Large Tap Marker","brand":"Southern - Caramel Pumking","count":1,"last":"Oct 15, 2025"}],"PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD":[{"item":"Coaster","brand":"Bud Light","count":4,"last":"Nov 25, 2025"},{"item":"Coaster","brand":"Mich Ultra","count":2,"last":"Nov 25, 2025"},{"item":"Coaster","brand":"Fiddlehead - IPA","count":1,"last":"Nov 25, 2025"},{"item":"Coaster","brand":"Budweiser","count":1,"last":"Oct 16, 2025"},{"item":"Coaster","brand":"Mich Ultra Org","count":1,"last":"Oct 16, 2025"}],"MARKET BASKET #25 PLAISTOW":[{"item":"Display/ Display Enhancer","brand":"Popwell","count":1,"last":"Feb 12, 2026"}],"SHAW'S #3669 - PLAISTOW":[{"item":"Display/ Display Enhancer","brand":"Super Coffee","count":1,"last":"Jan 29, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Jan 19, 2026"}],"PLAISTOW MINI EXPRESS":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 21, 2025"}],"THE KITCHEN BY JTAPS":[{"item":"Small Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Dec 10, 2025"}]},"adennis":{"VILLAGE TRESTLE (THE)":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 03, 2026"}],"T-BONES - BEDFORD":[{"item":"Coaster","brand":"Nutrl","count":1,"last":"Feb 02, 2026"}],"PINARDVILLE ATHLETIC CLUB":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 06, 2026"}],"DON RAMON":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 05, 2026"}],"THIRSTY MOOSE":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Oct 07, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Nov 11, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 04, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Hop Slinger IPA","count":1,"last":"Oct 28, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Founders - CBS","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Founders - KBS","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Oct 14, 2025"},{"item":"Large Tap Marker","brand":"Able - Homecoming Pumpkin Ale","count":1,"last":"Oct 14, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Oct 07, 2025"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Sour Face","count":1,"last":"Oct 07, 2025"},{"item":"Large Tap Marker","brand":"Henniker - Kolsch","count":1,"last":"Oct 07, 2025"},{"item":"Large Tap Marker","brand":"Citizen Cider - Strawb Haze","count":1,"last":"Sep 23, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Sep 23, 2025"}],"JADE DRAGON-MERRIMACK":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 28, 2025"}],"K2 MOBIL MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Dec 02, 2025"}],"PIZZICO - MERRIMACK":[{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Jan 05, 2026"}],"RIVER ROAD TAVERN":[{"item":"Large Tap Marker","brand":"Stoneface - Imaginary Cartwheel","count":1,"last":"Dec 18, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":1,"last":"Nov 06, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Pilsner","count":1,"last":"Nov 06, 2025"}],"TAVERN IN THE SQUARE BEDFORD LLC":[{"item":"Large Tap Marker","brand":"Maine Beer Co - Dinner","count":1,"last":"Dec 18, 2025"}],"TOMAHAWK BUTCHERY & TAVERN (REST)":[{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Nov 03, 2025"},{"item":"Large Tap Marker","brand":"Berkshire - Coffehouse Porter","count":1,"last":"Oct 20, 2025"}],"FRONTERA GRILL OF NASHUA":[{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 29, 2025"}],"TORTILLA FLAT":[{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Oct 28, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 28, 2025"}],"MERRIMACK TEN PIN CENTER":[{"item":"Large Tap Marker","brand":"Concord Craft - Conquered","count":1,"last":"Oct 21, 2025"}],"LOBSTER BOAT RESTAURANT":[{"item":"Large Tap Marker","brand":"Able - Lady of the Lake","count":1,"last":"Oct 21, 2025"}],"GIORGIO'S TRATTORIA - MERRIMACK":[{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 16, 2025"}],"HOMESTEAD RESTAURANT & TAVERN":[{"item":"Large Tap Marker","brand":"603 Brew - Slightly Tstd","count":1,"last":"Oct 14, 2025"}],"COMMON MAN - MERRIMACK":[{"item":"Large Tap Marker","brand":"Carlson - Oak Hill","count":1,"last":"Sep 29, 2025"}],"AMERICAN LEGION POST 98 - MERRIMACK":[{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 16, 2025"},{"item":"Small Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 30, 2025"}]},"jsewall":{"SALT HILL PUB - LEBANON":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Bells - Kalamazo","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Henniker - King Misanthrope","count":1,"last":"Feb 02, 2026"}],"MOLLYS RESTAURANT":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Kelsen - Paradigm","count":1,"last":"Mar 09, 2026"},{"item":"Large Tap Marker","brand":"Jack's Abby - Citrus Wave","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Kapital Kolsch","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"von Trapp - Dunkel","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Kelsen - Battle Axe","count":1,"last":"Jan 22, 2026"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Stoneface - Imaginary Cartwheel","count":1,"last":"Dec 28, 2025"}],"LUI LUI - WEST LEBANON":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 22, 2025"}],"APPLEBEES - W.LEB #6732":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 18, 2025"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Nov 06, 2025"}],"SHAW'S #4555 - W.LEB":[{"item":"Display/ Display Enhancer","brand":"Budweiser","count":2,"last":"Feb 18, 2026"},{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Jan 15, 2026"},{"item":"Display/ Display Enhancer","brand":"Athletic - Run Wild","count":2,"last":"Oct 08, 2025"},{"item":"Display/ Display Enhancer","brand":"Ryse Energy + Protein","count":1,"last":"Mar 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Mar 11, 2026"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 25, 2025"},{"item":"Other","brand":"Sparkling Ice","count":1,"last":"Dec 30, 2025"}],"DISCOUNT BEVERAGE KING W. LEB":[{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Feb 02, 2026"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Nov 20, 2025"},{"item":"Display/ Display Enhancer","brand":"Heineken","count":1,"last":"Nov 20, 2025"}],"HANNAFORD #8266 - W.LEB":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 26, 2025"}],"TARGET # 3401 - W. LEBANON":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 25, 2025"}],"MERIDEN DELI MART":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 19, 2025"}],"FOUR CORNERS GENERAL STORE":[{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Nov 18, 2025"},{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"NH-VT SMOKE & BEVERAGE OUTLET INC":[{"item":"Display/ Display Enhancer","brand":"Downeast - Original","count":1,"last":"Nov 17, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Dec 01, 2025"}],"SHAWNEE GENERAL STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"LYME COUNTRY STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"APPLEKNOCKERS STORE":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":1,"last":"Nov 04, 2025"}],"CHILI'S - W.LEB":[{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Feb 19, 2026"}],"99 REST - W.LEB":[{"item":"Other","brand":"Stella Artois","count":2,"last":"Oct 02, 2025"},{"item":"Illuminated Sign","brand":"Fiddlehead - IPA","count":1,"last":"Oct 30, 2025"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 02, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Blackberry","count":1,"last":"Feb 05, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Oct 02, 2025"}],"UPPER VALLEY EVENT CENTER":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 09, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 14, 2025"}],"WEATHERVANE - W.LEB":[{"item":"Large Tap Marker","brand":"BBCO - Lunar Wizard","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Concord Craft - Irish Stout","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Bells - Two Hearted","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 22, 2025"}],"POOR THOMS TAVERN":[{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Feb 25, 2026"},{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Jan 07, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Jan 07, 2026"},{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Dec 17, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Green State","count":1,"last":"Dec 03, 2025"}],"STELLA'S ITALIAN KITCHEN & CAFE (OFF PREMISE)":[{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":2,"last":"Dec 29, 2025"},{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Jan 13, 2026"},{"item":"Large Tap Marker","brand":"BBCO - Lighthouse","count":1,"last":"Dec 29, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Sep 30, 2025"},{"item":"Large Tap Marker","brand":"14th Star - Maple Br","count":1,"last":"Sep 23, 2025"}],"PEYTON PLACE RESTAURANT":[{"item":"Large Tap Marker","brand":"Deciduous - Easier Operator","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Frost - Little Lush","count":1,"last":"Nov 18, 2025"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Nov 18, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Nov 18, 2025"}],"WICKED TASTY (CATERING)":[{"item":"Large Tap Marker","brand":"Wormtown - Be Hoppy","count":1,"last":"Feb 03, 2026"},{"item":"Large Tap Marker","brand":"Mighty Squirrel - Cloud Candy","count":1,"last":"Jan 20, 2026"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Jan 20, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Sep 23, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Sep 15, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 15, 2025"},{"item":"Large Tap Marker","brand":"Jack's Abby - Copper Legend","count":1,"last":"Sep 15, 2025"},{"item":"Large Tap Marker","brand":"von Trapp - Oktober","count":1,"last":"Sep 15, 2025"},{"item":"Small Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Feb 16, 2026"},{"item":"Small Tap Marker","brand":"Downeast - Original","count":1,"last":"Feb 16, 2026"},{"item":"Small Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 16, 2026"}],"BUDDY T'S":[{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Jan 08, 2026"},{"item":"Large Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Jan 08, 2026"}],"SAWTOOTH KITCHEN LLC":[{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Jan 05, 2026"},{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Nov 13, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":1,"last":"Nov 06, 2025"},{"item":"Large Tap Marker","brand":"Throwback - Rule Roost","count":1,"last":"Oct 08, 2025"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Sep 25, 2025"}],"LEBANON VILLAGE PIZZA":[{"item":"Large Tap Marker","brand":"Jack's Abby - Extra Layer","count":1,"last":"Dec 04, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Oct 06, 2025"},{"item":"Large Tap Marker","brand":"Zero Gravity - Cone Head","count":1,"last":"Sep 25, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Safe Space","count":1,"last":"Sep 25, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 15, 2025"}],"LEBANON LODGE OF ELKS":[{"item":"Large Tap Marker","brand":"Tuckerman - Pale Ale","count":1,"last":"Oct 27, 2025"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 15, 2025"}],"THREE TOMATOES TRATTORIA":[{"item":"Large Tap Marker","brand":"Wormtown - Fresh Patch","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Slightly Tstd","count":1,"last":"Oct 14, 2025"},{"item":"Small Tap Marker","brand":"Zero Gravity - Pisolino","count":1,"last":"Oct 23, 2025"}]},"bgermano":{"STAGE HANDS RESTAURANT":[{"item":"Coaster","brand":"Bud Light","count":3,"last":"Sep 23, 2025"}],"T-BIRD MINI MART - W. SWANZEY":[{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Mar 05, 2026"}],"WAL-MART #3549 - KEENE":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Feb 19, 2026"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Jan 29, 2026"},{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Dec 31, 2025"}],"PRICE CHOPPER #208 - KEENE":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":6,"last":"Oct 23, 2025"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":2,"last":"Nov 26, 2025"},{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Sep 18, 2025"}],"CRAFT MARKET AT RIVERSIDE":[{"item":"Display/ Display Enhancer","brand":"Johny Bootlegger","count":1,"last":"Feb 05, 2026"},{"item":"Illuminated Sign","brand":"Stella Artois","count":1,"last":"Mar 12, 2026"},{"item":"Illuminated Sign","brand":"Kona - Big Wave","count":1,"last":"Mar 12, 2026"},{"item":"Illuminated Sign","brand":"Busch Light","count":1,"last":"Mar 12, 2026"},{"item":"Illuminated Sign","brand":"Fiddlehead - IPA","count":1,"last":"Feb 03, 2026"},{"item":"Illuminated Sign","brand":"BL Seltzer Variety","count":1,"last":"Feb 03, 2026"},{"item":"Illuminated Sign","brand":"Bud Light","count":1,"last":"Feb 03, 2026"}],"MARKET BASKET #64 SWANZEY":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":6,"last":"Oct 02, 2025"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":3,"last":"Nov 13, 2025"},{"item":"Display/ Display Enhancer","brand":"Heineken","count":2,"last":"Nov 13, 2025"},{"item":"Display/ Display Enhancer","brand":"Sparkling Ice","count":1,"last":"Jan 19, 2026"},{"item":"Display/ Display Enhancer","brand":"New Belgium - Fat Tire","count":1,"last":"Sep 25, 2025"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Sep 25, 2025"}],"BEAVER STREET MARKET":[{"item":"Display/ Display Enhancer","brand":"Good 2 grow","count":2,"last":"Nov 18, 2025"}],"SEVEN ELEV #32504 B- KEENE":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":2,"last":"Oct 28, 2025"},{"item":"Other","brand":"Bud Light","count":1,"last":"Oct 28, 2025"}],"SWANZEY NEIGHBOR":[{"item":"Illuminated Sign","brand":"Mich Ultra","count":1,"last":"Nov 18, 2025"}],"ATHEN'S PIZZA":[{"item":"Large Tap Marker","brand":"Downeast - Cranberry","count":1,"last":"Nov 11, 2025"}],"BRETWOOD GOLF COURSE":[{"item":"Large Tap Marker","brand":"Jack's Abby - Copper Legend","count":1,"last":"Sep 15, 2025"}]},"pvoniderstin":{"MILANO HOUSE OF PIZZA-NASHUA":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Jan 12, 2026"}],"TACO TIME COCINA & CANTINA":[{"item":"Coaster","brand":"Dos Equis Amber","count":1,"last":"Dec 10, 2025"}],"AMERICAN LEGION POST 23 - MILFORD":[{"item":"Coaster","brand":"Budweiser","count":1,"last":"Dec 09, 2025"}],"VFW #4368 - MILFORD":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Dec 09, 2025"}],"THIRSTY MOOSE":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 07, 2025"},{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 07, 2025"}],"CHILI'S - NASHUA - DW HWY":[{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Feb 24, 2026"}],"NATIONAL CLUB (THE)":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 15, 2026"}],"EL TAPATIO RESTAURANTE MEXICANO LLC":[{"item":"Large Tap Marker","brand":"Fiddlehead - IPA","count":1,"last":"Jan 14, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 08, 2025"}],"OLDE TOWNE TAVERN":[{"item":"Large Tap Marker","brand":"Deciduous - NH Lager","count":1,"last":"Dec 09, 2025"}],"WILLIE JEWELL'S OLD SCHOOL BBQ":[{"item":"Large Tap Marker","brand":"603 Brew - IPA","count":1,"last":"Oct 08, 2025"}],"EVVIVA TRATTORIA - NASHUA":[{"item":"Large Tap Marker","brand":"Bud Light","count":1,"last":"Oct 01, 2025"}]},"jgiuffrida":{"RED ROBIN GOURMET BURGERS - SALEM":[{"item":"Coaster","brand":"Bud Light","count":2,"last":"Dec 31, 2025"},{"item":"Large Tap Marker","brand":"Wormtown - Blizzard","count":2,"last":"Nov 06, 2025"},{"item":"Large Tap Marker","brand":"603 Brew - Wood Devil IPA","count":2,"last":"Oct 16, 2025"},{"item":"Large Tap Marker","brand":"Gold Road Mango Cart","count":1,"last":"Mar 12, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Prickly Pear","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Dec 31, 2025"}],"99 REST - SALEM":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Dec 01, 2025"},{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 09, 2026"},{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Sep 22, 2025"},{"item":"Other","brand":"Stella Artois","count":1,"last":"Sep 22, 2025"}],"PAR28":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 15, 2025"},{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Feb 02, 2026"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Jan 05, 2026"}],"MARKET BASKET #06 SALEM":[{"item":"Display/ Display Enhancer","brand":"Stella Artois","count":2,"last":"Feb 26, 2026"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":2,"last":"Sep 23, 2025"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Feb 04, 2026"},{"item":"Display/ Display Enhancer","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 15, 2025"},{"item":"Large Tap Marker","brand":"Stoneface - IPA","count":1,"last":"Nov 16, 2025"},{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Nov 10, 2025"}],"MARKET BASKET #31 SALEM":[{"item":"Display/ Display Enhancer","brand":"Bud Light","count":1,"last":"Jan 07, 2026"},{"item":"Display/ Display Enhancer","brand":"Budweiser","count":1,"last":"Dec 03, 2025"},{"item":"Display/ Display Enhancer","brand":"Shipyard - Pumpkin Head","count":1,"last":"Oct 15, 2025"},{"item":"Display/ Display Enhancer","brand":"Mich Ultra","count":1,"last":"Sep 23, 2025"},{"item":"Other","brand":"Popwell","count":1,"last":"Oct 09, 2025"}],"SHAKING SEAFOOD":[{"item":"Large Tap Marker","brand":"Kona - Big Wave","count":1,"last":"Mar 05, 2026"},{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 18, 2025"}],"DREO FOOD AND DRINK":[{"item":"Large Tap Marker","brand":"603 Brew - Coffee Cake Porter","count":2,"last":"Dec 11, 2025"},{"item":"Large Tap Marker","brand":"Downeast - Prickly Pear","count":1,"last":"Feb 09, 2026"},{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Oct 23, 2025"}],"LIM'S SPORTS BAR & CAFE":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Jan 15, 2026"},{"item":"Large Tap Marker","brand":"Busch Light","count":1,"last":"Sep 29, 2025"}],"TOMO STEAKHOUSE":[{"item":"Large Tap Marker","brand":"Mich Ultra","count":1,"last":"Oct 30, 2025"},{"item":"Small Tap Marker","brand":"Mich Ultra","count":1,"last":"Dec 04, 2025"}]},"tpiccinono":{"KINGSTON VETS CLUB INC":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Oct 23, 2025"}],"PASTA LOFT RESTAURANT & BRICKHOUSE-HAMPSTEAD":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 24, 2025"}],"PPC KITCHEN & BAR":[{"item":"Coaster","brand":"Bud Light","count":1,"last":"Sep 24, 2025"},{"item":"Large Tap Marker","brand":"True North - Witch","count":1,"last":"Sep 17, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Four Rivers","count":1,"last":"Sep 17, 2025"}],"MARKET BASKET #25 PLAISTOW":[{"item":"Display/ Display Enhancer","brand":"Popwell","count":1,"last":"Sep 25, 2025"}],"SHAW'S #3669 - PLAISTOW":[{"item":"Display/ Display Enhancer","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 25, 2025"},{"item":"Display/ Display Enhancer","brand":"Popwell","count":1,"last":"Sep 25, 2025"}],"WINDHAM RESTAURANT (THE)":[{"item":"Large Tap Marker","brand":"Concord Craft - White Mtn White","count":1,"last":"Dec 18, 2025"},{"item":"Large Tap Marker","brand":"Newburyport - Plum Island","count":1,"last":"Dec 18, 2025"}],"PEPPERS PUB (NEW)":[{"item":"Large Tap Marker","brand":"Deciduous - Easy Operator","count":1,"last":"Dec 11, 2025"}],"RICK'S THE SPIRIT OF KINGSTON":[{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 20, 2025"}],"ATKINSON RESORT AND COUNTRY CLUB":[{"item":"Large Tap Marker","brand":"Downeast - Original","count":1,"last":"Oct 20, 2025"}],"DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)":[{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 20, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 20, 2025"}],"CARRIAGE TOWN BAR & GRILL":[{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Oct 20, 2025"}],"THE KITCHEN BY JTAPS":[{"item":"Large Tap Marker","brand":"Shipyard - Pumpkin Head","count":1,"last":"Sep 24, 2025"}]},"kford":{"HOUSE SALES":[{"item":"Coaster","brand":"Mich Ultra","count":1,"last":"Oct 17, 2025"}],"SUN BAR & GRILL":[{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Nov 20, 2025"}]},"mbertolami":{"CHA'S GEM SHOP AND CONV":[{"item":"Illuminated Sign","brand":"Budweiser","count":1,"last":"Sep 16, 2025"}]},"jcannamucio":{"JAMISON'S":[{"item":"Large Tap Marker","brand":"603 Brew - Pipes & Drums","count":1,"last":"Mar 04, 2026"},{"item":"Large Tap Marker","brand":"Founders - KBS","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Lord Hobo - Boomsauce","count":1,"last":"Feb 24, 2026"},{"item":"Large Tap Marker","brand":"Citizen Cider - Mimosa Crush","count":1,"last":"Jan 28, 2026"},{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Jan 20, 2026"},{"item":"Large Tap Marker","brand":"New Belgium - Juicy Haze","count":1,"last":"Jan 14, 2026"},{"item":"Large Tap Marker","brand":"Weihenstephaner - Kristalweiss","count":1,"last":"Dec 17, 2025"},{"item":"Small Tap Marker","brand":"Goose - Bourb County","count":1,"last":"Dec 02, 2025"}],"ATKINSON RESORT AND COUNTRY CLUB":[{"item":"Large Tap Marker","brand":"Stella Artois","count":1,"last":"Mar 02, 2026"}],"KINGSTON VETS CLUB INC":[{"item":"Large Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Feb 18, 2026"}],"HENHOUSE BAR & GRILL":[{"item":"Large Tap Marker","brand":"Concord Craft - Conquered","count":1,"last":"Jan 28, 2026"},{"item":"Small Tap Marker","brand":"Maine Beer Co - Lunch","count":1,"last":"Oct 15, 2025"}],"SADDLE UP SALOON":[{"item":"Large Tap Marker","brand":"Able - Burn the Ships","count":1,"last":"Jan 14, 2026"}],"CARRIAGE TOWN BAR & GRILL":[{"item":"Large Tap Marker","brand":"Downeast - Winter","count":1,"last":"Jan 12, 2026"},{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 27, 2025"}],"DRAFT HOUSE LAKESIDE BAR & GRILLE (THE)":[{"item":"Large Tap Marker","brand":"Downeast - Caramel Apple","count":1,"last":"Nov 03, 2025"}],"GRUMPY'S BAR & GRILL":[{"item":"Large Tap Marker","brand":"603 Brew - APL","count":1,"last":"Oct 28, 2025"}],"RICK'S THE SPIRIT OF KINGSTON":[{"item":"Small Tap Marker","brand":"Jack's Abby - Porch Fest","count":1,"last":"Mar 02, 2026"},{"item":"Small Tap Marker","brand":"Downeast - Apple Pie","count":1,"last":"Feb 22, 2026"},{"item":"Small Tap Marker","brand":"Fiddlehead - White","count":1,"last":"Nov 23, 2025"},{"item":"Small Tap Marker","brand":"Wormtown - Blizzard_2","count":1,"last":"Nov 03, 2025"}],"THE NEST PUB AND GRILL":[{"item":"Small Tap Marker","brand":"Elysian Space Dust","count":1,"last":"Feb 22, 2026"},{"item":"Small Tap Marker","brand":"Downeast - Original","count":1,"last":"Nov 03, 2025"}]},"kpeacock":{"JAMISON'S":[{"item":"Large Tap Marker","brand":"Founders - KBS","count":1,"last":"Jan 21, 2026"}],"THIRSTY MOOSE":[{"item":"Large Tap Marker","brand":"Epigram - Temptation","count":1,"last":"Dec 18, 2025"}]},"jarquiett":{"TAVERNE ON THE SQUARE LLC":[{"item":"Large Tap Marker","brand":"Shipyard - Smashed Pumpkin","count":1,"last":"Oct 21, 2025"},{"item":"Large Tap Marker","brand":"Concord Craft - Squirrel Fights","count":1,"last":"Oct 21, 2025"}],"AMERICAN LEGION POST 29 - CLAREMONT":[{"item":"Large Tap Marker","brand":"603 Brew - Winni","count":1,"last":"Oct 21, 2025"}]}};

const ITEM_TYPES = ["Coaster","Display/ Display Enhancer","Glass","Illuminated Sign","Large Tap Marker","Mirror","Other","Promo Item","Small Tap Marker","Umbrella"];
const ALL_REPS = ["adennis","amartin","aparente","bgermano","bhanscom","ddooling","dtaylor","eleahy","epaquette","eplatt","gconnor","ggage","jarquiett","jaustin","jcannamucio","jcaron","jgiuffrida","jgrumblatt","jjohnson","jmeharg","jmorse","jsewall","kford","kpeacock","krogers","lnorton","lortiz","maanderson","mbertolami","mblais","mcanavan","ncavallo","pbelanger","pvoniderstin","pwollert","rconstant","rdouzanis","rwallace","scamuso","sclark","sshaunessy","svisentin","tchagnon","tjebol","tpiccinono"];

const ITEM_ICONS = {"Coaster":"⭕","Display/ Display Enhancer":"🖼️","Glass":"🥂","Illuminated Sign":"💡","Large Tap Marker":"🍺","Mirror":"🪞","Other":"📦","Promo Item":"🎁","Small Tap Marker":"🔵","Umbrella":"☂️"};
const ITEM_COLORS = {"Coaster":"#e8a020","Display/ Display Enhancer":"#60b880","Glass":"#60a0e8","Illuminated Sign":"#f0d020","Large Tap Marker":"#e05050","Mirror":"#c080e0","Other":"#808080","Promo Item":"#e070a0","Small Tap Marker":"#40c0c0","Umbrella":"#4080d0"};

function genId() { return Date.now().toString(36) + Math.random().toString(36).slice(2,6); }
function nowStr() { return new Date().toLocaleString("en-US",{month:"short",day:"numeric",hour:"numeric",minute:"2-digit",hour12:true}); }

const ITEM_COLORS_DEFAULT = {"Coaster":"#e8a020","Display/ Display Enhancer":"#60b880","Glass":"#60a0e8","Illuminated Sign":"#f0d020","Large Tap Marker":"#e05050","Mirror":"#c080e0","Other":"#808080","Promo Item":"#e070a0","Small Tap Marker":"#40c0c0","Umbrella":"#4080d0"};
const NEW_ITEM_COLOR_POOL = ["#e8a020","#60b880","#60a0e8","#e05050","#c080e0","#e070a0","#40c0c0","#4080d0","#d06040","#50d0b0","#a0c040","#d050a0","#6070e0","#c0a030","#808080"];

function buildInitialInventory(itemTypes, brandsByItem) {
  const inv = {};
  itemTypes.forEach(item => {
    (brandsByItem[item]||[]).forEach(brand => { inv[item+"||"+brand] = 0; });
  });
  return inv;
}

// ── Color palette for item type chips on account cards
function itemChipColor(item) { return ITEM_COLORS[item] || "#888"; }

export default function BrewWMS() {
  const [role, setRole] = useState(null);
  const [repUser, setRepUser] = useState("");
  const [view, setView] = useState("home");
  // Dynamic catalog — starts from imported constants, can be extended by warehouse
  const [itemTypes, setItemTypes] = useState(() => [...ITEM_TYPES]);
  const [brandsByItem, setBrandsByItem] = useState(() => {
    const copy = {};
    Object.entries(BRANDS_BY_ITEM).forEach(([k,v]) => { copy[k] = [...v]; });
    return copy;
  });
  const [itemColors, setItemColors] = useState(() => ({...ITEM_COLORS_DEFAULT}));
  const [inventory, setInventory] = useState(() => buildInitialInventory(ITEM_TYPES, BRANDS_BY_ITEM));
  const [requests, setRequests] = useState([]);
  const [history, setHistory] = useState([]);
  const [toast, setToast] = useState(null);
  const toastRef = useRef(null);

  // Receive form
  const [rcvItem, setRcvItem] = useState(ITEM_TYPES[0]);
  const [rcvBrand, setRcvBrand] = useState("");
  const [rcvQty, setRcvQty] = useState(1);

  // Rep request form
  const [reqItem, setReqItem] = useState(ITEM_TYPES[0]);
  const [reqBrand, setReqBrand] = useState("");
  const [reqQty, setReqQty] = useState(1);
  const [reqCustomer, setReqCustomer] = useState("");
  const [reqSearch, setReqSearch] = useState("");

  // Accounts view
  const [acctSearch, setAcctSearch] = useState("");
  const [acctExpanded, setAcctExpanded] = useState(null);
  const [acctItemFilter, setAcctItemFilter] = useState("All");

  // Transfer modal
  const [transferModal, setTransferModal] = useState(null);
  const [transferTo, setTransferTo] = useState("");
  const [transferToSearch, setTransferToSearch] = useState("");
  const [transferQty, setTransferQty] = useState(1);
  const [transfers, setTransfers] = useState([]);
  const [accountOverrides, setAccountOverrides] = useState({});

  // Events & Promos shared state (shared across roles via lifted state)
  const [events, setEvents] = useState([]); // all events
  const [evtView, setEvtView] = useState("calendar"); // calendar|list|new
  const [evtCalMonth, setEvtCalMonth] = useState(new Date(2026,2,1)); // March 2026
  const [evtForm, setEvtForm] = useState({title:"",account:"",accountSearch:"",brand:"",date:"",startTime:"14:00",endTime:"17:00",notes:"",posItems:[],staffRequested:2});
  const [evtDetailId, setEvtDetailId] = useState(null);
  const [evtApprovingId, setEvtApprovingId] = useState(null);
  const [mktEvtFilter, setMktEvtFilter] = useState("all"); // all|pending|approved|conflict
  const [staffAvail, setStaffAvail] = useState({}); // {eventId: {staffName: "accepted"|"declined"}}

  // Promo staff roster — managed by Marketing Manager
  const [promoStaff, setPromoStaff] = useState([
    {id:"ps01",name:"Alyssa M.",phone:"603-555-0101",email:"alyssa@promo.com",notes:""},
    {id:"ps02",name:"Brianna K.",phone:"603-555-0102",email:"brianna@promo.com",notes:""},
    {id:"ps03",name:"Carla T.",phone:"603-555-0103",email:"carla@promo.com",notes:""},
    {id:"ps04",name:"Dana S.",phone:"603-555-0104",email:"dana@promo.com",notes:""},
    {id:"ps05",name:"Emma R.",phone:"603-555-0105",email:"emma@promo.com",notes:""},
    {id:"ps06",name:"Faith L.",phone:"603-555-0106",email:"faith@promo.com",notes:""},
    {id:"ps07",name:"Grace P.",phone:"603-555-0107",email:"grace@promo.com",notes:""},
    {id:"ps08",name:"Hailey N.",phone:"603-555-0108",email:"hailey@promo.com",notes:""},
    {id:"ps09",name:"Isabel W.",phone:"603-555-0109",email:"isabel@promo.com",notes:""},
    {id:"ps10",name:"Jenna C.",phone:"603-555-0110",email:"jenna@promo.com",notes:""},
    {id:"ps11",name:"Kayla D.",phone:"603-555-0111",email:"kayla@promo.com",notes:""},
    {id:"ps12",name:"Lauren H.",phone:"603-555-0112",email:"lauren@promo.com",notes:""},
  ]);
  const [staffSearchFilter, setStaffSearchFilter] = useState("");
  const [addStaffForm, setAddStaffForm] = useState({name:"",phone:"",email:"",notes:""});
  const [removeConfirm, setRemoveConfirm] = useState(null); // staff id pending removal
  const [editingStaff, setEditingStaff] = useState(null); // {id, name, phone, email, notes}

  function eventStatus(evt) {
    const staffAssigned = (evt.staffAssigned||[]).length;
    const staffNeeded = evt.staffRequested||1;
    const posOk = !evt.posRequested || evt.posApproved;
    const hasDate = !!evt.date;
    if (evt.status==="cancelled") return "cancelled";
    if (!hasDate) return "draft";
    if (evt.status==="approved"&&staffAssigned>=staffNeeded&&posOk) return "confirmed";
    if (evt.status==="approved"&&(staffAssigned<staffNeeded||!posOk)) return "staffing";
    if (evt.status==="pending") return "pending";
    return "draft";
  }

  function statusColor(st) {
    if (st==="confirmed") return "#44cc88";
    if (st==="staffing") return "#ffaa00";
    if (st==="pending") return "#ffaa00";
    if (st==="cancelled") return "#ff4d4d";
    return "#555";
  }
  function statusLabel(st) {
    if (st==="confirmed") return "✓ CONFIRMED";
    if (st==="staffing") return "⚠ NEEDS STAFF";
    if (st==="pending") return "⏳ PENDING APPROVAL";
    if (st==="cancelled") return "✕ CANCELLED";
    return "DRAFT";
  }

  function submitEvent() {
    const {title,account,brand,date,startTime,endTime,notes,posItems,staffRequested} = evtForm;
    if (!title||!account||!date) { showToast("Fill in event name, account, and date","#ff4444"); return; }
    const newEvt = {
      id:genId(), title, account, brand, date, startTime, endTime, notes,
      posItems: posItems||[], staffRequested: Number(staffRequested)||1,
      rep: repUser, status:"pending", createdAt:nowStr(),
      staffAssigned:[], posApproved:false, posRequested: (posItems||[]).length>0,
      approvedAt:null, approvedBy:null
    };
    setEvents(prev=>[...prev, newEvt]);
    setEvtForm({title:"",account:"",accountSearch:"",brand:"",date:"",startTime:"14:00",endTime:"17:00",notes:"",posItems:[],staffRequested:2});
    setEvtView("list");
    showToast("✓ Event submitted for approval");
  }

  function approveEvent(id) {
    setEvents(prev=>prev.map(e=>e.id===id?{...e,status:"approved",approvedAt:nowStr(),approvedBy:"Marketing Manager"}:e));
    setEvtApprovingId(null);
    showToast("✓ Event approved");
  }

  function cancelEvent(id) {
    setEvents(prev=>prev.map(e=>e.id===id?{...e,status:"cancelled"}:e));
    showToast("Event cancelled");
  }

  function assignStaff(eventId, staffName) {
    setEvents(prev=>prev.map(e=>{
      if (e.id!==eventId) return e;
      const already = e.staffAssigned||[];
      if (already.includes(staffName)) return {...e,staffAssigned:already.filter(s=>s!==staffName)};
      return {...e,staffAssigned:[...already,staffName]};
    }));
  }

  function approvePOS(eventId) {
    setEvents(prev=>prev.map(e=>e.id===eventId?{...e,posApproved:true}:e));
    showToast("✓ POS materials approved");
  }

  // Check staff conflicts on a given date
  function getStaffConflicts(date, staffName, excludeId) {
    return events.filter(e=>e.date===date&&e.id!==excludeId&&(e.staffAssigned||[]).includes(staffName)&&e.status!=="cancelled");
  }

  // Rep-visible events
  const repEvents = events.filter(e=>e.rep===repUser);

  // Catalog management (warehouse only)
  const [catNewItemName, setCatNewItemName] = useState("");
  const [catNewItemIcon, setCatNewItemIcon] = useState("📦");
  const [catSelectedItem, setCatSelectedItem] = useState("");
  const [catNewBrand, setCatNewBrand] = useState("");
  const [catBrandSearch, setCatBrandSearch] = useState("");
  const [catItemSearch, setCatItemSearch] = useState("");

  // Inventory filter
  const [invFilter, setInvFilter] = useState("");
  const [invItemFilter, setInvItemFilter] = useState("All");

  function showToast(msg, color="#44cc88") {
    setToast({msg,color});
    clearTimeout(toastRef.current);
    toastRef.current = setTimeout(()=>setToast(null),3000);
  }

  // ── Staff management functions ──
  function addStaffMember() {
    const name = addStaffForm.name.trim();
    if (!name) { showToast("Enter a name","#ff4444"); return; }
    if (promoStaff.some(s=>s.name.toLowerCase()===name.toLowerCase())) {
      showToast("A staff member with that name already exists","#ffaa00"); return;
    }
    const id = "ps"+Date.now().toString(36);
    setPromoStaff(prev=>[...prev,{id,name,phone:addStaffForm.phone.trim(),email:addStaffForm.email.trim(),notes:addStaffForm.notes.trim()}]);
    setAddStaffForm({name:"",phone:"",email:"",notes:""});
    showToast("✓ Added "+name+" to staff roster");
  }

  function removeStaffMember(id) {
    const member = promoStaff.find(s=>s.id===id);
    // Remove from any event assignments too
    setEvents(prev=>prev.map(e=>({...e, staffAssigned:(e.staffAssigned||[]).filter(n=>n!==member?.name)})));
    setPromoStaff(prev=>prev.filter(s=>s.id!==id));
    setRemoveConfirm(null);
    showToast("Removed "+member?.name+" from roster");
  }

  function saveStaffEdit() {
    if (!editingStaff) return;
    const name = editingStaff.name.trim();
    if (!name) { showToast("Name cannot be empty","#ff4444"); return; }
    const oldMember = promoStaff.find(s=>s.id===editingStaff.id);
    // If name changed, update event assignments to new name
    if (oldMember && oldMember.name !== name) {
      setEvents(prev=>prev.map(e=>({...e, staffAssigned:(e.staffAssigned||[]).map(n=>n===oldMember.name?name:n)})));
    }
    setPromoStaff(prev=>prev.map(s=>s.id===editingStaff.id?{...s,...editingStaff,name}:s));
    setEditingStaff(null);
    showToast("✓ Updated "+name);
  }

  function receiveStock() {
    if (!rcvBrand) { showToast("Select a brand","#ff4444"); return; }
    if (rcvQty < 1) { showToast("Enter a valid quantity","#ff4444"); return; }
    const key = rcvItem+"||"+rcvBrand;
    setInventory(prev=>({...prev,[key]:(prev[key]||0)+Number(rcvQty)}));
    setHistory(prev=>[{id:genId(),item:rcvItem,brand:rcvBrand,qty:Number(rcvQty),ts:nowStr()},...prev]);
    showToast("✓ Received "+rcvQty+"x "+rcvBrand+" "+rcvItem);
    setRcvQty(1);
  }

  function addItemType() {
    const name = catNewItemName.trim();
    if (!name) { showToast("Enter an item type name","#ff4444"); return; }
    if (itemTypes.includes(name)) { showToast("That item type already exists","#ffaa00"); return; }
    const colorIdx = itemTypes.length % NEW_ITEM_COLOR_POOL.length;
    const color = NEW_ITEM_COLOR_POOL[colorIdx];
    setItemTypes(prev => [...prev, name]);
    setBrandsByItem(prev => ({...prev, [name]: []}));
    setItemColors(prev => ({...prev, [name]: color}));
    setCatSelectedItem(name);
    setCatNewItemName("");
    setCatNewItemIcon("📦");
    showToast("✓ Added item type: "+name);
  }

  function addBrandToItem(itemName, brandName) {
    const b = brandName.trim();
    if (!b) { showToast("Enter a brand name","#ff4444"); return; }
    const existing = brandsByItem[itemName]||[];
    if (existing.includes(b)) { showToast("That brand already exists for "+itemName,"#ffaa00"); return; }
    setBrandsByItem(prev => ({...prev, [itemName]: [...(prev[itemName]||[]), b].sort()}));
    showToast("✓ Added brand: "+b+" → "+itemName);
  }

  function removeItemType(name) {
    setItemTypes(prev => prev.filter(t => t !== name));
    setCatSelectedItem(prev => prev === name ? "" : prev);
    showToast("Removed item type: "+name);
  }

  function removeBrandFromItem(itemName, brand) {
    setBrandsByItem(prev => ({...prev, [itemName]: (prev[itemName]||[]).filter(b => b !== brand)}));
  }

  function submitRequest() {
    if (!reqBrand) { showToast("Select a brand","#ff4444"); return; }
    if (!reqCustomer) { showToast("Select an account","#ff4444"); return; }
    if (reqQty < 1) { showToast("Enter a valid quantity","#ff4444"); return; }
    const key = reqItem+"||"+reqBrand;
    const avail = inventory[key]||0;
    if (avail < reqQty) { showToast("Only "+avail+" available in stock","#ffaa00"); return; }
    setInventory(prev=>({...prev,[key]:(prev[key]||0)-Number(reqQty)}));
    setRequests(prev=>[{id:genId(),rep:repUser,customer:reqCustomer,item:reqItem,brand:reqBrand,qty:Number(reqQty),status:"Pending",ts:nowStr(),fulfilledTs:null},...prev]);
    showToast("✓ Request submitted — "+reqQty+"x "+reqBrand+" "+reqItem);
    setReqQty(1); setReqBrand(""); setReqCustomer(""); setReqSearch("");
  }

  function fulfillRequest(id) {
    setRequests(prev=>prev.map(r=>r.id===id?{...r,status:"Fulfilled",fulfilledTs:nowStr()}:r));
    showToast("✓ Marked as fulfilled");
  }

  function cancelRequest(id) {
    const req = requests.find(r=>r.id===id);
    if (req&&req.status==="Pending") {
      const key = req.item+"||"+req.brand;
      setInventory(prev=>({...prev,[key]:(prev[key]||0)+req.qty}));
    }
    setRequests(prev=>prev.map(r=>r.id===id?{...r,status:"Cancelled"}:r));
    showToast("Request cancelled");
  }

  function submitTransfer() {
    if (!transferTo) { showToast("Select a destination account","#ff4444"); return; }
    if (!transferModal) return;
    const {fromAccount, item, brand, maxQty} = transferModal;
    const qty = Number(transferQty);
    if (qty < 1 || qty > maxQty) { showToast("Invalid quantity","#ff4444"); return; }
    if (transferTo === fromAccount) { showToast("Source and destination must be different","#ff4444"); return; }
    const returningToWarehouse = transferTo === "⬡ MAIN WAREHOUSE";
    // If returning to warehouse, add back to live inventory
    if (returningToWarehouse) {
      const key = item+"||"+brand;
      setInventory(prev=>({...prev,[key]:(prev[key]||0)+qty}));
      setHistory(prev=>[{id:genId(),item,brand,qty,ts:nowStr(),note:"Returned by "+repUser+" from "+fromAccount},...prev]);
    }
    // Apply account overrides: subtract from source account
    setAccountOverrides(prev => {
      const next = {...prev};
      const srcKey = fromAccount;
      if (!next[srcKey]) next[srcKey] = [];
      const srcExisting = next[srcKey].find(o=>o.item===item&&o.brand===brand);
      if (srcExisting) srcExisting.delta -= qty;
      else next[srcKey] = [...next[srcKey], {item, brand, delta: -qty}];
      // Only add to dest account card if NOT returning to warehouse
      if (!returningToWarehouse) {
        const dstKey = transferTo;
        if (!next[dstKey]) next[dstKey] = [];
        const dstExisting = next[dstKey].find(o=>o.item===item&&o.brand===brand);
        if (dstExisting) dstExisting.delta += qty;
        else next[dstKey] = [...next[dstKey], {item, brand, delta: qty}];
      }
      return next;
    });
    setTransfers(prev=>[{id:genId(),rep:repUser,item,brand,qty,fromAccount,toAccount:transferTo,ts:nowStr(),isReturn:returningToWarehouse},...prev]);
    showToast(returningToWarehouse ? "✓ Returned "+qty+"x "+brand+" to warehouse" : "✓ Transferred "+qty+"x "+brand+" → "+transferTo);
    setTransferModal(null);
    setTransferTo(""); setTransferToSearch(""); setTransferQty(1);
  }

  const pendingRequests = requests.filter(r=>r.status==="Pending");
  const myRequests = requests.filter(r=>r.rep===repUser);

  // Account data for this rep (historical + new requests + transfers merged)
  const repHistoricalAccounts = ACCOUNT_ASSETS[repUser] || {};
  const mergedAccounts = {};
  // Deep clone historical
  Object.entries(repHistoricalAccounts).forEach(([acct, assets]) => {
    mergedAccounts[acct] = assets.map(a=>({...a}));
  });
  // Merge in fulfilled/pending requests
  myRequests.filter(r=>r.status!=="Cancelled").forEach(req => {
    if (!mergedAccounts[req.customer]) mergedAccounts[req.customer] = [];
    const existing = mergedAccounts[req.customer].find(a=>a.item===req.item&&a.brand===req.brand);
    if (existing) { existing.count += req.qty; existing.last = req.ts; }
    else mergedAccounts[req.customer] = [...mergedAccounts[req.customer], {item:req.item, brand:req.brand, count:req.qty, last:req.ts}];
  });
  // Apply transfer overrides
  Object.entries(accountOverrides).forEach(([acct, overrides]) => {
    if (!mergedAccounts[acct]) mergedAccounts[acct] = [];
    overrides.forEach(({item, brand, delta}) => {
      const existing = mergedAccounts[acct].find(a=>a.item===item&&a.brand===brand);
      if (existing) {
        existing.count = Math.max(0, existing.count + delta);
      } else if (delta > 0) {
        mergedAccounts[acct] = [...mergedAccounts[acct], {item, brand, count: delta, last: nowStr()}];
      }
    });
  });

  const sortedAccounts = Object.entries(mergedAccounts)
    .filter(([name]) => !acctSearch || name.toLowerCase().includes(acctSearch.toLowerCase()))
    .sort((a,b) => b[1].length - a[1].length);

  const invRows = Object.entries(inventory)
    .map(([key,qty])=>{const [item,brand]=key.split("||");return{item,brand,qty,key};})
    .filter(r=>r.qty>0||invFilter||invItemFilter!=="All")
    .filter(r=>invItemFilter==="All"||r.item===invItemFilter)
    .filter(r=>!invFilter||r.brand.toLowerCase().includes(invFilter.toLowerCase())||r.item.toLowerCase().includes(invFilter.toLowerCase()))
    .sort((a,b)=>b.qty-a.qty);

  const C = {
    bg:"#0a0a0a", surface:"#141414", surface2:"#181818", border:"#222", border2:"#1a1a1a",
    accent:"#e8a020", textPrimary:"#f0ece4", textSec:"#777", textMuted:"#3a3a3a",
    green:"#44cc88", red:"#ff4d4d", orange:"#ffaa00"
  };

  const s = {
    root:{fontFamily:"'DM Mono',monospace",background:C.bg,color:C.textPrimary,minHeight:"100vh",display:"flex",flexDirection:"column"},
    header:{background:C.surface,borderBottom:"2px solid "+C.accent,padding:"0 20px",display:"flex",alignItems:"center",justifyContent:"space-between",height:54,position:"sticky",top:0,zIndex:100,flexShrink:0},
    logo:{fontSize:16,fontWeight:700,letterSpacing:3,color:C.accent,textTransform:"uppercase"},
    main:{flex:1,padding:20,maxWidth:960,margin:"0 auto",width:"100%",boxSizing:"border-box"},
    card:{background:C.surface,border:"1px solid "+C.border,borderRadius:8,padding:20,marginBottom:16},
    cardAccent:(color)=>({background:C.surface,border:"1px solid "+C.border,borderLeft:"3px solid "+color,borderRadius:8,padding:16,marginBottom:12}),
    h2:{fontSize:12,fontWeight:700,letterSpacing:2,color:C.accent,textTransform:"uppercase",marginBottom:16,marginTop:0},
    label:{fontSize:10,letterSpacing:2,color:C.textSec,textTransform:"uppercase",display:"block",marginBottom:6},
    input:{background:"#0e0e0e",border:"1px solid "+C.border,borderRadius:4,color:C.textPrimary,padding:"8px 12px",fontFamily:"inherit",fontSize:13,width:"100%",boxSizing:"border-box",outline:"none"},
    select:{background:"#0e0e0e",border:"1px solid "+C.border,borderRadius:4,color:C.textPrimary,padding:"8px 12px",fontFamily:"inherit",fontSize:13,width:"100%",boxSizing:"border-box",outline:"none"},
    btn:(v="primary",small=false)=>({
      background:v==="primary"?C.accent:v==="success"?C.green:v==="danger"?"#2a1010":"#1a1a1a",
      color:v==="primary"?"#111":v==="success"?"#111":v==="danger"?C.red:C.textPrimary,
      border:v==="danger"?"1px solid "+C.red+"33":v==="ghost"?"1px solid "+C.border:"none",
      borderRadius:4,padding:small?"5px 12px":"9px 18px",
      cursor:"pointer",fontFamily:"inherit",fontSize:small?11:12,fontWeight:600,
      letterSpacing:1,textTransform:"uppercase",transition:"opacity 0.15s",whiteSpace:"nowrap"
    }),
    tag:(color)=>({display:"inline-block",background:color+"22",color,border:"1px solid "+color+"44",borderRadius:3,padding:"2px 8px",fontSize:10,letterSpacing:1,fontWeight:700}),
    pill:(active,color=C.accent)=>({
      background:active?color+"22":"transparent",border:"1px solid "+(active?color:C.border),
      color:active?color:C.textSec,borderRadius:20,padding:"5px 14px",cursor:"pointer",
      fontFamily:"inherit",fontSize:11,letterSpacing:1,textTransform:"uppercase",fontWeight:600
    }),
    field:{marginBottom:14},
  };

  const navBtn = (id, label, active) => (
    <button key={id} onClick={()=>setView(id)} style={{
      background:active?C.accent+"22":"transparent",
      color:active?C.accent:C.textSec,
      border:"1px solid "+(active?C.accent+"44":"transparent"),
      borderRadius:4,padding:"5px 12px",cursor:"pointer",
      fontFamily:"inherit",fontSize:11,letterSpacing:1,textTransform:"uppercase",fontWeight:600
    }}>{label}</button>
  );

  // ── LOGIN ──────────────────────────────────────────────────────────────────
  if (!role) return (
    <div style={{...s.root,alignItems:"center",justifyContent:"center"}}>
      <style>{`@import url('https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500;700&display=swap');*{box-sizing:border-box}::-webkit-scrollbar{width:5px;background:#111}::-webkit-scrollbar-thumb{background:#2a2a2a;border-radius:3px}@keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}button:hover{opacity:0.82}.rh:hover{background:#1e1e1e!important}.acct-card:hover{border-color:#333!important}`}</style>
      <div style={{animation:"fadeUp 0.3s ease",textAlign:"center",maxWidth:440,width:"100%",padding:24}}>
        <div style={{fontSize:32,marginBottom:4}}>⬡</div>
        <div style={{fontSize:22,fontWeight:700,letterSpacing:4,color:C.accent,marginBottom:4}}>BREWASSET</div>
        <div style={{fontSize:11,color:C.textSec,letterSpacing:3,marginBottom:44}}>POS ROOM INVENTORY SYSTEM</div>
        <div style={{display:"flex",flexDirection:"column",gap:12}}>
          <button style={{...s.btn(),padding:"18px",fontSize:14,letterSpacing:2,borderRadius:8}} onClick={()=>{setRole("warehouse");setView("inventory");}}>
            🏭  WAREHOUSE STAFF
          </button>
          <div style={{fontSize:11,color:C.textMuted,letterSpacing:1}}>— or log in as rep —</div>
          <select style={{...s.select,padding:"12px",fontSize:13}} value={repUser} onChange={e=>setRepUser(e.target.value)}>
            <option value="">Select your name...</option>
            {ALL_REPS.map(r=><option key={r} value={r}>{r}</option>)}
          </select>
          <button style={{...s.btn("ghost"),padding:"14px",fontSize:13,letterSpacing:2,borderRadius:8,opacity:repUser?1:0.35}}
            onClick={()=>{if(repUser){setRole("rep");setView("repRequest");}}}>
            👤  REP LOGIN
          </button>
          <div style={{height:1,background:C.border,margin:"4px 0"}}/>
          <button style={{...s.btn("ghost"),padding:"14px",fontSize:13,letterSpacing:2,borderRadius:8,background:"#0a0e1a",border:"1px solid #2a3a6a",color:"#7090e8"}}
            onClick={()=>{setRole("marketing");setView("mktCalendar");}}>
            📅  EVENTS &amp; PROMOS  <span style={{fontSize:10,color:"#4a6ab8",marginLeft:4}}>MARKETING MGR</span>
          </button>
        </div>
      </div>
    </div>
  );

  const warehouseNav = [
    {id:"inventory",label:"Inventory"},
    {id:"receive",label:"Receive Stock"},
    {id:"requests",label:"Requests"+(pendingRequests.length?" ("+pendingRequests.length+")":"")},
    {id:"history",label:"History"},
    {id:"catalog",label:"Manage Catalog"},
  ];
  const repNav = [
    {id:"repRequest",label:"Request Items"},
    {id:"repView",label:"My Requests"+(myRequests.filter(r=>r.status==="Pending").length?" ("+myRequests.filter(r=>r.status==="Pending").length+")":"")},
    {id:"accounts",label:"My Accounts"},
    {id:"transfers",label:"Transfers"+(transfers.filter(t=>t.rep===repUser).length?" ("+transfers.filter(t=>t.rep===repUser).length+")":"")},
    {id:"events",label:"Events"+(repEvents.length?" ("+repEvents.length+")":"")},
  ];
  const marketingNav = [
    {id:"mktCalendar",label:"📅 Calendar"},
    {id:"mktEvents",label:"All Events"+(events.filter(e=>e.status==="pending").length?" ("+events.filter(e=>e.status==="pending").length+" pending)":"")},
    {id:"mktStaff",label:"Staff"},
  ];
  const nav = role==="warehouse"?warehouseNav:role==="marketing"?marketingNav:repNav;

  return (
    <div style={s.root}>
      <style>{`@import url('https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500;700&display=swap');*{box-sizing:border-box}::-webkit-scrollbar{width:5px;background:#111}::-webkit-scrollbar-thumb{background:#2a2a2a;border-radius:3px}@keyframes fadeUp{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}button:hover{opacity:0.82}.rh:hover{background:#1c1c1c!important}.acct-card:hover{border-color:#333!important;transform:translateY(-1px)}.asset-row:hover{background:#1a1a1a!important}`}</style>

      {toast&&(
        <div style={{position:"fixed",bottom:24,left:"50%",transform:"translateX(-50%)",zIndex:9999,background:"#1a1a1a",border:"1px solid "+toast.color,borderLeft:"3px solid "+toast.color,borderRadius:6,padding:"12px 24px",color:toast.color,fontSize:13,fontFamily:"inherit",letterSpacing:0.5,whiteSpace:"nowrap",boxShadow:"0 8px 32px rgba(0,0,0,0.6)",animation:"fadeUp 0.2s ease"}}>
          {toast.msg}
        </div>
      )}

      {/* Header */}
      <div style={s.header}>
        <div style={{display:"flex",alignItems:"center",gap:16}}>
          <div style={s.logo}>⬡ BrewAsset</div>
          <nav style={{display:"flex",gap:4}}>
            {nav.map(n=>navBtn(n.id,n.label,view===n.id))}
          </nav>
        </div>
        <div style={{display:"flex",alignItems:"center",gap:10}}>
          <span style={{fontSize:11,color:C.textSec}}>{role==="warehouse"?"🏭 Warehouse":role==="marketing"?"📅 Marketing Mgr":"👤 "+repUser}</span>
          <button onClick={()=>{setRole(null);setRepUser("");setView("home");}} style={s.btn("ghost",true)}>Sign Out</button>
        </div>
      </div>

      <div style={s.main}>

        {/* ════ WAREHOUSE: INVENTORY ════ */}
        {view==="inventory"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:20}}>
              <div>
                <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>INVENTORY</div>
                <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>{invRows.filter(r=>r.qty>0).length} SKUs IN STOCK</div>
              </div>
              <button style={s.btn()} onClick={()=>setView("receive")}>+ Receive Stock</button>
            </div>
            <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(120px,1fr))",gap:10,marginBottom:20}}>
              {itemTypes.map(item=>{
                const total=Object.entries(inventory).filter(([k])=>k.startsWith(item+"||")).reduce((s,[,v])=>s+v,0);
                const color=itemColors[item]||"#888";
                return(
                  <div key={item} onClick={()=>setInvItemFilter(invItemFilter===item?"All":item)}
                    style={{background:invItemFilter===item?color+"18":C.surface,border:"1px solid "+(invItemFilter===item?color:C.border),borderRadius:6,padding:"12px 14px",cursor:"pointer",transition:"all 0.15s"}}>
                    <div style={{fontSize:18,marginBottom:4}}>{ITEM_ICONS[item]}</div>
                    <div style={{fontSize:10,color:C.textSec,marginBottom:4,lineHeight:1.3}}>{item}</div>
                    <div style={{fontSize:22,fontWeight:700,color}}>{total}</div>
                  </div>
                );
              })}
            </div>
            <div style={{marginBottom:14}}>
              <input style={s.input} placeholder="Search brand or item type..." value={invFilter} onChange={e=>setInvFilter(e.target.value)}/>
            </div>
            <div style={{...s.card,padding:0,overflow:"hidden"}}>
              <table style={{width:"100%",borderCollapse:"collapse"}}>
                <thead>
                  <tr style={{borderBottom:"1px solid "+C.border}}>
                    {["Item Type","Brand","In Stock","Pending Requests"].map(h=>(
                      <th key={h} style={{textAlign:"left",fontSize:10,letterSpacing:2,color:C.textSec,textTransform:"uppercase",padding:"10px 14px"}}>{h}</th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {invRows.length===0?(
                    <tr><td colSpan={4} style={{padding:40,textAlign:"center",color:C.textMuted,fontSize:13}}>No stock received yet. Use Receive Stock to begin.</td></tr>
                  ):invRows.map(row=>{
                    const color=itemColors[row.item]||"#888";
                    const pending=pendingRequests.filter(r=>r.item===row.item&&r.brand===row.brand).reduce((s,r)=>s+r.qty,0);
                    return(
                      <tr key={row.key} className="rh" style={{borderBottom:"1px solid "+C.border2}}>
                        <td style={{padding:"10px 14px"}}><span style={{marginRight:6}}>{ITEM_ICONS[row.item]}</span><span style={s.tag(color)}>{row.item}</span></td>
                        <td style={{padding:"10px 14px",fontSize:13,fontWeight:600}}>{row.brand}</td>
                        <td style={{padding:"10px 14px",fontSize:18,fontWeight:700,color:row.qty===0?C.textMuted:row.qty<5?C.red:row.qty<15?C.orange:C.green}}>{row.qty}</td>
                        <td style={{padding:"10px 14px",fontSize:13,color:pending>0?C.orange:C.textMuted}}>{pending>0?pending+" pending":"—"}</td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ════ WAREHOUSE: RECEIVE STOCK ════ */}
        {view==="receive"&&(
          <div style={{animation:"fadeUp 0.2s ease",maxWidth:520}}>
            <div style={{marginBottom:24}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>RECEIVE STOCK</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>LOG INCOMING INVENTORY</div>
            </div>
            <div style={s.card}>
              <div style={s.field}>
                <label style={s.label}>Item Type</label>
                <select style={s.select} value={rcvItem} onChange={e=>{setRcvItem(e.target.value);setRcvBrand("");}}>
                  {itemTypes.map(t=><option key={t} value={t}>{ITEM_ICONS[t]||"📦"} {t}</option>)}
                </select>
              </div>
              <div style={s.field}>
                <label style={s.label}>Brand</label>
                <select style={s.select} value={rcvBrand} onChange={e=>setRcvBrand(e.target.value)}>
                  <option value="">Select brand...</option>
                  {(brandsByItem[rcvItem]||[]).map(b=><option key={b} value={b}>{b}</option>)}
                </select>
              </div>
              <div style={s.field}>
                <label style={s.label}>Quantity Received</label>
                <input type="number" min={1} style={s.input} value={rcvQty} onChange={e=>setRcvQty(e.target.value)}/>
              </div>
              {rcvBrand&&(
                <div style={{background:"#0e0e0e",border:"1px solid "+C.border,borderRadius:6,padding:12,marginBottom:16,fontSize:12,color:C.textSec}}>
                  Stock: <span style={{color:C.textPrimary,fontWeight:700}}>{inventory[rcvItem+"||"+rcvBrand]||0}</span>
                  {" → "}<span style={{color:C.accent,fontWeight:700}}>{(inventory[rcvItem+"||"+rcvBrand]||0)+Number(rcvQty||0)}</span>
                </div>
              )}
              <button style={{...s.btn(),width:"100%",padding:"12px"}} onClick={receiveStock}>✓ RECEIVE INTO STOCK</button>
            </div>
            {history.length>0&&(
              <div style={s.card}>
                <div style={s.h2}>Recently Received</div>
                {history.slice(0,8).map(h=>(
                  <div key={h.id} className="rh" style={{display:"flex",justifyContent:"space-between",alignItems:"center",padding:"8px 0",borderBottom:"1px solid "+C.border2}}>
                    <div><span style={{marginRight:6}}>{ITEM_ICONS[h.item]}</span><span style={{fontSize:13,fontWeight:600}}>{h.brand}</span><span style={{fontSize:11,color:C.textSec,marginLeft:6}}>{h.item}</span></div>
                    <div style={{textAlign:"right"}}>
                      <div style={{fontSize:16,fontWeight:700,color:C.green}}>+{h.qty}</div>
                      <div style={{fontSize:10,color:C.textMuted}}>{h.ts}</div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* ════ WAREHOUSE: REQUESTS ════ */}
        {view==="requests"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{marginBottom:20}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>REP REQUESTS</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>{pendingRequests.length} PENDING · LOAD ON NEXT DELIVERY TRUCK</div>
            </div>
            {pendingRequests.length>0&&(
              <div style={s.card}>
                <div style={s.h2}>⏳ Pending ({pendingRequests.length})</div>
                {pendingRequests.map(req=>(
                  <div key={req.id} style={{...s.cardAccent(C.orange),display:"flex",justifyContent:"space-between",alignItems:"center",flexWrap:"wrap",gap:10}}>
                    <div style={{flex:1}}>
                      <div style={{display:"flex",alignItems:"center",gap:8,marginBottom:4,flexWrap:"wrap"}}>
                        <span>{ITEM_ICONS[req.item]}</span>
                        <span style={{fontWeight:700,fontSize:14}}>{req.qty}x {req.brand}</span>
                        <span style={s.tag(itemColors[req.item]||"#888")}>{req.item}</span>
                      </div>
                      <div style={{fontSize:12,color:C.textSec}}>
                        <span style={{color:C.accent,fontWeight:600}}>{req.rep}</span>{" → "}
                        <span style={{fontWeight:600}}>{req.customer}</span>
                      </div>
                      <div style={{fontSize:10,color:C.textMuted,marginTop:2}}>{req.ts}</div>
                    </div>
                    <div style={{display:"flex",gap:8}}>
                      <button style={s.btn("success",true)} onClick={()=>fulfillRequest(req.id)}>✓ Loaded</button>
                      <button style={s.btn("danger",true)} onClick={()=>cancelRequest(req.id)}>✕</button>
                    </div>
                  </div>
                ))}
              </div>
            )}
            {pendingRequests.length===0&&(
              <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>No pending requests</div>
            )}
            {requests.filter(r=>r.status!=="Pending").length>0&&(
              <div style={s.card}>
                <div style={s.h2}>Recent History</div>
                {requests.filter(r=>r.status!=="Pending").slice(0,20).map(req=>(
                  <div key={req.id} className="rh" style={{display:"flex",justifyContent:"space-between",alignItems:"center",padding:"8px 0",borderBottom:"1px solid "+C.border2,flexWrap:"wrap",gap:6}}>
                    <div>
                      <span style={{marginRight:6}}>{ITEM_ICONS[req.item]}</span>
                      <span style={{fontSize:13,fontWeight:600}}>{req.qty}x {req.brand}</span>
                      <span style={{fontSize:11,color:C.textSec,marginLeft:6}}>{req.item}</span>
                      <span style={{fontSize:11,color:C.textSec}}> · {req.rep} → {req.customer}</span>
                    </div>
                    <span style={s.tag(req.status==="Fulfilled"?C.green:C.red)}>{req.status}</span>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* ════ WAREHOUSE: HISTORY ════ */}
        {view==="history"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{marginBottom:20}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>RECEIVE HISTORY</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>{history.length} TRANSACTIONS</div>
            </div>
            <div style={{...s.card,padding:0,overflow:"hidden"}}>
              {history.length===0?(
                <div style={{padding:40,textAlign:"center",color:C.textMuted,fontSize:13}}>No stock received yet</div>
              ):(
                <table style={{width:"100%",borderCollapse:"collapse"}}>
                  <thead>
                    <tr style={{borderBottom:"1px solid "+C.border}}>
                      {["Time","Item Type","Brand","Qty Received"].map(h=>(
                        <th key={h} style={{textAlign:"left",fontSize:10,letterSpacing:2,color:C.textSec,textTransform:"uppercase",padding:"10px 14px"}}>{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {history.map(h=>(
                      <tr key={h.id} className="rh" style={{borderBottom:"1px solid "+C.border2}}>
                        <td style={{padding:"9px 14px",fontSize:11,color:C.textMuted}}>{h.ts}</td>
                        <td style={{padding:"9px 14px"}}><span style={s.tag(itemColors[h.item]||"#888")}>{h.item}</span></td>
                        <td style={{padding:"9px 14px",fontSize:13,fontWeight:600}}>{h.brand}</td>
                        <td style={{padding:"9px 14px",fontSize:16,fontWeight:700,color:C.green}}>+{h.qty}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        )}


        {/* ════ WAREHOUSE: MANAGE CATALOG ════ */}
        {view==="catalog"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{marginBottom:24}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>MANAGE CATALOG</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>
                {itemTypes.length} ITEM TYPES · {Object.values(brandsByItem).reduce((s,b)=>s+b.length,0)} BRANDS TOTAL
              </div>
            </div>

            <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:20}}>

              {/* ── LEFT: Item Types Panel ── */}
              <div>
                {/* Add new item type */}
                <div style={{...s.card,borderTop:"3px solid "+C.accent,marginBottom:16}}>
                  <div style={s.h2}>+ NEW ITEM TYPE</div>
                  <div style={s.field}>
                    <label style={s.label}>Item Type Name</label>
                    <input style={s.input} placeholder="e.g. Growler, Koozie, Branded Hat..."
                      value={catNewItemName} onChange={e=>setCatNewItemName(e.target.value)}
                      onKeyDown={e=>{if(e.key==="Enter")addItemType();}}/>
                  </div>
                  <div style={{...s.field,marginBottom:0}}>
                    <label style={s.label}>Icon (emoji)</label>
                    <div style={{display:"flex",gap:8,alignItems:"center"}}>
                      <input style={{...s.input,width:80,textAlign:"center",fontSize:22}}
                        value={catNewItemIcon} onChange={e=>setCatNewItemIcon(e.target.value)}/>
                      <div style={{display:"flex",gap:6,flexWrap:"wrap",flex:1}}>
                        {["🍺","🥤","🎽","👒","🏷️","📋","🪧","💡","🪞","☂️","🎁","📦","🥂","🧊","🎯"].map(em=>(
                          <button key={em} onClick={()=>setCatNewItemIcon(em)}
                            style={{background:catNewItemIcon===em?C.accent+"33":"#111",border:"1px solid "+(catNewItemIcon===em?C.accent:C.border),borderRadius:4,padding:"4px 7px",cursor:"pointer",fontSize:16}}>
                            {em}
                          </button>
                        ))}
                      </div>
                    </div>
                  </div>
                  <button style={{...s.btn(),width:"100%",marginTop:14,padding:10}}
                    onClick={addItemType}>
                    + ADD ITEM TYPE
                  </button>
                </div>

                {/* Existing item types list */}
                <div style={s.card}>
                  <div style={s.h2}>ALL ITEM TYPES</div>
                  <input style={{...s.input,marginBottom:12}} placeholder="Filter types..."
                    value={catItemSearch} onChange={e=>setCatItemSearch(e.target.value)}/>
                  <div style={{display:"flex",flexDirection:"column",gap:6}}>
                    {itemTypes
                      .filter(t=>!catItemSearch||t.toLowerCase().includes(catItemSearch.toLowerCase()))
                      .map(t=>{
                        const brandCount = (brandsByItem[t]||[]).length;
                        const isSelected = catSelectedItem===t;
                        const color = itemColors[t]||"#888";
                        const isCustom = !ITEM_TYPES.includes(t);
                        return (
                          <div key={t}
                            onClick={()=>setCatSelectedItem(isSelected?"":t)}
                            style={{display:"flex",alignItems:"center",gap:10,padding:"10px 12px",
                              background:isSelected?color+"18":"#111",
                              border:"1px solid "+(isSelected?color:C.border),
                              borderRadius:6,cursor:"pointer",transition:"all 0.12s"}}>
                            <span style={{fontSize:18,flexShrink:0}}>{ITEM_ICONS[t]||catNewItemIcon||"📦"}</span>
                            <div style={{flex:1,minWidth:0}}>
                              <div style={{fontSize:13,fontWeight:600,color:isSelected?color:C.textPrimary}}>{t}</div>
                              <div style={{fontSize:10,color:C.textSec}}>{brandCount} brand{brandCount!==1?"s":""}</div>
                            </div>
                            {isCustom&&<span style={{...s.tag("#9070d0"),fontSize:9}}>CUSTOM</span>}
                            <div style={{display:"flex",gap:6,alignItems:"center"}}>
                              <div style={{width:10,height:10,borderRadius:"50%",background:color,flexShrink:0}}/>
                              {isCustom&&(
                                <button onClick={e=>{e.stopPropagation();removeItemType(t);}}
                                  style={{background:"transparent",border:"none",color:C.red,cursor:"pointer",fontSize:14,padding:"0 2px",lineHeight:1}}>✕</button>
                              )}
                            </div>
                          </div>
                        );
                      })}
                  </div>
                </div>
              </div>

              {/* ── RIGHT: Brands Panel ── */}
              <div>
                {catSelectedItem ? (
                  <>
                    {/* Add new brand */}
                    <div style={{...s.card,borderTop:"3px solid "+(itemColors[catSelectedItem]||C.accent),marginBottom:16}}>
                      <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:14}}>
                        <span style={{fontSize:22}}>{ITEM_ICONS[catSelectedItem]||"📦"}</span>
                        <div>
                          <div style={{fontSize:13,fontWeight:700,color:itemColors[catSelectedItem]||C.accent}}>{catSelectedItem}</div>
                          <div style={{fontSize:10,color:C.textSec}}>{(brandsByItem[catSelectedItem]||[]).length} brands</div>
                        </div>
                      </div>
                      <div style={s.h2}>+ ADD BRAND</div>
                      <div style={{display:"flex",gap:8}}>
                        <input style={{...s.input,flex:1}} placeholder="e.g. Bud Light, Fiddlehead - IPA..."
                          value={catNewBrand} onChange={e=>setCatNewBrand(e.target.value)}
                          onKeyDown={e=>{if(e.key==="Enter"&&catNewBrand.trim()){addBrandToItem(catSelectedItem,catNewBrand);setCatNewBrand("");}}}/>
                        <button style={{...s.btn(),padding:"8px 16px",whiteSpace:"nowrap"}}
                          onClick={()=>{addBrandToItem(catSelectedItem,catNewBrand);setCatNewBrand("");}}>
                          + Add
                        </button>
                      </div>
                    </div>

                    {/* Brand list for selected item */}
                    <div style={s.card}>
                      <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:12}}>
                        <div style={{...s.h2,marginBottom:0}}>BRANDS FOR {catSelectedItem.toUpperCase()}</div>
                      </div>
                      <input style={{...s.input,marginBottom:10}} placeholder="Search brands..."
                        value={catBrandSearch} onChange={e=>setCatBrandSearch(e.target.value)}/>
                      <div style={{maxHeight:420,overflowY:"auto"}}>
                        {(brandsByItem[catSelectedItem]||[])
                          .filter(b=>!catBrandSearch||b.toLowerCase().includes(catBrandSearch.toLowerCase()))
                          .map((b,i)=>{
                            const stockQty = inventory[catSelectedItem+"||"+b]||0;
                            const isCustom = !(BRANDS_BY_ITEM[catSelectedItem]||[]).includes(b);
                            return (
                              <div key={b} className="rh" style={{display:"flex",alignItems:"center",gap:10,
                                padding:"8px 10px",borderBottom:"1px solid "+C.border2,
                                background:i%2===0?"transparent":"#0e0e0e"}}>
                                <div style={{flex:1,minWidth:0}}>
                                  <div style={{fontSize:12,fontWeight:600,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{b}</div>
                                  {isCustom&&<span style={{...s.tag("#9070d0"),fontSize:9,marginTop:2,display:"inline-block"}}>NEW</span>}
                                </div>
                                <div style={{fontSize:12,color:stockQty>0?C.green:C.textMuted,fontWeight:stockQty>0?700:400,flexShrink:0}}>
                                  {stockQty>0?stockQty+" in stock":"no stock"}
                                </div>
                                <button onClick={()=>removeBrandFromItem(catSelectedItem,b)}
                                  style={{background:"transparent",border:"none",color:C.red+"99",cursor:"pointer",
                                    fontSize:14,padding:"0 4px",lineHeight:1,flexShrink:0,opacity:stockQty>0?0.4:1}}
                                  title={stockQty>0?"Cannot remove — item has stock":"Remove brand"}>
                                  ✕
                                </button>
                              </div>
                            );
                          })}
                        {(brandsByItem[catSelectedItem]||[]).filter(b=>!catBrandSearch||b.toLowerCase().includes(catBrandSearch.toLowerCase())).length===0&&(
                          <div style={{padding:"20px",textAlign:"center",color:C.textMuted,fontSize:12}}>
                            {catBrandSearch?"No brands match your search":"No brands yet — add the first one above"}
                          </div>
                        )}
                      </div>
                    </div>
                  </>
                ) : (
                  <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60,borderStyle:"dashed"}}>
                    <div style={{fontSize:32,marginBottom:12}}>←</div>
                    <div style={{fontSize:13,letterSpacing:1}}>SELECT AN ITEM TYPE</div>
                    <div style={{fontSize:11,marginTop:6}}>Click any item type on the left to manage its brands</div>
                  </div>
                )}
              </div>

            </div>
          </div>
        )}

        {/* ════ REP: REQUEST ITEMS ════ */}
        {view==="repRequest"&&(
          <div style={{animation:"fadeUp 0.2s ease",maxWidth:560}}>
            <div style={{marginBottom:24}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>REQUEST ITEMS</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>FOR NEXT DELIVERY TRUCK</div>
            </div>
            <div style={s.card}>
              <div style={s.field}>
                <label style={s.label}>Item Type</label>
                <div style={{display:"flex",flexWrap:"wrap",gap:6}}>
                  {itemTypes.map(t=>{
                    const avail=Object.entries(inventory).filter(([k,v])=>k.startsWith(t+"||")&&v>0).length;
                    return(
                      <button key={t} style={{...s.pill(reqItem===t,itemColors[t]||"#888"),opacity:avail===0?0.3:1}}
                        onClick={()=>{setReqItem(t);setReqBrand("");}}>
                        {ITEM_ICONS[t]} {t}
                      </button>
                    );
                  })}
                </div>
              </div>
              <div style={s.field}>
                <label style={s.label}>Brand</label>
                <select style={s.select} value={reqBrand} onChange={e=>setReqBrand(e.target.value)}>
                  <option value="">Select brand...</option>
                  {(brandsByItem[reqItem]||[]).map(b=>{
                    const qty=inventory[reqItem+"||"+b]||0;
                    return <option key={b} value={b} disabled={qty===0}>{b}{qty===0?" (out of stock)":" ("+qty+" available)"}</option>;
                  })}
                </select>
              </div>
              <div style={s.field}>
                <label style={s.label}>Quantity</label>
                <div style={{display:"flex",gap:8,flexWrap:"wrap"}}>
                  {[1,2,3,5,10].map(q=>{
                    const avail=reqBrand?(inventory[reqItem+"||"+reqBrand]||0):999;
                    return(
                      <button key={q} style={{...s.btn(reqQty===q?"primary":"ghost"),padding:"8px 16px",opacity:q>avail?0.3:1}}
                        onClick={()=>setReqQty(q)} disabled={q>avail}>{q}</button>
                    );
                  })}
                  <input type="number" min={1} max={reqBrand?(inventory[reqItem+"||"+reqBrand]||999):999}
                    style={{...s.input,width:80}} value={reqQty} onChange={e=>setReqQty(Math.max(1,parseInt(e.target.value)||1))}/>
                </div>
              </div>
              <div style={s.field}>
                <label style={s.label}>Account / Customer</label>
                <input style={{...s.input,marginBottom:6}} placeholder="Search your accounts..." value={reqSearch}
                  onChange={e=>{setReqSearch(e.target.value);setReqCustomer("");}}/>
                <div style={{maxHeight:180,overflowY:"auto",background:"#0a0a0a",border:"1px solid "+C.border,borderRadius:4}}>
                  {(CUSTOMERS_BY_REP[repUser]||[]).filter(c=>!reqSearch||c.toLowerCase().includes(reqSearch.toLowerCase())).slice(0,50).map(c=>(
                    <div key={c} onClick={()=>{setReqCustomer(c);setReqSearch(c);}}
                      style={{padding:"8px 12px",fontSize:12,cursor:"pointer",background:reqCustomer===c?C.accent+"22":"transparent",color:reqCustomer===c?C.accent:C.textPrimary,borderBottom:"1px solid #111"}}
                      className="rh">
                      {c}
                    </div>
                  ))}
                </div>
              </div>
              {reqBrand&&(
                <div style={{background:"#0e0e0e",border:"1px solid "+C.border,borderRadius:6,padding:12,marginBottom:16,fontSize:12}}>
                  <span style={{color:C.textSec}}>Available: </span>
                  <span style={{fontWeight:700,color:(inventory[reqItem+"||"+reqBrand]||0)===0?C.red:C.green}}>
                    {inventory[reqItem+"||"+reqBrand]||0}
                  </span>
                </div>
              )}
              <button style={{...s.btn(),width:"100%",padding:14}} onClick={submitRequest}>SUBMIT REQUEST FOR NEXT TRUCK</button>
            </div>
          </div>
        )}

        {/* ════ REP: MY REQUESTS ════ */}
        {view==="repView"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{marginBottom:20}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>MY REQUESTS</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>{repUser.toUpperCase()} · {myRequests.length} TOTAL</div>
            </div>
            {myRequests.length===0?(
              <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>No requests yet. Submit a request to get items on the next truck.</div>
            ):myRequests.map(req=>{
              const statusColor=req.status==="Fulfilled"?C.green:req.status==="Cancelled"?C.red:C.orange;
              return(
                <div key={req.id} style={s.cardAccent(statusColor)}>
                  <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",flexWrap:"wrap",gap:8}}>
                    <div style={{flex:1}}>
                      <div style={{display:"flex",alignItems:"center",gap:8,marginBottom:4,flexWrap:"wrap"}}>
                        <span>{ITEM_ICONS[req.item]}</span>
                        <span style={{fontWeight:700,fontSize:15}}>{req.qty}x {req.brand}</span>
                        <span style={s.tag(itemColors[req.item]||"#888")}>{req.item}</span>
                        <span style={s.tag(statusColor)}>{req.status}</span>
                      </div>
                      <div style={{fontSize:12,color:C.textSec}}>For: <span style={{color:C.textPrimary,fontWeight:600}}>{req.customer}</span></div>
                      <div style={{fontSize:10,color:C.textMuted,marginTop:3}}>
                        Requested: {req.ts}{req.fulfilledTs?" · Fulfilled: "+req.fulfilledTs:""}
                      </div>
                    </div>
                    {req.status==="Pending"&&(
                      <button style={s.btn("danger",true)} onClick={()=>cancelRequest(req.id)}>Cancel</button>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {/* ════ REP: MY ACCOUNTS ════ */}
        {view==="accounts"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-end",marginBottom:20,flexWrap:"wrap",gap:12}}>
              <div>
                <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>MY ACCOUNTS</div>
                <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>
                  {repUser.toUpperCase()} · {sortedAccounts.length} ACCOUNTS · LAST 6 MONTHS
                </div>
              </div>
              <input style={{...s.input,width:240}} placeholder="Search accounts..." value={acctSearch} onChange={e=>setAcctSearch(e.target.value)}/>
            </div>

            {/* Item type filter pills */}
            <div style={{display:"flex",flexWrap:"wrap",gap:6,marginBottom:20}}>
              <button style={s.pill(acctItemFilter==="All")} onClick={()=>setAcctItemFilter("All")}>All Items</button>
              {itemTypes.map(t=>(
                <button key={t} style={{...s.pill(acctItemFilter===t,itemColors[t]||"#888")}} onClick={()=>setAcctItemFilter(acctItemFilter===t?"All":t)}>
                  {ITEM_ICONS[t]} {t}
                </button>
              ))}
            </div>

            {sortedAccounts.length===0&&(
              <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>
                {acctSearch?"No accounts match your search.":"No account history found for the last 6 months."}
              </div>
            )}

            <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(320px,1fr))",gap:14}}>
              {sortedAccounts.map(([accountName, assets])=>{
                const filtered = acctItemFilter==="All" ? assets : assets.filter(a=>a.item===acctItemFilter);
                if (filtered.length===0) return null;
                const isExpanded = acctExpanded===accountName;
                const displayAssets = isExpanded ? filtered : filtered.slice(0,4);
                const totalItems = filtered.reduce((s,a)=>s+a.count,0);
                const uniqueTypes = [...new Set(filtered.map(a=>a.item))];
                const lastDate = filtered.reduce((best,a)=>{
                  // pick the "latest" date string by just returning last in array (already sorted by count)
                  return a.last || best;
                }, "");

                return(
                  <div key={accountName} className="acct-card" style={{background:C.surface,border:"1px solid "+C.border,borderRadius:10,overflow:"hidden",transition:"all 0.15s",cursor:"default"}}>
                    {/* Card header */}
                    <div style={{background:C.surface2,borderBottom:"1px solid "+C.border,padding:"14px 16px"}}>
                      <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",gap:8}}>
                        <div style={{flex:1,minWidth:0}}>
                          <div style={{fontSize:13,fontWeight:700,lineHeight:1.3,marginBottom:6,color:C.textPrimary}}>{accountName}</div>
                          <div style={{display:"flex",flexWrap:"wrap",gap:4}}>
                            {uniqueTypes.map(t=>(
                              <span key={t} style={{...s.tag(itemColors[t]||"#888"),fontSize:9}}>{ITEM_ICONS[t]} {t}</span>
                            ))}
                          </div>
                        </div>
                        <div style={{textAlign:"right",flexShrink:0}}>
                          <div style={{fontSize:22,fontWeight:700,color:C.accent,lineHeight:1}}>{totalItems}</div>
                          <div style={{fontSize:9,color:C.textSec,letterSpacing:1}}>TOTAL ITEMS</div>
                        </div>
                      </div>
                      {lastDate&&<div style={{fontSize:10,color:C.textMuted,marginTop:6}}>Last request: {lastDate}</div>}
                    </div>

                    {/* Asset rows */}
                    <div style={{padding:"8px 0"}}>
                      {displayAssets.map((asset,i)=>(
                        <div key={i} className="asset-row" style={{display:"flex",alignItems:"center",gap:10,padding:"7px 16px",borderBottom:i<displayAssets.length-1?"1px solid "+C.border2:"none",transition:"background 0.1s"}}>
                          <span style={{fontSize:16,flexShrink:0}}>{ITEM_ICONS[asset.item]}</span>
                          <div style={{flex:1,minWidth:0}}>
                            <div style={{fontSize:12,fontWeight:600,color:C.textPrimary,lineHeight:1.2,whiteSpace:"nowrap",overflow:"hidden",textOverflow:"ellipsis"}}>{asset.brand}</div>
                            <div style={{fontSize:10,color:C.textSec,marginTop:1}}>{asset.item}</div>
                          </div>
                          <div style={{display:"flex",alignItems:"center",gap:8,flexShrink:0}}>
                            <div style={{textAlign:"right"}}>
                              <div style={{fontSize:16,fontWeight:700,color:itemColors[asset.item]||"#888"}}>{asset.count}</div>
                              <div style={{fontSize:9,color:C.textMuted}}>{asset.last}</div>
                            </div>
                            {asset.count>0&&(
                              <button
                                onClick={()=>{setTransferModal({fromAccount:accountName,item:asset.item,brand:asset.brand,maxQty:asset.count});setTransferQty(1);setTransferTo("");setTransferToSearch("");}}
                                title="Transfer to another account"
                                style={{background:"#1a1a1a",border:"1px solid #333",borderRadius:4,color:"#60a0e8",fontSize:11,padding:"4px 9px",cursor:"pointer",fontFamily:"inherit",letterSpacing:0.5,flexShrink:0,whiteSpace:"nowrap"}}>
                                ⇄ Move
                              </button>
                            )}
                          </div>
                        </div>
                      ))}

                      {/* Show more / less */}
                      {filtered.length>4&&(
                        <button onClick={()=>setAcctExpanded(isExpanded?null:accountName)}
                          style={{width:"100%",background:"transparent",border:"none",borderTop:"1px solid "+C.border2,padding:"10px",color:C.textSec,fontSize:11,cursor:"pointer",fontFamily:"inherit",letterSpacing:1,textTransform:"uppercase"}}>
                          {isExpanded?"▲ Show Less":"▼ Show All "+filtered.length+" Items"}
                        </button>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>

            {/* Empty state if all filtered out */}
            {sortedAccounts.every(([,assets])=>(acctItemFilter==="All"?assets:assets.filter(a=>a.item===acctItemFilter)).length===0)&&sortedAccounts.length>0&&(
              <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>
                No accounts have {acctItemFilter} in their history.
              </div>
            )}
          </div>
        )}

        {/* ════ REP: EVENTS & PROMOS ════ */}
        {view==="events"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-end",marginBottom:20,flexWrap:"wrap",gap:12}}>
              <div>
                <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>EVENTS & PROMOS</div>
                <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>{repUser.toUpperCase()} · {repEvents.length} EVENTS</div>
              </div>
              <button style={s.btn()} onClick={()=>setEvtView(evtView==="new"?"list":"new")}>
                {evtView==="new"?"← Back to List":"+ Book Event"}
              </button>
            </div>

            {/* New event form */}
            {evtView==="new"&&(
              <div style={{...s.card,maxWidth:580}}>
                <div style={s.h2}>📅 Book a New Promo Event</div>
                <div style={s.field}>
                  <label style={s.label}>Event / Promo Name</label>
                  <input style={s.input} placeholder="e.g. Fiddlehead IPA Tap Night" value={evtForm.title}
                    onChange={e=>setEvtForm(f=>({...f,title:e.target.value}))}/>
                </div>
                <div style={{...s.field}}>
                  <label style={s.label}>Account</label>
                  <input style={{...s.input,marginBottom:6}} placeholder="Search your accounts..."
                    value={evtForm.accountSearch}
                    onChange={e=>setEvtForm(f=>({...f,accountSearch:e.target.value,account:""}))}/>
                  {evtForm.accountSearch&&!evtForm.account&&(
                    <div style={{maxHeight:160,overflowY:"auto",background:"#0a0a0a",border:"1px solid "+C.border,borderRadius:4}}>
                      {(CUSTOMERS_BY_REP[repUser]||[]).filter(c=>c.toLowerCase().includes(evtForm.accountSearch.toLowerCase())).slice(0,30).map(c=>(
                        <div key={c} className="rh" onClick={()=>setEvtForm(f=>({...f,account:c,accountSearch:c}))}
                          style={{padding:"8px 12px",fontSize:12,cursor:"pointer",color:C.textPrimary,borderBottom:"1px solid #111"}}>{c}</div>
                      ))}
                    </div>
                  )}
                  {evtForm.account&&<div style={{fontSize:11,color:C.green,marginTop:4}}>✓ {evtForm.account}</div>}
                </div>
                <div style={s.field}>
                  <label style={s.label}>Brand / Product Being Featured</label>
                  <select style={s.select} value={evtForm.brand} onChange={e=>setEvtForm(f=>({...f,brand:e.target.value}))}>
                    <option value="">Select brand...</option>
                    {[...new Set(Object.values(brandsByItem).flat())].sort().map(b=><option key={b} value={b}>{b}</option>)}
                  </select>
                </div>
                <div style={{display:"grid",gridTemplateColumns:"1fr 1fr 1fr",gap:12,marginBottom:14}}>
                  <div>
                    <label style={s.label}>Date</label>
                    <input type="date" style={s.input} value={evtForm.date} onChange={e=>setEvtForm(f=>({...f,date:e.target.value}))}/>
                  </div>
                  <div>
                    <label style={s.label}>Start Time</label>
                    <input type="time" style={s.input} value={evtForm.startTime} onChange={e=>setEvtForm(f=>({...f,startTime:e.target.value}))}/>
                  </div>
                  <div>
                    <label style={s.label}>End Time</label>
                    <input type="time" style={s.input} value={evtForm.endTime} onChange={e=>setEvtForm(f=>({...f,endTime:e.target.value}))}/>
                  </div>
                </div>
                <div style={s.field}>
                  <label style={s.label}>Promo Staff Needed</label>
                  <div style={{display:"flex",gap:8}}>
                    {[1,2,3,4].map(n=>(
                      <button key={n} style={{...s.btn(evtForm.staffRequested===n?"primary":"ghost"),padding:"8px 18px"}}
                        onClick={()=>setEvtForm(f=>({...f,staffRequested:n}))}>{n}</button>
                    ))}
                  </div>
                </div>
                <div style={s.field}>
                  <label style={s.label}>POS Materials Needed</label>
                  <div style={{display:"flex",flexWrap:"wrap",gap:6}}>
                    {itemTypes.filter(t=>t!=="Other").map(t=>{
                      const sel=(evtForm.posItems||[]).includes(t);
                      return(
                        <button key={t} style={s.pill(sel,itemColors[t]||"#888")}
                          onClick={()=>setEvtForm(f=>({...f,posItems:sel?(f.posItems||[]).filter(x=>x!==t):[...(f.posItems||[]),t]}))}>
                          {ITEM_ICONS[t]} {t}
                        </button>
                      );
                    })}
                  </div>
                </div>
                <div style={s.field}>
                  <label style={s.label}>Notes for Marketing Manager</label>
                  <textarea style={{...s.input,height:72,resize:"vertical"}} placeholder="Any special requirements, themes, or context..."
                    value={evtForm.notes} onChange={e=>setEvtForm(f=>({...f,notes:e.target.value}))}/>
                </div>
                <button style={{...s.btn(),width:"100%",padding:14}} onClick={submitEvent}>SUBMIT FOR APPROVAL</button>
              </div>
            )}

            {/* Event list */}
            {evtView!=="new"&&(
              <div>
                {repEvents.length===0?(
                  <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>
                    No events yet. Click + Book Event to get started.
                  </div>
                ):repEvents.sort((a,b)=>a.date>b.date?1:-1).map(evt=>{
                  const st = eventStatus(evt);
                  const sc = statusColor(st);
                  return(
                    <div key={evt.id} style={{...s.cardAccent(sc),cursor:"pointer"}} onClick={()=>setEvtDetailId(evtDetailId===evt.id?null:evt.id)}>
                      <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",flexWrap:"wrap",gap:8}}>
                        <div style={{flex:1}}>
                          <div style={{display:"flex",alignItems:"center",gap:8,marginBottom:4,flexWrap:"wrap"}}>
                            <span style={{fontSize:15,fontWeight:700}}>{evt.title}</span>
                            <span style={s.tag(sc)}>{statusLabel(st)}</span>
                          </div>
                          <div style={{fontSize:12,color:C.textSec}}>{evt.account}</div>
                          <div style={{fontSize:11,color:C.textMuted,marginTop:3}}>
                            {evt.date} · {evt.startTime}–{evt.endTime} · {evt.brand||"No brand set"}
                          </div>
                        </div>
                        <div style={{textAlign:"right",fontSize:11,color:C.textSec}}>
                          <div>Staff: {(evt.staffAssigned||[]).length}/{evt.staffRequested}</div>
                          <div>POS: {evt.posApproved?"✓ Approved":evt.posRequested?"Pending":"N/A"}</div>
                        </div>
                      </div>
                      {evtDetailId===evt.id&&(
                        <div style={{marginTop:14,paddingTop:14,borderTop:"1px solid "+C.border2,fontSize:12}}>
                          {evt.staffAssigned?.length>0&&<div style={{marginBottom:6}}>
                            <span style={{color:C.textSec}}>Staff assigned: </span>
                            {evt.staffAssigned.map(s=><span key={s} style={{...s3.chip("#60a0e8")}}>{s}</span>)}
                          </div>}
                          {evt.posItems?.length>0&&<div style={{marginBottom:6}}>
                            <span style={{color:C.textSec}}>POS requested: </span>
                            {evt.posItems.map(p=><span key={p} style={s.tag(itemColors[p]||"#888")}>{ITEM_ICONS[p]} {p} </span>)}
                          </div>}
                          {evt.notes&&<div style={{color:C.textSec,fontStyle:"italic"}}>"{evt.notes}"</div>}
                          {evt.approvedBy&&<div style={{marginTop:6,color:C.green,fontSize:11}}>Approved by {evt.approvedBy} · {evt.approvedAt}</div>}
                          {st!=="cancelled"&&<button style={{...s.btn("danger",true),marginTop:10}} onClick={e=>{e.stopPropagation();cancelEvent(evt.id);}}>Cancel Event</button>}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        )}

        {/* ════ MARKETING: CALENDAR ════ */}
        {view==="mktCalendar"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:20,flexWrap:"wrap",gap:12}}>
              <div>
                <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>PROMO CALENDAR</div>
                <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>MARKETING MANAGER VIEW · ALL EVENTS</div>
              </div>
              <div style={{display:"flex",gap:8,alignItems:"center"}}>
                <button style={s.btn("ghost",true)} onClick={()=>setEvtCalMonth(m=>new Date(m.getFullYear(),m.getMonth()-1,1))}>◀</button>
                <span style={{fontSize:13,fontWeight:700,letterSpacing:1,minWidth:120,textAlign:"center"}}>
                  {evtCalMonth.toLocaleString("en-US",{month:"long",year:"numeric"}).toUpperCase()}
                </span>
                <button style={s.btn("ghost",true)} onClick={()=>setEvtCalMonth(m=>new Date(m.getFullYear(),m.getMonth()+1,1))}>▶</button>
              </div>
            </div>

            {/* Legend */}
            <div style={{display:"flex",gap:12,marginBottom:16,flexWrap:"wrap"}}>
              {[["#44cc88","Confirmed"],["#ffaa00","Pending / Needs Staff"],["#ff4d4d","Conflict"]].map(([c,l])=>(
                <div key={l} style={{display:"flex",alignItems:"center",gap:6,fontSize:11,color:C.textSec}}>
                  <span style={{width:10,height:10,borderRadius:2,background:c,display:"inline-block"}}/>
                  {l}
                </div>
              ))}
            </div>

            {/* Calendar grid */}
            {(()=>{
              const year = evtCalMonth.getFullYear();
              const month = evtCalMonth.getMonth();
              const firstDay = new Date(year,month,1).getDay();
              const daysInMonth = new Date(year,month+1,0).getDate();
              const cells = [];
              for (let i=0;i<firstDay;i++) cells.push(null);
              for (let d=1;d<=daysInMonth;d++) cells.push(d);
              const days=["SUN","MON","TUE","WED","THU","FRI","SAT"];
              return(
                <div style={{background:C.surface,border:"1px solid "+C.border,borderRadius:8,overflow:"hidden"}}>
                  {/* Day headers */}
                  <div style={{display:"grid",gridTemplateColumns:"repeat(7,1fr)",borderBottom:"1px solid "+C.border}}>
                    {days.map(d=><div key={d} style={{padding:"8px 4px",textAlign:"center",fontSize:10,letterSpacing:2,color:C.textSec,fontWeight:700}}>{d}</div>)}
                  </div>
                  {/* Day cells */}
                  <div style={{display:"grid",gridTemplateColumns:"repeat(7,1fr)"}}>
                    {cells.map((day,i)=>{
                      if (!day) return <div key={"e"+i} style={{minHeight:90,borderRight:"1px solid "+C.border2,borderBottom:"1px solid "+C.border2}}/>;
                      const dateStr = year+"-"+(String(month+1).padStart(2,"0"))+"-"+String(day).padStart(2,"0");
                      const dayEvts = events.filter(e=>e.date===dateStr&&e.status!=="cancelled");
                      const isToday = dateStr==="2026-03-13";
                      return(
                        <div key={day} style={{minHeight:90,borderRight:"1px solid "+C.border2,borderBottom:"1px solid "+C.border2,padding:6,background:isToday?"#1a1610":"transparent"}}>
                          <div style={{fontSize:12,fontWeight:isToday?700:400,color:isToday?C.accent:C.textSec,marginBottom:4}}>{day}</div>
                          {dayEvts.map(e=>{
                            const st=eventStatus(e);
                            const color=statusColor(st);
                            return(
                              <div key={e.id} onClick={()=>{setEvtDetailId(e.id);setView("mktEvents");}}
                                style={{background:color+"22",border:"1px solid "+color+"44",borderLeft:"2px solid "+color,borderRadius:3,padding:"3px 5px",marginBottom:3,fontSize:10,cursor:"pointer",lineHeight:1.3}}>
                                <div style={{fontWeight:600,color:C.textPrimary,whiteSpace:"nowrap",overflow:"hidden",textOverflow:"ellipsis"}}>{e.title}</div>
                                <div style={{color,fontSize:9}}>{e.rep} · {e.startTime}</div>
                              </div>
                            );
                          })}
                        </div>
                      );
                    })}
                  </div>
                </div>
              );
            })()}
          </div>
        )}

        {/* ════ MARKETING: ALL EVENTS ════ */}
        {view==="mktEvents"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-end",marginBottom:20,flexWrap:"wrap",gap:12}}>
              <div>
                <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>ALL EVENTS</div>
                <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>MARKETING MANAGER · APPROVE · STAFF · POS</div>
              </div>
              <div style={{display:"flex",gap:6}}>
                {["all","pending","approved","confirmed"].map(f=>(
                  <button key={f} style={s.pill(mktEvtFilter===f)} onClick={()=>setMktEvtFilter(f)}>{f.toUpperCase()}</button>
                ))}
              </div>
            </div>

            {events.length===0&&(
              <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>
                No events submitted yet. Reps can submit events from their Events tab.
              </div>
            )}

            {events
              .filter(e=>mktEvtFilter==="all"?true:mktEvtFilter==="confirmed"?eventStatus(e)==="confirmed":e.status===mktEvtFilter)
              .sort((a,b)=>a.date>b.date?1:-1)
              .map(evt=>{
                const st=eventStatus(evt);
                const sc=statusColor(st);
                const isOpen=evtDetailId===evt.id;
                return(
                  <div key={evt.id} style={{...s.card,borderLeft:"3px solid "+sc,marginBottom:12}}>
                    {/* Event header */}
                    <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",gap:12,flexWrap:"wrap"}}>
                      <div style={{flex:1}}>
                        <div style={{display:"flex",gap:8,alignItems:"center",flexWrap:"wrap",marginBottom:4}}>
                          <span style={{fontSize:15,fontWeight:700}}>{evt.title}</span>
                          <span style={s.tag(sc)}>{statusLabel(st)}</span>
                        </div>
                        <div style={{fontSize:12,fontWeight:600,color:C.textSec}}>{evt.account}</div>
                        <div style={{fontSize:11,color:C.textMuted,marginTop:2}}>
                          {evt.date} · {evt.startTime}–{evt.endTime} · Rep: <span style={{color:C.accent}}>{evt.rep}</span>
                          {evt.brand&&<span> · {evt.brand}</span>}
                        </div>
                      </div>
                      <div style={{display:"flex",gap:6,flexWrap:"wrap"}}>
                        {evt.status==="pending"&&(
                          <button style={{...s.btn("success",true)}} onClick={()=>approveEvent(evt.id)}>✓ Approve</button>
                        )}
                        {evt.status==="approved"&&<span style={{...s.tag(C.green),padding:"5px 10px"}}>Approved</span>}
                        <button style={{...s.btn("ghost",true)}} onClick={()=>setEvtDetailId(isOpen?null:evt.id)}>
                          {isOpen?"▲ Hide":"▼ Manage"}
                        </button>
                        {evt.status!=="cancelled"&&<button style={s.btn("danger",true)} onClick={()=>cancelEvent(evt.id)}>✕</button>}
                      </div>
                    </div>

                    {/* Expanded management panel */}
                    {isOpen&&(
                      <div style={{marginTop:16,paddingTop:16,borderTop:"1px solid "+C.border2}}>
                        <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:16}}>

                          {/* Staff assignment */}
                          <div>
                            <div style={{fontSize:11,letterSpacing:2,color:C.textSec,textTransform:"uppercase",marginBottom:10}}>
                              Staff Assignment <span style={{color:(evt.staffAssigned||[]).length>=evt.staffRequested?C.green:C.orange}}>({(evt.staffAssigned||[]).length}/{evt.staffRequested})</span>
                            </div>
                            <div style={{display:"flex",flexDirection:"column",gap:4}}>
                              {promoStaff.filter(ps=>!staffSearchFilter||ps.name.toLowerCase().includes(staffSearchFilter.toLowerCase())).map(ps=>{
                                const assigned=(evt.staffAssigned||[]).includes(ps.name);
                                const conflicts=getStaffConflicts(evt.date,ps.name,evt.id);
                                return(
                                  <div key={ps.id} style={{display:"flex",alignItems:"center",gap:8,padding:"6px 10px",background:assigned?"#0a180a":"#111",border:"1px solid "+(assigned?"#2a4a2a":C.border2),borderRadius:4}}>
                                    <div style={{flex:1,minWidth:0}}>
                                      <span style={{fontSize:12,color:conflicts.length>0?C.red:C.textPrimary}}>{ps.name}{conflicts.length>0&&" ⚠"}</span>
                                      {ps.phone&&<div style={{fontSize:10,color:C.textMuted}}>{ps.phone}</div>}
                                    </div>
                                    {conflicts.length>0&&<span style={{fontSize:9,color:C.red}}>conflict</span>}
                                    <button style={{...s.btn(assigned?"danger":"ghost",true),padding:"3px 10px",fontSize:10}}
                                      onClick={()=>assignStaff(evt.id,ps.name)}>
                                      {assigned?"Remove":"Assign"}
                                    </button>
                                  </div>
                                );
                              })}
                            </div>
                          </div>

                          {/* POS & details */}
                          <div>
                            <div style={{fontSize:11,letterSpacing:2,color:C.textSec,textTransform:"uppercase",marginBottom:10}}>POS Materials</div>
                            {evt.posItems?.length>0?(
                              <div>
                                <div style={{display:"flex",flexWrap:"wrap",gap:6,marginBottom:12}}>
                                  {evt.posItems.map(p=><span key={p} style={s.tag(itemColors[p]||"#888")}>{ITEM_ICONS[p]} {p}</span>)}
                                </div>
                                <div style={{fontSize:12,color:C.textSec,marginBottom:8}}>
                                  Status: <span style={{color:evt.posApproved?C.green:C.orange,fontWeight:600}}>{evt.posApproved?"✓ Approved & Reserved":"Pending Approval"}</span>
                                </div>
                                {!evt.posApproved&&evt.status==="approved"&&(
                                  <button style={{...s.btn("success",true),width:"100%"}} onClick={()=>approvePOS(evt.id)}>✓ Approve POS</button>
                                )}
                              </div>
                            ):(
                              <div style={{color:C.textMuted,fontSize:12}}>No POS materials requested</div>
                            )}

                            <div style={{marginTop:16}}>
                              <div style={{fontSize:11,letterSpacing:2,color:C.textSec,textTransform:"uppercase",marginBottom:8}}>Event Details</div>
                              <div style={{fontSize:12,color:C.textSec,lineHeight:1.8}}>
                                <div>Date: <span style={{color:C.textPrimary}}>{evt.date}</span></div>
                                <div>Time: <span style={{color:C.textPrimary}}>{evt.startTime} – {evt.endTime}</span></div>
                                <div>Brand: <span style={{color:C.textPrimary}}>{evt.brand||"—"}</span></div>
                                <div>Submitted: <span style={{color:C.textPrimary}}>{evt.createdAt}</span></div>
                              </div>
                            </div>
                            {evt.notes&&(
                              <div style={{marginTop:12,background:"#0e0e0e",border:"1px solid "+C.border,borderRadius:6,padding:10,fontSize:12,color:C.textSec,fontStyle:"italic"}}>
                                "{evt.notes}"
                              </div>
                            )}
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                );
              })
            }
          </div>
        )}

        {/* ════ MARKETING: STAFF ════ */}
        {view==="mktStaff"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-end",marginBottom:20,flexWrap:"wrap",gap:12}}>
              <div>
                <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>PROMO STAFF</div>
                <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>BRAND AMBASSADOR ROSTER · {promoStaff.length} STAFF</div>
              </div>
              <input style={{...s.input,width:220}} placeholder="Search staff..." value={staffSearchFilter} onChange={e=>setStaffSearchFilter(e.target.value)}/>
            </div>

            <div style={{display:"grid",gridTemplateColumns:"minmax(320px,420px) 1fr",gap:20,alignItems:"start"}}>

              {/* ── LEFT: Add new staff form ── */}
              <div>
                <div style={{...s.card,borderTop:"3px solid #9070d0",marginBottom:16}}>
                  <div style={{fontSize:12,fontWeight:700,letterSpacing:2,color:"#9070d0",marginBottom:16}}>+ ADD STAFF MEMBER</div>
                  <div style={s.field}>
                    <label style={s.label}>Full Name *</label>
                    <input style={s.input} placeholder="e.g. Sarah J." value={addStaffForm.name}
                      onChange={e=>setAddStaffForm(f=>({...f,name:e.target.value}))}
                      onKeyDown={e=>{if(e.key==="Enter")addStaffMember();}}/>
                  </div>
                  <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:10,marginBottom:14}}>
                    <div>
                      <label style={s.label}>Phone</label>
                      <input style={s.input} placeholder="603-555-0000" value={addStaffForm.phone}
                        onChange={e=>setAddStaffForm(f=>({...f,phone:e.target.value}))}/>
                    </div>
                    <div>
                      <label style={s.label}>Email</label>
                      <input style={s.input} placeholder="name@email.com" value={addStaffForm.email}
                        onChange={e=>setAddStaffForm(f=>({...f,email:e.target.value}))}/>
                    </div>
                  </div>
                  <div style={s.field}>
                    <label style={s.label}>Notes (optional)</label>
                    <input style={s.input} placeholder="Availability, territory, specialties..." value={addStaffForm.notes}
                      onChange={e=>setAddStaffForm(f=>({...f,notes:e.target.value}))}/>
                  </div>
                  <button style={{...s.btn(),width:"100%",padding:11,background:"#9070d0"}} onClick={addStaffMember}>
                    + ADD TO ROSTER
                  </button>
                </div>

                {/* Quick stats */}
                <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:10}}>
                  {[
                    {label:"Total Staff",val:promoStaff.length,color:"#9070d0"},
                    {label:"Assigned to Events",val:[...new Set(events.filter(e=>e.status!=="cancelled").flatMap(e=>e.staffAssigned||[]))].length,color:C.green},
                  ].map(stat=>(
                    <div key={stat.label} style={{background:C.surface,border:"1px solid "+stat.color+"33",borderLeft:"3px solid "+stat.color,borderRadius:6,padding:"12px 14px"}}>
                      <div style={{fontSize:10,color:C.textSec,letterSpacing:2,textTransform:"uppercase",marginBottom:4}}>{stat.label}</div>
                      <div style={{fontSize:26,fontWeight:700,color:stat.color,lineHeight:1}}>{stat.val}</div>
                    </div>
                  ))}
                </div>
              </div>

              {/* ── RIGHT: Staff roster cards ── */}
              <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(240px,1fr))",gap:12,alignContent:"start"}}>
                {promoStaff
                  .filter(ps=>!staffSearchFilter||ps.name.toLowerCase().includes(staffSearchFilter.toLowerCase())||ps.phone.includes(staffSearchFilter)||ps.email.toLowerCase().includes(staffSearchFilter.toLowerCase()))
                  .map(ps=>{
                    const assignedEvents=events.filter(e=>(e.staffAssigned||[]).includes(ps.name)&&e.status!=="cancelled");
                    const upcoming=assignedEvents.filter(e=>e.date>="2026-03-16").sort((a,b)=>a.date>b.date?1:-1);
                    const isEditing = editingStaff?.id===ps.id;
                    return(
                      <div key={ps.id} style={{background:C.surface,border:"1px solid "+(isEditing?"#9070d0":C.border),borderRadius:8,overflow:"hidden",transition:"border-color 0.15s"}}>
                        {/* Card header */}
                        <div style={{background:C.surface2,borderBottom:"1px solid "+C.border,padding:"12px 14px"}}>
                          {isEditing ? (
                            <div>
                              <input style={{...s.input,marginBottom:6,fontSize:13,fontWeight:600}}
                                value={editingStaff.name} onChange={e=>setEditingStaff(f=>({...f,name:e.target.value}))}/>
                              <input style={{...s.input,marginBottom:6,fontSize:11}} placeholder="Phone"
                                value={editingStaff.phone} onChange={e=>setEditingStaff(f=>({...f,phone:e.target.value}))}/>
                              <input style={{...s.input,marginBottom:6,fontSize:11}} placeholder="Email"
                                value={editingStaff.email} onChange={e=>setEditingStaff(f=>({...f,email:e.target.value}))}/>
                              <input style={{...s.input,fontSize:11}} placeholder="Notes"
                                value={editingStaff.notes} onChange={e=>setEditingStaff(f=>({...f,notes:e.target.value}))}/>
                              <div style={{display:"flex",gap:6,marginTop:8}}>
                                <button style={{...s.btn("success",true),flex:1}} onClick={saveStaffEdit}>✓ Save</button>
                                <button style={{...s.btn("ghost",true),flex:1}} onClick={()=>setEditingStaff(null)}>Cancel</button>
                              </div>
                            </div>
                          ) : (
                            <div>
                              <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",marginBottom:6}}>
                                <div>
                                  <div style={{fontWeight:700,fontSize:14,marginBottom:1}}>{ps.name}</div>
                                  {ps.phone&&<div style={{fontSize:11,color:C.textSec}}>{ps.phone}</div>}
                                  {ps.email&&<div style={{fontSize:10,color:C.textMuted,marginTop:1}}>{ps.email}</div>}
                                  {ps.notes&&<div style={{fontSize:10,color:"#9070d0",marginTop:3,fontStyle:"italic"}}>{ps.notes}</div>}
                                </div>
                                <div style={{display:"flex",gap:4,flexShrink:0,marginLeft:8}}>
                                  <button onClick={()=>setEditingStaff({...ps})}
                                    title="Edit"
                                    style={{background:"#1a1a1a",border:"1px solid "+C.border,borderRadius:4,color:C.textSec,cursor:"pointer",padding:"4px 8px",fontSize:12,lineHeight:1}}>
                                    ✎
                                  </button>
                                  {removeConfirm===ps.id ? (
                                    <>
                                      <button onClick={()=>removeStaffMember(ps.id)}
                                        style={{background:"#2a0808",border:"1px solid "+C.red+"55",borderRadius:4,color:C.red,cursor:"pointer",padding:"4px 8px",fontSize:10,letterSpacing:0.5,fontFamily:"inherit",fontWeight:700}}>
                                        CONFIRM
                                      </button>
                                      <button onClick={()=>setRemoveConfirm(null)}
                                        style={{background:"#1a1a1a",border:"1px solid "+C.border,borderRadius:4,color:C.textSec,cursor:"pointer",padding:"4px 8px",fontSize:10,fontFamily:"inherit"}}>
                                        Cancel
                                      </button>
                                    </>
                                  ) : (
                                    <button onClick={()=>setRemoveConfirm(ps.id)}
                                      title="Remove from roster"
                                      style={{background:"#1a1a1a",border:"1px solid "+C.border,borderRadius:4,color:C.red+"99",cursor:"pointer",padding:"4px 8px",fontSize:12,lineHeight:1}}>
                                      ✕
                                    </button>
                                  )}
                                </div>
                              </div>
                              <div style={{display:"flex",gap:8,alignItems:"center"}}>
                                <div style={{background:"#9070d011",border:"1px solid #9070d033",borderRadius:4,padding:"3px 8px",fontSize:10,color:"#9070d0",fontWeight:600}}>
                                  {upcoming.length} upcoming
                                </div>
                                <div style={{background:C.green+"11",border:"1px solid "+C.green+"33",borderRadius:4,padding:"3px 8px",fontSize:10,color:C.green,fontWeight:600}}>
                                  {assignedEvents.length} total
                                </div>
                              </div>
                            </div>
                          )}
                        </div>

                        {/* Upcoming assignments */}
                        {!isEditing&&(
                          <div style={{padding:"6px 0"}}>
                            {upcoming.length===0?(
                              <div style={{padding:"8px 14px",fontSize:11,color:C.textMuted}}>No upcoming assignments</div>
                            ):upcoming.slice(0,3).map(e=>{
                              const sc=statusColor(eventStatus(e));
                              return(
                                <div key={e.id} style={{padding:"6px 14px",borderBottom:"1px solid "+C.border2,fontSize:11}}>
                                  <div style={{fontWeight:600,color:C.textPrimary,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{e.title}</div>
                                  <div style={{fontSize:10,color:C.textSec,marginTop:1}}>{e.date} · {e.account.split(" ").slice(0,3).join(" ")}</div>
                                </div>
                              );
                            })}
                            {upcoming.length>3&&(
                              <div style={{padding:"6px 14px",fontSize:10,color:C.textMuted}}>+{upcoming.length-3} more</div>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  })}
                {promoStaff.filter(ps=>!staffSearchFilter||ps.name.toLowerCase().includes(staffSearchFilter.toLowerCase())||ps.phone.includes(staffSearchFilter)||ps.email.toLowerCase().includes(staffSearchFilter.toLowerCase())).length===0&&(
                  <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:40,gridColumn:"1/-1"}}>
                    {staffSearchFilter?"No staff match your search":"No staff added yet"}
                  </div>
                )}
              </div>
            </div>
          </div>
        )}
        {view==="transfers"&&(
          <div style={{animation:"fadeUp 0.2s ease"}}>
            <div style={{marginBottom:20}}>
              <div style={{fontSize:20,fontWeight:700,letterSpacing:2,marginBottom:2}}>ACCOUNT TRANSFERS</div>
              <div style={{fontSize:11,color:C.textSec,letterSpacing:2}}>{repUser.toUpperCase()} · {transfers.filter(t=>t.rep===repUser).length} TRANSFERS LOGGED</div>
            </div>
            <div style={{...s.card,marginBottom:16,background:"#0e1a10",border:"1px solid #1a3020",borderLeft:"3px solid #44cc88"}}>
              <div style={{fontSize:12,color:"#44cc88",fontWeight:600,marginBottom:4}}>HOW TRANSFERS WORK</div>
              <div style={{fontSize:12,color:"#6a9a74",lineHeight:1.6}}>
                Use transfers to move POS items directly between accounts — no warehouse trip needed. Go to <strong style={{color:"#8abf94"}}>My Accounts</strong>, find the item at its current location, and click <strong style={{color:"#8abf94"}}>⇄ Move</strong> to reassign it to another account.
              </div>
            </div>
            {transfers.filter(t=>t.rep===repUser).length===0?(
              <div style={{...s.card,textAlign:"center",color:C.textMuted,padding:60}}>
                No transfers yet. Use the ⇄ Move button on any asset in My Accounts.
              </div>
            ):(
              <div style={{...s.card,padding:0,overflow:"hidden"}}>
                <table style={{width:"100%",borderCollapse:"collapse"}}>
                  <thead>
                    <tr style={{borderBottom:"1px solid "+C.border}}>
                      {["Time","Item","Brand","Qty","From Account","To Account"].map(h=>(
                        <th key={h} style={{textAlign:"left",fontSize:10,letterSpacing:2,color:C.textSec,textTransform:"uppercase",padding:"10px 14px"}}>{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {transfers.filter(t=>t.rep===repUser).map(t=>(
                      <tr key={t.id} className="rh" style={{borderBottom:"1px solid "+C.border2,background:t.isReturn?"#0e1008":"transparent"}}>
                        <td style={{padding:"9px 14px",fontSize:11,color:C.textMuted,whiteSpace:"nowrap"}}>{t.ts}</td>
                        <td style={{padding:"9px 14px"}}><span style={s.tag(itemColors[t.item]||"#888")}>{ITEM_ICONS[t.item]} {t.item}</span></td>
                        <td style={{padding:"9px 14px",fontSize:13,fontWeight:600}}>{t.brand}</td>
                        <td style={{padding:"9px 14px",fontSize:15,fontWeight:700,color:t.isReturn?C.orange:"#60a0e8"}}>{t.qty}</td>
                        <td style={{padding:"9px 14px",fontSize:12,color:C.textSec}}>{t.fromAccount}</td>
                        <td style={{padding:"9px 14px",fontSize:12,fontWeight:600,color:t.isReturn?C.orange:C.green,display:"flex",alignItems:"center",gap:6}}>
                          {t.isReturn&&<span style={{fontSize:11}}>🏭</span>}
                          {t.toAccount}
                          {t.isReturn&&<span style={s.tag(C.orange)}>RETURNED</span>}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

      </div>

      {/* ════ TRANSFER MODAL ════ */}
      {transferModal&&(
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.75)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:1000,padding:20}}
          onClick={()=>setTransferModal(null)}>
          <div style={{background:C.surface,border:"1px solid #333",borderTop:"3px solid #60a0e8",borderRadius:10,padding:28,width:"100%",maxWidth:460,maxHeight:"85vh",overflowY:"auto",animation:"fadeUp 0.2s ease"}}
            onClick={e=>e.stopPropagation()}>

            {/* Modal header */}
            <div style={{marginBottom:20}}>
              <div style={{fontSize:14,fontWeight:700,letterSpacing:2,color:"#60a0e8",marginBottom:4}}>⇄ MOVE ITEM</div>
              <div style={{fontSize:11,color:C.textSec}}>Reassign an asset directly between accounts</div>
            </div>

            {/* What's being moved */}
            <div style={{background:"#0e0e0e",border:"1px solid "+C.border,borderRadius:8,padding:"14px 16px",marginBottom:20}}>
              <div style={{fontSize:10,color:C.textSec,letterSpacing:2,marginBottom:10,textTransform:"uppercase"}}>Moving</div>
              <div style={{display:"flex",alignItems:"center",gap:12}}>
                <span style={{fontSize:24}}>{ITEM_ICONS[transferModal.item]}</span>
                <div style={{flex:1}}>
                  <div style={{fontSize:14,fontWeight:700,color:C.textPrimary}}>{transferModal.brand}</div>
                  <div style={{fontSize:11,color:C.textSec}}>{transferModal.item}</div>
                </div>
                <span style={s.tag(itemColors[transferModal.item]||"#888")}>{transferModal.maxQty} at account</span>
              </div>
              <div style={{marginTop:10,paddingTop:10,borderTop:"1px solid "+C.border2,fontSize:12,color:C.textSec}}>
                From: <span style={{color:C.orange,fontWeight:600}}>{transferModal.fromAccount}</span>
              </div>
            </div>

            {/* Qty */}
            <div style={{marginBottom:16}}>
              <label style={{fontSize:10,letterSpacing:2,color:C.textSec,textTransform:"uppercase",display:"block",marginBottom:8}}>Quantity to Move</label>
              <div style={{display:"flex",gap:8,flexWrap:"wrap",alignItems:"center"}}>
                {[...Array(Math.min(transferModal.maxQty,5))].map((_,i)=>(
                  <button key={i+1} style={{...s.btn(transferQty===i+1?"primary":"ghost"),padding:"8px 16px"}}
                    onClick={()=>setTransferQty(i+1)}>{i+1}</button>
                ))}
                {transferModal.maxQty>5&&(
                  <input type="number" min={1} max={transferModal.maxQty} style={{...s.input,width:80}}
                    value={transferQty} onChange={e=>setTransferQty(Math.min(transferModal.maxQty,Math.max(1,parseInt(e.target.value)||1)))}/>
                )}
                <span style={{fontSize:11,color:C.textMuted}}>max {transferModal.maxQty}</span>
              </div>
            </div>

            {/* Destination account */}
            <div style={{marginBottom:20}}>
              <label style={{fontSize:10,letterSpacing:2,color:C.textSec,textTransform:"uppercase",display:"block",marginBottom:8}}>Destination Account</label>
              <input style={{...s.input,marginBottom:6}} placeholder="Search accounts or warehouse..."
                value={transferToSearch}
                onChange={e=>{setTransferToSearch(e.target.value);setTransferTo("");}}/>
              <div style={{maxHeight:200,overflowY:"auto",background:"#0a0a0a",border:"1px solid "+C.border,borderRadius:6}}>
                {/* Pinned: Return to Warehouse */}
                {(!transferToSearch||"main warehouse".includes(transferToSearch.toLowerCase()))&&(
                  <div onClick={()=>{setTransferTo("⬡ MAIN WAREHOUSE");setTransferToSearch("⬡ MAIN WAREHOUSE");}}
                    className="rh"
                    style={{padding:"9px 12px",fontSize:12,cursor:"pointer",
                      background:transferTo==="⬡ MAIN WAREHOUSE"?C.orange+"22":"#0e1008",
                      color:transferTo==="⬡ MAIN WAREHOUSE"?C.orange:"#b0a060",
                      borderBottom:"2px solid #222",display:"flex",justifyContent:"space-between",alignItems:"center"}}>
                    <span style={{display:"flex",alignItems:"center",gap:8}}>
                      <span style={{fontSize:14}}>🏭</span>
                      <span style={{fontWeight:700,letterSpacing:0.5}}>MAIN WAREHOUSE</span>
                      <span style={{fontSize:9,color:"#6a5a30",letterSpacing:1,background:"#2a2010",padding:"1px 6px",borderRadius:3}}>RETURN</span>
                    </span>
                    {transferTo==="⬡ MAIN WAREHOUSE"&&<span style={{color:C.orange,fontSize:14}}>✓</span>}
                  </div>
                )}
                {/* Rep account history */}
                {Object.keys(mergedAccounts)
                  .filter(a=>a!==transferModal.fromAccount)
                  .filter(a=>!transferToSearch||a.toLowerCase().includes(transferToSearch.toLowerCase()))
                  .sort()
                  .slice(0,60)
                  .map(acct=>(
                    <div key={acct} onClick={()=>{setTransferTo(acct);setTransferToSearch(acct);}}
                      className="rh"
                      style={{padding:"9px 12px",fontSize:12,cursor:"pointer",
                        background:transferTo===acct?C.accent+"22":"transparent",
                        color:transferTo===acct?C.accent:C.textPrimary,
                        borderBottom:"1px solid #111",display:"flex",justifyContent:"space-between",alignItems:"center"}}>
                      <span>{acct}</span>
                      {transferTo===acct&&<span style={{color:C.accent,fontSize:14}}>✓</span>}
                    </div>
                  ))
                }
                {/* Also show all rep customers not yet in history */}
                {(CUSTOMERS_BY_REP[repUser]||[])
                  .filter(c=>!mergedAccounts[c]&&c!==transferModal.fromAccount)
                  .filter(c=>!transferToSearch||c.toLowerCase().includes(transferToSearch.toLowerCase()))
                  .slice(0,20)
                  .map(acct=>(
                    <div key={acct} onClick={()=>{setTransferTo(acct);setTransferToSearch(acct);}}
                      className="rh"
                      style={{padding:"9px 12px",fontSize:12,cursor:"pointer",
                        background:transferTo===acct?C.accent+"22":"transparent",
                        color:transferTo===acct?C.accent:C.textPrimary,
                        borderBottom:"1px solid #111",display:"flex",justifyContent:"space-between",alignItems:"center"}}>
                      <span>{acct}</span>
                      <span style={{fontSize:9,color:C.textMuted,letterSpacing:1}}>NEW</span>
                    </div>
                  ))
                }
              </div>
            </div>

            {/* Preview */}
            {transferTo&&(
              <div style={{background:"#0a120e",border:"1px solid #1a3020",borderRadius:8,padding:"12px 16px",marginBottom:16,fontSize:12}}>
                <div style={{color:"#44cc88",fontWeight:700,marginBottom:6}}>Transfer Preview</div>
                <div style={{display:"flex",gap:8,alignItems:"center",flexWrap:"wrap"}}>
                  <span style={{color:C.orange}}>{transferModal.fromAccount}</span>
                  <span style={{color:C.textSec,fontSize:16}}>→</span>
                  <span style={{color:C.green,fontWeight:600}}>{transferTo}</span>
                </div>
                <div style={{marginTop:6,color:C.textSec}}>
                  {transferQty}x {transferModal.brand} ({transferModal.item})
                </div>
              </div>
            )}

            <div style={{display:"flex",gap:10}}>
              <button style={{...s.btn(),flex:1,padding:12,background:"#60a0e8",color:"#fff"}} onClick={submitTransfer}>
                ⇄ CONFIRM TRANSFER
              </button>
              <button style={{...s.btn("ghost"),flex:1,padding:12}} onClick={()=>setTransferModal(null)}>
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
