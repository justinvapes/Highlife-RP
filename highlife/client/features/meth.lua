local calledCops = false

local hasFoundCook = false

local activeMethCookers = {}
local activeMethCookLocations = {}

local BadLocations = {
	uTool = {
		pos = vector3(2758.9, 3467.8, 55.0),
		radius = 400.0
	},
	city = {
		pos = vector3(10.9, -825.5, 30.0),
		radius = 400.0
	},
	davis = {
		pos = vector3(112.0517, -1571.14, 29.60267),
		radius = 400.0
	}
}

function MethVanCooking()
	local validLocation = true

	for locationName, locationData in pairs(BadLocations) do
		if Vdist(HighLife.Player.Pos, locationData.pos) < locationData.radius then
			validLocation = false

			break
		end
	end

	if validLocation then
		if not HighLife.Player.IsCookingMeth then
			HighLife.Player.IsCookingMeth = true

			local thisCookData = {
				statusMessage = "~b~Add items to start cooking",
				quality = 50, -- 0 - 100
				vehicle = HighLife.Player.Vehicle,
				quantity = 0,
				overheat = 0,
				success = false,
				started = false,
				smoke = nil,
				sentSmoke = false,
				temperature = 50,
				temperature_fine = true,
				desiredTemp = math.random(100),
				product_1 = 0,
				product_2 = 0,
				product_3 = 0,
				cookingLength = 0.0,
				interval = GameTimerPool.GlobalGameTime + Config.Durgz.Meth.Cooking.Interval,
				tempInterval = GameTimerPool.GlobalGameTime + Config.Durgz.Meth.Cooking.TempChangeInterval,
			}
			
			local helpText = 'Keep the temperature green for consistent production'

			CreateThread(function()
				while HighLife.Player.IsCookingMeth do
					helpText = 'Keep the temperature green for consistent production'

					for keyName,keyData in ipairs(Config.Durgz.Meth.ControlKeys) do
						helpText = helpText .. '~n~' .. (keyData.ignorePreview == nil and '~' .. keyData.scaleform .. '~ ' or '') .. keyData.description .. (keyData.dataAttribute ~= nil and ' (' .. thisCookData[keyData.dataAttribute] .. (keyData.percent ~= nil and '%' or '') .. ')' or '')
					end

					SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)

					Bar.DrawProgressBar('Cooking Meth', thisCookData.cookingLength, 0, { r = 224, g = 50, b = 160 })

					DisplayHelpText(helpText)

					DrawBottomText(thisCookData.statusMessage, 0.5, 0.95, 0.4)

					for keyName,keyData in ipairs(Config.Durgz.Meth.ControlKeys) do
						if keyData.control ~= nil then
							if IsKeyboard() and IsControlJustReleased(0, keyData.control) then
								if keyData.action == 'increase_temp' then
									thisCookData.temperature = thisCookData.temperature + 5

									if thisCookData.temperature > 100 then
										thisCookData.temperature = 100
									end
								elseif keyData.action == 'decrease_temp' then
									thisCookData.temperature = thisCookData.temperature - 5

									if thisCookData.temperature < 0 then
										thisCookData.temperature = 0
									end
								elseif keyData.action == 'add_product_1' then
									HighLife:ServerCallback('HighLife:RemoveItem', function(hasRemoved)
										if hasRemoved then
											thisCookData.product_1 = thisCookData.product_1 + 1

											Notification_AboveMap('You add more ~o~' .. keyData.plural .. ' ~s~to the pot')
										else
											Notification_AboveMap("You don't have any " .. keyData.plural .. " to add")
										end
									end, keyData.itemName, 1)
								elseif keyData.action == 'add_product_2' then
									HighLife:ServerCallback('HighLife:RemoveItem', function(hasRemoved)
										if hasRemoved then
											thisCookData.product_2 = thisCookData.product_2 + 1

											Notification_AboveMap('You add more ~o~' .. keyData.plural .. ' ~s~to the pot')
										else
											Notification_AboveMap("You don't have any " .. keyData.plural .. " to add")
										end
									end, keyData.itemName, 1)
								elseif keyData.action == 'add_product_3' then
									HighLife:ServerCallback('HighLife:RemoveItem', function(hasRemoved)
										if hasRemoved then
											thisCookData.product_3 = thisCookData.product_3 + 1

											Notification_AboveMap('You add more ~o~' .. keyData.plural .. ' ~s~to the pot')
										else
											Notification_AboveMap("You don't have any " .. keyData.plural .. " to add")
										end
									end, keyData.itemName, 1)
								end

								break
							end
						end
					end

					if thisCookData.product_1 > 0 and thisCookData.product_2 > 0 and thisCookData.product_3 > 0 then
						thisCookData.started = true

						if not thisCookData.sentSmoke then
							thisCookData.sentSmoke = true

							local thisPos = GetEntityCoords(thisCookData.vehicle) + vector3(0.0, 0.0, 1.6)

							thisCookData.smoke = {
								StartTime = GameTimerPool.GlobalGameTime,
								Pos = {
									x = thisPos.x,
									y = thisPos.y,
									z = thisPos.z
								}
							}

							TriggerServerEvent('HighLife:Meth:StartSmoke', json.encode(thisCookData))
						end

						if GameTimerPool.GlobalGameTime > thisCookData.tempInterval then
							thisCookData.desiredTemp = thisCookData.desiredTemp + (math.random(2) == 1 and -math.random(Config.Durgz.Meth.Cooking.TempChangeRange.min, Config.Durgz.Meth.Cooking.TempChangeRange.max) or math.random(Config.Durgz.Meth.Cooking.TempChangeRange.min, Config.Durgz.Meth.Cooking.TempChangeRange.max))

							if thisCookData.desiredTemp > 100 then
								thisCookData.desiredTemp = 100
							elseif thisCookData.desiredTemp < 0 then
								thisCookData.desiredTemp = 10
							end

							if not calledCops then
								if HighLife:DispatchEventCallback('suspicious') then
									HighLife:DispatchEvent('suspicious')

									calledCops = true
								end
							end

							thisCookData.tempInterval = GameTimerPool.GlobalGameTime + Config.Durgz.Meth.Cooking.TempChangeInterval
						end

						if GameTimerPool.GlobalGameTime > thisCookData.interval then
							thisCookData.cookingLength = thisCookData.cookingLength + (math.random(Config.Durgz.Meth.Cooking.Amount.min, Config.Durgz.Meth.Cooking.Amount.max) * 0.001)

							Debug('Meth Target Temp: ' .. thisCookData.desiredTemp .. '\nMeth Quality: ' .. thisCookData.quality .. '\nMeth Quantity: ' .. thisCookData.quantity .. '\nOverheat: ' .. thisCookData.overheat)

							if math.random(Config.Durgz.Meth.Cooking.DamageChance) == 1 then
								if GetPedDrawableVariation(HighLife.Player.Ped, 1) ~= (isMale() and 12 or 15) then
									ApplyDamageToPed(HighLife.Player.Ped, math.random(1,2), false)

									Notification_AboveMap('The fumes from the solution make it hard to breathe')
								end
							end

							if IntWithinRange(thisCookData.desiredTemp, thisCookData.temperature, Config.Durgz.Meth.Cooking.TempSuccessRange) then
								if not thisCookData.temperature_fine then
									thisCookData.temperature_fine = true
									
									thisCookData.statusMessage = '~g~The batch is responding well to the heat'
								end

								thisCookData.quality = thisCookData.quality + Config.Durgz.Meth.Cooking.TempSuccessQuality
							else
								if thisCookData.temperature_fine then
									thisCookData.temperature_fine = false
									
									thisCookData.statusMessage = '~o~The batch is not responding well to the heat'
								end

								if thisCookData.temperature > thisCookData.desiredTemp + Config.Durgz.Meth.Cooking.OverheatAboveValue then
									thisCookData.overheat = thisCookData.overheat + math.random(Config.Durgz.Meth.Cooking.Overheat.min, Config.Durgz.Meth.Cooking.Overheat.max)
								end

								thisCookData.quality = thisCookData.quality - Config.Durgz.Meth.Cooking.TempSuccessQuality
							end

							thisCookData.interval = GameTimerPool.GlobalGameTime + Config.Durgz.Meth.Cooking.Interval
						end

						if thisCookData.cookingLength > 0.99 then
							HighLife.Player.IsCookingMeth = false

							thisCookData.success = true
						end

						if thisCookData.overheat > Config.Durgz.Meth.Cooking.OverheatLimit then
							thisCookData.explode = true

							Notification_AboveMap("The liquid starts to bubble ~r~out of control~s~, ~o~I should probably leave")

							break
						end
					end

					if not HighLife.Player.InVehicle or HighLife.Player.VehicleSeat ~= -1 then
						break
					end

					Wait(1)
				end

				if thisCookData.success then
					HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(thisToken)
						if HighLife.Player.Debug then
							thisCookData.quality = 100
							thisCookData.quantity = 170.0

							Notification_AboveMap('Debug meth results active')
						end

						TriggerServerEvent('HighLife:Meth:CookMeth', thisToken, json.encode(thisCookData))
					end)
				elseif not thisCookData.started then
					HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(thisToken)
						TriggerServerEvent('HighLife:Meth:Return', thisToken, json.encode(thisCookData))
					end)
				end

				if thisCookData.explode then
					Wait(math.random(5000, 11000))

					AddExplosion(GetEntityCoords(thisCookData.vehicle), 0, 1.0, true, false, 1.5)

					HighLife:DispatchEvent('explosion')
				end

				Wait(5000)

				TriggerServerEvent('HighLife:Meth:StopSmoke')

				calledCops = false

				HighLife.Player.IsCookingMeth = false
			end)
		else
			Notification_AboveMap('~o~You are already cooking!')
		end
	else
		Notification_AboveMap("~o~This doesn't seem like a good place to start cooking... ~r~HAPPY?")
	end
end

function InAnyMethVehicle(vehicle)
	for i=1, #Config.Durgz.Meth.ValidVehicles do
		if GetEntityModel(vehicle) == Config.Durgz.Meth.ValidVehicles[i] then
			return true
		end
	end

	return false
end

RegisterNetEvent("HighLife:Meth:Expose")
AddEventHandler("HighLife:Meth:Expose", function(methCookers)
	if methCookers ~= nil then
		activeMethCookers = json.decode(methCookers)

		CreateThread(function()
			if not HasNamedPtfxAssetLoaded("core") then
				RequestNamedPtfxAsset("core")
				
		        while not HasNamedPtfxAssetLoaded("core") do
					Wait(1)
				end
			end

			SetPtfxAssetNextCall("core")

			if activeMethCookers ~= nil then
				for i=1, #activeMethCookers do
					if activeMethCookLocations[activeMethCookers[i].UID] == nil then
						activeMethCookLocations[activeMethCookers[i].UID] = StartParticleFxLoopedAtCoord("ent_amb_smoke_factory_white", activeMethCookers[i].Pos.x, activeMethCookers[i].Pos.y, activeMethCookers[i].Pos.z, 0.0, 0.0, 0.0, 2.5, false, false, false, false)
						
					    SetParticleFxLoopedAlpha(activeMethCookLocations[activeMethCookers[i].UID], 4.5)
						SetParticleFxLoopedColour(activeMethCookLocations[activeMethCookers[i].UID], 0.0, 0.0, 0.0, 0)
					end
				end

				for uid,particleObject in pairs(activeMethCookLocations) do
					hasFoundCook = false

					for i=1, #activeMethCookers do
						if activeMethCookers[i].UID == uid then
							hasFoundCook = true

							break
						end
					end

					if not hasFoundCook then
						StopParticleFxLooped(activeMethCookLocations[uid], 0)

						activeMethCookLocations[uid] = nil
					end
				end
			end

		end)
	end
end)


CreateThread(function()
	while true do
		if not HighLife.Player.IsCookingMeth and not HighLife.Other.InDealership and HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == -1 and InAnyMethVehicle(HighLife.Player.Vehicle) then
			if IsVehicleStopped(HighLife.Player.Vehicle) then
				DisplayHelpText('Press ~INPUT_PICKUP~ to start cooking')

				if IsKeyboard() and IsControlJustReleased(0, 38) then
					MethVanCooking()
				end
			end
		end

		Wait(1)
	end
end)
