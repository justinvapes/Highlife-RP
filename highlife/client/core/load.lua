-- @REMEMBER: This needs to be false for live

local disable = false

local music_events = {
	'OJBJ_START',
	'OJDG1_START',
	'FM_INTRO_START',
	'MICHAELS_HOUSE',
	'MP_DM_START_ALL',
	'AH3B_BURNTOUT_RT',
	'FRA1_FIGHT_START',
	'MGTR_MUSIC_START',
	'MIC1_TREVOR_PLANE',
	'PEYOTE_TRIPS_START',
	'MIC3_MISSION_START',
	'FAM1_FRANK_JUMPS_RT',
	'LM1_TERMINADOR_CLUMSY_ASS',
	'LM1_TERMINADOR_EXIT_WAREHOUSE'
}

local finish_event = 'FM_INTRO_DRIVE_END'

function ToggleSound(state)
	if state then
		StartAudioScene("MP_LEADERBOARD_SCENE")
	else
		StopAudioScene("MP_LEADERBOARD_SCENE")
	end
end

-- StartAudioScene("MP_LEADERBOARD_SCENE")
-- TriggerMusicEvent('')
-- StopAudioScene("MP_LEADERBOARD_SCENE")

local isLoading = true
local hasSentIdentifier = false

CreateThread(function()
	while not HighLife.Player.SentIdentifier do
		Wait(1)
	end
	
	if not disable then
		CreateThread(function()
			while isLoading do
				HighLife.Player.HideHUD = true

				Wait(1)
			end
		end)

		ShutdownLoadingScreen()

		DoScreenFadeOut(0)

		while not IsScreenFadedOut() do
			Wait(1)
		end

		Debug('Waiting for first spawn to be set')

		if not HighLife.Player.InCharacterMenu then
			while HighLife.Player.FirstSpawn do
				Wait(1)
			end

			Debug('Passed first spawn')

			while not HighLife.Player.GoForRollProgram do
				Wait(1)
			end

			RequestCollisionAtCoord(HighLife.Player.Pos)

			Wait(1000)

			Debug('init switch state')

			while HighLife.Player.Heading == nil do
				Wait(1)
			end

			SwitchOutPlayer(HighLife.Player.Ped, 0, 1)
			
			SetEntityVisible(HighLife.Player.Ped, false)
			FreezeEntityPosition(HighLife.Player.Ped, true)
		end

		Debug('Waiting for sky state')

		local forceLoad = false

		local failCount = 10

		local testCount = 0

		CreateThread(function()
			while not forceLoad do
				Wait(1000)

				testCount = testCount + 1

				Debug('Debug count for load: ' .. testCount .. '/' .. failCount)

				if testCount == failCount then
					forceLoad = true

					break
				end
			end
		end)

		-- Wait for the switch cam to be in the sky in the 'waiting' state (5).d
		while GetPlayerSwitchState() ~= 5 do
			Wait(1)

			if forceLoad then
				Debug('forced break')
				break
			end
		end

		Debug('Shutting down loading NUI')

		ShutdownLoadingScreenNui()

		ToggleSound(true)

		Wait(3000)

		DoScreenFadeIn(4000)
		
		-- Shut down the game's loading screen (this is NOT the NUI loading screen).

		RequestCollisionAtCoord(HighLife.Player.Pos)

		TriggerMusicEvent(music_events[math.random(#music_events)])

		HighLife.Player.HideHUD = true

		while not IsScreenFadedIn() do
			Wait(0)
		end
		
		local timer = GetGameTimer()
		
		-- Re-enable the sound in case it was muted.
		ToggleSound(false)

		TriggerEvent('HighLife:Guide:Open')

		RequestCollisionAtCoord(HighLife.Player.Pos)

		Wait(1000)
		
		while true do
			if GetGameTimer() - timer > 5000 then
				if HighLife.Player.HasReadDisclaimer then
					if not HighLife.Player.InCharacterMenu then
						TriggerMusicEvent(finish_event)
						
						SwitchInPlayer(HighLife.Player.Ped)

						SetEntityVisible(HighLife.Player.Ped, true)
						FreezeEntityPosition(HighLife.Player.Ped, false)

						while GetPlayerSwitchState() ~= 12 do
							Wait(1)

							SwitchInPlayer(PlayerPedId())
						end
					end

					break
				end
			end

			Wait(1)
		end

		isLoading = false

		if not HighLife.Player.InCharacterMenu then
			HighLife.Player.CD = false

			HighLife.Player.HideHUD = false 
		end
		
		ClearDrawOrigin()
	else
		isLoading = false

		DoScreenFadeIn(0)

		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()

		HighLife.Player.CD = false
	end
end)
