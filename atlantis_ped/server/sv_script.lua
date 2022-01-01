ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterNetEvent('atlantis_ped:checkPermission')
AddEventHandler('atlantis_ped:checkPermission', function(action, ped)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerGroup = xPlayer.getGroup()
    
    if xPlayerGroup == 'owner' or xPlayerGroup == 'admin' or xPlayerGroup == 'mod' then
        TriggerClientEvent('atlantis_ped:openMenu', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = _U('not_staff'), length = 2500})
    end
end)

-- Version Checker
PerformHttpRequest("https://raw.githubusercontent.com/xxpromw3mtxx/atlantis_ped/main/.version", function(err, text, headers)
    Citizen.Wait(2000)
    local curVer = GetResourceMetadata(GetCurrentResourceName(), "version")

    if (text ~= nil) then
        if (text ~= curVer) then
            print '^1-----------------------------------------^0'
            print '^1     UPDATE AVAILABLE ATLANTIS_PED       ^0'
            print '^1         GET IT ON GITHUB NOW            ^0'
            print '^1-----------------------------------------^0'
        else
            print("^2ATLANTIS_PED is up to date!^0")
        end
    else
        print '^1----------------------------------------^0'
        print '^1      ERROR GETTING ONLINE VERSION      ^0'
        print '^1----------------------------------------^0'
    end 
end)