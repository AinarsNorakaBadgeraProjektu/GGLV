if Config.Housing ~= "default" then
    return
end


function GetPlayerHouses(identifier)
    return {
        {
            ["name"] = 'Cannot find houses',
            ["id"] = '',
            ["coords"] = nil
        }
    }
end
