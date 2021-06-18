local isInNUI = false
local isNearDMV = false

-- function CalculatePlatePrice(plate)
-- 	local finalPrice = nil
-- 	local returnPlate = string.upper(plate)

-- 	returnPlate = returnPlate:gsub("%s+", "")

-- 	if string.len(plate) > 0 and string.len(plate) < (Config.DMV.Plate.MaxLength + 1) then
-- 		-- valid plate 
-- 		finalPrice = ((Config.DMV.Plate.MaxLength - string.len(returnPlate)) + 1) * ((Config.DMV.Plate.PriceModifier * (string.len(plate) > 6 and 2.3 or 1.0)) * ((Config.DMV.Plate.MaxLength - string.len(returnPlate)) > 0 and Config.DMV.Plate.MaxLength - string.len(returnPlate) or 0.5))
-- 	end

-- 	-- FIXME: a-Z, 0-9, no O
-- 	-- finalPrice will be nil if invalid
-- 	-- print(CalculatePlatePrice('AKISSANE'), CalculatePlatePrice('KISSANE'), CalculatePlatePrice('JARRRK'), CalculatePlatePrice('DAZ'), CalculatePlatePrice('DAZ'), CalculatePlatePrice('P1'), CalculatePlatePrice('1'))

-- 	return finalPrice
-- end

function ToggleDMVNUI(visible)
	isInNUI = visible

	SendNUIMessage({
		nui_reference = 'dmv',
		data = {
			visible = visible,
			licenses = {
				dmv = HighLife.Player.Licenses['dmv'],
				drive = HighLife.Player.Licenses['drive'],
				drive_truck = HighLife.Player.Licenses['drive_truck'],
				drive_bike = HighLife.Player.Licenses['drive_bike'],
			}
		}
	})

	SetNuiFocus(visible, visible)
end

-- function UpdateNUIOwnedPlates(plates)
-- 	SendNUIMessage({
-- 		nui_reference = nui_reference,
-- 		data = {
-- 			visible = isInNUI
-- 		}
-- 	})
-- end

-- RegisterNUICallback('dmvCheckPlateAvailibility', function(data)
-- 	print(data.plate)
-- end)

-- eventHandler({ nui_reference: 'dmv_plates', data: { plates: ['abc', 'def', 'ghi', 'jkl'] } });

RegisterNUICallback('dmv_CloseDMVNui', function()
	ToggleDMVNUI(false)
end)

RegisterNUICallback('dmv_submitResults', function(data)
	HighLife:ServerCallback('HighLife:DMV:Pay', function(hasPaid)
		if hasPaid then
			if data.result then
				TriggerServerEvent('HighLife:Player:AddLicense', Config.DMV.Locations.DrivingSchool.Tests['theory'].license)

				Wait(500)

				SendNUIMessage({
					nui_reference = 'dmv',
					data = {
						visible = true,
						licenses = {
							dmv = HighLife.Player.Licenses['dmv'],
							drive = HighLife.Player.Licenses['drive'],
							drive_truck = HighLife.Player.Licenses['drive_truck'],
							drive_bike = HighLife.Player.Licenses['drive_bike'],
						}
					}
				})
			end
		else
			Notification_AboveMap('You ~r~cannot afford ~s~to take the test')
		end
	end, Config.DMV.Locations.DrivingSchool.Tests['theory'].price)
end)

RegisterNUICallback('dmv_test_practical', function(data)
	ToggleDMVNUI(false)

	HighLife.DMV:StartTest('practical', 'DrivingSchool')
end)

RegisterNUICallback('dmv_test_bike', function(data)
	ToggleDMVNUI(false)

	HighLife.DMV:StartTest('motorcycle', 'DrivingSchool')
end)

RegisterNUICallback('dmv_test_commercial', function(data)
	ToggleDMVNUI(false)

	if HighLife.Player.Licenses['drive'] then
		HighLife.DMV:StartTest('commercial', 'DrivingSchool')
	else
		Notification_AboveMap('Your need a ~y~drivers license ~s~before taking the ~y~commercial test~s~!')
	end
end)

local stopTime = nil
local stopCheck = false
local initMessage = true

local CurrentTest = nil

function HighLife.DMV:StartTest(testType, locationReference)
	if CurrentTest == nil then
		local canCreateVehicle = nil

		for parkingName,parkingData in pairs(Config.DMV.Locations[locationReference].vehicle_spawns) do
			if Config.DMV.Locations[locationReference].Tests[testType].large_spawn == nil or (Config.DMV.Locations[locationReference].Tests[testType].large_spawn and parkingData.type == 'large') then
				if not GetClosestVehicleEnumeratedAtCoords(parkingData.pos, (Config.DMV.Locations[locationReference].Tests[testType].large_spawn and 2.5 or 1.0)) then
					canCreateVehicle = {
						x = parkingData.pos.x,
						y = parkingData.pos.y,
						z = parkingData.pos.z,
						heading = parkingData.pos.w
					}

					break
				end
			end
		end

		if canCreateVehicle ~= nil then
			HighLife:ServerCallback('HighLife:DMV:Pay', function(hasPaid)
				if hasPaid then
					-- CreateVehicle, give keys, fuel, etc
					if Config.DMV.Locations[locationReference].Tests[testType] ~= nil then
						if Config.DMV.Locations[locationReference].Tests[testType].valid_vehicles ~= nil then
							-- Route based
							HighLife:CreateVehicle(Config.DMV.Locations[locationReference].Tests[testType].valid_vehicles[math.random(#Config.DMV.Locations[locationReference].Tests[testType].valid_vehicles)], {x = canCreateVehicle.x, y = canCreateVehicle.y, z = canCreateVehicle.z + 0.5}, canCreateVehicle.heading, true, true, function(vehicle)
								PlaceObjectOnGroundProperly(vehicle)

								stopTime = nil
								stopCheck = false
								initMessage = true

								SetVehicleFixed(vehicle)
								SetVehicleFuel(vehicle, 110.0)
								SetVehicleDirtLevel(vehicle, 0.0)
								SetVehicleColours(vehicle, math.random(255), math.random(255))

								LockVehicle(vehicle, true)

								TriggerEvent('HighLife:LockSystem:GiveKeys', GetVehicleNumberPlateText(vehicle), true)

								Notification_AboveMap('Your test ~y~vehicle ~s~is waiting behind the ~b~DMV')

								CurrentTest = {
									Points = {},
									Failed = false,
									Passed = false,
									Type = testType,
									LockHint = false,
									Vehicle = vehicle,
									VehicleBlip = nil,
									VehicleHealth = nil,
									CurrentCheckpoint = 1,
									SeatbeltInfraction = false,
									LocationReference = locationReference, 
									Route = Config.DMV.Locations[locationReference].Routes[math.random(#Config.DMV.Locations[locationReference].Routes)]
								}
							end)
						else
							-- probably the theory, do NUI stuff
						end
					end
				else
					Notification_AboveMap('You ~r~cannot afford ~s~to take the test')
				end
			end, Config.DMV.Locations[locationReference].Tests[testType].price)
		else
			Notification_AboveMap('The ~b~DMV ~s~is under high demand and the parking lot is full!')
		end
	else
		Notification_AboveMap('~o~You are already taking a test')
	end
end

function HighLife.DMV:FinishTest(locationReference)
	if CurrentTest ~= nil then
		if Config.DMV.Locations[locationReference].Tests[CurrentTest.Type].max_points ~= nil then
			if #CurrentTest.Points < Config.DMV.Locations[locationReference].Tests[CurrentTest.Type].max_points then
				if not CurrentTest.Failed then
					CurrentTest.Passed = true
				end
			end
		end

		if CurrentTest.Passed then
			Notification_AboveMap('You ~g~passed ~s~the ~y~' .. CurrentTest.Type .. ' ~s~driving test with ~b~' .. #CurrentTest.Points .. ' ~s~minors!')

			-- TODO: secure this with tokens
			TriggerServerEvent('HighLife:Player:AddLicense', Config.DMV.Locations[locationReference].Tests[CurrentTest.Type].license)
		else
			Notification_AboveMap('You ~o~failed ~s~the ~y~' .. CurrentTest.Type .. ' ~s~driving test')
		end

		if #CurrentTest.Points > 0 then
			local thisTestPoints = CurrentTest.Points

			CreateThread(function()
				for i=1, #thisTestPoints do
					Wait(1000)

					Notification_AboveMap('~r~Point ' .. i .. '~n~~n~Reason~s~: ' .. thisTestPoints[i].reason)
				end
			end)
		end

		if CurrentTest ~= nil then
			if CurrentTest.Blip ~= nil then
				if DoesBlipExist(CurrentTest.Blip.Blip) then
					RemoveBlip(CurrentTest.Blip.Blip)
				end
			end

			if CurrentTest.VehicleBlip ~= nil then
				if DoesBlipExist(CurrentTest.VehicleBlip) then
					RemoveBlip(CurrentTest.VehicleBlip)
				end
			end
		end

		CurrentTest = nil
	end
end

CreateThread(function()
	while true do
		isNearDMV = false

		if not HighLife.Player.InVehicle then
			for locationReference,locationData in pairs(Config.DMV.Locations) do
				if Vdist(HighLife.Player.Pos, locationData.pos) < 3.5 and GetInteriorFromEntity(HighLife.Player.Ped) ~= 0 then
					isNearDMV = true
				end
			end
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local pointCooldown = GameTimerPool.GlobalGameTime

	for locationReference,locationData in pairs(Config.DMV.Locations) do
		local thisBlip = AddBlipForCoord(locationData.pos)

		SetBlipDisplay(thisBlip, 4)
		SetBlipSprite(thisBlip, 498)
		SetBlipScale(thisBlip, 0.8)
		SetBlipAsShortRange(thisBlip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(locationReference)
		EndTextCommandSetBlipName(thisBlip)
	end

	while true do
		if CurrentTest ~= nil then
			if CurrentTest.Route ~= nil then
				if CurrentTest.VehicleBlip == nil then
					CurrentTest.VehicleBlip = AddBlipForEntity(CurrentTest.Vehicle)

					SetBlipScale(CurrentTest.VehicleBlip, 0.6)
					SetBlipSprite(CurrentTest.VehicleBlip, 225)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Test Vehicle')
					EndTextCommandSetBlipName(CurrentTest.VehicleBlip)
				end

				if CurrentTest.CurrentCheckpoint ~= (#CurrentTest.Route + 1) then
					-- active test
					if HighLife.Player.Vehicle == CurrentTest.Vehicle then
						if initMessage and CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.hint ~= nil then
							initMessage = false

							Notification_AboveMap(CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.hint)
						end

						if CurrentTest.VehicleHealth == nil then
							CurrentTest.VehicleHealth = GetEntityHealth(vehicle)
						end

						if CurrentTest.Blip == nil or CurrentTest.CurrentCheckpoint ~= CurrentTest.Blip.Checkpoint then
							if CurrentTest.Blip ~= nil then
								if DoesBlipExist(CurrentTest.Blip.Blip) then
									RemoveBlip(CurrentTest.Blip.Blip)
								end
							end

							CurrentTest.Blip = {
								Blip = AddBlipForCoord(CurrentTest.Route[CurrentTest.CurrentCheckpoint].pos),
								Checkpoint = CurrentTest.CurrentCheckpoint
							}
							
							SetBlipRoute(CurrentTest.Blip.Blip, true)
						end

						if Vdist(HighLife.Player.Pos, CurrentTest.Route[CurrentTest.CurrentCheckpoint].pos) <= (CurrentTest.Route[CurrentTest.CurrentCheckpoint].radius or 10.0) then
							CurrentTest.CurrentCheckpoint = CurrentTest.CurrentCheckpoint + 1

							if CurrentTest.Route[CurrentTest.CurrentCheckpoint] ~= nil and CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.hint ~= nil then
								Notification_AboveMap(CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.hint)
							end
						end

						-- Failure conditions
						if CurrentTest.CurrentCheckpoint > 1 then
							if CurrentTest.Route[CurrentTest.CurrentCheckpoint] ~= nil then
								if Config.DMV.Locations[CurrentTest.LocationReference].Tests[CurrentTest.Type].bypass_seatbelt == nil or not Config.DMV.Locations[CurrentTest.LocationReference].Tests[CurrentTest.Type].bypass_seatbelt then
									if not HighLife.Player.Seatbelt and not CurrentTest.SeatbeltInfraction then
										CurrentTest.SeatbeltInfraction = true

										table.insert(CurrentTest.Points, { reason = '~o~Seatbelt Violation' })
									end
								end

								if GetEntityHealth(HighLife.Player.Vehicle) < (CurrentTest.VehicleHealth - 10.0) and GameTimerPool.GlobalGameTime > pointCooldown then
									pointCooldown = GameTimerPool.GlobalGameTime + 3000

									CurrentTest.VehicleHealth = GetEntityHealth(HighLife.Player.Vehicle)

									table.insert(CurrentTest.Points, { reason = '~o~Collision near ' .. GetStreetNameFromHashKey(GetStreetNameAtCoord(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z))})
								end

								if math.floor(GetEntitySpeedMPH(HighLife.Player.Vehicle)) > (CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.speed + (Config.DMV.Locations[CurrentTest.LocationReference].Tests[CurrentTest.Type].speed_leniency or 3)) and GameTimerPool.GlobalGameTime > pointCooldown then
									pointCooldown = GameTimerPool.GlobalGameTime + 3000

									table.insert(CurrentTest.Points, { reason = 'Speeding - ~o~' .. math.floor(GetEntitySpeedMPH(HighLife.Player.Vehicle)) .. 'mph ~s~in a ~y~' .. CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.speed .. 'mph ~s~zone (' .. GetStreetNameFromHashKey(GetStreetNameAtCoord(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z)) .. ')'})
								end

								if CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.stop ~= nil then
									stopCheck = true

									if stopCheck then
										if IsVehicleStopped(HighLife.Player.Vehicle) then
											if stopTime ~= nil then
												if GameTimerPool.GlobalGameTime >= stopTime then
													stopCheck = false
												end
											else
												stopTime = GameTimerPool.GlobalGameTime + (CurrentTest.Route[CurrentTest.CurrentCheckpoint].params.stop)
											end
										else
											stopTime = nil
										end
									end
								elseif stopCheck then
									stopCheck = false

									table.insert(CurrentTest.Points, { reason = 'Failure to yield - '.. GetStreetNameFromHashKey(GetStreetNameAtCoord(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z))})
								end
							end
						end
					else
						if GetVehiclePedIsTryingToEnter(HighLife.Player.Ped) == CurrentTest.Vehicle and not CurrentTest.LockHint and GetVehicleDoorLockStatus(CurrentTest.Vehicle) == 2 then 
							CurrentTest.LockHint = true 

							DisplayHelpText('Press ~INPUT_REPLAY_SCREENSHOT~ to ~g~unlock ~s~your vehicle')
							-- Config.Lock.Key
						end
					end

					if IsPedShooting(HighLife.Player.Ped) or (Vdist(HighLife.Player.Pos, GetEntityCoords(CurrentTest.Vehicle)) > 100.0) or not DoesEntityExist(CurrentTest.Vehicle) then
						CurrentTest.Failed = true

						HighLife.DMV:FinishTest(CurrentTest.LocationReference)
					end
				else
					BringVehicleToHalt(HighLife.Player.Vehicle, 5.0, 3, 0)

					while not IsVehicleStopped(HighLife.Player.Vehicle) do
						Wait(10)
					end

					SetEntityAsNoLongerNeeded(HighLife.Player.Vehicle)

					CreateThread(function()
						local thisVehicle = deepcopy(HighLife.Player.Vehicle)

						while IsEntityOnScreen(thisVehicle) do
							Wait(10)
						end

						TriggerServerEvent('HighLife:Entity:Delete', VehToNet(thisVehicle))
					end)

					TaskLeaveVehicle(HighLife.Player.Ped, HighLife.Player.Vehicle, 0)

					while HighLife.Player.InVehicle do
						Wait(10)
					end

					HighLife.DMV:FinishTest(CurrentTest.LocationReference)
				end
			end
		end

		if isNearDMV and not HighLife.Player.InVehicle and not HighLife.Player.CD and not HighLife.Player.InCharacterMenu then
			if not isInNUI then
				DisplayHelpText('Press ~INPUT_PICKUP~ to access the ~g~DMV')

				if IsControlJustReleased(0, 38) then
					ToggleDMVNUI(true)
				end
			end
		end

		Wait(1)
	end
end)