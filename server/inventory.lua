
local function HasItem(source, item, amount)
    local src = source
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        local itemInfo = Player.Functions.GetItemByName(item)
        if itemInfo ~= nil and itemInfo.amount >= amount then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getInventoryItem(item).count >= amount then
            return true
        else
            return false
        end
    end
end

local function GetItemCount(source, item)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        local itemInfo = Player.Functions.GetItemByName(item)
        if itemInfo ~= nil then
            return itemInfo.amount
        else
            return 0
        end
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        local item = xPlayer.getInventoryItem(item)
        if item ~= nil then
            return item.count
        else
            return 0
        end
    end
end

local function AddItem(source, item, amount, metadata)

    if Config.Inventory == "ox" then
        if exports.ox_inventory:AddItem(source, item, amount, metadata) then
            return true
        else
            return false
        end
    elseif Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.AddItem(item, amount, false, metadata) then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" and Config.Inventory == "qs" then
        if metadata and (not metadata.showAllDescriptions) then
            metadata.showAllDescriptions = true
        end
        if exports['qs-inventory']:AddItem(source, item, amount, nil, metadata) then
            return true
        else
            return false
        end
    end
end

local function RemoveItem(source, item, amount, slot)

    if Config.Inventory == "ox" then
        if exports.ox_inventory:RemoveItem(source, item, amount, nil,  slot) then
            return true
        else
            return false
        end
    elseif Config.Framework == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.RemoveItem(item, amount, slot) then
            return true
        else
            return false
        end
    elseif Config.Framework == "esx" and Config.Inventory == "qs" then
        if exports['qs-inventory']:RemoveItem(source, item, amount, slot) then
            return true
        else
            return false
        end
    end
end

local function CreateUseable(itemName, itemData)
    if Config.Framework == "qb" then
        QBCore.Functions.CreateUseableItem(itemName, function(source)
            TriggerClientEvent("snipe-restaurants:client:useItem", source, itemName, itemData)
        end)
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:CreateUsableItem(Config.WigItemName, function(source, item)
            EquipWig(source, item.info, item.slot)
        end)
    end
end

exports("CreateUseable", CreateUseable)

exports('HasItem', HasItem)
exports('GetItemCount', GetItemCount)
exports('AddItem', AddItem)
exports('RemoveItem', RemoveItem)
