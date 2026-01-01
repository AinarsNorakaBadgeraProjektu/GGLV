local commands = {
    ['/help'] = function(...)
        return showHelp(...)
    end,
    ['/av'] = function(...)
        return showTebex(...)
    end,
    ['/reply'] = function(...)
        return reply(...)
    end,
    ['/fivem'] = function(...)
        return fivem(...)
    end,
    ['/secretLocation'] = function(...)
        return secretKeyLocation(...)
    end,
}

RegisterNUICallback("terminal", function(data, cb)
    local resp = "Unknown command"
    local command = data['command']
    local args = data['args']
    if command and commands[command] then
        resp = commands[command](args)
    end
    cb(resp)
end)

function fivem(...)
    return [[
        <a onclick="window.invokeNative('openUrl', 'https://forum.cfx.re/')">Click here to visit the Fivem Forums!</a>
    ]]
end

function secretKeyLocation(...)
    return [[
        <a>Where cotton candy meets the sea,
        Beneath the fun, a clue may be...</a>
    ]]
end

function reply(args)
    return [[
        <p>]] .. args .. [[</p>
    ]]
end
