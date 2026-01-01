local time = 1000
function loadModel(model) 
    if not HasModelLoaded(model) then
        while not HasModelLoaded(model) do
            if time > 0 then time = time - 1 RequestModel(model) else time = 1000 break end Wait(10)
        end
    end
end

function loadParticle(pack)
    if not HasNamedPtfxAssetLoaded(pack) then RequestNamedPtfxAsset(pack) end
    while not HasNamedPtfxAssetLoaded(pack) do Wait(1) end
    SetPtfxAssetNextCall(pack)
end

function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(5) end
    end
end

function notify(message, type)
    lib.notify({ description = message, type = type })
end