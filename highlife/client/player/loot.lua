local lootingPlayer = nil
local closestLootable = nil

RegisterNetEvent('HighLife:Loot:EnableLooting')
AddEventHandler('HighLife:Loot:EnableLooting', function(status)
	HighLife.Other.LootingEnabled = status
end)

CreateThread(function()
	local foundPed = nil
	local closestPlayer, distance = nil

	while true do
		if HighLife.Settings.Development or HighLife.Other.LootingEnabled then
			foundPed = nil
			closestPlayer, distance = nil

			closestLootable = nil

			if not IsAnyJobs({'police', 'ambulance'}) then
				closestPlayer, distance = GetClosestPlayer()

				if distance ~= -1 and distance < 1.5 then
					foundPed = GetPlayerPed(closestPlayer)

					if IsHighLifeGradeDead(foundPed) then						
						closestLootable = closestPlayer
					else
						if not IsPedInAnyVehicle(foundPed) then
							if Entity(foundPed).state.knocked_out or IsEntityPlayingAnim(foundPed, "random@arrests", "idle_2_hands_up", 3) or IsEntityPlayingAnim(foundPed, 'missminuteman_1ig_2', 'handsup_enter', 3) or IsEntityPlayingAnim(foundPed, 'mp_arresting', 'idle', 3)  then							
								closestLootable = closestPlayer
							end
						end
					end
				end
			end
		end
		
		Wait(500)
	end
end)

CreateThread(function()
	local lootPlayerPos = nil

	while true do
		lootPlayerPos = nil

		if HighLife.Settings.Development or HighLife.Other.LootingEnabled then
			if closestLootable ~= nil and not HighLife.Player.Dead and not HighLife.Player.Cuffed and not HighLife.Player.InAmbulance and not IsPedBeingStunned(HighLife.Player.Ped, 0) and not HighLife.Player.InVehicle and HighLife.Player.Dragging == nil then
				if not RageUI.Visible(RMenu:Get('player', 'confiscate')) then
					lootPlayerPos = GetEntityCoords(GetPlayerPed(closestLootable))

					Draw3DCoordText(lootPlayerPos.x, lootPlayerPos.y, lootPlayerPos.z + 0.25, 'Press [~y~E~s~] to search')

					if HighLife.Player.LootingPlayer ~= nil then
						TriggerServerEvent('HighLife:Loot:RemoveBeingLooted', HighLife.Player.LootingPlayer)

						ResetConfiscation()

						HighLife.Player.LootingPlayer = nil
					end
					
					if IsControlJustReleased(0, 38) then
						lootingPlayer = closestLootable

						HighLife:SearchPlayer(false, GetPlayerServerId(lootingPlayer), false, true)
					end
				end
			else
				if HighLife.Player.LootingPlayer ~= nil then
					TriggerServerEvent('HighLife:Loot:RemoveBeingLooted', HighLife.Player.LootingPlayer)

					ResetConfiscation()

					HighLife.Player.LootingPlayer = nil
				end
			end
		end

		Wait(1)
	end
end)
