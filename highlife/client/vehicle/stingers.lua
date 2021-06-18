local is_deploying_stinger = false

local closestStinger = nil

local firstDeploy = true

RegisterNetEvent("HighLife:Items:Stinger")
AddEventHandler("HighLife:Items:Stinger", function()
	-- the object should be removed from the player

	if not is_deploying_stinger and not HighLife.Player.InVehicle then
		DeployStinger()
	else
		if HighLife.Player.InVehicle then
			Notification_AboveMap('STINGER_VEHICLE')

			TriggerServerEvent('HighLife:add_item', nil, 'stingers', 1, true)
		else
			Notification_AboveMap('STINGER_DEPLOYING_ALREADY')
		end
	end
end)

function PickupStinger(thisStinger)
	local pickupDelay = 800

	if HighLife.Player.Job.name == 'police' then
		pickupDelay = 100
	end

	-- do all the anims again for picking up
	NetworkRequestControlOfEntity(thisStinger)

	TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -1, true)

	Wait(pickupDelay)

	local gotBoth = false

	if NetworkHasControlOfEntity(thisStinger) then
		if DecorExistOn(closestStinger, Config.Stingers.object_decor) then
			local otherStinger = NetToObj(DecorGetInt(closestStinger, Config.Stingers.object_decor))

			NetworkRequestControlOfEntity(otherStinger)

			Wait(pickupDelay)

			if NetworkHasControlOfEntity(otherStinger) then
				if DoesEntityExist(otherStinger) then
					gotBoth = true

					SetEntityAsMissionEntity(otherStinger, true, true)

					DecorRemove(closestStinger, otherStinger)

					DeleteObject(otherStinger)
				end

				DecorRemove(closestStinger, Config.Stingers.object_decor)
			end
		end

		Wait(pickupDelay)

		SetEntityAsMissionEntity(thisStinger, true, true)

		DeleteObject(thisStinger)

		if gotBoth then
			TriggerServerEvent('HighLife:add_item', nil, 'stingers', 1, true)
		end
	end

	ClearPedTasks(HighLife.Player.Ped)
end

function DeployStinger()
	is_deploying_stinger = true

	-- local thisSound = GetSoundId()

	CreateThread(function()
		TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -1, true)

		Wait(1000)

		-- RequestScriptAudioBank("BIG_SCORE_3A_SOUNDS", 1)

		local deployed_stingers = {}
		local deployed_heading = GetEntityHeading(HighLife.Player.Ped)

		local spawnCoords = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, Config.Stingers.DeployDistance, 0.0)

		LoadAnimationDictionary(Config.Stingers.anims.stinger.dict)

		for i=1, 2 do
			HighLife:CreateObject(Config.Stingers.object, { x = spawnCoords.x, y = spawnCoords.y, z = spawnCoords.z }, GetEntityHeading(HighLife.Player.Ped), false, function(thisObject)
				deployed_stingers[i] = thisObject 

				spawnCoords = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, Config.Stingers.StingerSeperation, 0.0)

				PlaceObjectOnGroundProperly(deployed_stingers[i])

				ActivatePhysics(deployed_stingers[i])

				SetEntityDynamic(deployed_stingers[i], 1)

				PlayEntityAnim(deployed_stingers[i], Config.Stingers.anims.stinger.anim, Config.Stingers.anims.stinger.dict, 1000.0, 0, 1, 0, 0.0, 0)

				if firstDeploy then
					firstDeploy = false

					PlayEntityAnim(deployed_stingers[i], Config.Stingers.anims.stinger.anim, Config.Stingers.anims.stinger.dict, 1000.0, 0, 1, 0, 0.0, 0)
				end
			end)

			-- PlaySoundFromEntity(thisSound, "DROP_STINGER", deployed_stingers[i], "BIG_SCORE_3A_SOUNDS", 0, 0)

			Wait(1000)
		end

		RemoveAnimDict(Config.Stingers.anims.stinger.dict)

		DecorSetInt(deployed_stingers[1], Config.Stingers.object_decor, ObjToNet(deployed_stingers[2]))
		DecorSetInt(deployed_stingers[2], Config.Stingers.object_decor, ObjToNet(deployed_stingers[1]))

		ClearPedTasks(HighLife.Player.Ped)

		is_deploying_stinger = false
	end)
end

CreateThread(function()
	foundObject = nil

	while true do
		foundObject = GetClosestObjectOfType(HighLife.Player.Pos, Config.Stingers.NearbyRange, Config.Stingers.object, true, false, false)
			
		if foundObject ~= nil and foundObject ~= 0 then
			closestStinger = foundObject
		else
			closestStinger = nil
		end

		-- FIXME: this will need to be tweaked
		if HighLife.Player.InVehicle then
			Wait(150)
		else
			Wait(1000)
		end
	end
end)

CreateThread(function()
	local spike_p_s = nil
	local spike_p_f = nil

	local primary_stinger_coords = nil
	local secondary_stinger_coords = nil

	local wheel_coords = nil

	local spike_p_start = nil
	local spike_p_end = nil

	while true do
		if closestStinger ~= nil then
			-- local thisColor = 0

			spike_p_s = GetOffsetFromEntityInWorldCoords(closestStinger, vector3(0.0, 1.7825, 0.034225))
			spike_p_f = GetOffsetFromEntityInWorldCoords(closestStinger, vector3(0.0, -1.7825, 0.034225))

			-- DrawLine(spike_p_s, spike_p_f, 255, 0, thisColor, 255)

			if not HighLife.Player.InVehicle then
				if DecorExistOn(closestStinger, Config.Stingers.object_decor) then
					if Vdist(HighLife.Player.Pos, GetEntityCoords(closestStinger)) < 2.6 then
						DisplayHelpText('STINGER_PICKUP')

						if IsControlPressed(0, 38) then
							PickupStinger(closestStinger)
						end
					end
				end
			else
				primary_stinger_coords = GetEntityCoords(closestStinger)

				secondary_stinger_coords = GetEntityCoords(NetToObj(DecorGetInt(closestStinger, Config.Stingers.object_decor)))

				if IsEntityTouchingEntity(HighLife.Player.Vehicle, closestStinger) then
					for i=1, #Config.Stingers.ValidWheelBones do
						wheel_coords = GetWorldPositionOfEntityBone(HighLife.Player.Vehicle, GetEntityBoneIndexByName(HighLife.Player.Vehicle, Config.Stingers.ValidWheelBones[i].bone))

						spike_p_start = GetOffsetFromEntityInWorldCoords(closestStinger, vector3(0.0, 1.7825, 0.034225))
						spike_p_end = GetOffsetFromEntityInWorldCoords(closestStinger, vector3(0.0, -1.7825, 0.034225))

						if (Vdist(spike_p_start, wheel_coords) + Vdist(spike_p_end, wheel_coords)) < 4.0 then
							if not IsVehicleTyreBurst(HighLife.Player.Vehicle, Config.Stingers.ValidWheelBones[i].index, true) or IsVehicleTyreBurst(HighLife.Player.Vehicle, Config.Stingers.ValidWheelBones[i].index, false) then
								SetVehicleTyreBurst(HighLife.Player.Vehicle, Config.Stingers.ValidWheelBones[i].index, 0, (math.random(20, 30) / 100.0))
							end
						end
					end
				end
			end
		end

		Wait(0)
	end
end)