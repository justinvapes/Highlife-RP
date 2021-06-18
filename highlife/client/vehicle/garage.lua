local inMenu = false

local activeCooldown = 0
local currentVehicle = nil

local currentArea = nil
local currentAreaConfig = nil

local vehicleDeleteLock = false

local vehicle_menu_items = {}

for k,v in pairs(Config.Dealerships) do
	if v.vehicles ~= nil then
		for j,vehicle in pairs(v.vehicles) do
			for i=1, #vehicle do
				HighLife.Other.VehiclePrices[GetHashKey(vehicle[i].model)] = vehicle[i].price
			end
		end
	end
end

RegisterNetEvent('HighLife:Garage:QuestionExistance')
AddEventHandler('HighLife:Garage:QuestionExistance', function(vehicleData, vehicleHealth)
	SpawnVehicle(vehicleData, vehicleHealth)
end)

RegisterNetEvent('HighLife:Garage:UpdateVehicles')
AddEventHandler('HighLife:Garage:UpdateVehicles', function()
	GetPlayerVehicles()
end)

RegisterNetEvent('HighLife:Garage:ResetLock')
AddEventHandler('HighLife:Garage:ResetLock', function()
	vehicleDeleteLock = false
end)

function SpawnVehicle(thisVehicle, thisHealth)
	local spawnPos = HighLife.Player.Pos
	local spawnHeading = HighLife.Player.Heading

	thisVehicle = json.decode(thisVehicle)

	if GetVehicleClassFromName(thisVehicle.model) == Config.VehicleClasses.Boats then
		local closestDistance = nil
		local closestLocation = nil

		if GetVehicleClassFromName(thisVehicle.model) == Config.VehicleClasses.Boats then
			for i=1, #Config.Garage.Dock.Locations do
				if Config.Garage.Dock.Locations[i].spawnLocation ~= nil then
					local thisDistance = Vdist(HighLife.Player.Pos, Config.Garage.Dock.Locations[i].spawnLocation)

					if closestDistance == nil then
						closestDistance = thisDistance
						closestLocation = Config.Garage.Dock.Locations[i].spawnLocation
					elseif Vdist(HighLife.Player.Pos, Config.Garage.Dock.Locations[i].spawnLocation) < closestDistance then
						closestDistance = thisDistance
						closestLocation = Config.Garage.Dock.Locations[i].spawnLocation
					end
				end
			end

			for i=1, #Config.Garage.DockInsurance.Locations do
				if Config.Garage.DockInsurance.Locations[i].spawnLocation ~= nil then
					local thisDistance = Vdist(HighLife.Player.Pos, Config.Garage.DockInsurance.Locations[i].spawnLocation)

					if closestDistance == nil then
						closestDistance = thisDistance
						closestLocation = Config.Garage.DockInsurance.Locations[i].spawnLocation
					elseif Vdist(HighLife.Player.Pos, Config.Garage.DockInsurance.Locations[i].spawnLocation) < closestDistance then
						closestDistance = thisDistance
						closestLocation = Config.Garage.DockInsurance.Locations[i].spawnLocation
					end
				end
			end

			for i=1, #Config.Garage.DockImpound.Locations do
				if Config.Garage.DockImpound.Locations[i].spawnLocation ~= nil then
					local thisDistance = Vdist(HighLife.Player.Pos, Config.Garage.DockImpound.Locations[i].spawnLocation)

					if closestDistance == nil then
						closestDistance = thisDistance
						closestLocation = Config.Garage.DockImpound.Locations[i].spawnLocation
					elseif Vdist(HighLife.Player.Pos, Config.Garage.DockImpound.Locations[i].spawnLocation) < closestDistance then
						closestDistance = thisDistance
						closestLocation = Config.Garage.DockImpound.Locations[i].spawnLocation
					end
				end
			end
		end

		spawnPos = closestLocation

		if spawnPos.w ~= nil then
			spawnHeading = spawnPos.w
		end
	end

	HighLife:CreateVehicle(thisVehicle.model, {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z + 0.5}, spawnHeading, true, true, function(vehicle)
		HighLife.Player.EntryCheck = true

		HighLife:SetVehicleProperties(vehicle, thisVehicle)
		TaskWarpPedIntoVehicle(HighLife.Player.Ped, vehicle, -1)

		SetVehicleEngineHealth(vehicle, thisHealth * 1.0)
		SetVehicleNeedsToBeHotwired(vehicle, false)

		if GetVehicleClass(vehicle) ~= Config.VehicleClasses.Cycles then
			LockVehicle(vehicle, true)

			TriggerEvent('HighLife:LockSystem:GiveKeys', GetVehicleNumberPlateText(vehicle), true)
		end

		-- Fuel for shit vehicles
		if GetVehicleClass(vehicle) == Config.VehicleClasses.Boats or GetVehicleClass(vehicle) == Config.VehicleClasses.Helicopters or GetVehicleClass(vehicle) == Config.VehicleClasses.Planes then
			SetVehicleFuel(vehicle, 100.0)
		end
	end)
end

-- FIXME: This should be included in the global namespace
function GetPlayerVehicles()
	HighLife.Other.GarageData = nil

	HighLife:ServerCallback('HighLife:Garage:GetPlayerVehicles', function(data)
		HighLife.Other.GarageData = data
	end)

	while HighLife.Other.GarageData == nil do
		Wait(1)
	end
end

function HighLife:AnyOpenGarage()
	return RageUI.Visible(RMenu:Get('garage', 'main')) or RageUI.Visible(RMenu:Get('garage', 'vehicle'))
end

function HighLife:OpenGarage()
	if currentAreaConfig ~= nil then
		MenuVariables.Garages.CurrentName = (currentAreaConfig.reference ~= nil and 'Owned Garage' or (currentAreaConfig.name ~= nil and currentAreaConfig.name .. ' ' or currentArea))
		MenuVariables.Garages.CurrentType = currentArea
		MenuVariables.Garages.CurrentLocation = currentAreaConfig

		RMenu:Get('garage', 'main'):SetTitle(MenuVariables.Garages.CurrentName)
		RMenu:Get('garage', 'main'):SetSubtitle((Config.Garage[MenuVariables.Garages.CurrentType].Subtitle ~= nil and Config.Garage[MenuVariables.Garages.CurrentType].Subtitle or nil))

		RageUI.Visible(RMenu:Get('garage', 'main'), true)
	end
end

CreateThread(function()
	while true do
		local thisTry = false

		for areaType,area in pairs(Config.Garage) do
			if not area.playerOwned then
				for k,v in pairs(area.Locations) do
					if v.disabled == nil then
						if Vdist(HighLife.Player.Pos, v.x, v.y, v.z) < (v.range ~= nil and v.range or Config.Garage_Settings.DefaultRange) then
							thisTry = true
							currentArea = areaType
							currentAreaConfig = v

							break
						end
					end

					Wait(25)
				end
			end
		end

		if HighLife.Other.GlobalPropertyData ~= nil then
			if HighLife.Other.ClosestProperty ~= nil and HighLife.Other.ClosestProperty.isGarage then
				if (HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].owner == HighLife.Player.Identifier) and (HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].character_reference == nil or (HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].character_reference == HighLife.Player.CurrentCharacterReference)) then
					thisTry = true

					currentArea = 'Garage'
					currentAreaConfig = HighLife.Other.ClosestProperty
				end
			end
		end

		if not thisTry then
			currentArea = nil
			currentAreaConfig = nil
		end

		Wait(2000)
	end
end)

CreateThread(function()
	local thisGarageName = ''

	for k,v in pairs(Config.Garage) do
		if v.Blip ~= nil then
			for j,thisLocation in pairs(v.Locations) do
				if thisLocation.disabled == nil then
					local thisBlip = AddBlipForCoord(thisLocation.x, thisLocation.y, thisLocation.z)

					SetBlipAsShortRange(thisBlip, 1)
					SetBlipSprite(thisBlip, v.Blip.sprite)
					SetBlipColour(thisBlip, v.Blip.color)
					SetBlipScale(thisBlip, 0.8)

					local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

					AddTextEntry(thisEntry, k)
					
					BeginTextCommandSetBlipName(thisEntry)
					EndTextCommandSetBlipName(thisBlip)
				end
			end
		end
	end

	local canUseGarage = true

	while true do
		if not HighLife.Player.CD and not HighLife.Player.InCharacterMenu and not HighLife.Player.HidingInTrunk and not HighLife.Player.Dead then
			if currentArea ~= nil and currentAreaConfig ~= nil then
				canUseGarage = true

				if currentAreaConfig.job ~= nil then
					canUseGarage = false

					for jobName, jobCount in pairs(currentAreaConfig.job) do
						if GetOnlineJobCount(jobName) >= jobCount then
							canUseGarage = true
						else
							canUseGarage = false
						end
					end
				end

				if HighLife.Player.InstanceCheckActive or HighLife.Settings.IsTest then
					DisplayHelpText((HighLife.Settings.IsTest and 'Vehicles are disabled due to an ongoing server test!' or '~y~Please wait while your vehicles are being valeted...'))
				else
					thisGarageName = (currentAreaConfig.reference ~= nil and 'Owned ' or (currentAreaConfig.name ~= nil and currentAreaConfig.name .. ' ' or ''))  .. currentArea

					if not HighLife.Player.InVehicle and not HighLife.Player.Cuffed and HighLife.Player.Dragging == nil then
						if not HighLife:AnyOpenGarage() then
							DisplayHelpText('~y~' .. thisGarageName .. ' ~INPUT_PICKUP~')

							if IsControlJustReleased(0, 38) then
								GetPlayerVehicles()

								HighLife:OpenGarage()
							end
						end
					elseif HighLife.Player.InVehicle then
						if GetEntitySpeed(HighLife.Player.Vehicle) < 2.0 then
							if currentArea == 'Garage' then
								if canUseGarage then
									if not hasCheckedVehicles then
										GetPlayerVehicles()
										hasCheckedVehicles = true
									end

									local carCount = 0
									local foundCar = false
									local garageFull = false

									if GetVehicleClass(HighLife.Player.Vehicle) ~= 15 then
										if HighLife.Player.VehicleSeat == -1 then
											local plate = string.trim(GetVehicleNumberPlateText(HighLife.Player.Vehicle))

											if plate ~= nil then
												if HighLife.Other.GarageData ~= nil then
													for k,v in pairs(HighLife.Other.GarageData) do
														if plate == nil then
															break
														end

														if v.vehicle.plate ~= nil then
															if string.lower(v.vehicle.plate) == string.lower(plate) then
																foundCar = true

																break
															end
														end
													end
												end
											end

											if foundCar or (IsCasinoValet() and currentAreaConfig.valet) then
												if currentAreaConfig ~= nil then
													DisplayHelpText('Press ~INPUT_PICKUP~ to ~y~store ~s~your current vehicle in the ~y~' .. (currentAreaConfig.name ~= nil and currentAreaConfig.name .. ' Garage' or currentArea))
													
													if IsControlJustReleased(0, 38) and not vehicleDeleteLock then
														vehicleDeleteLock = true

														local vehicleMods = HighLife:GetVehicleProperties(HighLife.Player.Vehicle)

														if not HighLife.Player.Special then
															if vehicleMods.modEngine > 2 then
																TriggerServerEvent('HCheat:magic', 'SV_EL')

																return
															end
														end

														local engineHealth = GetVehicleEngineHealth(HighLife.Player.Vehicle) or 1000
														
														TriggerServerEvent('HighLife:Garage:VanishVehicle', GetEntityModel(HighLife.Player.Vehicle), plate, json.encode(vehicleMods), engineHealth, currentAreaConfig.reference or currentAreaConfig.id, VehToNet(HighLife.Player.Vehicle), IsCasinoValet())
													end
												end
											elseif string.trim(GetVehicleNumberPlateText(HighLife.Player.Vehicle)) == MenuVariables.Garages.RentedBike then
												DisplayHelpText('Press ~INPUT_PICKUP~ to ~y~return ~s~your rented bicycle')

												if IsControlJustReleased(0, 38) and not vehicleDeleteLock then
													vehicleDeleteLock = true

													HighLife:ServerCallback('HighLife:Garage:BikeRental', function(success)
														MenuVariables.Garages.RentedBike = nil

														vehicleDeleteLock = false
													end, VehToNet(HighLife.Player.Vehicle), string.trim(GetVehicleNumberPlateText(HighLife.Player.Vehicle)), true)
												end
											else
												DisplayHelpText('GARAGE_NOSTORE')
											end
										end
									end
								else
									if currentAreaConfig.venueName ~= nil then
										DisplayHelpText(string.format('This garage can only be used when %s ~s~is open', currentAreaConfig.venueName))
									end
								end
							elseif currentArea == 'Heliport' or currentArea == 'PlaneParking' then
								if not hasCheckedVehicles then
									GetPlayerVehicles()
									hasCheckedVehicles = true
								end

								local foundCar = false

								if GetVehicleClass(HighLife.Player.Vehicle) == Config.VehicleClasses.Helicopters or GetVehicleClass(HighLife.Player.Vehicle) == Config.VehicleClasses.Planes then
									if HighLife.Player.VehicleSeat == -1 then
										local plate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

										for k,v in pairs(HighLife.Other.GarageData) do
											if string.lower(v.vehicle.plate) == string.lower(plate) then
												foundCar = true
												break
											end
										end

										if foundCar then
											DisplayHelpText('GARAGE_STORE')
											
											if IsControlJustReleased(0, 38) and not vehicleDeleteLock then
												vehicleDeleteLock = true

												local vehicleMods = HighLife:GetVehicleProperties(HighLife.Player.Vehicle)

												if not HighLife.Player.Special then
													if vehicleMods.modEngine > 2 then
														TriggerServerEvent('HCheat:magic', 'SV_EL')

														return
													end
												end

												local engineHealth = GetVehicleEngineHealth(HighLife.Player.Vehicle) or 1000
												
												TriggerServerEvent('HighLife:Garage:VanishVehicle', GetEntityModel(HighLife.Player.Vehicle), plate, json.encode(vehicleMods), engineHealth, nil, VehToNet(HighLife.Player.Vehicle))
											end
										else
											DisplayHelpText('GARAGE_NOSTORE_AIRCRAFT')
										end
									end
								end
							elseif currentArea == 'Dock' then
								if not hasCheckedVehicles then
									GetPlayerVehicles()
									hasCheckedVehicles = true
								end

								local foundCar = false

								if GetVehicleClass(HighLife.Player.Vehicle) == 14 then
									if HighLife.Player.VehicleSeat == -1 then
										local plate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

										for k,v in pairs(HighLife.Other.GarageData) do
											if string.lower(v.vehicle.plate) == string.lower(plate) then
												foundCar = true
												break
											end
										end

										if foundCar then
											DisplayHelpText('GARAGE_STORE')
											
											if IsControlJustReleased(0, 38) and not vehicleDeleteLock then
												vehicleDeleteLock = true

												local vehicleMods = HighLife:GetVehicleProperties(HighLife.Player.Vehicle)

												if not HighLife.Player.Special then
													if vehicleMods.modEngine > 2 then
														TriggerServerEvent('HCheat:magic', 'SV_EL')

														return
													end
												end

												local engineHealth = GetVehicleEngineHealth(HighLife.Player.Vehicle) or 1000
												
												TriggerServerEvent('HighLife:Garage:VanishVehicle', GetEntityModel(HighLife.Player.Vehicle), plate, json.encode(vehicleMods), engineHealth, nil, VehToNet(HighLife.Player.Vehicle))
											end
										else
											DisplayHelpText('GARAGE_NOSTORE_BOAT')
										end
									end
								end
							else
								if hasCheckedVehicles then
									hasCheckedVehicles = false
								end
							end
						end
					end
				end
			end

			if HighLife:AnyOpenGarage() and (currentArea == nil or currentArea ~= MenuVariables.Garages.CurrentType or HighLife.Player.HidingInTrunk or HighLife.Player.Dead) then
				RageUI.Visible(RMenu:Get('garage', 'main'), false)
				RageUI.Visible(RMenu:Get('garage', 'vehicle'), false)

				MenuVariables.Garages.CurrentLocation = nil
			end
		end

		Wait(1)
	end
end)