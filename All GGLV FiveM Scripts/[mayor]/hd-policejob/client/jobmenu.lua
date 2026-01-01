RegisterNetEvent('hd-policejob:client:OpenJobmenu', function()
    local JobMenu = {}
    JobMenu[#JobMenu+1] = {opthead = Lang:t('polmenu.object_menu'), optdesc = '', opticon = 'caret-right',
        optparams = { event = 'police:client:OpenObjectMenu', args = {}}}
    JobMenu[#JobMenu+1] = {opthead = Lang:t('polmenu.actions'), optdesc = '', opticon = 'caret-right',
        optparams = { event = 'police:client:OpenActionMenu', args = {}}}
    JobMenu[#JobMenu+1] = {opthead = Lang:t('polmenu.traffic_menu'), optdesc = '', opticon = 'caret-right',
        optparams = { event = 'police:client:OpenTrafficMenu', args = {}}}
    JobMenu[#JobMenu+1] = {opthead = Lang:t('polmenu.cammenu'), optdesc = '', opticon = 'caret-right',
        optparams = { event = 'police:client:OpenCamMenu', args = {}}}
    
    JobMenu[#JobMenu+1] = {opthead = Lang:t('menu.close_x'), opticon = 'xmark', optparams = {event = ''}}

    local header = {
        disabled = true,
        header = Lang:t('polmenu.header'),
        headerid = 'police_job_menu', -- unique
        desc = '',
        icon = 'handcuffs'
    }
    ContextSystem.Open(header, JobMenu)
end)

RegisterNetEvent('police:client:OpenActionMenu', function()
    local ActionMenu = {}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.back'), optdesc = '', opticon = 'caret-left',
        optparams = { event = 'hd-policejob:client:OpenJobmenu', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.checkstatus'), optdesc = '', opticon = 'question',
        optparams = { event = 'police:client:CheckStatus', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.takegsr'), optdesc = '', opticon = 'vial',
        optparams = { event = 'hd-policejob:client:StartGSRTest', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.escort'), optdesc = '', opticon = 'user-group',
        optparams = { event = 'police:client:EscortPlayer', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.search'), optdesc = '', opticon = 'magnifying-glass',
        optparams = { event = 'police:client:JMSearchPlayer', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.jail'), optdesc = '', opticon = 'user-lock',
        optparams = { event = 'police:client:JailPlayer', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.resetlock'), optdesc = '', opticon = 'key',
        optparams = { event = 'qb-houses:client:ResetHouse', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.takedl'), optdesc = '', opticon = 'id-card',
        optparams = { event = 'police:client:SeizeDriverLicense', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.putinveh'), optdesc = '', opticon = 'taxi',
        optparams = { event = 'police:client:PutPlayerInVehicle', args = {}}}
    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('polmenu.takeoutveh'), optdesc = '', opticon = 'taxi',
        optparams = { event = 'police:client:SetPlayerOutVehicle', args = {}}}

    ActionMenu[#ActionMenu+1] = {opthead = Lang:t('menu.close_x'), opticon = 'xmark', optparams = {event = ''}}

    local header = {
        disabled = true,
        header = Lang:t('polmenu.actionheader'),
        headerid = 'police_action_menu', -- unique
        desc = '',
        icon = 'person'
    }
    ContextSystem.Open(header, ActionMenu)
end)

RegisterNetEvent('police:client:OpenTrafficMenu', function()
    local TrafficMenu = {}
    TrafficMenu[#TrafficMenu+1] = {opthead = Lang:t('polmenu.back'), optdesc = '', opticon = 'caret-left',
        optparams = { event = 'hd-policejob:client:OpenJobmenu', args = {}}}
    TrafficMenu[#TrafficMenu+1] = {opthead = Lang:t('polmenu.slowtraffic'), optdesc = '', opticon = 'gauge',
        optparams = { event = 'police:client:placeProp', args = {object = "slowtraffic", speed = 'slow'}}}
    TrafficMenu[#TrafficMenu+1] = {opthead = Lang:t('polmenu.stoptraffic'), optdesc = '', opticon = 'gauge',
        optparams = { event = 'police:client:placeProp', args = {object = "stoptraffic", speed = 'stop'}}}
    TrafficMenu[#TrafficMenu+1] = {opthead = Lang:t('polmenu.flagplate'), optdesc = '', opticon = 'flag',
        optparams = { event = 'hd-policejob:client:FlagPlateInput', args = {}}}
    TrafficMenu[#TrafficMenu+1] = {opthead = Lang:t('polmenu.flagplateinfo'), optdesc = '', opticon = 'list-ul',
        optparams = { event = 'hd-policejob:client:FlagPlateInfo', args = {}}}
    TrafficMenu[#TrafficMenu+1] = {opthead = Lang:t('menu.close_x'), opticon = 'xmark', optparams = {event = ''}}

    local header = {
        disabled = true,
        header = Lang:t('polmenu.trafficheader'),
        headerid = 'police_traffic_menu', -- unique
        desc = '',
        icon = 'person'
    }
    ContextSystem.Open(header, TrafficMenu)
end)

RegisterNetEvent('police:client:OpenCamMenu', function()
    local CamMenu = {}
    CamMenu[#CamMenu+1] = {opthead = Lang:t('polmenu.back'), optdesc = '', opticon = 'caret-left',
        optparams = { event = 'hd-policejob:client:OpenJobmenu', args = {}}}
    CamMenu[#CamMenu+1] = {opthead = Lang:t('polmenu.openbcam'), optdesc = Lang:t('polmenu.openbcamdesc'), opticon = 'camera',
        optparams = { event = 'hd-policejob:client:openActiveBodyCamera', args = {}}}
    CamMenu[#CamMenu+1] = {opthead = Lang:t('polmenu.openrecords'), optdesc = Lang:t('polmenu.openrecordsdesc'), opticon = 'list',
        optparams = { event = 'hd-policejob:client:openRecordsList', args = {}}}
    CamMenu[#CamMenu+1] = {opthead = Lang:t('polmenu.viewcam'), optdesc = Lang:t('polmenu.viewcamdesc'), opticon = 'camera',
        optparams = { event = 'hd-policejob:client:ViewCamInput', args = {}}}

    CamMenu[#CamMenu+1] = {opthead = Lang:t('menu.close_x'), opticon = 'xmark', optparams = {event = ''}}

    local header = {
        disabled = true,
        header = Lang:t('polmenu.cammenu'),
        headerid = 'police_camera_menu', -- unique
        desc = '',
        icon = 'sign-in-alt'
    }
    ContextSystem.Open(header, CamMenu)
end)

RegisterNetEvent('hd-policejob:client:FlagPlateInfo', function()
    QBCore.Functions.TriggerCallback('hd-policejob:server:getFlaggedPlates', function(plates)
        if plates then
            local PlateMenu = {}
            PlateMenu[#PlateMenu+1] = {opthead = Lang:t('polmenu.back'), optdesc = '', opticon = 'caret-left', optparams = { event = 'police:client:OpenTrafficMenu', args = {}}}
            for k,v in pairs(plates) do
                PlateMenu[#PlateMenu+1] = {opthead = k, optdesc = Lang:t('polmenu.reason') .." : ".. v.reason, opticon = 'caret-right', optparams = { event = 'hd-policejob:client:UnFlagPlateMenu', args = k}}
            end
            local header = {
                disabled = true,
                header = Lang:t('polmenu.flagplateinfo'),
                headerid = 'police_flagplate_menu', -- unique
                desc = '',
                icon = 'flag'
            }
            ContextSystem.Open(header, PlateMenu)
        else

        end
    end)
end)

RegisterNetEvent('hd-policejob:client:UnFlagPlateMenu', function(plate)
    if not plate then return end
    local UnFlagMenu = {}
    UnFlagMenu[#UnFlagMenu+1] = {opthead = Lang:t('polmenu.back'), optdesc = '', opticon = 'caret-left', optparams = { event = 'hd-policejob:client:FlagPlateInfo', args = {}}}
    UnFlagMenu[#UnFlagMenu+1] = {opthead = Lang:t('polmenu.unflag') .. " : ".. plate, optdesc = Lang:t('polmenu.unflagdesc'), opticon = 'trash-can', optparams = { event = 'hd-policejob:client:UnFlagPlate', args = plate}}
    local header = {
        disabled = true,
        header = Lang:t('polmenu.unflag'),
        headerid = 'police_unflagplate_menu', -- unique
        desc = '',
        icon = 'trash-can'
    }
    ContextSystem.Open(header, UnFlagMenu)
end)

RegisterNetEvent('hd-policejob:client:UnFlagPlate', function(plate)
    TriggerServerEvent('hd-policejob:server:UnFlagPlate', plate)
    TriggerEvent('hd-policejob:client:FlagPlateInfo')
end)

RegisterNetEvent('police:client:JMSearchPlayer', function()
    TriggerServerEvent('police:server:SearchPlayer')
end)

RegisterNetEvent('hd-policejob:client:ViewCamInput', function()
    local Options = {}
    Options[#Options+1] = {label = Lang:t('polmenu.camid'), name = 'camid', type = "number", required = true}
    local dialog = ContextSystem.Input(Lang:t('polmenu.camid'), Lang:t('info.submit'), Options)

    if dialog then
        if Config.InputSystem == 'ox_lib' then camid = dialog[1] else camid = dialog.camid end
        if tonumber(camid) > 0 then
            TriggerEvent("police:client:ActiveCamera", tonumber(camid))
        else
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.validnumber"), "error", 4500)
        end
    else return end
end)

RegisterNetEvent('hd-policejob:client:FlagPlateInput', function()
    local Options = {}
    Options[#Options+1] = {label = Lang:t('polmenu.platetoflag'), name = 'flagplate', type = "text", required = true}
    Options[#Options+1] = {label = Lang:t('polmenu.reason'), name = 'reason', type = "text", required = true}
    local dialog = ContextSystem.Input(Lang:t('polmenu.platetoflag'), Lang:t('info.submit'), Options)
    if dialog then
        if Config.InputSystem == 'ox_lib' then plate = dialog[1] else plate = dialog.flagplate end
        if Config.InputSystem == 'ox_lib' then reason = dialog[2] else reason = dialog.reason end
        if plate and reason then
            TriggerServerEvent("hd-policejob:server:FlagPlate", plate, reason)
        end
    else return end
end)
-- Commands

RegisterCommand('polmenu', function()
    if PlayerJob.type == 'leo' and PlayerJob.onduty then
        Wait(50)
        TriggerEvent('hd-policejob:client:OpenJobmenu')
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t('error.ondutyonly'), "error", 4500)
    end
end)

RegisterKeyMapping('polmenu', 'Open Jobmenu', 'keyboard', Config.OpenJobMenu)
