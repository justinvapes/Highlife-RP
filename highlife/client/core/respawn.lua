RegisterCommand('frespawn', function()
	if HighLife.Player.Debug then
		HighLife:RespawnPlayer()
	end
end)

function HighLife:RespawnPlayer()
	CreateThread(function()
		RemoveAllPedWeapons(HighLife.Player.Ped, true)

		HighLife.Player.HideHUD = true

		DoScreenFadeOut(3000)
		
		while not IsScreenFadedOut() do
			Wait(0)
		end

		HighLife:ServerCallback('HighLife:EMS:RespawnPlayer', function()			
			HighLife:HospitalRespawn(true)

			HighLife.Player.AfkCheck = true
			HighLife.Player.Bleeding = false

			StopScreenEffect('DeathFailOut')
		end)
	end)
end

function HighLife:StartRespawnTimer(isSniperShot)
	if HighLife.Player.Dead then
		CreateThread(function()
			local finalText = 'wake up at the closest hospital'

			if isSniperShot then
				finalText = 'go to your grave'
			end

			if HighLife.Player.Detention.InJail then
				finalText = '~g~wake up'
			end

			while HighLife.Player.Dead do
				if HighLife.Player.Detention.InJail then
					if HighLife.Player.IsStable then
						HighLife.Player.IsStable = false

						break
					end
				end

				DrawBottomText('Press [~y~R~w~] to ' .. finalText, 0.5, 0.8, 0.5, 4)

				if not HighLife.Player.IsTyping then
					if IsControlPressed(0, 80) or IsDisabledControlPressed(0, 80) then
						if isSniperShot then
							-- morgue, max time
							TriggerServerEvent('HighLife:Detention:Send', 'morgue', nil, 2000, 'FGSW', true)
						else
							if not HighLife.Player.Detention.InJail then
								HighLife:RespawnPlayer()
							else
								HighLife:RevivePlayer(true)
							end
						end

						break
					end
				end

				Wait(1)
			end
		end)
	end
end

function HighLife:HospitalRespawn(fullRespawn, staffOrJob)
	if not HighLife.Settings.Development then
		DoScreenFadeOut(0)
	end

	HighLife:TempDisable()

	SetEntityCoordsNoOffset(HighLife.Player.Ped, HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, false, false, false, true)
	NetworkResurrectLocalPlayer(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, HighLife.Player.Heading, true, false)

	Wait(1000)

	HighLife:UpdateCorePlayerStats()

	if staffOrJob ~= nil then
		if type(staffOrJob) == 'boolean' then
			if staffOrJob then
				SetEntityHealth(HighLife.Player.Ped, 200)
			end
		else
			if staffOrJob == 'police' then
				SetEntityHealth(HighLife.Player.Ped, 105)
			elseif staffOrJob == 'fib' then
				SetEntityHealth(HighLife.Player.Ped, 115)
			elseif staffOrJob == 'ambulance' then
				SetEntityHealth(HighLife.Player.Ped, 120)
			else
				SetEntityHealth(HighLife.Player.Ped, math.random(105, 115))
			end

			SetPedCanRagdollFromPlayerImpact(HighLife.Player.Ped, true)

			Citizen.SetTimeout(40000, function()
				SetPedCanRagdollFromPlayerImpact(HighLife.Player.Ped, false)
			end)
		end
	end

	if fullRespawn then
		HighLife.Player.BlockSwitchCam = true

		RemoveAllPedWeapons(HighLife.Player.Ped, true)
	end

	if fullRespawn then
		local closestHospital = {
			distance = nil,
			location = nil
		}

		for k,v in pairs(Config.EMS.RespawnLocations) do
			local distance = GetDistanceBetweenCoords(HighLife.Player.Pos, v.respawnPos, true)

			if closestHospital.distance == nil or distance < closestHospital.distance then
				closestHospital.distance = distance
				closestHospital.location = v
			end
		end

		CreateThread(function()
			DoScreenFadeOut(0)

			SetPlayerControl(HighLife.Player.Id, false, 0)
			SetEntityCoords(HighLife.Player.Ped, closestHospital.location.respawnPos)

			FreezeEntityPosition(HighLife.Player.Id, true)

			RequestAnimDict(closestHospital.location.respawnDict)

			while not HasAnimDictLoaded(closestHospital.location.respawnDict) do
				Wait(1)
			end

			while not HasCollisionLoadedAroundEntity(HighLife.Player.Ped) do
				Wait(1)
			end

			SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)
			ClearPedTasksImmediately(HighLife.Player.Ped)
			
			Wait(2000)

			FreezeEntityPosition(HighLife.Player.Id, false)
			
			DoScreenFadeIn(1000)

			N_0x4759cc730f947c81() -- idk
			N_0x48adc8a773564670() -- also idk

			local respawnScene = NetworkCreateSynchronisedScene(closestHospital.location.respawnPos, closestHospital.location.respawnRot, 2, false, false, 1065353216, 0, 1065353216)

			NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, respawnScene, closestHospital.location.respawnDict, closestHospital.location.respawnAnim, 1000.0, -1.5, 4, 0, 1148846080, 0)

			N_0x129466ed55140f8d(HighLife.Player.Ped, true)
			SetPlayerClothPinFrames(HighLife.Player.Id, true)

			SetPedResetFlag(HighLife.Player.Ped, 77, true)

			NetworkForceLocalUseOfSyncedSceneCamera(respawnScene, closestHospital.location.respawnDict, closestHospital.location.respawnAnimCam)

			NetworkStartSynchronisedScene(respawnScene)

			repeat Wait(1) until (NetworkConvertSynchronisedSceneToSynchronizedScene(respawnScene) ~= -1)

			local convertedScene = NetworkConvertSynchronisedSceneToSynchronizedScene(respawnScene)

			local controlReady = false
			local playAnimEffects = true

			while IsSynchronizedSceneRunning(convertedScene) and not HighLife.Player.Dead and not controlReady do
				local currentScenePhase = GetSynchronizedScenePhase(convertedScene)

				if playAnimEffects then
					StartScreenEffect('RespawnMichael', 0, 0)

					PlaySoundFrontend(-1, 'Whoosh', 'RESPAWN_SOUNDSET', false);

					playAnimEffects = false
				end

				if currentScenePhase >= closestHospital.location.respawnPhaseEnd then
					if HasAnimEventFired(HighLife.Player.Ped, GetHashKey('ForceBlendout')) then
						controlReady = true
					end
				end

				Wait(1)
			end

			ForcePedMotionState(HighLife.Player.Ped, -668482597, true, 0, 0)
			SimulatePlayerInputGait(HighLife.Player.Id, 1.0, 500, 0.0, 1, 0)
			
			SetPlayerControl(HighLife.Player.Id, true, 0)

			StartScreenEffect("CamPushInMichael", 0, 0)

			if not HighLife.Player.Dead then
				ClearPedTasks(HighLife.Player.Ped)
			end

			RemoveAnimDict(closestHospital.location.respawnDict)

			N_0x3044240d2e0fa842()

			N_0x59424bd75174c9b1()

			HighLife.Player.HideHUD = false
		end)
	end

	CreateThread(function()
		Wait(3000)

		HighLife.Player.BlockSwitchCam = false
	end)

	ClearPedBloodDamage(HighLife.Player.Ped)

	UpdatePlayerDecorations(true)
end