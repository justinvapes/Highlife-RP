local inDetentionType = nil
local inReleaseProcess = false

local DetentionData = {
	ICU = {
		active = false,
		remaining_time = 0
	},
	Jail = {
		active = false,
		remaining_time = 0
	},
	Morgue = {
		active = false,
		remaining_time = 0
	}
}

function HighLife:ResetDetentionData()
	Release(inDetentionType, true)

	inDetentionType = nil

	HighLife.Player.Detention = {
		Active = false,

		InICU = false,
		InJail = false,
		InMorgue = false,
	}

	DetentionData = {
		ICU = {
			active = false,
			remaining_time = 0
		},
		Jail = {
			active = false,
			remaining_time = 0
		},
		Morgue = {
			active = false,
			remaining_time = 0
		}
	}
end

RegisterNetEvent("HighLife:Detention:Activate")
AddEventHandler("HighLife:Detention:Activate", function(detentionType, time, init)
	CreateThread(function()
		local alreadyLoaded = false

		while HighLife.Player.CD or HighLife.Player.InCharacterMenu do
			if HighLife.Player.InCharacterMenu then
				alreadyLoaded = true
			end

			if GetPlayerSwitchState() == 8 then
				break
			end

			Wait(1)
		end
		
		if DetentionData[detentionType] ~= nil then
			if not DetentionData[detentionType].active then
				if detentionType == 'Jail' then
					HighLife.Player.Detention.InJail = true
				end

				if detentionType == 'Morgue' then
					HighLife.Player.Detention.InMorgue = true

					alreadyLoaded = false
				end

				if detentionType == 'ICU' then
					HighLife.Player.Detention.InICU = true

					if init then
						TriggerEvent('HighLife:Player:ClosestBed')
					end

					NetworkSetVoiceActive(false)

					TriggerScreenblurFadeIn(10000.0)
				end

				local thisLocation = HighLife.Player.Pos

				if Config.Detention[detentionType].EnterLocation ~= nil then
					thisLocation = Config.Detention[detentionType].EnterLocation
				end
				
				DetentionData[detentionType].active = true
				DetentionData[detentionType].remaining_time = time

				inDetentionType = detentionType

				RequestCollisionAtCoord(thisLocation)

				if not alreadyLoaded then
					DoScreenFadeOut(3000)

					while not IsScreenFadedOut() do
						Wait(1)
					end
				end

				HighLife.Player.Detention.Active = true

				if HighLife.Player.Dead then
					HighLife:RevivePlayer(true)
				end

				HighLife:EndCurrentJob(true)

				if not HighLife.Player.Detention.InICU then
					ESX.SetPlayerData('loadout', {})

					HighLife.Player.Cuffed = false

					RemoveAllPedWeapons(HighLife.Player.Ped, true)

					TriggerServerEvent('HighLife:Detention:RemovePosessions')
				end

				if not alreadyLoaded then
					if Config.Detention[detentionType].EnterLocation ~= nil then
						HighLife:TempDisable()

						SetEntityCoords(HighLife.Player.Ped, thisLocation.x, thisLocation.y, thisLocation.z)

						while not HasCollisionLoadedAroundEntity(HighLife.Player.Ped) do
							Wait(0)
						end
						
						SetEntityCoords(HighLife.Player.Ped, thisLocation.x, thisLocation.y, thisLocation.z)
					end
				else
					if Config.Detention[inDetentionType].MaxDistance ~= nil and Config.Detention[inDetentionType].EnterLocation ~= nil then
						if Vdist(HighLife.Player.Pos, Config.Detention[inDetentionType].EnterLocation) > Config.Detention[inDetentionType].MaxDistance then
							HighLife:TempDisable()

							SetEntityCoords(HighLife.Player.Ped, Config.Detention[inDetentionType].EnterLocation)
						end
					end
				end

				DoScreenFadeIn(5000)

				if Config.Detention[detentionType].Freeze ~= nil and Config.Detention[detentionType].Freeze then
					FreezeEntityPosition(HighLife.Player.Ped, true)
				end

				if Config.Detention[detentionType].Clothes ~= nil then
					HighLife:SetOverrideClothing(Config.Outfits[Config.Detention[detentionType].Clothes])
				end

				if Config.Detention[detentionType].CleanPlayer ~= nil and Config.Detention[detentionType].CleanPlayer then
					ClearPedBloodDamage(HighLife.Player.Ped)
					ResetPedVisibleDamage(HighLife.Player.Ped)
					ClearPedLastWeaponDamage(HighLife.Player.Ped)
				end
			end
		end
	end)
end)

RegisterNetEvent("HighLife:Detention:Release")
AddEventHandler("HighLife:Detention:Release", function(detentionType)
	Release(detentionType)
end)

function Release(detentionType, instant)
	local exitPosition = nil
	local isMorgue = false

	NetworkSetVoiceActive(true)

	HighLife.Player.Detention.Active = false

	if not instant then
		if detentionType == 'Morgue' then
			isMorgue = true

			HighLife.Player.Detention.InMorgue = false

			for k,v in pairs(GetActivePlayers()) do
				SetEntityAlpha(GetPlayerPed(v), 255)
			end

			DoScreenFadeOut(1)
		elseif detentionType == 'Jail' then
			HighLife.Player.Detention.InJail = false

			exitPosition = Config.Detention.Jail.ExitLocation
		elseif detentionType == 'ICU' then
			HighLife.Player.Detention.InICU = false

			SetEntityHealth(HighLife.Player.Ped, GetEntityMaxHealth(HighLife.Player.Ped))

			HighLife.Player.Health_N.DamagedBoneArray = {}

			TriggerScreenblurFadeOut(10000.0)
		end
	else
		TriggerScreenblurFadeOut(1.0)
	end

	if not instant then 
		TriggerServerEvent('HighLife:Detention:Update', detentionType, 0)

		if not isMorgue then
			DoScreenFadeOutWait(3000)
		end
	end

	inReleaseProcess = false

	if not instant then
		DetentionData[detentionType].active = false
		
		if detentionType ~= 'ICU' then
			if Config.Detention[detentionType].Clothes ~= nil then
				HighLife:ResetOverrideClothing()
			end
		end
	end

	ClearPedBloodDamage(HighLife.Player.Ped)
	ResetPedVisibleDamage(HighLife.Player.Ped)
	ClearPedLastWeaponDamage(HighLife.Player.Ped)

	FreezeEntityPosition(HighLife.Player.Ped, false)

	if not instant then
		if HighLife.Player.Dead then
			HighLife:RevivePlayer(true)

			while HighLife.Player.Dead do
				Wait(1)
			end
		end

		if exitPosition ~= nil then
			HighLife:TempDisable()

			SetEntityCoords(HighLife.Player.Ped, exitPosition)
			SetEntityHeading(HighLife.Player.Ped, exitPosition.w)
		end

		Wait(1000)
		
		if not isMorgue then
			DoScreenFadeIn(5000)
		end
	end

	HighLife.Player.AfkCheck = true
	HighLife.Player.DisableShooting = false
end

CreateThread(function()
	while true do
		if HighLife.Player.Detention.Active and inDetentionType ~= nil then
			TriggerServerEvent('HighLife:Detention:Update', inDetentionType, DetentionData[inDetentionType].remaining_time)
		end
		
		Wait(30000)
	end
end)

-- CreateThread(function()
-- 	local jailInteriorID = GetInteriorAtCoords(vector3(1777.181, 2581.242, 45.79))

-- 	while true do
-- 		if not inDetention then
-- 			if not HighLife.Player.InJail and GetInteriorAtCoords(HighLife.Player.Pos) == jailInteriorID then
-- 				HighLife:TempDisable()
				
-- 				SetEntityCoords(HighLife.Player.Ped, Config.Detention.Jail.ExitLocation)
-- 			end
-- 		end

-- 		Wait(10000)
-- 	end
-- end)

CreateThread(function()
	local lastTime = nil
	local ghostCheck = GetGameTimer()

	while true do
		if HighLife.Player.Detention.Active then
			if lastTime == nil then
				lastTime = GameTimerPool.GlobalGameTime
			end

			if Config.Detention[inDetentionType].Ragdoll then
				if not IsPedRagdoll(HighLife.Player.Ped) then
					SetPedToRagdoll(HighLife.Player.Ped, 11000, 11000, 0, true, false, true)
				end
			end

			if not HighLife.Player.InCharacterMenu then
				if Config.Detention[inDetentionType].MaxDistance ~= nil and Config.Detention[inDetentionType].EnterLocation ~= nil then
					if Vdist(HighLife.Player.Pos, Config.Detention[inDetentionType].EnterLocation) > Config.Detention[inDetentionType].MaxDistance then
						HighLife:TempDisable()

						SetEntityCoords(HighLife.Player.Ped, Config.Detention[inDetentionType].EnterLocation)
					end
				end
			end

			DisableControlAction(0, 82, true)
			DisableControlAction(0, 38, true) -- EEEEEEEEEEEEEEEE
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 246, true) -- Phone
			DisableControlAction(0, 263, true)

			-- DisablePlayerFiring(HighLife.Player.Ped, true)
			-- SetEntityInvincible(HighLife.Player.Ped, true)

			SetPlayerWantedLevel(HighLife.Player.Id, 0, false)
			SetPlayerWantedLevelNow(HighLife.Player.Id, false)

			if HighLife.Player.InVehicle then
				ClearPedTasksImmediately(HighLife.Player.Ped)
			end

			if not HighLife.Player.InCharacterMenu then
				if DetentionData[inDetentionType].remaining_time > 0 then
					if GameTimerPool.GlobalGameTime >= (lastTime + 1000) then
						HighLife.Player.AfkCheck = false

						DetentionData[inDetentionType].remaining_time = DetentionData[inDetentionType].remaining_time - 1
						lastTime = GameTimerPool.GlobalGameTime
					end

					if IsScreenFadedOut() then
						DoScreenFadeIn(7000)
					end

					local detentionTypeText = 'in the ~r~morgue'

					if inDetentionType == 'Jail' then
						detentionTypeText = 'in ~b~jail'
					elseif inDetentionType == 'ICU' then
						detentionTypeText = 'in the ~g~ICU'
					end

					if inDetentionType == 'Morgue' then
						if GameTimerPool.GlobalGameTime > (ghostCheck + 2000) then
							ghostCheck = GameTimerPool.GlobalGameTime
							
							for k,v in pairs(GetActivePlayers()) do
							    if Vdist(HighLife.Player.Pos, GetEntityCoords(GetPlayerPed(v))) < 5.0 then
							        SetEntityAlpha(GetPlayerPed(v), 120)
							    end
							end
						end
					end

					DrawBottomText('You have ~y~' .. DetentionData[inDetentionType].remaining_time .. ' ~s~days remaining ' .. detentionTypeText, 0.5, 0.95, 0.4)
				else
					if not inReleaseProcess then
						inReleaseProcess = true

						while HighLife.Player.Dead do
							Wait(1)
						end

						Release(inDetentionType)
					end
				end
			end
		else
			if lastTime ~= nil then
				lastTime = nil

				DisableControlAction(0, 82, false)
				DisableControlAction(0, 38, false) -- EEEEEEEEEEEEEEEE
				DisableControlAction(0, 45, false)
				DisableControlAction(0, 140, false)
				DisableControlAction(0, 246, false) -- Phone
				DisableControlAction(0, 263, false)

				DisableControlAction(0, 249, false)
			end
		end

		Wait(1)
	end
end)