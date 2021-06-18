local maxHealth = 200
local minHealth = 100

RegisterNetEvent('HighLife:EMS:Revive')
AddEventHandler('HighLife:EMS:Revive', function(token, staffOrJob)
	HighLife:RevivePlayer(nil, token, staffOrJob)
end)

-- RegisterNetEvent('fr')
-- AddEventHandler('fr', function()
-- 	HighLife:RespawnPlayer()
-- end)

RegisterNetEvent('HighLife:EMS:Heal')
AddEventHandler('HighLife:EMS:Heal', function(heal_type)
	local maxHealth = GetEntityMaxHealth(HighLife.Player.Ped)

	if heal_type == 'bandage' then
		HighLife.Player.Bleeding = false
		
		local health = GetEntityHealth(HighLife.Player.Ped)

		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8)) -- pretty dumb, adds 25

		SetEntityHealth(HighLife.Player.Ped, newHealth)
	elseif heal_type == 'full' then
		SetEntityHealth(HighLife.Player.Ped, maxHealth)
	end

	Notification_AboveMap('~y~You have been healed')
end)

local carryRequestTimeout = GameTimerPool.GlobalGameTime

function CountJobOnline(jobName)
	if HighLife.Other.OnlineJobs ~= nil then
		if jobName ~= nil then
			return (HighLife.Other.OnlineJobs[jobName] ~= nil and HighLife.Other.OnlineJobs[jobName] or 0)
		end
	end

	return 0
end

function HighLife:StartBleedoutTimer(sniperShot)
	local respawnTime = (HighLife.Player.Debug and 10 or Config.EMS.RespawnTime)

	local respawnText = 'You are ~b~unconscious~w~ from your wounds'

	if not HighLife.Player.Debug then
		if CountJobOnline('ambulance') < 1 then
			respawnTime = 420
		end
	end

	if sniperShot then
		respawnText = '~r~You have no pulse~s~'
	end
	
	if HighLife.Player.Detention.InJail then
		respawnTime = (HighLife.Settings.Development and 5 or 60)
		respawnText = 'You are ~y~unconscious'
	end

	CreateThread(function()
		local isSniperShot = sniperShot
		local attempting = false
		local hasCalled = false
		local lastTime = GameTimerPool.GlobalGameTime

		while respawnTime > 0 and HighLife.Player.Dead do
			if HighLife.Player.Dragger == nil then
				if GameTimerPool.GlobalGameTime >= (lastTime + 1000) then
					respawnTime = respawnTime - 1
					lastTime = GameTimerPool.GlobalGameTime
				end
			else
				if HighLife.Player.Detention.InJail then
					respawnTime = (HighLife.Settings.Development and 5 or 60)
				elseif CountJobOnline('ambulance') < 1 then
					respawnTime = 420
				else
					respawnTime = (HighLife.Player.Debug and 10 or Config.EMS.RespawnTime)
				end
			end

			raw_seconds = respawnTime
			raw_minutes = raw_seconds / 60
			minutes = stringsplit(raw_minutes, ".")[1] or 0
			seconds = stringsplit(raw_seconds - (minutes * 60), ".")[1] or 0

			if not hasCalled and not HighLife.Player.Detention.InJail and not isSniperShot then
				respawnText = 'You are ~b~unconscious~s~, press [~y~R~w~] to shout for ~g~help~n~~s~Press [~y~Q~s~] to be carried - ' .. string.format("~s~(~r~%s~s~m ~r~%s~s~s)", minutes, seconds) .. ' until local ambulance arrival'
			end

			if hasCalled then
				if attempting then
					respawnText = 'You are ~b~unconscious~s~, ~y~you shout out for help'
				else				
					respawnText = 'You are ~b~unconscious~s~, someone has called for help!'
				end
			end

			if HighLife.Player.IsStable then
				respawnText = 'You have been ~b~stabilized~s~. Press [~y~Q~s~] to be carried'
			end

			if HighLife.Player.Dragger == nil then
				DrawBottomText(respawnText, 0.5, 0.8, 0.5, 4)
			end

			if not hasCalled and not HighLife.Player.Detention.InJail then
				if IsControlJustReleased(0, 80) then
					if not HighLife.Player.IsStable then
						attempting = true
						hasCalled = true

						if not HighLife.Player.InArmyBase then
							if HighLife:DispatchEventCallback('dead') then
								CreateThread(function()
									Wait(3000)
									
									if IsAnyJobs({'police'}) then
										HighLife:DispatchEvent('dead_police', {
											respawnTime = respawnTime,
											serverID = HighLife.Player.ServerId
										})
									elseif IsAnyJobs({'ambulance'}) then
										HighLife:DispatchEvent('dead_ems', {
											respawnTime = respawnTime,
											serverID = HighLife.Player.ServerId
										})
									else
										HighLife:DispatchEvent('dead', {
											respawnTime = respawnTime,
											serverID = HighLife.Player.ServerId
										})
									end

									attempting = false
								end)
							else
								CreateThread(function()
									Wait(3000)

									hasCalled = false
								end)
							end
						else
							CreateThread(function()
								Wait(10000)

								hasCalled = false
							end)
						end
					end
				elseif IsControlJustReleased(0, 44) then
					if not HighLife.Player.InVehicle then
						if GameTimerPool.GlobalGameTime > carryRequestTimeout then
							local player, distance = GetClosestPlayer()
						
							if player ~= nil and distance < 3.0 then
								HighLife:ServerCallback('HighLife:Carry:CheckCanCarry', function(canCarry)
									if canCarry then
										carryRequestTimeout = GameTimerPool.GlobalGameTime + 5000

										Notification_AboveMap("~y~You ask the person to help you")

										TriggerServerEvent('HighLife:Drag:Request', GetPlayerServerId(player))
									else
										Notification_AboveMap("~o~That person cannot carry you as they were not involved in your death")
									end
								end, GetPlayerServerId(player))
							else
								Notification_AboveMap("~o~Nobody nearby to carry you")
							end
						end
					else
						Notification_AboveMap('~o~You cannot be carried while inside a vehicle')
					end
				end
			end

			Wait(1)
		end

		if not HighLife.Player.IsStable then
			HighLife:StartRespawnTimer(isSniperShot)
		end

		HighLife.Player.IsStable = false
	end)
end

function HighLife:StartPlayerDeath()
	HighLife.Player.IsStable = false

	HighLife:UpdateCorePlayerStats()

	local hit, bone = GetPedLastDamageBone(HighLife.Player.Ped)

	local fadeOut = 50

	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		fadeOut = 1400
	end

	CreateThread(function()
		if not HighLife.Settings.Development then
			DoScreenFadeOut(fadeOut)
		end

		StartScreenEffect('DeathFailOut', 0, true)

		Wait((HighLife.Settings.Development and 100 or 3000))

		if GetEntityHealth(HighLife.Player.Ped) < 101 then
			HighLife:ServerCallback('HighLife:Health:Gate', function(status)
				if status then
					local returnVehicle = {
						entity = nil,
						seat = nil
					}

					if HighLife.Player.InVehicle then
						returnVehicle = {
							entity = HighLife.Player.Vehicle,
							seat = HighLife.Player.VehicleSeat
						}
					end

					NetworkResurrectLocalPlayer(HighLife.Player.Pos, HighLife.Player.Heading, false, false)

					SetEntityHealth(HighLife.Player.Ped, 101)

					-- if returnVehicle.entity ~= nil then
					-- 	SetPedIntoVehicle(HighLife.Player.Ped, returnVehicle.entity, returnVehicle.seat)
					-- end

					HighLife.Player.Bleeding = false
				end
			end)
		end

		Wait((HighLife.Settings.Development and 100 or 3000))

		HighLife:StartBleedoutTimer(isSniper)

		HighLife.Player.AfkCheck = false
		
		if not HighLife.Settings.Development then
			DoScreenFadeIn(19000)
		end
	end)
end

function HighLife:RevivePlayer(localCall, token, staffOrJob)
	if localCall or HighLife:IsValidPlayerToken(token) then
		HighLife:ServerCallback('HighLife:Health:Gate', function(status)
			if status then
				HighLife.Player.AfkCheck = true
				HighLife.Player.IsStable = true

				HighLife.Player.Health_N.DamagedBoneArray = {}

				CreateThread(function()
					if not HighLife.Settings.Development then
						DoScreenFadeOut(800)

						while not IsScreenFadedOut() do
							Wait(0)
						end
					end
					
					HighLife:HospitalRespawn(false, staffOrJob)

					StopScreenEffect('DeathFailOut')
				
					TriggerEvent('dpEmotes:SetDefaultWalkStyle', 'default')

					HighLife.Player.Bleeding = false

					ClearPedBloodDamage(HighLife.Player.Ped)

					HighLife.Player.Dragger = nil

					if not HighLife.Settings.Development then
						DoScreenFadeIn(8500)
					end

					HighLife:UpdateCorePlayerStats()

					-- Try apply their tattoos

					UpdatePlayerDecorations(true)
				end)
			end
		end)
	else
		TriggerServerEvent('HCheat:magic', 'HL_RP_TE')
	end
end

CreateThread(function()
	local diedThisFrame = false
	local thisHealth = GetEntityHealth(HighLife.Player.Ped)

	local hitDetected, thisDamagedBone = nil

	while true do
		if not HighLife.Player.CD then
			hitDetected, thisDamagedBone = nil

			thisHealth = GetEntityHealth(HighLife.Player.Ped)

			if HighLife.Player.Bleeding and GameTimerPool.Bleeding == nil then
				GameTimerPool.Bleeding = GameTimerPool.GlobalGameTime

				CreateThread(function()
					Wait(5000)
					
					Notification_AboveMap('~r~You are slowly bleeding')
				end)
			end

			if GameTimerPool.Bleeding ~= nil and GameTimerPool.GlobalGameTime >= (GameTimerPool.Bleeding + 7000) then
				if HighLife.Player.Bleeding then
					if HighLife.Player.Health ~= nil and HighLife.Player.Health > 99 then
						SetEntityHealth(HighLife.Player.Ped, HighLife.Player.Health - math.random(1, 2))
					end
					
					GameTimerPool.Bleeding = GameTimerPool.GlobalGameTime
				else
					Notification_AboveMap('~y~You are no longer bleeding')

					GameTimerPool.Bleeding = nil
				end
			end

			if HighLife.Player.Health ~= nil and HighLife.Player.Health ~= thisHealth then
				diedThisFrame = false

				hitDetected, thisDamagedBone = GetPedLastDamageBone(HighLife.Player.Ped)

				for i=1, #Config.BleedingWeapons do
					if HasPedBeenDamagedByWeapon(HighLife.Player.Ped, Config.BleedingWeapons[i], 0) then
						HighLife.Player.Bleeding = true
						
						break
					end
				end

				if hitDetected then
					if thisDamagedBone ~= nil and thisDamagedBone ~= 0 and HighLife.Player.LastDamagedBone ~= thisDamagedBone then
						HighLife.Player.LastDamagedBone = thisDamagedBone

						if thisHealth < minHealth and HighLife.Player.Health ~= thisHealth then
							diedThisFrame = true
						end

						table.insert(HighLife.Player.Health_N.DamagedBoneArray, {
							died = diedThisFrame,
							bone = thisDamagedBone,
							time = GameTimerPool.GlobalGameTime,
							velocity = GetEntityVelocity(HighLife.Player.Ped),
							health_lost = HighLife.Player.Health - thisHealth,
						})

						-- local printBone = 'last hit bone id: ' .. Config.BoneNames[thisDamagedBone] .. ' at ' .. GameTimerPool.GlobalGameTime .. ', lost: ' .. HighLife.Player.Health - thisHealth

						-- print(printBone)

						-- for k,v in pairs(HighLife.Player.DamagedBoneArray[#HighLife.Player.DamagedBoneArray]) do
						-- 	print(k, v)
						-- end

						-- Notification_AboveMap(printBone)
					end
				end

				-- Hit by police dog
				if GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, Config.WeaponHashes.unarmed) ~= 0 then
					thisHealth = HighLife.Player.Health
					
					SetEntityHealth(HighLife.Player.Ped, thisHealth)

					if not HighLife.Player.KnockedOut then
						if (math.random(40) == 1) or (thisHealth < 178 and math.random(15) == 1) or (thisHealth < 130 and math.random(5) == 1) then
							HighLife:Knockout()
						end
					end

					ApplyDamageToPed(HighLife.Player.Ped, math.random(1, 3), false)
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_ANIMAL')) ~= 0 then
					if math.random(2) == 1 then
						SetPedToRagdollWithFall(HighLife.Player.Ped, 4000, 4000, 0, GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
					end

					ApplyDamageToPed(HighLife.Player.Ped, math.random(5, 10), false)
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_KNUCKLE')) ~= 0 then
					if math.random(3) == 1 then
						SetPedToRagdollWithFall(HighLife.Player.Ped, 4000, 4000, 0, GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
					end

					ApplyDamageToPed(HighLife.Player.Ped, math.random(12, 20), false)
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_NONLETHALSHOTGUN')) ~= 0 then
					ClearPedBloodDamage(HighLife.Player.Ped)

					if math.random(2) == 1 then
						local downTime = math.random(3000, 6000)
						
						SetPedToRagdollWithFall(HighLife.Player.Ped, downTime, downTime, 0, -GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
					end
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_flashlight')) ~= 0 or GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_poolcue')) ~= 0 and GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_nightstick')) ~= 0 then
					thisHealth = HighLife.Player.Health
					
					SetEntityHealth(HighLife.Player.Ped, (thisHealth - math.random(1,3)))

					if math.random(3) == 1 or IsPedRagdoll(HighLife.Player.Ped) then
						local downTime = math.random(700, 1000)
						
						SetPedToRagdollWithFall(HighLife.Player.Ped, downTime, downTime, 0, -GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
					end
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_bat')) ~= 0 or GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_wrench')) ~= 0 or GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_crowbar')) ~= 0 or GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_hammer')) ~= 0 or GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('weapon_golfclub')) ~= 0 then
					thisHealth = HighLife.Player.Health
					
					SetEntityHealth(HighLife.Player.Ped, (thisHealth - math.random(5,15)))

					if math.random(3) == 1 or IsPedRagdoll(HighLife.Player.Ped) then
						local downTime = math.random(1000, 3000)
						
						SetPedToRagdollWithFall(HighLife.Player.Ped, downTime, downTime, 0, -GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
					end
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_SNOWBALL')) ~= 0 then
					thisHealth = HighLife.Player.Health
					
					SetEntityHealth(HighLife.Player.Ped, thisHealth)

					if math.random(100) == 1 then
						local downTime = math.random(2500, 3500)
						
						SetPedToRagdollWithFall(HighLife.Player.Ped, downTime, downTime, 0, -GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
					end
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_PAINTBALLGUN')) ~= 0 then
					thisHealth = HighLife.Player.Health
					
					SetEntityHealth(HighLife.Player.Ped, thisHealth)
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_STUNGUN')) ~= 0 then
					SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)

					-- TODO: Does slight damage
					-- TODO: Does have heart condition
				elseif GetTimeOfLastPedWeaponDamage(HighLife.Player.Ped, GetHashKey('WEAPON_SMOKEGRENADE')) ~= 0 then
					thisHealth = HighLife.Player.Health

					SetEntityHealth(HighLife.Player.Ped, thisHealth)

					-- Bad but exempts gas masks from recieving the effect
					if GetPedDrawableVariation(HighLife.Player.Ped, 1) ~= 138 then
						if not AnimpostfxIsRunning('Dont_tazeme_bro') then
							AnimpostfxPlay('Dont_tazeme_bro', 0, true)
						end

						if IsScreenblurFadeRunning() then
							DisableScreenblurFade()
						end

						TriggerScreenblurFadeIn(4000.0)

						HighLife.Player.LastGasTime = GameTimerPool.GlobalGameTime 
					end
				end

				ClearPedLastWeaponDamage(HighLife.Player.Ped)
				ClearEntityLastWeaponDamage(HighLife.Player.Ped)
				ClearEntityLastDamageEntity(HighLife.Player.Ped)
				ClearPedLastDamageBone(HighLife.Player.Ped)
			end

			HighLife.Player.Health = thisHealth
		end

		Wait(1)
	end
end)