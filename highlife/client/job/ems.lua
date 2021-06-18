local inSniperStateDeath = false

RegisterNetEvent('HighLife:EMS:Stabilize')
AddEventHandler('HighLife:EMS:Stabilize', function()
	-- Not really a thing anymore
	if not inSniperStateDeath then
		HighLife.Player.IsStable = true

		HighLife.Player.Bleeding = false

		-- MumbleSetAudioInputDistance(-1.0)

		Notification_AboveMap("~y~You have been stabilized")
	end
end)

RegisterNetEvent('HighLife:EMS:CauseOfDeath')
AddEventHandler('HighLife:EMS:CauseOfDeath', function(deathHash, hitPart)
	CreateThread(function()
		local patient, distance = GetClosestPlayer()
		
		if distance ~= -1 and distance <= 3.0 and not HighLife.Player.InVehicle then	
			if IsHighLifeGradeDead(GetPlayerPed(patient)) then	
				local cause_found = nil
	
				TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				
				Wait(7000)

				for deathReason,deathData in pairs(Config.DeathReasons) do
					for i=1, #deathData.hashes do
						if deathData.hashes[i] == tonumber(deathHash) then
							cause_found = deathData.reason

							break
						end
					end

					if cause_found ~= nil then
						break
					end
				end

				if cause_found ~= nil then
					Notification_AboveMap('~b~' .. cause_found)

					if hitPart ~= nil then
						Notification_AboveMap('~o~The injuries seem to be prevelant towards the ' .. string.lower(hitPart))
					end
				else
					Notification_AboveMap('~o~You are unsure of the patients cause of injury')
				end

				Wait(1000)
	
				ClearPedTasks(HighLife.Player.Ped)
			else
				Notification_AboveMap("~r~No injured patients nearby")
			end
		else
			Notification_AboveMap("~r~No patients nearby")
		end
	end)
end)