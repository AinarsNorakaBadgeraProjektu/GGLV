Slots = {}

function AddSlot(data)
    table.insert(Slots, data)
    return #Slots
end

for k, v in ipairs(CustomSlots) do
    AddSlot(v)
end

function GetSlotId(data)
    for i=1, #Slots do
		if(#(vector3(Slots[i].coords.x, Slots[i].coords.y, Slots[i].coords.z) - data.coords) <= 0.5 and Slots[i].model == data.model) then
			return i
		end
        if(i % 20 == 0) then
            Citizen.Wait(0)
        end
    end
    return AddSlot(data)
end

local slotString = [[
-- %s
{
    coords = %s,
    heading = %s,
    model = %s,
},
]]
if(DevMode) then
    RegisterNetEvent("sf-slots:saveSlot", function(model, coords, heading)
        local text = LoadResourceFile(GetCurrentResourceName(), "slots.txt")
        if(not text) then text = "" end
        text = text .. slotString:format(os.date("%x %X"), coords, heading, model) .. "\n"
        SaveResourceFile(GetCurrentResourceName(), "slots.txt", text, -1)
    end)
end