# CC Fishing (cc-fishing)
* Tebex: https://store.cc-scripts.com/
* Discord: http://discord.cc-scripts.com/

# Dependencies
* [PolyZone](https://github.com/mkafrin/PolyZone)
* [ox_lib](https://github.com/overextended/ox_lib)
* [oxmysql](https://github.com/overextended/oxmysql)

# Options
* Inventory (QB/OX/PS/Custom)
* Target (qb-target / ox_target)
* Menu (qb-menu / ox_lib)
* Progress (progressbar / ox_lib)
* Net Prop (cc-fishnets / custom)
* Minigame (cc-fishgame)

# Installation
* Add items from ITEMS_QB.md/ITEMS_OX.md to shared/items.lua or ox_inventory/data/items.lua
* Drag and drop the item images to your inventory image directory
* Download and install the fishing minigame from your Keymaster
* Download and install the fishing net prop from your Keymaster
* Run the SQL file (database.sql) in your server database
* Configure the script to your liking in shared/config.lua

# OPTIONAL: If using qs-inventory, add this to qs-inventory/config/metadata.js
```js
} else if (itemData.name == "salmon" || itemData.name == "trout" || itemData.name == "bass" ||
           itemData.name == "catfish" || itemData.name == "perch" || itemData.name == "pike" ||
           itemData.name == "carp" || itemData.name == "bluegill" || itemData.name == "cod" ||
           itemData.name == "herring" || itemData.name == "walleye" || itemData.name == "bream" ||
           itemData.name == "zander" || itemData.name == "sturgeon" || itemData.name == "swordfish" ||
           itemData.name == "tuna" || itemData.name == "muskellunge" || itemData.name == "tarpon" ||
           itemData.name == "giantcatfish" || itemData.name == "whale" || itemData.name == "shark" ||
           itemData.name == "eel" || itemData.name == "arapaima" || itemData.name == "giantsnakehead" ||
           itemData.name == "goliathtigerfish" || itemData.name == "devilray" || itemData.name == "kraken" ||
           itemData.name == "megalodon" || itemData.name == "giantcoelacanth" || itemData.name == "goldenfish") {
    $(".item-info-title").html("<p>" + `${itemData.info.label || label}` + "</p>");
    $(".item-info-description").html(
        "<p>Length: " + itemData.info.length + "\"</p>"
    );
```
