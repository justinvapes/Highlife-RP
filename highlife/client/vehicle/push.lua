local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local Vehicle = {Coords, Vehicle, Dimension, Distance = nil, IsInFront = false}

CreateThread(function()
	local closestVehicle = nil

	while true do
		if not HighLife.Player.InVehicle then
			closestVehicle = GetClosestVehicleEnumerated(6.0)

			if closestVehicle ~= nil and DoesEntityExist(closestVehicle) then
				local vehicleCoords = GetEntityCoords(closestVehicle)
				local Distance = GetDistanceBetweenCoords(GetEntityCoords(HighLife.Player.Ped), vehicleCoords, true)
				local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)

				if Distance < 3.4 and not IsPedInAnyVehicle(HighLife.Player.Ped) and GetVehicleClass(closestVehicle) ~= 13 and GetVehicleClass(closestVehicle) ~= 14 then
					Vehicle.Coords = vehicleCoords
					Vehicle.Dimensions = dimension
					Vehicle.Vehicle = closestVehicle
					Vehicle.Distance = Distance
					
					if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(HighLife.Player.Ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(HighLife.Player.Ped), true) then
						Vehicle.IsInFront = false
					else
						Vehicle.IsInFront = true
					end
				else
					Vehicle = {Coords, Vehicle, Dimension, Distance = nil, IsInFront = false}
				end
			end
		end

		Wait(500)
	end
end)


CreateThread(function()
	RequestAnimDict('missfinale_c2ig_11')
		
	while not HasAnimDictLoaded('missfinale_c2ig_11') do
		Wait(0)
	end

	while true do 
		if not HighLife.Player.Cuffed and not HighLife.Player.Dead and Vehicle.Vehicle ~= nil and not IsVehicleStuckOnRoof(Vehicle.Vehicle) and IsVehicleOnAllWheels(Vehicle.Vehicle) and not HighLife.Player.InVehicle then
			if IsVehicleSeatFree(Vehicle.Vehicle, -1) and (GetVehicleEngineHealth(Vehicle.Vehicle) <= 100.0 or GetVehicleFuelLevel(Vehicle.Vehicle) <= 10.0) then
				Draw3DCoordText(Vehicle.Coords.x, Vehicle.Coords.y, Vehicle.Coords.z, 'Hold [~y~SHIFT~w~] and [~y~E~w~] to push the vehicle')
				
				if IsControlPressed(0, 21) and IsControlJustPressed(0, 38) then
					NetworkRequestControlOfEntity(Vehicle.Vehicle)
					
					local coords = GetEntityCoords(HighLife.Player.Ped)
					
					if Vehicle.IsInFront then    
						AttachEntityToEntity(HighLife.Player.Ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
					else
						AttachEntityToEntity(HighLife.Player.Ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
					end
					
					TaskPlayAnim(HighLife.Player.Ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
					
					Wait(200)

					while true do
						foundTask = false

						if IsDisabledControlPressed(0, 34) then
							foundTask = true

							SetVehicleSteeringAngle(Vehicle.Vehicle, 25.0)
						end

						if IsDisabledControlPressed(0, 9) then
							foundTask = true

							SetVehicleSteeringAngle(Vehicle.Vehicle, -25.0)
						end

						if not foundTask then
							SetVehicleSteeringAngle(Vehicle.Vehicle, 0.0)
						end

						if Vehicle.IsInFront then
							SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
						else
							SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
						end

						if HasEntityCollidedWithAnything(Vehicle.Vehicle) then
							SetVehicleOnGroundProperly(Vehicle.Vehicle)
						end

						if not IsDisabledControlPressed(0, 38) then
							DetachEntity(HighLife.Player.Ped, false, false)
							StopAnimTask(HighLife.Player.Ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
							FreezeEntityPosition(HighLife.Player.Ped, false)

							RemoveAnimDict('missfinale_c2ig_11')

							break
						end
						
						Wait(5)
					end
				end
			end
		end
		
		Wait(5)
	end
end)