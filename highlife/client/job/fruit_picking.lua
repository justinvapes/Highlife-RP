local nearFruit = nil
local closestObject = nil

local isSearching = false

CreateThread(function()
	while true do
		nearFruit = nil
		closestObject = nil

		if not HighLife.Player.CD and not HighLife.Player.InVehicle and not HighLife.Player.Dead and not HighLife.Player.Cuffed then
			for fruitHash,fruitItem in pairs(Config.FruitPicking.entities) do
				closestObject = GetClosestObjectOfType(HighLife.Player.Pos, 4.0, fruitHash, false, false)

				if closestObject ~= 0 and closestObject ~= nil then
					nearFruit = {
						entity = closestObject,
						item = fruitItem
					}

					break
				end
			end
		end

		Wait(2000)
	end
end)

local searched_fruit = {}

CreateThread(function()
	local validSearch = false

	local fruitPos = nil

	while true do
		validSearch = true

		if nearFruit ~= nil and not isSearching then
			fruitPos = GetEntityCoords(nearFruit.entity)

			if Vdist(HighLife.Player.Pos, fruitPos) < 2.5 then
				Draw3DCoordText(fruitPos.x, fruitPos.y, fruitPos.z + 1.5, '[~y~E~s~] to harvest ' .. Config.FruitPicking.Names[nearFruit.item])

				if IsControlJustReleased(0, 38) then
					for i=1, #searched_fruit do
						if Vdist(fruitPos, searched_fruit[i].pos) < 5.0 or nearFruit.entity == searched_fruit[i].entity then
							if GameTimerPool.GlobalGameTime > searched_fruit[i].time then
								table.remove(searched_fruit, i)

								break
							end
							
							validSearch = false

							break
						end
					end

					HighLife:DisableCoreControls(true)

					isSearching = true

					TaskTurnPedToFaceEntity(HighLife.Player.Ped, nearFruit.entity, -1)

					Wait(1500)

					TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

					Wait(8000)

					if validSearch then
						if IsPedActiveInScenario(HighLife.Player.Ped) then
							HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(thisToken)
								TriggerServerEvent('HighLife:Fruit:Pick', thisToken, nearFruit.item)
							end)

							table.insert(searched_fruit, {
								pos = fruitPos,
								entity = nearFruit.entity,
								time = GameTimerPool.GlobalGameTime + (900 * 1000),
							})
						end
					else
						Notification_AboveMap('There are no more ' .. (nearFruit ~= nil and Config.FruitPicking.Names[nearFruit.item] or 'fruit') .. ' to harvest')
					end

					isSearching = false

					ClearPedTasks(HighLife.Player.Ped)

					HighLife:DisableCoreControls(false)
				end
			end
		end

		Wait(1)
	end
end)