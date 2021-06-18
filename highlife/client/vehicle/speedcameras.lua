local ClosestCamera = nil
local ClosestCameraBlip = nil

CreateThread(function()
	local thisTry = false

	local thisDistance = nil

	while true do
		thisTry = false

		if HighLife.Player.InVehicle then
			if not IsAnyJobs(Config.Speedcameras.ExcludedJobs) then
				local thisClosest = nil

				for k,v in pairs(Config.Speedcameras.Cameras) do
					thisDistance = Vdist(HighLife.Player.Pos, v.pos)

					if thisDistance < Config.Speedcameras.CameraNearDistance then
						thisTry = true

						if thisClosest == nil then
							thisClosest = {
								camData = v,
								distance = thisDistance
							}
						else
							if thisDistance < thisClosest.distance then
								thisClosest = {
									camData = v,
									distance = thisDistance
								}
							end
						end
					end
				end

				if thisClosest ~= nil and ClosestCamera ~= thisClosest then
					ClosestCamera = thisClosest.camData
				end
			end
		end

		if not thisTry then
			ClosestCamera = nil
		end

		Wait(250)
	end
end)

RegisterNetEvent("HighLife:SpeedCamera:Notify")
AddEventHandler('HighLife:SpeedCamera:Notify', function(amount, street, limit, speed)
	DisplayImageNotification('bank', 'Payment Notification', 'You paid a ~r~$' .. amount .. ' ~s~speeding ticket~n~~n~Street: ~y~~h~' .. street .. '~h~~s~~n~~y~Speed Limit~s~: ' .. limit .. ' MPH~n~~r~Recorded Speed~s~: ' .. speed .. ' MPH', true)
end)

CreateThread(function()
	local lastCamera = nil

	local isValidVehicle = true

	while true do
		if ClosestCamera ~= nil then
			if lastCamera ~= ClosestCamera then
				lastCamera = ClosestCamera

				RemoveBlip(ClosestCameraBlip)

				ClosestCameraBlip = nil
			end

			if ClosestCameraBlip == nil then
				ClosestCameraBlip = AddBlipForCoord(ClosestCamera.pos)

				SetBlipSprite(ClosestCameraBlip, 184)
				SetBlipDisplay(ClosestCameraBlip, 5) -- minimap only
				SetBlipScale(ClosestCameraBlip, 0.3)
				SetBlipColour(ClosestCameraBlip, 46)
				SetBlipAsShortRange(ClosestCameraBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Speed Camera")
				EndTextCommandSetBlipName(ClosestCameraBlip)
			end
			
			if HighLife.Player.InVehicle and GetPedInVehicleSeat(HighLife.Player.Vehicle, -1) == HighLife.Player.Ped and not IsAnyJobs({'police', 'ambulance', 'fib'}) then
				if Vdist(HighLife.Player.Pos, ClosestCamera.pos) < Config.Speedcameras.RadarRadius then
					isValidVehicle = true

					local class = GetVehicleClass(HighLife.Player.Vehicle)

					for i=1, #Config.Speedcameras.ExcludedClasses do
						if class == Config.Speedcameras.ExcludedClasses[i] then
							isValidVehicle = false

							break
						end
					end

					if isValidVehicle then
						local thisSpeedLimit = ClosestCamera.limit

						local plate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)
						local current_speed = math.floor(GetEntitySpeed(HighLife.Player.Vehicle) * 2.236936)

						local captureSpeedLimit = (thisSpeedLimit + (thisSpeedLimit / 10) + 2)

						if current_speed >= captureSpeedLimit then
							local thisFine = math.floor((current_speed - thisSpeedLimit) * Config.Speedcameras.FineModifier)

							if thisFine < Config.Speedcameras.MinimumFine then
								thisFine = thisFine + Config.Speedcameras.MinimumFine
							end

							local street, crossing = GetStreetNameAtCoord(ClosestCamera.pos.x, ClosestCamera.pos.y, ClosestCamera.pos.z)
							local street_name = GetStreetNameFromHashKey(street)

							local thisData = json.encode({
								speed = current_speed,
								fine = math.floor(thisFine * 0.46),
								plate = plate,
								street = street_name,
								limit = thisSpeedLimit
							})

							Wait(5000)

							local workVehicle = false

							if DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.WorkVehicleOwner') then
								if DecorGetInt(HighLife.Player.Vehicle, 'Vehicle.WorkVehicleOwner') == GetPlayerServerId(HighLife.Player.Id) then
									workVehicle = true
								end
							end

							TriggerServerEvent('HighLife:SpeedCamera:sendFine', thisData, workVehicle)
						end
					end
				end
			end
		else
			if ClosestCameraBlip ~= nil then
				RemoveBlip(ClosestCameraBlip)

				ClosestCameraBlip = nil
			end
		end
		
		Wait(100)
	end
end)