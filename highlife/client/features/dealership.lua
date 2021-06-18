local lastMenu = nil

local currentDealer = nil
local currentVehicle = nil

local previewVehicle = nil

local warningDisplayed = false
local purchasedVehicle = false
local purchaseReference = nil

local fakeBankBalance = nil

local menus = {
	subMenus = {},
	subItems = {}
}

local MarkerDrawDistance = 30.0

_dealerMenuPool = NativeUI.CreatePool()

dealerMenu = nil

function pairsByKeys(t, f)
    local a = {}

    for n in pairs(t) do
        table.insert(a, n)
    end

    table.sort(a, f)

    local i = 0

    local iter = function()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end

    return iter
end

function SpawnDealershipVehicle(model, config, preview, plate)
	if preview then
		RequestModel(model)

		while not HasModelLoaded(model) do
			BeginTextCommandBusyString('STRING')
			AddTextComponentSubstringPlayerName('Downloading Vehicle')
			EndTextCommandBusyString(4)

			Wait(1)
		end
	end

	HighLife:CreateVehicle(model, vector3(config.location.preview.x, config.location.preview.y, config.location.preview.z) + vector3(0.0, 0.0, 0.5), HighLife.Player.Heading, false, not preview, function(thisVehicle)
		RemoveLoadingPrompt()
		RemoveLoadingPrompt()

		SetVehicleDirtLevel(thisVehicle, 0.0)
		-- SetVehicleColours(thisVehicle, 112, 0) -- P: White S: Black
		SetVehicleOnGroundProperly(thisVehicle)
		
		if plate ~= nil then
			SetVehicleNumberPlateText(thisVehicle, plate)
		end

		SetVehicleNumberPlateTextIndex(thisVehicle, 5)
		-- SetVehicleWindowTint(thisVehicle, 3)
		SetVehRadioStation(thisVehicle, 'OFF')
		SetVehicleFixed(thisVehicle)
		SetVehicleModKit(thisVehicle, 0)
		
		if preview then
			SetEntityInvincible(thisVehicle, true)
			SetVehicleDoorsLocked(thisVehicle, 4)
			FreezeEntityPosition(thisVehicle, true)
			SetEntityInvincible(thisVehicle, true)

			previewVehicle = thisVehicle
		else
			HighLife.Other.InDealership = false

			local thisPlate = GetVehicleNumberPlateText(thisVehicle)

			HighLife:TempDisable()

			SetEntityCoords(thisVehicle, config.location.purchase)
			SetEntityHeading(thisVehicle, config.location.purchase.w)

			-- SetVehicleCustomPrimaryColour(thisVehicle, math.random(255), math.random(255), math.random(255))
			-- SetVehicleCustomSecondaryColour(thisVehicle, math.random(255), math.random(255), math.random(255))

			SetVehicleOnGroundProperly(thisVehicle)

			HighLife.Player.EntryCheck = true

			TaskWarpPedIntoVehicle(HighLife.Player.Ped, thisVehicle, -1)

			local vehicle_class = GetVehicleClass(thisVehicle)
			local vehicle_components = HighLife:GetVehicleProperties(thisVehicle)

			SetVehicleFuel(thisVehicle, 100.0)

			TriggerEvent('HighLife:LockSystem:GiveKeys', thisPlate, true)

			DecorSetBool(thisVehicle, 'Vehicle.PlayerOwned', true)

			TriggerServerEvent("HighLife:Dealership:AddVehicle", purchaseReference, json.encode(vehicle_components))

			purchaseReference = nil
		end

		HighLife.Player.EntryCheck = true

		Wait(1)

		TaskWarpPedIntoVehicle(HighLife.Player.Ped, thisVehicle, -1)
	end, (preview and true or nil))
end

function DeleteCurrentVehicle(vehicle)
	HighLife:DeleteVehicle(vehicle)

	previewVehicle = nil
end

function DrawDealershipMenu(menu, dealer)
	menu:Clear()

	if dealer ~= nil then
		menus.subMenus = {}
		menus.subItems = {}

		previewVehicle = nil

		HighLife.Other.InDealership = true

		local hasValidLicense = true

		InDealership(dealer.location.preview, true)

		if dealer.required_licenses ~= nil then
			for i=1, #dealer.required_licenses do
				if not HighLife.Player.Licenses[dealer.required_licenses[i]] then
					hasValidLicense = false

					break
				end
			end
		end

		for k,v in pairsByKeys(dealer.vehicles) do
			local menuName = k

			if k == 'Supporters' then
				menuName = '~y~Supporters'
			end

			if k == 'Nitro' then
				menuName = '~p~Nitro'
			end

			menus.subMenus[k] = _dealerMenuPool:AddSubMenu(menu, menuName, "", true)

			menus.subMenus[k].SubMenu:AddInstructionButton({GetControlInstructionalButton(2, 22, 0), 'Preview'})

			menus.subItems[k] = {}

			for i=1, #v do
				local vehicle = v[i]

				if vehicle.hidden == nil then
					local vehicleEnabled = true

					local storageSize = 0

					if Config.Storage.Trunk.SizeOverrides[vehicle.model] ~= nil then
						storageSize = Config.Storage.Trunk.SizeOverrides[vehicle.model]
					else
						storageSize = Config.Storage.Trunk.VehicleClasses[GetVehicleClassFromName(GetHashKey(vehicle.model))].limits.items
					end

					local vehicleDescription = '(Storage Capacity: ~y~' .. storageSize .. '~s~)'

					if (fakeBankBalance or 0) < vehicle.price then
						vehicleEnabled = false
						-- vehicleDescription = '~o~You cannot afford this vehicle'
					end

					if not hasValidLicense then
						local hasStarted = false

						for i=1, #dealer.required_licenses do
							if not HighLife.Player.Licenses[dealer.required_licenses[i]] then
								if hasStarted then
									vehicleDescription = vehicleDescription .. ' ~s~and ~o~' .. Config.Licenses[dealer.required_licenses[i]].name
								else
									hasStarted = true

									vehicleDescription = 'You require a ~o~' .. Config.Licenses[dealer.required_licenses[i]].name
								end
							end
						end

						vehicleEnabled = false
						vehicleDescription = vehicleDescription .. ' ~s~license'
					end

					if vehicle.noLicense ~= nil and vehicle.noLicense then
						vehicleEnabled = true
						vehicleDescription = ''
					end

					if vehicle.supporter ~= nil and vehicle.supporter then
						if HighLife.Player.Supporter == nil then
							vehicleEnabled = false
							vehicleDescription = '~o~This is a ~y~Supporter ~o~only vehicle'
						else
							if HighLife.Player.Supporter < Config.GoldenTicketRank then
								vehicleEnabled = false
								vehicleDescription = '~o~This is a ~y~Gold Supporter~o~ only vehicle'
							end
						end
					end

					if vehicle.disabled ~= nil and vehicle.disabled then
						vehicleEnabled = false

						vehicleDescription = '~o~This vehicle is out of stock'
					end

					if vehicle.nitro ~= nil and vehicle.nitro then
						if not HighLife.Player.NitroBoosted then
							vehicleEnabled = false
							vehicleDescription = '~o~This is a ~p~Nitro booster ~o~only vehicle'
						end
					end

					local thisName = (GetLabelText(vehicle.model) ~= 'NULL' and GetLabelText(vehicle.model) or vehicle.name)

					menus.subItems[k][i] = {
						menu = NativeUI.CreateItem(thisName, vehicleDescription),
						name = thisName,
						price = vehicle.price,
						model = vehicle.model
					}

					menus.subItems[k][i].menu:RightLabel('$' .. comma_value(vehicle.price), {R = 114, G = 204, B = 114, A = 255}, {R = 0, G = 0, B = 0, A = 255})

					if not vehicleEnabled then
						menus.subItems[k][i].menu:Enabled(false)
					end

					menus.subMenus[k].SubMenu:AddItem(menus.subItems[k][i].menu)
				end
			end

			menus.subMenus[k].SubMenu.OnIndexChange = function(menu, index)
				currentVehicle = menus.subItems[k][index].model

				if previewVehicle ~= nil then
					DeleteCurrentVehicle(previewVehicle)

					while DoesEntityExist(previewVehicle) do
						Wait(0)
					end
				end
			end

			menus.subMenus[k].SubMenu.OnItemSelect = function(sender, item, index)
				local thisVehicle = menus.subItems[k][index]

				if not warningDisplayed then
					local purchase = false

					CreateThread(function()
						warningDisplayed = true
						local controlsEnabled = false

						AddTextEntry("wrn_dlr_" .. thisVehicle.model, "Are you sure you want to purchase a ~y~" .. thisVehicle.name .. "~s~?")
						AddTextEntry("wrn_dlr_" .. thisVehicle.model .. "_price", "This will cost ~r~$" .. comma_value(thisVehicle.price))

						CreateThread(function()
							Wait(1000)

							controlsEnabled = true
						end)
						
						while true do
							SetWarningMessage("wrn_dlr_" .. thisVehicle.model, 20, "wrn_dlr_" .. thisVehicle.model .. "_price", 0, -1, true, 0, 0, 0)

							if controlsEnabled then
								if IsControlJustReleased(2, 201) or IsControlJustReleased(2, 217) then -- any select/confirm key was pressed.
									purchase = true
									break
								elseif IsControlJustReleased(2, 202) then -- any of the cancel/back buttons was pressed
								    break
								end
							end

							Wait(0)
						end
						
						if purchase then
							local data = {
								price = thisVehicle.price,
								model = thisVehicle.model
							}

							HighLife:ServerCallback('HighLife:Dealership:CanBuy', function(data)
								if data.status then
									purchaseReference = data.reference

									DeleteCurrentVehicle(previewVehicle)

									purchasedVehicle = true

									menu:Visible(false)

									for k,v in pairs(menus.subMenus) do
										v.SubMenu:Visible(false)
									end

									TriggerServerEvent('HighLife:Discord:Log', 'dealership', '[Rogue] ' .. GetPlayerName(PlayerId()) .. ' bought a ' .. thisVehicle.model .. ', legit, he did!')

									SpawnDealershipVehicle(GetHashKey(thisVehicle.model), currentDealer, false, data.plate)
								end
							end, data)
						end

						warningDisplayed = false
					end)
				end
			end

			menus.subMenus[k].SubMenu:CurrentSelection(0)
		end

		menu.OnItemSelect = function(sender, item, index)
			local thisCount = 1

			for k,v in pairsByKeys(menus.subItems) do
				if thisCount == index then
					currentVehicle = v[1].model
					break
				end

				thisCount = thisCount + 1
			end
		end

		menu:CurrentSelection(0)
	 
		_dealerMenuPool:RefreshIndex()
		
		menu:Visible(true)

	    lastMenu = dealer
	end
end

function InDealership(location, bool)
	HighLife:TempDisable()

	SetEntityCoords(HighLife.Player.Ped, location.x, location.y, location.z)
	SetEntityHeading(HighLife.Player.Ped, location.w)

	FreezeEntityPosition(HighLife.Player.Ped, true)
end

function DrawDealershipBlips()
	for k,v in pairs(Config.Dealerships) do
		if v.blip ~= nil then
			local thisLocation = nil

			if v.vehicleSell ~= nil and v.vehicleSell then
				thisLocation = v.location
			else
				thisLocation = v.location.enter
			end

			local thisBlip = AddBlipForCoord(thisLocation.x, thisLocation.y, thisLocation.z)

			SetBlipAsShortRange(thisBlip, 1)
			SetBlipSprite(thisBlip, v.blip.sprite)
			SetBlipColour(thisBlip, v.blip.color)
			SetBlipScale(thisBlip, 0.8)

			if v.blip.category ~= nil then
				SetBlipCategory(thisBlip, v.blip.category)
			end

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blip.text)
			EndTextCommandSetBlipName(thisBlip)

			if v.blip.image ~= nil then
				SetBlipInfoTitle(thisBlip, v.blip.text, false)
				AddBlipInfoText(thisBlip, "Motto", '"' .. v.description .. '~s~"')

				if v.blip.image ~= nil then
					RequestStreamedTextureDict(v.blip.image.dict, 1)
					
					while not HasStreamedTextureDictLoaded(v.blip.image.dict)  do
						Wait(1)
					end
					
					SetBlipInfoImage(thisBlip, v.blip.image.dict, v.blip.image.name) 
				end
			end
		end
	end
end

local closestDealer = nil

CreateThread(function()
	DrawDealershipBlips()
	
	local thisTry = false
	local thisLocation = nil

	while true do
		thisTry = false

		for k,v in pairs(Config.Dealerships) do
			thisLocation = nil

			if v.vehicleSell ~= nil and v.vehicleSell then
				thisLocation = v.location
			else
				thisLocation = v.location.enter
			end
			
			if Vdist(HighLife.Player.Pos, thisLocation.x, thisLocation.y, thisLocation.z) < MarkerDrawDistance then
				thisTry = true
			
				closestDealer = v
			
				break
			end
		end

		if not thisTry then
			closestDealer = nil
		end

		Wait(500)
	end
end)

CreateThread(function()
	while true do
		_dealerMenuPool:ControlDisablingEnabled(false)
		_dealerMenuPool:MouseControlsEnabled(false)

		_dealerMenuPool:ProcessMenus()

		if closestDealer ~= nil then
			local isSell = false

			if closestDealer.vehicleSell ~= nil and closestDealer.vehicleSell then
				isSell = true

				thisLocation = closestDealer.location
			else
				thisLocation = closestDealer.location.enter
			end

			if not HighLife.Other.InDealership then
				DrawMarker(1, thisLocation.x, thisLocation.y, thisLocation.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 255, 255, 255, 80, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(HighLife.Player.Pos, thisLocation.x, thisLocation.y, thisLocation.z) < 1.0 then
				if not HighLife.Player.InVehicle and not isSell then
					if not HighLife.Other.InDealership then
						DisplayHelpText("Press ~INPUT_PICKUP~ to browse ~y~" .. closestDealer.blip.text)
					end

					if IsControlJustReleased(0, 38) then
						local dealerName = closestDealer.blip.text

						if closestDealer.DisplayTexture ~= nil then
							dealerName = ''
						end

						dealerMenu = NativeUI.CreateMenu(dealerName, '~y~' .. closestDealer.description, 1380, 200, closestDealer.DisplayTexture, closestDealer.DisplayTexture)
						_dealerMenuPool:Add(dealerMenu)

						_dealerMenuPool:RefreshIndex()

						SetCurrentPedWeapon(HighLife.Player.Ped, -1569615261, true)

						fakeBankBalance = nil

						HighLife:ServerCallback('HighLife:callback:GetPlayerMoney', function(data)
							fakeBankBalance = data.bank
						end)

						while fakeBankBalance ~= nil do
							Wait(0)
						end

						DoFadeyShit(2000)

						currentDealer = closestDealer

						if closestDealer ~= nil then
							DrawDealershipMenu(dealerMenu, closestDealer)
						end
					end
				else
					if isSell and HighLife.Player.InVehicle then
						local vehicleModel = GetEntityModel(HighLife.Player.Vehicle)

						local sellPrice = nil
						local foundVehicle = false

						for k,v in pairs(Config.Dealerships) do
							if v.vehicles ~= nil then
								for j,vehicle in pairs(v.vehicles) do
									for i=1, #vehicle do
										if GetHashKey(vehicle[i].model) == vehicleModel then
											foundVehicle = true
											sellPrice = math.floor(vehicle[i].price * closestDealer.sellModifier)

											break
										end
									end

									if foundVehicle then
										break
									end
								end
							end

							if foundVehicle then
								break
							end
						end

						if sellPrice ~= nil then
							DisplayHelpText("Press ~INPUT_PICKUP~ to ~r~sell ~w~your vehicle for ~g~$" .. comma_value(sellPrice))

							if IsControlJustReleased(0, 38) then
								TriggerServerEvent('HighLife:Dealership:SellVehicle', vehicleModel, GetVehicleNumberPlateText(HighLife.Player.Vehicle), sellPrice, VehToNet(HighLife.Player.Vehicle))

								Wait(3000)
							end
						else
							DisplayHelpText('DEALER_NOSELL')
						end

						DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					end
				end
			end
		end

		if lastMenu ~= nil then
			if not _dealerMenuPool:IsAnyMenuOpen() then
				dealerMenu:Visible(false)

				HighLife.Other.InDealership = false

				DeleteCurrentVehicle(previewVehicle)
			end
		end

		if HighLife.Other.InDealership then
			SetEntityVisible(HighLife.Player.Ped, false)

			DisableControlAction(0, 23, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 49, true)
			DisableControlAction(0, 58, true)
			DisableControlAction(0, 75, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 143, true)
			DisableControlAction(0, 145, true)
			DisableControlAction(0, 185, true)
			DisableControlAction(0, 251, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)

			HighLife.Player.DisableShooting = true

			if currentDealer.CanRotate then
				if previewVehicle ~= nil and DoesEntityExist(previewVehicle) then
					local currentRot = GetEntityRotation(previewVehicle, 2)

					SetEntityRotation(previewVehicle, currentRot.x, currentRot.y, currentRot.z + 0.15, 2, true)
				end
			end

			if IsControlJustPressed(1, 22) then -- Space
				local validMenu = false

				if previewVehicle ~= nil then
					DeleteCurrentVehicle(previewVehicle)

					while DoesEntityExist(previewVehicle) do
						Wait(0)
					end
				end

				for k,v in pairs(menus.subMenus) do
					if v.SubMenu:Visible() then
						validMenu = true

						break
					end
				end

				if validMenu and previewVehicle == nil then
					SpawnDealershipVehicle(GetHashKey(currentVehicle), currentDealer, true, nil)
				end
			end

			if IsControlJustPressed(1, 202) then -- Backspace
				if previewVehicle ~= nil then
					currentVehicle = nil

					DeleteCurrentVehicle(previewVehicle)
				end
			end
		else
			if lastMenu ~= nil or purchasedVehicle then
				local thisLocation = nil

				if lastMenu ~= nil and lastMenu.vehicleSell ~= nil and lastMenu.vehicleSell then
					thisLocation = lastMenu.location
				else
					thisLocation = lastMenu.location.enter
				end

				if not purchasedVehicle then
					HighLife:TempDisable()

					SetEntityCoords(HighLife.Player.Ped, thisLocation)

					if HighLife.Player.InVehicle then
						SetEntityAsMissionEntity(HighLife.Player.Vehicle, true, true)
						
						DeleteVehicle(HighLife.Player.Vehicle)
					end
				else
					purchasedVehicle = false
				end

				SetEntityVisible(HighLife.Player.Ped, true)
				FreezeEntityPosition(HighLife.Player.Ped, false)

				HighLife.Player.DisableShooting = false

				previewVehicle = nil

				lastMenu = nil
			end
		end

		Wait(1)
	end
end)