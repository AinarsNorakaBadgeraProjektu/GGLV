if Config.Billing ~= "okokBilling" then
    return
end

function CreateBill(amount, text)
    -- TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(PlayerId()), tonumber(amount), text, 'Traffic Radar', 'police', 'Police') -- if you using okokBilling you can uncomment this line
    DebugPrint("Creating bill for " .. amount .. " with text " .. text) 
    TriggerServerEvent('qs-billing:server:CreateInvoice', GetPlayerServerId(PlayerId()), 'Traffic Radar', text, tonumber(amount), true, false, true, false, 'society_police')
end