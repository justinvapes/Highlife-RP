local BanDurationsList = {}

local active_players = {}
local disconnected_players = {}

local ActivePlayerMenus = {}

local SpectatingPlayer = nil

local RadiusPropHashes = 1

local PlayerBanData = {}
local PlayerWarningData = {}

local PlayerNameFilter = nil

local PlayersVisibleCheck = false

local SetInstructionalButton = false

local TargetPlayerData = nil

local tempData = {
	ban = {
		reason = nil,
		comment = nil,
		duration = 1,
		hardware = false
	},
	kick = {
		reason = nil
	},
	warn = {
		reason = nil,
		comment = nil
	}
}

RMenu.Add('staff_menu', 'main', RageUI.CreateMenu("pew pew bang bang", "~b~Moderation tools and pest control"))

RMenu.Add('staff_menu', 'players', RageUI.CreateSubMenu(RMenu:Get('staff_menu', 'main'), "PlayerList", "~g~Current Players", nil, nil, "root_cause", "shopui_title_dynasty8"))
RMenu.Add('staff_menu', 'disco_players', RageUI.CreateSubMenu(RMenu:Get('staff_menu', 'main'), "PlayerList", "~o~Disconnected Players", nil, nil, "root_cause", "shopui_title_dynasty8"))
RMenu.Add('staff_menu', 'server', RageUI.CreateSubMenu(RMenu:Get('staff_menu', 'main'), "Server Control", "Take control, and FIRMLY GRASP IT", nil, nil, "root_cause", "shopui_title_dynasty8"))
RMenu.Add('staff_menu', 'toolbox', RageUI.CreateSubMenu(RMenu:Get('staff_menu', 'main'), "Toolbox", "Trinkets and Tricks", nil, nil, "root_cause", "shopui_title_dynasty8"))

RMenu.Add('players_menu', 'player', RageUI.CreateSubMenu(RMenu:Get('staff_menu', 'players'), 'Current Player', 'Current Player'))
RMenu.Add('players_menu', 'ban_player', RageUI.CreateSubMenu(RMenu:Get('players_menu', 'player'), "Ban"))
RMenu.Add('players_menu', 'kick_player', RageUI.CreateSubMenu(RMenu:Get('players_menu', 'player'), "Kick"))
RMenu.Add('players_menu', 'warn_player', RageUI.CreateSubMenu(RMenu:Get('players_menu', 'player'), "Warn"))
RMenu.Add('players_menu', 'bans_player', RageUI.CreateSubMenu(RMenu:Get('players_menu', 'player'), "View Bans"))
RMenu.Add('players_menu', 'warnings_player', RageUI.CreateSubMenu(RMenu:Get('players_menu', 'player'), "View Warnings"))
		
RMenu.Add('disco_players_menu', 'player', RageUI.CreateSubMenu(RMenu:Get('staff_menu', 'disco_players'), 'Current Player', 'Current Player'))
RMenu.Add('disco_players_menu', 'ban_player', RageUI.CreateSubMenu(RMenu:Get('disco_players_menu', 'player'), "Ban"))
RMenu.Add('disco_players_menu', 'warn_player', RageUI.CreateSubMenu(RMenu:Get('disco_players_menu', 'player'), "Warn"))
RMenu.Add('disco_players_menu', 'bans_player', RageUI.CreateSubMenu(RMenu:Get('disco_players_menu', 'player'), "View Bans"))
RMenu.Add('disco_players_menu', 'warnings_player', RageUI.CreateSubMenu(RMenu:Get('disco_players_menu', 'player'), "View Warnings"))

RegisterNetEvent('HighLife:Staff:ReceiveBans')
AddEventHandler('HighLife:Staff:ReceiveBans', function(playerID, ban_data)
	PlayerBanData[playerID] = {}

	if ban_data ~= nil then
		PlayerBanData[playerID] = json.decode(ban_data)
	end
end)

RegisterNetEvent('HighLife:Staff:ReceiveWarnings')
AddEventHandler('HighLife:Staff:ReceiveWarnings', function(playerID, warning_data)
	PlayerWarningData[playerID] = {}

	if warning_data ~= nil then
		PlayerWarningData[playerID] = json.decode(warning_data)
	end
end)

function CleanupMenuData()
	tempData = {
		ban = {
			reason = nil,
			comment = nil,
			duration = 1,
			hardware = false
		},
		kick = {
			reason = nil
		},
		warn = {
			reason = nil,
			comment = nil
		}
	}

	PlayerBanData = {}
	PlayerWarningData = {}

	PlayerNameFilter = nil

	PlayersVisibleCheck = false

	RMenu:Get('staff_menu', 'players').Index = 1
	RMenu:Get('staff_menu', 'disco_players').Index = 1
end

function InitTasks()
	local tempBanLengths = {}

	for k,v in pairs(Config.Staff.BanDurations) do
		table.insert(tempBanLengths, k)
	end

	table.sort(tempBanLengths)

	for i=1, #tempBanLengths do
		table.insert(BanDurationsList, Config.Staff.BanDurations[tempBanLengths[i]])
	end
end

local spectateCam = nil

function StartSpectatePreCam(coords)
    ClearFocus()
    
    spectateCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, 0, 0, 0, 38 * 1.0)

    SetCamActive(spectateCam, true)

    RenderScriptCams(true, false, 0, true, false)
end

function DestroySpectatePreCam()
	ClearFocus()

    RenderScriptCams(false, false, 0, true, false)

    DestroyCam(spectateCam, false)
end

function SpectatePlayer(thisPed, thisServerID)
	local foundPlayer = nil

	for _,playerData in pairs(HighLife.Player.ActivePlayerData) do
		if playerData.ped == thisPed then
			foundPlayer = playerData

			break
		end
	end

	CreateThread(function()
		local success = false
		local startTime = GetGameTimer()

		StartSpectatePreCam(vector3(foundPlayer.coords.x, foundPlayer.coords.y, foundPlayer.coords.z))

		while true do
			if foundPlayer ~= nil then
				if GetPlayerFromServerId(foundPlayer.id) ~= -1 and GetPlayerPed(GetPlayerFromServerId(foundPlayer.id)) ~= 0 then
					success = true

					break
				end

				if GetGameTimer() > (startTime + (10 * 1000)) then
					break
				end
			end

			Wait(100)
		end
		
		if success then
			local existCheck = true

			local finalSpectatePed = GetPlayerPed(GetPlayerFromServerId(foundPlayer.id))

			FreezeEntityPosition(HighLife.Player.Ped, true)

			if HighLife.Player.InVehicle then
				FreezeEntityPosition(HighLife.Player.Vehicle, true)
			end

			startTime = GetGameTimer()

			while not DoesEntityExist(finalSpectatePed) do
				Wait(100)

				if GetGameTimer() > (startTime + (10 * 1000)) then
					existCheck = false

					break
				end
			end

			if existCheck then
				NetworkSetInSpectatorMode(true, finalSpectatePed)

				DestroySpectatePreCam()

				SpectatingPlayer = {
					Ped = finalSpectatePed,
					ID = foundPlayer.id,
				}

				HighLife.Player.SpectatingPed = finalSpectatePed
				
				TriggerServerEvent('HighLife:Staff:Spectate', SpectatingPlayer.ID)
			else
				print("something went wrong, did they leave?")
			end
		else
			DestroySpectatePreCam()
		end
	end)
end

local thisPlayerData = nil
local tempSortActivePlayers = nil
local tempSortDisconnectedPlayers = nil

-- DEBUG
-- function UpdateActivePlayers()
-- 	active_players = {}

-- 	tempSortActivePlayers = {}

-- 	CleanupMenuData()

-- 	for playerId,playerData in pairs(HighLife.Player.ActivePlayerData) do
-- 		table.insert(tempSortActivePlayers, playerId)
-- 	end

-- 	for i=1, 110 do
-- 		table.insert(tempSortActivePlayers, i)
-- 	end

-- 	table.sort(tempSortActivePlayers)

-- 	for _,thePlayer in pairs(tempSortActivePlayers) do
-- 		-- thisPlayerData = HighLife.Player.ActivePlayerData[thePlayer]

-- 		table.insert(active_players, {
-- 			ped = 1,
-- 			serverID = thePlayer,
-- 			coords = nil,
-- 			username = 'test',
-- 			isLoading = false,

-- 			isFrozen = 1,
-- 			teleportPos = 1
-- 		})
-- 	end
-- end

function UpdateActivePlayers()
	active_players = {}
	disconnected_players = {}

	tempSortActivePlayers = {}
	tempSortDisconnectedPlayers = {}

	for playerId,playerData in pairs(HighLife.Player.ActivePlayerData) do
		if playerData.disconnect_time ~= nil then
			table.insert(tempSortDisconnectedPlayers, playerId)
		else
			table.insert(tempSortActivePlayers, playerId)
		end
	end

	table.sort(tempSortActivePlayers, function(a, b) if a < b then return true end end)
	table.sort(tempSortDisconnectedPlayers, function(a, b) if a < b then return true end end)

	for _,thePlayer in pairs(tempSortActivePlayers) do
		thisPlayerData = HighLife.Player.ActivePlayerData[thePlayer]

		table.insert(active_players, {
			ped = thisPlayerData.ped,
			serverID = thisPlayerData.id,
			coords = thisPlayerData.coords,
			username = thisPlayerData.name,
			identifier = thisPlayerData.identifier,

			isLoading = false,
			disconnected = false,

			isFrozen = 1,
			teleportPos = 1
		})
	end

	for _,thePlayer in pairs(tempSortDisconnectedPlayers) do
		thisPlayerData = HighLife.Player.ActivePlayerData[thePlayer]

		table.insert(disconnected_players, {
			ped = thisPlayerData.ped,
			serverID = thisPlayerData.id,
			coords = thisPlayerData.coords,
			username = thisPlayerData.name,
			identifier = thisPlayerData.identifier,

			isLoading = false,
			disconnected = true,

			isFrozen = 1,
			teleportPos = 1
		})
	end
end

RMenu:Get('staff_menu', 'main').Closed = function()
	CleanupMenuData()
end

function IsHelperPlus()
	return (HighLife.Player.PlaytimeHours >= 2000)
end

CreateThread(function()
	InitTasks()

	local thisPlayerName = nil

	while true do
		if HighLife.Player.IsStaff or HighLife.Player.IsHelper then
			if GetLastInputMethod(2) and IsControlJustPressed(1, 57) and not RageUI.Visible(RMenu:Get('staff_menu', 'main')) then
				UpdateActivePlayers()

				if not SetInstructionalButton then
					if HighLife.Player.IsStaff then
						RMenu:Get('staff_menu', 'players'):AddInstructionButton({GetControlInstructionalButton(2, 22, 0), 'Preview'})

						RMenu:Get('staff_menu', 'main'):SetTitle("pew pew bang bang")
						RMenu:Get('staff_menu', 'main'):SetSubtitle("~b~Moderation tools and pest control")
					elseif HighLife.Player.IsHelper then
						RMenu:Get('staff_menu', 'main'):SetTitle("monkey menu" .. (IsHelperPlus() and '~g~+' or ''))
						RMenu:Get('staff_menu', 'main'):SetSubtitle("~g~Helper tools and tricks")
					end

					SetInstructionalButton = true
				end

				RageUI.Visible(RMenu:Get('staff_menu', 'main'), true)
			end

			if NetworkIsInSpectatorMode() then
				RageUI.Text({
					message = '[~y~E~s~] to stop spectating'
				})

				if SpectatingPlayer ~= nil then				
					local playerAttributes = {
						'Armor: ~b~' .. GetPedArmour(SpectatingPlayer.Ped),
						'Health: ~g~' .. GetEntityHealth(SpectatingPlayer.Ped),
						'Invincible: ' .. (GetPlayerInvincible(SpectatingPlayer.ID) and '~r~Yes' or '~g~No')
					}

					for i=1, #playerAttributes do
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.30)
						SetTextDropshadow(0, 0, 0, 0, 255)
						SetTextEdge(1, 0, 0, 0, 255)
						SetTextDropShadow()
						SetTextOutline()
						SetTextEntry("STRING")
						AddTextComponentString(playerAttributes[i])
						EndTextCommandDisplayText(0.3, 0.7 + (i / 30))
					end
				end

				if IsControlJustReleased(0, 38) or not DoesEntityExist(SpectatingPlayer.Ped) then
					SpectatingPlayer = nil

					HighLife.Player.SpectatingPed = nil

					NetworkSetInSpectatorMode(false, HighLife.Player.Ped)

					FreezeEntityPosition(HighLife.Player.Ped, false)

					if HighLife.Player.InVehicle then
						FreezeEntityPosition(HighLife.Player.Vehicle, false)
					end

					RageUI.Text({
						message = ''
					})
				end
			else
				if SpectatingPlayer ~= nil then
					SpectatingPlayer = nil

					HighLife.Player.SpectatingPed = nil

					NetworkSetInSpectatorMode(false, HighLife.Player.Ped)

					FreezeEntityPosition(HighLife.Player.Ped, false)

					if HighLife.Player.InVehicle then
						FreezeEntityPosition(HighLife.Player.Vehicle, false)
					end

					RageUI.Text({
						message = ''
					})
				end
			end

			if RageUI.Visible(RMenu:Get('staff_menu', 'main')) then				
				RageUI.IsVisible(RMenu:Get('staff_menu', 'main'), true, false, true, function()
					RageUI.ButtonWithStyle("Active Players", nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('staff_menu', 'players'))
					RageUI.ButtonWithStyle("Disconnected Players", nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('staff_menu', 'disco_players'))

					if HighLife.Player.IsStaff then
						RageUI.Separator()

						RageUI.ButtonWithStyle("Server Control", nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('staff_menu', 'server'))
						
						RageUI.ButtonWithStyle("Toolbox", nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('staff_menu', 'toolbox'))
					end
				end)
			end

			if RageUI.Visible(RMenu:Get('staff_menu', 'toolbox')) then
				RageUI.IsVisible(RMenu:Get('staff_menu', 'toolbox'), false, false, true, function()
					RageUI.ButtonWithStyle('Give DVGun', 'Why do we need to have this again?', { RightLabel = "🤦" }, true, function(Hovered, Active, Selected)
						if Selected then
							ExecuteCommand('dvgun')
						end
					end)

					RageUI.ButtonWithStyle('Spawn Elegy', 'Why do we need to have this again?', { RightLabel = "🤦" }, true, function(Hovered, Active, Selected)
						if Selected then
							ExecuteCommand('scar')

							RageUI.CloseAll()

							CleanupMenuData()
						end
					end)

					RageUI.ButtonWithStyle('Spawn Bicycle', 'Why do we need to have this again?', { RightLabel = "🤦" }, true, function(Hovered, Active, Selected)
						if Selected then
							ExecuteCommand('bike')

							RageUI.CloseAll()

							CleanupMenuData()
						end
					end)

					RageUI.Separator()

					RageUI.List("Enable Prop Hashes", {'Disabled', 'Enabled'}, HighLife.Other.RadiusPropHashes, "Shows object hashes, used to combat objects spawned by scripters. Get close, take note of the hash (~y~everything after hash:~s~) and submit it somewhere for it to be added.", {}, true, function(Hovered, Active, Selected, Index)
						if HighLife.Other.RadiusPropHashes ~= Index then
							HighLife.Other.RadiusPropHashes = Index
						end
					end)

					-- RageUI.ButtonWithStyle('Add Rogue Bad Model', "Adds the specified object as a 'bad model' to the anti-cheat", { RightLabel = "🤦" }, true, function(Hovered, Active, Selected)
					-- 	if Selected then
					-- 		local result = openKeyboard('STAFF_ADD_MODEL', '~r~Required: ~s~The hash (text or number) of the object to add')

					-- 		if result ~= nil then
					-- 			local thisModel = (tonumber(result) ~= nil and tonumber(result) or result)

					-- 			if IsModelInCdimage(thisModel) then
					-- 				TriggerServerEvent('HighLife:Rogue:AddModel', thisModel)
					-- 			else
					-- 				Notification_AboveMap("~r~ERROR~s~: '" .. thisModel .. "' is not a ~o~valid model~s~!")
					-- 			end
					-- 		end
					-- 	end
					-- end)
				end)
			end

			if RageUI.Visible(RMenu:Get('staff_menu', 'server')) then
				RageUI.IsVisible(RMenu:Get('staff_menu', 'server'), false, false, true, function()
					RageUI.ButtonWithStyle('Clear Chat', 'To ~b~soothe ~s~headaches', { RightLabel = "🛑" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_CLEAR_CHAT', '~r~Required: ~s~The message to send when clearing chat')

							if result and result ~= "" then							
								TriggerServerEvent('HighLife:Staff:ClearChat', result)
							end
						end
					end)

					RageUI.ButtonWithStyle('Mass Screenshot', 'Why do we need to have this again?', { RightLabel = "🤦" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent('HighLife:Staff:RMS')
						end
					end)

					RageUI.ButtonWithStyle('Revive Dead Players', 'aDMiN ReViVe PLs', { RightLabel = "⚰️" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent('HighLife:Staff:MassRevive')
						end
					end)
				end)
			end

			if PlayersVisibleCheck or RageUI.Visible(RMenu:Get('staff_menu', 'players')) or RageUI.Visible(RMenu:Get('staff_menu', 'disco_players')) then
				PlayersVisibleCheck = true

				RageUI.IsVisible(RMenu:Get('staff_menu', 'disco_players'), false, false, true, function()
					RageUI.ButtonWithStyle('Jump to ID', 'FIND THEM', { RightLabel = "🔎" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_JUMP_ID', 'Enter a player ID to jump to it')

							if result and tonumber(result) ~= nil then							
								local foundPlayer = false

								local thisIndex = 1
								
								for k,v in pairs(disconnected_players) do
									if v.serverID == tonumber(result) then
										foundPlayer = true

										RMenu:Get('staff_menu', 'disco_players').Index = thisIndex + 3

										break
									end

									thisIndex = thisIndex + 1
								end

								if not foundPlayer then
									Notification_AboveMap('~o~No player found with ID ~s~' .. result)
								end
							end
						end
					end)

					RageUI.ButtonWithStyle('Filter by name', (PlayerNameFilter ~= nil and '~y~Enter nothing to remove the current filter' or 'FIND THEM v2'), { RightLabel = "🔎" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_JUMP_NAME', 'Enter a player name, or part of one to filter players')

							if result ~= nil then							
								PlayerNameFilter = result

								if #PlayerNameFilter == 0 then
									PlayerNameFilter = nil
								end
							else
								PlayerNameFilter = nil
							end
						end
					end)

					RageUI.Separator((PlayerNameFilter ~= nil and "~b~Filtering ~s~players by: '" .. PlayerNameFilter .. "'" or nil))

					for k,v in pairs(disconnected_players) do
						if PlayerNameFilter ~= nil then
							if string.find(string.lower(v.username), string.lower(PlayerNameFilter)) ~= nil then
								RageUI.ButtonWithStyle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''), nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
									if Selected then
										TargetPlayerData = v

										RMenu:Get('disco_players_menu', 'player'):SetTitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
										RMenu:Get('disco_players_menu', 'player'):SetSubtitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
									end
								end, RMenu:Get('disco_players_menu', 'player'))
							end
						else
							RageUI.ButtonWithStyle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''), nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
								if Selected then
									TargetPlayerData = v

									RMenu:Get('disco_players_menu', 'player'):SetSubtitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
									RMenu:Get('disco_players_menu', 'player'):SetTitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
								end
							end, RMenu:Get('disco_players_menu', 'player'))
						end
					end
				end)

				RageUI.IsVisible(RMenu:Get('staff_menu', 'players'), false, false, true, function()
					RageUI.ButtonWithStyle('Jump to ID', 'FIND THEM', { RightLabel = "🔎" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_JUMP_ID', 'Enter a player ID to jump to it')

							if result and tonumber(result) ~= nil then							
								local foundPlayer = false

								local thisIndex = 1
								
								for k,v in pairs(active_players) do
									if v.serverID == tonumber(result) then
										foundPlayer = true

										RMenu:Get('staff_menu', 'players').Index = thisIndex + 3

										break
									end

									thisIndex = thisIndex + 1
								end

								if not foundPlayer then
									Notification_AboveMap('~o~No player found with ID ~s~' .. result)
								end
							end
						end
					end)

					RageUI.ButtonWithStyle('Filter by name', (PlayerNameFilter ~= nil and '~y~Enter nothing to remove the current filter' or 'FIND THEM v2'), { RightLabel = "🔎" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_JUMP_NAME', 'Enter a player name, or part of one to filter players')

							if result ~= nil then							
								PlayerNameFilter = result

								if #PlayerNameFilter == 0 then
									PlayerNameFilter = nil
								end
							else
								PlayerNameFilter = nil
							end
						end
					end)

					RageUI.Separator((PlayerNameFilter ~= nil and "~b~Filtering ~s~players by: '" .. PlayerNameFilter .. "'" or nil))

					for k,v in pairs(active_players) do
						if PlayerNameFilter ~= nil then
							if string.find(string.lower(v.username), string.lower(PlayerNameFilter)) ~= nil then
								RageUI.ButtonWithStyle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''), nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
									if Selected then
										TargetPlayerData = v

										RMenu:Get('players_menu', 'player'):SetSubtitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
										RMenu:Get('players_menu', 'player'):SetTitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
									end
								end, RMenu:Get('players_menu', 'player'))
							end
						else
							RageUI.ButtonWithStyle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''), nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
								if Selected then
									TargetPlayerData = v

									RMenu:Get('players_menu', 'player'):SetSubtitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
									RMenu:Get('players_menu', 'player'):SetTitle(string.format("%s - %s", v.serverID, v.username) .. (v.isLoading and ' - ~o~Loading' or ''))
								end
							end, RMenu:Get('players_menu', 'player'))
						end
					end

					if HighLife.Player.IsStaff then
						if IsControlJustPressed(1, 22) then -- Space
							local spectatePlayerMenuIndex = RMenu:Get('staff_menu', 'players').Index - 3

							local thisIndex = 1

							for k,v in pairs(active_players) do
								if thisIndex == spectatePlayerMenuIndex then
									SpectatePlayer(v.ped, v.serverID)

									break
								end

								thisIndex = thisIndex + 1
							end
						end
					end
				end)

				RageUI.IsVisible(RMenu:Get('players_menu', 'player'), false, false, true, function()
					if HighLife.Player.IsStaff then
						RageUI.ButtonWithStyle('Ban', 'Show them the ~b~stick', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'ban_player'))
						RageUI.ButtonWithStyle('Kick', 'Give them the ~o~boot', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'kick_player'))
						RageUI.ButtonWithStyle('Warn', 'Tell them to ~o~sudoku', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'warn_player'))
						
						RageUI.Separator()

						RageUI.ButtonWithStyle('View Bans', 'View a players previous infractions', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'bans_player'))
						RageUI.ButtonWithStyle('View Warnings', 'View a players previous warnings', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'warnings_player'))
						
						RageUI.Separator()
					elseif HighLife.Player.IsHelper and IsHelperPlus() then
						-- RageUI.ButtonWithStyle('Warn', 'Tell them to ~o~sudoku', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'warn_player'))
						RageUI.ButtonWithStyle('Kick', 'Give them the ~o~boot', { RightLabel = "→→→" }, true, nil, RMenu:Get('players_menu', 'kick_player'))

						RageUI.Separator()
					end

					if HighLife.Player.IsStaff then
						if HighLife.Player.Special then
							RageUI.ButtonWithStyle('Smite', 'I will also smite mine hands together, and I will cause my fury to rest: I the LORD have said it.', { RightLabel = "⚡" }, true, function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent("HighLife:Player:Smite", TargetPlayerData.serverID)
								end
							end)
						end

						RageUI.ButtonWithStyle('Revive', 'Kiss of life', { RightLabel = "💖" }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent("HighLife:Staff:Revive", TargetPlayerData.serverID)
							end
						end)

						RageUI.ButtonWithStyle('Spectate', (TargetPlayerData.isLoading and 'You cannot spectate while the player is loading' or 'Eagle-eyed'), { RightLabel = "🔎" }, not TargetPlayerData.isLoading, function(Hovered, Active, Selected)
							if Selected then
								SpectatePlayer(TargetPlayerData.ped, TargetPlayerData.serverID)
							end
						end)
					end

					if HighLife.Player.IsStaff then
						RageUI.ButtonWithStyle('Give Bike', 'Push iron', { RightLabel = "🚴" }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent('HighLife:Staff:GiveBike', TargetPlayerData.serverID)
							end
						end)

						-- RageUI.ButtonWithStyle('OOC Mute', "Hush little baby don't you cry", { RightLabel = "🗣️" }, true, function(Hovered, Active, Selected)
						-- 	if Selected then
						-- 		TriggerServerEvent("HighLife:Staff:Mute", TargetPlayerData.serverID)
						-- 	end
						-- end)

						RageUI.ButtonWithStyle('Screenshot', 'WHAT ARE YOU HIDING???', { RightLabel = "📸" }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent('HighLife:Staff:RMS', TargetPlayerData.serverID)
							end
						end)

						RageUI.ButtonWithStyle('Send Tutorial', 'Helpful, to an extent...', { RightLabel = "📝" }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent("HighLife:Staff:SendGuide", TargetPlayerData.serverID)
							end
						end)
					end

					RageUI.ButtonWithStyle('View Playtime', 'To be, or not to be, a danny...', { RightLabel = "🕒" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent('HighLife:Playtime:Get', TargetPlayerData.serverID)
						end
					end)

					if HighLife.Player.IsStaff then
						RageUI.ButtonWithStyle('Remove Items', 'Remove items from a player', { RightLabel = "👮" }, not TargetPlayerData.isLoading, function(Hovered, Active, Selected)
							if Selected then
								RageUI.CloseAll()

								HighLife:SearchPlayer(false, TargetPlayerData.serverID, true)
							end
						end)
					end

					if HighLife.Player.IsStaff or IsHelperPlus() then
						RageUI.ButtonWithStyle('Send Message', 'A helping selection of words', { RightLabel = "📩" }, true, function(Hovered, Active, Selected)
							if Selected then
								local result = openKeyboard('STAFF_SEND_MESSAGE', 'Sends a message to the specified player')

								if result and result ~= "" then							
									TriggerServerEvent("HighLife:Staff:SendMessage", TargetPlayerData.serverID, result, false, HighLife.Player.IsHelper)
								end
							end
						end)
					end
					
					RageUI.Separator()

					RageUI.ButtonWithStyle('Force Skin', 'Forces the player into the skin menu', { RightLabel = "👕" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent("HighLife:Staff:ForceSkin", TargetPlayerData.serverID)
						end
					end)

					RageUI.ButtonWithStyle('Force Register', 'Forces the player into the register screen', { RightLabel = "💄" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent("HighLife:Staff:ForceRegister", TargetPlayerData.serverID)
						end
					end)

					if HighLife.Player.IsStaff then
						RageUI.Separator()

						RageUI.List("Freeze", Config.Staff.FreezeOptions, TargetPlayerData.isFrozen, "Freeze the player (+the vehicle they are in)~n~~n~~r~Note: ~s~Make sure to unfreeze the vehicle they were in previously as the vehicle will be permenantly frozen", {}, true, function(Hovered, Active, Selected, Index)
							if TargetPlayerData.isFrozen ~= Index then
								TargetPlayerData.isFrozen = Index
							end

							if Selected then
								TriggerServerEvent("HighLife:Staff:FreezePlayer", TargetPlayerData.serverID, (tonumber(TargetPlayerData.isFrozen) == 1 and true or false))
							end
						end)

						RageUI.List("Teleport", Config.Staff.TeleportOptions, TargetPlayerData.teleportPos, "Teleport the player~n~~n~~b~Random Location~s~: Will set them back to a random spawn location", {}, true, function(Hovered, Active, Selected, Index)
							if TargetPlayerData.teleportPos ~= Index then
								TargetPlayerData.teleportPos = Index
							end

							if Selected then
								TriggerServerEvent('HighLife:Staff:Teleport', TargetPlayerData.serverID, TargetPlayerData.teleportPos)
							end
						end)
					end
				end)

				RageUI.IsVisible(RMenu:Get('players_menu', 'ban_player'), false, false, true, function()
					RageUI.ButtonWithStyle('Reason', "An explanation for the ban" .. (tempData.ban.reason ~= nil and ("~n~~n~~y~Reason: ~s~" .. tempData.ban.reason) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_BAN_PLAYER', 'The reason to ban the player')

							if result and result ~= "" then
								tempData.ban.reason = result
							end
						end
					end)

					RageUI.List("Duration", BanDurationsList, tempData.ban.duration, "How long the ban will last for", {}, true, function(Hovered, Active, Selected, Index)
						if tempData.ban.duration ~= Index then
							tempData.ban.duration = Index
						end
					end)
					
					RageUI.ButtonWithStyle('Comment', "~y~Not visible to the player, purely for audit purposes" .. (tempData.ban.comment ~= nil and ("~n~~n~~y~Comment: ~s~" .. tempData.ban.comment) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_COMMENT_PLAYER', 'Your comment for banning the player')

							if result and result ~= "" then
								tempData.ban.comment = result
							end
						end
					end)

					RageUI.Checkbox("~o~Hardware Ban", 'Attempts to catch ban evaders through ~b~magic means', tempData.ban.hardware, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						if Active then
							tempData.ban.hardware = not tempData.ban.hardware
						end
					end)

					RageUI.ButtonWithStyle('~r~Confirm Ban', '~r~NOTE: ~s~Pressing confirm will ban the player with the specified settings', { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							if tempData.ban.reason ~= nil then							
								TriggerServerEvent('HighLife:Staff:Ban', TargetPlayerData.serverID, json.encode(tempData.ban))

								RageUI.CloseAll()

								CleanupMenuData()
							else
								Notification_AboveMap('~r~NOTE: ~s~You must submit a reason for the ban')
							end
						end
					end)
				end)

				RageUI.IsVisible(RMenu:Get('players_menu', 'warn_player'), false, false, true, function()
					RageUI.ButtonWithStyle('Reason', "An explanation for the warning" .. (tempData.warn.reason ~= nil and ("~n~~n~~y~Reason: ~s~" .. tempData.warn.reason) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_WARN_PLAYER', 'The reason to warn the player')

							if result and result ~= "" then
								tempData.warn.reason = result
							end
						end
					end)
					
					RageUI.ButtonWithStyle('Comment', "~y~Not visible to the player, purely for audit purposes" .. (tempData.warn.comment ~= nil and ("~n~~n~~y~Comment: ~s~" .. tempData.warn.comment) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_COMMENT_PLAYER', 'Your comment for warning the player')

							if result and result ~= "" then
								tempData.warn.comment = result
							end
						end
					end)

					RageUI.ButtonWithStyle('~o~Confirm Warning', '~r~NOTE: ~s~Pressing confirm will warn the player with the specified settings', { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							if tempData.warn.reason ~= nil then							
								TriggerServerEvent('HighLife:Staff:Warn', TargetPlayerData.serverID, json.encode(tempData.warn))

								RageUI.CloseAll()

								CleanupMenuData()
							else
								Notification_AboveMap('~r~NOTE: ~s~You must submit a reason for the warning')
							end
						end
					end)
				end)

				RageUI.IsVisible(RMenu:Get('players_menu', 'kick_player'), false, false, true, function()
					RageUI.ButtonWithStyle('Reason', "An explanation for the kick" .. (tempData.kick.reason ~= nil and ("~n~~n~~y~Reason: ~s~" .. tempData.kick.reason) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_KICK', 'The reason for kicking the player')

							if result and result ~= "" then
								tempData.kick.reason = result
							end
						end
					end)

					RageUI.ButtonWithStyle('~b~Confirm Kick', '~r~NOTE: ~s~Pressing confirm will kick the player with the specified settings', { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							if tempData.kick.reason ~= nil then
								TriggerServerEvent('HighLife:Staff:Kick', TargetPlayerData.serverID, json.encode(tempData.kick), HighLife.Player.IsHelper)

								RageUI.CloseAll()

								CleanupMenuData()
							else
								Notification_AboveMap('~r~NOTE: ~s~You must submit a reason for the kick')
							end
						end
					end)
				end)

				RageUI.IsVisible(RMenu:Get('players_menu', 'bans_player'), false, false, true, function()
					if PlayerBanData[TargetPlayerData.serverID] ~= nil and type(PlayerBanData[TargetPlayerData.serverID]) == 'table' then
						if #PlayerBanData[TargetPlayerData.serverID] <= 0 then
							RageUI.ButtonWithStyle('~b~Squeaky Clean!', 'Player has no previous bans', { RightLabel = "🧼" }, true)
						else
							for i=1, #PlayerBanData[TargetPlayerData.serverID] do
								RageUI.ButtonWithStyle('~r~Ban ~s~#' .. i .. ' - (' .. PlayerBanData[TargetPlayerData.serverID][i].date .. ')', PlayerBanData[TargetPlayerData.serverID][i].reason .. '~n~~y~Comments~s~: ' .. (PlayerBanData[TargetPlayerData.serverID][i].comments ~= nil and (#PlayerBanData[TargetPlayerData.serverID][i].comments > 2 and PlayerBanData[TargetPlayerData.serverID][i].comments or 'None') or 'None'), { RightLabel = "🛑" }, true)
							end
						end
					else
						RageUI.Separator('Retrieving data...')

						if PlayerBanData[TargetPlayerData.serverID] == nil then
							PlayerBanData[TargetPlayerData.serverID] = true

							TriggerServerEvent('HighLife:Staff:RequestBans', TargetPlayerData.serverID)
						end
					end
				end)

				RageUI.IsVisible(RMenu:Get('players_menu', 'warnings_player'), false, false, true, function()
					if PlayerWarningData[TargetPlayerData.serverID] ~= nil and type(PlayerWarningData[TargetPlayerData.serverID]) == 'table' then
						if #PlayerWarningData[TargetPlayerData.serverID] <= 0 then
							RageUI.ButtonWithStyle('~b~Squeaky Clean!', 'Player has no warnings', { RightLabel = "🧼" }, true)
						else
							for i=1, #PlayerWarningData[TargetPlayerData.serverID] do
								RageUI.ButtonWithStyle('~r~Warning ~s~#' .. i .. ' - (' .. PlayerWarningData[TargetPlayerData.serverID][i].date .. ')', PlayerWarningData[TargetPlayerData.serverID][i].reason .. '~n~~y~Comments~s~: ' .. (PlayerWarningData[TargetPlayerData.serverID][i].comments ~= nil and PlayerWarningData[TargetPlayerData.serverID][i].comments or 'None'), { RightLabel = "⚠️" }, true)
							end
						end
					else
						RageUI.Separator('Retrieving data...')

						if PlayerWarningData[TargetPlayerData.serverID] == nil then
							PlayerWarningData[TargetPlayerData.serverID] = true

							TriggerServerEvent('HighLife:Staff:RequestWarnings', TargetPlayerData.serverID)
						end
					end
				end)

				RageUI.IsVisible(RMenu:Get('disco_players_menu', 'player' ), false, false, true, function()
					if HighLife.Player.IsStaff then
						RageUI.ButtonWithStyle('Ban', 'Show them the ~b~stick', { RightLabel = "→→→" }, true, nil, RMenu:Get('disco_players_menu', 'ban_player'))
						RageUI.ButtonWithStyle('Warn', 'Tell them to ~o~sudoku', { RightLabel = "→→→" }, true, nil, RMenu:Get('disco_players_menu', 'warn_player'))
						
						RageUI.Separator()

						RageUI.ButtonWithStyle('View Bans', 'View a players previous infractions', { RightLabel = "→→→" }, true, nil, RMenu:Get('disco_players_menu', 'bans_player'))
						RageUI.ButtonWithStyle('View Warnings', 'View a players previous warnings', { RightLabel = "→→→" }, true, nil, RMenu:Get('disco_players_menu', 'warnings_player'))

						RageUI.Separator()
					end

					RageUI.ButtonWithStyle('View Playtime', 'To be, or not to be, a danny...', { RightLabel = "🕒" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent('HighLife:Playtime:Get', TargetPlayerData.identifier)
						end
					end)
				end)

				RageUI.IsVisible(RMenu:Get('disco_players_menu', 'ban_player'), false, false, true, function()
					RageUI.ButtonWithStyle('Reason', "An explanation for the ban" .. (tempData.ban.reason ~= nil and ("~n~~n~~y~Reason: ~s~" .. tempData.ban.reason) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_BAN_PLAYER', 'The reason to ban the player')

							if result and result ~= "" then
								tempData.ban.reason = result
							end
						end
					end)

					RageUI.List("Duration", BanDurationsList, tempData.ban.duration, "How long the ban will last for", {}, true, function(Hovered, Active, Selected, Index)
						if tempData.ban.duration ~= Index then
							tempData.ban.duration = Index
						end
					end)
					
					RageUI.ButtonWithStyle('Comment', "~y~Not visible to the player, purely for audit purposes" .. (tempData.ban.comment ~= nil and ("~n~~n~~y~Comment: ~s~" .. tempData.ban.comment) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_COMMENT_PLAYER', 'Your comment for banning the player')

							if result and result ~= "" then
								tempData.ban.comment = result
							end
						end
					end)

					RageUI.ButtonWithStyle('~r~Confirm Ban', '~r~NOTE: ~s~Pressing confirm will ban the player with the specified settings', { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							if tempData.ban.reason ~= nil then
								tempData.ban.hardware = false

								tempData.ban.disconnected = true

								TriggerServerEvent('HighLife:Staff:Ban', TargetPlayerData.identifier, json.encode(tempData.ban))

								RageUI.CloseAll()

								CleanupMenuData()
							else
								Notification_AboveMap('~r~NOTE: ~s~You must submit a reason for the ban')
							end
						end
					end)
				end)

				RageUI.IsVisible(RMenu:Get('disco_players_menu', 'warn_player'), false, false, true, function()
					RageUI.ButtonWithStyle('Reason', "An explanation for the warning" .. (tempData.warn.reason ~= nil and ("~n~~n~~y~Reason: ~s~" .. tempData.warn.reason) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_WARN_PLAYER', 'The reason to warn the player')

							if result and result ~= "" then
								tempData.warn.reason = result
							end
						end
					end)
					
					RageUI.ButtonWithStyle('Comment', "~y~Not visible to the player, purely for audit purposes" .. (tempData.warn.comment ~= nil and ("~n~~n~~y~Comment: ~s~" .. tempData.warn.comment) or ""), { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('STAFF_COMMENT_PLAYER', 'Your comment for warning the player')

							if result and result ~= "" then
								tempData.warn.comment = result
							end
						end
					end)

					RageUI.ButtonWithStyle('~o~Confirm Warning', '~r~NOTE: ~s~Pressing confirm will warn the player with the specified settings', { RightLabel = "<>" }, true, function(Hovered, Active, Selected)
						if Selected then
							if tempData.warn.reason ~= nil then
								tempData.warn.disconnected = true

								TriggerServerEvent('HighLife:Staff:Warn', TargetPlayerData.identifier, json.encode(tempData.warn))

								RageUI.CloseAll()

								CleanupMenuData()
							else
								Notification_AboveMap('~r~NOTE: ~s~You must submit a reason for the warning')
							end
						end
					end)
				end)

				RageUI.IsVisible(RMenu:Get('disco_players_menu', 'bans_player'), false, false, true, function()
					if PlayerBanData[TargetPlayerData.identifier] ~= nil and type(PlayerBanData[TargetPlayerData.identifier]) == 'table' then
						if #PlayerBanData[TargetPlayerData.identifier] <= 0 then
							RageUI.ButtonWithStyle('~b~Squeaky Clean!', 'Player has no previous bans', { RightLabel = "🧼" }, true)
						else
							for i=1, #PlayerBanData[TargetPlayerData.identifier] do
								RageUI.ButtonWithStyle('~r~Ban ~s~#' .. i .. ' - (' .. PlayerBanData[TargetPlayerData.identifier][i].date .. ')', PlayerBanData[TargetPlayerData.identifier][i].reason .. '~n~~y~Comments~s~: ' .. (PlayerBanData[TargetPlayerData.identifier][i].comments ~= nil and (#PlayerBanData[TargetPlayerData.identifier][i].comments > 2 and PlayerBanData[TargetPlayerData.identifier][i].comments or 'None') or 'None'), { RightLabel = "🛑" }, true)
							end
						end
					else
						RageUI.Separator('Retrieving data...')

						if PlayerBanData[TargetPlayerData.identifier] == nil then
							PlayerBanData[TargetPlayerData.identifier] = true

							TriggerServerEvent('HighLife:Staff:RequestBans', TargetPlayerData.identifier)
						end
					end
				end)

				RageUI.IsVisible(RMenu:Get('disco_players_menu', 'warnings_player'), false, false, true, function()
					if PlayerWarningData[TargetPlayerData.identifier] ~= nil and type(PlayerWarningData[TargetPlayerData.identifier]) == 'table' then
						if #PlayerWarningData[TargetPlayerData.identifier] <= 0 then
							RageUI.ButtonWithStyle('~b~Squeaky Clean!', 'Player has no warnings', { RightLabel = "🧼" }, true)
						else
							for i=1, #PlayerWarningData[TargetPlayerData.identifier] do
								RageUI.ButtonWithStyle('~r~Warning ~s~#' .. i .. ' - (' .. PlayerWarningData[TargetPlayerData.identifier][i].date .. ')', PlayerWarningData[TargetPlayerData.identifier][i].reason .. '~n~~y~Comments~s~: ' .. (PlayerWarningData[TargetPlayerData.identifier][i].comments ~= nil and PlayerWarningData[TargetPlayerData.identifier][i].comments or 'None'), { RightLabel = "⚠️" }, true)
							end
						end
					else
						RageUI.Separator('Retrieving data...')

						if PlayerWarningData[TargetPlayerData.identifier] == nil then
							PlayerWarningData[TargetPlayerData.identifier] = true

							TriggerServerEvent('HighLife:Staff:RequestWarnings', TargetPlayerData.identifier)
						end
					end
				end)
			end
		end

		Wait(1)
	end
end)
