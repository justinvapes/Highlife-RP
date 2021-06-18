RMenu.Add('garage', 'main', RageUI.CreateMenu('Default Garage', '~y~Your collection of vehicles'))
RMenu.Add('garage', 'vehicle', RageUI.CreateSubMenu(RMenu:Get('garage', 'main'), 'Vehicle Name', nil))

local repairing_vehicles = {}

CreateThread(function()
	local thisClass = nil

	local ownedGarage = false
	local canUseLocation = true
	local canAddVehicle = false
	local thisRetrieveType = nil
	local availableVehicle = true

	local thisVehicleCount = 0

	local thisRentalIndex = 1

	local rental_vehicles = {
		bmx = {
			name = 'BMX'
		},
		fixter = {
			name = 'Fixter'
		},
		cruiser = {
			name = 'Cruiser'
		},
		scorcher = {
			name = 'Scorcher'
		},
		tribike = {
			name = 'Whippet Race Bike'
		},
	}

	local rental_bikes = {}

	for rentalModel,rentalData in pairs(rental_vehicles) do
		table.insert(rental_bikes, rentalData.name)
	end

	while true do
		if MenuVariables.Garages.CurrentLocation ~= nil then
			RageUI.IsVisible(RMenu:Get('garage', 'main'), true, false, true, function()
				ownedGarage = false
				canUseLocation = true

				RageUI.ButtonWithStyle('Total Vehicles', 'The number of vehicles you own', { RightLabel = thisVehicleCount }, true)

				RageUI.Separator()

				-- not an owned garage
				if MenuVariables.Garages.CurrentLocation.reference == nil then
					RageUI.List("Rent Bicycle (~g~$100~s~)", rental_bikes, thisRentalIndex, (MenuVariables.Garages.RentedBike == nil and 'Choose from our range of city bicycles! You can return the bicycle ~y~at any time ~s~to ~g~get your money back' or 'You already rented a bike from us, bring it back to use our service again.'), {}, (MenuVariables.Garages.RentedBike == nil), function(Hovered, Active, Selected, Index)
						if Active then
							if thisRentalIndex ~= Index then
								thisRentalIndex = Index
							end
						end

						if Selected then
							-- do callback
							local thisPlate = 'JSON' .. math.random(1000, 9999)

							HighLife:ServerCallback('HighLife:Garage:BikeRental', function(success)
								if success then
									for rentalModel,rentalData in pairs(rental_vehicles) do
										if rentalData.name == rental_bikes[thisRentalIndex] then

											local thisModel = GetHashKey(rentalModel)

											if not HasModelLoaded(thisModel) then
												RequestModel(thisModel)

												while not HasModelLoaded(thisModel) do
													Wait(1)
												end
											end

											local thisVehicle = CreateVehicle(thisModel, HighLife.Player.Pos, HighLife.Player.Heading, true, false)

											SetModelAsNoLongerNeeded(thisModel)

											SetVehicleNumberPlateText(thisVehicle, thisPlate)

											MenuVariables.Garages.RentedBike = thisPlate

											SetVehicleCustomPrimaryColour(thisVehicle, 70, 225, 60)

											SetPedIntoVehicle(HighLife.Player.Ped, thisVehicle, -1)

											SetVehicleDirtLevel(thisVehicle, 0.0)

											RageUI.Visible(RMenu:Get('garage', 'main'), false)

											Notification_AboveMap('Make sure to bring it back to get your ~g~money ~s~back!')

											Wait(1000)

											StartVehicleHorn(thisVehicle, 500, 0, 0)

											Entity(thisVehicle).state:set('cleanup_time', GetNetworkTime() + (900 * 1000), true)

											break
										end
									end
								end
							end, nil, thisPlate, false)
						end
					end)

					RageUI.Separator()
				end

				if Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense ~= nil then
					for i=1, #Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense do
						if not HighLife.Player.Licenses[Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense[i]] then
							canUseLocation = false

							break
						end
					end
				end

				if canUseLocation and HighLife.Other.GarageData ~= nil then
					thisVehicleCount = 0

					for k,v in pairs(HighLife.Other.GarageData) do
						canAddVehicle = false

						thisClass = GetVehicleClassFromName(v.vehicle.model)

						if Config.Garage[MenuVariables.Garages.CurrentType].IgnoreClasses ~= nil then
							canAddVehicle = true

							for i=1, #Config.Garage[MenuVariables.Garages.CurrentType].IgnoreClasses do
								if thisClass == Config.Garage[MenuVariables.Garages.CurrentType].IgnoreClasses[i] then
									canAddVehicle = false

									break
								end
							end
						end

						if Config.Garage[MenuVariables.Garages.CurrentType].ValidClasses ~= nil then
							canAddVehicle = false 

							for i=1, #Config.Garage[MenuVariables.Garages.CurrentType].ValidClasses do
								if thisClass == Config.Garage[MenuVariables.Garages.CurrentType].ValidClasses[i] then
									canAddVehicle = true

									break
								end
							end
						end

						if Config.Garage[MenuVariables.Garages.CurrentType].ValidStatus ~= nil then
							if v.status ~= Config.Garage[MenuVariables.Garages.CurrentType].ValidStatus then
								canAddVehicle = false
							end
						end

						if v.reference ~= nil and v.reference ~= HighLife.Player.CurrentCharacterReference then
							canAddVehicle = false
						end

						if canAddVehicle then
							availableVehicle = true

							if MenuVariables.Garages.CurrentLocation.reference ~= nil then
								ownedGarage = true

								if MenuVariables.Garages.CurrentLocation.reference ~= v.location then
									availableVehicle = false
								end
							end

							if availableVehicle then
								local thisStatus = Config.Garage_Settings.StatusTypes[v.status]

								local availableHere = true

								local thisLocation = 'Owned Garage'

								for i=1, #Config.Garage.Garage.Locations do
									local useNumber = tonumber(v.location)

									if Config.Garage.Garage.Locations[i].id == (useNumber or v.location) then
										thisLocation = Config.Garage.Garage.Locations[i].name

										break
									end
								end

								local thisVehicleName = GetLabelText(GetDisplayNameFromVehicleModel(v.vehicle.model))

								if thisVehicleName == 'NULL' then
									thisVehicleName = GetDisplayNameFromVehicleModel(v.vehicle.model)
								end

								if v.status == 0 or v.status == 2 then
									availableHere = false
								end

								if not Config.Garage[MenuVariables.Garages.CurrentType].IgnoreLocation then
									if tonumber(v.location) ~= nil then
										if tonumber(v.location) ~= 0 then
											if MenuVariables.Garages.CurrentLocation.id ~= tonumber(v.location) then
												availableHere = false

												thisStatus.color = '~y~'
											end
										end
									else
										if MenuVariables.Garages.CurrentLocation.reference ~= v.location then
											availableHere = false

											thisStatus.color = '~y~'
										end
									end
								end

								if availableHere then
									thisStatus.color = '~g~'
								end

								if v.status == 2 then
									thisStatus.color = '~b~'
								end

								if v.status == 0 then
									thisStatus.color = '~r~'
								end

								local descriptionText = thisStatus.color .. thisStatus.text

								if thisStatus.text == 'Available' then
									if not Config.Garage[MenuVariables.Garages.CurrentType].IgnoreLocation then
										descriptionText = descriptionText .. ' ~s~- ' .. thisLocation
									end
								end

								if not ownedGarage or (ownedGarage and availableHere) then
									RageUI.ButtonWithStyle(thisStatus.color .. thisVehicleName, descriptionText, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
										if Selected then
											MenuVariables.Garages.CurrentVehicle = {
												data = v,
												name = thisVehicleName,
												available = availableHere,
												location = thisLocation,
												plate = string.trim(v.vehicle.plate)
											}

											RMenu:Get('garage', 'vehicle'):SetTitle(MenuVariables.Garages.CurrentVehicle.name)
											RMenu:Get('garage', 'vehicle'):SetSubtitle((Config.Garage[MenuVariables.Garages.CurrentType].Subtitle ~= nil and Config.Garage[MenuVariables.Garages.CurrentType].Subtitle or nil))
										end
									end, RMenu:Get('garage', 'vehicle'))
								end
							end

							thisVehicleCount = thisVehicleCount + 1
						end
					end

					if thisVehicleCount == 0 then
						RageUI.ButtonWithStyle('You have no vehicles to retrieve', nil, {}, true)
					end
				else
					if Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense ~= nil then
						for i=1, #Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense do
							if not HighLife.Player.Licenses[Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense[i]] then
								RageUI.ButtonWithStyle('You need a ~y~' .. string.lower(Config.Licenses[Config.Garage[MenuVariables.Garages.CurrentType].RequireLicense[i]].name) .. ' license ~s~to retrieve a vehicle', 'You need this to continue', {}, true)
							end
						end
					end
				end
			end)

			RageUI.IsVisible(RMenu:Get('garage', 'vehicle'), true, false, true, function()
				thisRetrieveType = nil

				if MenuVariables.Garages.CurrentVehicle.data ~= nil then
					RageUI.ButtonWithStyle('Plate', 'The number plate of the vehicle', { RightLabel = MenuVariables.Garages.CurrentVehicle.plate }, true)

					if Config.Garage[MenuVariables.Garages.CurrentType].ValidStatus ~= nil then
						if Config.Garage[MenuVariables.Garages.CurrentType].ValidStatus == 0 then
							thisRetrieveType = 'Insurance'
						elseif Config.Garage[MenuVariables.Garages.CurrentType].ValidStatus == 2 then
							thisRetrieveType = 'Impound'
						end

						if thisRetrieveType ~= nil then
							local thisGrade = 0
							local thisPriceText = nil
							local thisPrice = 0

							if thisRetrieveType == 'Insurance' then
								if HighLife.Other.VehiclePrices[MenuVariables.Garages.CurrentVehicle.data.vehicle.model] ~= nil then					
									for price,modifier in pairs(Config.ImpoundInsurance[thisRetrieveType .. 'ValueModifiers']) do
										if HighLife.Other.VehiclePrices[MenuVariables.Garages.CurrentVehicle.data.vehicle.model] > price then
											if thisPrice ~= 0 then
												thisGrade = thisGrade + 1
											end

											thisPrice = math.floor((HighLife.Other.VehiclePrices[MenuVariables.Garages.CurrentVehicle.data.vehicle.model] * modifier) / 100)
										end
									end
								else
									thisPriceText = 'FREE'
								end
							elseif thisRetrieveType == 'Impound' then
								if MenuVariables.Garages.CurrentVehicle.data.price ~= nil then					
									thisPrice = math.floor(MenuVariables.Garages.CurrentVehicle.data.price)
								else
									thisPriceText = 'FREE'
								end
							end

							RageUI.ButtonWithStyle('Price', 'The vehicles ' .. string.lower(thisRetrieveType) .. ' cost', { RightLabel = ('$' .. comma_value(thisPrice)) }, true)

							if thisRetrieveType == 'Insurance' then
								RageUI.ButtonWithStyle('Insurance Category', 'This rating dictates the recovery price', { RightLabel = thisGrade or 0 }, true)
							end

							RageUI.Separator()

							RageUI.ButtonWithStyle('~g~Retrieve Vehicle', 'Pay the price to recover the vehicle', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent('HighLife:Trunk:WipeInventory', MenuVariables.Garages.CurrentVehicle.plate)

									if CanRegisterMissionVehicles(1) then
										TriggerServerEvent('HighLife:Garage:ContemplateVehicle', MenuVariables.Garages.CurrentVehicle.data.id)
									
										PlayBoughtSound()

										RageUI.CloseAll()
									else
										Notification_AboveMap('GARAGE_CANT_DELIVER')
									end
								end
							end)
						end
					else
						if not Config.Garage[MenuVariables.Garages.CurrentType].IgnoreLocation then
							RageUI.ButtonWithStyle('Location', 'The location of the vehicle', { RightLabel = (MenuVariables.Garages.CurrentVehicle.data.status == 1 and MenuVariables.Garages.CurrentVehicle.location or (MenuVariables.Garages.CurrentVehicle.data.status == 0 and '~o~Insurance' or (MenuVariables.Garages.CurrentVehicle.data.status == 2 and '~b~LSPD Impound'))) }, true)
						end

						RageUI.Separator()

						if MenuVariables.Garages.CurrentVehicle.available and MenuVariables.Garages.CurrentVehicle.data.status == 1 and MenuVariables.Garages.CurrentVehicle.data.damage ~= 1000 then
							RageUI.ButtonWithStyle('~y~Damage', 'Current vehicle damage', { RightLabel = math.floor((1000 - MenuVariables.Garages.CurrentVehicle.data.damage) / 10) .. '% (~r~$' .. math.floor(((1000 - MenuVariables.Garages.CurrentVehicle.data.damage) * Config.Garage_Settings.VehicleClassModifiers[(GetVehicleClassFromName(MenuVariables.Garages.CurrentVehicle.data.vehicle.model) + 1)]) * 0.46) .. '~s~)' }, true)

							RageUI.ButtonWithStyle('Repair Vehicle', '~y~More expensive, but handy', { RightLabel = '→→→' }, (MenuVariables.Garages.CurrentVehicle.data.repair_time == nil), function(Hovered, Active, Selected)
								if Selected then
									HighLife:ServerCallback('HighLife:Garage:RepairVehicle', function(hasPaid)
										if hasPaid then
											PlayBoughtSound()

											repairing_vehicles[MenuVariables.Garages.CurrentVehicle.data.id] = GameTimerPool.GlobalGameTime + (((1000 - MenuVariables.Garages.CurrentVehicle.data.damage) * 0.07) * 1000)

											MenuVariables.Garages.CurrentVehicle.data.damage = 1000
										end
									end, MenuVariables.Garages.CurrentVehicle.plate, math.floor(((1000 - MenuVariables.Garages.CurrentVehicle.data.damage) * Config.Garage_Settings.VehicleClassModifiers[(GetVehicleClassFromName(MenuVariables.Garages.CurrentVehicle.data.vehicle.model) + 1)]) * 0.46))
								end
							end)

							RageUI.Separator()
						end

						if repairing_vehicles[MenuVariables.Garages.CurrentVehicle.data.id] ~= nil then
							RageUI.ButtonWithStyle('~y~Repairing ~s~(' .. math.round(((repairing_vehicles[MenuVariables.Garages.CurrentVehicle.data.id] - GameTimerPool.GlobalGameTime) / 1000), 2) .. ')', 'Your vehicle is being repaired', { RightLabel = "→→→" }, false)

							if GameTimerPool.GlobalGameTime > repairing_vehicles[MenuVariables.Garages.CurrentVehicle.data.id] then
								repairing_vehicles[MenuVariables.Garages.CurrentVehicle.data.id] = nil
							end
						else
							RageUI.ButtonWithStyle((MenuVariables.Garages.CurrentVehicle.available and '~g~Retrieve Vehicle' or '~o~Unavailable'), (MenuVariables.Garages.CurrentVehicle.available and (CanRegisterMissionVehicles(1) and 'Retrieve this vehicle' or 'Cannot retrieve at this time') or 'Vehicle not at this location'), { RightLabel = "→→→" }, (MenuVariables.Garages.CurrentVehicle.available and CanRegisterMissionVehicles(1)), function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent('HighLife:Garage:ContemplateVehicle', MenuVariables.Garages.CurrentVehicle.data.id)

									RageUI.CloseAll()
								end
							end)
						end
					end
				end
			end)
		end

		Wait(1)
	end
end)