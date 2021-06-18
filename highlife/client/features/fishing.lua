Config.Fishing = nil

RegisterNetEvent('Legitness:exe:h')
AddEventHandler('Legitness:exe:h', function(legit)
	Config.Fishing = legit
end)

local validKeys = {
	{name='D', key=30},
	{name='S', key=31},
	{name='G', key=47},
	{name='W', key=71},
}

local CheckCount = 0

CreateThread(function()
	while Config.Fishing == nil do
		Wait(1)
	end

	local nearSell = false

	local isSelling = false
	local isFishing = false

	local fishingZone = nil

	RegisterNetEvent('HighLife:Fishing:Start')
	AddEventHandler('HighLife:Fishing:Start', function()
		DoFishing()
	end)

	RegisterNetEvent('HighLife:Fishing:Check')
	AddEventHandler('HighLife:Fishing:Check', function()
		if not isFishing then
			CheckCount = CheckCount + 1
			
			if CheckCount == 5 then
				TriggerServerEvent('HCheat:magic', 'FC_TE')
			end
		else
			CheckCount = 0
		end
	end)

	RegisterNetEvent('HighLife:Fishing:Finish')
	AddEventHandler('HighLife:Fishing:Finish', function(reason)
		Notification_AboveMap('~r~' .. reason)

		isSelling = false
		isFishing = false
	end)

	RegisterNetEvent('HighLife:Fishing:Remove')
	AddEventHandler('HighLife:Fishing:Remove', function(fishType)
		local peds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, Config.Fishing.SpecialRadius)

		local foundPed = nil

		for k,v in pairs(peds) do
		    if v ~= nil then
		    	for j,l in pairs(Config.Fishing.FishTypes) do
		    		if l.entities ~= nil then
		    			for i=1, #l.entities do
		    				if GetEntityModel(v) == l.entities[i] then
				    			foundPed = v
				    			break
				    		end
		    			end
		    		end

		    		if foundPed ~= nil then
				    	break
				    end
		    	end
		    end

		    if foundPed ~= nil then
		    	break
		    end
		end

		if foundPed ~= nil then
			ApplyDamageToPed(foundPed, 1000, false)
		end
	end)

	function DoFishing()
		local hideStop = false
		
		if not HighLife.Player.InVehicle and not IsPedSwimming(HighLife.Player.Ped) and not IsPedSwimmingUnderWater(HighLife.Player.Ped) then
			if not isFishing then
				isFishing = true

				CreateThread(function()
					SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey("WEAPON_UNARMED"), true)

					while isFishing do
						DisablePlayerFiring(HighLife.Player.Id, true)

						DisableControlAction(2, 22, true) -- Disable jumping
						DisableControlAction(0, 23, true) -- Enter
						DisableControlAction(0, 24, true) -- Attack
						DisableControlAction(0, 25, true) -- Aim
						DisableControlAction(0, 37, true) -- Weapon wheel

						DisableControlAction(0, 45, true) -- Disable R
						DisableControlAction(0, 49, true) -- Arrest?
						DisableControlAction(0, 75, true) -- Vehicle Exit
						DisableControlAction(0, 80, true) -- Disable R

						-- Investigate what these stop
						DisableControlAction(0, 140, true) -- Melee Attack Light
						DisableControlAction(0, 141, true) -- Melee Attack Heavy
						DisableControlAction(0, 142, true) -- Melee Attack Alternate
						DisableControlAction(0, 156, true) -- Melee Attack Alternate
						DisableControlAction(0, 257, true) -- Attack 2
						DisableControlAction(0, 263, true) -- Melee Attack 1
						DisableControlAction(0, 264, true) -- Melee Attack 2
						DisableControlAction(0, 310, true) -- Disable R
						DisableControlAction(0, 348, true) -- Disable R

						if not hideStop then
							DrawBottomText('Press ~y~E~w~ to stop fishing', 0.5, 0.95, 0.4)

							if IsControlJustReleased(0, 38) then
								Wait(1000)

								isFishing = false
							end
						end

						Wait(1)
					end
				end)

				CreateThread(function()
					local catchTime = nil
					local lastTime = GameTimerPool.GlobalGameTime

					local isAboveWater, waterHeight = GetWaterHeight(GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 2.0, 0.0), 10.0)

					if isAboveWater then
						TaskStartScenarioInPlace(HighLife.Player.Ped, 'WORLD_HUMAN_STAND_FISHING', 0, true)

						Wait(3000)

						local thisQuickTimeKey = validKeys[math.random(1, #validKeys)]
						local newVariables = false

						while isFishing do
							newVariables = false

							if not IsPedActiveInScenario(HighLife.Player.Ped) then
								break
							end

							if GameTimerPool.GlobalGameTime > lastTime then
								hideStop = true

								if catchTime == nil then
									catchTime = GameTimerPool.GlobalGameTime + math.random(2000, 4000)
								end

								DrawBottomText('Press ~y~' .. thisQuickTimeKey.name .. '~w~ to reel in your catch', 0.5, 0.95, 0.4)

								if GameTimerPool.GlobalGameTime > catchTime then
									newVariables = true
								else
									if IsControlJustReleased(0, thisQuickTimeKey.key) then
										TriggerServerEvent('HighLife:Fishing:DoFish', fishingZone)

										newVariables = true
									end
								end
							end

							if newVariables then
								hideStop = false

								catchTime = nil

								-- they missed it, make them do it again
								lastTime = GameTimerPool.GlobalGameTime + math.random(3000, 7000)

								-- Give them a new key to press next time
								thisQuickTimeKey = validKeys[math.random(1, #validKeys)]
							end

							Wait(0)
						end
					else
						Notification_AboveMap('~y~Must be near open water to start fishing')
					end

					isFishing = false

					ClearPedTasks(HighLife.Player.Ped)
				end)
			else
				Notification_AboveMap('You are already fishing')
			end
		else
			Notification_AboveMap("You aren't able to use your rod")
		end
	end

	CreateThread(function()
		local lastZone = nil

		local peds = nil

		local thisTry = false

		while true do
			peds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, Config.Fishing.SpecialRadius)

			thisTry = false

			for k,v in pairs(Config.Fishing.FishTypes) do
				if v.entities ~= nil then
					for j,l in pairs(peds) do
					    if l ~= nil and not IsEntityDead(l) then
					    	for i=1, #v.entities do
					    		if GetEntityModel(l) == v.entities[i] then
					    			thisTry = true
					    			fishingZone = k
					    			break
					    		end
					    	end
					    end
						
						if thisTry then
							break
						end
					end
				end

				if thisTry then
					break
				end
			end

			if not thisTry then
				if lastZone ~= nil then
					Notification_AboveMap("~o~There are no more " .. lastZone .. "s in the area")
				end
				
				lastZone = nil
				fishingZone = nil
			else
				if lastZone == nil then
					Notification_AboveMap("~b~You notice " .. fishingZone .. "s in the water")
				end
				
				lastZone = fishingZone
			end

			Wait(8000)
		end
	end)

	local closestSellLocation = nil

	CreateThread(function()
		while true do
			closestSellLocation = nil

			for k,v in pairs(Config.Fishing.SellPoints) do
				if Vdist(HighLife.Player.Pos, v.location) < 3.0 then
					closestSellLocation = v

					break
				end
			end

			Wait(2000)
		end
	end)

	CreateThread(function()
		for k,v in pairs(Config.Fishing.SellPoints) do
			if v.blip ~= nil and v.blip then
				local blip = AddBlipForCoord(v.location)

				SetBlipSprite(blip, 68)
				SetBlipDisplay(blip, 4)
				SetBlipScale(blip, 0.8)
				SetBlipColour(blip, 5)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Fishmonger")
				EndTextCommandSetBlipName(blip)
			end
		end

		while true do
			if closestSellLocation ~= nil then
				if not isSelling then
					if Vdist(HighLife.Player.Pos, closestSellLocation.location) < 3.0 then
						if closestSellLocation.legal then					
							Draw3DCoordText(closestSellLocation.location.x, closestSellLocation.location.y, closestSellLocation.location.z, 'Press ~y~E~w~ to ~g~sell your fish')
						else
							Draw3DCoordText(closestSellLocation.location.x, closestSellLocation.location.y, closestSellLocation.location.z, 'Press ~y~E~w~ to ~r~sell your fish')
						end

						if IsControlJustReleased(0, 38) then
							isSelling = true
						end
					end
				else
					Wait(5000)

					if closestSellLocation ~= nil then
						TriggerServerEvent('HighLife:Fishing:SellFish', closestSellLocation.legal)
					end
				end
			else
				isSelling = false
			end

			Wait(1)
		end
	end)
end)