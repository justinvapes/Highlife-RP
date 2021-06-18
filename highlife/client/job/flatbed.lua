function InFlatbed()
	if GetPedInVehicleSeat(HighLife.Player.Vehicle, -1) == HighLife.Player.Ped then
		if IsVehicleModel(HighLife.Player.Vehicle, Config.Flatbed.model) then
			return true
		end
	end

	return false
end

local benson_model = GetHashKey('benson')
local benson_attach_vector = vector3(0.0, 0.0, 0.0)

function InBenson()
	local endPos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, 3.0, 0.0)

	local benson = StartShapeTestCapsule(HighLife.Player.Pos, endPos, 0.0, 10, HighLife.Player.Vehicle, 7)

	-- DrawLine(HighLife.Player.Pos, endPos, 255, 0, 0, 255)
			
	local f, g, h, i, test_vehicle = GetShapeTestResult(benson)

	if test_vehicle ~= nil and test_vehicle ~= -2 then
		if IsEntityAVehicle(test_vehicle) and IsVehicleModel(test_vehicle, benson_model) then
			return test_vehicle
		end
	end

	return nil
end

function GetVehicleBehind()
	local tow_car = StartShapeTestCapsule(GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, 1.0, 1.0), GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, -3.5, 0.0), 3.0, 10, HighLife.Player.Vehicle, 7)
			
	local f, g, h, i, test_vehicle = GetShapeTestResult(tow_car)

	if test_vehicle ~= nil and test_vehicle ~= -2 then
		if IsEntityAVehicle(test_vehicle) then
			return test_vehicle
		end
	end

	return nil
end

RegisterNetEvent('HighLife:Towing:LoadVehicle')
AddEventHandler('HighLife:Towing:LoadVehicle', function(flatbedNetID, vehicleNetID, isAttach)
	local flatbed = NetToVeh(flatbedNetID)
	local vehicle = NetToVeh(vehicleNetID)

	if isAttach then
		AttachEntityToEntity(vehicle, flatbed, GetEntityBoneIndexByName(flatbed, 'bodyshell'), Config.Flatbed.bed_pos, 0.0, 0.0, 0.0, true, true, false, true, 20, true)
	else
		DetachEntity(vehicle, true, true)

		SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -10.0, -2.0))

		SetVehicleOnGroundProperly(vehicle)
	end
end)

CreateThread(function()
	while true do
		if not HighLife.Player.Dead and HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == -1 then
			-- local foundBenson = InBenson() -- Disabled for performance reasons

			if not DecorExistOn(HighLife.Player.Vehicle, 'Attached.Entity') then
				if foundBenson ~= nil then
					DisplayHelpText('~INPUT_RELOAD~ to load your vehicle')

					if IsDisabledControlJustPressed(0, 45) then
						SetVehicleHandbrake(HighLife.Player.Vehicle, true)

						local thisEntityID = NetworkGetNetworkIdFromEntity(foundBenson)

						DecorSetInt(HighLife.Player.Vehicle, 'Attached.Entity', thisEntityID)

						AttachEntityToEntity(HighLife.Player.Vehicle, foundBenson, GetEntityBoneIndexByName(foundBenson, 'bodyshell'), GetOffsetFromEntityGivenWorldCoords(foundBenson, GetEntityCoords(HighLife.Player.Vehicle)), vector3(0.0, -1.0, 0.0), true, true, false, true, 20, true)
					end
				end
			else
				-- GetEntityBoneIndexByName(foundBenson, 'bodyshell')
				DisplayHelpText('~INPUT_RELOAD~ to unload your vehicle')

				if IsDisabledControlJustPressed(0, 45) then
					local attachedNetID = DecorGetInt(HighLife.Player.Vehicle, 'Attached.Entity')

					DecorRemove(HighLife.Player.Vehicle, 'Attached.Entity')

					DetachEntity(HighLife.Player.Vehicle, true, true)
					
					SetVehicleHandbrake(HighLife.Player.Vehicle, false)
				end
			end

			if InFlatbed() then
				if GetIsVehicleEngineRunning(HighLife.Player.Vehicle) then
					if DecorExistOn(HighLife.Player.Vehicle, 'Flatbed.TowingEntity') then
						local towedVehicleNetID = DecorGetInt(HighLife.Player.Vehicle, 'Flatbed.TowingEntity')

						if towedVehicleNetID ~= 0 then
							local thisEntity = NetworkGetEntityFromNetworkId(towedVehicleNetID)

							if DoesEntityExist(thisEntity) then
								if (GetEntitySpeed(HighLife.Player.Vehicle) * 2.236936) < 5.0 then
									DrawMarker(1, GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, -10.0, -2.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.0, 4.0, 4.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								end

								if (GetEntitySpeed(HighLife.Player.Vehicle) * 2.236936) < 2.0 then
									if not HighLife.Player.IsTyping then
										DisplayHelpText('TOWING_UNLOAD')

										if IsDisabledControlJustPressed(0, 45) then
											local currentFlatbed = HighLife.Player.Vehicle

											SetVehicleHandbrake(currentFlatbed, true)

											Wait(10000)

											NetworkRequestControlOfEntity(thisEntity)

											Wait(200)

											DecorRemove(currentFlatbed, 'Flatbed.TowingEntity')

											if NetworkHasControlOfEntity(thisEntity) then
												DetachEntity(thisEntity, true, true)

												SetEntityCoords(thisEntity, GetOffsetFromEntityInWorldCoords(currentFlatbed, 0.0, -10.0, -2.0))

												SetVehicleOnGroundProperly(thisEntity)
											else
												local thisFlatbedID = NetworkGetNetworkIdFromEntity(currentFlatbed)
												local thisEntityID = NetworkGetNetworkIdFromEntity(thisEntity)

												TriggerServerEvent('HighLife:Towing:LoadVehicle', thisFlatbedID, thisEntity, NetworkGetEntityOwner(thisEntity), false)
											end

											SetVehicleHandbrake(currentFlatbed, false)
										end
									end
								end
							else
								DecorRemove(HighLife.Player.Vehicle, 'Flatbed.TowingEntity')
							end
						else
							DecorRemove(HighLife.Player.Vehicle, 'Flatbed.TowingEntity')
						end
					else
						-- free to load
						local availableVehicle = GetVehicleBehind()

						if availableVehicle ~= nil then
							local vehicleClass = GetVehicleClass(availableVehicle)

							if vehicleClass ~= 14 and vehicleClass ~= 15 and vehicleClass ~= 16 and vehicleClass ~= 16 and vehicleClass ~= 21 then
								if not HighLife.Player.IsTyping then
									DisplayHelpText('TOWING_LOAD')
									
									if IsDisabledControlJustPressed(0, 45) then
										local currentFlatbed = HighLife.Player.Vehicle

										local thisFlatbedID = NetworkGetNetworkIdFromEntity(currentFlatbed)
										local thisEntityID = NetworkGetNetworkIdFromEntity(availableVehicle)

										SetVehicleHandbrake(currentFlatbed, true)

										DisplayHelpText('TOWING_LOADING')

										NetworkRequestControlOfEntity(availableVehicle)

										Wait(15000)

										NetworkRequestControlOfEntity(availableVehicle)

										Wait(200)

										if Vdist(currentFlatbed, availableVehicle) < 10.0 then
											DecorSetInt(currentFlatbed, 'Flatbed.TowingEntity', thisEntityID)
											
											if NetworkHasControlOfEntity(availableVehicle) then
												AttachEntityToEntity(availableVehicle, currentFlatbed, GetEntityBoneIndexByName(currentFlatbed, 'bodyshell'), Config.Flatbed.bed_pos, 0.0, 0.0, 0.0, true, true, false, true, 20, true)
											else
												TriggerServerEvent('HighLife:Towing:LoadVehicle', thisFlatbedID, thisEntityID, NetworkGetEntityOwner(availableVehicle), true)
											end
										else
											DisplayHelpText('TOWING_TOOFAR')
										end

										SetVehicleHandbrake(currentFlatbed, false)
									end
								end
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end)