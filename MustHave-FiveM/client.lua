-- Script by SliceAndExit
-- PrestigeV Roleplay
-- discord.gg/prestigev


-------------------------
--Anti-Headshot Oneshot--
-------------------------

CreateThread(function()
    SetPedSuffersCriticalHits(PlayerPedId(), false)
end)

--------------------------
--Anti-ControllerAutoAim--
--------------------------

Citizen.CreateThread(function()
   
	while true do
        Citizen.Wait(0)
       
		if currentWeaponHash ~= -1569615261 then --Unarmed (Knifes and Stuff still have AutoAim)--Change to false to deactivate for Unarmed
            SetPlayerLockon(PlayerId(), true)
        else
            SetPlayerLockon(PlayerId(), false)   --If Player has Weapon AutoAim is DeActivatet
        end
    end
end)

------------------------
--Anti-NPC/Scenario-Spawn--
------------------------

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)

		SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
		SetGarbageTrucks(false)
		SetRandomBoats(false)                                 -- 0.0 = No-Spawn - 1.0 = High-Spawnrate
       	SetVehicleDensityMultiplierThisFrame(0.0)             -- 0.0 - 1.0 --
       	SetPedDensityMultiplierThisFrame(0.0)                 -- 0.0 - 1.0 --
		SetRandomVehicleDensityMultiplierThisFrame(0.0)       -- 0.0 - 1.0 --
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)    -- 0.0 - 1.0 --
		SetParkedVehicleDensityMultiplierThisFrame(0.0)       -- 0.0 - 1.0 --

		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    end
end)

-----------------------
--DisableAmbientSound--
-----------------------

Citizen.CreateThread(function()
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
	SetAudioFlag("PoliceScannerDisabled", true)
end)

-------------------
--InfiniteStamina--
-------------------

Citizen.CreateThread(function()
	
	while true do
		
		StatSetInt('MP0_STAMINA', 100, true)
		Citizen.Wait(100)			
	end
end)

---------------
--SeatShuffle--
---------------

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(0)
		
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		
		Citizen.Wait(5000)
		
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("shuff", function(source, args, raw)
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone / true allow only admin

----------------------
--DisableWeaponPunch--
----------------------

Citizen.CreateThread(function()
    
	while true do
        Citizen.Wait(0)
		
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
