local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('gglv-mining:useStone', function()
    local ped = PlayerPedId()
    if IsEntityInWater(ped) and not IsPedSwimming(ped) then
        local animDict = 'amb@world_human_bum_wash@male@high@idle_a'
        local animName = 'idle_a'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
        local stoneModel = `prop_rock_5_smash1`
        RequestModel(stoneModel)
        while not HasModelLoaded(stoneModel) do
            Wait(10)
        end
        local stoneProp = CreateObject(stoneModel, GetEntityCoords(ped), true, true, false)
        AttachEntityToEntity(stoneProp, ped, GetPedBoneIndex(ped, 60309), 0.1, 0.0, 0.05, 90.0, -90.0, 90.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 49, 0, false, false, false)
        local success = lib.progressBar({
            duration = 15000,
            label = 'Washing the stone...',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
        })
        ClearPedTasks(ped)
        DeleteObject(stoneProp)
        SetModelAsNoLongerNeeded(stoneModel)
        if success then
            TriggerServerEvent('gglv-mining:washStone')
        end
    else
        QBCore.Functions.Notify('You must be in water to wash the stones!', 'error')
    end
end)
