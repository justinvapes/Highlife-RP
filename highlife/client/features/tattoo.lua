local closestTattoo = nil

local PreviewTattoo = nil

local selectedItemRef = nil

RegisterNetEvent('HighLife:Tattoos:Callback')
AddEventHandler('HighLife:Tattoos:Callback', function(method, collection, hash, status)
	if status then
		if method == 'add' then
			if selectedItemRef ~= nil then
				selectedItemRef:Enabled(false)
			end

			AddTattoo(collection, hash)

			Notification_AboveMap('~g~Congratulations on your new addition')
		elseif method == 'remove' then
			if selectedItemRef ~= nil then
				selectedItemRef:Enabled(false)
			end

			RemoveTattoo(hash)

			Notification_AboveMap('~g~Don\'t make the same mistake twice!')
		end
	else
		if method == 'add' then
			Notification_AboveMap('~o~You cannot afford the tattoo')
		elseif method == 'remove' then
			Notification_AboveMap('~o~You cannot afford the removal')
		end
	end

	selectedItemRef = nil
end)

function AnyTattooMenuOpen()
	return RageUI.Visible(RMenu:Get('tattoo', 'main')) or RageUI.Visible(RMenu:Get('tattoo', 'left_arm')) or RageUI.Visible(RMenu:Get('tattoo', 'right_arm')) or RageUI.Visible(RMenu:Get('tattoo', 'left_leg')) or RageUI.Visible(RMenu:Get('tattoo', 'right_leg')) or RageUI.Visible(RMenu:Get('tattoo', 'head')) or RageUI.Visible(RMenu:Get('tattoo', 'torso')) or RageUI.Visible(RMenu:Get('tattoo', 'special')) or RageUI.Visible(RMenu:Get('tattoo', 'remove'))
end

function UpdatePlayerDecorations(removePreviews)
	ClearPedDecorations(HighLife.Player.Ped)

	for k,v in pairs(HighLife.Player.Tattoos) do
		AddPedDecorationFromHashes(HighLife.Player.Ped, GetHashKey(v), GetHashKey(k))
	end

	if removePreviews ~= nil and removePreviews then
		MenuVariables.Tattoo.Preview = nil
	end

	if MenuVariables.Tattoo.Preview ~= nil then
		local isOwned = false

		for k,v in pairs(HighLife.Player.Tattoos) do
			if k == MenuVariables.Tattoo.Preview.hash then
				isOwned = true

				break
			end
		end

		if not isOwned then
			AddPedDecorationFromHashes(HighLife.Player.Ped, MenuVariables.Tattoo.Preview.collection, MenuVariables.Tattoo.Preview.hash)
		end
	end
end

function AddTattoo(collection, name)
	HighLife.Player.Tattoos[name] = collection

	TriggerServerEvent('HighLife:Player:UpdateTattoos', json.encode(HighLife.Player.Tattoos))

	PlaySoundFrontend(-1, "Tattooing_Oneshot", "TATTOOIST_SOUNDS", 1)

	PlayBoughtSound()
end

function RemoveTattoo(name)
	HighLife.Player.Tattoos[name] = nil

	TriggerServerEvent('HighLife:Player:UpdateTattoos', json.encode(HighLife.Player.Tattoos))

	PlaySoundFrontend(-1, "Tattooing_Oneshot_Remove", "TATTOOIST_SOUNDS", 1)

	PlayBoughtSound()

	UpdatePlayerDecorations(true)
end

function InitTattooMenu()
	MenuVariables.Tattoo.isOpen = true

	TaskStandStill(HighLife.Player.Ped, -1)

	SetPedCanSwitchWeapon(HighLife.Player.Ped, false)

	MenuVariables.Tattoo.isMale = isMale()

	RageUI.Visible(RMenu:Get('tattoo', 'main'), true)
end

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		if not HighLife.Player.InVehicle then
			for i=1, #Config.Tattoos.Locations do
				if IsInInterior() and Vdist(Config.Tattoos.Locations[i], HighLife.Player.Pos) < 5.0 then
					closestTattoo = Config.Tattoos.Locations[i]

					thisTry = true

					break
				end 
			end
		end

		if not thisTry then
			closestTattoo = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local customTattooID = 1

	for i=1, #Config.Tattoos.sortTattoos do
		for k=1, #Config.Tattoos.Options do
			if Config.Tattoos.Options[k].zone == Config.Tattoos.sortTattoos[i].zone then
				if string.match(Config.Tattoos.sortTattoos[i].name, "_") and GetLabelText(Config.Tattoos.sortTattoos[i].name) == 'NULL' then
					Config.Tattoos.sortTattoos[i].name = 'Tattoo #' .. customTattooID

					customTattooID = customTattooID + 1
				end

				table.insert(Config.Tattoos.Options[k].tattoos, Config.Tattoos.sortTattoos[i])

				break
			end
		end
	end

	Wait(100)

	for i=1, #Config.Tattoos.Locations do
		local thisLocation = Config.Tattoos.Locations[i]

		local blip = AddBlipForCoord(thisLocation)

		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 23)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('TATTOO_BLIP')
		EndTextCommandSetBlipName(blip)
	end

	while true do
		if closestTattoo ~= nil then
			if HighLife.Player.Job.name == 'unemployed' then
				if not AnyTattooMenuOpen() and not MenuVariables.Tattoo.isOpen then
					DisplayHelpText('TATTOO_GETTAT')

					if IsControlJustPressed(0, 38) then
						InitTattooMenu()

						MenuVariables.Tattoo.isOpen = true
					end
				end
			else
				DisplayHelpText('MISC_HAVEAJOB')
			end
		else
			PreviewTattoo = nil
		end

		if MenuVariables.Tattoo.isOpen then
			DisableFirstPersonCamThisFrame()

			if IsControlJustPressed(1, 202) then -- Backspace
				UpdatePlayerDecorations(true)
			end
		end

		if MenuVariables.Tattoo.isOpen and not AnyTattooMenuOpen() then
			MenuVariables.Tattoo.isOpen = false

			ClearPedTasks(HighLife.Player.Ped)

			UpdatePlayerDecorations(true)

			SetPedCanSwitchWeapon(HighLife.Player.Ped, true)

			MenuVariables.Tattoo.Preview = nil
			MenuVariables.Tattoo.HiddenMenuComponents = {}

			HighLife.Skin:ResetCurrentSkin()
		end

		Wait(1)
	end
end)