RMenu.Add('tattoo', 'main', RageUI.CreateMenu('Tattoo Parlor', "~y~We know best, you do not"))

RMenu.Add('tattoo', 'left_arm', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Left Arm", nil))
RMenu.Add('tattoo', 'right_arm', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Right Arm", nil))

RMenu.Add('tattoo', 'left_leg', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Left Leg", nil))
RMenu.Add('tattoo', 'right_leg', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Right Leg", nil))

RMenu.Add('tattoo', 'head', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Head", nil))
RMenu.Add('tattoo', 'torso', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Torso", nil))

RMenu.Add('tattoo', 'special', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "Special", "~y~Shiny"))

RMenu.Add('tattoo', 'remove', RageUI.CreateSubMenu(RMenu:Get('tattoo', 'main'), "~o~Remove Tattoos", "For those 'Oopsie' moments"))

CreateThread(function()
	local canAdd = true
	local canAddTattoo = true
	local enableThisTattoo = true

	local tattooCount = 0

	local canBreakSub = false

	while true do
		if MenuVariables.Tattoo.isOpen then
			RageUI.IsVisible(RMenu:Get('tattoo', 'main'), true, false, true, function()
				tattooCount = 0

				for k,v in pairs(HighLife.Player.Tattoos) do
					tattooCount = tattooCount + 1
				end

				RageUI.ButtonWithStyle('Left Arm', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'left_arm'))
				RageUI.ButtonWithStyle('Right Arm', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'right_arm'))

				RageUI.ButtonWithStyle('Left Leg', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'left_leg'))
				RageUI.ButtonWithStyle('Right Leg', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'right_leg'))

				RageUI.ButtonWithStyle('Head', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'head'))
				RageUI.ButtonWithStyle('Torso', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'torso'))

				if HighLife.Player.Special then
					RageUI.ButtonWithStyle('Special', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'special'))
				end

				if tattooCount > 0 then
					RageUI.ButtonWithStyle('~o~Remove Tattoos', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('tattoo', 'remove'))
				end

				PreviewTattoo = nil
			end)

			RageUI.IsVisible(RMenu:Get('tattoo', 'remove'), true, false, true, function()
				for pTattooHash,pTattooCollection in pairs(HighLife.Player.Tattoos) do
					canBreakSub = false

					for k,v in pairs(Config.Tattoos.Options) do
						for i=1, #v.tattoos do
							if v.tattoos[i].hash == pTattooHash then
								RageUI.ButtonWithStyle('~r~Remove ~s~' .. (GetLabelText(v.tattoos[i].name) ~= 'NULL' and GetLabelText(v.tattoos[i].name) or v.tattoos[i].name) .. ' (' .. v.title .. ')', nil, { RightLabel = '~g~$' .. comma_value(Config.Tattoos.RemovePrice) }, true, function(Hovered, Active, Selected)
									if Selected then
										TriggerServerEvent('HighLife:Tattoos:Check', 'remove', v.tattoos[i].collection, v.tattoos[i].hash, Config.Tattoos.RemovePrice)
									end
								end)

								canBreakSub = true

								break
							end
						end

						if canBreakSub then
							break
						end
					end
				end
			end)

			for _,thisTattooType in pairs(Config.Tattoos.Options) do
				RageUI.IsVisible(RMenu:Get('tattoo', thisTattooType.menuName), true, false, true, function()
					if MenuVariables.Tattoo.HiddenMenuComponents[thisTattooType.menuName] == nil then
						MenuVariables.Tattoo.HiddenMenuComponents[thisTattooType.menuName] = true

						if thisTattooType.hide_components ~= nil then
							for componentType,componentData in pairs(thisTattooType.hide_components) do
								SetPedComponentVariation(HighLife.Player.Ped, componentType, (MenuVariables.Tattoo.isMale and componentData.male or componentData.female), 0, 2)
							end
						end
					end

					for _,tattooData in pairs(thisTattooType.tattoos) do
						canAddTattoo = true
						enableThisTattoo = true

						if MenuVariables.Tattoo.isMale then
							if string.match(tattooData.hash, '_F') then
								canAddTattoo = false
							end
						else
							if string.match(tattooData.hash, '_M') then
								canAddTattoo = false
							end
						end

						if canAddTattoo then
							for k,v in pairs(HighLife.Player.Tattoos) do
								if k == tattooData.hash then
									enableThisTattoo = false

									break
								end
							end

							RageUI.ButtonWithStyle((GetLabelText(tattooData.name) ~= 'NULL' and GetLabelText(tattooData.name) or tattooData.name), nil, { RightLabel = '~g~$' .. comma_value((tattooData.priceModifier ~= nil and Config.Tattoos.BasePrice * tattooData.priceModifier or Config.Tattoos.BasePrice)) }, enableThisTattoo, function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent('HighLife:Tattoos:Check', 'add', tattooData.collection, tattooData.hash, tattooData.price or Config.Tattoos.BasePrice)
								end

								if Active then
									if MenuVariables.Tattoo.Preview ~= nil then
										if MenuVariables.Tattoo.Preview.hash ~= tattooData.hash then
											MenuVariables.Tattoo.Preview = {
												collection = tattooData.collection,
												hash = tattooData.hash
											}

											UpdatePlayerDecorations()
										end
									else
										MenuVariables.Tattoo.Preview = {
											collection = tattooData.collection,
											hash = tattooData.hash
										}

										UpdatePlayerDecorations()
									end
								end
							end)
						else
							tattooData.skip = true
						end
					end
				end)
			end
		end

		Wait(1)
	end
end)