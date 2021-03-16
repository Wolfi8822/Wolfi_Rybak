
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--local RYBAK = 'https://discord.com/api/webhooks/793837580399542312/3w355Bs468lRG8iSjt7Df6j7Oo-712TzB5xIaB-CmJqqZQ9XaGPI3PUo-in5ZyCQo4Wz'
--local CHEAT = 'https://discord.com/api/webhooks/818420239216934932/-4wG87J_cUCB3_V9J1kJoIACS3RB5Kry6MMjd8YXJ65B4oNaTL6h3iB9pTf3yx4oBMFl'

ESX.RegisterUsableItem('rod', function(source)
    local _source = source
	TriggerClientEvent('wolfi_rybak:check', _source)
end)

RegisterServerEvent('wolfi_rybak:dajItem')
AddEventHandler('wolfi_rybak:dajItem', function(itemek)
    local xPlayer = ESX.GetPlayerFromId(source)
    if itemek == 'ryba' then
        xPlayer.addInventoryItem('ryba', 1)
        --exports.logs:wolfilog(source, RYBAK, '**'..GetPlayerName(source)..'** wyłowił **średnią rybę**', "CentrumRP")
    elseif itemek == 'malaryba' then
        xPlayer.addInventoryItem('malaryba', 1)
        --exports.logs:wolfilog(source, RYBAK, '**'..GetPlayerName(source)..'** wyłowił **małą rybę**', "CentrumRP")
    elseif itemek == 'duzaryba' then
        xPlayer.addInventoryItem('duzaryba', 1)
        --exports.logs:wolfilog(source, RYBAK, '**'..GetPlayerName(source)..'** wyłowił **dużą rybę**', "CentrumRP")
    elseif itemek == 'extraryba' then
        xPlayer.addInventoryItem('duzaryba', 2)
        --exports.logs:wolfilog(source, RYBAK, '**'..GetPlayerName(source)..'** wyłowił **dwie duże ryby**', "CentrumRP")
    elseif itemek == 'CheaterBan' then
        xPlayer.addMoney(200)
        --exports.logs:wolfilog(source, RYBAK, '**'..GetPlayerName(source)..'** wyłowił **banknot 200$**', "CentrumRP")
    else
       --exports.logs:cheat(source, CHEAT, '**'..GetPlayerName(source)..'** próbował dodać item. ``'..itemek..'``', "CentrumRP")
    end
end)

RegisterServerEvent('wolfi_rybak:banplayer')
AddEventHandler('wolfi_rybak:banplayer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ilosc1 = xPlayer.getInventoryItem('malaryba').count
    local ilosc2 = xPlayer.getInventoryItem('ryba').count
    local ilosc3 = xPlayer.getInventoryItem('duzaryba').count

    if ilosc1 > 0 then
        local price1 = 100
        local price1a = price1 * ilosc1
        xPlayer.removeInventoryItem('malaryba', ilosc1)
        xPlayer.addMoney(price1a)
        TriggerClientEvent("esx:showAdvancedNotification", source, "CentrumRP", "Informacja", "Sprzedałeś ~g~x"..ilosc1..' mała ryba ~s~za ~g~$'..price1a, CustomLogo, 7500, primary)
    end
    if ilosc2 > 0 then
        local price2 = 200
        local price2a = price2 * ilosc2
        xPlayer.removeInventoryItem('ryba', ilosc2)
        xPlayer.addMoney(price2a)
        TriggerClientEvent("esx:showAdvancedNotification", source, "CentrumRP", "Informacja", "Sprzedałeś ~g~x"..ilosc2..' ryba ~s~za ~g~$'..price2a, CustomLogo, 7500, primary)
    end
    if ilosc3 > 0 then
        local price3 = 300
        local price3a = price3 * ilosc3
        xPlayer.removeInventoryItem('duzaryba', ilosc3)
        xPlayer.addMoney(price3a)
        TriggerClientEvent("esx:showAdvancedNotification", source, "CentrumRP", "Informacja", "Sprzedałeś ~g~x"..ilosc3..' ryba ~s~za ~g~$'..price3a, CustomLogo, 7500, primary)
    end
end)

RegisterServerEvent('wolfi_rybak:zabierWedka')
AddEventHandler('wolfi_rybak:zabierWedka', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('rod', 1)
end)

--webhook = "https://discord.com/api/webhooks/793837580399542312/3w355Bs468lRG8iSjt7Df6j7Oo-712TzB5xIaB-CmJqqZQ9XaGPI3PUo-in5ZyCQo4Wz"

--function ping(message)
--    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "CentrumRP", content = message}), { ['Content-Type'] = 'application/json' })
--end

--function discordlog(message)
--    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "CentrumRP", embeds = {{["color"] = 1,["title"] = "WOLFI-RYBAK",["description"] = "".. message .."",["footer"] = {["text"] = "CentrumRP"},}},}), { ['Content-Type'] = 'application/json' })
--end

--RegisterServerEvent('wolfi_log')
--AddEventHandler('wolfi_log', function(message)
--	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "CentrumRP", embeds = {{["color"] = '1',["title"] = "WOLFI-RYBAK",["description"] = "".. message .."",["footer"] = {["text"] = "CentrumRP"},}},}), { ['Content-Type'] = 'application/json' })
--end)
