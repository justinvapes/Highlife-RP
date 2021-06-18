local isFilling = false
local RefuelArray = nil

local JerryCan = GetHashKey('WEAPON_PETROLCAN')
local JerryCanAnim = {
	dict = 'weapon@w_sp_jerrycan',
	anim = 'fire'
}

local currentFill = {
	vehicleNetID = nil,
	vehicleFuelAmount = nil
}

RegisterNetEvent('HighLife:Fuel:NetSetFuel')
AddEventHandler('HighLife:Fuel:NetSetFuel', function(vehNetID, fuelAmount)
	local thisVehicle = NetToVeh(vehNetID)

	SetVehicleFuel(thisVehicle, (fuelAmount * 1.0))
end)

-- World grid this?
CreateThread(function()
	LoadAnimationDictionary(JerryCanAnim.dict)
	
	while true do
		local hasCan = false
		local thisTry = false

		if not HighLife.Player.InVehicle and not HighLife.Player.Dead then
			local closestVehicle = GetClosestVehicleEnumerated(3.0)

			if GetVehicleEngineHealth(closestVehicle) < 101.0 then
				closestVehicle = nil
			end

			if HighLife.Player.CurrentWeapon == JerryCan then
				hasCan = true
			end

			if closestVehicle ~= nil then
				for i=1, #Config.Fuel.PumpModels do
					local foundPump = GetClosestObjectOfType(HighLife.Player.Pos, 3.0, Config.Fuel.PumpModels[i], false, false)
			
					if foundPump ~= nil and foundPump ~= 0 then
						thisTry = true

						RefuelArray = {
							method = 'pump',
							vehicle = closestVehicle
						}

						break
					end

					Wait(10)
				end
				
				if not thisTry then
					if hasCan then
						thisTry = true

						RefuelArray = {
							method = 'can',
							vehicle = closestVehicle
						}
					end
				end
			else
				for i=1, #Config.Fuel.PumpModels do
					local foundPump = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, Config.Fuel.PumpModels[i], false, false)
			
					if foundPump ~= nil and foundPump ~= 0 and hasCan then
						thisTry = true

						RefuelArray = {
							method = 'jerrycan',
							vehicle = nil
						}

						break
					end

					Wait(10)
				end
			end
		end

		if not thisTry then
			RefuelArray = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local lastFillTime = nil
	local lastFillTotalPrice = 0

	local currentFuel = 0

	while true do
		currentFuel = 0

		if HighLife.Player.InVehicle and GetPedInVehicleSeat(HighLife.Player.Vehicle, -1) == HighLife.Player.Ped and not HighLife.Player.HideHUD then
			if GetVehicleClass(HighLife.Player.Vehicle) ~= 13 then
				currentFuel = math.floor(GetVehicleFuelLevel(HighLife.Player.Vehicle) - Config.Fuel.FakeFuelExtension)

				if currentFuel < 0 then
					currentFuel = 0
				end

				DrawAdvancedText(HighLife.Player.MinimapAnchor.right_x + 0.0725, HighLife.Player.MinimapAnchor.bottom_y - 0.2169, 0.005, 0.0028, 0.4, (currentFuel < 30 and '~y~' or '~g~') .. currentFuel .. '~s~%', 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(HighLife.Player.MinimapAnchor.right_x + 0.0555, HighLife.Player.MinimapAnchor.bottom_y - 0.2169, 0.005, 0.0028, 0.4, 'Fuel', 255, 255, 255, 255, 6, 1)
			end
		end

		if HighLife.Player.CurrentWeapon == JerryCan then
			local currentAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, JerryCan)

			if currentAmmo <= 1 then
				DisableControlAction(1, 142, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(1, 25, true)
				DisableControlAction(1, 68, true)
				DisableControlAction(0, 91, true)
				DisableControlAction(1, 91, true)
				DisablePlayerFiring(HighLife.Player.Id, true)
			end
		end

		if RefuelArray ~= nil then
			if not HighLife.Player.Dead then
				if not isFilling then
					lastFillTime = nil
					lastFillTotalPrice = 0

					local vehiclePos = nil
					local VehicleFuelLevel = nil

					if DoesEntityExist(RefuelArray.vehicle) then
						vehiclePos = GetEntityCoords(RefuelArray.vehicle)
						VehicleFuelLevel = GetVehicleFuelLevel(RefuelArray.vehicle)
					end

					if RefuelArray.method == 'pump' then
						if VehicleFuelLevel ~= nil then
							if VehicleFuelLevel < (100.0 + Config.Fuel.FakeFuelExtension) then
								Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, 'Press [~y~E~s~] to start fueling the vehicle')

								if IsControlJustReleased(0, 38) then
									isFilling = true
								end
							else
								Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, "~g~Your vehicle is fully fueled")
							end
						end
					elseif RefuelArray.method == 'can' then
						if VehicleFuelLevel ~= nil then
							if VehicleFuelLevel < (100.0 + Config.Fuel.FakeFuelExtension) then
								local currentAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, JerryCan)

								if currentAmmo > 1 then
									Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, 'Press [~y~E~s~] to fuel the vehicle')
									
									if IsControlJustReleased(0, 38) then
										isFilling = true
									end
								else
									Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, '~r~Your jerry can is empty')
								end
							else
								Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, "~g~Your vehicle is fully fueled")
							end
						end
					elseif RefuelArray.method == 'jerrycan' then
						local currentAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, JerryCan)

						if currentAmmo ~= 1000 then
							Draw3DCoordText(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z + 0.6, 'Press [~y~E~s~] to fill your jerrycan')
								
							if IsControlJustReleased(0, 38) then
								isFilling = true
							end
						else
							Draw3DCoordText(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z + 0.6, "~g~Your jerrycan is fully fueled")
						end
					end
				else
					if lastFillTime == nil then
						lastFillTime = GameTimerPool.GlobalGameTime
					end

					if RefuelArray.method == 'pump' then
						local vehiclePos = GetEntityCoords(RefuelArray.vehicle)

						if GetVehicleFuelLevel(RefuelArray.vehicle) < 10.0 then
							currentFill.vehicleNetID = VehToNet(RefuelArray.vehicle)
							currentFill.vehicleFuelAmount = 10.0
						end

						local thisFuelText = 'Press [~y~E~s~] to stop fueling the vehicle (~y~' .. math.floor(GetVehicleFuelLevel(RefuelArray.vehicle) - Config.Fuel.FakeFuelExtension) .. '%~s~) - ~g~$' .. lastFillTotalPrice

						if currentFill.vehicleNetID ~= nil then
							thisFuelText = 'Press [~y~E~s~] to stop fueling the vehicle (~y~' .. math.floor(((currentFill.vehicleFuelAmount * 1.0) - Config.Fuel.FakeFuelExtension)) .. '%~s~) - ~g~$' .. lastFillTotalPrice
						end

						Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, thisFuelText)

						if (GameTimerPool.GlobalGameTime - lastFillTime) > Config.Fuel.Interval.pump then
							lastFillTime = GameTimerPool.GlobalGameTime

							if currentFill.vehicleNetID == nil then
								currentFill.vehicleNetID = VehToNet(RefuelArray.vehicle)
								currentFill.vehicleFuelAmount = GetVehicleFuelLevel(RefuelArray.vehicle)
							end

							if currentFill.vehicleFuelAmount ~= nil then
								if ((currentFill.vehicleFuelAmount * 1.0) - Config.Fuel.FakeFuelExtension) <= 100.0 then
									PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 0)

									currentFill.vehicleFuelAmount = currentFill.vehicleFuelAmount + 1.0

									lastFillTotalPrice = lastFillTotalPrice + Config.Fuel.PricePerTick
								else
									isFilling = false
								end
							end
						end

						if HighLife.Player.InVehicle then
							isFilling = false
						end
					elseif RefuelArray.method == 'can' then
						local vehiclePos = GetEntityCoords(RefuelArray.vehicle)

						local currentAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, JerryCan)

						Draw3DCoordText(vehiclePos.x, vehiclePos.y, vehiclePos.z + 0.6, 'Press [~y~E~s~] to stop fueling (~r~Jerry Can: ~y~' .. math.floor(currentAmmo / 10) .. '~s~% remaining)')

						if not IsEntityPlayingAnim(HighLife.Player.Ped, JerryCanAnim.dict, JerryCanAnim.anim, 3) then
							TaskPlayAnim(HighLife.Player.Ped, JerryCanAnim.dict, JerryCanAnim.anim, 4.0, -8.0, -1, 1, 0, false, false, false)
						end

						if (GameTimerPool.GlobalGameTime - lastFillTime) > Config.Fuel.Interval.can then
							lastFillTime = GameTimerPool.GlobalGameTime

							if currentAmmo > 1 then
								local VehicleFuelLevel = GetVehicleFuelLevel(RefuelArray.vehicle)

								if VehicleFuelLevel < (100.0 + Config.Fuel.FakeFuelExtension) then
									if (currentAmmo - Config.Fuel.CanAmount) < 1 then
										SetPedAmmo(HighLife.Player.Ped, JerryCan, 1)
									else
										SetPedAmmo(HighLife.Player.Ped, JerryCan, currentAmmo - Config.Fuel.CanAmount)
									end

									if VehicleFuelLevel < Config.Fuel.FakeFuelExtension then
										currentFill.vehicleNetID = VehToNet(RefuelArray.vehicle)
										currentFill.vehicleFuelAmount = Config.Fuel.FakeFuelExtension
									end

									if currentFill.vehicleFuelAmount == nil then
										currentFill.vehicleNetID = VehToNet(RefuelArray.vehicle)
										currentFill.vehicleFuelAmount = VehicleFuelLevel
									else
										currentFill.vehicleFuelAmount = currentFill.vehicleFuelAmount + 0.25
									end
								else
									isFilling = false

									ClearPedTasks(HighLife.Player.Ped)
								end
							else
								isFilling = false

								ClearPedTasks(HighLife.Player.Ped)
							end
						end
					elseif RefuelArray.method == 'jerrycan' then
						local currentAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, JerryCan)

						Draw3DCoordText(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z + 0.6, 'Press [~y~E~s~] to stop filling (~r~Jerry Can: ~g~' .. math.floor(currentAmmo / 10) .. '~s~% full) - ~g~$' .. lastFillTotalPrice)

						if (GameTimerPool.GlobalGameTime - lastFillTime) > Config.Fuel.Interval.can then
							lastFillTime = GameTimerPool.GlobalGameTime

							if currentAmmo < 1000 then
								SetPedAmmo(HighLife.Player.Ped, JerryCan, currentAmmo + 10)

								lastFillTotalPrice = lastFillTotalPrice + (Config.Fuel.PricePerTick / 2)
							else
								isFilling = false

								ClearPedTasks(HighLife.Player.Ped)
							end
						end
					end

					if IsControlJustReleased(0, 38) then
						ClearPedTasks(HighLife.Player.Ped)

						isFilling = false
					end
				end

				if not isFilling and currentFill.vehicleNetID ~= nil then
					TriggerServerEvent('HighLife:Fuel:NetSetFuel', GetPlayerServerId(NetworkGetEntityOwner(NetToVeh(currentFill.vehicleNetID))), currentFill.vehicleNetID, currentFill.vehicleFuelAmount)

					currentFill = {
						vehicleNetID = nil,
						vehicleFuelAmount = nil
					}
				end
			end
		end

		if not isFilling and lastFillTotalPrice ~= 0 then
			DisplayImageNotification('bank', 'Payment Notification', 'You paid ~r~$' .. math.floor(lastFillTotalPrice) .. ' ~s~for fuel', true)
			
			TriggerServerEvent('HighLife:Fuel:Pay', math.floor(lastFillTotalPrice))

			lastFillTotalPrice = 0
		end

		Wait(1)
	end
end)

CreateThread(function()
	local bypassWait = false
	local initVehicleCheck = true

	local thisTickVehicle = nil

	CreateThread(function()
		while true do
			if not initVehicleCheck then
				if not HighLife.Player.InVehicle then
					initVehicleCheck = true
				end
			end

			Wait(100)
		end
	end)

	while true do
		if HighLife.Player.InVehicle and GetPedInVehicleSeat(HighLife.Player.Vehicle, -1) == HighLife.Player.Ped and GetVehicleClass(HighLife.Player.Vehicle) ~= 13 then
			if initVehicleCheck then
				-- Do this initial wait to make sure the decor is set by the script
				Wait(250)

				if not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.Fuel') then
					-- Random fuel amount (which will set the init decor)
					local thisRandFuelAmount = (math.random(20, 100) * 1.0)

					SetVehicleFuel(HighLife.Player.Vehicle, thisRandFuelAmount)
				else
					SetVehicleFuel(HighLife.Player.Vehicle, (DecorGetInt(HighLife.Player.Vehicle, 'Vehicle.Fuel') * 1.0))
				end

				initVehicleCheck = false

				Wait(500)
			else
				if GetIsVehicleEngineRunning(HighLife.Player.Vehicle) then
					local CalculatedFuelUse = 0

					for i=1, #Config.Fuel.RPM do
						local vehicle_rpm = GetVehicleCurrentRpm(HighLife.Player.Vehicle)

						if vehicle_rpm > Config.Fuel.RPM[i].rate then
							Wait(Config.Fuel.RPM[i].delay)

							if HighLife.Player.InVehicle then
								local vehicle_fuel = GetVehicleFuelLevel(HighLife.Player.Vehicle)

								thisTickVehicle = HighLife.Player.Vehicle

								CalculatedFuelUse = vehicle_fuel - GetVehicleCurrentRpm(HighLife.Player.Vehicle) / Config.Fuel.RPM[i].usage

								if CalculatedFuelUse > (100.0 + Config.Fuel.FakeFuelExtension) then
									CalculatedFuelUse = (100.0 + Config.Fuel.FakeFuelExtension)
								end
							end

							break
						end
					end

					if DoesEntityExist(HighLife.Player.Vehicle) and CalculatedFuelUse ~= 0 then
						if thisTickVehicle ~= nil and thisTickVehicle == HighLife.Player.Vehicle then
							SetVehicleFuel(HighLife.Player.Vehicle, CalculatedFuelUse)
						else
							thisTickVehicle = nil
						end
					end

					Wait(5000)
				end

				if HighLife.Player.InVehicle then
					if GetVehicleFuelLevel(HighLife.Player.Vehicle) <= Config.Fuel.FakeFuelExtension then
						SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)
					end
				end
			end
		else
			initVehicleCheck = true
		end
		
		Wait(1)
	end
end)