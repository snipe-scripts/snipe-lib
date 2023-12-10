local function ShowNotification(msg, type)
    if Config.Notify == "ox" then
        lib.notify({type = type, description = msg})
    elseif Config.Notify == "qb" then
        QBCore.Functions.Notify(msg, type)
    elseif Config.Notify == "esx" then
        ESX.ShowNotification(msg)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert("Bundles", msg, 5000, type)
    end
end

exports('ShowNotification', ShowNotification)