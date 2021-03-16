Config = {
    MiejscaLowienia = {x = -1850.04, y = -1250.68,  z = 8.61},  -- Miejsce w którym możemy łowić ryby
    Lol = {x = -1816.55, y= -1193.38, z= 13.3},
    Blips = true -- Używanie blipa
}

local ped = {
    {
      coords = vector3(-1816.55, -1193.38, 13.3),
      heading = 320.0,
    },
}

ESX                           = nil
local PlayerData                = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

local blips = {
    {title="Łowienie Ryb", colour=3, id=68, x=Config.MiejscaLowienia.x, y=Config.MiejscaLowienia.y, z=Config.MiejscaLowienia.z},
    {title="Sprzedaż Ryb", colour=3, id=68, x=Config.Lol.x, y=Config.Lol.y, z=Config.Lol.z},
  }
  
  if Config.Blips == true then
  Citizen.CreateThread(function()
  
     for _, info in pairs(blips) do
       info.blip = AddBlipForCoord(info.x, info.y, info.z)
       SetBlipSprite(info.blip, info.id)
       SetBlipDisplay(info.blip, 4)
       SetBlipScale(info.blip, 0.8)
       SetBlipColour(info.blip, info.colour)
       SetBlipAsShortRange(info.blip, true)
       BeginTextCommandSetBlipName("STRING")
       AddTextComponentString(info.title)
       EndTextCommandSetBlipName(info.blip)
     end
  end)
  end

RegisterNetEvent('wolfi_rybak:check')
AddEventHandler('wolfi_rybak:check', function()
        local ped = PlayerPedId()
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.MiejscaLowienia.x, Config.MiejscaLowienia.y, Config.MiejscaLowienia.z, true) < 10.0  then
            if not IsPedInAnyVehicle(ped, false) then
                wolfirybak_start()
            else
                ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Musisz opuścić pojazd przed rozpoczęciem łowienia!", CustomLogo, 7500, primary)
            end
        else
            ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "To jest złe miejsce na łowienie ryb!", CustomLogo, 7500, primary)
        end
end, false)

function wolfirybak_start(cock)
    local zmienna = true
    ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Wędka została zarzucona!", CustomLogo, 7500, primary)
    FishRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
    PlayAnim(GetPed(),'amb@world_human_stand_fishing@idle_a','idle_c',1,0)
    Citizen.Wait(math.random(1000, 10000))
    ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Kliknij ~g~[E] ~s~aby złapać rybę!", CustomLogo, 7500, primary)
    local timer = 80
    while zmienna do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 38) then
            local random = (math.random(0,100))
            if random <= 30 then
                TriggerServerEvent("wolfi_rybak:dajItem", 'malaryba')
                ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Wyłowiłeś 1 małą rybkę!", CustomLogo, 7500, primary)
                DeleteEntity(FishRod)
                ClearPedTasks(PlayerPedId())
                break
            elseif random <= 60 then
                TriggerServerEvent("wolfi_rybak:dajItem", 'ryba')
                ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Wyłowiłeś 1 średnią rybkę!", CustomLogo, 7500, primary)
                DeleteEntity(FishRod)
                ClearPedTasks(PlayerPedId())
                break
            elseif random <= 90 then
                TriggerServerEvent("wolfi_rybak:dajItem", 'duzaryba')
                ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Wyłowiłeś 1 dużą rybkę!", CustomLogo, 7500, primary)
                DeleteEntity(FishRod)
                ClearPedTasks(PlayerPedId())
                break
            elseif random <= 100 then
                TriggerServerEvent("wolfi_rybak:dajItem", 'extraryba')
                ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Wyłowiłeś 2 duże rybki!", CustomLogo, 7500, primary)
                DeleteEntity(FishRod)
                ClearPedTasks(PlayerPedId())
                break
            end
            if random == 2 then
                ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Wyłowiłeś banknot ~g~200$~s~!", CustomLogo, 7500, primary)
            end
        end
        timer = timer - 1
        if timer <= 0 then
            TriggerServerEvent('wolfi_rybak:zabierWedka')
            ESX.ShowAdvancedNotification("CentrumRP", "Informacja", "Ryba złamała wędkę!", CustomLogo, 7500, primary)
            DeleteEntity(FishRod)
            ClearPedTasks(PlayerPedId())
            break
        end
    end
end

function PlayAnim(ped,base,sub,nr,time) 
	CreateThread(function() 
		RequestAnimDict(base) 
		while not HasAnimDictLoaded(base) do 
			Citizen.Wait(1) 
		end
		if IsEntityPlayingAnim(ped, base, sub, 3) then
			ClearPedSecondaryTask(ped) 
		else 
			for i = 1,nr do 
				TaskPlayAnim(ped, base, sub, 8.0, -8, -1, 16, 0, 0, 0, 0) 
				Citizen.Wait(time) 
			end 
		end 
	end) 
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Lol.x, Config.Lol.y, Config.Lol.z, true) < 3.0  then
            TriggerServerEvent("wolfi_rybak:banplayer")
            Citizen.Wait(10000)
        end
    end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_y_chef_01"))

    while not HasModelLoaded(GetHashKey("s_m_y_chef_01")) do
      Wait(10)
    end

    for _, item in pairs(ped) do
      local hospitalped =  CreatePed(4, "s_m_y_chef_01", item.coords, item.heading, false, true)
      FreezeEntityPosition(hospitalped, true)
      SetEntityInvincible(hospitalped, true)
      SetBlockingOfNonTemporaryEvents(hospitalped, true)
    end
end)

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
	BoneID = GetPedBoneIndex(GetPed(), bone_ID)
	obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
	vX,vY,vZ = table.unpack(GetEntityCoords(GetPed()))
	xRot, yRot, zRot = table.unpack(GetEntityRotation(GetPed(),2))
	AttachEntityToEntity(obj,  GetPed(),  BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
	return obj
end

function GetPed() 
	return 
	GetPlayerPed(-1) 
end
