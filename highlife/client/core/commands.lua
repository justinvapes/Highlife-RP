local oneSlice = true
local activeRadius = nil

function testFailFunc()
	finishFail()
end

function finishFail()
	return nil * 3
end

RegisterCommand('trip_error', function()
	if HighLife.Settings.Development then
		testFailFunc()
	end
end)

RegisterCommand('skills', function()
	RageUI.Visible(RMenu:Get('skills_menu', 'main'), true)
end)

RegisterCommand('vis_check', function()
	print(RageUI.IsAnyMenuVisible())
end)

CreateThread(function()
	for k,v in pairs(Config.Chat.Suggestions) do
		TriggerEvent('chat:addSuggestion', '/' .. v.command, v.context)
	end
end)

RegisterCommand('playptfx', function(source, args, raw)
	if HighLife.Player.Special then
		TestPtfx(args[1], args[2], args[3])
	end
end, false)

RegisterCommand('events_menu', function()
	if HighLife.Player.EventsTeam or HighLife.Player.Special then
		RageUI.Visible(RMenu:Get('jobs', 'events_team'), true)
	end
end)

RegisterCommand('playanim', function(source, args, raw)
	if HighLife.Player.Special or HighLife.Settings.Development then
		print(json.encode(args))

		if args[1] ~= nil and args[2] ~= nil then
			if not HasAnimDictLoaded(args[1]) then
				RequestAnimDict(args[1])
				
				repeat Wait(1) until HasAnimDictLoaded(args[1])
			end

			print(args[1], args[2])

			TaskPlayAnim(HighLife.Player.Ped, args[1], args[2], 8.0, 8.0, -1, (args[3] ~= nil), false, false, false, false)

			RemoveAnimDict(args[1])
		end
	end
end, false)

RegisterCommand('lefix', function(source, args, raw)
	if HighLife.Player.Special or HighLife.Settings.Development then
		SetVehicleFixed(HighLife.Player.Vehicle)
	end
end, false)

RegisterCommand("record_clip", function(source, args, string)
	if HighLife.Player.IsEditor or HighLife.Player.IsStaff then
		if not IsRecording() then
			StartRecording(1)
		else
			StopRecordingAndSaveClip()
		end
	else
		Notification_AboveMap('You are not whitelisted to use the ~o~Rockstar Editor~s~~n~If you want access to this, request access on ~p~Discord')
	end
end)

RegisterCommand('radius_test', function(source, args, something)
	if HighLife.Player.Special or HighLife.Settings.Development then
		local canCreate = false

		if args[1] ~= nil then
			if activeRadius == nil then
				canCreate = true
			end

			activeRadius = tonumber(args[1])
		else
			activeRadius = nil
		end

		if canCreate then
			CreateThread(function()
				while activeRadius ~= nil do
					DrawMarker(1, GetEntityCoords(PlayerPedId()), 0, 0, 0, vector3(0.0, 0.0, 0.0), vector3(activeRadius, activeRadius, 1.0), vector4(20, 20, 220, 255), false, false, 0, 0)

					Wait(1)
				end
			end)
		end
	end
end)

RegisterCommand("gc", function(source, args, string)
	collectgarbage()
end)

RegisterCommand('skin', function(args)
	if HighLife.Settings.Development or HighLife.Player.Special then
		HighLife:OpenSkinMenu()
	end
end)

RegisterCommand('saveskin', function(args)
	local skin_name = openKeyboard('OUTFIT_NAME', 'Name to save the outfit with', 15)

	if skin_name ~= nil then
		TriggerServerEvent('HighLife:Skin:SaveSkin', json.encode(HighLife:GetCurrentClothing()), skin_name)
	end
end)

RegisterCommand('getclothes', function(args)
	if HighLife.Settings.Development or HighLife.Player.Special or HighLife.Player.IsStaff then
		print(json.encode(HighLife:GetCurrentClothing()))
	end
end)

RegisterCommand("car", function(source, args, string)
	if HighLife.Player.Special or HighLife.Settings.Development then
		HighLife:CreateVehicle(args[1], {x = HighLife.Player.Pos.x, y = HighLife.Player.Pos.y, z = HighLife.Player.Pos.z + 0.5}, HighLife.Player.Heading, true, true, function(vehicle)
			HighLife.Player.EntryCheck = true

			TaskWarpPedIntoVehicle(HighLife.Player.Ped, vehicle, -1)

			SetVehicleNeedsToBeHotwired(vehicle, false)

			if GetVehicleClass(vehicle) ~= Config.VehicleClasses.Cycles then
				LockVehicle(vehicle, true)

				TriggerEvent('HighLife:LockSystem:GiveKeys', GetVehicleNumberPlateText(vehicle), true)
			end

			-- Fuel for shit vehicles
			if GetVehicleClass(vehicle) == Config.VehicleClasses.Boats or GetVehicleClass(vehicle) == Config.VehicleClasses.Helicopters or GetVehicleClass(vehicle) == Config.VehicleClasses.Planes then
				SetVehicleFuel(vehicle, 100.0)
			end
		end)
	end
end)

RegisterCommand("cake", function(source, args, string)
	local year, month, day, hour, minute, second = GetUtcTime()

	if month == 08 and ((day == 25 and hour == 23) or day == 26) then
		if oneSlice then
			oneSlice = false

			SendNUIMessage({
				nui_reference = 'cake',
			})

			Notification_AboveMap('alright, have a slice, take it!')
		else
			Notification_AboveMap('one slice only!')
		end
	end
end)

RegisterCommand("force_error", function(source, args, string)
	if HighLife.Player.Special then
		local myVar = {}

		print((myVar.test * 10))
	end
end)

RegisterCommand("debug", function(source, args, string)
	if HighLife.Player.Special or HighLife.Settings.Development then
		HighLife.Player.Debug = not HighLife.Player.Debug

		print('Debug State: ', HighLife.Player.Debug)
	end
end)

RegisterCommand("streamer_mode", function(source, args, string)
	HighLife.Player.StreamerMode = not HighLife.Player.StreamerMode

	Notification_AboveMap('Streamer mode: ' .. (HighLife.Player.StreamerMode and '~g~Enabled' or '~r~Disabled'))
end)

RegisterCommand("bond", function(source, args, string)
	if IsAnyJobs({'fib'}) then
		ClearPedProp(HighLife.Player.Ped, 0)

		SetPedPropIndex(HighLife.Player.Ped, 0, 20, 0, 2)
		SetPedComponentVariation(HighLife.Player.Ped, 1, 213, 0, 2)
		SetPedComponentVariation(HighLife.Player.Ped, 8, 178, 0, 2)
		SetPedComponentVariation(HighLife.Player.Ped, 11, 21, 0, 2)
	end
end)

RegisterCommand("autism", function(source, args, string)
	HighLife.Player.Autism = not HighLife.Player.Autism
end)

RegisterCommand("bodycam", function(source, args, string)
	if IsAnyJobs({'police'}) then
		local characterData = nil

		for _,thisCharacterData in pairs(HighLife.Player.CharacterData) do
			if thisCharacterData.reference == HighLife.Player.CurrentCharacterReference then
				characterData = thisCharacterData

				break
			end
		end

		if characterData ~= nil then
			SendNUIMessage({
				nui_reference = 'bodycam',
				name = string.upper(characterData.name.first:sub(1, 1)) .. '. ' .. characterData.name.last,
				callsign = HighLife.Other.JobStatData.current[HighLife.Player.Job.name].data.callsign,
			})
		end
	end
end)

RegisterCommand("instructor_menu", function(source, args, string)
	if HighLife.Player.Instructor then
		RageUI.Visible(RMenu:Get('jobs', 'flight_instructor'), true)
	end
end)

RegisterCommand("detach_objects", function(source, args, string)
	if not HighLife.Player.HidingInTrunk and HighLife.Player.Dragger == nil then
		DetachEntity(HighLife.Player.Ped, false, false)
	end
end)

RegisterCommand("pos", function(source, args, string)
	if HighLife.Settings.Development or HighLife.Player.Special then
		print(vector4(HighLife.Player.Pos, HighLife.Player.Heading))
	end
end)

RegisterCommand("tp", function(source, args, string)
	if HighLife.Player.Special then
		SetEntityCoordsNoOffset(HighLife.Player.Ped, tonumber(args[1]), tonumber(args[2]), tonumber(args[3]) + 1.0)
	end
end)

RegisterCommand("ooc", function(source, args, string)
	TriggerEvent('chatMessage', "System^0", {7, 206, 246}, "OOC no longer exists! New to HighLife? /guide can get you started. If you require staff assistance please head to discord and join the waiting for staff channel. Need to report a player or *immediate* issue such as someone cheating? Press F1 and use the 'Report Issue/Player' options.")
end)

RegisterCommand("id", function(source, args, string)
	local playerID = GetPlayerServerId(HighLife.Player.Id)

	print(playerID)
	
	Notification_AboveMap('~y~Your ID: ~s~' .. playerID)
end)

RegisterCommand("vdata", function(source, args, string)
	if HighLife.Player.Special and HighLife.Player.InVehicle then
		print(json.encode(HighLife:GetVehicleProperties(HighLife.Player.Vehicle)))
	end
end)

RegisterCommand("vanilla_music", function(source, args, string)
	if IsAnyJobs({'vanilla'}) then
		TriggerServerEvent('HighLife:MiscGlobals:SetSyncedGlobal', 'VanillaMusic', not HighLife.Player.MiscSync.VanillaMusic)
	end
end)

RegisterCommand("vanilla_stream_music", function(source, args, string)
	if IsAnyJobs({'vanilla'}) then
		local extraData = {}

		if HighLife.Player.InVehicle then
			extraData.findEntity = 'vehicle'	
		end

		HighLife.SpatialSound.CreateSound('Vanilla')
	end
end)

RegisterCommand("paradise_stream_music", function(source, args, string)
	if IsAnyJobs({'vanilla'}) then
		local extraData = {}

		if HighLife.Player.InVehicle then
			extraData.findEntity = 'vehicle'	
		end

		HighLife.SpatialSound.CreateSound('Paradise')
	end
end)

RegisterCommand("bad_boys", function(source, args, string)
	if HighLife.Settings.Development and HighLife.Player.Special then
		TriggerServerEvent('HighLife:MiscGlobals:SetSyncedGlobal', 'BadBoys', not HighLife.Player.MiscSync.BadBoys)
	end
end)

RegisterCommand("briefcase", function(source, args, string)
	if IsAnyJobs({'dynasty', 'lawyer'}) then
		GiveWeaponToPed(HighLife.Player.Ped, GetHashKey('WEAPON_BRIEFCASE_02'), 1, true, true)
	end
end)

RegisterCommand("news_camera", function(source, args, string)
	if IsAnyJobs({'weazel'}) then
		TriggerEvent('Cam:ToggleCam')
	end
end)

RegisterCommand("nitro", function(source, args, string)
	if HighLife.Player.Special then
		HighLife.Player.Nitro = not HighLife.Player.Nitro
	end
end)

RegisterCommand("news_mic", function(source, args, string)
	if IsAnyJobs({'weazel'}) then
		TriggerEvent('Mic:ToggleMic')
	end
end)

RegisterCommand("bike", function(source, args, string)
	if HighLife.Player.IsStaff then
    	TriggerEvent('HighLife:Staff:GetBike')
	end
end)

RegisterCommand("scar", function(source, args, string)
	if HighLife.Player.IsStaff then
    	TriggerEvent('HighLife:Staff:GetCar')
	end
end)

RegisterCommand("dv", function(source, args, string)
    TriggerEvent('HighLife:Staff:DeleteVehicle')
end)

RegisterCommand("dvgun", function(source, args, string)
	if HighLife.Player.IsStaff then
		if HasPedGotWeapon(HighLife.Player.Ped, GetHashKey('weapon_doubleaction'), false) then
			RemoveWeaponFromPed(HighLife.Player.Ped, GetHashKey('weapon_doubleaction'))
		else
			HighLife:WeaponGate()

			GiveWeaponToPed(HighLife.Player.Ped, GetHashKey('weapon_doubleaction'), 1, false, true)
		end
	end
end)

RegisterCommand("entgun", function(source, args, string)
	if HighLife.Player.IsStaff then
		HighLife.Player.EntGun = not HighLife.Player.EntGun
		
		print('entgun state', HighLife.Player.EntGun)
	end
end)

RegisterCommand("magneto", function(source, args, string)
	if HighLife.Player.Special then
		HighLife.Player.Megneto = not HighLife.Player.Megneto

		print('magneto state', HighLife.Player.Megneto)
	end
end)

RegisterCommand("sillygun", function(source, args, string)
	if HighLife.Player.IsStaff and HighLife.Player.Special then
		HighLife.Player.SillyGun = not HighLife.Player.SillyGun

		print('silly state', HighLife.Player.SillyGun)
	end
end)

RegisterCommand("chillygun", function(source, args, string)
	if HighLife.Player.IsStaff then
		HighLife.Player.ChilliadGun = not HighLife.Player.ChilliadGun

		print('chilly state', HighLife.Player.ChilliadGun)
	end
end)

RegisterCommand("ic3gun", function(source, args, string)
	if HighLife.Player.IsStaff and (HighLife.Player.Special or HighLife.Player.CatLover) then
		HighLife.Player.IC3Gun = not HighLife.Player.IC3Gun

		print('IC3 state', HighLife.Player.IC3Gun)
	end
end)

RegisterCommand("localgun", function(source, args, string)
	if HighLife.Player.IsStaff and HighLife.Player.Special then
		HighLife.Player.LocalGun = not HighLife.Player.LocalGun

		print('local mode', HighLife.Player.LocalGun)
	end
end)

RegisterCommand("reset_vitals", function(source, args, string)
	if HighLife.Player.Special then
		for k,v in pairs(HighLife.Player.Vitals) do
			v.level = 0.0
		end

		print('Reset all vitals')
	end
end)

RegisterCommand("treasure", function(source, args, string)
	local _source = source
	local defaultItem = 'prop_alien_egg_01'

	-- imp_prop_covered_vehicle_01a

	if args[1] ~= nil then
		defaultItem = args[1]
	end

	local thisPos = {
		x = HighLife.Player.Pos.x,
		y = HighLife.Player.Pos.y,
		z = HighLife.Player.Pos.z,
	}
	
	TriggerServerEvent('HighLife:Treasure:Create', thisPos, defaultItem)
end)

local previousRank = nil

RegisterCommand("hidesupporter", function(source, args, string)
	if previousRank ~= nil then
		DecorSetInt(HighLife.Player.Ped, 'Player.Rank', previousRank)

		previousRank = nil
	else
		local RankExist = DecorExistOn(HighLife.Player.Ped, 'Player.Rank')

		if RankExist then
			local foundRank = DecorGetInt(HighLife.Player.Ped, 'Player.Rank')

			if foundRank ~= nil and foundRank ~= Config.Ranks.Staff then
				previousRank = foundRank

				DecorSetInt(HighLife.Player.Ped, 'Player.Rank', -1)
			end
		end
	end
end)

-- RegisterCommand('creator', function(source, args, raw)
-- 	CreateThread(function()
-- 		local entity = GetClosestObjectEnumerated(5.0)
		
-- 		local owner = NetworkGetEntityOwner(entity)
		
-- 		if owner ~= nil and GetPlayerName(owner) ~= nil then
-- 			print('Entity creator of closest object: ' .. GetPlayerName(owner))
-- 		else
-- 			print('No owner for closest entity, may have left')
-- 		end
-- 	end)
-- end, true)

-- RegisterCommand('clear_objects', function(source, args, raw)
-- 	CreateThread(function()
-- 		local radius = tonumber(args[1]) or 500.0
		
-- 		print('Clearing all objects within ' .. radius .. 'm')
			
-- 		local playerPos = GetEntityCoords(PlayerPedId())
			
-- 		ClearArea(playerPos, radius, true, false, false, false) -- (0, 2, 6, 16, and 17)
-- 	end)
-- end, true)

RegisterCommand("die", function(source, args, raw)
	if HighLife.Player.Special then
		SetEntityHealth(HighLife.Player.Ped, 0)
	end
end, false)

RegisterCommand("help", function(source, args, string)
	TriggerEvent('HighLife:Guide:Open')
end)

RegisterCommand("commands", function(source, args, string)
	TriggerEvent('HighLife:Guide:Open')
end)

RegisterCommand("rules", function(source, args, string)
	TriggerEvent('HighLife:Guide:Open')
end)

RegisterCommand("guide", function(source, args, string)
	TriggerEvent('HighLife:Guide:Open')
end)

for k,v in pairs(Config.Skin.ToggleOptions) do
	RegisterCommand(k, function(source, args, string)
		HighLife.Skin:ToggleClothingItem(k)
	end)
end

RegisterCommand('xmas', function()
	if IsChristmas() then
		ResetCurrentPedWeapon()
		
		StartAnimation('missheistdockssetup1hardhat@', 'put_on_hat', true)

		Wait(1000)

		SetPedPropIndex(HighLife.Player.Ped, 0, (isMale() and 102 or 180), 0, false)
	end
end)

RegisterCommand("playtime", function(source, args, raw) --change command here
	if tonumber(args[1]) ~= nil then
		if HighLife.Player.IsStaff or HighLife.Player.IsHelper then
			TriggerServerEvent('HighLife:Playtime:Get', tonumber(args[1]))
		end
	else
		TriggerServerEvent('HighLife:Playtime:Get')
	end
end, false)

RegisterCommand("forceskin", function(source, args, raw) --change command here
	if tonumber(args[1]) ~= nil then
		if HighLife.Player.IsStaff or HighLife.Player.IsHelper then
			TriggerServerEvent('HighLife:Staff:ForceSkin', tonumber(args[1]))
		end
	end
end, false)

RegisterCommand("fund", function(source, args, string)
	if HighLife.Player.Job.name ~= 'unemployed' then
		HighLife:ServerCallback('HighLife:Society:GetFund', function(money)
			if money ~= nil then
				Notification_AboveMap(HighLife.Player.Job.name .. ' fund is at: ~g~$' .. comma_value(money))
			end
		end, HighLife.Player.Job.name)
	end
end)