local validTrailerNear = nil
local isVehicleAttached = false

local nearVehicles = nil

CreateThread(function()
	local trailerNearVehicle = nil

	while true do
		nearVehicles = nil
		validTrailerNear = nil
		isVehicleAttached = false

		if HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == Config.VehicleSeatIndex.Driver then
			if IsEntityAttachedToAnyVehicle(HighLife.Player.Vehicle) then
				isVehicleAttached = true
			else
				nearVehicles = GetNearbyVehicles(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, 5.0)

				if nearVehicles ~= nil then
					for i=1, #nearVehicles do
						trailerNearVehicle = nil

						trailerNearVehicle = nearVehicles[i]

						for trailerHash,trailerData in pairs(Config.Trailers) do
							if trailerHash == GetEntityModel(trailerNearVehicle) then
								if trailerData.anyClass == nil then
									for trailerAttachVehicle,trailerOffsetVector in pairs(trailerData) do
										if GetEntityModel(HighLife.Player.Vehicle) == trailerAttachVehicle then
											validTrailerNear = {
												offset = trailerOffsetVector,
												trailer = trailerNearVehicle
											}

											break
										end
									end
								else
									validTrailerNear = {
										trailer = trailerNearVehicle,
										offset = trailerData.initOffset,
										step = trailerData.offsetVectorStep
									}

									break
								end
							end
						end

						if validTrailerNear then break end
					end
				end
			end
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local trailerDecorStep = 0
	local thisOffsetVector = vector3(0.0, 0.0, 0.0)

	while true do
		trailerDecorStep = 0

		if HighLife.Player.InVehicle and GetEntitySpeedMPH(HighLife.Player.Vehicle) < 40.0 then
			if isVehicleAttached then
				DrawBottomText('Press ~y~E~w~ to ~y~detach ~s~from the trailer', 0.5, 0.95, 0.4)

				if IsKeyboard() and IsControlJustReleased(0, 38) then
					isVehicleAttached = false

					if validTrailerNear ~= nil and DecorExistOn(validTrailerNear.trailer, 'Vehicle.TrailerStep') then
						trailerDecorStep = DecorGetInt(validTrailerNear.trailer, 'Vehicle.TrailerStep')

						if trailerDecorStep <= 0 then
							DecorRemove(validTrailerNear.trailer, 'Vehicle.TrailerStep')
						else
							DecorSetInt(validTrailerNear.trailer, 'Vehicle.TrailerStep', trailerDecorStep - 1)
						end
					end

					DetachEntity(HighLife.Player.Vehicle)
				end
			elseif validTrailerNear ~= nil then
				DrawBottomText('Press ~y~E~w~ to ~g~attach ~s~to the vehicle', 0.5, 0.95, 0.4)

				if IsKeyboard() and IsControlJustReleased(0, 38) then
					if validTrailerNear.step ~= nil then
						trailerDecorStep = DecorGetInt(validTrailerNear.trailer, 'Vehicle.TrailerStep')

						if DecorExistOn(validTrailerNear.trailer, 'Vehicle.TrailerStep') then
							DecorSetInt(validTrailerNear.trailer, 'Vehicle.TrailerStep', trailerDecorStep + 1)
						else
							DecorSetInt(validTrailerNear.trailer, 'Vehicle.TrailerStep', 1)
						end

						thisOffsetVector = vector3(0.0, ((validTrailerNear.step * (0 or DecorGetInt(validTrailerNear.trailer, 'Vehicle.TrailerStep'))) * 1.0), 0.0)
					end

					AttachVehicleOnToTrailer(HighLife.Player.Vehicle, validTrailerNear.trailer, validTrailerNear.offset + thisOffsetVector, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), false)

					validTrailerNear = nil
				end
			end
		end

		Wait(1)
	end
end)