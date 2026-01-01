# Project X Gabz Fleeca Bank Robbery

## Links

[Discord](https://discord.gg/bJNxYDAm5u)
[Store](https://www.projectx.gg)

## Dependencies

[ox_lib](https://github.com/overextended/ox_lib)
[Gabz-Maps-Subscription](https://fivem.gabzv.com/category/subscription)
[Zip-With-All-Minigames-Required](https://drive.google.com/file/d/1v_UFkM18Ji2LkdVX_aYQyinc7XdneqKb/view?usp=sharing)

### Required Dependencies if you want to use the script as is

[QBCore-QBOX]
[ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)

[ESX]
[linden_outlawalert](https://github.com/thelindat/linden_outlawalert)

### Installation

- Step 1: Extract the script from the zip file and place it into your scripts folder.
- Step 2: Add the minigames that are found in the zip file above into your standalone/dependencies folder (Make sure they are not in the same folder as the robbery script).
- Step 3: Add the items from below and the images from the images folder to your inventory.
- Step 4: Configure the config.lua file to work with your server by changing the Framework, Inventory, Dispatch, Target name.
- Step 5: Make sure that the Framework, ox_lib, your Target, Dispatch, Inventory, and Minigames are started before the robbery script.

### Add this to the server.cfg

```lua
  ensure ox_lib -- This should be placed under ensure qb-core in your server.cfg, if you just downloaded it
```

### How to remove the props inside the vault

1) Go to your maps folder
2) Find cfx-gabz-mapdata
3) Open gabz_entityset_mods1
4) Search for fleeca (<https://imgur.com/nYKgnKB>)
5) Switch enable to false in each one of them

### Images done by Artwork Inventory

[Discord](https://discord.gg/Z2awpnXKdw) -- Use code ProjectX for 10% off!

-- For qb-inventory:

```lua
    ['fleeca_key']               = {['name'] = 'fleeca_key',               ['label'] = 'Fleeca Key',        ['weight'] = 50,     ['type'] = 'item',          ['image'] = 'fleeca_key.png',           ['unique'] = true,          ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Key!'},
    ['employeepictures']             = {['name'] = 'employeepictures',              ['label'] = 'Employee Pictures',       ['weight'] = 25,        ['type'] = 'item',          ['image'] = 'employeepictures.png',       ['unique'] = false,         ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Faces of employees'},
    ['fleecacard']                     = {['name'] = 'fleecacard',                  ['label'] = 'Fleeca Keycard',           ['weight'] = 25,        ['type'] = 'item',          ['image'] = 'fleecacard.png',           ['unique'] = false,         ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'A Security card for Fleeca Bank'},
    ['x_laptop']          = {['name'] = 'x_laptop',           ['label'] = 'X Laptop',    ['weight'] = 50,   ['type'] = 'item',         ['image'] = 'x_laptop.png',        ['unique'] = true,       ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = '?????????'},
    ['x_device']          = {['name'] = 'x_device',           ['label'] = 'X Device',    ['weight'] = 50,   ['type'] = 'item',         ['image'] = 'x_device.png',        ['unique'] = true,       ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = '?????????'},
    ['pliers']                = {['name'] = 'pliers',                ['label'] = 'Pliers',          ['weight'] = 200,    ['type'] = 'item',          ['image'] = 'pliers.png',         ['unique'] = false,         ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Pliers..?'},
    ['bag']                  = {['name'] = 'bag',                   ['label'] = 'Bag',                ['weight'] = 400,   ['type'] = 'item',         ['image'] = 'bag.png',                ['unique'] = true,       ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'Duffel bag'},

```

-- For ox_inventory:

```lua
 ["fleeca_key"] = {
  label = "Fleeca Key",
  weight = 50,
  stack = false,
  close = false,
  description = "Key!",
  client = {
   image = "fleeca_key.png",
  }
 },

 ["employeepictures"] = {
  label = "Employee Pictures",
  weight = 25,
  stack = false,
  close = false,
  description = "Faces of employees",
  client = {
   image = "employeepictures.png",
  }
 },

 ["pliers"] = {
  label = "Pliers",
  weight = 125,
  stack = false,
  close = false,
  description = "A pair of pliers",
  client = {
   image = "pliers.png",
  }
 },

  ["x_device"] = {
  label = "Flapper Hero",
  weight = 125,
  stack = false,
  close = false,
  description = "?????????",
  client = {
   image = "x_device.png",
  }
 },

  ["bag"] = {
  label = "Duffel Bag",
  weight = 250,
  stack = false,
  close = false,
  description = "Duffel bag",
  client = {
   image = "bag.png",
  }
 },

 ["x_laptop"] = {
  label = "X Laptop",
  weight = 50,
  stack = false,
  close = false,
  description = "?????????",
  client = {
   image = "x_laptop.png",
  }
 },

 ["fleecacard"] = {
  label = "Fleeca Card",
  weight = 300,
  stack = false,
  close = false,
  description = "A Security card for Fleeca Bank",
  client = {
   image = "fleecacard.png",
  }
 },
 ```
