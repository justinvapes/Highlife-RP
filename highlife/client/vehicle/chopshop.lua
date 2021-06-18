-- @TODO: Ignore player vehicle - this vehicle has a tracker on it

local closestLocation = {
	name, shop = nil
}

local hasGivenHint = false

local isChopping = false

RegisterNetEvent('HighLife:ChopShop:ReturnData')
AddEventHandler('HighLife:ChopShop:ReturnData', function(chopshopData)
	HighLife.Player.ChopshopData = json.decode(chopshopData)
end)

CreateThread(function()
	local thisVehicle = nil
	local nearVehicles = nil

	while true do
		if HighLife.Player.Job.name == 'unemployed' and not hasGivenHint and HighLife.Player.ChopshopData ~= nil and HighLife.Player.ChopshopData.task_vehicle ~= nil then
			nearVehicles = GetNearbyVehicles(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, 100.0)

			for i=1, #nearVehicles do
				thisVehicle = nearVehicles[i]

				if thisVehicle ~= HighLife.Player.Vehicle then
					if string.match(GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(thisVehicle))), GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(HighLife.Player.ChopshopData.task_vehicle)))) then
						local chopshopVehiclePoint = CreateTrackedPoint()

						SetTrackedPointInfo(chopshopVehiclePoint, GetEntityCoords(thisVehicle), 3.0)

						Wait(100)

						if IsTrackedPointVisible(chopshopVehiclePoint) then
							local canHint = true

							if HighLife.Player.InVehicle then
								if GetEntitySpeedMPH(HighLife.Player.Vehicle) > 50.0 then
									canHint = false
								end
							end

							if canHint then
								hasGivenHint = true

								DisplayHelpText('CHOPSHOP_NOTICE')

								PlaySoundFrontend(-1, "Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset", 0)

								SetGameplayVehicleHint(thisVehicle, 0.0, 0.0, 0.0, false, 3000, 1200, 1200)

								break
							end
						end

						DestroyTrackedPoint(chopshopVehiclePoint)
					end
				end
			end
		end

		Wait(1500)
	end
end)

CreateThread(function()
	local foundLocation = false

	while true do
		if HighLife.Player.Job.name == 'unemployed' then
			foundLocation = false

			for k,v in pairs(Config.ChopShop.Locations) do
				if Vdist(HighLife.Player.Pos, v.location) < 15.0 then
					closestLocation.name = k
					closestLocation.shop = v

					foundLocation = true
				end
			end

			if not foundLocation then
				if not isChopping then
					closestLocation = {
						name, shop = nil
					}
				end
			end
		end

		Wait(3000)
	end
end)

CreateThread(function()
	for k,v in pairs(Config.ChopShop.Locations) do
		if not v.whitelisted then
			local blip = AddBlipForCoord(v.location)

			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.8)
			SetBlipSprite(blip, 527)
			SetBlipColour(blip, 24)
			SetBlipAsShortRange(blip, true)

			local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

			AddTextEntry(thisEntry, 'Chopshop')
			
			BeginTextCommandSetBlipName(thisEntry)
			EndTextCommandSetBlipName(blip)
		end 
	end

	while true do
		if closestLocation.shop ~= nil and HighLife.Player.ChopshopData ~= nil then
			if not HighLife.Player.InVehicle then
				if Vdist(closestLocation.shop.location, HighLife.Player.Pos) < 5.0 then
					local currentText = 'Press [~y~E~s~] to get a new task\nYou currently have ~y~' .. HighLife.Player.ChopshopData.points .. ' points ~s~available'

					if HighLife.Player.ChopshopData.task_vehicle ~= nil then
						if HighLife.Player.ChopshopData.shop ~= closestLocation.name then
							currentText = '~r~You already have a task with another chop shop'				
						else
							currentText = '~g~You have a task to get us a ~g~' .. GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(HighLife.Player.ChopshopData.task_vehicle)))

							if HighLife.Player.ChopshopData.points >= closestLocation.shop.skip_task_points then
								currentText = '~g~You have a task to get us a ~g~' .. GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(HighLife.Player.ChopshopData.task_vehicle))) .. '~s~\nPress [~y~G~s~] to skip this task for ~y~' .. closestLocation.shop.skip_task_points .. ' ~s~points'
							
								if GetLastInputMethod(2) and IsControlJustReleased(0, 47) then
									TriggerServerEvent('HighLife:ChopShop:SkipTask', closestLocation.name)

									hasGivenHint = false
								end
							end
						end
					end

					Draw3DCoordText(closestLocation.shop.location.x, closestLocation.shop.location.y, closestLocation.shop.location.z, currentText)

					if HighLife.Player.ChopshopData.task_vehicle == nil then
						if IsControlJustReleased(0, 38) then
							local task_vehicle = closestLocation.shop.valid_vehicles[math.random(#closestLocation.shop.valid_vehicles)]
							local task_vehicle_name = GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(task_vehicle)))

							if task_vehicle ~= nil then
								TriggerServerEvent('HighLife:ChopShop:AddTask', closestLocation.name, task_vehicle, task_vehicle_name)
							end
						end
					end
				end
			else
				local canChop = true
				local vehicle = HighLife.Player.Vehicle
				local vehicleModel = GetEntityModel(vehicle)
				local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(vehicleModel))

				if HighLife.Player.ChopshopData.task_vehicle ~= nil then
					if HighLife.Player.ChopshopData.shop == closestLocation.name then
						local similarModel = false

						if string.match(GetLabelText(GetDisplayNameFromVehicleModel(vehicleModel)), GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(HighLife.Player.ChopshopData.task_vehicle)))) then
							similarModel = true
						end

						if HighLife.Player.VehicleSeat == -1 then
							if GetLabelText(GetDisplayNameFromVehicleModel(vehicleModel)) == GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(HighLife.Player.ChopshopData.task_vehicle))) or similarModel then
								DisplayHelpText('CHOPSHOP_CHOPVEHICLE')

								if IsControlJustReleased(0, 38) then
									if GetVehicleNumberOfPassengers(vehicle) > 0 then
										canChop = false
									end

									if canChop then
										TaskLeaveVehicle(HighLife.Player.Ped, vehicle, 0)

										isChopping = true

										if DecorExistOn(vehicle, 'Vehicle.CSE') then
											TriggerServerEvent('HCheat:magic', 'SV_CV')
										end

										DisplayHelpText('CHOPSHOP_PROGRESS')

										FreezeEntityPosition(vehicle, true)

										CreateThread(function()
											while DoesEntityExist(vehicle) do
												SetVehicleHandbrake(vehicle, true)
												SetVehicleEngineOn(vehicle, true, true, true)
												SetVehicleDoorsLocked(vehicle, 2)

												Wait(0)
											end
										end)

										local vehicle_data = {
											model = HighLife.Player.ChopshopData.task_vehicle,
											name = vehicleName,
											body = 1000 - GetVehicleBodyHealth(vehicle),
											engine = 1000 - GetVehicleEngineHealth(vehicle),
											class = GetVehicleClassFromName(vehicleModel) + 1
										}

										if not HighLife.Player.Debug then
											Wait(1000)

											for i=0, 6 do
												if DoesVehicleHaveDoor(vehicle, i) then
													if not IsVehicleDoorDamaged(vehicle, i) then
														SetVehicleDoorOpen(vehicle, i, false, false)

														Wait(1000)
														
														SetVehicleDoorBroken(vehicle, i, false)
														
														Wait(1000)
													end
												end
											end
										end
										
										TriggerServerEvent('HighLife:Vehicle:RequestOwnerDelete', GetPlayerServerId(NetworkGetEntityOwner(vehicle)), NetworkGetNetworkIdFromEntity(vehicle))
										
										HighLife:DeleteVehicle(vehicle)

										TriggerServerEvent('HighLife:ChopShop:CompleteTask', closestLocation.name, vehicle_data)

										hasGivenHint = false
										isChopping = false
									else
										DisplayHelpText('You cannot chop a vehicle with someone inside')

										Wait(3000)
									end
								end
							else
								DisplayHelpText('CHOPSHOP_NOCHOP')
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end)