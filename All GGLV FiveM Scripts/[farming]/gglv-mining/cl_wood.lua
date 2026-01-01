-- gglv-mining: cl_wood.lua
local QBCore = exports['qb-core']:GetCoreObject()
local chopping = false
local axeModel = GetHashKey("weapon_battleaxe")
local choppedTrees = {} -- Glabājam nocirstos kokus ar cooldown

-- Derīgo koku modeļu saraksts
local validTrees = {
    "prop_tree_pine_01", "prop_tree_pine_02",
    "prop_tree_fallen_pine_01", "prop_tree_cedar_02",
    "prop_tree_fir_02", "prop_tree_cedar_s_02",
    "prop_tree_cedar_s_01", "prop_tree_birch_01",
    "prop_tree_cedar_03", "prop_tree_cedar_04",
    "prop_tree_mquite_01", "prop_tree_maple_03",
    "prop_tree_cedar_s_05"
}

-- Pārbauda, vai modelis ir derīgs koks
local function IsValidTree(model)
    for _, tree in ipairs(validTrees) do
        if model == GetHashKey(tree) then
            return true
        end
    end
    return false
end

-- Pievieno mijiedarbības iespēju kokiem ar ox_target
local function addTreeTargets()
    for _, tree in ipairs(validTrees) do
        exports.ox_target:addModel(GetHashKey(tree), {
            {
                event = "gglv-mining:client:startChopping",
                icon = "fas fa-tree",
                label = "Chop Tree",
                distance = 2.5,
            }
        })
    end
end
addTreeTargets() -- Pievieno target sistēmu kokiem

-- Funkcija, kas pārbauda, vai koks jau ir nocirsts un cooldown ir beidzies
local function isTreeOnCooldown(entity)
    local coords = GetEntityCoords(entity)
    local treeId = math.floor(coords.x * 1000) + math.floor(coords.y * 1000) + math.floor(coords.z * 1000)

    if choppedTrees[treeId] then
        local elapsedTime = GetGameTimer() - choppedTrees[treeId]
        if elapsedTime < (5 * 60 * 1000) then -- 5 minūšu cooldown
            return true, (5 * 60) - math.floor(elapsedTime / 1000) -- Atgriež atlikušās sekundes
        else
            choppedTrees[treeId] = nil -- Noņem ierakstu pēc cooldown
        end
    end
    return false, 0
end

-- Koka ciršanas funkcija
RegisterNetEvent('gglv-mining:client:startChopping', function(data)
    if chopping then return end

    local playerPed = PlayerPedId()
    local weapon = GetSelectedPedWeapon(playerPed)

    -- Pārbauda, vai spēlētājam ir cirvis
    if weapon ~= axeModel then
        QBCore.Functions.Notify("You need a battle axe to chop this tree!", "error")
        return
    end

    -- Pārbauda, vai spēlētājs tiešām skatās uz koku
    local entity = data.entity
    if not entity then
        QBCore.Functions.Notify("No tree found.", "error")
        return
    end

    local model = GetEntityModel(entity)
    if not IsValidTree(model) then
        QBCore.Functions.Notify("This is not a valid tree to chop.", "error")
        return
    end

    -- Pārbauda, vai koks nav cooldown
    local onCooldown, remainingTime = isTreeOnCooldown(entity)
    if onCooldown then
        QBCore.Functions.Notify("This tree is regenerating! Wait " .. remainingTime .. "s.", "error")
        return
    end

    -- Uzsāk animāciju un progress bar
    chopping = true
    TaskPlayAnim(playerPed, "melee@hatchet@streamed_core", "plyr_rear_takedown", 8.0, -8.0, -1, 49, 0, false, false, false)

    local success = lib.progressBar({
        duration = 10000, -- 10 sekundes ciršanai
        label = "Chopping Tree...",
        useWhileDead = false,
        canCancel = false,
        disable = { combat = true, movement = true, car = true },
    })

    ClearPedTasks(playerPed) -- Beidz animāciju
    chopping = false

    if success then
        -- Atzīmē koku kā nocirstu un ieliek cooldown
        local treeCoords = GetEntityCoords(entity)
        local treeId = math.floor(treeCoords.x * 1000) + math.floor(treeCoords.y * 1000) + math.floor(treeCoords.z * 1000)
        choppedTrees[treeId] = GetGameTimer()

        -- Nosūta pieprasījumu uz serveri, lai piešķirtu spēlētājam koka baļķi
        TriggerServerEvent('gglv-lumber:server:choptree')
        QBCore.Functions.Notify("You successfully chopped the tree!", "success")
    else
        QBCore.Functions.Notify("Tree chopping was canceled!", "error")
    end
end)

-- Animāciju ielāde
CreateThread(function()
    RequestAnimDict("melee@hatchet@streamed_core")
    while not HasAnimDictLoaded("melee@hatchet@streamed_core") do
        Wait(100)
    end
end)
