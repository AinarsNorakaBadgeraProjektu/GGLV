function SetHUDState(state)
	if(state) then
		SendAppAction("setBet", 0)
		SendAppAction("setLastWin", 0)
		SendAppAction("setText", { bet = _L("bet"), last_win = _L("last_win") })
		SendAppAction("setKeys", {
			{
				keys = { "↓", "↑" },
				label = _L("change_bet")
			},
			{
				keys = { "←", "→" },
				label = _L("min_max_bet")
			},
			{
				keys = { "↵" },
				label = _L("use_slot")
			},
		})
	end
	SendAppAction("setVisible", state)
	SendAppAction("setDisplayTop", true)
end

function UpdateHUDValue(key, value)
	if(key == "bet") then
		SendAppAction("setBet", value)
	elseif(key == "last_win") then
		SendAppAction("setLastWin", value)
	end
end

RegisterNetEvent("sf-slots:showNotification", function(message)
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
        ShowNotification("Casino Slots", notification, "")
    end
end

function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('slotsNotification', message)
    BeginTextCommandThefeedPost("slotsNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("slotsHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("slotsHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("slotsHelpNotification")
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function SendAppAction(action, payload)
    SendNUIMessage({
        event = "sendAppEvent",
        app = "os",
        action = action,
        payload = payload,
    })
end

function ShouldExit()
	-- here you can apply your own dead logic to automatically exit game (It checks every 500ms)
	return false
end