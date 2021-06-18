local processingPercent = nil

function DrawStorageMonetaryButtons(storageType, monetaryLimits)
	RageUI.ButtonWithStyle("Cash", "Max Total Amount: ~g~$" .. comma_value(monetaryLimits.limits.money), { RightLabel = "$" .. comma_value(MenuVariables[string.capitalize(storageType)].Storage.Monetary.cash), Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, true, function(Hovered, Active, Selected)
		if Selected then
			MenuVariables[string.capitalize(storageType)].MoneyType = 'cash'
		end
	end, RMenu:Get(storageType, 'monetary'))

	RageUI.ButtonWithStyle("Dirty Money", "Max Total Amount: ~r~$" .. comma_value(monetaryLimits.limits.money), { RightLabel = "$" .. comma_value(MenuVariables[string.capitalize(storageType)].Storage.Monetary.dirty), Color = { LabelColor = { R = 203, G = 57, B = 67 } } }, true, function(Hovered, Active, Selected)
		if Selected then
			MenuVariables[string.capitalize(storageType)].MoneyType = 'dirty'
		end
	end, RMenu:Get(storageType, 'monetary'))
end

function DrawStorageMonetaryDepositButtons(storageType, storageReference)
	RageUI.ButtonWithStyle("Withdraw", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
		if Selected then
			local inputMonetary = openKeyboard('WITHDRAW_CASH', 'Amount of' .. (MenuVariables[string.capitalize(storageType)].MoneyType == 'dirty' and ' dirty' or ' ') .. 'cash to withdraw (Max: $' .. comma_value(MenuVariables[string.capitalize(storageType)].Storage.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType]) .. '~s~)', nil, nil, not MenuVariables[string.capitalize(storageType)].AwaitingCallback)

			if inputMonetary ~= nil then
				if tonumber(inputMonetary) ~= nil and tonumber(inputMonetary) > 0 then
					MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

					if MenuVariables[string.capitalize(storageType)].Storage ~= nil then
						if MenuVariables[string.capitalize(storageType)].Storage.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType] ~= nil then
							if tonumber(inputMonetary) > MenuVariables[string.capitalize(storageType)].Storage.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType] then
								inputMonetary = tonumber(MenuVariables[string.capitalize(storageType)].Storage.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType])
							end
						end
					end

					TriggerServerEvent('HighLife:Storage:RemoveItem', storageType, storageReference, 'money', MenuVariables[string.capitalize(storageType)].MoneyType, tonumber(inputMonetary))
				else
					Notification_AboveMap('MISC_MUSTNUMBER')
				end
			end
		end
	end)

	RageUI.ButtonWithStyle("Deposit", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
		if Selected then
			local inputMonetary = openKeyboard('DEPOSIT_CASH', 'Amount of' .. (MenuVariables[string.capitalize(storageType)].MoneyType == 'dirty' and ' dirty' or ' ') .. 'cash to deposit (Available: $' .. comma_value(HighLife.Player.Inventory.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType]) .. '~s~)', nil, nil, not MenuVariables[string.capitalize(storageType)].AwaitingCallback)

			if inputMonetary ~= nil then
				if tonumber(inputMonetary) ~= nil and tonumber(inputMonetary) > 0 then
					MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

					if HighLife.Player.Inventory.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType] ~= nil then
						if tonumber(inputMonetary) > HighLife.Player.Inventory.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType] then
							inputMonetary = tonumber(HighLife.Player.Inventory.Monetary[MenuVariables[string.capitalize(storageType)].MoneyType])
						end
					end

					TriggerServerEvent('HighLife:Storage:AddItem', storageType, storageReference, 'money', MenuVariables[string.capitalize(storageType)].MoneyType, tonumber(inputMonetary))
				else
					Notification_AboveMap('MISC_MUSTNUMBER')
				end
			end
		end
	end)
end

function DrawStorageItemButton(storageType, storageReference, itemName, itemData)
	if itemData.processing ~= nil then
		if MenuVariables.Property.UpdateEpoch == nil then
			MenuVariables.Property.UpdateEpoch = true

			HighLife.Player.LastEpochTime = itemData.processing
		end

		processingPercent = math.floor((Config.Storage.Property[storageReference.propertyType].process[itemData.pre_name].time - HighLife.Player.LastEpochTime) / Config.Storage.Property[storageReference.propertyType].process[itemData.pre_name].time * 100.0)

		if processingPercent > 100 then
			processingPercent = 100
		end
	end

	RageUI.ButtonWithStyle((itemData.processing ~= nil and (processingPercent >= 100 and string.format('%s ~s~- ~g~Completed', itemData.name) or (string.format('%s ~s~- ~r~Processing~s~: %s', itemData.name, processingPercent) .. '%')) or string.format('%s%s ~s~(x%s)', (itemData.ammo ~= nil and '~o~' or '~s~'), itemData.name, itemData.amount)), (itemData.processing ~= nil and (processingPercent >= 100 and '~g~Ready to bash.' or '~o~Come back soon.') or (itemData.ammo ~= nil and string.format('~y~%s rounds of ammo', itemData.ammo) or nil)), { RightLabel = (itemData.processing ~= nil and (processingPercent >= 100 and '→→→' or nil) or nil) }, ((itemData.processing ~= nil and (processingPercent == 100) or (itemData.processing == nil and not MenuVariables[string.capitalize(storageType)].AwaitingCallback))), function(Hovered, Active, Selected)
		if Selected then
			if itemData.amount > 1 or (itemData.ammo ~= nil) then
				local inputAmmo = nil
				local inputCount = nil

				if itemData.ammo ~= nil and not IsItemParachute(itemName) then
					if itemData.ammo > 1 then
						inputAmmo = openKeyboard('AMMO_AMOUNT', 'Amount of ammo to withdraw (Max: ' .. itemData.ammo .. ')', nil, nil, true)
					else
						inputAmmo = itemData.ammo
					end

					if inputAmmo ~= nil and tonumber(inputAmmo) ~= nil and tonumber(inputAmmo) > -1 then
						MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

						if tonumber(inputAmmo) > itemData.ammo then
							inputAmmo = itemData.ammo
						end

						TriggerServerEvent('HighLife:Storage:RemoveItem', storageType, storageReference, 'weapon', itemName, 1, inputAmmo)
					end
				else
					if itemData.amount > 1 then
						inputCount = openKeyboard('WITHDRAW_ITEM', 'Amount of ' .. itemData.name ..  ' to withdraw (Max: ' .. itemData.amount .. ')', nil, nil, true)
					else
						inputCount = 1
					end

					if inputCount ~= nil and tonumber(inputCount) ~= nil and tonumber(inputCount) > -1 then
						MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

						TriggerServerEvent('HighLife:Storage:RemoveItem', storageType, storageReference, 'item', itemName, tonumber(inputCount))
					else
						Notification_AboveMap('MISC_MUSTNUMBER')
					end
				end
			else
				MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

				TriggerServerEvent('HighLife:Storage:RemoveItem', storageType, storageReference, 'item', itemName, 1)
			end

			if itemData.smells then
				DecorSetBool(HighLife.Player.Ped, 'Entity.HasDrugs', true)

				if storageType == 'trunk' then
					if MenuVariables.Trunk.CurrentVehicle ~= nil and MenuVariables.Trunk.CurrentVehicle.entity ~= nil then
						DecorSetBool(MenuVariables.Trunk.CurrentVehicle.entity, 'Entity.HasDrugs', true)
					end
				end
			end
		end
	end)
end

function DrawInventoryItemButton(storageType, storageReference, itemName, itemData)
	RageUI.ButtonWithStyle(string.format('%s%s ~s~(x%s)', (itemData.ammo ~= nil and '~o~' or ''), itemData.name, itemData.amount or 1), (itemData.ammo ~= nil and string.format('~y~%s rounds of ammo', GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(itemName))) or nil), { RightLabel = nil }, not MenuVariables[string.capitalize(storageType)].AwaitingCallback, function(Hovered, Active, Selected)
		if Selected then
			local inputAmmo = nil
			local inputCount = nil
			
			local thisAmmoCount = (itemData.ammo ~= nil and GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(itemName)) or nil)

			if itemData.ammo ~= nil and not IsItemParachute(itemName) then
				if thisAmmoCount > 1 then
					inputAmmo = openKeyboard('AMMO_AMOUNT', 'Amount of ammo to deposit (Max: ' .. thisAmmoCount .. ')', nil, nil, true)
				else
					inputAmmo = thisAmmoCount
				end

				if inputAmmo ~= nil and tonumber(inputAmmo) ~= nil and tonumber(inputAmmo) > -1 then
					MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

					if tonumber(inputAmmo) > GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(itemName)) then
						inputAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, GetHashKey(itemName))
					end

					TriggerServerEvent('HighLife:Storage:AddItem', storageType, storageReference, 'weapon', itemName, 1, tonumber(inputAmmo))
				end
			else
				if itemData.ammo == nil and itemData.amount > 1 then
					inputCount = openKeyboard('DEPOSIT_ITEM', 'Amount of ' .. itemData.name ..  ' to deposit (Max: ' .. itemData.amount .. ')', nil, nil, true)
				else
					inputCount = 1
				end

				if inputCount ~= nil and tonumber(inputCount) ~= nil then
					MenuVariables[string.capitalize(storageType)].AwaitingCallback = true

					if itemData.amount ~= nil then
						if tonumber(inputCount) > itemData.amount then
							inputCount = itemData.amount
						end
					end

					TriggerServerEvent('HighLife:Storage:AddItem', storageType, storageReference, 'item', itemName, tonumber(inputCount))
				end
			end

			if itemData.smells then
				DecorSetBool(HighLife.Player.Ped, 'Entity.HasDrugs', true)

				if storageType == 'trunk' then
					if MenuVariables.Trunk.CurrentVehicle ~= nil and MenuVariables.Trunk.CurrentVehicle.entity ~= nil then
						DecorSetBool(MenuVariables.Trunk.CurrentVehicle.entity, 'Entity.HasDrugs', true)
					end
				end
			end
		end
	end)
end