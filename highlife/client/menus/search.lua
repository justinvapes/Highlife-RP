RMenu.Add('player', 'confiscate', RageUI.CreateMenu("Confiscate", "~o~Keep your hands to yourself"))

function ConfiscatePlayerItem(itemType, item, ammo)
	local itemExists = false

	HighLife:ServerCallback('HighLife:Player:ConfiscateItem', function(newPlayerData)
		if MenuVariables.SearchMenu.ExtraData ~= nil then
			if not MenuVariables.SearchMenu.ExtraData.isLooting then
				MenuVariables.SearchMenu.PlayerData = json.decode(newPlayerData)
			else
				MenuVariables.SearchMenu.SlowPlayerData = json.decode(newPlayerData)

				MenuVariables.SearchMenu.PlayerData.money = MenuVariables.SearchMenu.SlowPlayerData.money

				if MenuVariables.SearchMenu.SlowPlayerData.accounts ~= nil then
					if MenuVariables.SearchMenu.PlayerData.accounts ~= nil then
						MenuVariables.SearchMenu.PlayerData.accounts = MenuVariables.SearchMenu.SlowPlayerData.accounts
					end
				end

				if #MenuVariables.SearchMenu.PlayerData.weapons > 0 then
					for i=1, #MenuVariables.SearchMenu.PlayerData.weapons do
						itemExists = false

						if MenuVariables.SearchMenu.PlayerData.weapons[i] ~= nil then
							for j=1, #MenuVariables.SearchMenu.SlowPlayerData.weapons do
								if MenuVariables.SearchMenu.PlayerData.weapons[i].name == MenuVariables.SearchMenu.SlowPlayerData.weapons[j].name then
									-- still exists
									itemExists = true

									break
								end
							end

							if not itemExists then
								-- remove the weapon from the playerdata
								table.remove(MenuVariables.SearchMenu.PlayerData.weapons, i)
							end
						end
					end
				end

				if #MenuVariables.SearchMenu.PlayerData.inventory > 0 then
					for i=1, #MenuVariables.SearchMenu.PlayerData.inventory do
						itemExists = false

						if MenuVariables.SearchMenu.PlayerData.inventory[i] ~= nil then
							for j=1, #MenuVariables.SearchMenu.SlowPlayerData.inventory do
								if (MenuVariables.SearchMenu.PlayerData.inventory[i].name == MenuVariables.SearchMenu.SlowPlayerData.inventory[j].name) and MenuVariables.SearchMenu.SlowPlayerData.inventory[j].count > 0 then
									-- still exists
									itemExists = true

									break
								end
							end

							if not itemExists then
								table.remove(MenuVariables.SearchMenu.PlayerData.inventory, i)
							end
						end
					end
				end
			end
		end
	end, MenuVariables.SearchMenu.ExtraData.playerID, itemType, item, ammo, MenuVariables.SearchMenu.ExtraData.isStaff, MenuVariables.SearchMenu.ExtraData.isLooting)
end

function ResetConfiscation()
	RageUI.Visible(RMenu:Get('player', 'confiscate'), false)

	MenuVariables.SearchMenu = {
		LootData = nil,
		ExtraData = nil,
		PlayerData = nil,
		SearchEntity = nil,
		SlowPlayerData = nil,
	}

	ClearPedTasks(HighLife.Player.Ped)
end

function DoesKeyValueExistInTable(thisTable, key, value)
	for i=1, #thisTable do
		if thisTable[i][key] == value then
			return true
		end
	end

	return false
end

CreateThread(function()
	local thisTotalMoney = 0

	local hasItems = false

	while true do
		if MenuVariables.SearchMenu.PlayerData ~= nil or MenuVariables.SearchMenu.SlowPlayerData ~= nil then
			RageUI.IsVisible(RMenu:Get('player', 'confiscate'), true, false, true, function()
				if MenuVariables.SearchMenu.SlowPlayerData ~= nil then
					if MenuVariables.SearchMenu.IsFinding == nil then
						MenuVariables.SearchMenu.IsFinding = true

						CreateThread(function()
							if MenuVariables.SearchMenu.SlowPlayerData ~= nil then
								MenuVariables.SearchMenu.PlayerData = {
									money = MenuVariables.SearchMenu.SlowPlayerData.money or 0,
									accounts = MenuVariables.SearchMenu.SlowPlayerData.accounts or {},
									weapons = {},
									inventory = {}
								}

								if #MenuVariables.SearchMenu.SlowPlayerData.weapons > 0 then
									for i=1, #MenuVariables.SearchMenu.SlowPlayerData.weapons do
										if MenuVariables.SearchMenu.SlowPlayerData.weapons[i] ~= nil then
											if not DoesKeyValueExistInTable(MenuVariables.SearchMenu.PlayerData.weapons, 'name', MenuVariables.SearchMenu.SlowPlayerData.weapons[i].name) then
												Wait(1000)

												if MenuVariables.SearchMenu.PlayerData ~= nil and MenuVariables.SearchMenu.SlowPlayerData ~= nil then
													table.insert(MenuVariables.SearchMenu.PlayerData.weapons, MenuVariables.SearchMenu.SlowPlayerData.weapons[i])
												end
											end

											if MenuVariables.SearchMenu.PlayerData == nil or MenuVariables.SearchMenu.SlowPlayerData == nil then
												break
											end
										end
									end
								end

								if MenuVariables.SearchMenu.SlowPlayerData ~= nil and MenuVariables.SearchMenu.PlayerData ~= nil then
									for i=1, #MenuVariables.SearchMenu.SlowPlayerData.inventory do
										if MenuVariables.SearchMenu.SlowPlayerData.inventory[i] ~= nil then
											if MenuVariables.SearchMenu.SlowPlayerData.inventory[i].count > 0 then
												if not DoesKeyValueExistInTable(MenuVariables.SearchMenu.PlayerData.inventory, 'name', MenuVariables.SearchMenu.SlowPlayerData.inventory[i].name) then
													Wait(1000)

													if MenuVariables.SearchMenu.PlayerData ~= nil and MenuVariables.SearchMenu.SlowPlayerData ~= nil  then
														table.insert(MenuVariables.SearchMenu.PlayerData.inventory, MenuVariables.SearchMenu.SlowPlayerData.inventory[i])
													end
												end
											end

											if MenuVariables.SearchMenu.PlayerData == nil or MenuVariables.SearchMenu.SlowPlayerData == nil then
												break
											end
										end
									end
								end

								if MenuVariables.SearchMenu.PlayerData ~= nil and MenuVariables.SearchMenu.SlowPlayerData ~= nil then
									MenuVariables.SearchMenu.IsFinding = false
								end
							end
						end)
					end
				end

				if MenuVariables.SearchMenu.PlayerData ~= nil then
					hasItems = false

					thisTotalMoney = MenuVariables.SearchMenu.PlayerData.money or 0

					if MenuVariables.SearchMenu.SearchEntity ~= nil then
						if DoesEntityExist(MenuVariables.SearchMenu.SearchEntity) then
							if Vdist(GetEntityCoords(MenuVariables.SearchMenu.SearchEntity), HighLife.Player.Pos) > 3.0 then
								ResetConfiscation()
							end
						else
							ResetConfiscation()
						end
					end

					if MenuVariables.SearchMenu.ExtraData ~= nil then
						if MenuVariables.SearchMenu.ExtraData.isPatdown then
							if not MenuVariables.SearchMenu.ExtraData.finishedPatdown then
								if #MenuVariables.SearchMenu.PlayerData.weapons > 0 then
									hasItems = true

									Notification_AboveMap('~o~You can feel a weapon under the suspects clothing')
								else
									Notification_AboveMap('You cannot feel any weapons on the suspect')

									RageUI.Visible(RMenu:Get('player', 'confiscate'), false)
								end

								MenuVariables.SearchMenu.ExtraData.finishedPatdown = true
							else
								if #MenuVariables.SearchMenu.PlayerData.weapons > 0 then
									hasItems = true

									for i=1, #MenuVariables.SearchMenu.PlayerData.weapons do
										RageUI.ButtonWithStyle((ESX.GetWeaponLabel(MenuVariables.SearchMenu.PlayerData.weapons[i].name) ~= nil and ESX.GetWeaponLabel(MenuVariables.SearchMenu.PlayerData.weapons[i].name) or 'Invalid Item'), (MenuVariables.SearchMenu.PlayerData.weapons[i].ammo ~= nil and string.format('%s rounds of ammunition', MenuVariables.SearchMenu.PlayerData.weapons[i].ammo) or nil), { RightLabel = string.format('~b~%s', (MenuVariables.SearchMenu.ExtraData.isLooting and 'Take' or 'Confiscate')) }, true, function(Hovered, Active, Selected)
											if Selected then
												ConfiscatePlayerItem('weapon', MenuVariables.SearchMenu.PlayerData.weapons[i].name, MenuVariables.SearchMenu.PlayerData.weapons[i].ammo)
											end
										end)
									end
								end
							end
						else
							if MenuVariables.SearchMenu.PlayerData.accounts ~= nil then
								for i=1, #MenuVariables.SearchMenu.PlayerData.accounts do
									if MenuVariables.SearchMenu.PlayerData.accounts[i].name == 'black_money' then
										thisTotalMoney = thisTotalMoney + MenuVariables.SearchMenu.PlayerData.accounts[i].money
									end
								end
							end

							if thisTotalMoney > 0 then
								hasItems = true

								RageUI.ButtonWithStyle(string.format('~g~$%s', comma_value(thisTotalMoney)), nil, { RightLabel = string.format('~b~%s', (MenuVariables.SearchMenu.ExtraData.isLooting and 'Take' or 'Confiscate')) }, true, function(Hovered, Active, Selected)
									if Selected then
										ConfiscatePlayerItem('money', nil)
									end
								end)

								RageUI.Separator()
							end

							-- Weapons
							if MenuVariables.SearchMenu.PlayerData.weapons ~= nil then
								if #MenuVariables.SearchMenu.PlayerData.weapons > 0 then
									hasItems = true

									for i=1, #MenuVariables.SearchMenu.PlayerData.weapons do
										RageUI.ButtonWithStyle((ESX.GetWeaponLabel(MenuVariables.SearchMenu.PlayerData.weapons[i].name) ~= nil and ESX.GetWeaponLabel(MenuVariables.SearchMenu.PlayerData.weapons[i].name) or 'Invalid Item'), (MenuVariables.SearchMenu.PlayerData.weapons[i].ammo ~= nil and string.format('%s rounds of ammunition', MenuVariables.SearchMenu.PlayerData.weapons[i].ammo) or nil), { RightLabel = string.format('~b~%s', (MenuVariables.SearchMenu.ExtraData.isLooting and 'Take' or 'Confiscate')) }, (not MenuVariables.SearchMenu.ExtraData.isLooting or (MenuVariables.SearchMenu.ExtraData.isLooting and not HasPedGotWeapon(HighLife.Player.Ped, MenuVariables.SearchMenu.PlayerData.weapons[i].name, false))), function(Hovered, Active, Selected)
											if Selected then
												ConfiscatePlayerItem('weapon', MenuVariables.SearchMenu.PlayerData.weapons[i].name, MenuVariables.SearchMenu.PlayerData.weapons[i].ammo)
											end
										end)
									end

									RageUI.Separator()
								end
							end

							if MenuVariables.SearchMenu.PlayerData.inventory ~= nil then
								for i=1, #MenuVariables.SearchMenu.PlayerData.inventory do
									if MenuVariables.SearchMenu.PlayerData.inventory[i].count > 0 then
										hasItems = true

										RageUI.ButtonWithStyle(string.format('%s (x%s)', MenuVariables.SearchMenu.PlayerData.inventory[i].label, MenuVariables.SearchMenu.PlayerData.inventory[i].count), nil, { RightLabel = string.format('~b~%s', (MenuVariables.SearchMenu.ExtraData.isLooting and 'Take' or 'Confiscate')) }, true, function(Hovered, Active, Selected)
											if Selected then
												ConfiscatePlayerItem('item', MenuVariables.SearchMenu.PlayerData.inventory[i].name)
											end
										end)
									end
								end
							end
						end

						if not hasItems then
							RageUI.ButtonWithStyle(((MenuVariables.SearchMenu.IsFinding ~= nil and MenuVariables.SearchMenu.IsFinding) and '~y~Searching...' or 'Nothing.'), nil, {}, true)
						end
					end
				end
			end)
		end

		Wait(1)
	end
end)