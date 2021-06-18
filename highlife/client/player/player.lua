local isFirstLoad = true
local SettingPlayerData = false

local sensitiveLocations = {
	vector3(1138.05, -3198.86, -39.67)
}

RegisterNetEvent('HighLife:Player:UpdateKeys')
AddEventHandler('HighLife:Player:UpdateKeys', function(data)
	if data ~= nil then
		local keyData = json.decode(data)

		if keyData ~= nil then
			local updateMessage = '~y~A key has been removed from your keychain'

			if HighLife.Player.VehicleKeys == nil or #HighLife.Player.VehicleKeys < #keyData then
				updateMessage = '~y~A key has been added to your keychain'
			end

			Notification_AboveMap(updateMessage)

			HighLife.Player.VehicleKeys = keyData
		end
	end
end)

RegisterNetEvent('HighLife:Player:Smite')
AddEventHandler('HighLife:Player:Smite', function()
	ApplyDamageToPed(HighLife.Player.Ped, 500, false)
end)

RegisterNetEvent('HighLife:Player:SetData')
AddEventHandler('HighLife:Player:SetData', function(data)
	if not SettingPlayerData then
		SettingPlayerData = true

		CreateThread(function()
			data = json.decode(data)

			if isFirstLoad then
				SendLoadingScreenMessage(json.encode({identifier = data.identifier}))

				Wait(2000)
			end

			SetPlayerInvincible(HighLife.Player.Id, true)

			HighLife.Player.SentIdentifier = true

			HighLife:ServerCallback('HighLife:Inventory:Get', function(inventoryData)
				HighLife.Player.Inventory = json.decode(inventoryData)
			end)

			if data.phoneSettings ~= nil then
				-- FIXME: Gen the phone number
				-- HighLife.Phone:UpdateSettings(data.phoneSettings)
			end

			if data.character_data ~= nil then
				HighLife.Player.CharacterData = json.decode(data.character_data)
			end

			if data.upgrades ~= nil then
				HighLife.Player.Upgrades = json.decode(data.upgrades)
			end

			HighLife.Player.Skills = {}
			HighLife.Player.Tattoos = {}
			HighLife.Player.Licenses = {}
			
			HighLife.Player.OutfitData = (data.outfit_data ~= nil and json.decode(data.outfit_data) or {})

			HighLife.Player.ChopshopData = (data.chopshop_data ~= nil and json.decode(data.chopshop_data) or nil)

			if data.clothing_data ~= nil then
				HighLife.Player.OwnedClothing = {}
				
				local thisClothingData = json.decode(data.clothing_data)

				for clothingType,clothingData in pairs(thisClothingData) do
					if HighLife.Player.OwnedClothing[clothingType] == nil then
						HighLife.Player.OwnedClothing[clothingType] = {}
					end

					for clothingIndex,clothingVariationIndexList in pairs(clothingData) do
						if HighLife.Player.OwnedClothing[clothingType][tostring(clothingIndex)] == nil then
							HighLife.Player.OwnedClothing[clothingType][tostring(clothingIndex)] = {}
						end

						for i=1, #clothingVariationIndexList do
							table.insert(HighLife.Player.OwnedClothing[clothingType][tostring(clothingIndex)], clothingVariationIndexList[i])
						end
					end
				end
			else
				HighLife.Player.OwnedClothing = nil
			end

			if data.character_reference ~= nil then
				HighLife.Player.CurrentCharacterReference = data.character_reference

				for i=1, #HighLife.Player.CharacterData do
					if HighLife.Player.CharacterData[i].reference == HighLife.Player.CurrentCharacterReference then
						HighLife.Player.CurrentCharacter = HighLife.Player.CharacterData[i]

						break
					end
				end
			else
				HighLife:CharacterLimbo()
			end

			-- we'll do this first as we like to do job stuff first
			if data.job_data ~= nil then
				HighLife.Player.Job.name = data.job_data.name
				HighLife.Player.Job.rank = data.job_data.grade
				HighLife.Player.Job.rank_name = data.job_data.grade_name
			end

			for k,v in pairs(Config.Jobs) do
				if not v.Whitelisted then
					HighLife.Other.JobStatData.current[k] = {
						rank = 1,
						actions_left_to_rank = v.Ranks[1].PromotionAmount or 0
					}
				end
			end

			if data.character_reference ~= nil then
				HighLife.Skin:Set(data.skin)

				if data.skin == nil then
					HighLife.Player.IsInvalidCharacter = true
				end
			end

			CreateThread(function()
				while HighLife.Player.CD do
					Wait(100)
				end

				if isFirstLoad then
					if Config.CurrentAnnouncement ~= nil then
						TriggerEvent('HighLife:Announce:Message', Config.CurrentAnnouncement)
					end
				end

				-- For setting health on females
				Wait(1000)

				SetPedArmour(HighLife.Player.Ped, data.armour)

				SetEntityHealth(HighLife.Player.Ped, data.health)

				-- WEAPON/ITEM Related

				Wait(3000)

				SetPlayerInvincible(HighLife.Player.Id, false)

				-- Wait to enable death logging so logs don't duplicate
				HighLife.Player.DeathLogging = true

				-- Remove any job weapons when loaded
				if IsAnyJobs({'police', 'fib'}) then
					Debug('Removing job weapons')

					RemoveAllPedWeapons(HighLife.Player.Ped, true)
					
					TriggerServerEvent('HighLife:Player:RemoveAllOfItem', {'ram', 'pvest', 'tracker', 'gasmask', 'stingers', 'handcuffs', 'plastic_handcuffs', 'gsrkit'})

					SetPedArmour(HighLife.Player.Ped, 0)
				end

				-- Make sure they're unemployed
				if HighLife.Player.Job.name ~= 'unemployed' then
					TriggerServerEvent('HighLife:Job:Set', 'unemployed', 0)
				end

				HighLife.Player.JobReset = true

				Wait(1000)

				-- Remove a tracker if they have one, should be unemployed by now
				TriggerServerEvent('HighLife:Player:RemoveAllOfItem', 'tracker')
			end)

			if data.vitals then
				-- check if exist and apply
				local dbVitals = json.decode(data.vitals)

				for k,v in pairs(dbVitals) do
					HighLife.Player.Vitals[k] = v

					Debug('setting vitals for ' .. k)
				end

				if dbVitals.death_hash ~= nil then
					CreateThread(function()
						while HighLife.Player.LastDeathData == nil do
							Wait(100)
						end
						
						Debug('set death hash as ', dbVitals.death_hash)

						HighLife.Player.LastDeathData.cause_hash = dbVitals.death_hash
					end)
				end
			end

			if data.bleeding ~= nil and data.bleeding == 1 then
				CreateThread(function()
					while HighLife.Player.CD do
						Wait(1000)
					end

					HighLife.Player.Bleeding = true
				end)
			end

			HighLife.Player.VitalsReady = true

			if data.special then
				HighLife.Player.Special = true

				StatSetInt('MP0_STAMINA', 100, true)
				StatSetInt('MP0_STRENGTH', 100, true)
				StatSetInt('MP0_LUNG_CAPACITY', 100, true)
				StatSetInt('MP0_WHEELIE_ABILITY', 100, true)
				StatSetInt('MP0_FLYING_ABILITY', 100, true)
				StatSetInt('MP0_SHOOTING_ABILITY', 100, true)
				StatSetInt('MP0_STEALTH_ABILITY', 100, true)

				print("Who's a special boy?")
			else
				local year, month, day, hour, minute, second = GetUtcTime()

				print("You wish you were special")

				if month == 08 and ((day == 25 and hour == 23) or day == 26) then
					print("Maybe you are, but only today, its my birthday - /cake if you want a slice c:")
				end
			end

			if data.licenses ~= nil then
				for k,v in pairs(json.decode(data.licenses)) do
					if v then
						HighLife.Player.Licenses[k] = true
					end
				end
			end

			if data.skills ~= nil then
				HighLife.Player.Skills = json.decode(data.skills)
			end

			if data.treasure ~= nil then
				TriggerEvent('HighLife:Treasure:CreateItem', data.treasure)
			end

			if data.discord ~= nil then
				HighLife.Player.Discord = data.discord
			end

			if data.misc_sync ~= nil then
				TriggerEvent('HighLife:Net:MiscSync', json.encode(data.misc_sync))
			end

			if data.position ~= nil and data.position then
				HighLife.Player.LoginPosition = vector3(data.position.x, data.position.y, data.position.z)

				if data.position.h ~= nil then
					HighLife.Player.Heading = data.position.h
				end

				for i=1, #sensitiveLocations do
					if Vdist(HighLife.Player.LoginPosition, sensitiveLocations[i]) < 20.0 then
						HighLife:TempDisable()

						HighLife.Player.LoginPosition = Config.SpawnPoints[math.random(#Config.SpawnPoints)]

						break
					end
				end

				Debug('Spawning with last loc: x:' .. data.position.x .. ' y:' .. data.position.y .. ' z:' .. data.position.z)

				TriggerEvent('playerSpawned')
			else
				HighLife.Player.LoginPosition = nil
				
				Debug('Spawning with default method')
				
				TriggerEvent('playerSpawned', true)
			end

			if data.player_container_data ~= nil then
				HighLife.Container:SetContainerData('player:' .. data.identifier, data.player_container_data)
			end

			if data.deposit_boxes ~= nil then
				for k,v in pairs(json.decode(data.deposit_boxes)) do
					if v then
						HighLife.Player.OwnedDepositBoxes[k] = true
					end
				end
			end

			if data.whitelist_data ~= nil then
				local whitelist_data = json.decode(data.whitelist_data)

				for k,v in pairs(whitelist_data) do
					HighLife.Other.JobStatData.current[k] = v
				end
			end

			if data.public_job_data ~= nil then
				local public_job_data = json.decode(data.public_job_data)

				for k,v in pairs(public_job_data) do
					HighLife.Other.JobStatData.current[k] = v
				end
			end

			if data.ban_data ~= nil then
				HighLife.Player.BanData = json.decode(data.ban_data)
			end

			if data.warning_data ~= nil then
				HighLife.Player.WarningData = json.decode(data.warning_data)
			end

			if data.robbery_data ~= nil then
				HighLife.Other.RobberyData = data.robbery_data
			end

			if data.cData ~= nil then
				for k,v in pairs(data.cData) do
					TriggerEvent('HighLife:NotDrugsButDurgz:CGroup', k, v[1], v[2])
				end
			end

			if data.special_events ~= nil then
				HighLife.Other.SpecialEvents = json.decode(data.special_events)
			end

			if data.bank_account_id ~= nil then
				HighLife.Player.BankID = data.bank_account_id
			end

			if data.playtime ~= nil then
				HighLife.Player.PlaytimeHours = (data.playtime / 60) / 60
			end

			if data.identifier ~= nil then
				HighLife.Player.Identifier = data.identifier
			end

			if data.current_time ~= nil then
				HighLife.SpatialSound.EpochTime = data.current_time
			end

			if data.persistant_sounds ~= nil then
				for i=1, #data.persistant_sounds do
					HighLife.SpatialSound:StartSound(json.encode(data.persistant_sounds[i]))
				end
			end

			HighLife.SpatialSound.Init = true

			if not HighLife.Player.Special then
				if data.playtime ~= nil then
					local maxLungInt = 100
					local maxStaminaInt = 50
					local maxWheelieInt = 100

					local maxPlaytime = 3600000 -- 1000 hours (41 days)

					local thisPlayTime = data.playtime

					if thisPlayTime > maxPlaytime then
						thisPlayTime = maxPlaytime
					end

					local finalLungInt =  math.floor(tonumber(((maxLungInt / 100) * (thisPlayTime * (100 / maxPlaytime)))))
					local finalStaminaInt = math.floor(tonumber(((maxStaminaInt / 100) * (thisPlayTime * (100 / maxPlaytime)))))
					local finalWheelieInt =  math.floor(tonumber(((maxWheelieInt / 100) * (thisPlayTime * (100 / maxPlaytime)))))

					if finalLungInt < 20 then
						finalLungInt = 20
					end

					StatSetInt('MP0_STAMINA', finalStaminaInt or 0, true)
					StatSetInt('MP0_LUNG_CAPACITY', finalLungInt or 20, true)
					StatSetInt('MP0_WHEELIE_ABILITY', 0, true)
				else
					StatSetInt('MP0_STAMINA', 0, true)
					StatSetInt('MP0_LUNG_CAPACITY', 20, true)
					StatSetInt('MP0_WHEELIE_ABILITY', 0, true)
				end
			end

			-- if data.current_skin ~= nil then

			-- end

			-- if data.skin_primary ~= nil then
			-- end

			if data.can_loot then
				TriggerEvent('HighLife:Loot:EnableLooting', data.can_loot)
			end

			TriggerEvent('dpEmotes:SetDefaultWalkStyle', data.walk_style)

			if data.whalk_style ~= nil and data.whalk_style then
				whalk_away()
			end

			if data.ped_model ~= nil then
				SetHighLifePlayerModel(GetHashKey(data.ped_model))
			end

			if data.drug_location_data ~= nil then
				CreateThread(function()
					Wait(5000)
					
					TriggerEvent('HighLife:Drugs:locationSync', data.drug_location_data)
				end)
			end

			if data.cat_lover then
				HighLife.Player.CatLover = true
				
				-- CreateThread(function()
				-- 	while HighLife.Player.CD do
				-- 		Wait(100)
				-- 	end

				-- 	local cat_model = GetHashKey('a_c_cat_01')

				-- 	RequestModel(cat_model)

				-- 	while not HasModelLoaded(cat_model) do
				-- 		Wait(50)
				-- 	end

				-- 	local cat_ped = CreatePed(28, cat_model, GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, -0.8, 0.0), GetEntityHeading(HighLife.Player.Ped), false, true)

				-- 	Wait(3000)

				-- 	ClearPedTasks(cat_ped)

				-- 	TaskWanderStandard(cat_ped, 10.0, 10)

				-- 	TaskFollowToOffsetOfEntity(cat_ped, HighLife.Player.Ped, 0.0, 0.25, 0.0, 0, 1, -1, 0.25, true)
				-- end)
			end

			if HighLife.Player.Special or HighLife.Player.CatLover then
				-- SetPedConfigFlag(HighLife.Player.Ped, 32, false)
			end

			if data.available_keys ~= nil then
				local keyData = json.decode(data.available_keys)

				if keyData ~= nil then
					HighLife.Player.VehicleKeys = keyData
				end
			end

			if data.is_helper then
				HighLife.Player.IsHelper = true
			end

			if data.is_editor then
				HighLife.Player.IsEditor = true
			end

			if data.event_data ~= nil then
				TriggerEvent('HighLife:Event:Sync', json.encode(data.event_data))
			end

			if data.is_staff then
				local staffDecorInt = Config.Ranks.Staff

				HighLife.Player.IsStaff = true

				TriggerEvent('chat:AllowEmojis')

				if data.staff_group == 'founder' then
					staffDecorInt = 5
				end

				if data.staff_group == '_dev' then
					staffDecorInt = 6
				end

				HighLife.Player.Supporter = Config.Ranks.DiamondSupporter

				CreateThread(function()
					while HighLife.Player.CD do
						Wait(100)
					end
					
					DecorSetInt(HighLife.Player.Ped, 'Player.Rank', staffDecorInt)
				end)
			end

			if data.nitro_booster then
				HighLife.Player.NitroBoosted = data.nitro_booster
			end

			if data.events_team then
				HighLife.Player.EventsTeam = data.events_team
			end

			if data.flight_instructor then
				HighLife.Player.Instructor = data.flight_instructor
			end

			if data.isAutistic then
				HighLife.Player.Autism, HighLife.Player.Autistic = true
			end

			if data.tattoos ~= nil then
				HighLife.Player.Tattoos = json.decode(data.tattoos)

				CreateThread(function()
					while HighLife.Player.CD do
						Wait(1000)
					end

					UpdatePlayerDecorations()
				end)
			end

			if data.support_rank ~= nil then
				HighLife.Player.Supporter = data.support_rank

				if HighLife.Player.Supporter ~= nil and not HighLife.Player.IsStaff then
					CreateThread(function()
						while HighLife.Player.CD do
							Wait(100)
						end

						DecorSetInt(HighLife.Player.Ped, 'Player.Rank', HighLife.Player.Supporter)
					end)
				end

				TriggerEvent('chat:AllowEmojis')
			else
				print('Like reading the F8 logs? You can support HighLife if you like it that much, check the #support-highlife channel on Discord for more info')
			end

			RemoveAllPedWeapons(HighLife.Player.Ped, true)

			HighLife.Player.WeaponCheck = false
		
			TriggerEvent('esx:restoreLoadout')

			CreateThread(function()
				Wait(700)
				
				HighLife.Player.WeaponCheck = true
			end)

			HighLife.Player.InstanceCheckActive = false

			isFirstLoad = false

			SettingPlayerData = false

			HighLife.Other.JobStatData.Loaded = true

			-- For multi char switching
			UpdatePropertyBlips()
		end)
	end
end)

RegisterNetEvent('HighLife:Player:RemoveWeapon')
AddEventHandler('HighLife:Player:RemoveWeapon', function(weapon, removeAmmo)
	local thisWeapon = GetHashKey(weapon)

	RemoveWeaponFromPed(HighLife.Player.Ped, thisWeapon)

	if removeAmmo ~= nil then
		if tonumber(removeAmmo) ~= nil then
			SetPedAmmo(HighLife.Player.Ped, thisWeapon, GetAmmoInPedWeapon(HighLife.Player.Ped, thisWeapon) - tonumber(removeAmmo))
		else
			SetPedAmmo(HighLife.Player.Ped, thisWeapon, 0)
		end
	end
end)

RegisterNetEvent('HighLife:Player:SetLicenses')
AddEventHandler('HighLife:Player:SetLicenses', function(licenses)
	HighLife.Player.Licenses = licenses
end)

RegisterNetEvent('HighLife:Player:UpdateLicense')
AddEventHandler('HighLife:Player:UpdateLicense', function(name, bool)
	HighLife.Player.Licenses[name] = bool
end)

local lastHealth = nil
local lastArmour = nil
local lastVitals = nil

local updateCoreStats = false

local currentArmour = nil
local currentHealth = nil
local currentVitals = nil

local thisCoreData = nil

function HighLife:UpdateCorePlayerStats()
	updateCoreStats = false
	
	if not isFirstLoad then
		if HighLife.Player.LastDeathData ~= nil and HighLife.Player.LastDeathData.cause_hash ~= nil then
			HighLife.Player.Vitals.death_hash = HighLife.Player.LastDeathData.cause_hash

			Debug('set vital cause hash to ', HighLife.Player.Vitals.death_hash)
		end

		currentArmour = GetPedArmour(HighLife.Player.Ped)
		currentHealth = GetEntityHealth(HighLife.Player.Ped)
		currentVitals = json.encode(HighLife.Player.Vitals)

		thisCoreData = {
			health = currentHealth,
			armour = currentArmour,
			bleeding = HighLife.Player.Bleeding,
			vitals = currentVitals
		}

		if currentArmour ~= lastArmour then
			updateCoreStats = true
		end

		if currentHealth ~= lastHealth then
			updateCoreStats = true
		end

		if currentVitals ~= lastVitals then
			updateCoreStats = true
		end

		if updateCoreStats then
			lastHealth = currentHealth
			lastVitals = currentVitals
			lastArmour = currentArmour

			Debug('Updated health at: ' .. thisCoreData.health)

			TriggerServerEvent('HighLife:Player:UpdateBasicData', json.encode(thisCoreData))
		end
	end
end

CreateThread(function()
	Wait(5000)

	if isFirstLoad then
		TriggerServerEvent('HighLife:Player:GetData')
	end

	while true do
		if not HighLife.Player.CD and not HighLife.Player.InstanceCheckActive then
			HighLife:UpdateCorePlayerStats()
		end

		Wait(10000)
	end
end)

-- PLAYER_SWITCH

-- CreateThread(function()
-- 	while true do
-- 		if IsControlPressed(0, 45) then
-- 			local hasWeapon, currentWeapon = GetCurrentPedWeapon(HighLife.Player.Ped)

-- 			if GetWeaponDamageType(currentWeapon) == 3 then
-- 				local gotWeapon, currentAmmo = GetAmmoInClip(HighLife.Player.Ped, currentWeapon)

-- 				local maxClipAmmo = GetMaxAmmoInClip(HighLife.Player.Ped, currentWeapon, true)

-- 				if currentAmmo ~= maxClipAmmo then
--                     local finalWeaponAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_PISTOL')) - currentAmmo

--                     SetPedAmmo(HighLife.Player.Ped, currentWeapon, finalWeaponAmmo)

-- 					Wait(3000)
-- 				end
-- 			end
-- 		end

-- 		Wait(1)
-- 	end
-- end)

RegisterNetEvent('HighLife:Player:GetHuntingStats') 
AddEventHandler('HighLife:Player:GetHuntingStats', function(stats) if stats ~= nil then for k,v in pairs(stats) do if type(v) == 'string' then Config[k] = json.decode(v) else Config[k] = v end end end end)
