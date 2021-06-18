local removeThis = true

RMenu.Add('inventory', 'main', RageUI.CreateMenu("Pockets", "~b~What's in your pants?"))

RMenu.Add('inventory', 'money', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), 'Cash', nil))

RMenu.Add('inventory', 'skills', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), 'Skills', ("~y~99 or bust" .. (removeThis and ' ~s~- ~b~Not done yet!' or ''))))

RMenu.Add('inventory', 'items', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), 'Items', 'Your tricks and trinkets'))
RMenu.Add('inventory', 'item', RageUI.CreateSubMenu(RMenu:Get('inventory', 'items'), 'ITEM_NAME', nil))

RMenu.Add('inventory', 'identification', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), 'Identification', 'What makes you, you.'))
RMenu.Add('inventory', 'licenses', RageUI.CreateSubMenu(RMenu:Get('inventory', 'identification'), 'Licenses', 'Legal documents'))

function IsAnyInventoryMenuVisible()
	return RageUI.Visible(RMenu:Get('inventory', 'main')) or RageUI.Visible(RMenu:Get('inventory', 'money')) or RageUI.Visible(RMenu:Get('inventory', 'items')) or RageUI.Visible(RMenu:Get('inventory', 'item')) or RageUI.Visible(RMenu:Get('inventory', 'identification')) or RageUI.Visible(RMenu:Get('inventory', 'licenses')) or RageUI.Visible(RMenu:Get('inventory', 'skills'))
end

CreateThread(function()
	local hasItems = false
	local hasLicenses = false

	local handingID = false

	while true do
		if HighLife.Player.IsInventoryVisible then
			hasItems = false
			hasLicenses = false

			RageUI.IsVisible(RMenu:Get('inventory', 'main'), true, false, true, function()
				RageUI.ButtonWithStyle('~g~Cash', '~g~$$$', { RightLabel = string.format('$%s', comma_value(HighLife.Player.Inventory.Monetary.cash)), Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, true, function(Hovered, Active, Selected)
					if Selected then
						RMenu:Get('inventory', 'money'):SetTitle('Cash')

						MenuVariables.Inventory.MoneyType = 'cash'
					end
				end, RMenu:Get('inventory', 'money'))

				RageUI.ButtonWithStyle('~r~Dirty Cash', '~r~$$$', { RightLabel = string.format('$%s', comma_value(HighLife.Player.Inventory.Monetary.dirty) ), Color = { LabelColor = { R = 203, G = 57, B = 67 } } }, true, function(Hovered, Active, Selected)
					if Selected then
						RMenu:Get('inventory', 'money'):SetTitle('Dirty Cash')

						MenuVariables.Inventory.MoneyType = 'dirty'
					end
				end, RMenu:Get('inventory', 'money'))

				RageUI.Separator()

				RageUI.ButtonWithStyle('Skills', "Making you a better you", { RightLabel = "→→→" }, true, nil, RMenu:Get('inventory', 'skills'))
				RageUI.ButtonWithStyle('Identity', "What makes you, you.", { RightLabel = "→→→" }, true, nil, RMenu:Get('inventory', 'identification'))

				RageUI.ButtonWithStyle('~y~Hand ID', "'Give' someone your ID", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if not handingID then
							handingID = true

							if IsAnyJobs({'police', 'fib'}) then
								local characterData = nil

								for _,thisCharacterData in pairs(HighLife.Player.CharacterData) do
									if thisCharacterData.reference == HighLife.Player.CurrentCharacterReference then
										characterData = thisCharacterData

										break
									end
								end

								if characterData ~= nil then
									if IsJob('police') then
										TriggerServerEvent('HighLife:Player:MeAction', string.format("~y~shows ID (~b~%s | %s - LSPD~y~)", HighLife.Other.JobStatData.current[HighLife.Player.Job.name].data.callsign, (characterData.name.first .. ' ' .. characterData.name.last)))
									else
										TriggerServerEvent('HighLife:Player:MeAction', string.format("~y~shows ID (~r~Special Agent %s - FIB~y~)", characterData.name.last))
									end
								end
							else
								TriggerServerEvent('HighLife:Player:MeAction', "~y~hands ID")
							end

							Citizen.SetTimeout(5000, function()
								handingID = false
							end)
						end
					end
				end)

				RageUI.Separator()

				RageUI.ButtonWithStyle('~b~Items', "What you got there, son?", { RightLabel = "→→→" }, true, nil, RMenu:Get('inventory', 'items'))
			end)

			RageUI.IsVisible(RMenu:Get('inventory', 'identification'), true, false, true, function()
				RageUI.ButtonWithStyle('Name', 'Who you are.', { RightLabel = string.format('%s %s', HighLife.Player.CurrentCharacter.name.first, HighLife.Player.CurrentCharacter.name.last) }, true)
				RageUI.ButtonWithStyle('Birthday', 'When it all started', { RightLabel = string.format('%s/%s/%s', HighLife.Player.CurrentCharacter.dob.day, HighLife.Player.CurrentCharacter.dob.month, HighLife.Player.CurrentCharacter.dob.year) }, true)
				RageUI.ButtonWithStyle('Job', 'What you do', { RightLabel = (Config.Jobs[HighLife.Player.Job.name] ~= nil and (Config.Jobs[HighLife.Player.Job.name].MenuName ~= nil and Config.Jobs[HighLife.Player.Job.name].MenuName or string.capitalize(HighLife.Player.Job.name)) or string.capitalize(HighLife.Player.Job.name)) }, true)
				
				RageUI.Separator()

				RageUI.ButtonWithStyle('Bank Account ID', 'Useful for others to know', { RightLabel = string.format('~b~%s', (HighLife.Player.StreamerMode and 'Hidden due to SM' or HighLife.Player.BankID)), }, true)

				RageUI.ButtonWithStyle('Licenses', "Legal documents", { RightLabel = "→→→" }, true, nil, RMenu:Get('inventory', 'licenses'))
			end)
			
			RageUI.IsVisible(RMenu:Get('inventory', 'licenses'), true, false, true, function()
				for licenseName,hasLicense in pairs(HighLife.Player.Licenses) do
					if hasLicense then
						hasLicenses = true

						RageUI.ButtonWithStyle(Config.Licenses[licenseName].name, (Config.Licenses[licenseName].description ~= nil and Config.Licenses[licenseName].description or nil), {}, true)
					end
				end

				if not hasLicenses then
					RageUI.ButtonWithStyle('~b~You have no licenses.', nil, {}, true)
				end
			end)

			RageUI.IsVisible(RMenu:Get('inventory', 'items'), true, false, true, function()
				for itemName,itemData in pairs(HighLife.Player.Inventory.Items) do
					if itemData.smells then
						DecorSetBool(HighLife.Player.Ped, 'Entity.HasDrugs', true)
					end

					if itemData.ammo ~= nil then
						hasItems = true

						RageUI.ButtonWithStyle(string.format('%s%s%s', (HighLife.Player.Inventory.Items[itemName].ammo ~= nil and '~o~' or ''), HighLife.Player.Inventory.Items[itemName].name, (HighLife.Player.Inventory.Items[itemName].amount ~= nil and ' (x' .. HighLife.Player.Inventory.Items[itemName].amount .. ')' or '')), (HighLife.Player.Inventory.Items[itemName].ammo ~= nil and string.format('%s rounds of ammo', GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(itemName))) or nil), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								RMenu:Get('inventory', 'item'):SetTitle(HighLife.Player.Inventory.Items[itemName].name)

								MenuVariables.Inventory.CurrentItem = itemName
							end
						end, RMenu:Get('inventory', 'item'))
					end
				end

				if hasItems then
					RageUI.Separator()
				end

				for itemName,itemData in pairs(HighLife.Player.Inventory.Items) do
					hasItems = true

					if itemData.ammo == nil then
						RageUI.ButtonWithStyle(string.format('%s%s%s', (HighLife.Player.Inventory.Items[itemName].ammo ~= nil and '~o~' or ''), HighLife.Player.Inventory.Items[itemName].name, (HighLife.Player.Inventory.Items[itemName].amount ~= nil and ' (x' .. HighLife.Player.Inventory.Items[itemName].amount .. ')' or '')), (HighLife.Player.Inventory.Items[itemName].ammo ~= nil and string.format('%s rounds of ammo', GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(itemName))) or nil), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								RMenu:Get('inventory', 'item'):SetTitle(HighLife.Player.Inventory.Items[itemName].name)

								MenuVariables.Inventory.CurrentItem = itemName
							end
						end, RMenu:Get('inventory', 'item'))
					end
				end

				if not hasItems then
					RageUI.ButtonWithStyle('~b~You have nothing.', nil, {}, true)
				end
			end)

			RageUI.IsVisible(RMenu:Get('inventory', 'item'), true, false, true, function()
				if MenuVariables.Inventory.CurrentItem ~= nil and HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem] ~= nil then
					if HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].usable then
						RageUI.ButtonWithStyle(string.format('~g~%s', (Config.Storage.Inventory.UseDialogue[MenuVariables.Inventory.CurrentItem] ~= nil and Config.Storage.Inventory.UseDialogue[MenuVariables.Inventory.CurrentItem] or 'Use')), nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent('esx:useItem', MenuVariables.Inventory.CurrentItem)
							end
						end)
					end

					RageUI.ButtonWithStyle('Give', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Active then
							if not HighLife.Player.StreamerMode then
								local player, distance = GetClosestPlayer()
								
								if distance ~= -1 and distance < 2 then
									DrawMarker(2, ((IsPedInAnyVehicle(GetPlayerPed(player)) and GetPedBoneCoords(GetPlayerPed(player), 79, vector3(0, 0, 0.0)) or GetEntityCoords(GetPlayerPed(player))) + vector3(0.0, 0.0, 1.33)), 0.0, 0.0, 0.0, vector3(0.0, 180.0, 0.0), 0.5, 0.5, 0.5, 255, 255, 255, 60, true, true, 2, false, false, false, false)
								end
							end
						end

						if Selected then
							local giveAmount = 1

							local player, distance = GetClosestPlayer()

							local thisWeaponAmmoCount = (HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].ammo ~= nil and GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(MenuVariables.Inventory.CurrentItem)) or nil)

							if distance ~= -1 and distance < 2 then
								if HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].ammo ~= nil then
									-- Weapon
									
									if thisWeaponAmmoCount > 0 then
										giveAmount = 1

										if thisWeaponAmmoCount > 1 then
											local input = openKeyboard('GIVE_ITEM', 'Amount of ammo to give (Max: ' .. thisWeaponAmmoCount .. ')')

											if input ~= nil and tonumber(input) ~= nil then
												giveAmount = tonumber(input)
											else
												giveAmount = nil
											end
										end
									else
										giveAmount = 0
									end
								else
									if HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].amount > 1 then
										local input = openKeyboard('GIVE_ITEM', 'Amount to give (Max: ' .. HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].amount .. ')')

										if input ~= nil and tonumber(input) ~= nil then
											giveAmount = tonumber(input)
										else
											giveAmount = nil
										end
									end
								end

								if giveAmount ~= nil and giveAmount > -1 then
									if thisWeaponAmmoCount ~= nil then
										if giveAmount > thisWeaponAmmoCount then
											giveAmount = thisWeaponAmmoCount
										end

										SetPedAmmo(HighLife.Player.Ped, GetHashKey(MenuVariables.Inventory.CurrentItem), (thisWeaponAmmoCount - giveAmount))
									end

									TriggerServerEvent('HighLife:Player:MeAction', '~y~hands over an item')

									TriggerServerEvent('HInventory:GiveItem', GetPlayerServerId(player), (HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].ammo ~= nil and 'weapon' or 'item'), MenuVariables.Inventory.CurrentItem, giveAmount)
								end
							else
								Notification_AboveMap('No one nearby to give to')
							end
						end
					end)

					if HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].ammo ~= nil and GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(MenuVariables.Inventory.CurrentItem)) > 0 then
						RageUI.ButtonWithStyle('~o~Give Ammo', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Active then
								local player, distance = GetClosestPlayer()

								if distance ~= -1 and distance < 2 then
									DrawMarker(2, GetEntityCoords(GetPlayerPed(player)) + vector3(0.0, 0.0, 1.33), 0.0, 0.0, 0.0, vector3(0.0, 180.0, 0.0), 0.5, 0.5, 0.5, 255, 255, 255, 100, true, true, 2, false, false, false, false)
								end
							end

							if Selected then
								local giveAmount = 1

								local player, distance = GetClosestPlayer()

								local thisWeaponAmmoCount = GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(MenuVariables.Inventory.CurrentItem))

								if distance ~= -1 and distance < 2 then
									if thisWeaponAmmoCount > 0 then
										giveAmount = 1

										if thisWeaponAmmoCount > 1 then
											local input = openKeyboard('GIVE_ITEM', 'Amount of ammo to give (Max: ' .. thisWeaponAmmoCount .. ')')

											if input ~= nil and tonumber(input) ~= nil then
												giveAmount = tonumber(input)
											else
												giveAmount = nil
											end
										end
									else
										giveAmount = 0
									end

									if giveAmount ~= nil and giveAmount > -1 then
										if giveAmount > thisWeaponAmmoCount then
											giveAmount = thisWeaponAmmoCount
										end

										SetPedAmmo(HighLife.Player.Ped, GetHashKey(MenuVariables.Inventory.CurrentItem), (thisWeaponAmmoCount - giveAmount))

										TriggerServerEvent('HighLife:Player:MeAction', '~y~hands over ammo')

										TriggerServerEvent('HInventory:GiveAmmo', GetPlayerServerId(player), MenuVariables.Inventory.CurrentItem, giveAmount)
									end
								else
									Notification_AboveMap('No one nearby to give ammo to')
								end
							end
						end)
					end

					if HighLife.Player.Debug then
						RageUI.ButtonWithStyle('~o~Drop', 'thanks to that one guy who doubted dropping items would be a thing with no container system 🤡', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								RageUI.CloseAll()
							end
						end)
					end

					if HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].rare then
						RageUI.Separator('~y~Rare Item')
					end

					if HighLife.Player.Inventory.Items[MenuVariables.Inventory.CurrentItem].isIllegal then
						RageUI.Separator('~r~Illegal Item')
					end
				else
					RageUI.Visible(RMenu:Get('inventory', 'item'), false)

					RageUI.Visible(RMenu:Get('inventory', 'items'), true)
				end
			end)

			RageUI.IsVisible(RMenu:Get('inventory', 'skills'), true, false, true, function()
				if HighLife.Player.Skills ~= nil then
					for skillName,skillPoints in pairs(Config.Skills) do
						RageUI.ButtonWithStyle(skillName, (Config.Skills[skillName].Description ~= nil and Config.Skills[skillName].Description or string.format('Your skill in %s', skillName)), { RightLabel = (HighLife.Player.Debug and string.format('L: %s, LP: %s, UL: %s', HighLife.Skills:GetSkillLevel(skillName).level, HighLife.Skills:GetSkillLevel(skillName).points, HighLife.Skills:GetSkillLevel(skillName).useful_level) or string.format('Level: ~y~%s', HighLife.Skills:GetSkillLevel(skillName).level)) }, true)
					end
				end
			end)

			RageUI.IsVisible(RMenu:Get('inventory', 'money'), true, false, true, function()
				RageUI.ButtonWithStyle('Give', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Active then
						if not HighLife.Player.StreamerMode then
							local player, distance = GetClosestPlayer()
							
							if distance ~= -1 and distance < 2 then
								DrawMarker(2, ((IsPedInAnyVehicle(GetPlayerPed(player)) and GetPedBoneCoords(GetPlayerPed(player), 79, vector3(0, 0, 0.0)) or GetEntityCoords(GetPlayerPed(player))) + vector3(0.0, 0.0, 1.33)), 0.0, 0.0, 0.0, vector3(0.0, 180.0, 0.0), 0.5, 0.5, 0.5, 255, 255, 255, 60, true, true, 2, false, false, false, false)
							end
						end
					end

					if Selected then
						local giveAmount = 0

						local player, distance = GetClosestPlayer()

						if distance ~= -1 and distance < 2 then
							if HighLife.Player.Inventory.Monetary[MenuVariables.Inventory.MoneyType] > 1 then
								local input = openKeyboard('GIVE_MONEY', string.format('Amount of %s to give (Max: %s$%s~s~)', MenuVariables.Inventory.MoneyType, (MenuVariables.Inventory.MoneyType == 'cash' and '~g~' or '~r~'), comma_value(HighLife.Player.Inventory.Monetary[MenuVariables.Inventory.MoneyType])))

								if input ~= nil and tonumber(input) ~= nil then
									giveAmount = tonumber(input)
								else
									giveAmount = nil
								end
							end

							if giveAmount ~= nil and HighLife.Player.Inventory.Monetary[MenuVariables.Inventory.MoneyType] >= giveAmount then
								TriggerServerEvent('HighLife:Player:MeAction', '~y~hands over cash')

								TriggerServerEvent('HInventory:GiveCash', GetPlayerServerId(player), MenuVariables.Inventory.MoneyType, giveAmount)
							end
						else
							Notification_AboveMap('No one nearby to give money to')
						end
					end
				end)
			end)

			if HighLife.Player.SwitchingCharacters or HighLife.Player.Dead or HighLife.Player.Cuffed or GetIsInDetention() or HighLife.Player.Handsup then
				RageUI.CloseAll()
			end

			if not IsAnyInventoryMenuVisible() then
				HighLife.Player.IsInventoryVisible = false
			end
		end

		Wait(1)
	end
end)