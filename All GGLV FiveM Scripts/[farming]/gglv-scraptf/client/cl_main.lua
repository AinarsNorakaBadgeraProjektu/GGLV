-- client.lua
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('gglv-scraptf:steal', function(scrapObj, entity, securityToken)
    local pos = GetEntityCoords(PlayerPedId())
    local clientToken = securityToken
    local toolName = 'oxycutter'
    local hasItem = exports.ox_inventory:Search('count', Config.ItemNeeded) >= 1

    if hasItem then
        QBCore.Functions.TriggerCallback('gglv-scraptf:GetCops', function(copCount)
            if copCount >= Config.MinCops then
                -- Alert Cops
                if math.random() <= Config.CopsChance then
                    TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                        job = { 'police', 'sheriff', 'traffic', 'patrol' },
                        callLocation = pos,
                        callCode = { code = '0-10', snippet = 'Vehicle Pursuit' },
                        message = 'Scrap Material Theft reported at location.',
                        flashes = true,
                        blip = {
                            sprite = 488,
                            scale = 1.5,
                            colour = 1,
                            flashes = true,
                            text = 'Scrap Material Theft reported at location.',
                            time = 20000,
                        }
                    })
                end

                -- Progress Bar
                if lib.progressBar({
                    duration = Config.ScrapTime,
                    label = 'Stealing Scrap',
                    useWhileDead = false,
                    canCancel = true,
                    anim = {
                        scenario = 'WORLD_HUMAN_WELDING',
                        duration = Config.ScrapTime,
                    },
                    disable = {
                        move = true,
                    },
                }) then
                    TriggerServerEvent('gglv-scraptf:removescrap', entity)
                    TriggerServerEvent('gglv-scraptf:reward', scrapObj, clientToken)
                    ClearPedTasks(PlayerPedId())
                end
            else
                lib.notify({type = 'error', description = 'Not enough cops online', duration = 5000})
            end
        end)
    else
        lib.notify({type = 'error', description = 'You need a ' .. Config.ItemNeeded .. ' to do this.', duration = 5000})
    end
end)

-- Target Exports: Get all the objects from the config and add them to ox_target
CreateThread(function()
    for i = 1, #Config.ScrapObjects do
        local scrapObj = Config.ScrapObjects[i]
        exports.ox_target:addModel(scrapObj.name, {
            {
                icon = 'fa-solid fa-screwdriver-wrench',
                label = 'Steal Scraps',
                onSelect = function(data)
                    TriggerServerEvent('gglv-scraptf:checkifscrapped', scrapObj, data.entity)
                end,
            },
        })
    end
end)

