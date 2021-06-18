RMenu.Add('vehicle', 'main', RageUI.CreateMenu("Vehicle Controls", "~y~Flick some switches, yo"))
RMenu.Add('vehicle', 'extras', RageUI.CreateSubMenu(RMenu:Get('vehicle', 'main'), "Vehicle Extras", nil))

-- SetIbuttons({		
-- 	{GetControlInstructionalButton(0, 187, 0), "Decrease Cruise Control"},
-- 	{GetControlInstructionalButton(0, 188, 0), "Increase Cruise Control"},
-- 	{GetControlInstructionalButton(0, 19, 0), "Toggle Cruise Control"},
-- }, 0)

CreateThread(function()
	local NeonToggle = false
	local vehicleWindows = {}

	local thisVehicleExtraCount = 0

	while true do
		if HighLife.Player.InVehicle and not HighLife.Player.Cuffed then
			RageUI.IsVisible(RMenu:Get('vehicle', 'main'), true, false, true, function()
				if HighLife.Player.VehicleClass ~= 8 then
					RageUI.ButtonWithStyle("Switch Seats", "Switch to the next seat", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
						if Selected then
							local canShuffle = false

							if not HighLife.Player.Seatbelt then
								if HighLife.Player.VehicleSeat == -1 then
									if GetPedInVehicleSeat(HighLife.Player.Vehicle, 0) == 0 then
										canShuffle = true
									end
								elseif HighLife.Player.VehicleSeat == 0 then
									if GetPedInVehicleSeat(HighLife.Player.Vehicle, -1) == 0 then
										canShuffle = true
									end
								end

								if canShuffle then
									HighLife.Player.AllowShuffle = true

									TaskShuffleToNextVehicleSeat(HighLife.Player.Ped, HighLife.Player.Vehicle)

									Wait(3000)

									HighLife.Player.AllowShuffle = false

									HighLife.Player.VehicleSeat = nil
								end
							else
								Notification_AboveMap("~o~You can't switch seats with a seatbelt on")
							end
						end
					end)

					if HighLife.Player.VehicleClass == Config.VehicleClasses.Helicopters and DoesVehicleAllowRappel(HighLife.Player.Vehicle) then
						RageUI.ButtonWithStyle('~o~Rappel', ((GetEntitySpeedMPH(HighLife.Player.Vehicle) < 10.0) and (HighLife.Player.VehicleSeat > 0 and "Don't fall and ~r~die~s~!" or "~o~You cannot rappel from this seat") or "~o~Vehicle is not slow enough"), { RightLabel = '→→→' }, (GetEntitySpeedMPH(HighLife.Player.Vehicle) < 10.0 and HighLife.Player.VehicleSeat > 0), function(Hovered, Active, Selected)
							if Selected then
								PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

								CreateThread(function()
									local thisVehicle = HighLife.Player.Vehicle

									SetEntityNoCollisionEntity(HighLife.Player.Ped, thisVehicle, false)

									Wait(10000)

									SetEntityNoCollisionEntity(HighLife.Player.Ped, thisVehicle, true)
								end)

								TaskRappelFromHeli(HighLife.Player.Ped, 1)
							end
						end)
					end

					if HighLife.Player.VehicleClass ~= 13 and HighLife.Player.VehicleClass ~= 14 and HighLife.Player.VehicleClass ~= 15 and HighLife.Player.VehicleClass ~= 16 then
						if not IsThisModelABike(GetEntityModel(HighLife.Player.Vehicle)) then
							RageUI.ButtonWithStyle((HighLife.Player.Seatbelt and 'Release' or 'Fasten') .. ' Seatbelt', "So you don't go flying", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
								if Selected then
									if HighLife.Player.Seatbelt then
										ReleaseSeatbelt()
									else
										FastenSeatbelt()
									end
								end
							end)
						end
					end
				end

				if HighLife.Player.VehicleSeat == -1 then
					RageUI.ButtonWithStyle((DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled') and ((DecorGetBool(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled') and 'Start' or 'Stop')) or 'Stop') .. ' Engine', "Start/Stop the engine", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
						if Selected then
							if not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled') then
								DecorSetBool(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled', true)
							else
								DecorSetBool(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled', not DecorGetBool(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled'))
							end
						end
					end)

					RageUI.ButtonWithStyle('Toggle Underglow', "Paul Walker Wannabe", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
						if Selected then
							NeonToggle = not NeonToggle

							DisableVehicleNeonLights(HighLife.Player.Vehicle, NeonToggle)
						end
					end)

					RageUI.ButtonWithStyle((GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, 4) > 0.0 and 'Close' or 'Open') .. " hood", "Opens or closes the hood", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
						if Selected then
							if GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, 4) > 0.0 then 
								SetVehicleDoorShut(HighLife.Player.Vehicle, 4, false)
							else
								SetVehicleDoorOpen(HighLife.Player.Vehicle, 4, false)     
							end
						end
					end)

					RageUI.ButtonWithStyle((GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, 5) > 0.0 and 'Close' or 'Open') .. " trunk", "Opens or closes the trunk", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
						if Selected then
							if GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, 5) > 0.0 then 
								SetVehicleDoorShut(HighLife.Player.Vehicle, 5, false)
							else
								SetVehicleDoorOpen(HighLife.Player.Vehicle, 5, false)     
							end
						end
					end)

					RageUI.List((GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.DoorIndex].Value) > 0.0 and 'Close' or 'Open') .. " Door", MenuVariables.Vehicle.Doors, MenuVariables.Vehicle.DoorIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
						MenuVariables.Vehicle.DoorIndex = Index

						if Selected then
							if GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.DoorIndex].Value) > 0.0 then 
								SetVehicleDoorShut(HighLife.Player.Vehicle, MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.DoorIndex].Value, false)
							else
								SetVehicleDoorOpen(HighLife.Player.Vehicle, MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.DoorIndex].Value, false)
							end
						end
					end)

					RageUI.List("Open/Close Windows", MenuVariables.Vehicle.Doors, MenuVariables.Vehicle.WindowIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
						MenuVariables.Vehicle.WindowIndex = Index

						if Selected then
							local netID = NetworkGetNetworkIdFromEntity(HighLife.Player.Vehicle)

							if vehicleWindows[netID] == nil then
								vehicleWindows[netID] = {
									[MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.WindowIndex].Value] = true	
								}
							else
								vehicleWindows[netID] = {
									[MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.WindowIndex].Value] = not vehicleWindows[netID][MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.WindowIndex].Value]	
								}
							end

							if vehicleWindows[netID][MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.WindowIndex].Value] then
								RollDownWindow(HighLife.Player.Vehicle, MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.WindowIndex].Value)
							else
								RollUpWindow(HighLife.Player.Vehicle, MenuVariables.Vehicle.Doors[MenuVariables.Vehicle.WindowIndex].Value)
							end
						end
					end)

					if HighLife.Player.VehicleClass == Config.VehicleClasses.Boats then
						RageUI.ButtonWithStyle((IsBoatAnchoredAndFrozen(HighLife.Player.Vehicle) and 'Raise' or 'Drop') .. ' Anchor', (GetEntitySpeedMPH(HighLife.Player.Vehicle) < 10.0 and "Make her go down..." or "~o~Slow down to drop the anchor"), { RightLabel = '→→→' }, (GetEntitySpeedMPH(HighLife.Player.Vehicle) < 10.0), function(Hovered, Active, Selected)
							if Selected then
								SetBoatFrozenWhenAnchored(HighLife.Player.Vehicle, true)

								SetBoatAnchor(HighLife.Player.Vehicle, not IsBoatAnchoredAndFrozen(HighLife.Player.Vehicle))
							end
						end)
					end

					if HighLife.Player.VehicleClass ~= 13 and HighLife.Player.VehicleClass ~= 15 and HighLife.Player.VehicleClass ~= 16 then
						RageUI.ButtonWithStyle('Extras', 'Toggle vehicle parts', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected) end, RMenu:Get('vehicle', 'extras'))
					end

					RageUI.Separator('Odometer: ~y~' .. (DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.TravelDistance') and (math.floor(DecorGetInt(HighLife.Player.Vehicle, 'Vehicle.TravelDistance') / Config.Distances.Miles)) or 0) .. ' ~s~Miles')
				end
			end)

			RageUI.IsVisible(RMenu:Get('vehicle', 'extras'), true, false, true, function()
				thisVehicleExtraCount = 0

				if HighLife.Player.VehicleClass ~= Config.VehicleClasses.Emergency then
					for i=1, 20 do
						if DoesExtraExist(HighLife.Player.Vehicle, i) then
							if not IsValueInTable(Config.DisabledVehicleExtras[HighLife.Player.VehicleModel], i) then
								thisVehicleExtraCount = thisVehicleExtraCount + 1

								RageUI.Checkbox("Extra #" .. i, nil, IsVehicleExtraTurnedOn(HighLife.Player.Vehicle, i), { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
									if Active then
										if GetVehicleEngineHealth(HighLife.Player.Vehicle) == 1000.0 then
											local InitFuelLevel = GetVehicleFuelLevel(HighLife.Player.Vehicle) * 1.0
											
											SetVehicleExtra(HighLife.Player.Vehicle, i, not Checked)
											
											SetVehicleFuel(HighLife.Player.Vehicle, InitFuelLevel)
										end
									end
								end)
							end
						end
					end
				end

				if thisVehicleExtraCount == 0 then
					RageUI.ButtonWithStyle('This vehicle has no extras', nil, { RightLabel = "" }, true)
				end
			end)
		end

		Wait(1)
	end
end)