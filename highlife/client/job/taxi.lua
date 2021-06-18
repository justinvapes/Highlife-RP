local currentFare = 0
local seatIndexData = {}

RegisterNetEvent('HighLife:Taxi:SendFair')
AddEventHandler('HighLife:Taxi:SendFair', function(fare)
	SetNotificationTextEntry('STRING')
	AddTextComponentString("Your fare was ~g~$" .. fare .. '~s~, have a great day!')
	SetNotificationMessage('CHAR_TAXI', 'CHAR_TAXI', true, 4, 'Downtown Cab Co.', 'Thanks for riding!')
	DrawNotification(false, true)

	currentFare = 0
end)

RegisterNetEvent('HighLife:Taxi:SendCurrentFair')
AddEventHandler('HighLife:Taxi:SendCurrentFair', function(fare)
	currentFare = fare
end)

RegisterNetEvent('HighLife:Taxi:SendNotif')
AddEventHandler('HighLife:Taxi:SendNotif', function(fare)
	SetNotificationTextEntry('STRING')
	AddTextComponentString("A passenger has paid the fare of ~g~$" .. fare)
	SetNotificationMessage('CHAR_TAXI', 'CHAR_TAXI', true, 4, 'Downtown Cab Co.', 'Your Taxi')
	DrawNotification(false, true)
end)

local PauseFare = false

local isDriver = false

CreateThread(function()
	while true do
		if HighLife.Player.InVehicle then
			if IsJob('taxi') then
				local passengerCount = 0

				local validVehicle = (GetEntityModel(HighLife.Player.Vehicle) == GetHashKey('taxi'))

				if GetPedInVehicleSeat(HighLife.Player.Vehicle, -1) == HighLife.Player.Ped and validVehicle and not HighLife.Player.Dead then
					isDriver = true

					for vehicleSeat=0, 2 do
						local thisSeatPed = GetPedInVehicleSeat(HighLife.Player.Vehicle, vehicleSeat)

						if DoesEntityExist(thisSeatPed) and IsPedAPlayer(thisSeatPed) then
							for _,playerID in pairs(GetActivePlayers()) do
								if thisSeatPed == GetPlayerPed(playerID) then
									seatIndexData[vehicleSeat] = {
										active = true,
										playerID = playerID
									}

									passengerCount = passengerCount + 1

									break
								end
							end
						end
					end

					for vehicleSeat=0, 2 do
						local pedInSeat = GetPedInVehicleSeat(HighLife.Player.Vehicle, vehicleSeat)

						if seatIndexData[vehicleSeat] ~= nil then
							if not DoesEntityExist(pedInSeat) and seatIndexData[vehicleSeat].active then
								if passengerCount == 0 then
									local passengerPlayerID = GetPlayerServerId(seatIndexData[vehicleSeat].playerID)
									
									if passengerPlayerID ~= nil then
										TriggerServerEvent('HighLife:Taxi:SendFare', passengerPlayerID, math.floor(currentFare))
									end
								end

								seatIndexData[vehicleSeat] = nil
							end
						end
					end

					if passengerCount == 0 then
						currentFare = 0
					end

					if passengerCount > 0 then
						if not PauseFare then
							if GetEntitySpeedMPH(HighLife.Player.Vehicle) > 10.0 then
								currentFare = currentFare + (passengerCount * Config.Taxi.FareModifier)
							else
								currentFare = currentFare + (passengerCount * (Config.Taxi.FareModifier / 2))
							end
						end
					end

					for vehicleSeat=0, 2 do
						if seatIndexData[vehicleSeat] ~= nil then
							TriggerServerEvent('HighLife:Taxi:SendCurrentFare', GetPlayerServerId(seatIndexData[vehicleSeat].playerID), math.floor(currentFare))
						end
					end
				else
					isDriver = false
				end
			end
		else
			currentFare = 0

			seatIndexData = {}

			isDriver = false
		end

		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		if currentFare ~= nil and currentFare > 0 then
			DrawBottomText("Current fare: ~g~$" .. math.floor(currentFare) .. (isDriver and (PauseFare and ' ~o~PAUSED ~s~[~y~R~s~] to resume fare' or ' ~s~[~y~R~s~] to pause fare') or ''), 0.5, 0.95, 0.4)

			if isDriver then
				if GetLastInputMethod(2) and IsDisabledControlJustPressed(0, 45) then
					PauseFare = not PauseFare
				end
			end
		end

		Wait(1)
	end
end)

local taxiIsWorking = true

local CurrentMission = {
	AirTime = nil,
	PickupTime = nil,
	ForceFail = false,
	VehicleInitHealth = nil,

	Notifications = {
		Drive = false,
		Pickup = false,
		Finish = false
	},
	Destination = {
		blip = nil,
		position = nil,
		distance = nil
	},
	PickupPed = {
		blip = nil,
		entity = nil,
		entering = false,
		inVehicle = false
	},
}

function CleanupMission()
	if DoesBlipExist(CurrentMission.PickupPed.blip) then
		RemoveBlip(CurrentMission.PickupPed.blip)
	end

	if DoesBlipExist(CurrentMission.Destination.blip) then
		RemoveBlip(CurrentMission.Destination.blip)
	end

	if DoesEntityExist(CurrentMission.PickupPed.entity) then
		SetEntityAsNoLongerNeeded(CurrentMission.PickupPed.entity)
	end

	CurrentMission = {
		AirTime = nil,
		PickupTime = nil,
		ForceFail = false,
		VehicleInitHealth = nil,

		Notifications = {
			Drive = false,
			Pickup = false,
			Finish = false
		},
		Destination = {
			blip = nil,
			position = nil,
			distance = nil
		},
		PickupPed = {
			blip = nil,
			entity = nil,
			entering = false,
			inVehicle = false
		},
	}
end

function ClosestRoadPositionTemp(position)
	local foundRoad, roadPosition, roadHeading = GetClosestVehicleNodeWithHeading(position.x, position.y, position.z, roadPosition, roadHeading, 1, 3, 0)

	if foundRoad then
		return {
			position = roadPosition, 
			heading = roadHeading
		}
	end

	return nil
end

function TaxiAddDestinationBlip(position)
	local thisBlip = AddBlipForCoord(position)

	SetBlipAsShortRange(thisBlip, 0)
	SetBlipColour(thisBlip, 51)
	SetBlipScale(thisBlip, 0.6)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Customer Drop-off')
	EndTextCommandSetBlipName(thisBlip)

	return thisBlip
end

function TaxiAddPedBlip(thisPed)
	local thisBlip = AddBlipForEntity(thisPed)

	SetBlipAsShortRange(thisBlip, 0)
	SetBlipSprite(thisBlip, 480)
	SetBlipColour(thisBlip, 5)
	SetBlipScale(thisBlip, 0.6)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Customer')
	EndTextCommandSetBlipName(thisBlip)

	return thisBlip
end

local taxiHash = GetHashKey('taxi')

local GenerateBoundries = {
	top_left = {
		x = -1960,
		y = 558
	},
	bottom_right = {
		x = 1621,
		y = -2410
	}
}

-- TODO: Chance to give a tip + random items if good journey

Config.Speech = {
	types = {
		['GENERIC_HI'] = 'SPEECH_PARAMS_FORCE',
		['GENERIC_FUCK_YOU'] = 'SPEECH_PARAMS_FORCE',
		['GENERIC_YES'] = 'SPEECH_PARAMS_FORCE_NORMAL',
		['GENERIC_INSULT_MED'] = 'SPEECH_PARAMS_FORCE',
		['GENERIC_INSULT_HIGH'] = 'SPEECH_PARAMS_FORCE',
		['GENERIC_HOWS_IT_GOING'] = 'SPEECH_PARAMS_FORCE',
		['APOLOGY_NO_TROUBLE'] = 'SPEECH_PARAMS_FORCE_SHOUTED_CRITICAL',
	},
	lines = {
		greet = {
			'GENERIC_HI',
			'GENERIC_HOWS_IT_GOING'
		},
		leave = {
			'GENERIC_BYE',
			'GENERIC_THANKS',
		}
	},
}

function TaxiMissionFailConditions()
	if GetEntitySpeedMPH(HighLife.Player.Vehicle) > 80.0 or 
		IsVehicleStuckOnRoof(HighLife.Player.Vehicle) or 
		IsPedShooting(HighLife.Player.Ped) or
		CurrentMission.ForceFail or 
		((CurrentMission.VehicleInitHealth - GetVehicleEngineHealth(HighLife.Player.Vehicle)) > 200) or
		GameTimerPool.GlobalGameTime > (CurrentMission.PickupTime + (600 * 1000))
	then
		return true
	end

	return false
end

CreateThread(function()
	while true do
		-- DrawMarker(1, GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, vector3(0.0, Config.Taxi.AiPickupDistance, 0.0)), 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Taxi.AiPickupRadius, Config.Taxi.AiPickupRadius, 1.0, 255, 255, 255, 80, false, true, 2, false, false, false, false)

		if HighLife.Player.Job.name == 'taxi' or HighLife.Settings.Development then
			if taxiIsWorking and HighLife.Player.InVehicle and GetEntityModel(HighLife.Player.Vehicle) == taxiHash then
				if CurrentMission.PickupTime ~= nil then
					if GameTimerPool.GlobalGameTime > CurrentMission.PickupTime then
						if CurrentMission.PickupPed.entity == nil then
							local foundEnumPed = GetClosestPedEnumerated(Config.Taxi.AiPickupRadius, GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, vector3(0.0, Config.Taxi.AiPickupDistance, 0.0)), true)

							if foundEnumPed ~= nil and IsPedHuman(foundEnumPed) and not IsPedDeadOrDying(foundEnumPed) and IsPedWalking(foundEnumPed) and not IsPedFleeing(foundEnumPed) then
								if not DecorExistOn(foundEnumPed, 'Entity.UsedTaxi') then
									CurrentMission.PickupPed = {
										entity = foundEnumPed,
										blip = TaxiAddPedBlip(foundEnumPed)
									}
								end
							end
						else
							if CurrentMission.Destination.position == nil then
								local isHighway = true

								local thisRoadNode = nil

								while isHighway do
									thisRoadNode = ClosestRoadPositionTemp(vector3(math.random(GenerateBoundries.top_left.x, GenerateBoundries.bottom_right.x), math.random(GenerateBoundries.bottom_right.y, GenerateBoundries.top_left.y), 0.0))

									if thisRoadNode ~= nil then
										local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(thisRoadNode.position.x, thisRoadNode.position.y, thisRoadNode.position.z))

										if string.match(streetName, "Los Santos Freeway") or string.match(streetName, "Palomino Fwy") or string.match(streetName, "Los Santos Fwy") or string.match(streetName, "Del Perro") or string.match(streetName, "Olympic") or string.match(streetName, "La Puerta") then
											if string.match(streetName, "City") then
												isHighway = false
											end
										else
											isHighway = false
										end
									end

									Wait(50)
								end

								CurrentMission.Destination.position = thisRoadNode.position

								CurrentMission.Destination.distance = GetDistanceBetweenCoords(HighLife.Player.Pos, thisRoadNode.position, true)

								CurrentMission.Destination.blip = TaxiAddDestinationBlip(CurrentMission.Destination.position)
							else
								if CurrentMission.PickupPed.entity ~= nil and DoesEntityExist(CurrentMission.PickupPed.entity) and not IsPedDeadOrDying(CurrentMission.PickupPed.entity) then
									CurrentMission.PickupPed.inVehicle = (GetVehiclePedIsIn(CurrentMission.PickupPed.entity) == HighLife.Player.Vehicle)

									if not CurrentMission.PickupPed.inVehicle then
										SetBlipDisplay(CurrentMission.Destination.blip, 0)
										SetBlipRoute(CurrentMission.Destination.blip, false)

										if not CurrentMission.Notifications.Pickup then
											ClearPedTasks(CurrentMission.PickupPed.entity)

											TaskStandStill(CurrentMission.PickupPed.entity, -1)

											DecorSetBool(CurrentMission.PickupPed.entity, 'Entity.UsedTaxi', true)

											SetEntityAsMissionEntity(CurrentMission.PickupPed.entity, true, true)

											TaskStartScenarioInPlace(CurrentMission.PickupPed.entity, 'WORLD_HUMAN_STAND_IMPATIENT', -1, false)

											Notification_AboveMap('Park near the customer to pick them up')

											CurrentMission.Notifications.Pickup = true
										end

										if Vdist(HighLife.Player.Pos, GetEntityCoords(CurrentMission.PickupPed.entity)) < 15.0 and IsVehicleStopped(HighLife.Player.Vehicle) then
											TaskVehicleTempAction(HighLife.Player.Ped, HighLife.Player.Vehicle, 6, 1000)

											if not GetIsTaskActive(CurrentMission.PickupPed.entity, 160) then
												CurrentMission.PickupPed.entering = true

												ClearPedTasks(CurrentMission.PickupPed.entity)

												SetBlockingOfNonTemporaryEvents(CurrentMission.PickupPed.entity, true)

												SetEntityAsMissionEntity(CurrentCustomer, true, false)

												SetVehicleDoorsLocked(HighLife.Player.Vehicle, Config.LockStatusTypes.Unlocked)

												TaskEnterVehicle(CurrentMission.PickupPed.entity, HighLife.Player.Vehicle, -1, (GetDistanceBetweenCoords(GetEntityCoords(CurrentMission.PickupPed.entity), GetWorldPositionOfEntityBone(vehicleHandle, GetEntityBoneIndexByName(HighLife.Player.Vehicle, 'door_dside_r')), false) < GetDistanceBetweenCoords(GetEntityCoords(CurrentMission.PickupPed.entity), GetWorldPositionOfEntityBone(vehicleHandle, GetEntityBoneIndexByName(HighLife.Player.Vehicle, 'door_pside_r')), false) and 1 or 2), (math.random(1, 2) * 1.0), 0)
											end
										end

										if Vdist(HighLife.Player.Pos, GetEntityCoords(CurrentMission.PickupPed.entity)) > (Config.Taxi.AiPickupDistance * 2) then
											CurrentMission.PickupTime = nil
										end
									else
										SetBlipDisplay(CurrentMission.PickupPed.blip, 0)
										SetBlipDisplay(CurrentMission.Destination.blip, 2)

										if IsEntityInAir(HighLife.Player.Vehicle) then
											if CurrentMission.AirTime == nil then
												CurrentMission.AirTime = GameTimerPool.GlobalGameTime + 1000
											end
										else
											if CurrentMission.AirTime ~= nil then
												if GameTimerPool.GlobalGameTime > CurrentMission.AirTime then
													CurrentMission.ForceFail = true
												end

												CurrentMission.AirTime = nil
											end
										end

										if not CurrentMission.Notifications.Drive then
											SetBlipRoute(CurrentMission.Destination.blip, true)

											CurrentMission.VehicleInitHealth = GetVehicleEngineHealth(HighLife.Player.Vehicle)

											Notification_AboveMap('Drive the customer to their destination!')

											SetVehicleDoorsLocked(HighLife.Player.Vehicle, Config.LockStatusTypes.Locked)

											PlayAmbientSpeech1(CurrentMission.PickupPed.entity, Config.Speech.lines.greet[math.random(#Config.Speech.lines.greet)], 'SPEECH_PARAMS_FORCE_NORMAL')

											CurrentMission.Notifications.Drive = true
										end

										if TaxiMissionFailConditions() then
											Notification_AboveMap('You scared the customer off, let them out')

											BringVehicleToHalt(HighLife.Player.Vehicle, 15.0, 3, true)

											while not IsVehicleStopped(HighLife.Player.Vehicle) do
												Wait(100)
											end

											TaskSmartFleePed(CurrentMission.PickupPed.entity, HighLife.Player.Ped, 100.0, -1, true, true)

											CleanupMission()
										end

										if Vdist(HighLife.Player.Pos, CurrentMission.Destination.position) < 20.0 then
											if not CurrentMission.Notifications.Finish then
												Notification_AboveMap('Come to a stop to drop the customer off')

												CurrentMission.Notifications.Finish = true
											end

											if IsVehicleStopped(HighLife.Player.Vehicle) then
												TaskVehicleTempAction(HighLife.Player.Ped, HighLife.Player.Vehicle, 6, 3000)

												TaskLeaveVehicle(CurrentMission.PickupPed.entity, HighLife.Player.Vehicle, 0)
												
												PlayAmbientSpeech1(CurrentMission.PickupPed.entity, Config.Speech.lines.leave[math.random(#Config.Speech.lines.leave)], 'SPEECH_PARAMS_FORCE_NORMAL')

												Notification_AboveMap('Trip complete!')

												TriggerServerEvent('HighLife:Taxi:AIFare', CurrentMission.Destination.distance)

												CleanupMission()

												Wait(2000)

												SetVehicleDoorShut(HighLife.Player.Vehicle, 2, false)
												SetVehicleDoorShut(HighLife.Player.Vehicle, 3, false)
											end
										end
									end
								else
									CurrentMission.PickupTime = nil
								end
							end
						end
					end
				elseif GetPedInVehicleSeat(HighLife.Player.Vehicle, 0) == 0 and GetPedInVehicleSeat(HighLife.Player.Vehicle, 1) == 0 and GetPedInVehicleSeat(HighLife.Player.Vehicle, 2) == 0 and currentFare == 0 then
					if GetEntitySpeedMPH(HighLife.Player.Vehicle) < 60.0 and GetVehicleEngineHealth(HighLife.Player.Vehicle) > 800.0 then
						CleanupMission()

						CurrentMission.PickupTime = GameTimerPool.GlobalGameTime + ((HighLife.Settings.Development and GetRandomIntInRange(1, 5) or GetRandomIntInRange(60, 300)) * 1000)
					end
				end
			else
				CleanupMission()
			end
		else
			CleanupMission()
		end

		Wait(100)
	end
end)