# Items for shared/items.lua
```lua
-- Equipment
fishingrod = { name = 'fishingrod', label = 'EZ Cast 2000', weight = 5000, type = 'item', image = 'fishingrod.png', unique = true, useable = true, shouldClose = true, description = 'Perfect entry-level tool for all your fishing needs.' },
fishingrod2 = { name = 'fishingrod2', label = 'Coastal Caster Plus', weight = 5500, type = 'item', image = 'fishingrod2.png', unique = true, useable = true, shouldClose = true, description = 'The fisherman\'s friend for a day by the shore.' },
fishingrod3 = { name = 'fishingrod3', label = 'Predator Pro Rod', weight = 6000, type = 'item', image = 'fishingrod3.png', unique = true, useable = true, shouldClose = true, description = 'Built for the challenge of catching predatory fish. When you\'re after the big ones!' },

fishingnet = { name = 'fishingnet', label = 'Fishing Net', weight = 3000, type = 'item', image = 'fishingnet.png', unique = true, useable = true, shouldClose = true, description = 'Great for catching a bunch of fish.' },
net_repair_kit = { name = 'net_repair_kit', label = 'Net Repair Kit', weight = 1000, type = 'item', image = 'net_repair_kit.png', unique = false, useable = true, shouldClose = true, description = 'Used to repair damaged fishing nets.' },

bait_shovel = { name = 'bait_shovel', label = 'Shovel', weight = 2500, type = 'item', image = 'bait_shovel.png', unique = true, useable = true, shouldClose = true, description = 'A sturdy shovel, perfect for digging up bait.' },
logbook = { name = 'logbook', label = 'Logbook', weight = 1000, type = 'item', image = 'logbook.png', unique = true, useable = true, shouldClose = true, description = 'Useful to keep track of the fish you\'ve caught.' },
fishinghat = { name = 'fishinghat', label = 'Lucky Fishing Hat', weight = 1000, type = 'item', image = 'fishinghat.png', unique = true, useable = true, shouldClose = true, description = 'A lucky hat that improves your fishing luck.' },
anchor = { name = 'anchor', label = 'Anchor', weight = 1000, type = 'item', image = 'anchor.png', unique = false, useable = true, shouldClose = true, description = 'A useful tool to prevent your boat from drifting away.' },
illegal_hook = { name = 'illegal_hook', label = 'Illegal Hook', weight = 1000, type = 'item', image = 'illegal_hook.png', unique = true, useable = true, shouldClose = true, description = 'An illegally modified fishing hook, designed to maim and injure fish to make them easier to catch.' },

-- Bait Items
fishingbait = { name = 'fishingbait', label = 'Earthworms', weight = 250, type = 'item', image = 'earthworms.png', unique = false, useable = true, shouldClose = true, description = 'Standard bait, suitable for common fish.' },
good_bait = { name = 'good_bait', label = 'Crickets', weight = 500, type = 'item', image = 'crickets.png', unique = false, useable = true, shouldClose = true, description = 'Above-average bait, increases chances of better catches.' },
excellent_bait = { name = 'excellent_bait', label = 'Leeches', weight = 500, type = 'item', image = 'leeches.png', unique = false, useable = true, shouldClose = true, description = 'High-quality bait for catching rare and valuable fish.' },
legendary_bait = { name = 'legendary_bait', label = 'Glowing Earthworm', weight = 1000, type = 'item', image = 'glowworms.png', unique = false, useable = true, shouldClose = true, description = 'A bioluminescent worm that lures even the most elusive legendary fish with its captivating light.' },
treasure_bait = { name = 'treasure_bait', label = 'Treasure Hunter\'s Lure', weight = 1000, type = 'item', image = 'treasure_bait.png', unique = false, useable = true, shouldClose = true, description = 'A special bait carefully crafted to find treasures.' },

-- Common
salmon = { name = 'salmon', label = 'Salmon', weight = 1000, type = 'item', image = 'salmon.png', unique = true, useable = true, shouldClose = true, description = 'Prized for its pink flesh and omega-3 fatty acids.' },
trout = { name = 'trout', label = 'Trout', weight = 1000, type = 'item', image = 'trout.png', unique = true, useable = true, shouldClose = true, description = 'Freshwater fish known for its delicate flavor.' },
bass = { name = 'bass', label = 'Bass', weight = 1000, type = 'item', image = 'bass.png', unique = true, useable = true, shouldClose = true, description = 'Popular game fish with a mild, white flesh.' },
catfish = { name = 'catfish', label = 'Catfish', weight = 1000, type = 'item', image = 'catfish.png', unique = true, useable = true, shouldClose = true, description = 'Bottom-dwelling fish with whisker-like barbels.' },
perch = { name = 'perch', label = 'Perch', weight = 1000, type = 'item', image = 'perch.png', unique = true, useable = true, shouldClose = true, description = 'Small freshwater fish with a mild, sweet taste.' },
pike = { name = 'pike', label = 'Pike', weight = 1000, type = 'item', image = 'pike.png', unique = true, useable = true, shouldClose = true, description = 'Predatory fish with a long, slender body.' },
carp = { name = 'carp', label = 'Carp', weight = 1000, type = 'item', image = 'carp.png', unique = true, useable = true, shouldClose = true, description = 'Hardy freshwater fish, popular in Asian cuisine.' },

-- Uncommon
bluegill = { name = 'bluegill', label = 'Bluegill', weight = 1000, type = 'item', image = 'bluegill.png', unique = true, useable = true, shouldClose = true, description = 'Small sunfish with a distinctive blue patch near the gills.' },
cod = { name = 'cod', label = 'Cod', weight = 1000, type = 'item', image = 'cod.png', unique = true, useable = true, shouldClose = true, description = 'Whitefish commonly used in fish and chips.' },
herring = { name = 'herring', label = 'Herring', weight = 1000, type = 'item', image = 'herring.png', unique = true, useable = true, shouldClose = true, description = 'Small, oily fish often pickled or smoked.' },
walleye = { name = 'walleye', label = 'Walleye', weight = 1000, type = 'item', image = 'walleye.png', unique = true, useable = true, shouldClose = true, description = 'Freshwater perciform fish with large, glassy eyes.' },
bream = { name = 'bream', label = 'Bream', weight = 1000, type = 'item', image = 'bream.png', unique = true, useable = true, shouldClose = true, description = 'Flat-bodied freshwater fish, good for pan-frying.' },
zander = { name = 'zander', label = 'Zander', weight = 1000, type = 'item', image = 'zander.png', unique = true, useable = true, shouldClose = true, description = 'European freshwater fish, similar to walleye.' },

-- Rare
sturgeon = { name = 'sturgeon', label = 'Sturgeon', weight = 1000, type = 'item', image = 'sturgeon.png', unique = true, useable = true, shouldClose = true, description = 'Ancient fish prized for its caviar.' },
swordfish = { name = 'swordfish', label = 'Swordfish', weight = 1000, type = 'item', image = 'swordfish.png', unique = true, useable = true, shouldClose = true, description = 'Large, predatory fish with a distinctive bill.' },
tuna = { name = 'tuna', label = 'Tuna', weight = 1000, type = 'item', image = 'tuna.png', unique = true, useable = true, shouldClose = true, description = 'Fast-swimming fish with firm, meaty flesh.' },
muskellunge = { name = 'muskellunge', label = 'Muskellunge', weight = 1000, type = 'item', image = 'muskellunge.png', unique = true, useable = true, shouldClose = true, description = 'Large, predatory freshwater fish.' },
tarpon = { name = 'tarpon', label = 'Tarpon', weight = 1000, type = 'item', image = 'tarpon.png', unique = true, useable = true, shouldClose = true, description = 'Large, silver-scaled fish known for acrobatic jumps.' },
giantcatfish = { name = 'giantcatfish', label = 'Giant Catfish', weight = 1000, type = 'item', image = 'giantcatfish.png', unique = true, useable = true, shouldClose = true, description = 'Massive freshwater fish found in large rivers.' },

-- Very rare
shark = { name = 'shark', label = 'Shark', weight = 1000, type = 'item', image = 'shark.png', unique = true, useable = true, shouldClose = true, description = 'Cartilaginous fish with multiple rows of teeth.' },
eel = { name = 'eel', label = 'Eel', weight = 1000, type = 'item', image = 'eel.png', unique = true, useable = true, shouldClose = true, description = 'Snake-like fish with a slimy skin.' },
arapaima = { name = 'arapaima', label = 'Arapaima', weight = 1000, type = 'item', image = 'arapaima.png', unique = true, useable = true, shouldClose = true, description = 'One of the largest freshwater fish in the world.' },
giantsnakehead = { name = 'giantsnakehead', label = 'Giant Snakehead', weight = 1000, type = 'item', image = 'giantsnakehead.png', unique = true, useable = true, shouldClose = true, description = 'Aggressive predatory fish native to Asia.' },
goliathtigerfish = { name = 'goliathtigerfish', label = 'Goliath Tigerfish', weight = 1000, type = 'item', image = 'goliathtigerfish.png', unique = true, useable = true, shouldClose = true, description = 'Fearsome predator with large, sharp teeth.' },

-- Legendary
whale = { name = 'whale', label = 'Whale', weight = 1000, type = 'item', image = 'whale.png', unique = true, useable = true, shouldClose = true, description = 'Enormous marine mammal.' },
devilray = { name = 'devilray', label = 'Devil Ray', weight = 1000, type = 'item', image = 'devilray.png', unique = true, useable = true, shouldClose = true, description = 'Large, flat-bodied fish related to sharks.' },
kraken = { name = 'kraken', label = 'Kraken', weight = 1000, type = 'item', image = 'kraken.png', unique = true, useable = true, shouldClose = true, description = 'Mythical sea monster.' },
megalodon = { name = 'megalodon', label = 'Megalodon', weight = 1000, type = 'item', image = 'megalodon.png', unique = true, useable = true, shouldClose = true, description = 'Colossal shark thought extinct, now rarely seen in deepest waters.' },
giantcoelacanth = { name = 'giantcoelacanth', label = 'Giant Coelacanth', weight = 1000, type = 'item', image = 'giantcoelacanth.png', unique = true, useable = true, shouldClose = true, description = 'Ancient species once thought to be extinct.' },
goldenfish = { name = 'goldenfish', label = 'Golden Fish', weight = 1000, type = 'item', image = 'goldenfish.png', unique = true, useable = true, shouldClose = true, description = 'Mythical fish said to bring good fortune.' },

-- Treasure
gold_coin = { name = 'gold_coin', label = 'Gold Coin', weight = 1000, type = 'item', image = 'gold_coin.png', unique = false, useable = false, shouldClose = true, description = 'A well-preserved gold coin from a long-lost civilization.' },
vintage_watch = { name = 'vintage_watch', label = 'Vintage Pocket Watch', weight = 1000, type = 'item', image = 'vintage_watch.png', unique = false, useable = false, shouldClose = true, description = 'An ornate pocket watch from the 19th century, still ticking.' },
antique_locket = { name = 'antique_locket', label = 'Antique Silver Locket', weight = 1000, type = 'item', image = 'antique_locket.png', unique = false, useable = false, shouldClose = true, description = 'A tarnished silver locket containing a faded photograph.' },
captain_spyglass = { name = 'captain_spyglass', label = 'Captain\'s Spyglass', weight = 1000, type = 'item', image = 'captain_spyglass.png', unique = false, useable = false, shouldClose = true, description = 'An ornate brass spyglass once belonging to a famous explorer.' },
captain_compass = { name = 'captain_compass', label = 'Captain\'s Lost Compass', weight = 1000, type = 'item', image = 'captain_compass.png', unique = false, useable = false, shouldClose = true, description = 'An old compass that seems to have a mind of its own.' },
treasure_map = { name = 'treasure_map', label = 'Treasure Map', weight = 1000, type = 'item', image = 'treasure_map.png', unique = false, useable = false, shouldClose = true, description = 'An old map, hinting at the location of a legendary pirate hoard.' },
pharaohs_scarab = { name = 'pharaohs_scarab', label = 'Pharaoh\'s Scarab', weight = 1000, type = 'item', image = 'pharaohs_scarab.png', unique = false, useable = false, shouldClose = true, description = 'A large, jewel-encrusted scarab beetle, once worn by an ancient Egyptian pharaoh.' },
emperors_jade = { name = 'emperors_jade', label = 'Emperor\'s Jade', weight = 1000, type = 'item', image = 'emperors_jade.png', unique = false, useable = false, shouldClose = true, description = 'A flawless piece of imperial jade, once part of a Chinese emperor\'s collection.' },
megalodon_tooth = { name = 'megalodon_tooth', label = 'Megalodon Tooth', weight = 1000, type = 'item', image = 'megalodon_tooth.png', unique = false, useable = false, shouldClose = true, description = 'A tooth said to be from the enormous megalodon.' },
atlantean_coin = { name = 'atlantean_coin', label = 'Atlantean Coin', weight = 1000, type = 'item', image = 'atlantean_coin.png', unique = false, useable = false, shouldClose = true, description = 'A coin made of an unknown metal, bearing the image of a sunken city.' },
```
