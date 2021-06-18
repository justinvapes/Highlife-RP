local door_config = nil

local doorDistance = 2.5

local lastClosest = nil
local closestDoor = nil

RegisterNetEvent("HighLife:Doors:UpdateDoor")
AddEventHandler("HighLife:Doors:UpdateDoor", function(key, bool)
	if door_config ~= nil and door_config[key] ~= nil then
		door_config[key].locked = bool
	end
end)

RegisterNetEvent("HighLife:Doors:Sync")
AddEventHandler("HighLife:Doors:Sync", function(config)
	door_config = json.decode(config)

	closestDoor = nil
end)

CreateThread(function()
	local thisDoor = nil
	local thisTry = false

	local interactDistance = 2.5

	local closestDistance = nil
	local recentClosest = nil

	local thisDoorDistance = nil

	for _,v in pairs(DoorSystemGetActive()) do
		RemoveDoorFromSystem(v[1])
	end

	local closeRegisterDoor = nil

	while true do
		if door_config ~= nil and not HighLife.Player.CD then
			thisTry = false

			closestDistance = nil
			recentClosest = nil

			for k,v in pairs(door_config) do
				thisDoorDistance = nil

				if v.enabled then
					thisDoorDistance = Vdist(HighLife.Player.Pos, v.position.x, v.position.y, v.position.z)

					if thisDoorDistance < 20.0 then
						if not IsDoorRegisteredWithSystem(GetHashKey(k)) then
							closeRegisterDoor = GetClosestObjectOfType(v.position.x, v.position.y, v.position.z, 5.0, v.door_model, false, false, false)

							if closeRegisterDoor ~= 0 then
								-- AddDoorToSystem(GetHashKey(k), v.door_model, GetEntityCoords(closeRegisterDoor), false, false, true)

								-- NEW
								AddDoorToSystem(GetHashKey(k), v.door_model, GetEntityCoords(closeRegisterDoor), false, true, true)
							end
						end

						DoorSystemSetDoorState(GetHashKey(k), v.locked, true, true)
					-- else
					-- 	if IsDoorRegisteredWithSystem(GetHashKey(k)) then
					-- 		RemoveDoorFromSystem(GetHashKey(k))
					-- 	end
					end

					interactDistance = 2.5

					if v.isGate ~= nil and v.isGate then
						if v.range then
							interactDistance = v.range
						else	
							interactDistance = 15.0
						end
					end

					if thisDoorDistance <= interactDistance then
						thisTry = true

						if closestDistance ~= nil then
							if thisDoorDistance < closestDistance then
								closestDistance = thisDoorDistance
								lastClosest = k

								recentClosest = {
									key = k,
									config = v
								}
							end
						else
							closestDistance = thisDoorDistance

							if closestDoor ~= nil then
								if closestDoor.key ~= k then
									recentClosest = {
										key = k,
										config = v
									}
								end
							else
								recentClosest = {
									key = k,
									config = v
								}
							end
						end
					end
				end
			end

			if recentClosest ~= nil then
				if closestDoor ~= nil then
					if recentClosest.key ~= closestDoor.key then
						closestDoor = recentClosest
					end
				else
					closestDoor = recentClosest
				end
			end

			if not thisTry then
				closestDoor = nil
			end
		end

		Wait(250)
	end
end)

CreateThread(function()
	while true do
		if door_config ~= nil then
			for doorKey,doorData in pairs(door_config) do
				if HighLife.Player.GridID == GetWorldGrid(doorData.position.x, doorData.position.y) then
					if IsDoorRegisteredWithSystem(GetHashKey(doorKey)) then						
						DoorSystemSetDoorState(GetHashKey(doorKey), doorData.locked, true, true)
					end

					Wait(25)
				end
			end
		end

		Wait(2000)
	end
end)

CreateThread(function()
	TriggerServerEvent('HighLife:Doors:GetDoorConfig')

	local drawPosition = nil

	local offsetRotation = -0.60
	
	local canInteract = false

	while true do
		drawPosition = nil

		if closestDoor ~= nil then
			if closestDoor.door ~= nil then
				canInteract = false

				DoorSystemSetDoorState(GetHashKey(closestDoor.key), closestDoor.config.locked, true, true)

				if closestDoor.config.jobs ~= nil then
					if IsAnyJobs(closestDoor.config.jobs) then
						canInteract = true
					end
				end

				if closestDoor.config.licenses ~= nil then
					if HasAnyLicense(closestDoor.config.licenses) then
						canInteract = true
					end
				end

				if canInteract then
					if closestDoor.config.isGate or not HighLife.Player.InVehicle then
						offsetRotation = -0.60
						
						if closestDoor.config.invertTextOffset ~= nil and closestDoor.config.invertTextOffset then
							offsetRotation = 0.60
						end

						drawPosition = GetOffsetFromEntityInWorldCoords(closestDoor.door, offsetRotation, 0.0, 0.15)

						Draw3DCoordText(drawPosition.x, drawPosition.y, drawPosition.z, 'Press [~y~E~s~] to ' .. (closestDoor.config.locked and '~r~unlock' or '~g~lock') .. ((HighLife.Settings.Development or HighLife.Player.Debug) and ' ~s~- ~y~' .. closestDoor.key or ''))

						if IsControlJustReleased(0, 38) then
							TriggerServerEvent('HighLife:Doors:UpdateStatus', closestDoor.key, not closestDoor.config.locked, canInteract)
						end
					end
				end
			else
				closestDoor.door = GetClosestObjectOfType(closestDoor.config.position.x, closestDoor.config.position.y, closestDoor.config.position.z, 5.0, closestDoor.config.door_model, false, false, false)

				Debug(closestDoor.key, GetEntityHeading(closestDoor.door))
			end
		end
		
		Wait(1)
	end
end)

-- local door_config = nil

-- local doorDistance = 2.5

-- local lastClosest = nil
-- local closestDoor = nil

-- RegisterNetEvent("HighLife:Doors:UpdateDoor")
-- AddEventHandler("HighLife:Doors:UpdateDoor", function(key, bool)
-- 	if door_config ~= nil and door_config[key] ~= nil then
-- 		door_config[key].locked = bool
-- 	end
-- end)

-- RegisterNetEvent("HighLife:Doors:Sync")
-- AddEventHandler("HighLife:Doors:Sync", function(config)
-- 	door_config = json.decode(config)

-- 	closestDoor = nil
-- end)

-- local first_try = true

-- CreateThread(function()
-- 	local thisDoor = nil
-- 	local thisTry = false

-- 	local interactDistance = 2.5

-- 	local closestDistance = nil
-- 	local recentClosest = nil

-- 	local thisDoorDistance = nil

-- 	while true do
-- 		if door_config ~= nil and not HighLife.Player.CD then
-- 			if first_try then
-- 				first_try = false

-- 				for k,v in pairs(door_config) do
-- 					thisDoor = nil

-- 					thisDoor = GetClosestObjectOfType(v.position.x, v.position.y, v.position.z, 5.0, v.door_model, false, false, false)

-- 					if thisDoor ~= 0 then
-- 						FreezeEntityPosition(thisDoor, v.locked)
-- 					end
-- 				end
-- 			end

-- 			thisTry = false

-- 			closestDistance = nil
-- 			recentClosest = nil

-- 			for k,v in pairs(door_config) do
-- 				thisDoorDistance = nil

-- 				if v.enabled then
-- 					thisDoorDistance = Vdist(HighLife.Player.Pos, v.position.x, v.position.y, v.position.z)

-- 					interactDistance = 2.5

-- 					if v.isGate ~= nil and v.isGate then
-- 						if v.range then
-- 							interactDistance = v.range
-- 						else	
-- 							interactDistance = 15.0
-- 						end
-- 					end

-- 					if thisDoorDistance <= interactDistance then
-- 						thisTry = true

-- 						if closestDistance ~= nil then
-- 							if thisDoorDistance < closestDistance then
-- 								closestDistance = thisDoorDistance
-- 								lastClosest = k

-- 								recentClosest = {
-- 									key = k,
-- 									config = v
-- 								}
-- 							end
-- 						else
-- 							closestDistance = thisDoorDistance

-- 							if closestDoor ~= nil then
-- 								if closestDoor.key ~= k then
-- 									recentClosest = {
-- 										key = k,
-- 										config = v
-- 									}
-- 								end
-- 							else
-- 								recentClosest = {
-- 									key = k,
-- 									config = v
-- 								}
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end

-- 			if recentClosest ~= nil then
-- 				if closestDoor ~= nil then
-- 					if recentClosest.key ~= closestDoor.key then
-- 						closestDoor = recentClosest
-- 					end
-- 				else
-- 					closestDoor = recentClosest
-- 				end
-- 			end

-- 			if not thisTry then
-- 				closestDoor = nil
-- 			end
-- 		end

-- 		Wait(250)
-- 	end
-- end)

-- CreateThread(function()
-- 	local thisDoor = nil

-- 	while true do
-- 		if door_config ~= nil then
-- 			for doorKey,doorData in pairs(door_config) do
-- 				thisDoor = nil

-- 				if HighLife.Player.GridID == GetWorldGrid(doorData.position.x, doorData.position.y) then
-- 					thisDoor = GetClosestObjectOfType(doorData.position.x, doorData.position.y, doorData.position.z, 5.0, doorData.door_model, false, false, false)

-- 					if thisDoor ~= 0 and thisDoor ~= nil then
-- 						FreezeEntityPosition(thisDoor, doorData.locked)
-- 					end
-- 				end
-- 			end
-- 		end

-- 		Wait(50)
-- 	end
-- end)

-- CreateThread(function()
-- 	TriggerServerEvent('HighLife:Doors:GetDoorConfig')

-- 	local drawPosition = nil

-- 	local offsetRotation = -0.60
	
-- 	local canInteract = false
	
-- 	local message = 'Press [~y~E~s~] to ~r~unlock' --.. ' - ' .. closestDoor.key

-- 	while true do
-- 		drawPosition = nil

-- 		if closestDoor ~= nil then
-- 			if closestDoor.door ~= nil then
-- 				canInteract = false

-- 				message = 'Press [~y~E~s~] to ~r~unlock' --.. ' - ' .. closestDoor.key

-- 				if not closestDoor.config.locked then
-- 					message = 'Press [~y~E~s~] to ~g~lock' --.. ' - ' .. closestDoor.key
-- 				end

-- 				-- if closestDoor.config.locked then
-- 				-- 	if closestDoor.config.heading ~= nil and math.floor(GetEntityHeading(closestDoor.door)) ~= closestDoor.config.heading then
-- 				-- 		SetEntityHeading(closestDoor.door, closestDoor.config.heading)
-- 				-- 	end
-- 				-- end

-- 				if closestDoor.config.jobs ~= nil then
-- 					if IsAnyJobs(closestDoor.config.jobs) then
-- 						canInteract = true
-- 					end
-- 				end

-- 				if closestDoor.config.licenses ~= nil then
-- 					if HasAnyLicense(closestDoor.config.licenses) then
-- 						canInteract = true
-- 					end
-- 				end

-- 				if canInteract then
-- 					if closestDoor.config.isGate or not HighLife.Player.InVehicle then
-- 						offsetRotation = -0.60
						
-- 						if closestDoor.config.invertTextOffset ~= nil and closestDoor.config.invertTextOffset then
-- 							offsetRotation = 0.60
-- 						end

-- 						drawPosition = GetOffsetFromEntityInWorldCoords(closestDoor.door, offsetRotation, 0.0, 0.15)

-- 						Draw3DCoordText(drawPosition.x, drawPosition.y, drawPosition.z, message)

-- 						if IsControlJustReleased(0, 38) then
-- 							TriggerServerEvent('HighLife:Doors:UpdateStatus', closestDoor.key, not closestDoor.config.locked, canInteract)
-- 						end
-- 					end
-- 				end
-- 			else
-- 				closestDoor.door = GetClosestObjectOfType(closestDoor.config.position.x, closestDoor.config.position.y, closestDoor.config.position.z, 5.0, closestDoor.config.door_model, false, false, false)

-- 				Debug(closestDoor.key, GetEntityHeading(closestDoor.door))
-- 			end
-- 		end
		
-- 		Wait(1)
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local playerPos = GetEntityCoords(PlayerPedId())

-- 		local door = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 5.0, GetHashKey('prop_sec_barrier_ld_01a'), false, false, false)

-- 		local doorPos = GetOffsetFromEntityInWorldCoords(door, -0.60, 0.0, 0.15)

-- 		Draw3DCoordText(doorPos.x, doorPos.y, doorPos.z, "X: " .. doorPos.x .. "\nY: " .. doorPos.y .. "\nZ: " .. doorPos.z)

-- 		SetEntityDynamic(door, true)

-- 		Wait(0)
-- 	end
-- end)