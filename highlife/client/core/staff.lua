RegisterNetEvent('HighLife:Staff:DeleteVehicle')
AddEventHandler('HighLife:Staff:DeleteVehicle', function()
	local nearVehicle = GetClosestVehicleEnumerated(5.0)

	if nearVehicle ~= nil and DoesEntityExist(nearVehicle) then
		if HighLife.Player.IsStaff or (HighLife.Player.IsHelper and not DecorExistOn(nearVehicle, 'Vehicle.PlayerOwned')) then
			TriggerServerEvent('HighLife:Entity:Delete', NetworkGetNetworkIdFromEntity(nearVehicle))
		end
	end
end)

RegisterNetEvent('HighLife:Staff:GetBike')
AddEventHandler('HighLife:Staff:GetBike', function()
	if HighLife.Player.IsStaff then
		local spawnPos = HighLife.Player.Pos

		HighLife:CreateVehicle('bmx', {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z + 0.5}, HighLife.Player.Heading, true, true, function(vehicle)
			exports.highlife:SetEntryCheck()
			
			TaskWarpPedIntoVehicle(HighLife.Player.Ped, vehicle, -1)
		end)
	end
end)

RegisterNetEvent('HighLife:Staff:GetCar')
AddEventHandler('HighLife:Staff:GetCar', function()
	if HighLife.Player.IsStaff then
		local spawnPos = HighLife.Player.Pos

		HighLife:CreateVehicle('elegy2', {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z + 0.5}, HighLife.Player.Heading, true, true, function(vehicle)
			exports.highlife:SetEntryCheck()

			HighLife:SetVehicleProperties(vehicle, json.decode('{"pearlescentColor":3,"windowTint":1,"modXenonColor":255,"fuel":64.640625,"neonEnabled":[false,false,false,false],"modLivery":-1,"modSeats":-1,"modWindows":-1,"modHydrolic":-1,"modHood":1,"modDoorSpeaker":-1,"neonColor":[255,0,255],"modGrille":0,"modRoof":-1,"modFrontWheels":18,"modExhaust":1,"modHorns":-1,"modFender":-1,"wheels":0,"modRearBumper":-1,"modAPlate":-1,"modSteeringWheel":-1,"modSpeakers":-1,"modArchCover":-1,"modTrunk":-1,"health":1000,"modSuspension":3,"modEngine":3,"color1":146,"modShifterLeavers":-1,"modStruts":-1,"dirtLevel":0.0,"modTank":-1,"modEngineBlock":-1,"modAerials":-1,"modSpoilers":2,"modFrontBumper":0,"modDial":-1,"colorData":{"primary":{"r":0,"g":8,"b":15},"wheels":0,"secondary":{"r":0,"g":8,"b":15},"pearlescent":3,"dashboard":0,"interior":0},"modVanityPlate":-1,"modAirFilter":-1,"modXenon":false,"modPlateHolder":-1,"modBackWheels":-1,"modTrimB":-1,"modTrimA":-1,"modSmokeEnabled":1,"modOrnaments":-1,"modTurbo":1,"modArmor":-1,"modTransmission":2,"modRightFender":-1,"modBrakes":2,"modDashboard":-1,"tyreSmokeColor":[255,255,255],"modSideSkirt":3,"model":-566387422,"plateIndex":4,"plate":"chayotes","wheelColor":0,"modFrame":0,"color2":146}'))

			LockVehicle(vehicle, true)

			TriggerEvent('HighLife:LockSystem:GiveKeys', GetVehicleNumberPlateText(vehicle), true)
			
			TaskWarpPedIntoVehicle(HighLife.Player.Ped, vehicle, -1)
		end)
	end
end)

RegisterNetEvent('HighLife:Staff:TeleportToPlayer')
AddEventHandler('HighLife:Staff:TeleportToPlayer',function(teleportPlayerID)
	HighLife:TempDisable()

	local thisCoords = nil

	for playerID,playerData in pairs(HighLife.Player.ActivePlayerData) do
		if playerData.id == teleportPlayerID then
			thisCoords = playerData.coords

			break
		end
	end

	if thisCoords ~= nil then
		SetEntityCoords(HighLife.Player.Ped, vector3(thisCoords.x, thisCoords.y, thisCoords.z))
	end
end)

RegisterNetEvent('HighLife:Staff:GiveBike')
AddEventHandler('HighLife:Staff:GiveBike',function()
	if not HighLife.Player.Vehicle then
		local spawnPos = HighLife.Player.Pos

		HighLife:CreateVehicle('bmx', {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z + 0.5}, HighLife.Player.Heading, true, true, function(vehicle)
			exports.highlife:SetEntryCheck()
			
			TaskWarpPedIntoVehicle(HighLife.Player.Ped, vehicle, -1)

			Notification_AboveMap("~g~You were given a bicycle by a staff member")
		end)
	else
		Notification_AboveMap("~o~A staff member is trying to give you a bicycle, you must not be in a vehicle")
	end
end)

RegisterNetEvent('HighLife:Staff:RandomSpawn')
AddEventHandler('HighLife:Staff:RandomSpawn',function()
	HighLife:TempDisable()

	SetEntityCoords(HighLife.Player.Ped, Config.SpawnPoints[math.random(#Config.SpawnPoints)])

	Notification_AboveMap("~g~You have been teleported to a spawn location by a staff member")
end)

RegisterNetEvent('HighLife:Staff:Chilliad')
AddEventHandler('HighLife:Staff:Chilliad',function()
	HighLife:TempDisable()

	local chilliadPos = vector4(501.647, 5604.36, 797.9103, 173.8784)

	SetEntityCoords(HighLife.Player.Ped, chilliadPos)

	SetEntityHeading(HighLife.Player.Ped, chilliadPos.w)

	Notification_AboveMap("You have been teleported to ~b~Mount Chilliad ~s~by a staff member, ~y~don't be stupid in future ~s~(:")
end)

RegisterNetEvent('HighLife:Staff:FreezePlayer')
AddEventHandler('HighLife:Staff:FreezePlayer',function(isFrozen)
	if HighLife.Player.InVehicle then
		FreezeEntityPosition(HighLife.Player.Vehicle, isFrozen)
	end

	FreezeEntityPosition(HighLife.Player.Ped, isFrozen)

	-- Notification_AboveMap("~y~You have been frozen in place by a staff member")
end)

RegisterNetEvent('HighLife:Staff:SendMessage')
AddEventHandler('HighLife:Staff:SendMessage',function(message, isWarning, isHelper)
	CreateThread(function()
		local displayTime = 10
		local displayMessage = '~g~Message From Staff'

		CreateThread(function()
			while displayTime ~= 0 do
				Wait(1000)

				displayTime = displayTime - 1
			end
		end)

		if isHelper then
			displayMessage = '~g~Message From Helper'
		else
			if isWarning then
				displayMessage = '~o~Warning Received'
			end
		end

		while displayTime ~= 0 do
			local scaleform = RequestScaleformMovie('mp_big_message_freemode')

			while not HasScaleformMovieLoaded(scaleform) do
				Wait(0)
			end

			PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			PushScaleformMovieFunctionParameterString(displayMessage)
			PushScaleformMovieFunctionParameterString(message)
			PopScaleformMovieFunctionVoid()

			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
			
			Wait(1)
		end
	end)
end)

local rangedProps = {}

CreateThread(function()
	while true do
		if HighLife.Other.RadiusPropHashes ~= 1 then
			rangedProps = GetNearbyObjects(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, 30.0)
		end

		Wait(2000)
	end
end)

CreateThread(function()
	local currentProp = nil
	local currentPropCoords = nil

	while true do
		if HighLife.Other.RadiusPropHashes ~= 1 then
			for i=1, #rangedProps do
				currentProp = rangedProps[i]

				if currentProp ~= nil and DoesEntityExist(currentProp) then
					currentPropCoords = GetEntityCoords(currentProp)

					Draw3DCoordText(currentPropCoords.x, currentPropCoords.y, currentPropCoords.z, 'hash: ' .. GetEntityModel(currentProp))
				end
			end
		end

		Wait(1)
	end
end)