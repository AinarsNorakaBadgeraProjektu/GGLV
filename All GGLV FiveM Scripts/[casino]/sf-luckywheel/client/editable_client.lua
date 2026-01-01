Citizen.CreateThread(function()
	Citizen.Wait(1000)
	TriggerServerEvent("sf-luckywheel:playerLoaded")
    Citizen.Wait(1000)
    OnPlayerLoaded()
end)

RegisterNetEvent("sf-luckywheel:showNotification", function(message)
	HudAddNotification(message)
end)

if(GetResourceState("es_extended") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("esx:showNotification", notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function HudAddNotification(notification)
        TriggerEvent("QBCore:Notify", notification)
    end
else
	function HudAddNotification(notification)
        ShowNotification("Casino Lucky Wheel", notification, "")
    end
end

function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('luckyWheelNotification', message)
    BeginTextCommandThefeedPost("luckyWheelNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("luckyWheelHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("luckyWheelHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("luckyWheelHelpNotification")
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

AddEventHandler("sf-luckywheel:onChange", function()
    local items = GetInventoryItems()
    SendAppAction("setAvailableItems", items)
	SendAppAction("setLocales", Locales[Language])
    SendAppAction("setItems", WheelRewards)
	SendAppAction("setVisible", true)
	SetNuiFocus(true, true)
end)

RegisterNUICallback("sf-luckywheel:exit", function(data, cb)
    SendAppAction("setVisible", false)
    SetNuiFocus(false, false)
	cb({})
end)

HasPermission = true

RegisterNetEvent("sf-luckywheel:canChangeWheel", function(hasPermission)
    HasPermission = hasPermission
end)

function CanChangeWheel()
    -- REMEMBER TO IMPLEMENT YOUR LOGIC HERE OR SET IT TO FALSE!!!!
	return HasPermission
end

local yourItems = {}

-- here you can implement stash logic etc
function GetInventoryItems()
    if(not next(yourItems)) then 
        GetAllItems()
    end
    return yourItems
end

function GetAllItems()
    if(GetResourceState("ox_inventory") ~= "missing") then
        local oxItems = exports['ox_inventory']:Items()
        for k, v in pairs(oxItems) do
            yourItems[k] = v.label
        end
    elseif(GetResourceState("qs-inventory") ~= "missing") then
        local oxItems = exports['qs-inventory']:GetItemList()
        for k, v in pairs(oxItems) do
            yourItems[k] = v.label
        end
    elseif(GetResourceState("es_extended") ~= "missing") then
        yourItems = TriggerServerCallback("sf-luckywheel:getESXItems")
        yourItems["money"] = "Money"
    elseif(GetResourceState("qb-core") ~= "missing") then
        local QBCore = exports['qb-core']:GetCoreObject()
        if(not QBCore) then return end
        local qbItems = QBCore.Shared.Items
        for k, v in pairs(qbItems) do
            yourItems[k] = v.label
        end
        yourItems["money"] = "Money"
    end
end

function ShouldExit()
	-- here you can apply your own dead logic to automatically exit game (It checks every 500ms)
	return false
end

AddEventHandler("sf-luckywheel:showHelp", function(state)
    if(state) then
        HudAddNotification(_L("press_lmb_to_spin"))
    end
end)

Citizen.CreateThread(function()
	while true do
		if(#(WheelCoords.xyz - GetEntityCoords(PlayerPedId())) < 150.0 and GetInteriorFromEntity(PlayerPedId()) ~= 0) then
			InCasino = true
			PrepareLuckyWheel()
		else
			InCasino = false
			RemoveLuckyWheel()
		end
		Citizen.Wait(500)
	end
end)

function OnPlayerLoaded()
	CreateInteraction("casino_wheel", {
		coords = WheelCoords.xyz,
		notify = _L("use_help_standalone") .. (CanChangeWheel() and ("~n~".._L("change_help_standalone")) or ""),
		range = StandaloneRange,
		controls = {
			{
                disabled = StandaloneControls["use"].disabled,
                key = StandaloneControls["use"].key,
                action = function()
					TriggerEvent("sf-luckywheel:onUse")
				end
            },
			{
                disabled = StandaloneControls["change_wheel"].disabled,
                key = StandaloneControls["change_wheel"].key,
                action = function()
					if(not CanChangeWheel()) then return end
					TriggerEvent("sf-luckywheel:onChange")
				end
            },
        }
	}, {
		zone = {
			coords = WheelCoords,
			length = 1.0,
			width = 3.0,
			minZ = WheelCoords.z - 2.0,
			maxZ = WheelCoords.z + 2.0
		},
		options = {
            {
                icon = "fas fa-hands",
                label = _L("use_wheel"),
                action = function()
					TriggerEvent("sf-luckywheel:onUse")
				end
            },
			{
                icon = "fas fa-wrench",
                label = _L("change_wheel"),
                action = function()
					TriggerEvent("sf-luckywheel:onChange")
				end,
				canInteract = function()
					return CanChangeWheel()
				end
            },
        }
	})
end