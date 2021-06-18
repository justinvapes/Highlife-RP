RMenu.Add('report', 'main', RageUI.CreateMenu("Player Menu", "~g~Your own toolbox"))

RMenu.Add('report', 'settings', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Settings", "Whatever your preference"))

RMenu.Add('report', 'player', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Report Player", "Use this to report players"))
RMenu.Add('report', 'issue', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Report Issue", "Use this to report immediate issues to staff"))

RMenu.Add('report', 'warnings', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Past Warnings", "View your account warnings"))
RMenu.Add('report', 'bans', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Past Bans", "View your account bans"))

RMenu.Add('report', 'errors', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Errors", "Help fix server issues"))
RMenu.Add('report', 'contributors', RageUI.CreateSubMenu(RMenu:Get('report', 'main'), "Contributors", "~b~HighLife Contributors"))

CreateThread(function()
	local playersNearby = false

	local errorCount = 0

	while true do
		playersNearby = false

		RageUI.IsVisible(RMenu:Get('report', 'main'), true, false, true, function()
			errorCount = 0

			for i=1, #HighLife.Other.ErrorQueue do
				if not HighLife.Other.ErrorQueue[i].completed then
					errorCount = errorCount + 1
				end
			end

			if errorCount > 0 then
				RageUI.ButtonWithStyle(string.format('~o~Report Errors ~s~- %s', errorCount), 'Report errors for a ~g~potential reward ~s~if the info helps us resolve the issue', { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'errors'))
			end

			RageUI.ButtonWithStyle('Report Issue', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'issue'))
			RageUI.ButtonWithStyle('Report Player', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'player'))

			RageUI.Separator()

			RageUI.ButtonWithStyle('Settings', "Whatever your preference", { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'settings'))

			RageUI.Separator()

			RageUI.ButtonWithStyle('Past Bans - (' .. #HighLife.Player.BanData .. ' bans)', "View your account bans", { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'bans'))
			RageUI.ButtonWithStyle('Past Warnings - (' .. #HighLife.Player.WarningData .. ' warnings)', "View your account warnings", { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'warnings'))
			
			RageUI.Separator()

			for k,v in pairs(GetActivePlayers()) do
				if HighLife.Player.Ped ~= GetPlayerPed(tonumber(v)) then
					if HasEntityClearLosToEntity(HighLife.Player.Ped, GetPlayerPed(tonumber(v)), 17) then
						playersNearby = true

						break
					end
				end
			end

			-- Switch Conditions
			if IsPedShooting(HighLife.Player.Ped) or HighLife.Player.CD or HighLife.Player.Dead or HighLife.Player.InVehicle or (HighLife.Player.Job.CurrentJob ~= nil) or HighLife.Player.Bleeding or HighLife.Player.Detention.Active or IsPedRagdoll(HighLife.Player.Ped) or HighLife.Player.IsCookingMeth or HighLife.Player.IsSellingDrugs or HighLife.Player.IsHealing then
				HighLife.Player.CanSwitch = false

				if HighLife.Player.Dead or (HighLife.Player.Job.CurrentJob ~= nil) or HighLife.Player.Bleeding or IsPedShooting(HighLife.Player.Ped) or (GetEntitySpeedMPH(HighLife.Player.Vehicle) > 100.0) or HighLife.Player.IsCookingMeth or HighLife.Player.IsSellingDrugs then
					GameTimerPool.CharacterSwitch = GameTimerPool.GlobalGameTime + (600 * 1000)
				end

				if HighLife.Player.Detention.InJail then
					HighLife.Player.CanSwitch = true
				end
			end

			if GameTimerPool.GlobalGameTime >= GameTimerPool.CharacterSwitch then
				HighLife.Player.CanSwitch = true
			else
				HighLife.Player.CanSwitch = false
			end

			if HighLife.Player.Debug or HighLife.Settings.Development then
				HighLife.Player.CanSwitch = true
			end
			
			RageUI.ButtonWithStyle('Switch Character', (HighLife.Player.CanSwitch and (not playersNearby and "~g~Make the switch" or "~b~Hide from other players to switch") or "You cannot switch right now (" .. math.floor((GameTimerPool.CharacterSwitch - GameTimerPool.GlobalGameTime) / 1000) .. "s ~y~remaining~s~)"), { RightLabel = "→→→" }, HighLife.Player.CanSwitch and not playersNearby, function(Hovered, Active, Selected)
				if Selected then
					RageUI.CloseAll()

					HighLife:SwitchCharacters()
				end
			end)

			RageUI.ButtonWithStyle('~y~Project Contributors', "People that have contributed towards the development of the ~y~HighLife ~s~project", { RightLabel = "→→→" }, true, nil, RMenu:Get('report', 'contributors'))
		end)

		RageUI.IsVisible(RMenu:Get('report', 'errors'), true, false, true, function()
			for i=1, #HighLife.Other.ErrorQueue do
				if not HighLife.Other.ErrorQueue[i].completed then
					RageUI.ButtonWithStyle(string.format('~r~Error ~s~#%s', i), 'Press ~y~Enter ~s~to fill out', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							SendNUIMessage({
								nui_reference = 'sentry',

								issue_id = HighLife.Other.ErrorQueue[i].issue_id,
								username = GetPlayerName(PlayerId()),
								error = HighLife.Other.ErrorQueue[i].errorText
							})

							HighLife.Other.ErrorQueue[i].completed = true

							SetNuiFocus(true, true)
						end
					end)
				end
			end
		end)

		RageUI.IsVisible(RMenu:Get('report', 'contributors'), true, false, true, function()
			RageUI.ButtonWithStyle('Jarrrk', "\"3 years and still have no idea what I'm doing\"", { RightLabel = "🚀" }, true, function(Hovered, Active, Selected)
				if Selected then
					print('pew pew')
				end
			end)

			RageUI.Separator()

			RageUI.ButtonWithStyle('huh?', "This area is to highlife members of the community that have contributed towards developing HighLife. If you don't see your name here and think it should be, message me!", { RightLabel = "???" }, true)
		end)

		RageUI.IsVisible(RMenu:Get('report', 'issue'), true, false, true, function()
			RageUI.ButtonWithStyle('Reason', '~y~Describe the issue you are reporting, e.g cheater, server issue~s~' .. (MenuVariables.Report.Issue.reason ~= nil and ':~n~~n~' .. MenuVariables.Report.Issue.reason or '') , { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local input = openKeyboard('PLAYER_REASON', 'Reason', 300)

					if input ~= nil then
						MenuVariables.Report.Issue.reason = input
					end
				end
			end)

			RageUI.ButtonWithStyle('Player ID', '~y~If another player is relevant~s~' .. (MenuVariables.Report.Issue.username ~= nil and ': ' .. MenuVariables.Report.Issue.username or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local input = openKeyboard('PLAYER_USERNAME', 'Player ID', 20)

					if input ~= nil then
						if tonumber(input) ~= nil then
							MenuVariables.Report.Issue.username = input
						else
							Notification_AboveMap('Invalid player ID')
						end
					end
				end
			end)

			RageUI.ButtonWithStyle((MenuVariables.Report.Issue.reason ~= nil and '~g~' or '~r~') .. 'Send Report', '~y~Make sure everything is completed', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					if MenuVariables.Report.Issue.reason ~= nil then
						MenuVariables.Report.Issue.issue = 'da'

						TriggerServerEvent('HighLife:Report:Submit', MenuVariables.Report.Issue)

						MenuVariables.Report = {
							Issue = {},
							Player = {},
						}

						Notification_AboveMap('Your ~r~report ~s~has been submitted, thank you.')
					else
						Notification_AboveMap('~o~Please fill out all the required fields.')
					end
				end
			end)
		end)

		RageUI.IsVisible(RMenu:Get('report', 'settings'), true, false, true, function()
			RageUI.ButtonWithStyle('~y~Help', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					TriggerEvent('HighLife:Guide:Open')
				end
			end)

			if HighLife.Player.Special then
				RageUI.Checkbox("Nitro", "Much faster than discord nitro...", HighLife.Player.Nitro, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
					if Active then
						HighLife.Player.Nitro = not HighLife.Player.Nitro
					end
				end)
			end

			if HighLife.Player.Debug or HighLife.Settings.Development then
				RageUI.ButtonWithStyle('~r~Show Debug Menu', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						Wait(25)
						
						RageUI.Visible(RMenu:Get('debug', 'main'), true)
					end
				end)
			end

			RageUI.Checkbox("Streamer Mode", "Hides various info to mitigate stream snipers", HighLife.Player.StreamerMode, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
				if Active then
					HighLife.Player.StreamerMode = not HighLife.Player.StreamerMode
				end
			end)

			RageUI.ButtonWithStyle('Check Playtime', "Returns your overall playtime in HighLife", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					TriggerServerEvent('HighLife:Playtime:Get')
				end
			end)
		end)

		RageUI.IsVisible(RMenu:Get('report', 'player'), true, false, true, function()
			RageUI.ButtonWithStyle('Reason', '~y~The reason you are reporting the person~s~' .. (MenuVariables.Report.Player.reason ~= nil and ':~n~~n~' .. MenuVariables.Report.Player.reason or '') , { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local input = openKeyboard('PLAYER_REASON', 'Reason', 300)

					if input ~= nil then
						MenuVariables.Report.Player.reason = input
					end
				end
			end)

			RageUI.ButtonWithStyle('Player ID', '~y~What shows above the players head~s~' .. (MenuVariables.Report.Player.username ~= nil and ': ' .. MenuVariables.Report.Player.username or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local input = openKeyboard('PLAYER_USERNAME', 'Player ID', 20)

					if input ~= nil then
						if tonumber(input) ~= nil then
							MenuVariables.Report.Player.username = input
						else
							Notification_AboveMap('Invalid player ID')
						end
					end
				end
			end)

			RageUI.ButtonWithStyle(((MenuVariables.Report.Player.reason ~= nil and MenuVariables.Report.Player.username ~= nil) and '~g~' or '~r~') .. 'Send Report', '~y~Make sure everything is completed', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					if MenuVariables.Report.Player.reason ~= nil and MenuVariables.Report.Player.username ~= nil then
						TriggerServerEvent('HighLife:Report:Submit', MenuVariables.Report.Player)

						MenuVariables.Report = {
							Issue = {},
							Player = {},
						}

						Notification_AboveMap('Your ~r~report ~s~has been submitted, thank you.')
					else
						Notification_AboveMap('~o~Please fill out all the required fields.')
					end
				end
			end)
		end)

		RageUI.IsVisible(RMenu:Get('report', 'bans'), true, false, true, function()
			if HighLife.Player.BanData ~= nil then
				for banID=1, #HighLife.Player.BanData do
					RageUI.ButtonWithStyle(string.format('~r~#%s~s~: %s', banID, (string.find(HighLife.Player.BanData[banID].reason, '%( ') and string.match(HighLife.Player.BanData[banID].reason, '(.+)%((.+)') or HighLife.Player.BanData[banID].reason)), HighLife.Player.BanData[banID].reason, { RightLabel = "" }, true)
				end
			else
				RageUI.ButtonWithStyle('~b~Squeaky Clean!', 'Screenshot this for ~r~#bad-memes ~s~so we can bring this up and laugh at a later date 😊', { RightLabel = "" }, true)
			end
		end)

		RageUI.IsVisible(RMenu:Get('report', 'warnings'), true, false, true, function()
			if HighLife.Player.WarningData ~= nil then
				for i=1, #HighLife.Player.WarningData do
					RageUI.ButtonWithStyle('~o~Warning ~s~#' .. i, HighLife.Player.WarningData[i].reason, { RightLabel = "" }, true)
				end
			else
				RageUI.ButtonWithStyle('~b~Squeaky Clean!', nil, { RightLabel = "" }, true)
			end
		end)

		Wait(1)
	end
end)