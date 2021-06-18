local isShowingText = false
local isRunningAnim = false

RegisterNetEvent("HighLife:LockSystem:GiveKeys")
AddEventHandler("HighLife:LockSystem:GiveKeys", function(plate, ownedVehicle)
	GivePlayerVehicleKeys(plate, ownedVehicle)
end)

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, HighLife.Player.Ped, 0)
	local _, _, _, _, vehicle = GetRaycastResult(rayHandle)

	if vehicle > 0 and IsEntityAVehicle(vehicle) then
		return vehicle
	end
   
	return nil
end

function DrawVehicleMetaMessage(vehicle, text)
	isShowingText = false

	Wait(50)

	if not isShowingText then
		isShowingText = true

		local vehiclePos = GetEntityCoords(vehicle)

		CreateThread(function()
			CreateThread(function()
				Wait(3000)

				isShowingText = false
			end)
			
			while isShowingText do
				vehiclePos = GetEntityCoords(vehicle)

				Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 1.0, text)

				Wait(0)
			end
		end)
	end
end

function DoFobPress(vehicle)
	if not isRunningAnim then
		isRunningAnim = true

		CreateThread(function()
			local found, previousWeapon = GetCurrentPedWeapon(HighLife.Player.Ped, 1)

			SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)

			TaskPlayAnim(HighLife.Player.Ped, Config.Lock.Anim.dict, Config.Lock.Anim.anim, 8.0, -8, -1, 0 + 16 + 32, 0, false, false, false)

			PlaySoundFromEntity(GetSoundId(), "Landing_Tone", vehicle, "DLC_PILOT_ENGINE_FAILURE_SOUNDS", 0, 0)

			Wait(2000)

			isRunningAnim = false

			SetCurrentPedWeapon(HighLife.Player.Ped, previousWeapon, true)
		end)
	end
end

function LockVehicle(vehicle, locked, overrideStatus)
	local LockedType = Config.LockStatusTypes.Locked
	-- Auto locked when giving keys - garage/jobs/etc
	DecorSetBool(vehicle, 'Vehicle.Locked', locked)

	if not DecorExistOn(vehicle, 'Vehicle.PlayerTouched') then
		DecorSetBool(vehicle, 'Vehicle.PlayerTouched', true)
	end

	if not locked then
		-- NOTE: Maybe - HighLife.Player.Preferences.VehicleLock
		LockedType = Config.LockStatusTypes.Unlocked

		if not IsEntityAMissionEntity(vehicle) then
			SetEntityAsMissionEntity(vehicle, true, true)

			Entity(vehicle).state:set('cleanup_time', GetNetworkTime() + (1800 * 1000), true)
		end
	end

	if overrideStatus ~= nil then
		LockedType = overrideStatus

		if overrideStatus == Config.LockStatusTypes.BreakIn then
			if not DecorExistOn(vehicle, 'Vehicle.HotWired') then
				DecorSetBool(vehicle, 'Vehicle.HotWired', true)
			end
		end
	end

	SetVehicleDoorsLocked(vehicle, LockedType)
end

function AddKeysToPlayer(plate, ownedVehicle)
	table.insert(HighLife.Player.VehicleKeys, plate)

	TriggerServerEvent('HighLife:LockSystem:AddVehicle', plate)
end

function GivePlayerVehicleKeys(plate, ownedVehicle)
	if not ownedVehicle then
		CreateThread(function()
			local active = true

			CreateThread(function()
				Wait(5000)

				active = false
			end)

			while active do
				if HighLife.Player.InVehicle then
					local plate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

					if plate ~= nil then
						active = false

						AddKeysToPlayer(plate, true)
					end

					break
				end

				Wait(100)
			end
		end)
	else
		AddKeysToPlayer(plate, true)
	end
end

function ToggleVehicleLockStatus(vehicle)
	if vehicle ~= nil then
		local validOwnedVehicle = false

		local vehicleClass = GetVehicleClass(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)

		NetworkRequestControlOfEntity(vehicle)

		if vehicleClass ~= 13 then -- Bicycle
			if HighLife.Player.VehicleKeys ~= nil then
				for i=1, #HighLife.Player.VehicleKeys do
				    if HighLife.Player.VehicleKeys[i] == plate then
				    	validOwnedVehicle = true

				        break
				    end
				end

				if HighLife.Player.Debug or validOwnedVehicle then
					if NetworkHasControlOfEntity(vehicle) then
						if DecorGetBool(vehicle, 'Vehicle.Locked') then
							LockVehicle(vehicle, false)

							DrawVehicleMetaMessage(vehicle, '~y~The vehicle unlocks')
						else
							LockVehicle(vehicle, true)

							DrawVehicleMetaMessage(vehicle, '~g~The vehicle locks')
						end

						if not HighLife.Player.InVehicle then
							DoFobPress(vehicle)
						end
					else
						DrawVehicleMetaMessage(vehicle, "~o~The vehicle is occupied")
					end
				else
					DrawVehicleMetaMessage(vehicle, "~o~You don't have the keys")
				end
			end
		end
	end
end

function TriggerVehicleAlarm(vehicle)
	if GetVehicleClass(vehicle) ~= 14 then
		if math.random(2) == 1 then
			SetVehicleIsStolen(vehicle, true)
		end

		CreateThread(function()
			StartVehicleAlarm(vehicle)
			
			SetVehicleAlarmTimeLeft(vehicle, 30000)
			
			HighLife:DispatchEvent('vehicle_theft', {
				['Vehicle'] = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			})
		end)
	end
end

CreateThread(function()
	LoadAnimationDictionary(Config.Lock.Anim.dict)

	local vehicle = nil

	local vehicle_plate = nil
	local vehicle_class = nil

	local isVehicleLocked = true
	local isVehicleTouched = true

	while true do
		if not HighLife.Player.Debug and DoesEntityExist(GetVehiclePedIsTryingToEnter(HighLife.Player.Ped)) then
			vehicle = GetVehiclePedIsTryingToEnter(HighLife.Player.Ped)

			if not isVehicleTaxi then
				vehicle_plate = GetVehicleNumberPlateText(vehicle)
				vehicle_class = GetVehicleClass(vehicle)
				
				if not DecorExistOn(vehicle, 'Vehicle.Legit') then
					DecorSetBool(vehicle, 'Vehicle.Legit', true)
				end

				isVehicleLocked = DecorExistOn(vehicle, 'Vehicle.Locked')
				isVehicleTouched = DecorExistOn(vehicle, 'Vehicle.PlayerTouched')

				if not isVehicleTouched then
					DecorSetBool(vehicle, 'Vehicle.PlayerTouched', true)

					if vehicle_class ~= 13 then
						if IsAnyVehicleDoorOpen(vehicle) then
							LockVehicle(vehicle, false)
						else
							if isVehicleLocked then
								if DecorGetBool(vehicle, 'Vehicle.Locked') then
									LockVehicle(vehicle, true)
								else
									LockVehicle(vehicle, false)
								end
							else
								local IsPedInSeat = not IsVehicleSeatFree(vehicle, Config.VehicleSeatIndex.Driver)
								
								if IsPedInSeat then
									local ValidDriverPed = GetPedInVehicleSeat(vehicle, Config.VehicleSeatIndex.Driver)
									local CanDragOut = (math.random(100) < Config.Lock.DragOutChance)

									if IsEntityDead(ValidDriverPed) then
										if math.random(3) == 1 then
											LockVehicle(vehicle, false)

											SetPedCanBeDraggedOut(ValidDriverPed, true)

											GivePlayerVehicleKeys(vehicle_plate, false)
										else
											LockVehicle(vehicle, true) -- locked
										end

										local extra_data = {
											['Vehicle'] = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
										}

										HighLife:DispatchEvent('jacking_theft', extra_data)
									else
										if CanDragOut then
											LockVehicle(vehicle, false)

											SetPedCanBeDraggedOut(ValidDriverPed, true)

											local extra_data = {
												['Vehicle'] = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
											}

											HighLife:DispatchEvent('jacking_theft', extra_data)
											
											GivePlayerVehicleKeys(vehicle_plate, false)

											local WillFightBack = (math.random(100) < Config.Lock.FightBackChance)

											if WillFightBack then
												if not IsPedAPlayer(ValidDriverPed) then
													GiveWeaponToPed(ValidDriverPed, GetHashKey('WEAPON_PISTOL'), 36, false, true)

													TaskShootAtEntity(ValidDriverPed, HighLife.Player.Ped, 30000, GetHashKey('FIRING_PATTERN_SINGLE_SHOT'))

													SetEntityAsNoLongerNeeded(ValidDriverPed)

													CreateThread(function()
														while true do
															if GetAmmoInPedWeapon(ValidDriverPed, GetHashKey('WEAPON_PISTOL')) == 0 then
																TaskSmartFleePed(ValidDriverPed, HighLife.Player.Ped, 100.0, -1, true, true)
																break
															elseif IsEntityDead(ValidDriverPed) then
																break
															end

															if not DoesEntityExist(ValidDriverPed) then
																break
															end
															
															Wait(500)
														end
													end)
												end
											end
										else
											LockVehicle(vehicle, true)

											TaskVehicleDriveWander(ValidDriverPed, vehicle, 60.0, 2883621)

											PlayAmbientSpeech1(driverPed, (math.random(100) > 50 and "GENERIC_FRIGHTENED_HIGH_RANDOM" or "GENERIC_FRIGHTENED_HIGH_03"), "SPEECH_PARAMS_FORCE_SHOUTED_CRITICAL")
										end
									end
								else
									local ValidDriverPed = GetPedInVehicleSeat(vehicle, Config.VehicleSeatIndex.Driver)
									local CanBreakIn = (math.random(100) < Config.Lock.BreakInChance)

									if CanBreakIn then
										SetVehicleNeedsToBeHotwired(vehicle, true)

										LockVehicle(vehicle, false, Config.LockStatusTypes.BreakIn)

										Wait(1500)

										TriggerVehicleAlarm(vehicle, true)
									else
										LockVehicle(vehicle, true)

										if math.random(100) > Config.Lock.AlarmChance then
											Wait(1000)
											
											TriggerVehicleAlarm(vehicle, true)
										end
									end
								end
							end
						end
					end
				else
					if DecorExistOn(vehicle, 'Vehicle.HotWired') then
						LockVehicle(vehicle, false, Config.LockStatusTypes.Unlocked)

						SetVehicleIsStolen(vehicle, true)

						SetVehicleNeedsToBeHotwired(vehicle, true)
					end
				end
			end
		end

		Wait(10)
	end
end)

CreateThread(function()
	local foundVehicle = nil

	while true do
		foundVehicle = nil

		if IsControlJustPressed(1, Config.Lock.Key) and not HighLife.Player.Dead and HighLife.Player.Dragging == nil then
			if HighLife.Player.InVehicle then
				if HighLife.Player.VehicleSeat == -1 and (IsKeyboard() or HighLife.Player.VehicleClass ~= Config.VehicleClasses.Emergency) then
					ToggleVehicleLockStatus(HighLife.Player.Vehicle)
				end
			else
				foundVehicle = GetVehicleInDirection(GetEntityCoords(HighLife.Player.Ped), GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 20.0, 0.0))

				if foundVehicle ~= nil then
					if not IsEntityDead(foundVehicle) then
						ToggleVehicleLockStatus(foundVehicle)
					end
				else
					foundVehicle = GetClosestVehicleEnumerated(3.0)

					if foundVehicle ~= nil and DoesEntityExist(foundVehicle) and not IsEntityDead(foundVehicle) then
						ToggleVehicleLockStatus(foundVehicle)
					end
				end
			end
		end

		Wait(1)
	end
end)