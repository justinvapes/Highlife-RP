RMenu.Add('character', 'main', RageUI.CreateMenu("Your Characters", "~o~Time to play god"))
RMenu.Add('character', 'create', RageUI.CreateSubMenu(RMenu:Get('character', 'main'), "New Character", "~o~Your new ego"))

local CharacterCount = 0
local MaxCharacters = Config.Characters.Max

local validName = nil
local isChecking = false

local upgradeData 

CreateThread(function()
	while true do
		RageUI.IsVisible(RMenu:Get('character', 'main'), true, false, true, function()
			CharacterCount = 0

			MaxCharacters = Config.Characters.Max + (HighLife.Player.Upgrades ~= nil and HighLife.Player.Upgrades.ExtraCharacterSlots or 0)

			validName = nil

			for _,characterData in pairs(HighLife.Player.CharacterData) do
				RageUI.ButtonWithStyle(characterData.name.first .. ' ' .. characterData.name.last .. ' - ' .. characterData.dob.day .. '/' .. characterData.dob.month .. '/' .. characterData.dob.year, (characterData.status.dead and "~r~This character is dead" or (HighLife.Player.CurrentCharacterReference == characterData.reference and "~g~Your current active character" or ((characterData.last_property ~= nil and characterData.last_property) and "In a ~g~property~s~" or (characterData.health_data.health <= 100 and "~o~Unconscious~s~" or "Wandering")) .. ((characterData.position ~= nil and characterData.position) and " near ~y~" .. GetStreetNameFromHashKey(GetStreetNameAtCoord(characterData.position.x, characterData.position.y, characterData.position.z)) or ""))), { RightLabel = "→→→" }, not ((HighLife.Player.CurrentCharacterReference == characterData.reference) or characterData.status.dead), function(Hovered, Active, Selected)
					if Selected then
						HighLife.Player.SwitchingCharacters = true

						TriggerServerEvent('HighLife:Character:Switch', characterData.reference)

						RageUI.CloseAll()
					end
				end)

				if not characterData.status.dead then
					CharacterCount = CharacterCount + 1
				end
			end

			if CharacterCount == 0 then
				RageUI.ButtonWithStyle("You have no characters to select", nil, { RightLabel = "" }, true)
			end

			RageUI.Separator()

			RageUI.ButtonWithStyle("Create New Character", "You have " .. ((MaxCharacters - CharacterCount) < 1 and "~r~" or "~g~") .. (MaxCharacters - CharacterCount) .. ' ~s~free character slots', { RightLabel = "→→→" }, (CharacterCount < MaxCharacters), nil, RMenu:Get('character', 'create'))
		end)

		RageUI.IsVisible(RMenu:Get('character', 'create'), true, false, true, function()
			RageUI.ButtonWithStyle('First Name', "The first name of your character", { RightLabel = (MenuVariables.Character.FirstName ~= nil and MenuVariables.Character.FirstName or "→→→") }, true, function(Hovered, Active, Selected)
				if Selected then
					local first_name = openKeyboard('CHARACTER_NAME', 'Character First Name', 15, (MenuVariables.Character.FirstName ~= nil and MenuVariables.Character.FirstName))

					if first_name ~= nil then
						if not first_name:match("%d+") and not first_name:match("%W+") then
							validName = nil

							if string.len(first_name) > 1 then
								MenuVariables.Character.FirstName = string.capitalize(string.lower(first_name))
							else
								MenuVariables.Character.FirstName = nil

								Notification_AboveMap("Your character name is too short")
							end
						else
							MenuVariables.Character.FirstName = nil
							
							Notification_AboveMap("Your character name can ~o~only ~s~contain letters")
						end
					end
				end
			end)

			RageUI.ButtonWithStyle('Last Name', "The last name of your character", { RightLabel = (MenuVariables.Character.LastName ~= nil and MenuVariables.Character.LastName or "→→→") }, true, function(Hovered, Active, Selected)
				if Selected then
					local last_name = openKeyboard('CHARACTER_NAME', 'Character First Name', 15, (MenuVariables.Character.LastName ~= nil and MenuVariables.Character.LastName))

					if last_name ~= nil then
						if not last_name:match("%d+") and not last_name:match("%W+") then
							validName = nil

							if string.len(last_name) > 1 then
								MenuVariables.Character.LastName = string.capitalize(string.lower(last_name))
							else
								MenuVariables.Character.LastName = nil

								Notification_AboveMap("Your character name is too short")
							end
						else
							MenuVariables.Character.LastName = nil

							Notification_AboveMap("Your character name can ~o~only ~s~contain letters")
						end
					end
				end
			end)

			RageUI.ButtonWithStyle('Date of Birth', "The birthdate of your character", { RightLabel = (MenuVariables.Character.DOB ~= nil and MenuVariables.Character.DOB or "") }, true, function(Hovered, Active, Selected)
				if Selected then
					local dob = openKeyboard('CHARACTER_DOB', 'Character Date of Birth - ~o~Example: ~s~30/05/1990', 10, (MenuVariables.Character.DOB ~= nil and MenuVariables.Character.DOB))

					if dob ~= nil then
						if string.match(dob, '(%d%d/%d%d/%d%d%d%d)') then
							local thisDate = string.split(dob, '/')

							if ((GetUtcTime() - tonumber(thisDate[3])) > 15) then
								if ((GetUtcTime() - tonumber(thisDate[3])) < 120) then
									if (tonumber(thisDate[2]) > 0 and tonumber(thisDate[2]) < 13) and (tonumber(thisDate[1]) > 0 and tonumber(thisDate[1]) < 32) then
										MenuVariables.Character.DOB = dob
									else
										MenuVariables.Character.DOB = nil

										Notification_AboveMap("Please enter a valid date")
									end
								else
									MenuVariables.Character.DOB = nil

									Notification_AboveMap("Too old. Take a wheelchair, senior")
								end
							else
								MenuVariables.Character.DOB = nil

								Notification_AboveMap("Your character cannot be below 16 years of age")
							end
						else
							MenuVariables.Character.DOB = nil

							Notification_AboveMap('Please follow the requested format, example: ~y~30/05/1990')
						end
					end
				end
			end)

			if MenuVariables.Character.FirstName ~= nil and MenuVariables.Character.LastName ~= nil and not isChecking and validName == nil then
				isChecking = true

				HighLife:ServerCallback('HighLife:Character:AvailableName', function(isAvailable)
					validName = isAvailable

					isChecking = false
				end, MenuVariables.Character)
			end

			RageUI.ButtonWithStyle(((MenuVariables.Character.DOB ~= nil and MenuVariables.Character.LastName ~= nil and MenuVariables.Character.FirstName ~= nil) and (validName and '~g~' or '~o~') or '~r~') .. 'Create Character', ((MenuVariables.Character.DOB ~= nil and MenuVariables.Character.LastName ~= nil and MenuVariables.Character.FirstName ~= nil) and ((validName == nil) and 'Checking...' or (validName and '~g~Ready when you are' or '~o~This name is already taken')) or '~o~Please complete all fields to continue'), { RightLabel = "→→→" }, (MenuVariables.Character.DOB ~= nil and MenuVariables.Character.LastName ~= nil and MenuVariables.Character.FirstName ~= nil and (validName ~= nil and validName)), function(Hovered, Active, Selected)
				if Selected then
					HighLife.Player.IsNewCharacter = true
					HighLife.Player.SwitchingCharacters = true

					TriggerServerEvent("HighLife:Character:Create", json.encode(MenuVariables.Character))

					MenuVariables.Character = {
						DOB = nil,
						LastName = nil,
						FirstName = nil
					}

					RageUI.CloseAll()
				end
			end)
		end)

		Wait(1)
	end
end)