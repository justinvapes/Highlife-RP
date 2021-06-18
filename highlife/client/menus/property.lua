RMenu.Add('property', 'entry', RageUI.CreateMenu('Property', 'Your place called ~g~home.'))

RMenu.Add('property', 'storage', RageUI.CreateMenu('Storage', '~p~Your odds and ends'))

RMenu.Add('property', 'deposit', RageUI.CreateSubMenu(RMenu:Get('property', 'storage'), nil, nil))
RMenu.Add('property', 'monetary', RageUI.CreateSubMenu(RMenu:Get('property', 'storage'), nil, nil))

CreateThread(function()
	local currentWeight = 0

	local canKnock = true
	local canUpgrade = true
	local playerHasItems = false

	while true do
		if HighLife.Player.Instanced.instanceReference ~= nil or (HighLife.Other.ClosestProperty ~= nil and MenuVariables.Property.CurrentReference == HighLife.Other.ClosestProperty.reference) and not HighLife.Player.TravelProperty then
			canUpgrade = true
			playerHasItems = false

			if HighLife.Other.ClosestProperty ~= nil then
				RageUI.IsVisible(RMenu:Get('property', 'entry'), true, false, true, function()
					RageUI.ButtonWithStyle('~b~Knock', "See if anyone's home", { RightLabel = '→→→' }, canKnock, function(Hovered, Active, Selected)
						if Selected then
							canKnock = false

							TriggerServerEvent('HighLife:Property:KnockKnock', HighLife.Other.ClosestProperty.reference)

							Citizen.SetTimeout(3000, function()
								canKnock = true
							end)
						end
					end)

					RageUI.ButtonWithStyle((HighLife.Other.ClosestProperty.isEnter and '~g~Enter' or '~o~Exit'), "If you dare...", { RightLabel = '→→→' }, (HighLife.Player.Debug or (not HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].isLocked)), function(Hovered, Active, Selected)
						if Selected then
							if (HighLife.Player.Debug or not HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].isLocked) then
								if not HighLife.Other.ClosestProperty.isGarage then
									if not HighLife.Player.TravelProperty then
										if MenuVariables.Property.CurrentReference == HighLife.Other.ClosestProperty.reference then
											TravelProperty()
										end
										
										RageUI.Visible(RMenu:Get('property', 'entry'), false)
									end
								end
							else
								Notification_AboveMap('PROPERTY_DOOR_LOCKED')
							end
						end
					end)

					if HighLife.Other.ClosestProperty.isEnter and HighLife.Player.SpecialItems['ram'] and not HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].isVehicleStore then
						RageUI.ButtonWithStyle('~r~Enforce the door', "~p~daddy, not like this", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
							if Selected then
								if not HighLife.Player.Dead then
									HighLife.SpatialSound.CreateSound('RamDoor', {
										pos = HighLife.Player.Pos
									})
									
									TriggerServerEvent('HighLife:Property:EnforceTheDoor', HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].id, HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].ref)
								end
							end
						end)
					end

					RageUI.Separator()

					if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].owner ~= HighLife.Player.Identifier then
						RageUI.ButtonWithStyle('Enter Password', (HighLife.Player.Debug and "The Ryan Kraft special" or "Lock/Unlock with a password"), { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
							if Selected then
								local input_password = openKeyboard('LOCK_CODE', 'Enter the password', 20, nil, true)

								if input_password ~= nil then
									TriggerServerEvent('HighLife:Property:TryCombination', HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].id, input_password)
								end
							end
						end)
					end

					if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].owner == HighLife.Player.Identifier then
						RageUI.Checkbox('~y~Locked', 'Does what it says, dingus', HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].isLocked, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
							if Active then
								TriggerServerEvent('HighLife:Property:LockProperty', HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].id, not HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].isLocked)
							end
						end)

						RageUI.ButtonWithStyle('Change Password', "Change the property password", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
							if Selected then
								local input_password = openKeyboard('LOCK_CODE', 'Enter the NEW password', 20, nil, true)

								if input_password ~= nil then
									TriggerServerEvent('HighLife:Property:ChangeCombination', HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].id, input_password)
								end
							end
						end)
					end

					if IsJob('dynasty') then
						RageUI.Separator()

						RageUI.ButtonWithStyle('Transfer Ownership', "Give the keys to someone else", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
							if Selected then
								local ownerIDInput = openKeyboard('TRANSFER_PROPERTY', 'Transferring property (' .. string.split(HighLife.Other.ClosestProperty.reference, '_')[2] .. ') Enter the property owners ID:', nil, nil, true)

								if ownerIDInput ~= nil and tonumber(ownerIDInput) ~= nil then
									local ownerID = tonumber(ownerIDInput)

									local playerIDInput = openKeyboard('TRANSFER_PROPERTY', 'Transferring property (' .. string.split(HighLife.Other.ClosestProperty.reference, '_')[2] .. ') Enter the player ID to transfer to:', nil, nil, true)

									if playerIDInput ~= nil and tonumber(playerIDInput) ~= nil then
										local toPlayerID = tonumber(playerIDInput)

										local propertyCombination = openKeyboard('TRANSFER_PROPERTY_COMB', 'Enter the combination number (8-digit Max)', 8, nil, true)

										if propertyCombination ~= nil then
											if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].id ~= nil then
												TriggerServerEvent('HighLife:Property:Transfer', HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].id, ownerID, toPlayerID, propertyCombination)
											end
										else
											Notification_AboveMap('Incorrect password')
										end
									end
								else
									Notification_AboveMap('Not a valid player ID')
								end
							end
						end)

						RageUI.Separator('ID: ~y~' .. string.split(HighLife.Other.ClosestProperty.reference, '_')[2] .. '~s~ - Price: ~g~$' .. ((HighLife.Other.ClosestProperty) ~= nil and HighLife.Other.ClosestProperty.price or HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].price))
					end
				end)
			end

			-- Storage
			RageUI.IsVisible(RMenu:Get('property', 'storage'), true, false, true, function()
				DrawStorageMonetaryButtons('property', Config.Storage.Property[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type])

				if Config.Properties.Types[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type].upgrade ~= nil then
					for requiredItem,requiredItemCount in pairs(Config.Properties.Types[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type].upgrade.requiredItems) do
						local hasItem = false

						for itemName,itemData in pairs(MenuVariables.Property.Storage.Items) do
							if requiredItem == itemName then
								hasItem = ((type(itemData) == 'table' and (itemData.count or itemData.amount) or itemData) >= requiredItemCount)

								break
							end
						end

						if not hasItem then
							canUpgrade = false

							break
						end
					end

					if canUpgrade then
						RageUI.ButtonWithStyle('~g~Upgrade Property', "~r~Time to go deeper...", { RightLabel = '→→→' }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent('HighLife:Property:LeaveProperty', HighLife.Player.Instanced.instanceReference, true)

								TriggerServerEvent('HighLife:Property:UpgradeProperty', HighLife.Player.Instanced.instanceReference)
							end
						end)
					end
				end

				if Config.Storage.Property[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type].limits ~= nil then
					RageUI.Separator(string.format('~y~Storage Limit: %s/%s', currentWeight, Config.Storage.Property[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type].limits.items))
				end

				currentWeight = GetStorageSize(MenuVariables.Property.Storage.Items)

				for itemName,itemData in pairs(MenuVariables.Property.Storage.Items) do
					DrawStorageItemButton('property', { id = MenuVariables.Property.NearReference, propertyType = HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type }, itemName, itemData)
				end

				if currentWeight <= 0 then
					RageUI.ButtonWithStyle('~y~No items stored', nil, {}, true)
				end

				RageUI.Separator()

				RageUI.ButtonWithStyle('Deposit', ((currentWeight < Config.Storage.Property[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type].limits.items) and 'Shed some weight' or '~r~You cannot deposit anymore items'), { RightLabel = '→→→' }, (currentWeight < Config.Storage.Property[HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type].limits.items), nil, RMenu:Get('property', 'deposit'))
			end)

			RageUI.IsVisible(RMenu:Get('property', 'deposit'), true, false, true, function()
				for itemName,itemData in pairs(HighLife.Player.Inventory.Items) do
					playerHasItems = true

					DrawInventoryItemButton('property', { id = MenuVariables.Property.NearReference, propertyType = HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type }, itemName, itemData)
				end

				if not playerHasItems then
					RageUI.ButtonWithStyle('~y~No items to store', nil, { RightLabel = nil }, true)
				end
			end)

			RageUI.IsVisible(RMenu:Get('property', 'monetary'), true, false, true, function()
				DrawStorageMonetaryDepositButtons('property', { id = MenuVariables.Property.NearReference, propertyType = HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type })
			end)
		end

		Wait(1)
	end
end)