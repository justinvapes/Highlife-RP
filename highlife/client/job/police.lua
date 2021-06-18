-- Events

RegisterNetEvent('HighLife:Police:SendFine')
AddEventHandler('HighLife:Police:SendFine', function(amount, isMedical)
	TriggerServerEvent('HighLife:Police:Fine', amount, isMedical)
end)

RegisterNetEvent('HighLife:Police:PlayerCuff')
AddEventHandler('HighLife:Police:PlayerCuff', function(isPlastic)
	local player, distance = GetClosestPlayer()

	if player ~= -1 and distance < 2.0 then
		if IsAnyJobs({'police'}) then
			TriggerServerEvent('HighLife:Player:Cuff', GetPlayerServerId(player), isPlastic)
		else
			if not IsPedInAnyVehicle(GetPlayerPed(player)) and IsEntityPlayingAnim(GetPlayerPed(player), "random@arrests", "idle_2_hands_up", 3) or IsEntityPlayingAnim(GetPlayerPed(player), 'missminuteman_1ig_2', 'handsup_enter', 3) then
				TriggerServerEvent('HighLife:Player:Cuff', GetPlayerServerId(player), isPlastic)
			else
				Notification_AboveMap('~r~Person must have their hands up')
			end
		end
	else
		Notification_AboveMap('~r~Nobody nearby to cuff')
	end
end)

RegisterNetEvent('HighLife:Police:GSRTest')
AddEventHandler('HighLife:Police:GSRTest', function()
	local player, distance = GetClosestPlayer()

	if distance ~= -1 and distance <= 3.0 then
		TaskStartScenarioInPlace(HighLife.Player.Ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)

		TriggerServerEvent('HighLife:Player:MeAction', 'swabs hands for gunshot residue')
		
		Wait(10000)
		
		ClearPedTasks(HighLife.Player.Ped)

		HighLife:ServerCallback('HighLife:GSR:Check', function(hasShotRecently)
			if hasShotRecently then
				Notification_AboveMap('GSR_POSITIVE')
			else
				Notification_AboveMap('GSR_NEGATIVE')
			end
		end, GetPlayerServerId(player))
	else
		Notification_AboveMap('GSR_NEARBY')
	end
end)

-- @TODO: REFACTOR
RegisterNetEvent("police:notify")
AddEventHandler("police:notify", function(icon, type, sender, title, text)
	CreateThread(function()
		SetNotificationTextEntry("STRING")
		AddTextComponentString(text)
		SetNotificationMessage(icon, icon, true, type, sender, title, text)
		DrawNotification(false, true)
	end)
end)
-- @TODO: REFACTOR

function HighLife:SearchPlayer(isPatdown, specificPlayer, isStaff, isLooting)
	local closestPlayer, distance = GetClosestPlayer()

	if specificPlayer ~= nil or (distance ~= -1 and distance < 3) then
		local foundPlayer = specificPlayer or GetPlayerServerId(closestPlayer)

		local isDead = nil

		if isLooting then
			isDead = IsHighLifeGradeDead(GetPlayerPed(closestPlayer))
		end

		HighLife:ServerCallback('HighLife:Player:GetData', function(data)
			if data ~= nil then
				if data.error ~= nil then
					Notification_AboveMap(data.error)
				else
					if not isStaff then
						MenuVariables.SearchMenu.SearchEntity = GetPlayerPed(closestPlayer)
					end

					MenuVariables.SearchMenu.ExtraData = {
						isStaff = isStaff,
						isLooting = isLooting,
						isPatdown = isPatdown,
						playerID = foundPlayer
					}

					if not isLooting then
						MenuVariables.SearchMenu.PlayerData = data

						RMenu:Get('player', 'confiscate'):SetTitle('Confiscate')
						RMenu:Get('player', 'confiscate'):SetSubtitle('~o~Keep your hands to yourself')
					else
						MenuVariables.SearchMenu.SlowPlayerData = data

						RMenu:Get('player', 'confiscate'):SetTitle('Loot')
						RMenu:Get('player', 'confiscate'):SetSubtitle('~o~Gotta go fast')
					end

					RageUI.Visible(RMenu:Get('player', 'confiscate'), true)

					if not isStaff and not IsAnyJobs({'police', 'ambulance'}) then
						HighLife.Player.LootingPlayer = foundPlayer

						TriggerServerEvent('HighLife:Player:MeAction', '~y~searches person')

						TaskTurnPedToFaceEntity(HighLife.Player.Ped, MenuVariables.SearchMenu.SearchEntity, 1000)

						if IsHighLifeGradeDead(MenuVariables.SearchMenu.SearchEntity) then
							Wait(1000)

							TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						end
					end
				end
			end
		end, foundPlayer, false, isStaff, isLooting, isDead)
	else
		Notification_AboveMap('~r~Nobody nearby to search')
	end
end

-- FIXME: Deprecate
function HighLife:PoliceSearchPlayer(isPatdown, specificPlayer, isStaff, isLooting)
	self:SearchPlayer(isPatdown, specificPlayer, isStaff, isLooting)
end

function HighLife:PoliceRevokeLicense(license, perm)
	local closestPlayer, distance = GetClosestPlayer()
	
	if license ~= nil then
		if distance ~= -1 and distance < 3 then
			TriggerServerEvent("HighLife:Player:RemoveLicense", GetPlayerServerId(closestPlayer), license, perm)
		else
			Notification_AboveMap('~r~Nobody nearby to revoke license')
		end
	end
end

function HighLife:GetClosestPlayerID()
	local closestPlayer, distance = GetClosestPlayer()

	local thisPlayerID = GetPlayerServerId(closestPlayer)
   
    if distance ~= -1 and distance < 3 and thisPlayerID ~= nil then
    	TriggerServerEvent('HighLife:Playtime:Get', thisPlayerID, true)

    	HighLife:ServerCallback('HighLife:Player:GetData', function(data)
    		MenuVariables.ID = {
    			dob = data.dob,
    			name = data.firstname .. " " .. data.lastname,
    			job = ((data.job.grade_label ~= nil and data.job.grade_label ~= '') and data.job.label .. ' - ' .. data.job.grade_label or data.job.label),
    			id = thisPlayerID,
    			licenses = json.decode(data.licenses)
    		}

    		if not RageUI.Visible(RMenu:Get('id', 'main')) then
    			RageUI.Visible(RMenu:Get('id', 'main'), true)
    		end
		end, thisPlayerID, true)
    else
    	Notification_AboveMap('~r~Nobody nearby')
    end
end

function HighLife:FinePlayer(amount, funeral)
	local t, distance = GetClosestPlayer()
	
	if distance ~= -1 and distance < 3 then
		if tonumber(amount) == -1 then
			TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)

			local input = openKeyboard('FINE_AMOUNT', 'Amount to fine the citizen', nil, MenuVariables.Detention.Morgue.Person)

			if input ~= nil and tonumber(input) ~= nil then
				amount = tonumber(input)
			end
			
			if tonumber(amount) ~= -1 then
				if not funeral then
					TriggerServerEvent('HighLife:Player:MeAction', 'writes citation for $' .. amount)
				end

				TriggerServerEvent("HighLife:Police:SendFine", GetPlayerServerId(t), tonumber(amount), funeral)
			end

			ClearPedTasks(HighLife.Player.Ped)
		else
			TriggerServerEvent("HighLife:Police:SendFine", GetPlayerServerId(t), tonumber(amount), funeral)
		end
	else
		Notification_AboveMap('~r~Nobody nearby to fine')
	end
end