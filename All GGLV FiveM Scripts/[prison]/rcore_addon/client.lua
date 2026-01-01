local QBCore = exports['qb-core']:GetCoreObject()
local cookingStage = {}
local lastCookTime = {}
local cooldown = 600 -- 10 minūtes

local cookingSpots = {
    {coords = vector3(1713.37, 2570.15, 45.68), stage = 1, anim = {dict = 'anim@heists@ornate_bank@grab_cash', name = 'grab'}},
    {coords = vector3(1716.89, 2575.24, 45.39), stage = 2, anim = {dict = 'amb@prop_human_bum_bin@idle_a', name = 'idle_a'}},
    {coords = vector3(1716.79, 2578.47, 45.83), stage = 3, anim = {dict = 'anim@amb@business@cfm@cfm_cut_sheets@', name = 'cut_sheets'}}
}

for _, spot in pairs(cookingSpots) do
    exports.ox_target:addSphereZone({
        coords = spot.coords,
        radius = 1.5,
        options = {
            {
                name = 'prison_cook_' .. spot.stage,
                event = 'prison:makeFood',
                icon = 'fa-solid fa-utensils',
                label = 'Pagatavot ēdienu',
                spot = spot.stage,
                anim = spot.anim
            }
        }
    })
end

RegisterNetEvent('prison:makeFood', function(data)
    local player = PlayerPedId()
    local src = source
    local playerId = GetPlayerServerId(NetworkGetEntityOwner(player))
    local isPrisoner = exports['rcore_prison']:IsPrisoner(playerId)

    if not isPrisoner then
        QBCore.Functions.Notify('Tu neesi cietumnieks!', 'error')
        return
    end

    local currentTime = GetGameTimer() / 1000
    if lastCookTime[src] and currentTime - lastCookTime[src] < cooldown then
        QBCore.Functions.Notify('Tu vari mēģināt atkal pēc 10 minūtēm!', 'error')
        return
    end

    if not cookingStage[src] then
        cookingStage[src] = 0
    end

    if cookingStage[src] + 1 == data.spot then
        cookingStage[src] = data.spot
        QBCore.Functions.Notify('Tu esi paveicis ' .. data.spot .. '. soli!', 'success')
        
        -- Spēlētāja animācija un progressbar
        local animDict = data.anim.dict
        local animName = data.anim.name
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
        TaskPlayAnim(player, animDict, animName, 8.0, -8.0, 5000, 49, 0, false, false, false)
        exports.ox_lib:progressBar({
            duration = 5000,
            label = 'Gatavo ēdienu...',
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                combat = true
            }
        })
        ClearPedTasks(player)
        
        if data.spot == 3 then
            TriggerServerEvent('prison:giveFood')
            lastCookTime[src] = currentTime
            cookingStage[src] = nil
        end
    else
        QBCore.Functions.Notify('Tev jāseko pareizai kārtībai!', 'error')
    end
end)