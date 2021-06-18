local nearTrash = nil
local closestObject = nil

local searched_trash = {}

local isSearching = false

CreateThread(function()
	while true do
		nearTrash = nil
		closestObject = nil

		if not HighLife.Player.CD and not HighLife.Player.InVehicle and not HighLife.Player.Dead and not HighLife.Player.Cuffed and not isSearching then
			for i=1, #Config.Trash.entities do
				closestObject = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, Config.Trash.entities[i], false, false)

				if closestObject ~= 0 and closestObject ~= nil then
					if IsEntityUpright(closestObject, 5.0) then
						nearTrash = closestObject
					end

					break
				end
			end
		end

		Wait(2000)
	end
end)

CreateThread(function()
	local validSearch = false

	local trashPos = nil

	while true do
		validSearch = true

		if nearTrash ~= nil and not isSearching then
			trashPos = GetEntityCoords(nearTrash)

			if Vdist(HighLife.Player.Pos, trashPos) < 1.5 then
				Draw3DCoordText(trashPos.x, trashPos.y, trashPos.z + 1.0, '[~y~E~s~] to search trash')

				if IsControlJustReleased(0, 38) then
					for i=1, #searched_trash do
						if Vdist(trashPos, searched_trash[i].pos) < 5.0 or nearTrash == searched_trash[i].entity then
							if GameTimerPool.GlobalGameTime > searched_trash[i].time then
								table.remove(searched_trash, i)

								break
							end
							
							validSearch = false

							break
						end
					end

					HighLife:DisableCoreControls(true)

					isSearching = true

					TaskTurnPedToFaceEntity(HighLife.Player.Ped, nearTrash, -1)

					Wait(1500)

					TaskStartScenarioInPlace(HighLife.Player.Ped, 'PROP_HUMAN_BUM_BIN', 0, true)

					Wait(5000)

					if validSearch then
						if IsPedActiveInScenario(HighLife.Player.Ped) then
							HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(thisToken)
								TriggerServerEvent('HighLife:Dumpster:Dive', thisToken)
							end)

							table.insert(searched_trash, {
								pos = trashPos,
								entity = nearTrash,
								time = GameTimerPool.GlobalGameTime + (900 * 1000),
							})
						end
					else
						Notification_AboveMap('You found nothing of interest in the trash')
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