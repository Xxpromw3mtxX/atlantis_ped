ESX = nil
local player
local model

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    TriggerEvent('chat:addSuggestion', '/ped', _U('menu_suggestion'))
end)

RegisterNetEvent('atlantis_ped:openMenu')
AddEventHandler('atlantis_ped:openMenu', function()
    local elements = {}

    for index, value in pairs(Config.Options) do
        table.insert(elements, {
            label = value.label,
            value = value.value
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_admin_actions', {
		title    = _U('ped_menu'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
        if data.current.value == 'reset' then
            TriggerEvent('atlantis_ped:resetPed')
            menu.close()
        elseif data.current.value == 'f' then
            TriggerEvent('atlantis_ped:openFemaleMenu')
            menu.close()
        elseif data.current.value == 'm' then
            TriggerEvent('atlantis_ped:openMaleMenu')
            menu.close()
        end
	end, function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('atlantis_ped:openFemaleMenu')
AddEventHandler('atlantis_ped:openFemaleMenu', function()
    local elements = {}

    for index, value in pairs(Config.FemalePeds) do
        table.insert(elements, {
            label = value.label,
            value = value.value
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_female_actions', {
		title    = _U('female'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
        TriggerEvent('atlantis_ped:setPed', data.current.value)
        menu.close()
	end, function(data, menu)
        menu.close()
        TriggerEvent('atlantis_ped:openMenu')
    end)
end)

RegisterNetEvent('atlantis_ped:openMaleMenu')
AddEventHandler('atlantis_ped:openMaleMenu', function()
    local elements = {}

    for index, value in pairs(Config.MalePeds) do
        table.insert(elements, {
            label = value.label,
            value = value.value
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_male_actions', {
		title    = _U('male'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
        TriggerEvent('atlantis_ped:setPed', data.current.value)
        menu.close()
	end, function(data, menu)
        menu.close()
        TriggerEvent('atlantis_ped:openMenu')
    end)
end)

RegisterNetEvent('atlantis_ped:setPed')
AddEventHandler('atlantis_ped:setPed', function(ped)
    player = PlayerId()
    model = GetHashKey(ped)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    SetPlayerModel(player, model)
    SetModelAsNoLongerNeeded(model)
    TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = _U('ped_changed', ped), length = 2500})
end)

RegisterNetEvent('atlantis_ped:resetPed')
AddEventHandler('atlantis_ped:resetPed', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil
    
        if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
        else
            model = GetHashKey("mp_f_freemode_01")
        end
    
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
        end
    
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    
        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)
    TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = _U('ped_reset'), length = 2500})
end)

RegisterCommand('ped', function(source, args, rawCommand)
    TriggerServerEvent('atlantis_ped:checkPermission')
end, false)