RMenu.Add('container', 'main', RageUI.CreateMenu("Container", "But what?"))

RMenu.Add('container', 'items', RageUI.CreateSubMenu(RMenu:Get('container', 'main'), "Items", nil))
RMenu.Add('container', 'weapons', RageUI.CreateSubMenu(RMenu:Get('container', 'main'), "Weapons", nil))

RMenu.Add('container', 'item', RageUI.CreateSubMenu(RMenu:Get('container', 'items'), "Container Item", nil))
RMenu.Add('container', 'item_group', RageUI.CreateSubMenu(RMenu:Get('container', 'items'), "Container Item", nil))
RMenu.Add('container', 'group_item', RageUI.CreateSubMenu(RMenu:Get('container', 'item_group'), "Container Item", nil))

RMenu.Add('container', 'weapon', RageUI.CreateSubMenu(RMenu:Get('container', 'weapons'), "Container Item", nil))
RMenu.Add('container', 'weapon_group', RageUI.CreateSubMenu(RMenu:Get('container', 'weapons'), "Container Item", nil))
RMenu.Add('container', 'group_weapon', RageUI.CreateSubMenu(RMenu:Get('container', 'weapon_group'), "Container Item", nil))

CreateThread(function()
	local lastContainer = nil
	local thisGroupContainerItems = nil

	local thisContainerItem = nil
	local thisContainerGroup = nil

	local selectedContainerItem = nil
	local selectedContainerGroup = nil

	local hasItems = false
	local hasOpened = false

	local isItemContainer = false
	local isValidInteractType = false

	while true do
		if HighLife.Container.Data[HighLife.Container.ActiveContainerReference] ~= nil and HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data ~= nil then
			if lastContainer ~= HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data then
				lastContainer = HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data

				thisGroupContainerItems = {}

				-- find multiples
				for i=1, #lastContainer do
					if thisGroupContainerItems[lastContainer[i].item] == nil then
						thisGroupContainerItems[lastContainer[i].item] = {
							count = 1,
							rendered = false
						}
					else
						thisGroupContainerItems[lastContainer[i].item].count = thisGroupContainerItems[lastContainer[i].item].count + 1
					end
				end
			end

			RageUI.IsVisible(RMenu:Get('container', 'main'), true, false, true, function()
				RageUI.ButtonWithStyle('Weight', 'Total container weight', { RightLabel = string.format('%s/%s', HighLife.Container:GetContainerWeight(HighLife.Container.Data[HighLife.Container.ActiveContainerReference]), HighLife.Container.Data[HighLife.Container.ActiveContainerReference].limits.MaxWeight) }, true)

				RageUI.Separator()

				RageUI.ButtonWithStyle('~y~Items', 'show', { RightLabel = "→→→" }, true, nil, RMenu:Get('container', 'items'))
				RageUI.ButtonWithStyle('~o~Weapons', 'show', { RightLabel = "→→→" }, true, nil, RMenu:Get('container', 'weapons'))
			end)

			RageUI.IsVisible({RMenu:Get('container', 'weapons'), RMenu:Get('container', 'items')}, true, false, true, function()
				hasItems = false

				isItemContainer = RageUI.Visible(RMenu:Get('container', 'items'))

				for itemName,groupStatus in pairs(thisGroupContainerItems) do
					thisGroupContainerItems[itemName].rendered = false
				end

				for i=1, #HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data do
					if Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] ~= nil then
						if (isItemContainer and not Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item].data_attributes.is_weapon) or (not isItemContainer and Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item].data_attributes.is_weapon) then
							if thisGroupContainerItems[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item].count > 1 and not thisGroupContainerItems[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item].rendered then
								thisGroupContainerItems[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item].rendered = true

								-- group item
								thisContainerGroup = {
									data = HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i],
									config = (Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] ~= nil and Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] or nil),
									totalWeight = HighLife.Container:GetContainerWeight(HighLife.Container.Data[HighLife.Container.ActiveContainerReference], HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item)
								}

								RageUI.ButtonWithStyle(thisContainerGroup.config.name, (thisContainerGroup.config.description or nil), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
									if Selected then
										selectedContainerGroup = thisContainerGroup

										RMenu:Get('container', ((isItemContainer and 'item' or 'weapon') .. '_group')).Index = 1

										RMenu:Get('container', ((isItemContainer and 'item' or 'weapon') .. '_group')):SetTitle(thisContainerGroup.config.name)
										RMenu:Get('container', ((isItemContainer and 'item' or 'weapon') .. '_group')):SetSubtitle((thisContainerGroup.config.description or nil))
									end
								end, RMenu:Get('container', ((isItemContainer and 'item' or 'weapon') .. '_group')))
							else
								if not thisGroupContainerItems[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item].rendered then
									thisContainerItem = {
										data = HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i],
										config = (Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] ~= nil and Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] or nil)
									}

									RageUI.ButtonWithStyle(thisContainerItem.config.name, (thisContainerItem.config.description or nil), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
										if Selected then
											selectedContainerItem = thisContainerItem

											RMenu:Get('container', (isItemContainer and 'item' or 'weapon')).Index = 1

											RMenu:Get('container', (isItemContainer and 'item' or 'weapon')):SetTitle(thisContainerItem.config.name)
											RMenu:Get('container', (isItemContainer and 'item' or 'weapon')):SetSubtitle((thisContainerItem.config.description or ''))
										end
									end, RMenu:Get('container', (isItemContainer and 'item' or 'weapon')))
								end
							end

							hasItems = true
						end
					else
						Notification_AboveMap(HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item .. ' has no valid config, this is bad report it!')
					end
				end

				if not hasItems then
					RageUI.ButtonWithStyle('No Items', 'You currently have no items', { RightLabel = '' }, true)
				end
			end)

			RageUI.IsVisible({RMenu:Get('container', 'item_group'), RMenu:Get('container', 'weapon_group')}, true, false, true, function()
				isItemContainer = RageUI.Visible(RMenu:Get('container', 'item_group'))

				if selectedContainerGroup.data ~= nil then
					if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config ~= nil then
						if Config.Items[selectedContainerGroup.data.item] == nil then
							-- check item options etc
							Notification_AboveMap(selectedContainerGroup.data.item .. ': has a valid item config') -- FIXME: well we shouldn't continue then should we
						end

						RageUI.ButtonWithStyle('Combined Weight', 'The total amount of items combined', { RightLabel = selectedContainerGroup.totalWeight }, true)
						
						RageUI.Separator()

						for interactType, interactData in pairs(Config.Containers.InteractTypes) do
							isValidInteractType = true

							if type(HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType]) == 'table' then
								isValidInteractType = false

								if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType].single == nil then
									isValidInteractType = true
								end
							end

							if isValidInteractType then
								if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType] ~= nil and HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType] then
									RageUI.ButtonWithStyle((interactData.Color ~= nil and interactData.Color or '') .. interactType, string.format('Will %s a ~y~random ~s~selection of items', string.lower(interactType)), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
										if Selected then
											local thisAmount = Config.Containers.DefaultWeight

											if selectedContainerGroup.totalWeight > Config.Containers.DefaultWeight then
												local enteredAmount = tonumber(openKeyboard('CONTAINER_TAKE_AMOUNT', string.format('The amount of %s to %s', selectedContainerGroup.config.name, string.lower(interactType))))

												if enteredAmount ~= nil then
													if enteredAmount > 0 then
														-- get the amount of favorite items, message back if invalid amount
														if enteredAmount > selectedContainerGroup.totalWeight then
															enteredAmount = math.floor(selectedContainerGroup.totalWeight)
														end

														print('got: ' .. interactType .. ', ' .. enteredAmount)

														thisAmount = math.floor(enteredAmount)

														-- TODO: Trigger the event
														-- TriggerServerEvent('HighLife:')
													end
												end
											end
										end
									end)
								end
							end
						end

						RageUI.Separator()

						-- TODO: Sort by lastUpdated
						for i=1, #HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data do
							if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item == selectedContainerGroup.data.item then
								thisContainerItem = {
									data = HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i],
									config = (Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] ~= nil and Config.Items[HighLife.Container.Data[HighLife.Container.ActiveContainerReference].data[i].item] or nil)
								}

								-- single item
								RageUI.ButtonWithStyle(thisContainerItem.config.name, (thisContainerItem.config.description or nil), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
									if Selected then
										selectedContainerItem = thisContainerItem

										RMenu:Get('container', 'group_' .. (isItemContainer and 'item' or 'weapon')).Index = 1

										RMenu:Get('container', 'group_' .. (isItemContainer and 'item' or 'weapon')):SetTitle(thisContainerItem.config.name)
										RMenu:Get('container', 'group_' .. (isItemContainer and 'item' or 'weapon')):SetSubtitle((thisContainerItem.config.description or ''))
									end
								end, RMenu:Get('container', 'group_' .. (isItemContainer and 'item' or 'weapon')))
							end
						end
					end
				end
			end)

			RageUI.IsVisible({RMenu:Get('container', 'group_item'), RMenu:Get('container', 'item'), RMenu:Get('container', 'group_weapon'), RMenu:Get('container', 'weapon')}, true, false, true, function()
				if selectedContainerItem.data ~= nil then
					if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config ~= nil then

						if HighLife.Player.Debug then
							RageUI.Separator('~r~DATA DEBUG')

							-- Get default item attributes from Config.Items
							if Config.Items[selectedContainerItem.data.item] ~= nil and Config.Items[selectedContainerItem.data.item].data_attributes ~= nil then
								for itemAttributeName, itemAttributeData in pairs(Config.Items[selectedContainerItem.data.item].data_attributes) do
									RageUI.ButtonWithStyle(itemAttributeName, string.format('Value: %s', tostring(itemAttributeData)), { RightLabel = "" }, true)
								end
							end

							RageUI.Separator('~r~ATTRIBUTE DEBUG')

							-- Get item attributes set from db attributes
							for itemAttributeName, itemAttributeData in pairs(selectedContainerItem.data.data) do
								RageUI.ButtonWithStyle(itemAttributeName, string.format('Value: %s', tostring(itemAttributeData)), { RightLabel = "" }, true)
							end
							
							RageUI.Separator()
						end

						RageUI.ButtonWithStyle('Amount', 'The weight of the object', { RightLabel = math.floor(selectedContainerItem.data.weight) .. "" }, true)

						RageUI.Separator()

						-- Enum the interaction types
						for interactType, interactData in pairs(Config.Containers.InteractTypes) do
							if type(HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType]) == 'table' then
								if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType].event ~= nil then
									RageUI.ButtonWithStyle((interactData.Color ~= nil and interactData.Color or '') .. interactType, nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
										if Selected then
											if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType].params == 'item_id' then
												TriggerServerEvent(HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType].event, selectedContainerItem.data.data.id)
											end
										end
									end)
								end
							else
								if HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType] ~= nil and HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.MenuOptions[interactType] then
									RageUI.ButtonWithStyle((interactData.Color ~= nil and interactData.Color or '') .. interactType, nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
										if Selected then
											local thisAmount = Config.Containers.DefaultWeight

											if selectedContainerItem.data.weight > Config.Containers.DefaultWeight then
												local enteredAmount = tonumber(openKeyboard('CONTAINER_TAKE_AMOUNT', string.format('The amount of %s to %s', selectedContainerItem.config.name, string.lower(interactType))))

												if enteredAmount ~= nil then
													if enteredAmount > 0 then
														if enteredAmount > selectedContainerItem.data.weight then
															enteredAmount = math.floor(selectedContainerItem.data.weight)
														end

														print('got: ' .. interactType .. ', ' .. enteredAmount)

														thisAmount = math.floor(enteredAmount)

														-- TODO: Trigger the event
														-- TriggerServerEvent('HighLife:')
													end
												end
											end
										end
									end)
								end
							end
						end
					end
				end
			end)

			-- FIXME: this will break when deposit is added
			-- FIXME: if in group item and menu updates, then what
			if not RageUI.Visible(RMenu:Get('container', 'main')) and not RageUI.Visible(RMenu:Get('container', 'items')) and not RageUI.Visible(RMenu:Get('container', 'weapons')) and not RageUI.Visible(RMenu:Get('container', 'item')) and not RageUI.Visible(RMenu:Get('container', 'item_group')) and not RageUI.Visible(RMenu:Get('container', 'group_item')) and not RageUI.Visible(RMenu:Get('container', 'weapon')) and not RageUI.Visible(RMenu:Get('container', 'weapon_group')) and not RageUI.Visible(RMenu:Get('container', 'group_weapon')) then
				-- Close the container if we're in it so we don't get future net updates
				TriggerServerEvent('HighLife:Container:ViewStatus', HighLife.Container.Data[HighLife.Container.ActiveContainerReference].reference, false)

				HighLife.Container.ActiveContainerReference = nil

				hasOpened = false
			end
		end

		Wait(1)
	end
end)