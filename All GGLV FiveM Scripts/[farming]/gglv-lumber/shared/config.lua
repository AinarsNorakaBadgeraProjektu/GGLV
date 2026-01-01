-- Configuration settings
Config = Config or {}
Config.debug = false

-- Notification System
Config.notification = "qbcore"  -- Options: qbcore, ox (If you have more this function can be found cl.lua line 21)

-- Progress Bar
Config.progress = "ox"  -- Options: qbcore, ox

-- Menu System
Config.menu = "ox"  -- Options: qbcore, ox

-- Fuel System
Config.fuel = "cdn-fuel" -- Export for fuel script (if using ox just put "ox")

-- Blips
Config.useBlips = true  -- true = Enabled, false = Disabled
-- Blips configuration can be found in client/blips.lua

-- ProgressBar Timers
Config.progressTime = {
    collectLog = 30, -- Seconds
    loadTruck_unload = 30,
    sellingLog = 45,
    chopping = 30,
}

-- Cool Downs
Config.coolDowns = { -- In minutes
    lumberDespawn = 1,
    chopping = 10,
}

-- Ped Model
Config.lumberModel = 'a_m_y_salton_01'
Config.lumberMillModel = 's_m_y_construct_01'

-- Coordinates
Config.lumberDepo = vector4(1167.59, -1347.38, 33.915, 267.685)
Config.deliverySuperPed = vector4(-606.472, 5311.273, 69.432, 255.341)
Config.deliveryTasker = vector4(-827.7626, 5419.7188, 33.4028, 181.3620)
Config.deliverDropOff = vector3(1239.427, -3149.191, 5.528) -- Drop Off Location for delivery task
Config.seller1 = vector4(1129.9534, -1304.9520, 33.7407, 4.2685) -- First Sale point (Firewood and Planks)
Config.seller2 = vector4(1158.5851, -1310.1917, 33.9330, 172.4857) -- Second Sale point (Toys and handles)
-- Camera Coords for NPC Diallog
Config.deliverySupervisorCam = vector4(-605.289, 5311.128, 71.00, 83.641)
Config.deliveryTaskerCam = vector4(-840.571, 5402.142, 35.315, 125.737)

-- Depo Area
Config.deliveryTruck = "phantom3" -- Truck
Config.deliveryTrailer = "trflat" -- Trailer
Config.workVan = "bison" -- Work truck
Config.WorkVanTrailer = "trailersmall" -- Bison Trailer
Config.workVanPrice = 500 -- cash
Config.returnPrice = 300 -- cash
Config.deliverySpawn = vector4(1158.62, -1330.271, 34.736, 264.758) -- Spawn point for above
Config.lumberVan = vector4(1164.155, -1317.344, 34.743, 173.472) -- Workvan Spawn

-- Transition time in seconds
Config.camTransition = 2 -- 2 seconds

-- Outline Color / distance
Config.outLine = { r = 0, g = 255, b = 0, a = 255 }
Config.outLineDistance = 20.0

-- Delivery Truck Config
Config.trailerBone = "bumper_r"
Config.maxLogs = 9 -- Log limit on the trailer
Config.logTrailerOffsets = {
    {id = 1, offset = {x = 0.0, y = 6.0, z = 0.6}},
    {id = 2, offset = {x = -1.0, y = 6.0, z = 0.6}},
    {id = 3, offset = {x = 0.0, y = 9.0, z = 0.6}},
    {id = 4, offset = {x = -1.0, y = 9.0, z = 0.6}},
    {id = 5, offset = {x = 0.0, y = 3.0, z = 0.6}},
    {id = 6, offset = {x = -1.0, y = 3.0, z = 0.6}},
    {id = 7, offset = {x = -0.5, y = 6.0, z = 0.8}},
    {id = 8, offset = {x = -0.5, y = 3.0, z = 0.8}},
    {id = 9, offset = {x = -0.5, y = 9.0, z = 0.8}}
}

-- Selling Prices
Config.sell = {
    deliveryPerLog = {90, 105},
    tr_woodplank = {100, 120},
    tr_firewood  = {90, 110},
    tr_woodhandles  = {50, 65},
    tr_toyset  = {95, 100}
}
