local nearbyDeadAnimal = nil
local closestSellLocation = nil

local roadkill = { 133987706, -1553120962, 2741846334 }

CreateThread(function()
	local peds = nil
	
	local thisTry = false

	while true do
		if not HighLife.Player.InVehicle then
			peds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, Config.Hunting.ButcherRange)

			thisTry = false

			for k,v in pairs(Config.Hunting.ped_types) do
				for j,l in pairs(peds) do
				    if l ~= nil and IsEntityDead(l) then
				    	if GetEntityModel(l) == GetHashKey(k) then
				    		thisTry = true

				    		local isRoadkill = false

				    		local deathReason = GetPedCauseOfDeath(l)

				    		for i=1, #roadkill do
				    			if deathReason == roadkill[i] then
				    				isRoadkill = true

				    				break
				    			end
				    		end

				    		nearbyDeadAnimal = {
				    			ped = l,
				    			model = k,
				    			roadKill = isRoadkill
				    		}

				    		break
				    	end
				    end
					
					if thisTry then
						break
					end
				end

				if thisTry then
					break
				end
			end

			if not thisTry then
				nearbyDeadAnimal = nil
			end
		else
			nearbyDeadAnimal = nil
		end

		Wait(3000)
	end
end)


CreateThread(function()
	while true do
		if nearbyDeadAnimal ~= nil then
			local ThisAnimal = nearbyDeadAnimal.ped
			local Roadkill = nearbyDeadAnimal.roadKill
			local ThisAnimalConfig = Config.Hunting.ped_types[nearbyDeadAnimal.model]

			if not DecorExistOn(ThisAnimal, 'Hunting.Butchering') then
				local deadAnimalPos = GetEntityCoords(ThisAnimal)

				local pedNetID = PedToNet(ThisAnimal)

				if HighLife.Player.SpecialItems.hunting_knife ~= nil and HighLife.Player.SpecialItems.hunting_knife then
					Draw3DCoordText(deadAnimalPos.x, deadAnimalPos.y, deadAnimalPos.z, 'Press [~y~E~s~] to skin the animal')

					if IsControlJustReleased(0, 38) then
						TriggerServerEvent('HighLife:Hunting:StartSkinning', pedNetID)
						
						local thisPos = vector3(deadAnimalPos.x, deadAnimalPos.y, deadAnimalPos.z)
						
						if HasSafeControl(ThisAnimal) then
							DecorSetBool(ThisAnimal, 'Hunting.Butchering', true)

							local RandomReturnAmount = math.random(ThisAnimalConfig.quantity[1], ThisAnimalConfig.quantity[2])

							TaskStartScenarioInPlace(HighLife.Player.Ped, Config.Hunting.Animation, -1, true)

							Wait(25000)

							if Vdist(HighLife.Player.Pos, thisPos) < 5.0 then
								ClearPedTasks(HighLife.Player.Ped)

								if Roadkill then
									Notification_AboveMap("~o~The meat is ruined from being ran over")
								else
									TriggerServerEvent('HighLife:Hunting:UpdateStats', RandomReturnAmount, pedNetID)
								end

								if math.random(30) == 30 then
									TriggerServerEvent('HighLife:Inventory:RemoveItem', 'hunting_knife', 1)

									Notification_AboveMap("~o~Your knife breaks while skinning")
								end

								NetworkFadeOutEntity(ThisAnimal, false, false)

								Wait(1000)

								TriggerServerEvent('HighLife:Entity:Delete', pedNetID)
							end
						end
					end
				else
					Draw3DCoordText(deadAnimalPos.x, deadAnimalPos.y, deadAnimalPos.z, "~y~You don't have a hunting knife")
				end
			end
		end

		Wait(1)
	end
end)