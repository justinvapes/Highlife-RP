AddEventHandler('playerSpawned', function(bypass)
	CreateThread(function()
		exports.spawnmanager:setAutoSpawn(false)
		
		if HighLife.Player.GoForRollProgram then
			if not HighLife.Player.BlockSwitchCam then 
				StartPlayerSwitch(HighLife.Player.Ped, HighLife.Player.Ped, 1090, 1)
			end
		end

		if not exports.highlife_assets:GetAlreadySpawned() or HighLife.Player.SwitchingCharacters then
			HighLife.Player.SwitchingCharacters = false
			
			if HighLife.Player.LoginPosition ~= nil then
				if HighLife.Player.LoginPosition.z > 2000.0 then
					HighLife.Player.LoginPosition = Config.SpawnPoints[math.random(#Config.SpawnPoints)]
				end

				HighLife:TempDisable()

				SetEntityCoordsNoOffset(HighLife.Player.Ped, HighLife.Player.LoginPosition, false, false, false)
				SetEntityHeading(HighLife.Player.Ped, HighLife.Player.Heading or 0.0)

				HighLife.Player.FirstSpawn = true

				exports.highlife_assets:SetAlreadySpawned(true)
			else
				FreezeEntityPosition(HighLife.Player.Ped, true)

				local thisRandomSpawn = Config.SpawnPoints[math.random(#Config.SpawnPoints)] -- Returns a vec4

				RequestCollisionAtCoord(thisRandomSpawn.x, thisRandomSpawn.y, thisRandomSpawn.z)

				HighLife:TempDisable()

				SetEntityCoordsNoOffset(HighLife.Player.Ped, thisRandomSpawn, false, false, false)
				SetEntityHeading(HighLife.Player.Ped, thisRandomSpawn.w)

				local time = GameTimerPool.GlobalGameTime

				while (not HasCollisionLoadedAroundEntity(HighLife.Player.Ped) and (GameTimerPool.GlobalGameTime - time) < 5000) do
					Wait(0)
				end

				HighLife.Player.FirstSpawn = true

				exports.highlife_assets:SetAlreadySpawned(true)
			end

			HighLife.Player.GoForRollProgram = true

			if HighLife.Player.FirstSpawn or bypass then
				FreezeEntityPosition(HighLife.Player.Ped, true)

				local time = GameTimerPool.GlobalGameTime

				while (not HasCollisionLoadedAroundEntity(HighLife.Player.Ped) and (GameTimerPool.GlobalGameTime - time) < 5000) do
					Wait(0)
				end

				FreezeEntityPosition(HighLife.Player.Ped, false)

				exports.highlife_assets:SetAlreadySpawned(true)

				HighLife.Player.FirstSpawn = false

				TriggerServerEvent('getGarageInfo') -- FIXME: Deprecate this - from LS Customs
			end
		end
	end)
end)

RegisterNetEvent('HighLife:ImageNotification:Send')
AddEventHandler('HighLife:ImageNotification:Send', function(adType, header, text, beep)
	DisplayImageNotification(adType, header, text, beep)
end)

RegisterNetEvent('HighLife:Connection:Disconnect')
AddEventHandler('HighLife:Connection:Disconnect', function(disconnectData)
	if disconnectData ~= nil then
		local thisData = json.decode(disconnectData)

		print(string.format("^3%s^7 (ID: ^3%s^7) disconnected [%s] - Reason: ^3%s%s", thisData.name, thisData.id, NowTimestamp(), thisData.reason, (((HighLife.Player.IsStaff or HighLife.Player.IsHelper) and thisData.coords.x ~= nil) and ' ^7- At street: ^4' .. GetStreetNameFromHashKey(GetStreetNameAtCoord(thisData.coords.x, thisData.coords.y, thisData.coords.z)) or '')))
	end
end)

RegisterNetEvent('HighLife:RMS')
AddEventHandler('HighLife:RMS', function()
	exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
		TriggerServerEvent('Rogue:report', GetPlayerName(PlayerId()) .. ' (MS)```' .. data, 'mass')
	end)
end)

RegisterNetEvent('HighLife:Player:SetInventory')
AddEventHandler('HighLife:Player:SetInventory', function(inventoryData)
	HighLife.Player.Inventory = json.decode(inventoryData)
end)

RegisterNetEvent('HighLife:Player:SMT')
AddEventHandler('HighLife:Player:SMT', function(name, amount)
	AddAmmoToPed(HighLife.Player.Ped, GetHashKey(name), tonumber(amount))
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	HighLife.Player.LastJob = HighLife.Player.Job.name

	HighLife.Player.Job.name = job.name
	HighLife.Player.Job.rank = job.grade
	HighLife.Player.Job.rank_name = job.grade_name

	RageUI.CloseAll()

	if (HighLife.Player.Job.name ~= 'police' and HighLife.Player.LastJob == 'police') or (HighLife.Player.Job.name ~= 'fib' and HighLife.Player.LastJob == 'fib') then		
		RemoveAllPedWeapons(HighLife.Player.Ped, true)
		
		TriggerServerEvent('HighLife:Player:RemoveAllOfItem', {'ram', 'pvest', 'tracker', 'gasmask', 'stingers', 'handcuffs', 'plastic_handcuffs', 'gsrkit', 'medical_kit'})

		SetPedArmour(HighLife.Player.Ped, 0)

		SendNUIMessage({
			nui_reference = 'bodycam',
			force_close = true
		})

		TriggerEvent('HighLife:Player:Save')
	end

	if (HighLife.Player.Job.name ~= 'ambulance' and HighLife.Player.LastJob == 'ambulance') then
		TriggerServerEvent('HighLife:Player:RemoveAllOfItem', {'tracker', 'medical_kit'})

	end

	if IsAnyJobs({'police', 'ambulance'}) then
		TriggerServerEvent('HighLife:Services:AddTracker')
	end
end)

-- Remove this, this basically just handles the phone sound event from eithin highlife
RegisterNetEvent('gcPhone:receiveMessage')
AddEventHandler("gcPhone:receiveMessage", function(message, coords, call_id)
	if message ~= nil and message.owner == 0 then
		HighLife.SpatialSound.CreateSound('TextTone')
	end
end)