function ReleaseSeatbelt()
	HighLife.SpatialSound.CreateSound('SeatbeltOff')

	Wait(2000)

	HighLife.Player.Seatbelt = false

	Notification_AboveMap('~y~You release your seatbelt')
end

function FastenSeatbelt()
	if HighLife.Player.VehicleClass ~= 13 and HighLife.Player.VehicleClass ~= 14 and HighLife.Player.VehicleClass ~= 15 and HighLife.Player.VehicleClass ~= 16 then
		if not IsThisModelABike(GetEntityModel(HighLife.Player.Vehicle)) then
			if HighLife.Player.VehicleSeat ~= -1 or (GetEntitySpeedMPH(HighLife.Player.Vehicle) < Config.Seatbelt.MaxVehicleSpeed) then
				HighLife.SpatialSound.CreateSound('SeatbeltOn')
					
				Wait(2500)

				HighLife.Player.Seatbelt = true
				
				Notification_AboveMap('~g~You fasten your seatbelt')
			else
				Notification_AboveMap("~o~You fail to fasten your seatbelt due to the vehicles speed")

				Wait(2000)
			end
		end
	end
end

CreateThread(function()
	local resetSpeedOnEnter = true
	local lastMaxSpeed = 0
	local hornActive = false
	local engineToggleTimer = GameTimerPool.GlobalGameTime

	while true do
		if HighLife.Player.InVehicle then
			if IsControlPressed(0, 29) and GetLastInputMethod(2) and not HighLife.Player.Cuffed then
				if not HighLife.Player.Seatbelt then
					FastenSeatbelt()
				else
					ReleaseSeatbelt()
				end
			end

			if HighLife.Player.VehicleSeat == -1 then
				if IsHornActive(HighLife.Player.Vehicle) then
					SetVehicleFullbeam(HighLife.Player.Vehicle, true)

					hornActive = true
				elseif hornActive then
					SetVehicleFullbeam(HighLife.Player.Vehicle, false)

					hornActive = false
				end

				if IsControlPressed(0, 23) then
					if GameTimerPool.GlobalGameTime > (engineToggleTimer + 600) then
						engineToggleTimer = GameTimerPool.GlobalGameTime

						-- don't turn off
						SetVehicleEngineOn(HighLife.Player.Vehicle, true, true, false)
					end
				else
					engineToggleTimer = GameTimerPool.GlobalGameTime
				end
				
				if resetSpeedOnEnter then
					if GetVehicleClass(HighLife.Player.Vehicle) ~= 15 and GetVehicleClass(HighLife.Player.Vehicle) ~= 16 then
						maxSpeed = GetVehicleHandlingFloat(HighLife.Player.Vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
						SetEntityMaxSpeed(HighLife.Player.Vehicle, maxSpeed)

						HighLife.Player.CruiseControl = false
						resetSpeedOnEnter = false
					end
				end

				if not IsEntityInAir(HighLife.Player.Vehicle) then
					if GetVehicleClass(HighLife.Player.Vehicle) ~= 18 and not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.HasSirens') and GetVehicleClass(HighLife.Player.Vehicle) ~= 13 and GetVehicleClass(HighLife.Player.Vehicle) ~= 15 and GetVehicleClass(HighLife.Player.Vehicle) ~= 16 then
						if IsControlJustReleased(0, 19) and HighLife.Player.CruiseControl then
							maxSpeed = GetVehicleHandlingFloat(HighLife.Player.Vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
							SetEntityMaxSpeed(HighLife.Player.Vehicle, maxSpeed)

							DisplayHelpText("Cruise Control disabled")

							HighLife.Player.CruiseControl = false
						elseif IsControlJustReleased(0, 19) then
							cruise = GetEntitySpeed(HighLife.Player.Vehicle)
							if cruise > 5.0 then
								SetEntityMaxSpeed(HighLife.Player.Vehicle, cruise)

								lastMaxSpeed = cruise

								cruise = math.floor(cruise * 2.23694 + 0.5)
								DisplayHelpText("Cruise Control: ~y~" .. cruise .. "~s~mph")

								HighLife.Player.CruiseControl = true
							end
						elseif IsControlJustReleased(0, 188) and HighLife.Player.CruiseControl then
							cruise = lastMaxSpeed + 0.5

							SetEntityMaxSpeed(HighLife.Player.Vehicle, cruise)

							lastMaxSpeed = cruise

							cruise = math.floor(cruise * 2.23694 + 0.5)

							DisplayHelpText("Cruise Control: ~y~" .. cruise .. "~s~mph")

							HighLife.Player.CruiseControl = true
						elseif IsControlJustReleased(0, 187) and HighLife.Player.CruiseControl then
							if lastMaxSpeed > 2.0 then
								cruise = lastMaxSpeed - 0.5
								SetEntityMaxSpeed(HighLife.Player.Vehicle, cruise)

								lastMaxSpeed = cruise

								cruise = math.floor(cruise * 2.23694 + 0.5)

								DisplayHelpText("Cruise Control: ~y~" .. cruise .. "~s~mph")
							end
						end

						if HighLife.Player.CruiseControl then
							DrawIbuttons()

							SetControlNormal(0, 71, .80)
						end
					end
				elseif HighLife.Player.CruiseControl then
					maxSpeed = GetVehicleHandlingFloat(HighLife.Player.Vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
					SetEntityMaxSpeed(HighLife.Player.Vehicle, maxSpeed)

					DisplayHelpText("Cruise Control disabled")

					HighLife.Player.CruiseControl = false
				end
			end
		else
			lastMaxSpeed = 0
			HighLife.Player.CruiseControl = false
			resetSpeedOnEnter = true
		end

		Wait(1)
	end
end)