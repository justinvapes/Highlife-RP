function IsAnyTrunkMenuOpen()
	return RageUI.Visible(RMenu:Get('trunk', 'main')) or RageUI.Visible(RMenu:Get('trunk', 'deposit')) or RageUI.Visible(RMenu:Get('trunk', 'item'))
end

function HideInTrunk(plate, vehicle, shouldHide)
	TriggerServerEvent('HighLife:Decor:NetworkSetEntityDecor', GetPlayerServerId(NetworkGetEntityOwner(vehicle)), NetworkGetNetworkIdFromEntity(vehicle), 'bool', 'Vehicle.HidingInTrunk', shouldHide)

	TriggerServerEvent('HighLife:Trunk:HideMe', plate, shouldHide)

	if shouldHide then
		AttachEntityToEntity(HighLife.Player.Ped, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -2.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 20, true)
	else		
		DetachEntity(HighLife.Player.Ped, false, false)
	end

	HighLife.Player.HidingInTrunk = shouldHide
end

function GetCustomVehicleTrunk(thisVehicle)
	for vehicleName,trunkSize in pairs(Config.Storage.Trunk.SizeOverrides) do
		if IsVehicleModel(thisVehicle, GetHashKey(vehicleName)) then
			return {
				items = trunkSize
			}
		end
	end

	return nil
end

function ResetTrunk(closeTrunk)
	if MenuVariables.Trunk.CurrentVehicle ~= nil then
		if IsAnyTrunkMenuOpen() then
			RageUI.CloseAll()
		end

		TriggerServerEvent('HighLife:Trunk:Release', MenuVariables.Trunk.CurrentVehicle.plate, (DoesEntityExist(MenuVariables.Trunk.CurrentVehicle.entity) and VehToNet(MenuVariables.Trunk.CurrentVehicle.entity) or nil), closeTrunk)

		MenuVariables.Trunk = {
			Storage = nil,
			NearReference = nil,
			AwaitingCallback = false
		}
	end
end

CreateThread(function()
	while true do
		if not HighLife.Player.CD then
			if GetLastInputMethod(2) and IsControlJustReleased(0, 47) and (MenuVariables.Trunk.CurrentVehicle == nil) and not IsPedBeingStunned(HighLife.Player.Ped, 0) and (HighLife.Player.Dragging == nil) and not IsPedActiveInScenario(HighLife.Player.Ped) and not HighLife.Player.Dead and not HighLife.Player.Cuffed and not HighLife.Player.HandsUp then
				local nearVehicle = GetClosestVehicleEnumerated(3.0)

				if nearVehicle ~= nil then
					local thisPlate = GetVehicleNumberPlateText(nearVehicle)
					local thisClass = GetVehicleClass(nearVehicle)

					if thisClass ~= 13 and thisClass ~= 21 then
						if thisPlate ~= nil then
							if not IsEntityDead(nearVehicle) or HighLife.Player.HidingInTrunk then
								MenuVariables.Trunk.CurrentVehicle = {
									entity = nearVehicle,
									plate = thisPlate
								}
							end

							if MenuVariables.Trunk.CurrentVehicle ~= nil and (Vdist(GetEntityCoords(MenuVariables.Trunk.CurrentVehicle.entity), HighLife.Player.Pos) < 3.0) then
								if HighLife.Player.Debug or DecorExistOn(MenuVariables.Trunk.CurrentVehicle.entity, 'Vehicle.Locked') and not DecorGetBool(MenuVariables.Trunk.CurrentVehicle.entity, 'Vehicle.Locked') then
									MenuVariables.Trunk.NearReference = MenuVariables.Trunk.CurrentVehicle.plate

									HighLife:ServerCallback('HighLife:Storage:Get', function(trunkStorage)
										if trunkStorage ~= nil then
											MenuVariables.Trunk.Storage = json.decode(trunkStorage)

											RageUI.Visible(RMenu:Get('trunk', 'main'), true)
										else
											MenuVariables.Trunk.Storage = true

											Notification_AboveMap('~o~Someone else is in the trunk')
										end
									end, 'trunk', MenuVariables.Trunk.NearReference, { netID = VehToNet(MenuVariables.Trunk.CurrentVehicle.entity) })
								else
									Notification_AboveMap('~r~Trunk is locked')

									MenuVariables.Trunk = {
										Storage = nil,
										NearReference = nil,
										AwaitingCallback = false
									}
								end
							end
						end
					end
				end
			end

			if MenuVariables.Trunk.CurrentVehicle ~= nil and MenuVariables.Trunk.Storage ~= nil then
				if (not IsAnyTrunkMenuOpen() or (Vdist(HighLife.Player.Pos, GetEntityCoords(MenuVariables.Trunk.CurrentVehicle.entity)) > 3.0) or HighLife.Player.Dead) or HighLife.Player.HandsUp then
					ResetTrunk(false)
				end
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	local TrunkIsInvisible = false

	local hidingVehicle = nil

	while true do
		if HighLife.Player.HidingInTrunk then
			if MenuVariables.Trunk.CurrentVehicle ~= nil then
				if hidingVehicle == nil then
					hidingVehicle = MenuVariables.Trunk.CurrentVehicle.entity
				end

				if not DoesEntityExist(hidingVehicle) or hidingVehicle == nil or HighLife.Player.Dragger ~= nil or not IsEntityAttached(HighLife.Player.Ped) then
					HideInTrunk(GetVehicleNumberPlateText(hidingVehicle), hidingVehicle, false)
				end

				if not TrunkIsInvisible then
					TrunkIsInvisible = true

					SetEntityVisible(HighLife.Player.Ped, false)
				end

				DisableControlAction(0, 0, true) -- Changing view (V)
				DisableControlAction(0, 22, true) -- Jumping (SPACE)
				DisableControlAction(0, 23, true) -- Entering vehicle (F)
				DisableControlAction(0, 24, true) -- Punching/Attacking
				DisableControlAction(0, 29, true) -- Pointing (B)
				DisableControlAction(0, 30, true) -- Moving sideways (A/D)
				DisableControlAction(0, 31, true) -- Moving back & forth (W/S)
				DisableControlAction(0, 37, true) -- Weapon wheel
				DisableControlAction(0, 44, true) -- Taking Cover (Q)
				DisableControlAction(0, 56, true) -- F9
				DisableControlAction(0, 82, true) -- Mask menu (,)
				DisableControlAction(0, 140, true) -- Hitting your vehicle (R)
				DisableControlAction(0, 166, true) -- F5
				DisableControlAction(0, 167, true) -- F6
				DisableControlAction(0, 168, true) -- F7
				DisableControlAction(0, 170, true) -- F3
				DisableControlAction(0, 288, true) -- F1
				DisableControlAction(0, 289, true) -- F2
				DisableControlAction(1, 323, true) -- Handsup (X)
			else
				HighLife.Player.HidingInTrunk = false

				hidingVehicle = nil
			end
		else
			if TrunkIsInvisible then
				SetEntityVisible(HighLife.Player.Ped, true)

				TrunkIsInvisible = false
			end
		end

		Wait(1)
	end
end)