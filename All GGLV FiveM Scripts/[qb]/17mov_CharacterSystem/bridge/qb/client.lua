if Config.Framework ~= "QBCore" then return end
if Config.Showcase then return end
if not Skin.Enabled then return end

exports('IsCreatingCharacter', function()
    return Skin.CameraEnabled
end)

RegisterNetEvent('qb-clothing:client:openMenu', function()
    if GetInvokingResource() == "qb-interior" or GetInvokingResource() == "qbx_properties" then
        return
    end

    Skin.OpenMenu({
        {
            label = _L("Skin.Button.Save"),
            type = "accent",
            action = "callback",
            actionData = {

                callbackName = "SkinSave"
            }
        }
    }, "creator")
end)


RegisterNetEvent('qb-clothing:client:openMenuCommand', function()
    Skin.OpenMenu({
        {
            label = _L("Skin.Button.Cancel"),
            type = "danger",
            action = "callback",
            actionData = {
                callbackName = "SkinClose"
            }
        },
        {
            label = _L("Skin.Button.Save"),
            type = "accent",
            action = "callback",
            actionData = {

                callbackName = "SkinSave"
            }
        }
    }, "skinCommand")
end)

RegisterNetEvent('qb-clothes:client:CreateFirstCharacter', function()
    if GetInvokingResource() == "qb-interior" or GetInvokingResource() == "qbx_properties" then
        return
    end

    Core?.Functions.GetPlayerData(function(pData)
        Skin.OpenMenu({
            {
                label = _L("Skin.Button.Save"),
                type = "accent",
                action = "callback",
                actionData = {

                    callbackName = "SkinSave"
                }
            },
        }, "creator", true, pData.charinfo.gender == 1 and "male" or "female")
    end)
end)

RegisterNetEvent("qb-clothes:loadSkin", function(_, model, data)
    if model then
        model = tonumber(model) or model
    end

    local translatedSkin = TranslateSkinFromQB(data, model)
    Skin.SetOnPed(PlayerPedId(), translatedSkin)
end)

RegisterNetEvent('qb-clothing:client:loadPlayerClothing', function(data, ped)
    if ped == nil then ped = PlayerPedId() end

    for i = 0, 11 do
        SetPedComponentVariation(ped, i, 0, 0, 0)
    end

    for i = 0, 7 do
        ClearPedProp(ped, i)
    end

    -- Face
    if not data["facemix"] or not data["face2"] then
        data["facemix"] = skinData["facemix"]
        data["facemix"].shapeMix = data["facemix"].defaultShapeMix
        data["facemix"].skinMix = data["facemix"].defaultSkinMix
        data["face2"] = skinData["face2"]
    end

    SetPedHeadBlendData(ped, data["face"].item, data["face2"].item, nil, data["face"].texture, data["face2"].texture, nil, data["facemix"].shapeMix, data["facemix"].skinMix, nil, true)

    -- Pants
    SetPedComponentVariation(ped, 4, data["pants"].item, 0, 0)
    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)

    -- Hair
    SetPedComponentVariation(ped, 2, data["hair"].item, 0, 0)
    SetPedHairColor(ped, data["hair"].texture, data["hair"].texture)

    -- Eyebrows
    SetPedHeadOverlay(ped, 2, data["eyebrows"].item, 1.0)
    SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows"].texture, 0)

    -- Beard
    SetPedHeadOverlay(ped, 1, data["beard"].item, 1.0)
    SetPedHeadOverlayColor(ped, 1, 1, data["beard"].texture, 0)

    -- Blush
    SetPedHeadOverlay(ped, 5, data["blush"].item, 1.0)
    SetPedHeadOverlayColor(ped, 5, 1, data["blush"].texture, 0)

    -- Lipstick
    SetPedHeadOverlay(ped, 8, data["lipstick"].item, 1.0)
    SetPedHeadOverlayColor(ped, 8, 1, data["lipstick"].texture, 0)

    -- Makeup
    SetPedHeadOverlay(ped, 4, data["makeup"].item, 1.0)
    SetPedHeadOverlayColor(ped, 4, 1, data["makeup"].texture, 0)

    -- Ageing
    SetPedHeadOverlay(ped, 3, data["ageing"].item, 1.0)
    SetPedHeadOverlayColor(ped, 3, 1, data["ageing"].texture, 0)

    -- Arms
    SetPedComponentVariation(ped, 3, data["arms"].item, 0, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)

    -- T-Shirt
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, 0, 2)
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)

    -- Vest
    SetPedComponentVariation(ped, 9, data["vest"].item, 0, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)

    -- Torso 2
    SetPedComponentVariation(ped, 11, data["torso2"].item, 0, 2)
    SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)

    -- Shoes
    SetPedComponentVariation(ped, 6, data["shoes"].item, 0, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)

    -- Mask
    SetPedComponentVariation(ped, 1, data["mask"].item, 0, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)

    -- Badge
    SetPedComponentVariation(ped, 10, data["decals"].item, 0, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)

    -- Accessory
    SetPedComponentVariation(ped, 7, data["accessory"].item, 0, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)

    -- Bag
    SetPedComponentVariation(ped, 5, data["bag"].item, 0, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)

    -- Hat
    if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
        SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
    else
        ClearPedProp(ped, 0)
    end

    -- Glass
    if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
        SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
    else
        ClearPedProp(ped, 1)
    end

    -- Ear
    if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
        SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
    else
        ClearPedProp(ped, 2)
    end

    -- Watch
    if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
        SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, true)
    else
        ClearPedProp(ped, 6)
    end

    -- Bracelet
    if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
        SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, true)
    else
        ClearPedProp(ped, 7)
    end

    if data["eye_color"].item ~= -1 and data["eye_color"].item ~= 0 then
        SetPedEyeColor(ped, data['eye_color'].item)
    end

    if data["moles"].item ~= -1 and data["moles"].item ~= 0 then
        SetPedHeadOverlay(ped, 9, data['moles'].item, (data['moles'].texture / 10))
    end

    SetPedFaceFeature(ped, 0, (data['nose_0'].item / 10))
    SetPedFaceFeature(ped, 1, (data['nose_1'].item / 10))
    SetPedFaceFeature(ped, 2, (data['nose_2'].item / 10))
    SetPedFaceFeature(ped, 3, (data['nose_3'].item / 10))
    SetPedFaceFeature(ped, 4, (data['nose_4'].item / 10))
    SetPedFaceFeature(ped, 5, (data['nose_5'].item / 10))
    SetPedFaceFeature(ped, 6, (data['eyebrown_high'].item / 10))
    SetPedFaceFeature(ped, 7, (data['eyebrown_forward'].item / 10))
    SetPedFaceFeature(ped, 8, (data['cheek_1'].item / 10))
    SetPedFaceFeature(ped, 9, (data['cheek_2'].item / 10))
    SetPedFaceFeature(ped, 10,(data['cheek_3'].item / 10))
    SetPedFaceFeature(ped, 11, (data['eye_opening'].item / 10))
    SetPedFaceFeature(ped, 12, (data['lips_thickness'].item / 10))
    SetPedFaceFeature(ped, 13, (data['jaw_bone_width'].item / 10))
    SetPedFaceFeature(ped, 14, (data['jaw_bone_back_lenght'].item / 10))
    SetPedFaceFeature(ped, 15, (data['chimp_bone_lowering'].item / 10))
    SetPedFaceFeature(ped, 16, (data['chimp_bone_lenght'].item / 10))
    SetPedFaceFeature(ped, 17, (data['chimp_bone_width'].item / 10))
    SetPedFaceFeature(ped, 18, (data['chimp_hole'].item / 10))
    SetPedFaceFeature(ped, 19, (data['neck_thikness'].item / 10))
    skinData = data
end)

RegisterNetEvent('qb-clothing:client:loadOutfit', function(oData)
    local data = oData.outfitData or oData.skin
    local ped = PlayerPedId()

    if type(data) ~= "table" then data = json.decode(data) end
    local rawTranslate = TranslateSkinFromQB(data)
    local current = Skin.ConstructFromPed(ped)
    local blacklistedComponents = {
        [0] = true, -- head
        [2] = true, -- HAIR
    }
    
    for k,v in pairs(current.components) do
        if not blacklistedComponents[v.component] then
            for k2, v2 in pairs(rawTranslate.components) do
                if v2.component == v.component then
                    current.components[k] = v2
                end
            end
        end
    end

    for k,v in pairs(current.props) do
        for k2, v2 in pairs(rawTranslate.props) do
            if v2.prop == v.prop then
                current.props[k] = v2
            end
        end
    end

    current["model"] = GetEntityModel(ped)

    Skin.SetOnPed(ped, current)

    -- Accessory
    if data["accessory"] ~= nil then
        if Core?.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)
        end
    else
        if Core?.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, -1, 0, 2)
        end
    end
end)

RegisterNetEvent("qb-clothing:client:openOutfitMenu", function()
    Core?.Functions.TriggerCallback('qb-clothing:server:getOutfits', function(result)
        if GetResourceState("qb-menu") ~= "missing" then
            local data = {
                {
                    header = _L("Bridge.Wardrobe.SelectOutfit"),
                    isMenuHeader = true,
                }
            }
            for k,v in pairs(result) do
                table.insert(data, {
                    header = v.outfitname,
                    params = {
                        event = "17mov_CharacterSystem:ManageOutfit",
                        args = {
                            data = v,
                            myId = v.outfitId,
                            myName = v.outfitname
                        }
                    }
                })
            end

            exports["qb-menu"]:openMenu(data)
        else
            local options = {}
            for k, v in pairs(result) do
                table.insert(options, {
                    label = v.outfitname,
                    args = {
                        data = v,
                        myId = v.id,
                        myName = v.outfitname
                    }
                })
            end

            if #options > 0 then
                lib.registerMenu({
                    id = '17mov_CharacterSystem:openOutfitMenu',
                    title = _L("Bridge.Wardrobe.SelectOutfit"),
                    position = 'top-right',
                    options = options
                }, function (selected, scrollIndex, args, checked)
                    lib.hideMenu(false)
                    TriggerEvent("17mov_CharacterSystem:ManageOutfit", args) -- Runs whenever an option is selected
                end)
                lib.showMenu('17mov_CharacterSystem:openOutfitMenu')
            else
                lib.notify({
                    title = _L("OutfitChanger.NoOutfits"),
                    position = "bottom",
                    icon = "fa-solid fa-ban",
                    iconAnimation = "shake",
                    type = 'error'
                })
            end
        end
    end)
end)

RegisterNetEvent("17mov_CharacterSystem:LoadWardrobeOutfit", function(data)
    TriggerEvent("qb-clothing:client:loadOutfit", data)
    if Skin.RememberLastOutfit then
        Citizen.Wait(1000)
        TriggerEvent("17mov_CharacterSystem:SaveCurrentSkin")
    end
end)

RegisterNetEvent("17mov_CharacterSystem:ManageOutfit", function(data)
    if GetResourceState("qb-menu") ~= "missing" then
        local data = {
            {
                header = data.myName,
                isMenuHeader = true,
            },
            {
                header = _L("Bridge.Wardrobe.ChooseOutfit"),
                params = {
                    event = "17mov_CharacterSystem:LoadWardrobeOutfit",
                    args = data.data
                }
            },
            {
                header = _L("Bridge.Wardrobe.DeleteOutfit"),
                params = {
                    event = "qb-clothing:server:removeOutfit",
                    isServer = true,
                    args = {
                        name = data.myName,
                        id = data.myId,
                    }
                }
            }
        }

        exports["qb-menu"]:openMenu(data)
    else
        local options = {
            {
                label = _L("Bridge.Wardrobe.ChooseOutfit"),
                args = data.data
            },
            {
                label = _L("Bridge.Wardrobe.DeleteOutfit"),
                args = {
                    name = data.myName,
                    id = data.myId
                }
            }
        }

        lib.registerMenu({
            id = "17mov_CharacterSystem:manageOutfitMenu",
            title = data.myName,
            options = options,
            position = "top-right"
        }, function (selected, scrollIndex, args, checked)
            if selected == 1 then
                TriggerEvent("qb-clothing:client:loadOutfit", args)
            elseif selected == 2 then
                TriggerServerEvent("qb-clothing:server:removeOutfit", args)
            end
        end)
        lib.showMenu("17mov_CharacterSystem:manageOutfitMenu")
    end
end)