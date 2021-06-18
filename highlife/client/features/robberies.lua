local softLockRobberyHelpText = false

local awaitingCallback = false
local tempLocationConfig = nil

local ptfx_array_list = {}
local sound_array_list = {}

local OpenVaultDoors = {}
local ShouldBeClosed = {}

local forceStopNiceOpen = false

local isHacking = false

local isSearching = false
local isRobbingTill = false
local isComputerRobbery = false

local isRobbingUD = false

local isDrilling = false
local inDrillingMinigame = false

local LocationAttemptArray = {}

local searchObject = nil

local lastUpdateTime = GameTimerPool.GlobalGameTime

local drill_pin_break_intervals = {0.33, 0.48, 0.63, 0.78}

local searchLocationReference = nil
local UDTakeLocationReference = nil
local hackingLocationReference = nil
local drillingLocationReference = nil
local explosiveLocationReference = nil
local tillrobberyLocationReference = nil
local computerRobberyLocationReference = nil

RegisterNetEvent('HighLife:Robberies:GlobalData')
AddEventHandler('HighLife:Robberies:GlobalData', function(robberyData)
	HighLife.Other.RobberyData = json.decode(robberyData)

	lastUpdateTime = GameTimerPool.GlobalGameTime
end)

RegisterNetEvent('HighLife:Robberies:OpenVaultDoor')
AddEventHandler('HighLife:Robberies:OpenVaultDoor', function(locationReference, isClose)
	OpenClosestVaultDoorNicelyAtCoords(locationReference, isClose)

	if isClose then
		ShouldBeClosed[locationReference] = true
	end
end)

RegisterNetEvent('HighLife:Robberies:CommercialAtt')
AddEventHandler('HighLife:Robberies:CommercialAtt', function()
	if math.random(3) == 1 then
		HighLife:DispatchEvent('commercial_breakin_att')
	end
end)

RegisterNetEvent('HighLife:Robberies:Attempt')
AddEventHandler('HighLife:Robberies:Attempt', function(locationReference)
	if LocationAttemptArray[locationReference] ~= nil then
		LocationAttemptArray[locationReference] = LocationAttemptArray[locationReference] + 1
	else
		LocationAttemptArray[locationReference] = 1
	end

	for k,v in pairs(LocationAttemptArray) do
		if v >= Config.Robberies.Types.store.AttemptCount then
			LocationAttemptArray[locationReference] = nil

			HighLife:DispatchEvent('robbery_store_att')

			HighLife.SpatialSound.CreateSound('BankRobbery', {
				reference = 'alarm_bank_' .. locationReference,
				pos = (Config.Robberies.Stores[locationReference].ped_pos ~= nil and Config.Robberies.Stores[locationReference].ped_pos or HighLife.Player.Pos) + vector3(0.0, 0.0, 3.0)
			})

			break
		end
	end
end)

RegisterNetEvent('HighLife:Robberies:ExplodePosition')
AddEventHandler('HighLife:Robberies:ExplodePosition', function(locationReference)
	if HighLife.Player.MiscSync.UDBlown then
		if Config.Robberies.Depository.explosive_points[locationReference] ~= nil then
			TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

			Wait(7000)

			ClearPedTasks(HighLife.Player.Ped)

			Notification_AboveMap("They're on a timer, so ~o~brace yourself!")

			Wait(9000)

			AddExplosion(Config.Robberies.Depository.explosive_points[locationReference].pos, 32, 0.6, true, false, 1.5)

			HighLife:DispatchEvent('explosion')

			TriggerServerEvent('HighLife:MiscGlobals:SetSyncedGlobal', locationReference, true)
		end
	end
end)

RegisterNetEvent('HighLife:Robberies:TestExplosive')
AddEventHandler('HighLife:Robberies:TestExplosive', function()
	if explosiveLocationReference ~= nil then
		if not HighLife.Player.MiscSync.UDBlown then
			if Config.Robberies.Depository.explosive_points[explosiveLocationReference].initial ~= nil then
				TriggerServerEvent('HighLife:Robberies:StartAction', false, 'depository', explosiveLocationReference)
			end
		else
			TriggerServerEvent('HighLife:Robberies:ExplodePosition', explosiveLocationReference)
		end
	else
		Notification_AboveMap('What are you, a ~r~terrorist~s~?')
	end
end)

AddEventHandler('HighLife:Robberies:Datacrack', function(success, reference)
	if isComputerRobbery then
		if success then
			TriggerServerEvent('HighLife:Robberies:CompleteStoreComputer', reference)
		end
		
		isComputerRobbery = false
	end
end)

RegisterNetEvent('HighLife:Robberies:Start')
AddEventHandler('HighLife:Robberies:Start', function(robberyType, locationReference, method)
	if method == 'drilling' then
		StartDrilling(Config.Robberies.Types[robberyType], locationReference)
	elseif method == 'hacking' then
		StartHacking(robberyType, locationReference)
	elseif method == 'rob_till' then
		StartRobbingTill(locationReference)
	elseif method == 'rob_store_computer' then
		StartRobbingStoreComputer(locationReference)
	elseif method == 'search_steal' then
		StartSearchingArea(locationReference)
	elseif method == 'depository' then
		StartDepositoryRobbery()
	end
end)

function OpenClosestVaultDoorNicelyAtCoords(locationReference, isClose)
	if Config.Robberies.Banks[locationReference].VaultDoor ~= nil then
		isClose = not isClose
	end

	CreateThread(function()
		local rotationOffset = 95.0

		local vaultDoor = GetClosestObjectOfType(Config.Robberies.Banks[locationReference].door_hack.pos, Config.Robberies.Banks[locationReference].VaultDoor or GetHashKey('v_ilev_gb_vauldr'), false, false, false)
						
		if vaultDoor ~= 0 then
			local desiredHeading = CalculateHeadingNoFucksGiven(GetEntityHeading(vaultDoor), rotationOffset, isClose)

			OpenVaultDoors[locationReference] = desiredHeading

			if isClose then
				if Config.Robberies.Banks[locationReference].VaultDoor == nil then
					OpenVaultDoors[locationReference] = nil
				end

				ShouldBeClosed[locationReference] = nil

				desiredHeading = CalculateHeadingNoFucksGiven(GetEntityHeading(vaultDoor), rotationOffset, isClose)
			else
				if Config.Robberies.Banks[locationReference].VaultDoor ~= nil then
					OpenVaultDoors[locationReference] = nil
				end
			end

			while math.floor(GetEntityHeading(vaultDoor)) ~= math.floor(desiredHeading) do
				if isClose then
					SetEntityHeading(vaultDoor, (GetEntityHeading(vaultDoor) + 0.1))
				else
					SetEntityHeading(vaultDoor, (GetEntityHeading(vaultDoor) - 0.1))
				end

				Wait(1)
			end
		end
	end)
end

local quicktimeKeys = { 172, 173, 174, 175 }

function RandomHotkeys()
	primary = quicktimeKeys[math.random(#quicktimeKeys)]
	secondary = nil

	while secondary == nil do
		local randomKey = quicktimeKeys[math.random(#quicktimeKeys)]

		if randomKey ~= primary then
			secondary = randomKey

			break
		end
	end

	return {
		primary,
		secondary,
	}
end

local validKeyLabels = {
	[172] = 'INPUT_CELLPHONE_UP',
	[173] = 'INPUT_CELLPHONE_DOWN',
	[174] = 'INPUT_CELLPHONE_LEFT',
	[175] = 'INPUT_CELLPHONE_RIGHT',
}

function StartDepositoryRobbery()
	local explosionCount = 0

	local thisLocationConfig = Config.Robberies.Depository

	TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

	Wait(7000)

	if IsPedActiveInScenario(HighLife.Player.Ped) then
		ClearPedTasks(HighLife.Player.Ped)

		Notification_AboveMap("They're on a timer, so ~o~brace yourself!")

		Wait(9000)

		HighLife:DispatchEvent('union_robbery')

		while explosionCount ~= 15 do 
			explosionCount = explosionCount + 1

			AddExplosion(thisLocationConfig.explosive_points.outside_wall.pos, (explosionCount == 14 and 21 or 32), 1.0, true, false, 1.5)

			if explosionCount == 12 then
				TriggerServerEvent('HighLife:MiscGlobals:SetSyncedGlobal', 'UDBlown', true)

				HighLife.SpatialSound.CreateSound('UnionAlarm', {
					reference = 'alarm_depository',
					pos = thisLocationConfig.alarm_position
				})
			end
			
			Wait(100)
		end
	end
end

function StartSearchingArea(thisLocationReference)
	if not isSearching then
		HighLife:DispatchEvent('commercial_breakin')
		
		local thisLocationConfig = Config.Robberies.Search[thisLocationReference]

		if thisLocationConfig.AlarmPos ~= nil then
			HighLife.SpatialSound.CreateSound('ContainerRobbery', {
				reference = 'alarm_search_' .. thisLocationReference,
				pos = thisLocationConfig.AlarmPos
			})
		end

		isSearching = true

		local objectNetID = ObjToNet(searchObject)

		searchObject = nil

		local initTime = GameTimerPool.GlobalGameTime
		local decreaseTimer = GameTimerPool.GlobalGameTime + 5000
		local currentGameTime = GameTimerPool.GlobalGameTime

		local successSearch = false

		CreateThread(function()
			local progress = 0

			local waitingKey = nil

			local currentKeys = RandomHotkeys()

			TaskStartScenarioInPlace(HighLife.Player.Ped, 'PROP_HUMAN_PARKING_METER', -1, true)

			while isSearching do
				if waitingKey == nil then
					waitingKey = currentKeys[1]
				end

				if GameTimerPool.GlobalGameTime > (initTime + 3000) then
					if not IsPedUsingAnyScenario(HighLife.Player.Ped) then
						isSearching = false

						break
					end 
				end

				if GameTimerPool.GlobalGameTime > (decreaseTimer + 1000) then
					decreaseTimer = GameTimerPool.GlobalGameTime

					if progress > thisLocationConfig.DecreaseStep then
						progress = progress - thisLocationConfig.DecreaseStep
					end
				end

				if GameTimerPool.GlobalGameTime > (currentGameTime + 5000) then
					currentGameTime = GameTimerPool.GlobalGameTime

					currentKeys = RandomHotkeys()

					waitingKey = currentKeys[1]
				end

				if IsControlJustReleased(0, waitingKey) then
					-- switch to the other
					progress = progress + thisLocationConfig.KeyStep

					for i=1, #currentKeys do 
						if currentKeys[i] ~= waitingKey then
							waitingKey = currentKeys[i]

							break
						end
					end
				end

				if HighLife.Settings.Development then
					progress = 1.0
				end

				Bar.DrawProgressBar('Break in', (progress > 1.0 and 1.0 or progress), 0, { r = 225, g = 50, b = 50 })

				DisplayHelpText('Press ~' .. validKeyLabels[waitingKey] .. '~ to break in', true)

				DrawBottomText('Press ~y~E~w~ to stop ~r~breaking in', 0.5, 0.95, 0.4)

				if progress >= 1.0 then
					successSearch = true

					break
				end

				if IsControlJustReleased(0, 38) then
					break
				end

				Wait(1)
			end

			isSearching = false

			ClearPedTasks(HighLife.Player.Ped)

			if successSearch then
				TriggerServerEvent('HighLife:Robberies:CompleteSearch', thisLocationReference, objectNetID)
			end

			isSearching = false
		end)
	end
end

function StartUD()
	local vault_door = GetClosestObjectOfType(-4.22, -686.60, 16.13, 5.0, GetHashKey('v_ilev_fin_vaultdoor'), false, false, false)

	FreezeEntityPosition(vault_door, true)

	SetEntityHeading(vault_door, 240.0)
end

function StartRobbingStoreComputer(thisLocationReference)
	isComputerRobbery = true

	SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)

	HighLife:DispatchEvent('robbery_store_computer')

	HighLife.SpatialSound.CreateSound('BankRobbery', {
		reference = 'alarm_store_' .. thisLocationReference,
		pos = Config.Robberies.Stores[thisLocationReference].ped_pos + vector3(0.0, 0.0, 3.0)
	})

	DataCrackStart(6, thisLocationReference)
end

function StartRobbingTill(thisLocationReference)
	if not isRobbingTill then
		isRobbingTill = true

		SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)

		HighLife:DispatchEvent('robbery_store')

		HighLife.SpatialSound.CreateSound('BankRobbery', {
			reference = 'alarm_store_' .. thisLocationReference,
			pos = Config.Robberies.Stores[thisLocationReference].ped_pos + vector3(0.0, 0.0, 3.0)
		})

		CreateThread(function()
			local devRobtime = nil
			local thisRobTime = math.random(Config.Robberies.Types.store.time.min, Config.Robberies.Types.store.time.max) * 1000
			local thisSequence = nil

			if thisSequence ~= nil then
				ClearSequenceTask(thisSequence)
			end

			local foundTill = nil

			local thisTill = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, Config.Robberies.Types.store.entities.till.model, true, true, true)
			local thisTill2 = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, Config.Robberies.Types.store.entities.till_2.model, true, true, true)

			if thisTill ~= 0 then
				foundTill = thisTill
			end

			if thisTill2 ~= 0 then
				foundTill = thisTill2
			end

		    if foundTill ~= nil then
		    	local playerTillPos = GetOffsetFromEntityInWorldCoords(foundTill, 0.0, -0.72, -1.1)
		    	local playerTillHeading = GetEntityHeading(foundTill)
				
				SetEntityCoords(HighLife.Player.Ped, playerTillPos)
				SetEntityHeading(HighLife.Player.Ped, playerTillHeading)

				local shouldHide = nil

				for k,v in pairs(Config.Robberies.Types.store.entities) do
					if GetEntityModel(foundTill) == v.model then
						shouldHide = v
						break
					end
				end

				if shouldHide ~= nil and shouldHide.switch ~= nil and shouldHide.switch then
					CreateModelSwap(HighLife.Player.Pos, 1.0, shouldHide.model, Config.Robberies.Types.store.entities.open_till.model, true)
				end

				RequestAnimDict(Config.Robberies.Types.store.animDictionary)

				while not HasAnimDictLoaded(Config.Robberies.Types.store.animDictionary) do
					Wait(50)
				end

				local success, thisSequence = OpenSequenceTask()

				TaskPlayAnim(0, Config.Robberies.Types.store.animDictionary, "enter", 8.0, -8.0, -1, 0, 0, 0, 0, 0)
				TaskPlayAnim(0, Config.Robberies.Types.store.animDictionary, "loop", 8.0, -8.0, devRobtime or thisRobTime, 1, 0, 0, 0, 0)
				TaskPlayAnim(0, Config.Robberies.Types.store.animDictionary, "exit", 8.0, -1.5, -1, 0, 0, 0, 0, 0)

				CloseSequenceTask(thisSequence)

				AnimpostfxPlay("CamPushInNeutral", 0, 0)

				TaskPerformSequence(HighLife.Player.Ped, thisSequence)

				RemoveAnimDict(Config.Robberies.Types.store.animDictionary)

				local bill_amounts = {10, 20, 50, 100}

				local robberyTotal = 0

				CreateThread(function()
					while isRobbingTill do
						DisplayHelpText('Press ~INPUT_PICKUP~ to ~y~stop robbing')

						if IsControlJustReleased(1, 38) then
							ClearPedTasks(HighLife.Player.Ped)

							isRobbingTill = false
						end

						DrawBottomText('Current take: ~r~$' .. robberyTotal, 0.5, 0.95, 0.4)

						Wait(1)
					end
				end)

				while isRobbingTill do
					Wait(100)

					local progress = GetSequenceProgress(HighLife.Player.Ped)
					local thisAnimTime = GetEntityAnimCurrentTime(HighLife.Player.Ped, Config.Robberies.Types.store.animDictionary, "loop", 3)

					if (thisAnimTime > 0.374 and thisAnimTime <= 0.484) or (thisAnimTime > 0.824 and thisAnimTime <= 0.92) then
						PlaySoundFrontend(-1, "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", true)

						local thisAmount = math.floor((bill_amounts[math.random(#bill_amounts)] + bill_amounts[math.random(#bill_amounts)] + bill_amounts[math.random(#bill_amounts)]) * 0.40)

						robberyTotal = robberyTotal + thisAmount
					end

					if progress == -1 then
						break
					end
				end

				softLockRobberyHelpText = true

				isRobbingTill = false

				TriggerServerEvent('HighLife:Robberies:Payout', thisLocationReference, robberyTotal)

				Wait(2000)

				softLockRobberyHelpText = false

				HighLife.Player.Robbable = false
			end
		end)
	end
end

function StartHacking(robberyType, thisLocationReference)
	if not isHacking then
		isHacking = true

		local thisLocationReferenceConfig = Config.Robberies.Banks[thisLocationReference]
		
		CreateThread(function()
			local thisAttempts = 0
			local maxAttempts = thisLocationReferenceConfig.HackingChances or Config.Robberies.Hacking.MaxAttempts

			local inAnim = true

			local alarmTriggered = false

			local preAnimTimer = GameTimerPool.GlobalGameTime

			TaskStartScenarioAtPosition(HighLife.Player.Ped, thisLocationReferenceConfig.door_hack.anim, thisLocationReferenceConfig.door_hack.pos, -1, false, false)

			if inAnim then
				function startHacking()
					thisAttempts = thisAttempts + 1

					TriggerEvent("mhacking:show")
					TriggerEvent("mhacking:start", 7, thisLocationReferenceConfig.HackingTime or Config.Robberies.Hacking.MaxTime, mycb)
				end

				function triggerAlarm()
					if not alarmTriggered then
						alarmTriggered = true
						
						HighLife:DispatchEvent('robbery')

						HighLife.SpatialSound.CreateSound('BankRobbery', {
							reference = 'alarm_bank_' .. thisLocationReference,
							pos = thisLocationReferenceConfig.alarm_position
						})
					end
				end

				function mycb(success, timeremaining, forceClose)
					TriggerEvent('mhacking:hide')

					if forceClose == nil then 
						if success then
							triggerAlarm()

							TriggerServerEvent('HighLife:Robberies:CompleteHack', thisLocationReference)

							ClearPedTasks(HighLife.Player.Ped)
						else
							-- failed, send the event!
							triggerAlarm()

							if thisAttempts ~= maxAttempts then
								startHacking()
							else
								-- max attempts reached
								ClearPedTasks(HighLife.Player.Ped)

								TriggerServerEvent('HighLife:Robberies:ResetProgress', thisLocationReference)
							end
						end
					else
						triggerAlarm()

						TriggerServerEvent('HighLife:Robberies:ResetProgress', thisLocationReference)

						ClearPedTasks(HighLife.Player.Ped)
					end
				end

				startHacking()
			end
		end)
	end
end

function StartDrilling(bank, thisLocationReference)
	isDrilling = true

	HighLife.Player.BypassFOVCheck = true

	local finalDrillingPos = nil
	local finalDrillingHeading = nil

	-- change to entity pos
	local vaultDoor = GetClosestObjectOfType(HighLife.Player.Pos, 10.0, GetHashKey('hei_prop_heist_safedepdoor'), false, false, false)
					
	if vaultDoor ~= 0 then
		finalDrillingPos = GetOffsetFromEntityInWorldCoords(vaultDoor, 0.1323, -0.53, -1.0)
		finalDrillingHeading = GetEntityHeading(vaultDoor)

	else
		return
	end

	local thisLocation = Config.Robberies.Banks[thisLocationReference]

	local drilling_success = false

	local drilling_minigame = nil

	local drill_move_modifier = 0.01

	local drill_current_speed = 0.6 -- 0.6
	local drill_current_position = 0.07
	local drill_current_heat = 0.0

	CreateThread(function()
		drilling_minigame = Scaleform.Request("DRILLING")

		while true do
			if drilling_minigame == nil then
				break
			end

			if inDrillingMinigame then				
				if drill_current_heat > 0.5 then
					drill_move_modifier = 0.005
				else
					drill_move_modifier = 0.01
				end

				if thisLocation.ExtendedDrilling ~= nil then
					drill_move_modifier = (drill_move_modifier / 2)
				end

				drilling_minigame:Draw2D()
			end

			Wait(0)
		end
	end)

	function UpdateDrill()
		local doOnce = true

		if drilling_minigame ~= nil then
			drilling_minigame:CallFunction("SET_SPEED", drill_current_speed)
			drilling_minigame:CallFunction("SET_HOLE_DEPTH", drill_current_position)
			drilling_minigame:CallFunction("SET_DRILL_POSITION", drill_current_position)
			drilling_minigame:CallFunction("SET_TEMPERATURE", drill_current_heat)

			for i=1, #drill_pin_break_intervals do
				if math.round(drill_current_position, 2) == drill_pin_break_intervals[i] then
					PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)

					if i == 4 then
						drilling_success = true

						Wait(2000)

						if doOnce then
							doOnce = false
							
							ClearPedTasks(HighLife.Player.Ped)	
						end
					end

					break
				end
			end
		end
	end

	CreateThread(function()
		while drilling_minigame == nil do
			Wait(0)
		end

		UpdateDrill()
	end)

	HighLife.Player.VisibleItemBlocker = true

	SetCurrentPedWeapon(HighLife.Player.Ped, Config.WeaponHashes.unarmed, true)

	SetEntityCoords(HighLife.Player.Ped, finalDrillingPos)
	SetEntityHeading(HighLife.Player.Ped, finalDrillingHeading)

	-- This removes the bag we set the player to have when the have the drill on the
	SetPedComponentVariation(HighLife.Player.Ped, 5, 0, 0, 0)

	RequestAnimDict(bank.animDictionary)

	while not HasAnimDictLoaded(bank.animDictionary) do
		Wait(50)
	end

	local bag_object = nil
	local drill_object = nil

	-- Create the bag alert
	HighLife:CreateObject(bank.entities.bag.model, { x = HighLife.Player.Pos.x, y = HighLife.Player.Pos.y, z = HighLife.Player.Pos.z }, GetEntityHeading(HighLife.Player.Ped), false, function(thisObject)
		bag_object = thisObject
	end)

	HighLife:CreateObject(bank.entities.drill.model, { x = HighLife.Player.Pos.x, y = HighLife.Player.Pos.y, z = HighLife.Player.Pos.z }, GetEntityHeading(HighLife.Player.Ped), false, function(thisObject)
		drill_object = thisObject
	end)

	while drill_object == nil or bag_object == nil do
		Wait(1)
	end

	SetEntityInvincible(bag_object, true)
	FreezeEntityPosition(bag_object, true)
	SetEntityCollision(bag_object, false, false)

	SetEntityInvincible(drill_object, true)
	FreezeEntityPosition(drill_object, true)
	SetEntityCollision(drill_object, false, false)

	AttachEntityToEntity(bag_object, HighLife.Player.Ped, GetPedBoneIndex(HighLife.Player.Ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
	AttachEntityToEntity(drill_object, HighLife.Player.Ped, GetPedBoneIndex(HighLife.Player.Ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)

	SetObjectAsNoLongerNeeded(bag_object)
	SetObjectAsNoLongerNeeded(drill_object)

	-- Create the drill alert

	local drilling_cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')

	SetCamCoord(drilling_cam, GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, vector3(0.9193, -0.5807, 0.0869)))
	PointCamAtCoord(drilling_cam, GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, vector3(0.137600004673, 0.4819, 0.4162)))

	ShakeCam(drilling_cam, 'HAND_SHAKE', 0.1)

	SetCamActive(drilling_cam, true)

	RenderScriptCams(true, false, 0, 1, 0, 0)

	-- TODO: Release all this shit - no idea which ones though
	RequestScriptAudioBank("HEIST_FLEECA_DRILL", 1)
	RequestScriptAudioBank("HEIST_FLEECA_DRILL_2", 1)
	RequestScriptAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 1)
	RequestScriptAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 1)
	RequestScriptAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 1)

	-- RELEASE_NAMED_SCRIPT_AUDIO_BANK

	sound_array_list['drilling'] = GetSoundId()

	-- Speeds up anims, leaving in for now as it's done in the *actual* R* script
	N_0x2208438012482a1a(HighLife.Player.Ped, 0, 1)
	
	for i=1, bank.maxAnimLength do
		ClearPedTasks(HighLife.Player.Ped)

		if bank.entities.bag.anims[i] ~= nil then
			local minusCount = 0

			if i ~= 1 then
				while bank.entities.bag.anims[i - minusCount] == nil do
					minusCount = minusCount + 1
				end
			
				StopEntityAnim(bag_object, bank.entities.bag.anims[i - minusCount].anim, bank.entities.bag.anims[i - minusCount].dict or bank.animDictionary, -1000.0)
			end

			PlayEntityAnim(bag_object, bank.entities.bag.anims[i].anim, bank.entities.bag.anims[i].dict or bank.animDictionary, 1000.0, 1, 1, 1, 0.0, 0)
		end

		if bank.entities.drill.anims[i] ~= nil then
			local minusCount = 0

			if i ~= 1 then
				while bank.entities.drill.anims[i - minusCount] == nil do
					minusCount = minusCount + 1
				end
			
				StopEntityAnim(drill_object, bank.entities.drill.anims[i - minusCount].anim, bank.entities.drill.anims[i - minusCount].dict or bank.animDictionary, -1000.0)
			end

			if bank.entities.drill.anims[i].sound ~= nil then
				inDrillingMinigame = true

				CreateThread(function()
					local lastDrillingTime = GameTimerPool.GlobalGameTime

					while inDrillingMinigame do
						if IsDisabledControlJustReleased(0, 200) then
							ClearPedTasks(HighLife.Player.Ped)
						end

						if GameTimerPool.GlobalGameTime > (lastDrillingTime + 1000) then
							lastDrillingTime = GameTimerPool.GlobalGameTime

							drill_current_position = drill_current_position + drill_move_modifier
							
							UpdateDrill()
						end

						DisableControlAction(0, 177, true)
						DisableControlAction(0, 194, true)
						DisableControlAction(0, 202, true)

						Wait(0)
					end
				end)

				sound_array_list['drilling'] = GetSoundId()

				PlaySoundFromEntity(sound_array_list['drilling'], bank.entities.drill.anims[i].sound.name, drill_object, bank.entities.drill.anims[i].sound.sound_set, 1, 0)

				-- TODO: cool idea but doesn't work at this time
				-- CreateThread(function()
				-- 	RequestNamedPtfxAsset('FM_Mission_Controler')

				-- 	while not HasNamedPtfxAssetLoaded('FM_Mission_Controler') do
				-- 		Wait(1)
				-- 	end

				-- 	while inDrillingMinigame and drill_object ~= nil do
				-- 		UseParticleFxAssetNextCall('FM_Mission_Controler')
				-- 		StartParticleFxLoopedOnEntity("scr_drill_out", drill_object, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false)

				-- 		Wait(1)
				-- 	end
				-- end)

				CreateThread(function()
					while not HasSoundFinished(sound_array_list['drilling']) do
						local thisF = (math.random(1, 10) / 10)
						
						SetVariableOnSound(sound_array_list['drilling'], "DrillState", thisF)

						drill_current_heat = thisF

						UpdateDrill()

						Wait(5000)
					end
				end)
			end

			PlayEntityAnim(drill_object, bank.entities.drill.anims[i].anim, bank.entities.drill.anims[i].dict or bank.animDictionary, 1000.0, 1, 1, 1, 0.0, 0)
		end

		if bank.entities.ped.anims[i] ~= nil then
			if bank.entities.ped.anims[i].anim == bank.initProps.fake_deposit_door.triggerAnim then
				inDrillingMinigame = false

				StopSound(sound_array_list['drilling'])

				drilling_minigame = nil

				ReleaseSoundId(sound_array_list['drilling'])
				
				if drilling_success then
					-- TODO: Stop the ptfx? - this is broken - might be able to fix but need to re-instate ptfx above
					-- StopParticleFxLooped(ptfx_array_list['drill_effect'], 0)
					
					CreateThread(function()
						local thisAnimCount = 1
						local safeDoor = GetClosestObjectOfType(HighLife.Player.Pos, 5.0, GetHashKey('hei_prop_heist_safedepdoor'), true, false, false)

						if safeDoor ~= nil and safeDoor ~= 0 then
							SetEntityDynamic(safeDoor, true)

							PlayEntityAnim(safeDoor, bank.initProps.fake_deposit_door.anims[i].anim, bank.initProps.fake_deposit_door.anims[i].dict or bank.animDictionary, 1000.0, 1, 1, 1, 0.0, 0)
							
							TriggerServerEvent('HighLife:Robberies:Payout', thisLocationReference)
						end
					end)
				else
					ClearPedTasks(HighLife.Player.Ped)
				end
			end
			
			-- check this
			if bank.entities.ped.anims[i].success ~= nil then
				if bank.entities.ped.anims[i].success and drilling_success then
					TaskPlayAnim(HighLife.Player.Ped, bank.entities.ped.anims[i].dict or bank.animDictionary, bank.entities.ped.anims[i].anim, 4.0, -8.0, -1, bank.entities.ped.anims[i].loop, 0, false, false, false)
				end
			else				
				TaskPlayAnim(HighLife.Player.Ped, bank.entities.ped.anims[i].dict or bank.animDictionary, bank.entities.ped.anims[i].anim, 4.0, -8.0, -1, bank.entities.ped.anims[i].loop, 0, false, false, false)
			end
		end

		Wait(10)

		if bank.entities.ped.anims[i] ~= nil then
			while IsEntityPlayingAnim(HighLife.Player.Ped, bank.entities.ped.anims[i].dict or bank.animDictionary, bank.entities.ped.anims[i].anim, 3) do
				Wait(0)
			end
		end
	end

	TriggerServerEvent('HighLife:Robberies:ResetProgress', thisLocationReference)

	FreezeEntityPosition(HighLife.Player.Ped, false)

	SetCamActive(drilling_cam, false)

	N_0x2208438012482a1a(HighLife.Player.Ped, 0, 0)

	HighLife.Player.VisibleItemBlocker = false

	RenderScriptCams(false, false, 0, true, false)

	DestroyCam(drilling_cam)

	HighLife.Player.BypassFOVCheck = false

	SetEntityAsMissionEntity(bag_object, true, true)
	SetEntityAsMissionEntity(drill_object, true, true)

	DeleteObject(bag_object)
	DeleteObject(drill_object)

	-- Look at us doing the right ting!
	RemoveAnimDict(bank.animDictionary)

	isDrilling = false
end

-- for drilling - seperate and maybe check if player is in interior first
CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		for k,v in pairs(Config.Robberies.Banks) do 
			if Vdist(HighLife.Player.Pos, v.door_hack.pos) < 1.2 then
				thisTry = true
				hackingLocationReference = k
				break
			end
		end

		if not thisTry then
			hackingLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		for k,v in pairs(Config.Robberies.Stores) do 
			if Vdist(HighLife.Player.Pos, v.ped_pos) < 2.0 then
				thisTry = true

				tillrobberyLocationReference = k

				break
			end
		end

		if not thisTry then
			tillrobberyLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		if HighLife.Player.SpecialItems['usb_key'] then
			for k,v in pairs(Config.Robberies.Stores) do 
				if Vdist(HighLife.Player.Pos, v.computer_pos) < 2.0 then
					thisTry = true

					computerRobberyLocationReference = k

					break
				end
			end
		end

		if not thisTry then
			computerRobberyLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		for k,v in pairs(Config.Robberies.Search) do
			if Vdist(HighLife.Player.Pos, v.ped_pos) < v.AreaRadius then
				thisTry = true

				searchLocationReference = k

				break
			end
		end
		
		if not thisTry then
			searchLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		if HighLife.Player.SpecialItems['safe_drill'] then
			for k,v in pairs(Config.Robberies.Banks) do 
				if Vdist(HighLife.Player.Pos, v.ped_pos) < 2.0 then
					thisTry = true
					drillingLocationReference = k
					break
				end
			end
		end

		if not thisTry then
			drillingLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		-- if HighLife.Player.SpecialItems['safe_drill'] then
		for k,v in pairs(Config.Robberies.Depository.explosive_points) do
			if Vdist(HighLife.Player.Pos, v.pos) < 2.0 then
				thisTry = true
				explosiveLocationReference = k
			end
		end
		-- end

		if not thisTry then
			explosiveLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		for k,v in pairs(Config.Robberies.Depository.explosive_points) do
			if Vdist(HighLife.Player.Pos, v.loot_pos) < 1.5 then
				thisTry = true

				UDTakeLocationReference = k
			end
		end

		if not thisTry then
			UDTakeLocationReference = nil
		end

		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		if HighLife.Other.RobberyData ~= nil then
			if GameTimerPool.GlobalGameTime > (lastUpdateTime + 15000) then
				for k,v in pairs(HighLife.Other.RobberyData.StoreLocations) do
					local foundShop = nil

					for _,shopData in pairs(Config.Shops) do
						for shopname,subShopData in pairs(shopData.Pos) do
							if shopname == k then
								subShopData.closed = v.completed

								foundShop = true

								break
							end
						end

						if foundShop then
							break
						end
					end
				end

				for k,v in pairs(HighLife.Other.RobberyData.BankLocations) do
					if v.completed then
						Config.Banking.Locations[k].closed = true
					end

					if v.door_open then
						if OpenVaultDoors[k] == nil then
							local rotationOffset = 95.0

							local vaultDoor = GetClosestObjectOfType(Config.Robberies.Banks[k].door_hack.pos, Config.Robberies.Banks[k].VaultDoor or GetHashKey('v_ilev_gb_vauldr'), false, false, false)

							if vaultDoor ~= 0 then
								local isClose = false

								if Config.Robberies.Banks[k].VaultDoor ~= nil then
									isClose = not isClose
								end

								local desiredHeading = CalculateHeadingNoFucksGiven(GetEntityHeading(vaultDoor), rotationOffset, isClose)

								OpenVaultDoors[k] = desiredHeading

								SetEntityHeading(vaultDoor, desiredHeading)
							end
						end
					end
				end

				for k,v in pairs(ShouldBeClosed) do
					if OpenVaultDoors[k] ~= nil and OpenVaultDoors[k] then
						local rotationOffset = 95.0

						local vaultDoor = GetClosestObjectOfType(Config.Robberies.Banks[k].door_hack.pos, Config.Robberies.Banks[k].VaultDoor or GetHashKey('v_ilev_gb_vauldr'), false, false, false)
										
						if vaultDoor ~= 0 then
							local isClose = true

							if Config.Robberies.Banks[k].VaultDoor ~= nil then
								isClose = not isClose
							end

							OpenVaultDoors[k] = nil
							ShouldBeClosed[k] = nil

							local desiredHeading = CalculateHeadingNoFucksGiven(GetEntityHeading(vaultDoor), rotationOffset, isClose)

							SetEntityHeading(vaultDoor, desiredHeading)
						end
					end
				end

				for k,v in pairs(OpenVaultDoors) do
					local vaultDoor = GetClosestObjectOfType(Config.Robberies.Banks[k].door_hack.pos, Config.Robberies.Banks[k].VaultDoor or GetHashKey('v_ilev_gb_vauldr'), false, false, false)
										
					if vaultDoor ~= 0 then
						SetEntityHeading(vaultDoor, v)
					end
				end
			end
		end

		Wait(5000)
	end
end)

-- anim@heists@fleeca_bank@drilling outro_no_armour

--  AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "Drill_Jam", l_649, "DLC_HEIST_FLEECA_SOUNDSET", 1, 20);

CreateThread(function()
	while true do
		if awaitingCallback then
			Wait(2000)

			awaitingCallback = false
		end

		Wait(100)
	end
end)

CreateThread(function()
	RequestAnimDict('anim@heists@fleeca_bank@drilling')

	while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
		Wait(50)
	end

	local temp_bag_object = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), HighLife.Player.Pos - vector3(0.0, 0.0, 50.0), false, true, false)
	local temp_door_object = CreateObject(GetHashKey('hei_prop_heist_safedepdoor'), HighLife.Player.Pos - vector3(0.0, 0.0, 50.0), false, true, false)

	PlayEntityAnim(temp_door_object, 'outro_door', 'anim@heists@fleeca_bank@drilling', 1000.0, 1, 1, 1, 0.0, 0)
	PlayEntityAnim(temp_bag_object, 'bag_intro_no_armour', 'anim@heists@fleeca_bank@drilling', 1000.0, 1, 1, 1, 0.0, 0)

	Wait(100)

	DeleteObject(temp_bag_object)
	DeleteObject(temp_door_object)
end)

CreateThread(function()
	while true do
		if not HighLife.Player.InVehicle and not HighLife.Player.Dead and not awaitingCallback then
			if searchLocationReference ~= nil then
				if not isSearching then
					local thisObject = 0

					if type(Config.Robberies.Search[searchLocationReference].Object) == 'table' then
						local enumObjects = Config.Robberies.Search[searchLocationReference].Object
						local thisEnumObject = nil

						for i=1, #enumObjects do 
							thisEnumObject = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, enumObjects[i], true, true, true)

							if thisEnumObject ~= nil and thisEnumObject ~= 0 then
								thisObject = thisEnumObject

								break
							end
						end
					else
						thisObject = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, Config.Robberies.Search[searchLocationReference].Object, true, true, true)
					end

					if thisObject ~= 0 then
						if not isSearching then
							if IsAnyJobs({'unemployed'}) then
								local requiredPass = true

								if Config.Robberies.Search[searchLocationReference].RequiredWeapon ~= nil then
									if HighLife.Player.CurrentWeapon ~= Config.Robberies.Search[searchLocationReference].RequiredWeapon then
										requiredPass = false
									end
								end

								if requiredPass then
									DisplayHelpText('Press ~INPUT_PICKUP~ to ~o~search ~s~the ~y~' .. Config.Robberies.Search[searchLocationReference].ObjectSearchName)

									if IsControlJustPressed(1, 38) then
										awaitingCallback = true

										searchObject = thisObject

										TriggerServerEvent('HighLife:Robberies:StartAction', false, 'search', searchLocationReference)
									end
								end
							end
						end
					end
				end
			end

			if UDTakeLocationReference ~= nil then
				if HighLife.Player.MiscSync[UDTakeLocationReference] then
					if not isRobbingUD then
						if IsAnyJobs({'police', 'fib'}) then
							DisplayHelpText('Press ~INPUT_PICKUP~ to ~o~confiscate ~g~money')
						else
							DisplayHelpText('Press ~INPUT_PICKUP~ to pickup ~g~money')
						end

						if IsControlJustReleased(1, 38) then
							isRobbingUD = true

							awaitingCallback = true

							TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

							Wait(20000)

							if IsPedActiveInScenario(HighLife.Player.Ped) then
								ClearPedTasks(HighLife.Player.Ped)
								
								TriggerServerEvent('HighLife:Robberies:UDTakeCash', UDTakeLocationReference)
							end

							isRobbingUD = false
						end
					end
				end
			end

			if drillingLocationReference ~= nil then
				if not isDrilling then
					local thisLocation = Config.Robberies.Banks[drillingLocationReference].ped_pos

					DisplayHelpText('ROBBERIES_DRILL')

					if IsControlJustReleased(1, 38) then
						awaitingCallback = true

						TriggerServerEvent('HighLife:Robberies:StartAction', true, 'fleeca', drillingLocationReference)
					end
				end
			end

			if hackingLocationReference ~= nil then
				local thisLocation = Config.Robberies.Banks[hackingLocationReference].door_hack

				if IsAnyJobs({'police', 'fib'}) then
					if HighLife.Other.RobberyData.BankLocations[hackingLocationReference].door_open then
						DisplayHelpText('ROBBERIES_CLOSE_VAULT')

						if IsControlJustReleased(1, 38) then
							TaskStartScenarioAtPosition(HighLife.Player.Ped, thisLocation.anim, thisLocation.pos, -1, false, false)

							Wait(5000)

							ClearPedTasks(HighLife.Player.Ped)
							
							TriggerServerEvent('HighLife:Robberies:CloseVault', hackingLocationReference)
						end
					end
				else
					if HighLife.Player.SpecialItems['keypad_cracker'] then
						if IsAnyJobs({'unemployed'}) then
							DisplayHelpText('ROBBERIES_CRACK')

							if IsControlJustReleased(1, 38) then
								awaitingCallback = true

								TriggerServerEvent('HighLife:Robberies:StartAction', false, 'fleeca', hackingLocationReference)
							end
						else
							DisplayHelpText('MISC_HAVEAJOB')
						end
					end
				end
			end

			if not isComputerRobbery and computerRobberyLocationReference ~= nil then
				if IsAnyJobs({'unemployed'}) then
					DisplayHelpText('Press ~INPUT_PICKUP~ to ~r~crack the computer')

					if IsControlJustReleased(1, 38) then
						awaitingCallback = true

						TriggerServerEvent('HighLife:Robberies:StartAction', false, 'store_computer', computerRobberyLocationReference)
					end
				end
			end

			if not isRobbingTill and not softLockRobberyHelpText then
				if tillrobberyLocationReference ~= nil then
					if IsAnyJobs({'unemployed'}) then
						if HighLife.Player.CurrentWeapon == GetHashKey('weapon_crowbar') then
							local foundTill = nil

							local thisTill = GetClosestObjectOfType(HighLife.Player.Pos, 1.5, Config.Robberies.Types.store.entities.till.model, true, true, true)
							local thisTill2 = GetClosestObjectOfType(HighLife.Player.Pos, 1.5, Config.Robberies.Types.store.entities.till_2.model, true, true, true)

							if thisTill ~= 0 then
								foundTill = thisTill
							end

							if thisTill2 ~= 0 then
								foundTill = thisTill2
							end

							if foundTill ~= nil then
								if Vdist(HighLife.Player.Pos, GetOffsetFromEntityInWorldCoords(foundTill, 0.0, -0.72, -1.1)) < 1.2 then
									DisplayHelpText('Press ~INPUT_PICKUP~ to ~r~rob the register')

									if IsControlJustReleased(1, 38) then
										awaitingCallback = true

										TriggerServerEvent('HighLife:Robberies:StartAction', false, 'store', tillrobberyLocationReference)
									end

									HighLife.Player.Robbable = true
								else
									HighLife.Player.Robbable = false
								end
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end)