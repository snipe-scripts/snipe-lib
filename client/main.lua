QBCore, ESX = nil, nil
-- PlayerJob = {}
PlayerInfo = {}

if Config.Framework == "qb" then
    QBCore = exports[Config.FrameworkTriggers["qb"].ResourceName]:GetCoreObject()
elseif Config.Framework == "esx" then
    local status, errorMsg = pcall(function() ESX = exports[Config.FrameworkTriggers["esx"].ResourceName]:getSharedObject() end)
    if (ESX == nil) then
        while ESX == nil do
            Wait(100)
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        end
    end
end

function PopulateData()
    if Config.Framework == "qb" then
        PlayerData = QBCore.Functions.GetPlayerData()
        PlayerJob = PlayerData.job
        PlayerGang = PlayerData.gang
        PlayerInfo = {
            job = PlayerData.job.name,
            identifier = PlayerData.citizenid,
        }
        PlayerData = nil
    elseif Config.Framework == "esx" then
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        PlayerData = ESX.GetPlayerData()
        PlayerInfo = {
            job = PlayerData.job.name,
            identifier = PlayerData.identifier,
        }
        PlayerData = nil
    end
end

local function ScriptRestarted(script_name)
    TriggerEvent("snipe-lib:client:playerLoaded", PlayerInfo)
end

exports('ScriptRestarted', ScriptRestarted)

AddEventHandler("onResourceStart", function(script_name)
    if script_name == GetCurrentResourceName() then
        PopulateData()
    end
end)

RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].PlayerLoaded)
AddEventHandler(Config.FrameworkTriggers[Config.Framework].PlayerLoaded, function()
    PopulateData()
    -- CheckIfHasWig()
    TriggerEvent("snipe-lib:client:playerLoaded", PlayerInfo)
end)

RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].PlayerUnload)
AddEventHandler(Config.FrameworkTriggers[Config.Framework].PlayerUnload, function()
    PlayerInfo = nil
end)

RegisterNetEvent(Config.FrameworkTriggers[Config.Framework].OnJobUpdate)
AddEventHandler(Config.FrameworkTriggers[Config.Framework].OnJobUpdate, function(job)
    PlayerInfo.job = job.name
    TriggerEvent("snipe-lib:client:jobUpdate", job.name)
end)

local function GetConfig()
    return Config
end

exports('GetConfig', GetConfig)