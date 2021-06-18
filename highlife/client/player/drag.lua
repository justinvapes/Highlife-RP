local ambulance_models = {
	[GetHashKey('steedamb')] = {
		x = -1.9,
		y = 1.5,
		rot = 180.0
	},
	[GetHashKey('polmav')] = {
		x = 1.1,
		y = 0.8,
		rot = 90.0
	}
}

local laydown_anims = {
	dict = 'missfbi1',
	anim = 'cpr_pumpchest_idle'
}

RegisterNetEvent('HighLife:Player:Drag')
AddEventHandler('HighLife:Player:Drag', function(dragger)
	HighLife:DragTarget(dragger)
end)

RegisterNetEvent('HighLife:Player:StopDrag')
AddEventHandler('HighLife:Player:StopDrag', function()
	HighLife:CancelDrag()
end)

RegisterNetEvent('HighLife:Player:RequestDrag')
AddEventHandler('HighLife:Player:RequestDrag', function(targetPlayer)
	if not HighLife.Player.HasDragRequest and not HighLife.Player.InVehicle and not HighLife.Player.Dead and HighLife.Player.EnteringVehicle == 0 then
		HighLife.Player.HasDragRequest = true

		if GetPlayerPed(GetPlayerFromServerId(targetPlayer)) ~= nil then
			CreateThread(function()
				local targetPed = GetPlayerPed(GetPlayerFromServerId(targetPlayer))

				local displayUntil = GameTimerPool.GlobalGameTime + 5000
				
				-- DrawMarker(0, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts)

				while true do
					if GameTimerPool.GlobalGameTime < displayUntil then
						if Vdist(HighLife.Player.Pos, GetEntityCoords(targetPed)) < 3.0 then
							DisplayHelpText('Press ~INPUT_RELOAD~ to drag the person')

							DisableControlAction(0, 45, true)
							DisableControlAction(0, 140, true)

							if IsDisabledControlJustReleased(0, 45) then
								if not HighLife.Player.InVehicle and HighLife.Player.EnteringVehicle == 0 then
									SetDragClosestPlayer(targetPlayer)

									HighLife.Player.DraggingPlayer = targetPlayer
								end

								break
							end
						end
					else
						break
					end

					Wait(1)
				end

				HighLife.Player.HasDragRequest = false
			end)
		end
	end
end)

RegisterNetEvent('HighLife:Player:PlaceInVehicle')
AddEventHandler('HighLife:Player:PlaceInVehicle', function(player)
	CreateThread(function()
		local entityWorld = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, HighLife.Player.Ped, 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			local isAmbulance = nil

			for k,v in pairs(ambulance_models) do
				if k == GetEntityModel(vehicleHandle) then
					isAmbulance = v

					break	
				end
			end

			if isAmbulance ~= nil then
				-- is an ambulance, force them in the back!
				HighLife:CancelDrag()

            	TriggerServerEvent('HighLife:Player:GetInVehicle', player, 0, true)
			else
				local backLeft = GetEntityBoneIndexByName(vehicleHandle, 'door_dside_r')
				local backRight = GetEntityBoneIndexByName(vehicleHandle, 'door_pside_r')

				local closestDoor = 0

				if backLeft ~= -1 then
					local blDistance = GetDistanceBetweenCoords(GetEntityCoords(HighLife.Player.Ped), GetWorldPositionOfEntityBone(vehicleHandle, backLeft), false)
					local brDistance = GetDistanceBetweenCoords(GetEntityCoords(HighLife.Player.Ped), GetWorldPositionOfEntityBone(vehicleHandle, backRight), false)

					if blDistance < brDistance then
						closestDoor = 1
					else
						closestDoor = 2
					end
				end

				if closestDoor ~= 0 then
					if IsVehicleSeatFree(vehicleHandle, closestDoor) then
						NetworkRequestControlOfEntity(vehicleHandle)

						while not NetworkHasControlOfEntity(vehicleHandle) do
							Wait(0)
						end

						SetVehicleDoorOpen(vehicleHandle, (closestDoor + 1), false) 

						Wait(2500)

						HighLife:CancelDrag()

						TriggerServerEvent('HighLife:Player:StopDrag', player)
						TriggerServerEvent('HighLife:Player:GetInVehicle', player, closestDoor)
					else
						-- Seat is occupied
					end
				else
					-- back of car only?
				end
			end
		end
	end)
end)

RegisterNetEvent('HighLife:Player:GetInVehicle')
AddEventHandler('HighLife:Player:GetInVehicle', function(seat, isAmbulance)
	CreateThread(function()
		local enumDistance = 3.0

		if isAmbulance then
			enumDistance = 4.5
		end

		local closestVehicle = GetClosestVehicleEnumerated(enumDistance)

		if closestVehicle ~= nil then
			if isAmbulance then
				-- we'll default these to the ambulance
				local offsets = {
					x= -1.9,
					y = 1.5,
					rot = 180.0
				}

				for k,v in pairs(ambulance_models) do
					if k == GetEntityModel(closestVehicle) then
						offsets = v

						break	
					end
				end

				HighLife.Player.InAmbulance = true

				HighLife:CancelDrag()

				CreateThread(function()
					Wait(1000)

					LoadAnimationDictionary(laydown_anims.dict)

					TaskPlayAnim(HighLife.Player.Ped, laydown_anims.dict, laydown_anims.anim, 8.0, -8.0, -1, 1, 0, false, false, false)

					AttachEntityToEntity(HighLife.Player.Ped, closestVehicle, 0.0, 0.0, offsets.x, offsets.y, 0.0, 0.0, offsets.rot, false, false, true, false, 2, true)
				end)
			else
				HighLife.Player.EntryCheck = true
				
				SetPedIntoVehicle(HighLife.Player.Ped, closestVehicle, seat)

				Wait(700)

				NetworkRequestControlOfEntity(closestVehicle)

				while not NetworkHasControlOfEntity(closestVehicle) do
					Wait(0)
				end

				SetVehicleDoorShut(closestVehicle, (seat + 1), false)
			end
		end
	end)
end)

function HighLife:DragTarget(targetPlayer)
	if HighLife.Player.Dragger ~= nil then
		TriggerServerEvent('HighLife:Player:StopDrag', targetPlayer)

		HighLife.Player.Dragger = nil

		DetachEntity(HighLife.Player.Ped, true, false)

		if HighLife.Player.InAmbulance then
			HighLife.Player.InAmbulance = false

			FreezeEntityPosition(HighLife.Player.Ped, false)

			HighLife.Player.DisableShooting = false
			HighLife.Player.BlockWeaponSwitch = false
		end

		if HighLife.Player.Dead then
			ClearPedTasksImmediately(HighLife.Player.Ped)
		end
	else
		if HighLife.Player.InAmbulance then
			HighLife.Player.InAmbulance = false

			FreezeEntityPosition(HighLife.Player.Ped, false)

			HighLife.Player.DisableShooting = false
			HighLife.Player.BlockWeaponSwitch = false
		end
		
		CreateThread(function()
			HighLife.Player.Dragger = targetPlayer

			local targetPlayer = GetPlayerPed(GetPlayerFromServerId(HighLife.Player.Dragger))

			local shouldDrag = true

			if not HighLife.Player.Dead then
				if HighLife.Player.InVehicle then
					shouldDrag = false

					local myVehicleSeat = HighLife.Player.VehicleSeat

					TaskLeaveVehicle(HighLife.Player.Ped, GetVehiclePedIsIn(HighLife.Player.Ped), 256)

					Wait(1800)

					HighLife.Player.Dragger = nil

					SetVehicleDoorShut(HighLife.Player.Vehicle, myVehicleSeat + 1, false)
				end
			else
				if HighLife.Player.InVehicle then
					shouldDrag = false

					SetVehicleDoorOpen(HighLife.Player.Vehicle, HighLife.Player.VehicleSeat + 1, false)

					Wait(1800)

					HighLife.Player.Dragger = nil

					ClearPedTasksImmediately(HighLife.Player.Ped)
				end
			end

			if shouldDrag then
				if not HighLife.Player.Dead then
					AttachEntityToEntity(HighLife.Player.Ped, targetPlayer, 4103, vector3(0.4, 0.3, 0.0), 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					-- attach to shoulder and play anim
					AttachEntityToEntity(HighLife.Player.Ped, targetPlayer, 0, vector3(0.27, 0.15, 0.63), 0.5, 0.5, 180, false, false, false, false, 2, false)

					CreateThread(function()
						if not HasAnimDictLoaded('nm') then
							RequestAnimDict('nm')

							repeat Wait(1) until HasAnimDictLoaded('nm')
						end

						ClearPedTasksImmediately(HighLife.Player.Ped)

						-- repeat Wait(1) until not IsPedRagdoll(HighLife.Player.Ped)

						while HighLife.Player.Dead and HighLife.Player.Dragger ~= nil do
							if not IsEntityPlayingAnim(HighLife.Player.Ped, 'nm', 'firemans_carry', 3) then
								TaskPlayAnim(HighLife.Player.Ped, 'nm', 'firemans_carry', 8.0, -8.0, 100000, 33, 0, false, false, false)
							end

							Wait(1)
						end

						RemoveAnimDict('nm')
					end)
				end

				CreateThread(function()
					local foundPed = GetPlayerPed(GetPlayerFromServerId(HighLife.Player.Dragger))

					while HighLife.Player.Dragger ~= nil do
						if HighLife.Player.CurrentInterior ~= nil and HighLife.Player.CurrentInterior ~= 0 then
							Wait(3000)

							SetEntityCoords(HighLife.Player.Ped, HighLife.Player.Pos)
						end

						Wait(1)
					end

					HighLife.Player.Dragger = nil

					DetachEntity(HighLife.Player.Ped, true, false)
				end)
			end
		end)
	end
end

function HighLife:CancelDrag()
	HighLife.Player.Dragger = nil
	HighLife.Player.Dragging = nil
	HighLife.Player.DraggingPlayer = nil

	DetachEntity(HighLife.Player.Ped, true, false)
end