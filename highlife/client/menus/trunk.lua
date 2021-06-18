RMenu.Add('trunk', 'main', RageUI.CreateMenu('Trunk', "It's still dark in there"))

RMenu.Add('trunk', 'deposit', RageUI.CreateSubMenu(RMenu:Get('trunk', 'main'), nil, nil))

RMenu.Add('trunk', 'item', RageUI.CreateSubMenu(RMenu:Get('trunk', 'main'), nil, nil))

CreateThread(function()
	local playerHasItems = false

	local currentWeight = 0
	local currentLimits = nil

	while true do
		currentLimits = nil

		if MenuVariables.Trunk.CurrentVehicle ~= nil then
			playerHasItems = false

			currentLimits = GetCustomVehicleTrunk(MenuVariables.Trunk.CurrentVehicle.entity) or Config.Storage.Trunk.VehicleClasses[GetVehicleClass(MenuVariables.Trunk.CurrentVehicle.entity)].limits

			RageUI.IsVisible(RMenu:Get('trunk', 'main'), true, false, true, function()
				RageUI.Separator(string.format('~y~Storage Limit: %s/%s', currentWeight, currentLimits.items))

				if MenuVariables.Trunk ~= nil and MenuVariables.Trunk.Storage ~= nil then
					currentWeight = GetStorageSize(MenuVariables.Trunk.Storage.Items)

					for itemName,itemData in pairs(MenuVariables.Trunk.Storage.Items) do
						if itemData.ammo ~= nil then
							DrawStorageItemButton('trunk', { plate = MenuVariables.Trunk.NearReference }, itemName, itemData)
						end
					end

					if currentWeight > 0 then
						RageUI.Separator()
					end

					for itemName,itemData in pairs(MenuVariables.Trunk.Storage.Items) do
						if itemData.ammo == nil then
							DrawStorageItemButton('trunk', { plate = MenuVariables.Trunk.NearReference }, itemName, itemData)
						end
					end
				end

				if currentWeight <= 0 then
					RageUI.ButtonWithStyle('~y~No items stored', nil, {}, true)
				end

				RageUI.Separator()

				RageUI.ButtonWithStyle((currentWeight ~= currentLimits.items and '~g~' or '~r~') .. "Deposit", (currentWeight ~= currentLimits.items and "Place items in the trunk" or "~o~The trunk is full"), { RightLabel = "→→→" }, (currentWeight ~= currentLimits.items), nil, RMenu:Get('trunk', 'deposit'))

				if HighLife.Player.HidingInTrunk or not HighLife.Player.InVehicle then
					if (GetVehicleNumberOfWheels(MenuVariables.Trunk.CurrentVehicle.entity) > 3) and (GetVehicleClass(MenuVariables.Trunk.CurrentVehicle.entity) ~= 8) and HighLife.Player.EnteringVehicle == 0 and (HighLife.Player.Dragging == nil) then
						if HighLife.Player.HidingInTrunk or not DecorGetBool(MenuVariables.Trunk.CurrentVehicle.entity, 'Vehicle.HidingInTrunk') then
							RageUI.ButtonWithStyle((HighLife.Player.HidingInTrunk and "~g~Get out" or "~o~Get in"), (((currentLimits.items - currentWeight) >= Config.Storage.Trunk.PersonWeight) and "It's dark, don't get spooked" or "~o~Not enough space to get in"), { RightLabel = "→→→" }, (HighLife.Player.HidingInTrunk or (currentLimits.items - currentWeight) >= Config.Storage.Trunk.PersonWeight), function(Hovered, Active, Selected)
								if Selected then
									if HighLife.Player.HidingInTrunk or (((currentLimits.items - currentWeight) >= Config.Storage.Trunk.PersonWeight) and not HighLife.Player.InVehicle) then
										HideInTrunk(MenuVariables.Trunk.CurrentVehicle.plate, MenuVariables.Trunk.CurrentVehicle.entity, not HighLife.Player.HidingInTrunk)
									end
								end
							end)
						end
					end
				end

				RageUI.ButtonWithStyle("~r~Close", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:Trunk:Release', MenuVariables.Trunk.NearReference, VehToNet(MenuVariables.Trunk.CurrentVehicle.entity), true)

						RageUI.CloseAll()
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('trunk', 'deposit'), true, false, true, function()
				for itemName,itemData in pairs(HighLife.Player.Inventory.Items) do
					if itemData.ammo ~= nil then
						playerHasItems = true

						DrawInventoryItemButton('trunk', { plate = MenuVariables.Trunk.NearReference, class = GetVehicleClass(MenuVariables.Trunk.CurrentVehicle.entity), limit = currentLimits.items }, itemName, itemData)
					end
				end

				if playerHasItems then
					RageUI.Separator()
				end

				for itemName,itemData in pairs(HighLife.Player.Inventory.Items) do
					if itemData.ammo == nil then
						playerHasItems = true
						
						if MenuVariables.Trunk.CurrentVehicle ~= nil then
							DrawInventoryItemButton('trunk', { plate = MenuVariables.Trunk.NearReference, class = GetVehicleClass(MenuVariables.Trunk.CurrentVehicle.entity), limit = currentLimits.items }, itemName, itemData)
						end
					end
				end

				if not playerHasItems then
					RageUI.ButtonWithStyle('~y~No items to store', nil, { RightLabel = nil }, true)
				end
			end)
		end

		Wait(1)
	end
end)