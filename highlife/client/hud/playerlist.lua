local currentPing = 0

local pingColor = ''
local hasStaff = false

local playerCount = 0

function GetLatestPlayerData()
	playerCount = 0
	hasStaff = false

	if HighLife.Player.ActivePlayerData ~= nil then
		for player,playerData in pairs(HighLife.Player.ActivePlayerData) do
			if playerData.disconnect_time == nil then
				playerCount = playerCount + 1

				if playerData.rank ~= nil and playerData.rank >= Config.Ranks.Staff then
					hasStaff = true
				end 
			end
		end
	end
end

function DrawPlayerList()	
	--Top bar
	DrawRect((0.0599 * 4), 0.045, (0.117 * 4), 0.03, 0, 0, 0, 220)

	if currentPing > 160 then
		pingColor = '~r~'
	elseif currentPing < 60 then
		pingColor = '~g~'
	elseif currentPing > 60  then
		pingColor = '~o~'
	end

	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.40, 0.40)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextEntry("STRING")
	AddTextComponentString("HighLife Roleplay - (" .. playerCount .. " connected)  " .. pingColor .. currentPing .. '~s~ms ' .. (hasStaff and '- ~g~Staff Online' or ''))

	DrawText(0.0105, 0.031)
end

local LastPress = 0
local gotPing = false
local lastPingTime = GameTimerPool.GlobalGameTime

CreateThread(function()
	TriggerServerEvent('HighLife:Discord:Log', 'system', GetPlayerName(HighLife.Player.Id) .. ' connected with server ID: ' .. GetPlayerServerId(HighLife.Player.Id))

	RequestStreamedTextureDict("mplobby")
	RequestStreamedTextureDict("mpleaderboard")

	local hasRun = false
	
	while true do
		if GetLastInputMethod(2) and IsControlPressed(0, 20) and (GameTimerPool.GlobalGameTime - LastPress) > 150 then
			LastPress = GameTimerPool.GlobalGameTime

			HighLife.Player.ZMenuOpen = not HighLife.Player.ZMenuOpen

			PlaySoundFrontend(-1, "LEADERBOARD", "HUD_MINI_GAME_SOUNDSET", 1)
		end
		
		if HighLife.Player.ZMenuOpen then
			if not gotPing then
				gotPing = true

				if (GameTimerPool.GlobalGameTime - lastPingTime) > 15000 then
					HighLife:ServerCallback('HPing:returnPing', function(ping)
						if ping ~= nil then
							currentPing = tonumber(ping)
						end
					end)

					lastPingTime = GameTimerPool.GlobalGameTime
				end
			end

			if (GameTimerPool.GlobalGameTime - LastPress) > 4000 then
				HighLife.Player.ZMenuOpen = false

				PlaySoundFrontend(-1, "LEADERBOARD", "HUD_MINI_GAME_SOUNDSET", 1)
			end

			if not hasRun then
				hasRun = true

				GetLatestPlayerData()
			end

			DrawPlayerList()
		else
			HideHudComponentThisFrame(7) -- Area Name
			HideHudComponentThisFrame(9) -- Street Name

			hasRun = false

			gotPing = false
		end

		Wait(1)
	end
end)