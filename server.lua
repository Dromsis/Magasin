ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('dromsis:vente')
AddEventHandler('dromsis:vente', function(prix , item , quant , type)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = prix
    local _item = item
    local _quant = quant
    local _type = type
    local xMoney = xPlayer.getMoney()
    local xBank =  xPlayer.getAccount('bank').money

    if _type == 1 then
        if xMoney >= price then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(_item, _quant)
            TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
        else
             TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
        end
    elseif _type == 2 then
        if xBank >= price then
            xPlayer.addInventoryItem(_item, _quant)
            xPlayer.removeAccountMoney('bank', price)
            TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
            TriggerClientEvent('magasin:bipbip',source)
        else
            TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
        end
    end

end)

ESX.RegisterServerCallback('carte', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getInventoryItem(Config.CardName).count == 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)