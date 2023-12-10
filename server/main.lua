QBCore, ESX = nil, nil
disabled = false

if Config.Framework == "qb" then
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkTriggers["qb"].ResourceName]:GetCoreObject()
    end
    Config.JobAccounts = true
elseif Config.Framework == "esx" then
    local status, errorMsg = pcall(function() ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject() end)
    if (ESX == nil) then
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
else
    print("Framework not found")
    disabled = true
end

local function GetConfig()
    return Config
end

exports('GetConfig', GetConfig)

local function GetQBCoreObject()
    return QBCore
end

exports('GetQBCoreObject', GetQBCoreObject)