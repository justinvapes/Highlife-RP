local isDrunk = false
local isBlazed = false
local isRepairing = false
local isHotDogging = false
local isLockpicking = false
local isSettingShitOnFire = false

local blazedLevel = 0

-- StartScreenEffect('DrugsDrivingIn', 0, false)
-- StopScreenEffect('DrugsDrivingIn')
-- StartScreenEffect('DrugsDrivingOut', 0, false)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	local PlayerData = xPlayer

	for i=1, #PlayerData.inventory do
		for j=1, #Config.SpecialItems do
			if PlayerData.inventory[i].name == Config.SpecialItems[j] then
				if PlayerData.inventory[i].count > 0 then
					HighLife.Player.SpecialItems[PlayerData.inventory[i].name] = true
				end
			end
		end
	end
end)

RegisterNetEvent('HighLife:SpecialItems:Update')
AddEventHandler('HighLife:SpecialItems:Update', function(item_name, hasItem)
	HighLife.Player.SpecialItems[item_name] = hasItem
end)

RegisterNetEvent('HighLife:Items:Case')
AddEventHandler('HighLife:Items:Case', function(briefcase)
	HighLife:WeaponGate()
	
	if briefcase then
		GiveWeaponToPed(HighLife.Player.Ped, GetHashKey('WEAPON_BRIEFCASE_02'), 1, true, true)
	else
		GiveWeaponToPed(HighLife.Player.Ped, GetHashKey('WEAPON_BRIEFCASE'), 1, true, true)
	end
end)

RegisterNetEvent('HighLife:Items:GasMask')
AddEventHandler('HighLife:Items:GasMask', function()
	SetPedComponentVariation(HighLife.Player.Ped, 1, 138, 0, 0)

	-- Remove glasses
	SetPedPropIndex(HighLife.Player.Ped, 1, (isMale() and 0 or 5), 0, 0, false)
end)

local isCleaning = false

RegisterNetEvent('HighLife:Items:CleanCar')
AddEventHandler('HighLife:Items:CleanCar', function()
	if not isCleaning then
		isCleaning = true

		TriggerEvent('dp:playanim', 'clean')

		local foundVehicle = GetClosestVehicleEnumeratedAtCoords(HighLife.Player.Pos, 4.0)

		if foundVehicle ~= nil then
			local hasUsed = false

			CreateThread(function()
				local fullyCleaned = false

				while true do
					if foundVehicle ~= nil then
						if Vdist(HighLife.Player.Pos, GetEntityCoords(foundVehicle)) < 4.0 then
							if GetVehicleDirtLevel(foundVehicle) > 0.0 then
								if (GetVehicleDirtLevel(foundVehicle) - 0.150) > 0.0 then
									SetVehicleDirtLevel(foundVehicle, GetVehicleDirtLevel(foundVehicle) - 0.150)
									
									hasUsed = true
								else
									if not fullyCleaned then
										Notification_AboveMap('~g~Your vehicle is as clean as can be')

										fullyCleaned = true
									end
								end
							end
						else
							break
						end
					else
						break
					end

					Wait(500)
				end

				isCleaning = false
				
				TriggerEvent('dp:playanim', 'cancel')

				if hasUsed then
					TriggerServerEvent('HighLife:Inventory:RemoveItem', 'cleaning_kit', 1)
				end
			end)
		end
	end
end)

RegisterNetEvent('HighLife:Avacado:Thanks')
AddEventHandler('HighLife:Avacado:Thanks', function()
	HighLife.SpatialSound.CreateSound('default', {
		url = 'https://cdn.highliferoleplay.net/fivem/sounds/avacado.ogg',
		findEntity = 'player',
		distance = 5.0,
		volume = 0.1
	})
end)

RegisterNetEvent('HighLife:Items:Respirator')
AddEventHandler('HighLife:Items:Respirator', function()
	SetPedComponentVariation(HighLife.Player.Ped, 1, (isMale() and 12 or 15), 0, 0)

	-- Remove glasses
	SetPedPropIndex(HighLife.Player.Ped, 1, (isMale() and 0 or 5), 0, 0, false)
end)

RegisterNetEvent('HighLife:Items:HotDog')
AddEventHandler('HighLife:Items:HotDog', function()
	if not isHotDogging then
		isHotDogging = true

		CreateThread(function()
			local startTime = GameTimerPool.GlobalGameTime

			local primaryColor = 0
			local secondaryColor = 0

			AnimpostfxPlay('MP_Celeb_Win', 0, true)

			while GameTimerPool.GlobalGameTime < (startTime + 60000) do
				thisRand = math.random(1000)

				SetPedHairColor(HighLife.Player.Ped, thisRand, thisRand / 2)

				Wait(80)
			end

			AnimpostfxStop('MP_Celeb_Win')

			AnimpostfxPlay('MP_Celeb_Win_Out', 0, false)

			isHotDogging = false
		end)

		Notification_AboveMap('The water leaves a, funny... taste in your mouth...')
	else
		Notification_AboveMap('You already appear to be hot dogging!')
	end
end)

RegisterNetEvent('HighLife:Items:Lockpick')
AddEventHandler('HighLife:Items:Lockpick', function(police)
	Lockpick(police)
end)

RegisterNetEvent('HighLife:Items:Joint')
AddEventHandler('HighLife:Items:Joint', function()
	CreateThread(function()
		if not HighLife.Player.InVehicle then
			TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_SMOKING_POT", 0, false)

			Wait(15000)

			ClearPedTasks(HighLife.Player.Ped)

			HighLife.Player.Vitals.weed.level = HighLife.Player.Vitals.weed.level + Config.DrugAttributes.weed.HitValue
		end
	end)
end)

RegisterNetEvent('HighLife:Items:Medkit')
AddEventHandler('HighLife:Items:Medkit', function()
	CreateThread(function()
		local player, distance = GetClosestPlayer()

		if player ~= nil and distance < 2.5 then
			if IsHighLifeGradeDead(GetPlayerPed(player)) then
				HighLife:ServerCallback('HighLife:RemoveItem', function(validRemove)
					if validRemove then
						CreateThread(function()							
							TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							
							Wait(7000)
							
							ClearPedTasks(HighLife.Player.Ped)

							print(HighLife.Skills:GetSkillLevel('Medical').useful_level)

							if math.random(100) < (10 + HighLife.Skills:GetSkillLevel('Medical').useful_level) then
								Notification_AboveMap("~g~You manage to use the kit effectively")

								HighLife.Skills:AddSkillPoints('Medical', 1)

								TriggerServerEvent('HighLife:EMS:Revive', GetPlayerServerId(player))
							else
								Notification_AboveMap("~o~You use the kit, not very well...")
							end
						end)
					else
						Notification_AboveMap("~o~You don't have any items to help the patient with")
					end
				end, 'medical_kit', 1)
			end
		else
			Notification_AboveMap('~r~Nobody nearby to revive')
		end
	end)
end)

RegisterNetEvent('HighLife:Items:Meth')
AddEventHandler('HighLife:Items:Meth', function()
	CreateThread(function()
		if not HighLife.Player.InVehicle then
			TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_SMOKING_POT", 0, false)

			Wait(15000)

			ClearPedTasks(HighLife.Player.Ped)

			HighLife.Player.Vitals.meth.level = HighLife.Player.Vitals.meth.level + Config.DrugAttributes.meth.HitValue
		end
	end)
end)

RegisterNetEvent('HighLife:Items:Cocaine')
AddEventHandler('HighLife:Items:Cocaine', function()
	CreateThread(function()
		if not HighLife.Player.InVehicle then
			TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_SMOKING_POT", 0, false)

			Wait(15000)

			ClearPedTasks(HighLife.Player.Ped)

			HighLife.Player.Vitals.cocaine.level = HighLife.Player.Vitals.cocaine.level + Config.DrugAttributes.cocaine.HitValue
		end
	end)
end)

RegisterNetEvent('HighLife:Items:Heroin')
AddEventHandler('HighLife:Items:Heroin', function()
	CreateThread(function()
		if not HighLife.Player.InVehicle then
			TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_SMOKING_POT", 0, false)

			Wait(15000)

			ClearPedTasks(HighLife.Player.Ped)

			HighLife.Player.Vitals.heroin.level = HighLife.Player.Vitals.heroin.level + Config.DrugAttributes.heroin.HitValue
		end
	end)
end)

local playing_cards = {'Ace of Clubs','Ace of Diamonds','Ace of Hearts','Ace of Spades','2 of Clubs','2 of Diamonds','2 of Hearts','2 of Spades','3 of Clubs','3 of Diamonds','3 of Hearts','3 of Spades','4 of Clubs','4 of Diamonds','4 of Hearts','4 of Spades','5 of Clubs','5 of Diamonds','5 of Hearts','5 of Spades','6 of Clubs','6 of Diamonds','6 of Hearts','6 of Spades','7 of Clubs','7 of Diamonds','7 of Hearts','7 of Spades','8 of Clubs','8 of Diamonds','8 of Hearts','8 of Spades','9 of Clubs','9 of Diamonds','9 of Hearts','9 of Spades','10 of Clubs','10 of Diamonds','10 of Hearts','10 of Spades','Jack of Clubs','Jack of Diamonds','Jack of Hearts','Jack of Spades','Queen of Clubs','Queen of Diamonds','Queen of Hearts','Queen of Spades','King of Clubs','King of Diamonds','King of Hearts','King of Spades'}
local eightBallStrings = {"It is certain.","It is decidedly so.","Without a doubt.","Yes – definitely.","You may rely on it.","As I see it, yes.","Most likely.","Outlook good.","Yes.","Signs point to yes.","Reply hazy, try again.","Ask again later.","Better not tell you now.","Cannot predict now.","Concentrate and ask again.","Don't count on it.","My reply is no.","My sources say no.","Outlook not so good.","Very doubtful.",}

local isBalling = false
local isDrawingCard = false
local isFlippingCoin = false
local isRollingDice = false

RegisterNetEvent('HighLife:Items:ShowCard')
AddEventHandler('HighLife:Items:ShowCard', function(card_name)
	SetNuiFocus(true, true)

	SendNUIMessage({
		nui_reference = 'cards',
		data = {
			showCard = card_name,
		}
	})
end)

RegisterNetEvent('HighLife:Items:Cards')
AddEventHandler('HighLife:Items:Cards', function()
	if not isDrawingCard then
		isDrawingCard = true
		
		CreateThread(function()
			TriggerServerEvent('HighLife:Player:MeAction', '~y~shuffles the deck of cards')
			
			Wait(6000)
			
			TriggerServerEvent('HighLife:Player:MeAction', '~o~draws the ' .. playing_cards[math.random(#playing_cards)])

			Wait(6000)
			
			isDrawingCard = false
		end)
	end
end)

RegisterNetEvent('HighLife:Items:Eightball')
AddEventHandler('HighLife:Items:Eightball', function()
	if not isBalling then
		isBalling = true
		
		CreateThread(function()
			TriggerServerEvent('HighLife:Player:MeAction', '~y~shakes the mysterious magic 8 ball')
			
			Wait(6000)
			
			TriggerServerEvent('HighLife:Player:MeAction', '~b~"' .. eightBallStrings[math.random(#eightBallStrings)] .. '" ~s~speaks the magic 8 ball')

			Wait(6000)
			
			isBalling = false
		end)
	end
end)

RegisterNetEvent('HighLife:Items:RepairKit')
AddEventHandler('HighLife:Items:RepairKit', function()
	if not isRepairing then
		local vehicle = GetClosestVehicleEnumerated(3.0)
		
		if vehicle ~= nil then
			local shouldFix = true
			local vehicle_health = GetVehicleEngineHealth(vehicle)

			if shouldFix then
				if vehicle_health <= 0 then
					Notification_AboveMap("~r~It's too far gone at this point, mate")

					shouldFix = false
				elseif vehicle_health > 295 then
					Notification_AboveMap("~y~The vehicle is still in a working condition")
					
					shouldFix = false
				end
			end

			if DecorExistOn(vehicle, 'Vehicle.HasRepaired') then
				shouldFix = false

				Notification_AboveMap('~o~The vehicle has already been repaired')
			end

			if shouldFix then
				if GetVehicleDoorAngleRatio(vehicle, 4) < 0.1 then 
					SetVehicleDoorOpen(vehicle, 4, false, false)
				end
			
				RequestAnimDict('mini@repair')
			
				while not HasAnimDictLoaded('mini@repair') do
					Wait(0)
				end

				isRepairing = true

				Notification_AboveMap('~y~Repairing vehicle')

				CreateThread(function()
					local current_time = 0
					local success = false

					local lastTime = GameTimerPool.GlobalGameTime

					TaskPlayAnim(HighLife.Player.Ped, "mini@repair", "fixing_a_ped", 3.5, -8, -1, 1, 0, 0, 0, 0)

					HighLife.Player.BlockWeaponSwitch = true
					HighLife.Player.VisibleItemBlocker = true

					CreateThread(function()
						while isRepairing do
							DrawBottomText('Press ~y~E~w~ to stop ~r~repairing', 0.5, 0.95, 0.4)

							if IsControlJustReleased(0, 38) then
								isRepairing = false
							end

							Wait(1)
						end
					end)

					while isRepairing do
						if GameTimerPool.GlobalGameTime >= (lastTime + 25000) then
							success = true
							break
						end

						if not IsEntityPlayingAnim(HighLife.Player.Ped, 'mini@repair', 'fixing_a_ped', 3) then
							TaskPlayAnim(HighLife.Player.Ped, "mini@repair", "fixing_a_ped", 3.5, -8, -1, 1, 0, 0, 0, 0)
						end

						Wait(500)
					end

					Wait(100)

					HighLife.Player.BlockWeaponSwitch = false
					HighLife.Player.VisibleItemBlocker = false

					ClearPedTasks(HighLife.Player.Ped)

					if success then
						isRepairing = false
						
						TriggerServerEvent('HighLife:Inventory:RemoveItem', 'repairkit', 1)

						SetVehicleUndriveable(vehicle, false)

						SetVehicleEngineHealth(vehicle, 230.0)

						DecorSetBool(vehicle, 'Vehicle.HasRepaired', true)
						
						Notification_AboveMap('~g~You successfully made repairs to the engine')

						SetVehicleDoorShut(vehicle, 4, false)
					end
				end)
			end
		else
			Notification_AboveMap('~r~No vehicle nearby to repair')
		end
	end
end)

RegisterNetEvent('HighLife:Items:Health')
AddEventHandler('HighLife:Items:Health', function(item_type)
	if item_type == 'cyanide' then
		TriggerServerEvent('HighLife:Inventory:RemoveItem', 'cyanide', 1)

		StartAnimation('mp_suicide', 'pill', false)

		Wait(4000)

		SetEntityHealth(HighLife.Player.Ped, 0)

		HighLife.Player.IsHealing = false
	elseif item_type == 'lsd' then
		TriggerServerEvent('HighLife:Inventory:RemoveItem', 'lsd', 1)

		StartAnimation('mp_suicide', 'pill', false, 2800)

		Wait(4000)

		AnimpostfxPlay('DMT_flight_intro', 300000, false)

		TriggerEvent('dpEmotes:SetDefaultWalkStyle', 'anim@move_m@grooving@')

		HighLife.Player.IsHealing = false
	else
		if not HighLife.Player.IsHealing then
			HighLife.Player.IsHealing = true

			local cancelled = false
			local current_health = GetEntityHealth(HighLife.Player.Ped)

			if item_type == 'bandage' then
				if HighLife.Player.Bleeding then
					if not HighLife.Player.InVehicle then
						TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
					end

					Notification_AboveMap("~y~You start to wrap the bandages around your wounds")

					Wait(3000)

					if IsPedActiveInScenario(HighLife.Player.Ped) or HighLife.Player.InVehicle then
						TriggerServerEvent('HighLife:Inventory:RemoveItem', 'bandage', 1)

						HighLife.Player.Bleeding = false

						Notification_AboveMap("~g~You wrap the bandage around your wounds, stopping the ~r~bleeding")
					end

					ClearPedTasks(HighLife.Player.Ped)

					HighLife.Player.IsHealing = false
				else
					if current_health > 150 then
						HighLife.Player.IsHealing = false

						Notification_AboveMap("You don't have serious enough injuries to use bandages")
					else
						-- TODO: Animation/Cancelling animation + bandaging sound
						CreateThread(function()
							TriggerServerEvent('HighLife:Inventory:RemoveItem', 'bandage', 1)

							Notification_AboveMap("~y~You start to wrap the bandages around your wounds")

							if not HighLife.Player.InVehicle then
								TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							end

							Wait(3000)

							ClearPedTasks(HighLife.Player.Ped)

							if IsPedActiveInScenario(HighLife.Player.Ped) or HighLife.Player.InVehicle then
								Notification_AboveMap("~y~You wrap the bandage around your wounds")

								while GetEntityHealth(HighLife.Player.Ped) < 150 do
									Wait(9000)-- 6 * (49 / 5) 58 seconds to full bandage up

									if HighLife.Player.Dead then
										cancelled = true
										break
									end

									SetEntityHealth(HighLife.Player.Ped, GetEntityHealth(HighLife.Player.Ped) + 5)
								end

								if not cancelled then
									ClearPedBloodDamage(HighLife.Player.Ped)
									
									Notification_AboveMap("~g~You have bandaged your wounds")
								end
							end
							
							HighLife.Player.IsHealing = false
						end)
					end
				end
			end

			if item_type == 'painkillers' then
				if current_health >= 150 and current_health < 200 then
					CreateThread(function()
						TriggerServerEvent('HighLife:Inventory:RemoveItem', 'painkillers', 1)

						if IsAprilFools() then
							if math.random(10) == 1 then
								ExecuteCommand('twt I love swallowing things')
							end

							HighLife.SpatialSound.CreateSound('Pills')
						end

						Notification_AboveMap("~y~You take a dose of painkillers")

						if not HighLife.Player.InVehicle then
							StartAnimation('mp_suicide', 'pill', false, 2800)
						end

						while GetEntityHealth(HighLife.Player.Ped) ~= 200 do
							Wait(8000) -- 8 * (49 / 2) 120 seconds to fully painkiller up

							if HighLife.Player.Dead then
								cancelled = true
								break
							end

							-- Prevent them getting banned for scripted health
							if (GetEntityHealth(HighLife.Player.Ped) + 2) > 200 then
								SetEntityHealth(HighLife.Player.Ped, 200)
							else
								SetEntityHealth(HighLife.Player.Ped, GetEntityHealth(HighLife.Player.Ped) + 2)
							end
						end

						HighLife.Player.IsHealing = false

						if not cancelled then
							Notification_AboveMap("~g~The painkillers wear off and your condition improves")
						end
					end)
				else
					HighLife.Player.IsHealing = false

					if current_health < 200 then
						Notification_AboveMap("~o~You have more serious wounds that require bandages")
					else
						Notification_AboveMap("~g~You don't require any medical attention")
					end
				end
			end
		else
			if HighLife.Player.Bleeding then
				if item_type == 'bandage' then
					HighLife.Player.IsHealing = true

					if not HighLife.Player.InVehicle then
						TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
					end
					
					Wait(3000)

					if IsPedActiveInScenario(HighLife.Player.Ped) or not HighLife.Player.InVehicle then
						HighLife.Player.Bleeding = false

						TriggerServerEvent('HighLife:Inventory:RemoveItem', 'bandage', 1)
						
						Notification_AboveMap("~y~You wrap the bandage around your wounds, stopping the ~r~bleeding")
					end

					HighLife.Player.IsHealing = false

					ClearPedTasks(HighLife.Player.Ped)
				else
					Notification_AboveMap("~o~That isn't going to help your bleeding")
				end
			else
				Notification_AboveMap('~y~You are already healing yourself')
			end
		end
	end
end)

RegisterNetEvent('HighLife:Items:Ammo')
AddEventHandler('HighLife:Items:Ammo', function(ammo_type)
	local ammoCount = Config.Ammo[ammo_type]

	if ammo_type == 'smg' then
		AddAmmoToPed(HighLife.Player.Ped, GetHashKey('WEAPON_MICROSMG'), ammoCount)
	elseif ammo_type == 'rifle' then
		AddAmmoToPed(HighLife.Player.Ped, GetHashKey('WEAPON_ASSAULTRIFLE'), ammoCount)
	elseif ammo_type == 'pistol' then
		AddAmmoToPed(HighLife.Player.Ped, GetHashKey('WEAPON_PISTOL'), ammoCount)
	elseif ammo_type == 'shotgun' then
		AddAmmoToPed(HighLife.Player.Ped, GetHashKey('WEAPON_PUMPSHOTGUN'), ammoCount)
	elseif ammo_type == 'hunting' then
		AddAmmoToPed(HighLife.Player.Ped, GetHashKey('WEAPON_HUNTINGRIFLE'), ammoCount)
	end
end)

RegisterNetEvent('HighLife:Items:Lighter')
AddEventHandler('HighLife:Items:Lighter', function()
	if not isSettingShitOnFire then
		isSettingShitOnFire = true

		CreateThread(function()
			TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

			Wait(1000)

			local thisFireID = StartScriptFire(GetOffsetFromEntityInWorldCoords(PlayerPedId(), vector3(0.0, 1.5, -.7)), -1, true)

			Wait(1000)

			ClearPedTasks(HighLife.Player.Ped)
			
			Wait(1000)

			RemoveScriptFire(thisFireID)

			isSettingShitOnFire = false
		end)
	end
end)

RegisterNetEvent('HighLife:Items:Coin')
AddEventHandler('HighLife:Items:Coin', function()
	if not isFlippingCoin then
		isFlippingCoin = true

		local coinText = '~o~the coin lands on heads'

		local chance = math.random(1000000)

		if chance == 500000 then
			coinText = '~g~the coin lands on its side'
		elseif chance > 500000 then
			coinText = '~o~the coin lands on tails'
		end
		
		CreateThread(function()
			TriggerServerEvent('HighLife:Player:MeAction', '~y~flips a coin')

			Wait(6000)

			TriggerServerEvent('HighLife:Player:MeAction', coinText)

			Wait(6000)
			
			isFlippingCoin = false
		end)
	end
end)

RegisterNetEvent('HighLife:Items:Dice')
AddEventHandler('HighLife:Items:Dice', function()
	if not isRollingDice then
		isRollingDice = true

		local rollText = '~o~the dice rolls on ' .. math.random(6)
		
		CreateThread(function()
			TriggerServerEvent('HighLife:Player:MeAction', '~y~rolls the dice')

			Wait(6000)

			TriggerServerEvent('HighLife:Player:MeAction', rollText)

			Wait(6000)
			
			isRollingDice = false
		end)
	end
end)

RegisterNetEvent('HighLife:Items:Bong')
AddEventHandler('HighLife:Items:Bong', function()
	CreateThread(function()
		local boneIndex = GetPedBoneIndex(HighLife.Player.Ped, 18905)
		local boneIndex2 = GetPedBoneIndex(HighLife.Player.Ped, 57005)

		RequestAnimDict('anim@safehouse@bong')
			
		while not HasAnimDictLoaded('anim@safehouse@bong') do
			Wait(0)
		end
		
		ESX.Game.SpawnObject('hei_heist_sh_bong_01', {
			x = HighLife.Player.Pos.x,
			y = HighLife.Player.Pos.y,
			z = HighLife.Player.Pos.z - 3
		},
		function(object)
			ESX.Game.SpawnObject('p_cs_lighter_01', {
				x = HighLife.Player.Pos.x,
				y = HighLife.Player.Pos.y,
				z = HighLife.Player.Pos.z - 3
			},
			function(object2)
				CreateThread(function()
					TaskPlayAnim(HighLife.Player.Ped, "anim@safehouse@bong", "bong_stage1", 3.5, -8, -1, 49, 0, 0, 0, 0)

					RemoveAnimDict('anim@safehouse@bong')

					Wait(1500)
					
					AttachEntityToEntity(object2, HighLife.Player.Ped, boneIndex2, 0.10, 0.0, 0, 99.0, 192.0, 180.0, true, true, false, true, 1, true)
					AttachEntityToEntity(object, HighLife.Player.Ped, boneIndex, 0.10, -0.25, 0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
					
					Wait(6000)
					
					DeleteObject(object)
					DeleteObject(object2)

					HighLife.Player.Vitals.weed.level = HighLife.Player.Vitals.weed.level + (Config.DrugAttributes.weed.HitValue * 2)

					ClearPedTasks(HighLife.Player.Ped)
				end)
			end)
		end)
	end)
end)

RegisterNetEvent('HighLife:Items:umbrella')
AddEventHandler('HighLife:Items:umbrella', function()	
	CreateThread(function()
		local boneIndex = GetPedBoneIndex(HighLife.Player.Ped, 57005)
			
		RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
		
		while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
			Citizen.Wait(0)
		end
		
		ESX.Game.SpawnObject('p_amb_brolly_01', {
			x = HighLife.Player.Pos.x,
			y = HighLife.Player.Pos.y,
			z = HighLife.Player.Pos.z + 2
		},
		function(object)
			CreateThread(function()
				AttachEntityToEntity(object, HighLife.Player.Ped, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
				TaskPlayAnim(HighLife.Player.Ped, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)

				RemoveAnimDict('amb@code_human_wander_drinking@beer@male@base')
				
				Wait(30000)
				
				DeleteObject(object)
				ClearPedSecondaryTask(HighLife.Player.Ped)
			end)
		end)
	end)
end)

RegisterNetEvent('HighLife:Items:rose')
AddEventHandler('HighLife:Items:rose', function()
	CreateThread(function()
		local boneIndex = GetPedBoneIndex(HighLife.Player.Ped, 57005)
			
		RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
		
		while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
			Wait(0)
		end
		
		ESX.Game.SpawnObject('p_single_rose_s', {
			x = HighLife.Player.Pos.x,
			y = HighLife.Player.Pos.y,
			z = HighLife.Player.Pos.z + 2
		},
		function(object)
			CreateThread(function()
				AttachEntityToEntity(object, HighLife.Player.Ped, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
				TaskPlayAnim(HighLife.Player.Ped, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)

				RemoveAnimDict('amb@code_human_wander_drinking@beer@male@base')
				
				Wait(30000)
				
				DeleteObject(object)
				ClearPedSecondaryTask(HighLife.Player.Ped)
			end)
		end)
	end)
end)

RegisterNetEvent('HighLife:Items:vest')
AddEventHandler('HighLife:Items:vest', function(isPolice)
	if isPolice then
		SetPedArmour(HighLife.Player.Ped, 75) -- police vest
		
		if IsAnyJobs({'police'}) then
			if isMale() then
				SetPedComponentVariation(HighLife.Player.Ped, 9, 13, 0, 2)
			else
				SetPedComponentVariation(HighLife.Player.Ped, 9, 8, 0, 2)
			end
		end
	else
		SetPedArmour(HighLife.Player.Ped, 50) -- standard vest
	end
end)

RegisterNetEvent('HighLife:Items:drunk')
AddEventHandler('HighLife:Items:drunk', function(level)
	CreateThread(function()
		TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_DRINKING", 0, 1)

		Wait(15000)

		ClearPedTasks(HighLife.Player.Ped)

		HighLife.Player.Drunk = HighLife.Player.Drunk + level
	end)
end)

function Lockpick(indestructable)
	if not isLockpicking then
		isLockpicking = true

		CreateThread(function()
			local maxAttempts = 0
			local alarmActive = false
			local currentAttempts = 0

			local lastTime = GameTimerPool.GlobalGameTime
			local lastSoundTime = GameTimerPool.GlobalGameTime

			local nearVehicle = GetClosestVehicleEnumerated(3.0)

			if nearVehicle ~= nil and DoesEntityExist(nearVehicle) then
				local lockpickBroke = false
				local lockpickSuccess = false
				local scenarioCheck = 0

				CreateThread(function()
					while isLockpicking do
						Bar.DrawProgressBar('Lockpicking', (currentAttempts / maxAttempts) or 0, 0, { r = 224, g = 50, b = 50 })

						DrawBottomText('Press ~y~E~w~ to stop ~r~lockpicking', 0.5, 0.95, 0.4)

						if IsControlJustReleased(0, 38) then
							isLockpicking = false
						end

						Wait(1)
					end
				end)

				maxAttempts = math.random(10, 20)

				TaskStartScenarioInPlace(HighLife.Player.Ped, "PROP_HUMAN_BUM_BIN", 0, true)

				Wait(3000)

				while isLockpicking do
					if not IsPedActiveInScenario(HighLife.Player.Ped) then
						Wait(2000)
						
						if not IsPedActiveInScenario(HighLife.Player.Ped) then
							break
						end
					end

					if currentAttempts == maxAttempts then
						local chance = math.random(10)

						if chance == 1 then
							lockpickBroke = true
						end

						if chance >= 7 then
							lockpickSuccess = true
						end

						break
					end

					if GameTimerPool.GlobalGameTime >= (lastSoundTime + 7000) then
						-- FIXME: bad
						HighLife.SpatialSound.CreateSound('Lockpick')

						lastSoundTime = GameTimerPool.GlobalGameTime
					end

					if GameTimerPool.GlobalGameTime >= (lastTime + 1000) then	
						currentAttempts = currentAttempts + 1

						if not alarmActive then
							local alarmChance = math.random(1, 10)

							if alarmChance >= 8 then
								alarmActive = true

								SetVehicleAlarm(nearVehicle, true)
								StartVehicleAlarm(nearVehicle)

								HighLife:DispatchEvent('vehicle_theft')
							end
						end

						lastTime = GameTimerPool.GlobalGameTime
					end

					Wait(1)
				end

				if lockpickSuccess then
					NetworkRequestControlOfEntity(nearVehicle)

					while not NetworkHasControlOfEntity(nearVehicle) do
						NetworkRequestControlOfEntity(nearVehicle)
						
						Wait(100)
					end
					
					SetVehicleNeedsToBeHotwired(nearVehicle, true)

					LockVehicle(nearVehicle, false)

					Notification_AboveMap('You pick the lock ~g~successfully')
				else
					Notification_AboveMap('You ~r~fail ~s~to pick the lock')
				end

				if not indestructable and lockpickBroke then
					TriggerServerEvent('HighLife:Items:RemoveLockpick')

					Notification_AboveMap('Your lockpick has ~r~broken')
				end

				isLockpicking = false

				ClearPedTasks(HighLife.Player.Ped)
			else
				isLockpicking = false
				
				Notification_AboveMap('Nothing nearby to lockpick')
			end
		end)
	else
		Notification_AboveMap('You are already lockpicking something')
	end
end

local drunkLevels = {
	light = {
		level = 2.5,
		Shake = 0.3,
		TCModifier = 0.3,
		Walk = 'move_m@drunk@slightlydrunk'
	},
	heavy = {
		level = 6.0,
		Shake = 0.8,
		TCModifier = 0.8,
		Walk = 'move_m@drunk@verydrunk'
	}
}

function GetDrunkLevel(currentLevel)
	local best = nil

	for k,v in pairs(drunkLevels) do
		if currentLevel > v.level then
			if best ~= nil then
				if v.level > best.level then
					best = v
				end
			else
				best = v
			end
		end 
	end

	return best
end

CreateThread(function()
	local thisDrunkLevel = nil

	while true do
		thisDrunkLevel = GetDrunkLevel(HighLife.Player.Drunk)

		if thisDrunkLevel ~= nil then
			if not isDrunk then
				isDrunk = true

				DoScreenFadeOutWait(3000)

				SetTimecycleModifier("Drunk")

				SetTimecycleModifierStrength(thisDrunkLevel.TCModifier)

				TriggerEvent('HAnimations:SetDrunk', true, thisDrunkLevel.Walk)

				ShakeGameplayCam('DRUNK_SHAKE', thisDrunkLevel.Shake)

				Wait(2000)

				DoScreenFadeIn(1200)
			end
		elseif isDrunk then
			isDrunk = false

			DoScreenFadeOutWait(2000)

			ClearTimecycleModifier()

			ShakeGameplayCam('DRUNK_SHAKE', 0.0)

			TriggerEvent('HAnimations:SetDrunk', false)

			Wait(1000)

			DoScreenFadeIn(1500)
		end

		if HighLife.Player.Drunk > 0.0 then
			if HighLife.Player.Drunk > 10.0 then
				SetEntityHealth(HighLife.Player.Ped, HighLife.Player.Health - math.floor(HighLife.Player.Drunk * 0.6))
			end

			HighLife.Player.Drunk = HighLife.Player.Drunk - 0.1

			if HighLife.Player.Drunk < 0.0 then HighLife.Player.Drunk = 0.0 end
		end

		Wait(15000)
	end
end)