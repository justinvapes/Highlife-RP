-- local nearSwitch = false

-- local createBlip = true

-- RegisterNetEvent('HighLife:Character:Erase')
-- AddEventHandler('HighLife:Character:Erase', function()
-- 	TriggerServerEvent('esx_phone:removeAllContacts')
-- end)

-- We do this as they're probably dead
local switchLimbo = false

RegisterNetEvent('HighLife:Characters:Update')
AddEventHandler('HighLife:Characters:Update', function(character_data)
	HighLife.Player.CharacterData = json.decode(character_data)
end)

RegisterNetEvent('HighLife:Character:ForceLimbo')
AddEventHandler('HighLife:Character:ForceLimbo', function()
	HighLife:CharacterLimbo()
end)

function HighLife:CharacterLimbo()
	switchLimbo = true

	HighLife:SwitchCharacters()
end

local isFirstLoad = true
local hasSwitchedCharacter = false

local badSwitchScenarios = {
	'WORLD_FISH_IDLE',
	'WORLD_RABBIT_FLEE',
	'WORLD_RATS_EATING',
	'WORLD_COW_GRAZING',
	'WORLD_PIG_GRAZING',
	'WORLD_COYOTE_REST',
	'WORLD_GULL_FEEDING',
	'WORLD_DEER_GRAZING',
	'WORLD_GULL_FEEDING',
	'WORLD_COYOTE_WANDER',
	'WORLD_GULL_STANDING',
	'WORLD_STINGRAY_SWIM',
	'WORLD_RABBIT_EATING',
	'WORLD_DOG_SITTING_SMALL',
	'WORLD_CAT_SLEEPING_GROUND',
	'WORLD_CHICKENHAWK_STANDING',
	'WORLD_MOUNTAIN_LION_WANDER',
	'WORLD_DOG_BARKING_RETRIEVER',
	'WORLD_DOG_SITTING_RETRIEVER',
	'WORLD_DOG_SITTING_ROTTWEILER',
	'WORLD_HUMAN_SEAT_WALL_TABLET',
	'WORLD_HUMAN_PROSTITUTE_LOW_CLASS',
}

local badSwitchAreas = {
	mrpd = {
		vector3(491.1407, -962.9357, -50.24326),
		vector3(426.7418, -1029.458, 50.00152)
	},
	pillbox = {
		vector3(301.12, -583.23, 33.24326),
		vector3(364.7418, -571.458, 60.00152)
	},
	prison = {
		vector3(1857.41, 2722.81, 20.88),
		vector3(1497.7418, 2451.85, 80.00152)
	}
}

function EnableBadSwitchScenarios(enable)
	for i=1, #badSwitchScenarios do
		SetScenarioTypeEnabled(badSwitchScenarios[i], disable)
	end
end

function HighLife:SwitchCharacters()
	CreateThread(function()
		SwitchOutPlayer(HighLife.Player.Ped, 0, 1)

		HighLife.Player.HideHUD = true
		HighLife.Player.InCharacterMenu = true

		TaskStandStill(HighLife.Player.Ped, -1)

		while GetPlayerSwitchState() ~= 5 do
			Wait(1)
		end

		NetworkFadeOutEntity(HighLife.Player.Ped, false, true)

		FreezeEntityPosition(HighLife.Player.Ped, true)

		SetEntityCollision(HighLife.Player.Ped, false, false)

		if not HighLife.Settings.Development then
			while not HighLife.Player.HasReadDisclaimer do
				Wait(1)
			end
		end

		if IsScreenFadedOut() then
			DoScreenFadeIn(3000)
		end

		Wait(3000)

		RageUI.Visible(RMenu:Get('character', 'main'), true)

		RMenu:Get('character', 'main').Controls.Back.Enabled = true

		if switchLimbo then
			CreateThread(function()
				while switchLimbo do
					if RageUI.Visible(RMenu:Get('character', 'main')) then
						RMenu:Get('character', 'main').Controls.Back.Enabled = false
					end

					if RageUI.Visible(RMenu:Get('character', 'create')) then
						RMenu:Get('character', 'create').Controls.Back.Enabled = true
					end

					Wait(1)
				end
			end)
		end

		Wait(1000)

		-- Check if they requested a new character or if they just closed the menu
		while (RageUI.Visible(RMenu:Get('character', 'main')) or RageUI.Visible(RMenu:Get('character', 'create'))) or HighLife.Player.SwitchingCharacters do
			if HighLife.Player.SwitchingCharacters then
				if not hasSwitchedCharacter then
					HighLife:ResetDefaultSkin()
					HighLife:ResetDetentionData()
					HighLife:ResetOverrideClothing()
				end

				switchLimbo = false
				hasSwitchedCharacter = true

				HighLife.Player.CD = false
			end

			Wait(1)
		end

		TriggerMusicEvent('FM_INTRO_DRIVE_END')

		SwitchInPlayer(HighLife.Player.Ped)

		RequestCollisionAtCoord(HighLife.Player.Pos)

		local time = GameTimerPool.GlobalGameTime

		while (not HasCollisionLoadedAroundEntity(HighLife.Player.Ped) and (GameTimerPool.GlobalGameTime - time) < 5000) do
			Wait(1)
		end

		SetEntityCollision(HighLife.Player.Ped, true, true)

		local inBadArea = false

		for k,v in pairs(badSwitchAreas) do
			if IsEntityInAngledArea(HighLife.Player.Ped, v[1], v[2], 50.0, 0, true, 0) then
				inBadArea = true

				break
			end
		end

		while GetPlayerSwitchState() ~= 8 do
			Wait(1)
		end

		if hasSwitchedCharacter or isFirstLoad then
			ClearPedBloodDamage(HighLife.Player.Ped)

			hasSwitchedCharacter = false

			GameTimerPool.CharacterSwitch = GameTimerPool.GlobalGameTime + (600 * 1000)

			inScenario = false

			AnimpostfxStopAll()

			if not inBadArea and not DoesScenarioBlockingAreaExist((vector3(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z) - vector3(15.0, 15.0, 15.0)), vector3(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z) + vector3(15.0, 15.0, 15.0)) then
				EnableBadSwitchScenarios(false)

				ClearPedTasks(HighLife.Player.Ped)
				
				if not HighLife.Player.IsNewCharacter then
					TaskUseNearestScenarioToCoordWarp(HighLife.Player.Ped, HighLife.Player.Pos, 20.0, -1)
				end

				NetworkFadeInEntity(HighLife.Player.Ped, 1)
			end
		else
			ClearPedTasks(HighLife.Player.Ped)

			NetworkFadeInEntity(HighLife.Player.Ped, 1)
		end

		while GetPlayerSwitchState() ~= 12 do
			Wait(1)
		end

		-- Reset menus we lock
		RMenu:Get('character', 'main').Controls.Back.Enabled = true
		RMenu:Get('character', 'create').Controls.Back.Enabled = true

		SetEntityVisible(HighLife.Player.Ped, true)
		FreezeEntityPosition(HighLife.Player.Ped, false)

		if HighLife.Player.IsNewCharacter or HighLife.Player.IsInvalidCharacter then
			HighLife:OpenSkinMenu(HighLife.Player.IsNewCharacter)

			HighLife.Player.IsNewCharacter = false
			HighLife.Player.IsInvalidCharacter = false
		end

		-- Get their new character details, TODO remove
		TriggerServerEvent('HInventory:GetPlayerDetails')

		Wait(3000)

		if isFirstLoad then
			isFirstLoad = false
		end

		EnableBadSwitchScenarios(true)

		if not HighLife.Player.IsNewCharacter then
			ClearPedTasks(HighLife.Player.Ped)
		end

		HighLife.Player.InCharacterMenu = false

		HighLife.Player.HideHUD = false
	end)
end