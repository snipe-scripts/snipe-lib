local function GetPlayerFrameworkIdentifier(id)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(id)
        return Player.PlayerData.citizenid
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(id)
        return xPlayer.identifier
    end
end

local function HasMoney(source, amount, type)
    
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.PlayerData.money[type] >= amount then
            return true
        else
            return false
        end
        
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            
            if xPlayer.getMoney() >= amount then
                return true
            else
                return false
            end
        elseif type == "bank" then
            if xPlayer.getAccount("bank").money >= amount then
                return true
            else
                return false
            end
        end
    end
end

local function AddMoney(source, amount, type)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddMoney(type, amount)
        return true
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            xPlayer.addMoney(amount)
            return true
        elseif type == "bank" then
            xPlayer.addAccountMoney("bank", amount)
            return true
        end
    end
end

local function RemoveMoney(source, amount, type)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveMoney(type, amount)
        return true
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == "cash" then
            xPlayer.removeMoney(amount)
            return true
        elseif type == "bank" then
            xPlayer.removeAccountMoney("bank", amount)
            return true
        end
    end
end

local function GetPlayerFrameworkName(source)
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getName()
    end
end

exports('GetPlayerFrameworkName', GetPlayerFrameworkName)
exports('GetPlayerFrameworkIdentifier', GetPlayerFrameworkIdentifier)
exports('HasMoney', HasMoney)
exports('AddMoney', AddMoney)
exports('RemoveMoney', RemoveMoney)