CreateThread(function()
	AddRelationshipGroup("hostile_player")

	for pedModel,pedData in pairs(Config.NPC) do
		if pedData.hostile then
			AddRelationshipGroup("hostile_" .. pedModel)

			SetRelationshipBetweenGroups(5, GetHashKey("hostile_" .. pedModel), GetHashKey("hostile_player"))
			SetRelationshipBetweenGroups(5, GetHashKey("hostile_player"), GetHashKey("hostile_" .. pedModel))
		end
	end

	local tempNetPed = nil

	while true do
		if HighLife.Player.MiscSync ~= nil and HighLife.Player.MiscSync.NPCArray ~= nil then
			for i=1, #HighLife.Player.MiscSync.NPCArray do
				if NetworkDoesNetworkIdExist(HighLife.Player.MiscSync.NPCArray[i].netID) then
					tempNetPed = NetToPed(HighLife.Player.MiscSync.NPCArray[i].netID)

					if DoesEntityExist(tempNetPed) then
						if Config.NPC[HighLife.Player.MiscSync.NPCArray[i].hash].hostile or Config.NPC[HighLife.Player.MiscSync.NPCArray[i].hash].lethal then
							SetPedFleeAttributes(tempNetPed, 0, 0)

							SetPedCombatAttributes(tempNetPed, 0, true)
							SetPedCombatAttributes(tempNetPed, 1, true)
							SetPedCombatAttributes(tempNetPed, 2, true)
							SetPedCombatAttributes(tempNetPed, 3, true)
							SetPedCombatAttributes(tempNetPed, 4, false)
							SetPedCombatAttributes(tempNetPed, 52, true)

							SetPedSeeingRange(tempNetPed, 30.0)
							SetPedHearingRange(tempNetPed, 30.0)

							SetPedAlertness(tempNetPed, 3)
							SetPedCombatAbility(tempNetPed, 2)

							SetPedCombatRange(tempNetPed, 2)
							SetPedDiesWhenInjured(tempNetPed, false)

							SetPedRelationshipGroupHash(tempNetPed, GetHashKey("hostile_" .. HighLife.Player.MiscSync.NPCArray[i].hash))
						end
					end
				end
			end
		end 

		Wait(2000)
	end
end)