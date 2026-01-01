local QBCore = exports['qb-core']:GetCoreObject()
local playerData = {}
local createdTargets = {}

local function createTargets()
    for i, loc in pairs(Config.Locations) do
        if playerData.job and playerData.job.name == loc.job and playerData.job.grade.level >= loc.grade then
            if not createdTargets[i] then
                createdTargets[i] = true
                exports.ox_target:addBoxZone({
                    coords = loc.coords,
                    size = vec3(1, 1, 1),
                    rotation = 0.0,
                    debug = false,
                    options = {
                        {
                            name = 'secret_cabinet_' .. i,
                            label = loc.label,
                            icon = 'fas fa-pills',
                            onSelect = function()
                                TriggerServerEvent('gglv-illegaljobs:attemptTake', i)
                            end
                        }
                    }
                })
            end
        else
            if createdTargets[i] then
                exports.ox_target:removeZone('secret_cabinet_' .. i)
                createdTargets[i] = nil
            end
        end
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    playerData = QBCore.Functions.GetPlayerData()
    createTargets()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    playerData = {}
    for i in pairs(createdTargets) do
        exports.ox_target:removeZone('secret_cabinet_' .. i)
        createdTargets[i] = nil
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    playerData.job = job
    createTargets()
end)

CreateThread(function()
    while not QBCore.Functions.GetPlayerData().job do
        Wait(500)
    end
    playerData = QBCore.Functions.GetPlayerData()
    createTargets()
end)

RegisterNetEvent('gglv-illegaljobs:notify', function(message, type)
    lib.notify({ description = message, type = type or 'inform' })
end)
