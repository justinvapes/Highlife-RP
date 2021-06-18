RMenu.Add('jobs', 'mechanic', RageUI.CreateMenu("DW Customs", "~o~Serving Mr. Wang"))
RMenu.Add('jobs', 'mechanic_colormenu', RageUI.CreateMenu("Vehicle Spray", "~g~Spray and pray they like it"))

RMenu.Add('jobs', 'mechanic_audit', RageUI.CreateSubMenu(RMenu:Get('jobs', 'mechanic'), "Audit Options", nil))
RMenu.Add('jobs', 'mechanic_vehicle', RageUI.CreateSubMenu(RMenu:Get('jobs', 'mechanic'), "Vehicle Options", nil))
RMenu.Add('jobs', 'mechanic_objects', RageUI.CreateSubMenu(RMenu:Get('jobs', 'mechanic'), "Roadside Objects", nil))

RMenu.Add('jobs', 'mechanic_colormenu_primary', RageUI.CreateSubMenu(RMenu:Get('jobs', 'mechanic_colormenu'), "Primary Color", "Change the primary color"))
RMenu.Add('jobs', 'mechanic_colormenu_secondary', RageUI.CreateSubMenu(RMenu:Get('jobs', 'mechanic_colormenu'), "Secondary Color", "Change the secondary color"))

CreateThread(function()
	while true do
		if IsJob('mecano') then
			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic'), true, false, true, function()
				if not HighLife.Player.InVehicle then
					RageUI.ButtonWithStyle('Tools', 'Things you can place, believe it or not...', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected) end, RMenu:Get('jobs', 'mechanic_objects'))

					RageUI.ButtonWithStyle('Audit Options', 'Paperwork and tings', { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'mechanic_audit'))
					RageUI.ButtonWithStyle('Vehicle Options', 'Pew pew, fix fix', { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'mechanic_vehicle'))

					RageUI.Separator('Mechanics Available: ~y~' .. GetOnlineJobCount('mecano'))
				else
					RageUI.CloseAll()
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic_audit'), true, false, true, function()
				RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:GetClosestPlayerID()
					end
				end)

				if HighLife.Player.Job.rank >= Config.Jobs.mecano.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('mecano')
						end
					end)
				end

				RageUI.ButtonWithStyle('Invoice Client', "Send someone an invoice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:InvoiceClosestPlayer('mecano')
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic_vehicle'), true, false, true, function()
				RageUI.ButtonWithStyle('Flip Vehicle', "Back on all fours", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						-- FIXME: Why is this here?
						CreateThread(function()
							local vehicle = GetClosestVehicleEnumerated(3.0)

							if vehicle ~= nil then
								if not IsVehicleOnAllWheels(vehicle) then
									TaskStartScenarioInPlace(HighLife.Player.Ped, "PROP_HUMAN_BUM_BIN", 0, true)
										
									Wait(30000)

									NetworkRequestControlOfEntity(vehicle)

									SetVehicleOnGroundProperly(vehicle)
									ClearPedTasks(HighLife.Player.Ped)
										
									Notification_AboveMap('VEHICLE_FLIP')
								else
									Notification_AboveMap('VEHICLE_NOFLIP')
								end
							else
								Notification_AboveMap('VEHICLE_NEARBY_FLIP')
							end
						end)
					end
				end)

				RageUI.ButtonWithStyle('Fix Vehicle', "Incredibly OP!", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						CreateThread(function()
							local vehicle = GetClosestVehicleEnumerated(3.0)

							local toolsNearby = false

							for k,v in pairs(Config.Mechanics.Objects) do
								if v.isRepair then
									local isClose = GetClosestObjectOfType(HighLife.Player.Pos, 7.0, v.object, true, false, false)

									if isClose ~= nil and isClose ~= 0 then
										toolsNearby = true

										break
									end
								end
							end

							if vehicle ~= nil then
								if toolsNearby then
									local InitFuelLevel = GetVehicleFuelLevel(vehicle) * 1.0

									TriggerEvent('dp:playanim', 'mechanic')

									local canFullRepair = IsNearValidFullRepair()

									-- TODO: move this to net to prevent sync
									NetworkRequestControlOfEntity(vehicle)

									-- Open hood
									SetVehicleDoorOpen(vehicle, 4, false)

									Wait(30000)

									-- Close good
									SetVehicleDoorShut(vehicle, 4, false)

									TriggerEvent('dp:playanim', 'cancel')

									Wait(2000)

									if canFullRepair then
										SetVehicleFixed(vehicle)
										SetVehicleDeformationFixed(vehicle)
									else
										SetVehicleEngineHealth(vehicle, 500.0)
									end
									
									SetVehicleUndriveable(vehicle, false)

									SetVehicleFuel(vehicle, InitFuelLevel)

									Notification_AboveMap('VEHICLE_REPAIRED')
								else
									Notification_AboveMap('~o~No tools nearby to fix the vehicle with')
								end
							end
						end)
					end
				end)

				RageUI.ButtonWithStyle('Lockpick Vehicle', "The old clothes hangar technique", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						TriggerEvent('HighLife:Items:Lockpick', true)
					end
				end)

				RageUI.Separator()

				RageUI.ButtonWithStyle('Impound Vehicle', "Get Ronnie on the job!", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:RonnieImpoundVehicle()
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic_objects'), true, false, true, function()
				RageUI.ButtonWithStyle('Remove Closest Object', "Removes the last placed object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						for k,v in pairs(Config.Mechanics.Objects) do
							local closestObj = GetClosestObjectOfType(HighLife.Player.Pos, 3.0, v.object, false, true, false)

							if closestObj ~= 0 then
								TriggerServerEvent('HighLife:Entity:Delete', NetworkGetNetworkIdFromEntity(closestObj))

								break
							end
						end
					end
				end)

				for k,v in pairs(Config.Mechanics.Objects) do
					RageUI.ButtonWithStyle('Place ' .. v.name, "Places the object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							CreatePropOnGround(v.object, v.freeze)
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic_colormenu'), true, false, true, function()
				if HighLife.Player.InVehicle then
					if not MenuVariables.Mechanics.VehicleSet then
						MenuVariables.Mechanics.VehicleSet = true

						local pr, pg, pb = GetVehicleCustomPrimaryColour(HighLife.Player.Vehicle)
						local sr, sg, sb = GetVehicleCustomSecondaryColour(HighLife.Player.Vehicle)

						local interiorColor = GetVehicleInteriorColour(HighLife.Player.Vehicle)
						local dashboardColor = GetVehicleDashboardColour(HighLife.Player.Vehicle)

						local pearlescentColor, wheelColor = GetVehicleExtraColours(HighLife.Player.Vehicle)

						MenuVariables.Mechanics.Color = {
							Primary = {
								r = (pr ~= 0 and pr or 1),
								g = (pg ~= 0 and pg or 1),
								b = (pb ~= 0 and pb or 1),
							},
							Secondary = {
								r = (sr ~= 0 and sr or 1),
								g = (sg ~= 0 and sg or 1),
								b = (sb ~= 0 and sb or 1),
							},
							Wheels = wheelColor + 1,
							Interior = interiorColor + 1,
							Dashboard = dashboardColor + 1,
							Pearlescent = pearlescentColor + 1,
						}
					end

					RageUI.ButtonWithStyle('Primary Color', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'mechanic_colormenu_primary'))
					RageUI.ButtonWithStyle('Secondary Color', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'mechanic_colormenu_secondary'))

					RageUI.List("Pearlescent Finish", MenuVariables.Mechanics.ColorNameIndex, MenuVariables.Mechanics.Color.Pearlescent, nil, {}, true, function(Hovered, Active, Selected, Index)
						SetVehicleModKit(HighLife.Player.Vehicle, 0)

						MenuVariables.Mechanics.Color.Pearlescent = Index
						
						SetVehicleExtraColours(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Pearlescent - 1, MenuVariables.Mechanics.Color.Wheels - 1)
					end)

					RageUI.List("Interior Color", MenuVariables.Mechanics.ColorNameIndex, MenuVariables.Mechanics.Color.Interior, nil, {}, true, function(Hovered, Active, Selected, Index)
						SetVehicleModKit(HighLife.Player.Vehicle, 0)

						MenuVariables.Mechanics.Color.Interior = Index
						
						SetVehicleInteriorColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Interior - 1)
					end)

					RageUI.List("Dashboard Color", MenuVariables.Mechanics.ColorNameIndex, MenuVariables.Mechanics.Color.Dashboard, nil, {}, true, function(Hovered, Active, Selected, Index)
						SetVehicleModKit(HighLife.Player.Vehicle, 0)

						MenuVariables.Mechanics.Color.Dashboard = Index
						
						SetVehicleDashboardColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Dashboard - 1)
					end)

					RageUI.List("Wheel Color", MenuVariables.Mechanics.ColorNameIndex, MenuVariables.Mechanics.Color.Wheels, nil, {}, true, function(Hovered, Active, Selected, Index)
						SetVehicleModKit(HighLife.Player.Vehicle, 0)

						MenuVariables.Mechanics.Color.Wheels = Index
						
						SetVehicleExtraColours(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Pearlescent - 1, MenuVariables.Mechanics.Color.Wheels - 1)
					end)
				else
					RageUI.Visible(RMenu:Get('jobs', 'mechanic_colormenu'), false)
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic_colormenu_primary'), true, false, true, function()
				RageUI.List("Red", MenuVariables.Mechanics.RGBColorIndex, MenuVariables.Mechanics.Color.Primary.r, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Mechanics.Color.Primary.r = Index

					if Selected then
						local thisInput = openKeyboard('mechanic_color', 'Color Value', 3)

						if thisInput ~= nil and tonumber(thisInput) ~= nil then
							MenuVariables.Mechanics.Color.Primary.r = tonumber(thisInput)
						end
					end

					SetVehicleCustomPrimaryColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Primary.r, MenuVariables.Mechanics.Color.Primary.g, MenuVariables.Mechanics.Color.Primary.b)
				end)

				RageUI.List("Green", MenuVariables.Mechanics.RGBColorIndex, MenuVariables.Mechanics.Color.Primary.g, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Mechanics.Color.Primary.g = Index

					if Selected then
						local thisInput = openKeyboard('mechanic_color', 'Color Value', 3)

						if thisInput ~= nil and tonumber(thisInput) ~= nil then
							MenuVariables.Mechanics.Color.Primary.g = tonumber(thisInput)
						end
					end

					SetVehicleCustomPrimaryColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Primary.r, MenuVariables.Mechanics.Color.Primary.g, MenuVariables.Mechanics.Color.Primary.b)
				end)

				RageUI.List("Blue", MenuVariables.Mechanics.RGBColorIndex, MenuVariables.Mechanics.Color.Primary.b, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Mechanics.Color.Primary.b = Index

					if Selected then
						local thisInput = openKeyboard('mechanic_color', 'Color Value', 3)

						if thisInput ~= nil and tonumber(thisInput) ~= nil then
							MenuVariables.Mechanics.Color.Primary.b = tonumber(thisInput)
						end
					end

					SetVehicleCustomPrimaryColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Primary.r, MenuVariables.Mechanics.Color.Primary.g, MenuVariables.Mechanics.Color.Primary.b)
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'mechanic_colormenu_secondary'), true, false, true, function()
				RageUI.List("Red", MenuVariables.Mechanics.RGBColorIndex, MenuVariables.Mechanics.Color.Secondary.r, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Mechanics.Color.Secondary.r = Index

					if Selected then
						local thisInput = openKeyboard('mechanic_color', 'Color Value', 3)

						if thisInput ~= nil and tonumber(thisInput) ~= nil then
							MenuVariables.Mechanics.Color.Secondary.r = tonumber(thisInput)
						end
					end

					SetVehicleCustomSecondaryColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Secondary.r, MenuVariables.Mechanics.Color.Secondary.g, MenuVariables.Mechanics.Color.Secondary.b)
				end)

				RageUI.List("Green", MenuVariables.Mechanics.RGBColorIndex, MenuVariables.Mechanics.Color.Secondary.g, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Mechanics.Color.Secondary.g = Index

					if Selected then
						local thisInput = openKeyboard('mechanic_color', 'Color Value', 3)

						if thisInput ~= nil and tonumber(thisInput) ~= nil then
							MenuVariables.Mechanics.Color.Secondary.g = tonumber(thisInput)
						end
					end

					SetVehicleCustomSecondaryColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Secondary.r, MenuVariables.Mechanics.Color.Secondary.g, MenuVariables.Mechanics.Color.Secondary.b)
				end)

				RageUI.List("Blue", MenuVariables.Mechanics.RGBColorIndex, MenuVariables.Mechanics.Color.Secondary.b, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Mechanics.Color.Secondary.b = Index

					if Selected then
						local thisInput = openKeyboard('mechanic_color', 'Color Value', 3)

						if thisInput ~= nil and tonumber(thisInput) ~= nil then
							MenuVariables.Mechanics.Color.Secondary.b = tonumber(thisInput)
						end
					end

					SetVehicleCustomSecondaryColour(HighLife.Player.Vehicle, MenuVariables.Mechanics.Color.Secondary.r, MenuVariables.Mechanics.Color.Secondary.g, MenuVariables.Mechanics.Color.Secondary.b)
				end)
			end)
		end

		Wait(1)
	end
end)