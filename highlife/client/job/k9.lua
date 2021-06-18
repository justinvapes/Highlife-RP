local sniffRange = 7.0

HighLife.Other.Pet = {
	blip = nil,
	task = nil,
	entity = nil,
	config = nil,
	attackTarget = nil,
	foundSniffingEntity = nil,

	memory = {},
	isSniffing = false
}

RegisterNetEvent('HighLife:Player:SetSmells')
AddEventHandler('HighLife:Player:SetSmells', function()
	HighLife.Player.Smells = true
end)

function RequestControlForcibly(entity)
	local maxAttempts = 5

	NetworkRequestControlOfEntity(entity)

	while not NetworkHasControlOfEntity(entity) or maxAttempts ~= 0 do
		Wait(100)
	
		NetworkRequestControlOfEntity(entity)

		maxAttempts = maxAttempts - 1
	end
end

function DoRequestModel(model)
	RequestModel(model)
	
	while not HasModelLoaded(model) do
		Wait(1)
	end
end

function DoRequestAnimSet(anim)
	RequestAnimDict(anim)
	
	while not HasAnimDictLoaded(anim) do
		Wait(1)
	end
end

function HighLife:ClearPetTasks()
	HighLife.Other.Pet.task = nil

	ClearPedTasks(HighLife.Other.Pet.entity)
end

function HighLife:SetPetWander()
	HighLife:ClearPetTasks()

	RequestControlForcibly(HighLife.Other.Pet.entity)
	
	HighLife.Other.Pet.task = 'wander'

	TaskWanderStandard(HighLife.Other.Pet.entity, 10.0, 10)
	
	Notification_AboveMap('Your pet has wandered off')
end

function HighLife:SetPetFollow()
	HighLife:ClearPetTasks()

	RequestControlForcibly(HighLife.Other.Pet.entity)

	if not HighLife.Player.InVehicle then
		StartAnimation("rcmnigel1c", "hailing_whistle_waive_a", true)
	end
	
	if Vdist(GetEntityCoords(HighLife.Other.Pet.entity), HighLife.Player.Pos) < Config.Pets.MinimumFollowCallDistance then	
		HighLife.Other.Pet.task = 'follow'
		
		TaskFollowToOffsetOfEntity(HighLife.Other.Pet.entity, HighLife.Player.Ped, vector3(0.5, 0.0, 0.0), 5.0, -1, 0.0, true)

		Notification_AboveMap('Your pet is now following you')
	else
		Notification_AboveMap('Your pet is not nearby')
	end
end

function HighLife:SetPetAnimation(animName)
	HighLife.Other.Pet.task = 'animation'

	if HighLife.Other.Pet.config ~= nil then
		local thisAnim = HighLife.Other.Pet.config.anims[animName]

		if thisAnim ~= nil then
			DoRequestAnimSet(thisAnim.dict)

			TaskPlayAnim(HighLife.Other.Pet.entity, thisAnim.dict, thisAnim.anim, 8.0, -8, -1, 0, 0, 0, 0, 0)

			RemoveAnimDict(thisAnim.dict)

			if thisAnim.time ~= nil then
				CreateThread(function()
					Wait(thisAnim.time * 1000)

					HighLife:ClearPetTasks()
				end)
			end
		end
	end
end

function GetVehicleDoorBoneByIndex(index)
	if index == 1 then
		return 'seat_pside_f'
	elseif index == 2 then
		return 'seat_dside_r'
	elseif index == 3 then
		return 'seat_pside_r'
	end
end

function HighLife:SetPetEnterVehicle()
	RequestControlForcibly(HighLife.Other.Pet.entity)

	CreateThread(function()
		if GetDistanceBetweenCoords(GetEntityCoords(HighLife.Other.Pet.entity), GetEntityCoords(HighLife.Player.Vehicle)) < 5.0 then
			HighLife:ClearPetTasks()

			SetPedCanRagdoll(HighLife.Other.Pet.entity, false)
			
			HighLife.Other.Pet.task = 'enter_vehicle'

			local vehicle_class = GetVehicleClass(HighLife.Player.Vehicle)
			local vehicle_model = GetEntityModel(HighLife.Player.Vehicle)
			local vehicle_seat_count = GetVehicleModelNumberOfSeats(vehicle_model)

			local foundSeat = nil

			if vehicle_class ~= 8 and vehicle_class ~= 13 then
				for i=0, vehicle_seat_count do
					if IsVehicleSeatFree(HighLife.Player.Vehicle, i) then
						if foundSeat ~= nil then
							if i == 2 then
								foundSeat = i

								break
							end
						else
							foundSeat = i
						end
					end
				end

				if foundSeat ~= nil then
					-- open the door anim
					local openDoorAnim = Config.Pets.PlayerAnims.OpenDoor

					if not HasAnimDictLoaded(openDoorAnim.dict) then
						DoRequestAnimSet(openDoorAnim.dict)
					end

					if not HasAnimDictLoaded(HighLife.Other.Pet.config.anims.vehicle.dict) then
						DoRequestAnimSet(HighLife.Other.Pet.config.anims.vehicle.dict)
					end

					TaskPlayAnim(HighLife.Player.Ped, openDoorAnim.dict, openDoorAnim.std, 8.0, -8, -1, 0, 0, false, false, false)

					Wait(600)

					SetVehicleDoorOpen(HighLife.Player.Vehicle, foundSeat + 1, false, false)

					Wait(500)

					if HighLife.Other.Pet.config.anims.vehicle ~= nil then
						local netScene = NetworkCreateSynchronisedScene(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2, 0, 1, 1065353216, 0, 1065353216)

						NetworkAttachSynchronisedSceneToEntity(netScene, HighLife.Player.Vehicle, GetEntityBoneIndexByName(HighLife.Player.Vehicle, GetVehicleDoorBoneByIndex(foundSeat + 1)))

						NetworkAddPedToSynchronisedScene(HighLife.Other.Pet.entity, netScene, HighLife.Other.Pet.config.anims.vehicle.dict, 'get_in', 4.0, -4.0, 12, 16, 1148846080, 0)

						NetworkStartSynchronisedScene(netScene)

						N_0x2208438012482a1a(HighLife.Other.Pet.entity, 0, 0)

						Wait(1)

						local localScene = NetworkConvertSynchronisedSceneToSynchronizedScene(netScene)

						SetSynchronizedSceneLooped(localScene, false)

						local sceneStartTime = GameTimerPool.GlobalGameTime

						while GetSynchronizedScenePhase(localScene) < 0.98 or GameTimerPool.GlobalGameTime > (sceneStartTime + 5000) do
							Wait(1)
						end

						SetPedIntoVehicle(HighLife.Other.Pet.entity, HighLife.Player.Vehicle, foundSeat)

						SetVehicleDoorOpen(HighLife.Player.Vehicle, foundSeat + 1, true, false)

						HighLife:SetPetAnimation('vehicle_idle')

						NetworkStopSynchronisedScene(netScene)

						HighLife.Other.Pet.task = 'in_vehicle'
					else
						-- If has no scene anim
						SetVehicleDoorOpen(HighLife.Player.Vehicle, foundSeat + 1, true, false)
						
						Wait(1000)

						TaskEnterVehicle(HighLife.Other.Pet.entity, HighLife.Player.Vehicle, 5000, foundSeat, 2.0, 16, 0)

						CreateThread(function()
							while not IsPedInAnyVehicle(HighLife.Other.Pet.entity) do
								Wait(200)
							end

							SetVehicleDoorShut(HighLife.Player.Vehicle, foundSeat + 1, false)
						end)
					end
				else
					Notification_AboveMap('Could not find a valid seat for your pet')
				end
			end
		else
			Notification_AboveMap('You pet is not close to your vehicle')
		end

		SetPedCanRagdoll(HighLife.Other.Pet.entity, true)
	end)
end

function HighLife:SetPetLeaveVehicle()
	local vehicle = GetVehiclePedIsIn(HighLife.Other.Pet.entity)
	
	RequestControlForcibly(vehicle)
	RequestControlForcibly(HighLife.Other.Pet.entity)

	CreateThread(function()
		if IsPedInAnyVehicle(HighLife.Other.Pet.entity) then
			SetPedCanRagdoll(HighLife.Other.Pet.entity, false)

			local vehicle_class = GetVehicleClass(vehicle)
			local vehicle_model = GetEntityModel(vehicle)
			local vehicle_seat_count = GetVehicleModelNumberOfSeats(vehicle_model)

			local foundSeat = nil

			for i=0, vehicle_seat_count do
				if GetPedInVehicleSeat(vehicle, i) == HighLife.Other.Pet.entity then
					foundSeat = i
					break
				end
			end

			if foundSeat ~= nil then
				SetVehicleDoorOpen(vehicle, foundSeat + 1, false, false)

				if HighLife.Other.Pet.config.anims.vehicle ~= nil then
					local netScene = NetworkCreateSynchronisedScene(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2, 0, 1, 1065353216, 0, 1065353216)

					NetworkAttachSynchronisedSceneToEntity(netScene, vehicle, GetEntityBoneIndexByName(vehicle, GetVehicleDoorBoneByIndex(foundSeat + 1)))

					NetworkAddPedToSynchronisedScene(HighLife.Other.Pet.entity, netScene, HighLife.Other.Pet.config.anims.vehicle.dict, 'get_out', 4.0, -4.0, 12, 16, 1148846080, 0)

					NetworkStartSynchronisedScene(netScene)

					Wait(1)

					local localScene = NetworkConvertSynchronisedSceneToSynchronizedScene(netScene)

					SetSynchronizedSceneLooped(localScene, false)

					local sceneStartTime = GameTimerPool.GlobalGameTime

					while GetSynchronizedScenePhase(localScene) < 0.98 or GameTimerPool.GlobalGameTime > (sceneStartTime + 5000) do
						Wait(1)
					end

					NetworkStopSynchronisedScene(netScene)

					ClearPedTasksImmediately(HighLife.Other.Pet.entity)

					N_0x2208438012482a1a(HighLife.Other.Pet.entity, 0, 0)

					SetVehicleDoorOpen(vehicle, foundSeat + 1, true, false)

					HighLife:SetPetFollow()
					
					Wait(1000)

					SetPedCanRagdoll(HighLife.Other.Pet.entity, true)
				end
			end
		end
	end)
end

function HighLife:RemovePet(dead)
	RemoveBlip(HighLife.Other.Pet.blip)

	RequestControlForcibly(HighLife.Other.Pet.entity)

	if dead then
		SetEntityAsNoLongerNeeded(HighLife.Other.Pet.entity)
	else
		SetEntityAsMissionEntity(HighLife.Other.Pet.entity, true, true)

		DeletePed(HighLife.Other.Pet.entity)
	end
	
	HighLife.Other.Pet = {
		blip = nil,
		task = nil,
		entity = nil,
		config = nil,
		attackTarget = nil,
		foundSniffingEntity = nil,

		memory = {},
		isSniffing = false
	}
end

function HighLife:CreatePet(pet_model)
	local pet_config = Config.Pets.Models[pet_model]
	
	if pet_config ~= nil then
		if HighLife.Other.Pet.entity == nil then
			HighLife.Other.Pet.config = pet_config
			
			CreateThread(function()
				DoRequestModel((IsAprilFools() and GetHashKey('a_c_rat') or GetHashKey(pet_model)))

				HighLife.Other.Pet.entity = CreatePed(6, (IsAprilFools() and GetHashKey('a_c_rat') or GetHashKey(pet_model)), GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, -0.8, 0.0), true, true)

				local net_id = PedToNet(HighLife.Other.Pet.entity)

				TaskSetBlockingOfNonTemporaryEvents(HighLife.Other.Pet.entity, true)

				NetworkRequestControlOfNetworkId(net_id, true)
				SetNetworkIdCanMigrate(net_id, false)
				NetworkRequestControlOfEntity(HighLife.Other.Pet.entity)
				NetworkUnregisterNetworkedEntity(HighLife.Other.Pet.entity)
				NetworkSetNetworkIdDynamic(net_id, false)

				if math.random(2) == 1 then
					SetPedRandomComponentVariation(HighLife.Other.Pet.entity, true)
				end
			
				SetPedCanBeDraggedOut(HighLife.Other.Pet.entity, false)
				SetEntityAsMissionEntity(HighLife.Other.Pet.entity, true, true)
				
				HighLife.Other.Pet.blip = AddBlipForEntity(HighLife.Other.Pet.entity)
				
				SetBlipAsFriendly(HighLife.Other.Pet.blip, true)
				SetBlipDisplay(HighLife.Other.Pet.blip, 4)
				SetBlipScale(HighLife.Other.Pet.blip, 0.6)
				SetBlipSprite(HighLife.Other.Pet.blip, 463)
				SetBlipColour(HighLife.Other.Pet.blip, 38)
				SetBlipAsShortRange(HighLife.Other.Pet.blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('K9')
				EndTextCommandSetBlipName(HighLife.Other.Pet.blip)

				Wait(1000)

				HighLife:SetPetFollow()
			end)
		else
			Notification_AboveMap("You can't have multiple pets at one time")
		end
	end
end

CreateThread(function()
	local closestPed = nil
	local closestVehicle = nil
	
	while true do
		if HighLife.Other.Pet.entity ~= nil and DoesEntityExist(HighLife.Other.Pet.entity) then
			if HighLife.Other.Pet.task ~= nil then				
				local petPos = GetEntityCoords(HighLife.Other.Pet.entity)
				
				if HighLife.Other.Pet.task == 'follow' or HighLife.Other.Pet.task == 'animation' then
					if GetDistanceBetweenCoords(petPos, HighLife.Player.Pos) > Config.Pets.WanderFalloffDistance then
						HighLife:SetPetWander()
					end
				end

				if HighLife.Other.Pet.task == 'wander' then
					if GetDistanceBetweenCoords(petPos, HighLife.Player.Pos) < (Config.Pets.WanderFalloffDistance / 2) then
						HighLife:SetPetFollow()
					end
				end

				if HighLife.Other.Pet.task == 'enter_vehicle' then
					if IsPedInAnyVehicle(HighLife.Other.Pet.entity) then
						HighLife.Other.Pet.task = 'in_vehicle'
					end
				end

				if IsEntityDead(HighLife.Other.Pet.entity) then
					HighLife:RemovePet(true)
				end

				if HighLife.Other.Pet.task == 'attack' then
					if IsEntityDead(HighLife.Other.Pet.attackTarget) then
						HighLife.Other.Pet.attackTarget = nil

						RequestControlForcibly(HighLife.Other.Pet.entity)

						ClearPedTasks(HighLife.Other.Pet.entity)

						HighLife.Other.Pet.task = 'follow'
					end
				end
			end

			if HighLife.Other.Pet.isSniffing then
				closestPed = GetClosestPedEnumerated(sniffRange, GetEntityCoords(HighLife.Other.Pet.entity))
				closestVehicle = GetClosestVehicleEnumerated(sniffRange, GetEntityCoords(HighLife.Other.Pet.entity))

				if HighLife.Other.Pet.foundSniffingEntity == nil then
					if closestPed ~= nil then
						if DecorExistOn(closestPed, 'Entity.HasDrugs') then
							if DecorGetBool(closestPed, 'Entity.HasDrugs') then
								HighLife.Other.Pet.foundSniffingEntity = closestPed
							end
						end
					end

					if HighLife.Other.Pet.foundSniffingEntity == nil then
						if closestVehicle ~= nil then
							if DecorExistOn(closestVehicle, 'Entity.HasDrugs') then
								if DecorGetBool(closestVehicle, 'Entity.HasDrugs') then
									HighLife.Other.Pet.foundSniffingEntity = closestVehicle
								end
							end
						end
					end

					if HighLife.Other.Pet.foundSniffingEntity ~= nil then
						local breakGot = false

						HighLife:ClearPetTasks()

						HighLife.Other.Pet.task = 'sniff_found'

						RequestControlForcibly(HighLife.Other.Pet.entity)

						TaskTurnPedToFaceEntity(HighLife.Other.Pet.entity, HighLife.Other.Pet.foundSniffingEntity, 3000)

						if IsEntityAPed(HighLife.Other.Pet.foundSniffingEntity) then
							while not IsPedFacingPed(HighLife.Other.Pet.entity, HighLife.Other.Pet.foundSniffingEntity, 10.0) do
								if IsEntityDead(HighLife.Other.Pet.entity) or HighLife.Other.Pet.foundSniffingEntity == nil or HighLife.Other.Pet.task ~= 'sniff_found' then
									break
								end

								Wait(100)
							end
						end

						Wait(2500)

						if not breakGot then
							HighLife:SetPetAnimation('indicate')

							Notification_AboveMap('Your dog appears to be indicating something')
						end
					end
				end
			end

			if HighLife.Other.Pet.foundSniffingEntity ~= nil then
				if DoesEntityExist(HighLife.Other.Pet.foundSniffingEntity) then
					if Vdist(GetEntityCoords(HighLife.Other.Pet.entity), GetEntityCoords(HighLife.Other.Pet.foundSniffingEntity)) > 10.0 then
						HighLife.Other.Pet.foundSniffingEntity = nil

						HighLife:SetPetFollow()
					else
						if IsEntityAPed(HighLife.Other.Pet.foundSniffingEntity) then
							if not IsPedFacingPed(HighLife.Other.Pet.entity, HighLife.Other.Pet.foundSniffingEntity, 10.0) then
								TaskTurnPedToFaceEntity(HighLife.Other.Pet.entity, HighLife.Other.Pet.foundSniffingEntity, 3000)
								
								while not IsPedFacingPed(HighLife.Other.Pet.entity, HighLife.Other.Pet.foundSniffingEntity, 10.0) do
									if IsEntityDead(HighLife.Other.Pet.entity) then
										break
									end

									Wait(100)
								end

								if DoesEntityExist(HighLife.Other.Pet.foundSniffingEntity) then
									HighLife:SetPetAnimation('indicate')
								end 
							else
								TaskTurnPedToFaceEntity(HighLife.Other.Pet.entity, HighLife.Other.Pet.foundSniffingEntity, 3000)

								Wait(2500)

								HighLife:SetPetAnimation('indicate')
							end
						end
					end
				else
					HighLife.Other.Pet.foundSniffingEntity = nil

					HighLife:SetPetFollow()
				end
			end
		end
		
		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		if HighLife.Other.Pet.entity ~= nil then
			if HighLife.Other.Pet.task ~= 'attack' and IsControlJustPressed(0, 38) then
				local meleeLock, meleeTarget = GetPlayerTargetEntity(HighLife.Player.Id)
				local aimingLock, aimingTarget = GetEntityPlayerIsFreeAimingAt(HighLife.Player.Id)

				HighLife.Other.Pet.attackTarget = nil

				if meleeTarget ~= 0 then
					HighLife.Other.Pet.attackTarget = meleeTarget
				else
					if aimingTarget ~= 0 then
						HighLife.Other.Pet.attackTarget = aimingTarget
					end
				end

				if HighLife.Other.Pet.attackTarget ~= nil and HighLife.Other.Pet.attackTarget ~= HighLife.Other.Pet.entity then
					HighLife:ClearPetTasks(HighLife.Other.Pet.entity)

					HighLife.Other.Pet.task = 'attack'

					StartAnimation("rcmnigel1c", "hailing_whistle_waive_a", true)

					TaskPutPedDirectlyIntoMelee(HighLife.Other.Pet.entity, HighLife.Other.Pet.attackTarget, 0.0, 1.0, 0.0, 0)
					-- TaskCombatPed(HighLife.Other.Pet.entity, HighLife.Other.Pet.attackTarget, 0, 16)
				end
			end

			if HighLife.Other.Pet.task == 'attack' then
				SetPedMoveRateOverride(HighLife.Other.Pet.entity, 1.5)

				if IsEntityDead(HighLife.Other.Pet.attackTarget) or HighLife.Other.Pet.attackTarget == nil or not DoesEntityExist(HighLife.Other.Pet.attackTarget) then
					HighLife:SetPetFollow()
				end
			end
		end

		Wait(1)
	end
end)