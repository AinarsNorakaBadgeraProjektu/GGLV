# Project X K4MB1 Bobcat Heist

## Links

[Discord](https://discord.gg/bJNxYDAm5u)
[Store](https://www.projectx.gg)

## Dependencies

[ox_lib](https://github.com/overextended/ox_lib)
[K4MB1-Bobcat](https://www.k4mb1maps.com/product/6136428)
[Minigames-zip](https://drive.google.com/file/d/1EfG_hcQeSiUZZNfMNRgu2nozUHKeLSzS/view?usp=sharing)

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

### Images done by Artwork Inventory

[Discord](https://discord.gg/Z2awpnXKdw) -- Use code ProjectX for 10% off!

-- For qb-inventory:

```lua
    ['x_device']          = {['name'] = 'x_device',           ['label'] = 'X Device',    ['weight'] = 50,   ['type'] = 'item',         ['image'] = 'x_device.png',        ['unique'] = true,       ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = '?????????'},
    ['bag']                  = {['name'] = 'bag',                   ['label'] = 'Bag',                ['weight'] = 400,   ['type'] = 'item',         ['image'] = 'bag.png',                ['unique'] = true,       ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'Duffel bag'},
    ['pliers']                = {['name'] = 'pliers',                ['label'] = 'Pliers',          ['weight'] = 200,    ['type'] = 'item',          ['image'] = 'pliers.png',         ['unique'] = false,         ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = 'Pliers..?'},    
    ['x_phone']           = {['name'] = 'x_phone',               ['label'] = 'X Phone',        ['weight'] = 50,     ['type'] = 'item',          ['image'] = 'x_phone.png',        ['unique'] = true,         ['useable'] = false,     ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = '?????????'},
    ['bobcatcard']                = {['name'] = 'bobcatcard',            ['label'] = 'Bobcat Keycard A',    ['weight'] = 200,   ['type'] = 'item',         ['image'] = 'bobcatcard.png',               ['unique'] = false,      ['useable'] = false,    ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ""}, 
    ['bobcatcard2']            = {['name'] = 'bobcatcard2',            ['label'] = 'Bobcat Keycard B',    ['weight'] = 200,   ['type'] = 'item',         ['image'] = 'bobcatcard2.png',              ['unique'] = false,      ['useable'] = false,    ['shouldClose'] = false,     ['combinable'] = nil,   ['description'] = ""}, 

```

-- For ox_inventory:

```lua

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

   ["x_phone"] = {
  label = "x Phone",
  weight = 300,
  stack = false,
  close = false,
  description = "?????????",
  client = {
   image = "x_phone.png",
  }
 },

  ["bobcatcard"] = {
  label = "Bobcat Keycard A",
  weight = 50,
  stack = false,
  close = false,
  description = "A Security card for Bobcat",
  client = {
   image = "bobcatcard.png",
  }
 },

  ["bobcatcard2"] = {
  label = "Bobcat Keycard B",
  weight = 50,
  stack = false,
  close = false,
  description = "A Security card for Bobcat",
  client = {
   image = "bobcatcard2.png",
  }
 },
```
