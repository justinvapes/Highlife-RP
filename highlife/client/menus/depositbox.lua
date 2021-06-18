RMenu.Add('depositbox', 'main', RageUI.CreateMenu('Deposit Box', '~b~Your Panama of Los Santos'))

RMenu.Add('depositbox', 'deposit', RageUI.CreateSubMenu(RMenu:Get('depositbox', 'main'), nil, nil))
RMenu.Add('depositbox', 'monetary', RageUI.CreateSubMenu(RMenu:Get('depositbox', 'main'), nil, nil))

CreateThread(function()
	local playerHasItems = false

	local currentWeight = 0

	while true do
		if MenuVariables.Depositbox.NearReference ~= nil then
			RageUI.IsVisible(RMenu:Get('depositbox', 'main'), true, false, true, function()
				if HighLife.Player.OwnedDepositBoxes[MenuVariables.Depositbox.NearReference] or Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].price == nil then
					if Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].price ~= nil then
						DrawStorageMonetaryButtons('depositbox', Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference])
					end
					
					if Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].limits ~= nil then
						RageUI.Separator(string.format('~y~Storage Limit: %s/%s', currentWeight, Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].limits.items))
					end

					currentWeight = GetStorageSize(MenuVariables.Depositbox.Storage.Items)

					for itemName,itemData in pairs(MenuVariables.Depositbox.Storage.Items) do
						DrawStorageItemButton('depositbox', MenuVariables.Depositbox.NearReference, itemName, itemData)
					end

					if currentWeight <= 0 then
						RageUI.ButtonWithStyle((Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].canDeposit ~= nil and '~y~No items stored' or '~o~No items to collect'), nil, {}, true)
					end

					if Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].price ~= nil or Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].canDeposit then
						RageUI.Separator()

						RageUI.ButtonWithStyle('Deposit', ((currentWeight < Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].limits.items) and 'Shed some weight' or '~r~You cannot deposit anymore items'), { RightLabel = '→→→' }, (currentWeight < Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].limits.items), nil, RMenu:Get('depositbox', 'deposit'))
					end
				else
					RageUI.ButtonWithStyle("Max Item Storage", "Item sizes may apply~y~**", { RightLabel = '~y~' .. Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].limits.items .. ' items*' }, true)

					RageUI.ButtonWithStyle("Max Deposit Amount", "The maximum amount of cash you can store", { RightLabel = '~g~$' .. comma_value(Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].limits.money) }, true)

					RageUI.Separator()

					RageUI.ButtonWithStyle("~o~Purchase", "A perfectly legal storage solution", { RightLabel = ('~g~$' .. Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].price) }, not MenuVariables.Depositbox.AwaitingCallback, function(Hovered, Active, Selected)
						if Selected then
							MenuVariables.Depositbox.AwaitingCallback = true

							TriggerServerEvent('HighLife:Storage:Purchase', 'depositbox', MenuVariables.Depositbox.NearReference)
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('depositbox', 'deposit'), true, false, true, function()
				for itemName,itemData in pairs(HighLife.Player.Inventory.Items) do
					DrawInventoryItemButton('depositbox', MenuVariables.Depositbox.NearReference, itemName, itemData)

					playerHasItems = true
				end

				if not playerHasItems then
					RageUI.ButtonWithStyle('~y~No items to store', nil, { RightLabel = nil }, true)
				end
			end)

			RageUI.IsVisible(RMenu:Get('depositbox', 'monetary'), true, false, true, function()
				DrawStorageMonetaryDepositButtons('depositbox', MenuVariables.Depositbox.NearReference)
			end)
		end

		Wait(1)
	end
end)