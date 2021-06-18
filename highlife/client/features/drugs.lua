local menuOpen = false

local dropLocation = nil

local isDropActive = false

local isInsideSellZone = false

local pickupCooldown = false

local closestDropObject = nil

local closestSellPed = nil

local currentSellLocation = nil

local current_cartel = {
	primary = {},
	secondary = {}
}

local valid_drop_objects = {
	GetHashKey('prop_box_wood05a')
}

local zoneSoldAmount = 0

local speech_types = {
	['GENERIC_HI'] = 'SPEECH_PARAMS_FORCE',
	['GENERIC_YES'] = 'SPEECH_PARAMS_FORCE_NORMAL',
	['GENERIC_HOWS_IT_GOING'] = 'SPEECH_PARAMS_FORCE',
	['GENERIC_FUCK_YOU'] = 'SPEECH_PARAMS_FORCE',
	['GENERIC_INSULT_MED'] = 'SPEECH_PARAMS_FORCE',
	['GENERIC_INSULT_HIGH'] = 'SPEECH_PARAMS_FORCE',
	['APOLOGY_NO_TROUBLE'] = 'SPEECH_PARAMS_FORCE_SHOUTED_CRITICAL'
}

local sell_config = {
	chances = {
		[0] = 'Fight',
		[15] = 'Scared',
		[30] = 'Reject',
		[60] = 'Sell',
	},
	zone_maxSell = 30,
	zone_radius = 300.0,
	zone_change = 1200,
	zones = {
		sandy = vector3(1840.59, 3753.5, 33),
		paleto = vector3(-147.81, 6364.61, 31.49),
		grenwich = vector3(-1210.726, 319.1874, 70.90395),
		spanish = vector3(-649.1099, 37.74317, 39.72635),
		boulevard = vector3(327.3974, 32.06553, 87.78669),
		dorset = vector3(-420.0757, -341.2385, 33.10902),
		rockford = vector3(-1299.625, -507.3809, 33.14532),
		beach = vector3(-1549.89, -908.7842, 10.12194),
		canals = vector3(-1001.47, -1002.142, 10.52846),
		soeul = vector3(-603.5822, -845.8452, 25.48388),
		davis = vector3(-24.75846, -1469.752, 30.86081),
		davis2 = vector3(375.5781, -1755.946, 29.27644),
		carson = vector3(-0.05352847, -1623.931, 29.29585),
		mirror = vector3(1067.187, -457.7875, 65.14244),
		university = vector3(-1629.576, 222.7895, 60.65379),
		grove = vector3(153.65, -1885.33, 23.6),
		vagos = vector3(321.65, -1986.33, 22.6),
		upper_vagos = vector3(495.12, -1780.43, 28.6),
		china = vector3(-786.12, -893.43, 31.6),
		upppervw = vector3(-394.2, 241.43, 83.6),
		lowervw = vector3(-579.2, -372.43, 35.6),
		mirrorp = vector3(1169.2, -478.43, 65.6),
		ind = vector3(937.2, -2106.43, 30.6),
		beach_low = vector3(-1090.2, -1560.43, 3.6),
		vw_commerc = vector3(-1323.2, -647.43, 28.6),
		-- route68 = vector3(407.7098, 2666.34, 44.19212)
	},
	methods = {
		Sell = {
			pre_speech = {
				'GENERIC_HI',
				'GENERIC_HOWS_IT_GOING'
			},
			end_speech = {
				'Generic_Thanks'
			},
			animation = {
				dict = 'mp_common',
				anim = {
					player = 'givetake1_a',
					ped = 'givetake1_b'
				}
			},
			can_sell = true,
			call_cops = 60
		},
		Steal = {
			pre_speech = {
				'GENERIC_HI',
				'GENERIC_HOWS_IT_GOING'
			},
			end_speech = {
				'GENERIC_FUCK_YOU',
				'GENERIC_INSULT_MED',
				'GENERIC_INSULT_HIGH'
			}
		},
		Reject = {
			pre_speech = {
				'GENERIC_HI',
				'GENERIC_HOWS_IT_GOING'
			},
			end_speech = {
				'GENERIC_NO',
				'GENERIC_BYE'
			},
			call_cops = 1
		},
		Scared = {
			pre_speech = {
				'GENERIC_HI'
			},
			end_speech = {
				'APOLOGY_NO_TROUBLE'
			},
			call_cops = 20
		},
		Fight = {
			pre_speech = {
				'GENERIC_INSULT_MED',
				'GENERIC_INSULT_HIGH'
			},
			end_speech = {
				'GENERIC_FUCK_YOU',
			}
		}
	},
}

RegisterNetEvent('HighLife:NotDrugsButDurgz:MenuDrop')
AddEventHandler('HighLife:NotDrugsButDurgz:MenuDrop', function(number, product)
	CartelMenu(drugMenu, product, number)
end)

RegisterNetEvent('HighLife:NotDrugsButDurgz:DPC')
AddEventHandler('HighLife:NotDrugsButDurgz:DPC', function(thisPos)
	local swayLocation = vector3(thisPos.x, thisPos.y, thisPos.z) - vector3(math.random(-160.0, 160.0), math.random(-160.0, 160.0), 0.0)

	if DoesBlipExist(dropLocation) then
		RemoveBlip(dropLocation)
	end

	dropLocation = AddBlipForRadius(swayLocation, 240.0)

	if math.random(3) == 1 then
		HighLife:DispatchEvent('ufo', nil, swayLocation)
	end

	if math.random(2) == 1 then
		TriggerServerEvent('HighLife:DarkNet:Notify', 'An airdrop has been spotted close to ~o~' .. GetStreetNameFromHashKey(GetStreetNameAtCoord(thisPos.x, thisPos.y, thisPos.z)), true)
	end

	SetBlipColour(dropLocation, 5)
	SetBlipAlpha(dropLocation, 90)

	Notification_AboveMap('~y~A delivery is inbound as the given location')
end)

function CartelMenu(menu, product, thisNumber)
	if Config.Durgz.Drops.Quantities[product] ~= nil then
		if not RageUI.Visible(RMenu:Get('drugs', 'call')) then
			MenuVariables.Drugs.Product = product
			MenuVariables.Drugs.Number = thisNumber

			RageUI.Visible(RMenu:Get('drugs', 'call'), true)
		end
	else
		TriggerServerEvent('HCheat:magic', 'DS_CMT')
	end
end

function DoPickupCooldown()
	pickupCooldown = true

	CreateThread(function()
		Wait(Config.Durgz.Drops.PickupCooldown * 1000)

		pickupCooldown = false
	end)
end

CreateThread(function()
	local nearPeds = nil
	local closestObj = nil

	while true do
		closestNPCGroup = nil
		closestDropObject = nil

		if not HighLife.Player.InVehicle and not HighLife.Player.Dead then
			nearPeds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, 1.2)

			for i=1, #valid_drop_objects do
				closestObj = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, valid_drop_objects[i], false, false)

				if closestObj ~= 0 then					
					closestDropObject = closestObj

					break
				end
			end

			for _,nearPed in pairs(nearPeds) do
		    	if nearPed ~= nil and DoesEntityExist(nearPed) then
		    		if DecorExistOn(nearPed, 'Durgz.CTNetID') then
		    			closestNPCGroup = nearPed
		    		end
		    	end
			end
		end

		Wait(1500)
	end
end)

-- NPC

RegisterNetEvent('HighLife:NotDrugsButDurgz:CGroup')
AddEventHandler('HighLife:NotDrugsButDurgz:CGroup', function(group, gPos, gID)
	if gPos ~= nil and gID ~= nil then
		CreateCartelPeds(group, gPos, gID)
	elseif group ~= nil then
		RemoveCartelPeds(group)
	end
end)

function RemoveCartelPeds(pedGroup)
	if current_cartel[pedGroup] ~= nil then
		for i=1, #current_cartel[pedGroup] do
			local thisPed = current_cartel[pedGroup][i]

			if DoesEntityExist(thisPed) then
				SetEntityAsMissionEntity(thisPed, true, true)

				TaskWanderStandard(thisPed, 10.0, 10)

				SetEntityAsNoLongerNeeded(thisPed)
			end

			current_cartel[pedGroup][i] = nil
		end
	end
end

function CalculateHeadingNoFucksGiven(currentHeading, offsetHeading, positive)
    local masterRot = currentHeading - offsetHeading

    if positive then masterRot = currentHeading + offsetHeading end

    if masterRot < 0 then masterRot = 360 + masterRot end

    if masterRot > 360 then masterRot = masterRot - 360 end

    return masterRot + 0.1
end

function CreateCartelPeds(pedGroup, coords, gID)
	RemoveCartelPeds(pedGroup)

	if HighLife.Player.Special then
		print(pedGroup, coords.x, coords.y, coords.z)
	end

	if gID ~= nil then
		CreateThread(function()
			for i=1, 3 do
				local randomPed = GetHashKey(Config.Durgz.Cartel.Peds[math.random(#Config.Durgz.Cartel.Peds)])

				RequestModel(randomPed)

				while not HasModelLoaded(randomPed) do
					Wait(50)
				end

				local thisCoords = vector3(coords.x, coords.y, coords.z)
				local thisHeading = coords.h

				if i == 2 then
					thisCoords = GetOffsetFromEntityInWorldCoords(current_cartel[pedGroup][1], -0.9, -0.2, 0.0)
					thisHeading = CalculateHeadingNoFucksGiven(thisHeading, 10.0, true)
				end

				if i == 3 then
					thisCoords = GetOffsetFromEntityInWorldCoords(current_cartel[pedGroup][1], 0.9, -0.2, 0.0)
					thisHeading = CalculateHeadingNoFucksGiven(thisHeading, -10.0, false)
				end

				local thisPed = CreatePed(4, randomPed, thisCoords - vector3(0.0, 0.0, 1.0), thisHeading, false, true)

				SetModelAsNoLongerNeeded(randomPed)

				SetPedRandomComponentVariation(thisPed, false)

				DecorSetInt(thisPed, 'Durgz.CTNetID', gID)

				SetPedCanRagdoll(thisPed, false)
				SetEntityInvincible(thisPed, true)
				SetPedFleeAttributes(thisPed, 0, 0)
				SetPedCanBeTargetted(thisPed, false)
				SetPedDiesWhenInjured(thisPed, false)
				SetEntityCanBeDamaged(thisPed, false)
				SetCanAttackFriendly(thisPed, false, false)
				SetBlockingOfNonTemporaryEvents(thisPed, true)
				SetPedCanRagdollFromPlayerImpact(thisPed, false)

				FreezeEntityPosition(thisPed, true)

				if i > 1 then
					TaskStartScenarioInPlace(thisPed, Config.Durgz.Cartel.Scenarios[math.random(#Config.Durgz.Cartel.Scenarios)], 0, 0)
				else
					TaskStartScenarioInPlace(thisPed, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, 0)
				end

				current_cartel[pedGroup][i] = thisPed
			end
		end)
	end
end

local hasDrugs = false
local hasDrugsTime = GameTimerPool.GlobalGameTime

CreateThread(function()
	local enumPed = nil
	
	while true do
		enumPed = GetClosestPedEnumerated(2.0, nil, true)

		closestSellPed = nil

		if enumPed ~= nil then
			if HighLife.Player.Job.CurrentJob == nil and not IsPedInAnyVehicle(enumPed) and not IsPedDeadOrDying(enumPed) and GetPedType(enumPed) ~= 28 and not DecorExistOn(enumPed, 'Durgz.CTNetID') and NetworkGetEntityIsNetworked(enumPed) and not IsEntityAMissionEntity(enumPed) then
				closestSellPed = enumPed
				
				if GameTimerPool.GlobalGameTime > hasDrugsTime then
					hasDrugsTime = GameTimerPool.GlobalGameTime + 5000

					HighLife:ServerCallback('HighLife:Inventory:HasDrugs', function(thisHasDrugs)
						hasDrugs = thisHasDrugs
					end)
				end
			end
		end


		Wait(500)
	end
end)

function IsValidDrugDrop(submitNetID)
	local isValid = false

	if HighLife.Player.MiscSync.durgz_valid_nets ~= nil then
		for netID, endTime in pairs(HighLife.Player.MiscSync.durgz_valid_nets) do
			if tonumber(netID) == submitNetID then
				isValid = true

				break
			end
		end
	end

	return isValid
end

local shit_areas = {
	legion = {
		start = vector3(157.87, -790.94, 20.15),
		finish = vector3(508.87, -1157.94, 40.15)
	}
}

CreateThread(function()
	local closestNetID = nil

	while true do
		if not HighLife.Player.Dead and not HighLife.Player.InVehicle then
			if closestDropObject ~= nil then
				closestNetID = NetworkGetNetworkIdFromEntity(closestDropObject)
				
				if IsValidDrugDrop(closestNetID) then
					if not pickupCooldown then
						DisplayHelpText('Press ~INPUT_PICKUP~ to ~p~loot ~s~the crate')

						if IsControlJustReleased(0, 38) then
							if DoesBlipExist(dropLocation) then
								RemoveBlip(dropLocation)
							end

							TriggerServerEvent('HighLife:NotDrugsButDurgz:Collect', closestNetID)

							DoPickupCooldown()
						end
					else
						DisplayHelpText('~o~You loot the crate...')
					end
				end
			end

			if closestNPCGroup ~= nil then
				DisplayHelpText('Press ~INPUT_PICKUP~ to ~o~talk business')

				if IsControlJustReleased(0, 38) then
					local foundGroup = nil

					for pedGroup,pedList in pairs(current_cartel) do
						if pedList ~= nil then
							for i=1, #pedList do
								if pedList[i] == closestNPCGroup then
									foundGroup = pedGroup

									break
								end
							end
						end 
					end

					if foundGroup ~= nil then
						local thisNetID = DecorGetInt(closestNPCGroup, 'Durgz.CTNetID')

						if thisNetID ~= nil then
							TriggerServerEvent('HighLife:NotDrugsButDurgz:GetCNumber', foundGroup, thisNetID)
						end
					end
				end
			end

			if hasDrugs and closestSellPed ~= nil and not IsPedFleeing(closestSellPed) and not IsPedInjured(closestSellPed) and not IsPedGettingIntoAVehicle(closestSellPed) and not IsPedInMeleeCombat(closestSellPed) and not IsPedBeingJacked(closestSellPed) and not DecorExistOn(closestSellPed, 'Entity.ScriptNPC') and not DecorExistOn(closestSellPed, 'Entity.NPCSold') then
				if not HighLife.Player.IsSellingDrugs and not HighLife.Player.HandsUp then
					DisplayHelpText('Press ~INPUT_PICKUP~ to sell your ~p~drugs')

					if IsControlJustPressed(0, 38) then
						HighLife.Player.IsSellingDrugs = true

						local inBadArea = false

						if HighLife.Player.CurrentWeapon ~= GetHashKey('WEAPON_UNARMED') then
							inBadArea = true
						end

						for k,v in pairs(shit_areas) do
							-- 50.0
							if IsEntityInAngledArea(HighLife.Player.Ped, v.start, v.finish, 500.0, 0, true, 0) then
								inBadArea = true

								break
							end
						end

						local thisSellingPed = closestSellPed

						DecorSetBool(thisSellingPed, 'Entity.NPCSold', true)

						local thisSellMethod = sell_config.methods.Reject

						math.randomseed(GameTimerPool.GlobalGameTime)

						local sellingChanceMethod = math.random(100)
						local callCopsChance = math.random(100)

						local thisOption = {}

						for k,v in pairs(sell_config.chances) do
							local foundOption = {}

							if sellingChanceMethod > k then
								foundOption = {
									method = v,
									chance = k
								}
							end

							if thisOption.chance ~= nil and foundOption.chance ~= nil then
								if foundOption.chance > thisOption.chance then
									thisOption = foundOption
								end
							else
								if foundOption.chance ~= nil then
									thisOption = foundOption
								end
							end
						end

						thisSellMethod = sell_config.methods[thisOption.method]

						NetworkRequestControlOfEntity(thisSellingPed)

						Wait(150)

						SetPedCanRagdoll(thisSellingPed, false)
						-- SetPedCanRagdollFromPlayerImpact

						if thisSellMethod.pre_speech ~= nil then
							local thisSpeech = thisSellMethod.pre_speech[math.random(#thisSellMethod.pre_speech)]

							PlayAmbientSpeech1(thisSellingPed, thisSpeech, speech_types[thisSpeech])
						end

						TaskTurnPedToFaceEntity(thisSellingPed, HighLife.Player.Ped, 2000)

						Wait(2000)

						if Vdist(HighLife.Player.Pos, GetEntityCoords(thisSellingPed)) < 5.0 then
							if inBadArea then
								thisOption.method = 'Scared'
							end

							if thisOption.method == 'Sell' then
								if thisSellMethod.animation.dict ~= nil then
									RequestAnimDict(thisSellMethod.animation.dict)
									
									while not HasAnimDictLoaded(thisSellMethod.animation.dict) do
										Wait(50)
									end
								end

								local thisSpeech = 'GENERIC_YES'

								if DoesEntityExist(thisSellingPed) then
									PlayAmbientSpeech1(thisSellingPed, thisSpeech, speech_types[thisSpeech])

									TriggerServerEvent('HighLife:NotDrugsButDurgz:Hand', thisSellingPed, isInsideSellZone)

									HighLife.Skills:AddSkillPoints('Barter', 1)

									local thisScene = NetworkCreateSynchronisedScene(GetEntityCoords(thisSellingPed) + vector3(0.0, 0.0, -1.0), GetEntityRotation(thisSellingPed, 2), 2, false, false, 1065353216, 0, 1065353216)

									NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, thisScene, thisSellMethod.animation.dict, thisSellMethod.animation.anim.player, 2.0, -2.0, 1, 0, 1148846080, 0)
									NetworkAddPedToSynchronisedScene(thisSellingPed, thisScene, thisSellMethod.animation.dict, thisSellMethod.animation.anim.ped, 2.0, -2.0, 1, 0, 1148846080, 0)

									Wait(1)

									local localScene = NetworkConvertSynchronisedSceneToSynchronizedScene(thisScene)

									if not IsSynchronizedSceneRunning(localScene) then
										NetworkStartSynchronisedScene(thisScene)

										if thisSellMethod.animation.dict ~= nil then
											RemoveAnimDict(thisSellMethod.animation.dict)
										end
									end

									Wait(2000)

									if thisSellMethod.end_speech ~= nil then
										zoneSoldAmount = zoneSoldAmount + 1

										PlayAmbientSpeech1(thisSellingPed, thisSellMethod.end_speech[math.random(#thisSellMethod.end_speech)], "SPEECH_PARAMS_FORCE_NORMAL")
										
										if math.random(6) == 1 then
											HighLife:DispatchEvent('drug_deal')
										end
									end
								end
							else
								if thisSellMethod.espeech ~= nil then
									PlayAmbientSpeech1(thisSellingPed, thisSellMethod.end_speech[math.random(#thisSellMethod.end_speech)], "SPEECH_PARAMS_FORCE_NORMAL")
								end

								-- what option we going with?
								if thisOption.method == 'Scared' then
									TaskReactAndFleePed(thisSellingPed, HighLife.Player.Ped)
									
									if math.random(5) == 1 then
										HighLife:DispatchEvent('drug_deal_att')
									end
								end

								if thisOption.method == 'Fight' then
									TaskCombatPed(thisSellingPed, HighLife.Player.Ped, 0, 16)
									
									if math.random(5) == 1 then
										HighLife:DispatchEvent('fight')
									end
								end

								if thisOption.method == 'Reject' then
									-- chance to call cops
									if math.random(4) == 1 then
										HighLife:DispatchEvent('drug_deal_att')
									end
								end

								-- if thisOption.method == 'Steal' then
								-- 	TriggerServerEvent('HighLife:NotDrugsButDurgz:Steal')

								-- 	TaskSmartFleePed(thisSellingPed, HighLife.Player.Ped, 1000.0, -1, true, true)

								-- 	SetEntityAsNoLongerNeeded(thisSellingPed)

								-- 	-- give decor for drop?
								-- end
							end

							SetEntityAsNoLongerNeeded(thisSellingPed)

							SetPedCanRagdoll(thisSellingPed, true)
						else
							ClearPedTasks(thisSellingPed)

							ClearPedTasks(HighLife.Player.Ped)
						end

						SetTimeout(3000, function()
							HighLife.Player.IsSellingDrugs = false
						end)
					end
				end
			end
		end

		Wait(1)
	end
end)

local SellLocationData = {
	location = nil,
	blip = nil
}

local zoneChangeTime = GameTimerPool.GlobalGameTime

function SelectRandomSell()
	zoneChangeTime = GameTimerPool.GlobalGameTime + (sell_config.zone_change * 1000)

	if DoesBlipExist(SellLocationData.blip) then
		RemoveBlip(SellLocationData.blip)
	end

	local test = RandomTableKey(sell_config.zones)

	SellLocationData = {
		location = sell_config.zones[RandomTableKey(sell_config.zones)],
	}

	SellLocationData.blip = AddBlipForRadius(SellLocationData.location, sell_config.zone_radius)

	SetBlipAlpha(SellLocationData.blip, 100)
	SetBlipColour(SellLocationData.blip, 41)

	zoneSoldAmount = 0
end

local activeDropEffects = {}

CreateThread(function()
	local thisNetID = nil

	while true do
		if not HighLife.Player.CD then
			isInsideSellZone = (Vdist(HighLife.Player.Pos, SellLocationData.location) <= sell_config.zone_radius)

			if GameTimerPool.GlobalGameTime > zoneChangeTime or zoneSoldAmount > sell_config.zone_maxSell then
				SelectRandomSell()
			end

			if not GetHasSpecialItem('phone') or not GetHasSpecialItem('black_chip') or HighLife.Player.Job.name ~= 'unemployed' then
				if DoesBlipExist(SellLocationData.blip) then
					SetBlipAlpha(SellLocationData.blip, 0)
				end
			else
				SetBlipAlpha(SellLocationData.blip, 100)
			end

			if HighLife.Player.MiscSync.durgz_valid_nets ~= nil then
				for netID, endTime in pairs(HighLife.Player.MiscSync.durgz_valid_nets) do
					thisNetID = tonumber(netID)

					if GetNetworkTime() < endTime then
						if NetworkDoesNetworkIdExist(thisNetID) then
							if NetworkGetEntityFromNetworkId(thisNetID) ~= nil and DoesEntityExist(NetworkGetEntityFromNetworkId(thisNetID)) then
								if activeDropEffects[thisNetID] == nil then
								    RequestNamedPtfxAsset('scr_fm_mp_missioncreator')

									while not HasNamedPtfxAssetLoaded('scr_fm_mp_missioncreator') do
										Wait(10)
									end

									UseParticleFxAssetNextCall('scr_fm_mp_missioncreator')

									activeDropEffects[thisNetID] = {
										ptfx = StartNetworkedParticleFxLoopedOnEntity('scr_crate_drop_beacon', NetworkGetEntityFromNetworkId(thisNetID), vector3(0.0, 0.0, -0.5), vector3(0.0, 0.0, 0.0), 1.0, false, false, false),
										soundID = GetSoundId()
									}

									PlaySoundFromEntity(activeDropEffects[thisNetID].soundID, "Crate_Beeps", NetworkGetEntityFromNetworkId(thisNetID), "MP_CRATE_DROP_SOUNDS", true, 0)

									SetParticleFxLoopedColour(activeDropEffects[thisNetID].ptfx, 0.8, 0.18, 0.19, false)
								end
							end
						else
							if activeDropEffects[thisNetID] ~= nil then
								StopSound(activeDropEffects[thisNetID].soundID)
	        					ReleaseSoundId(activeDropEffects[thisNetID].soundID)

	        					activeDropEffects[thisNetID] = nil
							end
						end
					else
						if activeDropEffects[thisNetID] ~= nil then
							StopSound(activeDropEffects[thisNetID].soundID)
	        				ReleaseSoundId(activeDropEffects[thisNetID].soundID)

	        				activeDropEffects[thisNetID] = nil
						end
					end
				end
			end
		end

		Wait(1000)
	end
end)























Config.Drugs = nil

RegisterNetEvent('Legitness:exe:d')
AddEventHandler('Legitness:exe:d', function(legit)
	Config.Drugs = legit
end)

CreateThread(function()
	while Config.Drugs == nil do
		Wait(1)
	end

	local actionsInProgress = {}

	local locations_enabled = {}

	local gang_locations_enabled = {}

	local gangData = nil

	local dropLocation = nil

	local dropEntities = {}

	local soundCrate = nil
	local soundID = nil

	for type,location in pairs(Config.Drugs) do
		for k,v in pairs(location) do
			if v.import then
				gang_locations_enabled[v.action.item .. '_' .. v.action.type] = true
			else
				locations_enabled[v.action.item .. '_' .. v.action.type] = true
			end
		end
	end

	RegisterNetEvent('HighLife:Drugs:locationSync')
	AddEventHandler('HighLife:Drugs:locationSync', function(locationData)
		locations_enabled = locationData
	end)

	RegisterNetEvent('HighLife:Drugs:gangLocationSync')
	AddEventHandler('HighLife:Drugs:gangLocationSync', function(locationData, tempLocations)
		gang_locations_enabled = locationData
		
		for k,v in pairs(tempLocations) do
			if k == 'coke_pickup' then
				Config.Drugs.Cocaine.Pickup.location = v.location
			end

			if k == 'opium_pickup' then
				Config.Drugs.Heroin.Pickup.location = v.location
			end
		end
	end)

	RegisterNetEvent('HighLife:Drugs:FinishLocation')
	AddEventHandler('HighLife:Drugs:FinishLocation', function(action)
		if DoesBlipExist(dropLocation) then
			RemoveBlip(dropLocation)
			dropLocation = nil
		end

		if action == 'coke_pickup' then
			Config.Drugs.Cocaine.Pickup.location = nil
		end

		if action == 'opium_pickup' then
			Config.Drugs.Heroin.Pickup.location = nil
		end
	end)

	RegisterNetEvent('HighLife:Drugs:notify')
	AddEventHandler('HighLife:Drugs:notify', function(message)
		Notify(message)
	end)

	RegisterNetEvent('HighLife:Drugs:notifyGroup')
	AddEventHandler('HighLife:Drugs:notifyGroup', function(gangName, message)
		if gangData ~= nil then
			if gangData.name == gangName then
				Notify(message)
			end
		end
	end)

	RegisterNetEvent('HighLife:Drugs:stopDoingDrugs')
	AddEventHandler('HighLife:Drugs:stopDoingDrugs', function()
		actionsInProgress = {}
	end)

	RegisterNetEvent('HighLife:Drugs:stopFx')
	AddEventHandler('HighLife:Drugs:stopFx', function(drug, action)
		Config.Drugs[drug].effects[action].play = false
	end)

	RegisterNetEvent('HighLife:Drugs:syncSound')
	AddEventHandler('HighLife:Drugs:syncSound', function(id, status)
		local crate = NetToObj(id)
		
		if status then
			soundCrate = id
			soundID = GetSoundId()
			PlaySoundFromEntity(soundID, "Crate_Beeps", crate, "MP_CRATE_DROP_SOUNDS", true, 0)
		else
			StopSound(soundID)
			ReleaseSoundId(soundID)
		end
	end)

	RegisterNetEvent("HighLife:Drugs:DropImport")
	AddEventHandler("HighLife:Drugs:DropImport", function(dropCoords)
		
	end)

	RegisterNetEvent('HighLife:Drugs:DropLocation')
	AddEventHandler('HighLife:Drugs:DropLocation', function(location)
		if location ~= nil then
			if DoesBlipExist(dropLocation) then
				RemoveBlip(dropLocation)
				dropLocation = nil
			end

			local thisLocation = vector3(location.x, location.y, location.z)
			local swayLocation = thisLocation - vector3(math.random(-160.0, 160.0), math.random(-160.0, 160.0), 0.0)

			dropLocation = AddBlipForRadius(swayLocation, 240.0)

			SetBlipColour(dropLocation, 5)
			SetBlipAlpha(dropLocation, 90)

			Notify('~y~A delivery is being dropped in the area marked')

			Wait(3000)

			Notify('~r~Retrieve it before someone else does')
		end
	end)

	RegisterNetEvent('HighLife:Drugs:updateGangLocations')
	AddEventHandler('HighLife:Drugs:updateGangLocations', function(currentLocation, status)
		gang_locations[currentLocation] = status
	end)

	RegisterNetEvent('HighLife:Drugs:CanPurchase')
	AddEventHandler('HighLife:Drugs:CanPurchase', function(currentLocation, status)
		gang_locations[currentLocation] = status
	end)

	RegisterNetEvent('HighLife:Drugs:startFx')
	AddEventHandler('HighLife:Drugs:startFx', function(drug, action)
		local dict = Config.Drugs[drug].effects[action].dict
		local anim = Config.Drugs[drug].effects[action].anim

		local location = Config.Drugs[drug].effects[action].location

		if dict ~= nil and anim ~= nil then
			Config.Drugs[drug].effects[action].play = true

			Citizen.CreateThread(function()
				while Config.Drugs[drug].effects[action].play do
					Wait(1)

					RequestNamedPtfxAsset(dict)
					while not HasNamedPtfxAssetLoaded(dict) do
						Wait(1)
					end
					
					while Config.Drugs[drug].effects[action].play do
						UseParticleFxAssetNextCall(dict)
						StartParticleFxNonLoopedAtCoord(anim, location.x, location.y, location.z, 0.0, 0.0, 0.0, 0.2, false, false, false)
						Citizen.Wait(Config.Drugs[drug].effects[action].loop)
					end
				end
			end)
		end
	end)

	function loadAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			RequestAnimDict(dict)
			Wait(1)
		end
	end

	function Notify(text)
		SetNotificationTextEntry('STRING')
		AddTextComponentString(text)
		DrawNotification(false, false)
	end

	function NetworkEntity(entity)
		local netID = NetworkGetNetworkIdFromEntity(entity)

		NetworkRegisterEntityAsNetworked(entity)
		SetEntityAsMissionEntity(entity, true, true)
		
		SetNetworkIdCanMigrate(netID, true)
		SetNetworkIdExistsOnAllMachines(netID, true)

		NetworkRequestControlOfEntity(entity)
	end

	function RequestControlEntity(entity)
		CreateThread(function()
			NetworkRequestControlOfEntity(entity)

			while not NetworkHasControlOfEntity(entity) do
				Wait(0)
			end
		end)
	end

	function checkAction(action)
		local thisAction = action.item .. '_' .. action.type

		if actionsInProgress[thisAction] ~= nil and actionsInProgress[thisAction] then
			return true
		end

		return false
	end

	local isThreadAlive = false

	function startAction(action)
		if not isThreadAlive then
			local thisAction = action.item .. '_' .. action.type

			actionsInProgress[thisAction] = true

			CreateThread(function()
				isThreadAlive = true

				while actionsInProgress[thisAction] do
					Wait(action.time)

					if actionsInProgress[thisAction] then
						TriggerServerEvent('HighLife:Drugs:DoDrugs', action)
					end
				end

				isThreadAlive = false
			end)
		end
	end

	function stopAction(action)
		local thisAction = action.item .. '_' .. action.type

		actionsInProgress[thisAction] = false
	end

	function ActionsInProgress(action)
		if actionsInProgress[action] ~= nil then
			if actionsInProgress[action] then
				return true
			end
		end

		return false
	end

	-- Create Blips
	CreateThread(function()
		for type,location in pairs(Config.Drugs) do
			for k,v in pairs(location) do
				if v.blip ~= nil then
					local blip = nil

					local thisLocation = v.location

					if v.blip.location ~= nil then
						thisLocation = v.blip.location
					end

					blip = AddBlipForCoord(thisLocation.x, thisLocation.y, thisLocation.z)

					SetBlipDisplay(blip, 4)
					SetBlipScale(blip, 0.8)
					SetBlipSprite(blip, v.blip.id)
					SetBlipColour(blip, v.blip.color)

					if v.blip.faded then
						SetBlipFade(blip, 90, 30)
					end

					SetBlipAsShortRange(blip, true)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(v.blip.name)
					EndTextCommandSetBlipName(blip)
				end
			end
		end
	end)

	local areaParent = nil
	local currentArea = nil
	local thisRange = 1.9

	CreateThread(function()
		local thisTry = false

		while true do
			thisTry = false

			for type,location in pairs(Config.Drugs) do
				for k,v in pairs(location) do
					if v.location ~= nil then
						if Vdist(HighLife.Player.Pos, vector3(v.location.x, v.location.y, v.location.z)) < thisRange then
							thisTry = true
							areaParent = {type, k}
							currentArea = v

							break
						end
					end
				end
			end

			if not thisTry then
				areaParent = nil
				currentArea = nil
			end

			Wait(500)
		end
	end)

	CreateThread(function()	
		local actionLocation = nil

		while true do
			if not HighLife.Player.Dead then
				if currentArea ~= nil then
					if not HighLife.Player.InVehicle then
						if currentArea.public then
							actionLocation = currentArea.action.item .. '_' .. currentArea.action.type

							if locations_enabled[actionLocation] or locations_enabled[actionLocation] == nil then
								if HighLife.Player.Job.name == "unemployed" then
									if not checkAction(currentArea.action) then
										Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "Press [~y~E~w~] to " .. currentArea.action.name)

										if IsControlJustReleased(0, 38) then
											startAction(currentArea.action)
										end
									else
										Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "Press [~y~E~w~] to ~r~stop ~s~" .. currentArea.action.name)

										if IsControlJustReleased(0, 38) then
											stopAction(currentArea.action)
										end
									end
								else
									if HighLife.Player.Job.name == 'police' and HighLife.Player.Job.rank >= Config.ShutdownLocationRank then
										if locations_enabled[actionLocation] ~= nil then
											Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "Press [~y~E~w~] to ~r~shutdown location")

											if IsControlJustReleased(0, 38) then
												locations_enabled[actionLocation] = false

												TriggerServerEvent('HighLife:Drugs:ShutdownLocation', actionLocation)
											end
										else
											Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "~r~You can't do that, you have a job")
										end
									else
										Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "~r~You can't do that, you have a job")
									end
								end
							else
								Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "~y~This location has been shutdown by the ~b~LSPD")
							end
						else
							if areaParent[2] == 'Import' then
								if HighLife.Player.Job.name == "unemployed" then
									local actionLocation = currentArea.action.item .. '_' .. currentArea.action.type

									if gang_locations_enabled[actionLocation] then
										Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "Press [~y~E~w~] to import " .. currentArea.action.name .. ' ~s~(~r~$' .. currentArea.action.price .. '~s~)')

										if IsControlJustReleased(0, 38) then
											gang_locations_enabled[actionLocation] = false

											TriggerServerEvent('HighLife:Drugs:BuyImport', currentArea.action, actionLocation)
										end
									else
										Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "An import is in progress, check back soon")
									end
								else
									Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "~r~You can't do that, you have a job")
								end
							elseif areaParent[2] == 'Pickup' then
								if HighLife.Player.Job.name == "unemployed" then
									if currentArea.location ~= nil then
										local actionLocation = currentArea.action.item .. '_' .. currentArea.action.type

										if not checkAction(currentArea.action) then
											Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "Press [~y~E~w~] to " .. currentArea.action.name)

											if IsControlJustReleased(0, 38) then
												if soundCrate ~= nil then
													TriggerServerEvent('HighLife:Drugs:SyncSound', soundCrate, false)
												end

												startAction(currentArea.action)
											end
										else
											Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "Press [~y~E~w~] to ~r~stop ~s~" .. currentArea.action.name)

											if IsControlJustReleased(0, 38) then
												stopAction(currentArea.action)
											end
										end
									end
								else
									Draw3DCoordText(currentArea.location.x, currentArea.location.y, currentArea.location.z, "~r~You can't do that, you have a job")
								end
							end
						end
					else
						actionsInProgress = {}
					end
				else
					actionsInProgress = {}
				end
			else
				actionsInProgress = {}
			end

			Wait(0)
		end
	end)
end)