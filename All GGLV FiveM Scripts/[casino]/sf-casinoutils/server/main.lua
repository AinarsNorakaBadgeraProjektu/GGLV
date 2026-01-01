AddEventHandler("sf-casinoutils:playAnnounce", function(name)
	TriggerClientEvent("sf-casinoutils:announcement", -1, name)
end)

if(GetResourceState("es_extended") ~= "missing") then
    function ShowNotification(source, notification)
        TriggerClientEvent("esx:showNotification", source, notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function ShowNotification(source, notification)
        TriggerClientEvent("QBCore:Notify", source, notification)
    end
else
	function ShowNotification(source, notification)
        TriggerClientEvent("sf-roulette:addNotification", source, notification)
    end
end


if(Society.enable and Society.registerSociety.enable and GetResourceState("esx_society") ~= "missing") then
    Citizen.CreateThread(function()
        local jobName = Society.registerSociety.jobName
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..jobName, function(account)
            if(not account) then
                exports['esx_addonaccount']:AddSharedAccount({ name = "society_"..jobName, label = Society.registerSociety.label })
            end
        end)
        TriggerEvent("esx_society:registerSociety", jobName, jobName, "society_"..jobName, "society_"..jobName, "society_"..jobName, { type = Society.registerSociety.type })
    end)
end