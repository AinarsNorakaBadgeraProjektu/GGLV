Config = Config or {}
Config.UsingPhone = "yphone"
Config.PhoneItems = {
    ['yphone_natural'] = true, 
    ['yphone_black'] = true,
    ['yphone_white'] = true,
    ['yphone_blue'] = true,
    ['yflip_mint'] = true,
    ['yflip_gold'] = true,
    ['yflip_graphite'] = true,
    ['yflip_lavender'] = true,
}

CreateThread(function()
    --if GetResourceState("yphone") == "started" then
    --    Config.UsingPhone = "yphone"
    --    if IsDuplicityVersion() then
    --        Config.PhoneItems = exports['qs-smartphone-pro']:getPhoneNames()
    --    end
    --    return
    --end
end)