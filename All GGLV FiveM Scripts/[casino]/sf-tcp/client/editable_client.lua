function UpdateBet(betIndex)

end


function GetTcpId(data)
    for index, tcp in ipairs(Config.Tables) do
		if(#(vector3(tcp.coords.x, tcp.coords.y, tcp.coords.z) - data.coords) <= 0.5 and tcp.model == data.model) then
			return index
		end
        if(index % 20 == 0) then
            Citizen.Wait(0)
        end
	end
end

RegisterNetEvent("sf-tcp:gameEnd", function()
	CurrentTable.handMode = false
	SendAppAction("setBet", CurrentTable.betAmount)
	SendAppAction("setTime", CurrentTable.timeLeft)
	SendAppAction("setText", { bet = _L("ante_bet"), last_win = _L("time_left") })
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
			label = _L("place_bet")
		},
	})
	SendAppAction("setDisplayTop", true)
end)

RegisterNetEvent("sf-tcp:setPairbet", function()
	SendAppAction("setText", { bet = _L("pair_bet"), last_win = _L("time_left") })
end)

RegisterNetEvent("sf-tcp:hideTop", function()
	if(not CurrentTable.handMode) then
		CurrentTable.handMode = true
		SendAppAction("setDisplayTop", false)
	end
end)

function SetHUDState(state)
	if(state) then
		CurrentTable.handMode = false
		SendAppAction("setBet", 0)
		SendAppAction("setTime", "00:00")
		SendAppAction("setText", { bet = _L("ante_bet"), last_win = _L("time_left") })
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
				label = _L("place_bet")
			},
		})
		SendAppAction("setDisplayTop", true)
	end
	SendAppAction("setVisible", state)
end

function UpdateHUDValue(key, value)
	if(key == "bet") then
		SendAppAction("setBet", value)
	elseif(key == "time_left") then
		local minutes = math.floor(value/60)
		local seconds = value - minutes*60
		SendAppAction("setTime", string.format("%02d:%02d", minutes, seconds))
	end
end

RegisterNetEvent("sf-tcp:addNotification", function(message)
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
        ShowNotification("Casino tcp", notification, "")
    end
end


function ShowNotification(title, subtitle, message, backgroundColor, notifImage, iconType, durationMult)
	AddTextEntry('tcpNotification', message)
    BeginTextCommandThefeedPost("tcpNotification")
    if(backgroundColor) then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle, durationMult)
    return EndTextCommandThefeedPostMpticker(false, true)
end

function ShowHelpNotification(message, thisFrame, beep, duration)
	AddTextEntry("tcpHelpNotification", message)
	if(thisFrame) then
		DisplayHelpTextThisFrame("tcpHelpNotification", false)
	else
		BeginTextCommandDisplayHelp("tcpHelpNotification")
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

RegisterClientCallback("sf-tcp:requestAction", function()
	CurrentTable.busy = true
	local keys = {
		{
			keys = { "␣" },
			label = _L("fold")
		},
		{
			keys = { "↵" },
			label = _L("play")
		},
	}
	SendAppAction("setKeys", keys)
	local time = GetGameTimer()
	local choice = false
	while true do
		if(GetGameTimer() - time > (30 * 1000)) then break end
		if(IsControlJustPressed(0, Config.Controls["play"])) then
			choice = true
			break
		end
		if(IsControlJustPressed(0, Config.Controls["fold"])) then
			choice = false
			break
		end
		Citizen.Wait(0)
	end
	CurrentTable.busy = false
	return choice
end)