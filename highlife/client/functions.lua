function NowTime()
	local utcTime = {GetUtcTime()}

	return { year = utcTime[1], month = utcTime[2], day = utcTime[3], hour = utcTime[4], minute = utcTime[5], second = utcTime[6] }
end

function NowTimestamp()
	local now = NowTime()

	return string.format('%s:%s:%s', now.hour, now.minute, now.second) 
end

function GetCasinoVehicleModelHeight(thisVehicle)
    vehicleModel = GetEntityModel(thisVehicle)

    if vehicleModel == GetHashKey('nero2') then
        return 0.82
    elseif vehicleModel == GetHashKey('2019chiron') then
        return 0.86
    elseif vehicleModel == GetHashKey('p1') then
        return 0.72
    elseif vehicleModel == GetHashKey('918') then
        return 0.89
    end

    return 0.82
end

function IsHighLifeGradeDead(ped)
	return (GetEntityHealth(ped) <= 101)
end

function IsItemParachute(itemName)
	return string.match(string.lower(itemName), 'gadget_')
end

-- function SchemaInventory(playerInventory)
-- 	local decodePlayerInventory = json.decode(playerInventory)

-- 	HighLife.Player.Inventory = {
-- 		Items = {},
-- 		Monetary = {
-- 			cash = 0,
-- 			dirty = 0,
-- 		}
-- 	}

-- 	HighLife.Player.Inventory.Monetary.cash = decodePlayerInventory.cash

-- 	-- FIXME: bad
-- 	for i=1, #decodePlayerInventory.accounts do
-- 		if decodePlayerInventory.accounts[i].name == 'black_money' then
-- 			HighLife.Player.Inventory.Monetary.dirty = decodePlayerInventory.accounts[i].money
-- 		end
-- 	end

-- 	for i=1, #decodePlayerInventory.weapons do
-- 		HighLife.Player.Inventory.Items[decodePlayerInventory.weapons[i].name] = {
-- 			name = ESX.GetWeaponLabel(decodePlayerInventory.weapons[i].name),
-- 			value = decodePlayerInventory.weapons[i].name,
-- 			weight = Config.DepositBoxes.WeaponWeight,
-- 			ammo = decodePlayerInventory.weapons[i].ammo,
-- 			amount = 1
-- 		}
-- 	end

-- 	for i=1, #decodePlayerInventory.inventory, 1 do
-- 		if decodePlayerInventory.inventory[i].count > 0 then
-- 			HighLife.Player.Inventory.Items[decodePlayerInventory.inventory[i].name] = {
-- 				name = decodePlayerInventory.inventory[i].label,
-- 				value = decodePlayerInventory.inventory[i].name,
-- 				amount = decodePlayerInventory.inventory[i].count,
-- 				usable = decodePlayerInventory.inventory[i].usable,
-- 			}
-- 		end
-- 	end
-- end

function IsAnyPlayerNearCoords(coords, radius)
	local CurrentActivePlayers = GetActivePlayers()

	local thisPed = nil

	for i=1, #CurrentActivePlayers do
		if CurrentActivePlayers[i] ~= HighLife.Player.Id then
			thisPed = GetPlayerPed(CurrentActivePlayers[i])

			if IsEntityAtCoord(thisPed, coords, radius, radius, radius, 0, 0, 0) then
				return true
			end
		end
	end

	return false
end

function GetVehicleSeatPedIsIn(ped)
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsIn(ped)
		local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))

		local foundSeat = nil

		for i=-1, maxSeats do
			local currentSeat = GetPedInVehicleSeat(vehicle, i)

			if currentSeat == ped then
				foundSeat = i

				break
			end
		end

		if foundSeat ~= nil then
			return foundSeat
		end

		return nil
	end
end

function GetVehiclePassengers(vehicle)
	local passengers = {}
	local passengerCount = 0
	local seatCount = GetVehicleMaxNumberOfPassengers(vehicle)

	local thisPed = nil

	for seat = 0, seatCount do
		if not IsVehicleSeatFree(vehicle, seat) then
			thisPed = GetPedInVehicleSeat(vehicle, seat)

			if IsPedAPlayer(thisPed) then
				table.insert(passengers, thisPed)
			end
			
			passengerCount = passengerCount + 1
		end
	end

	return passengerCount, passengers
end

function IsBlockedDrivebyVehicle(thisVehicle)
	for i=1, #Config.BlockedDrivebyVehicles do
		if GetEntityModel(thisVehicle) == Config.BlockedDrivebyVehicles[i] then
			return true
		end
	end

	return false
end

function HasJobAttribute(jobName, jobAttribute)
	-- if HighLife.Other.JobStatData.current[jobName].data ~= nil and HighLife.Other.JobStatData.current['police'].data['k9'] ~= nil and HighLife.Other.JobStatData.current['police'].data['k9']
	
	if HighLife.Other.JobStatData.current[jobName] ~= nil and HighLife.Other.JobStatData.current[jobName].data ~= nil and HighLife.Other.JobStatData.current[jobName].data[jobAttribute] then
		return true
	end

	return false
end

function IsNearAnyTablePosition(positionTable, distance, overridePos)
	local isNear = false

	for i=1, #positionTable do
		if Vdist((overridePos ~= nil and overridePos or HighLife.Player.Pos), positionTable[i]) < distance then
			isNear = true

			break
		end
	end

	return isNear
end

function IsAprilFools()
	-- print(HighLife.Other.Time[2], HighLife.Other.Time[3], HighLife.Other.Time[4], HighLife.Other.Time[5], HighLife.Other.Time[6])
	return (HighLife.Player.Debug and true or ((HighLife.Other.Time[2] == 4) and (HighLife.Other.Time[3] == 1)))
end

function IsChristmas()
	local isChristmas = false

	if HighLife.Other.Time[2] == Config.ChristmasTime.Start.Month and HighLife.Other.Time[3] >= Config.ChristmasTime.Start.Day then
		isChristmas = true
	end

	if HighLife.Other.Time[2] == Config.ChristmasTime.Finish.Month and HighLife.Other.Time[3] >= Config.ChristmasTime.Finish.Day then
		isChristmas = false
	end

	return isChristmas
end

function SetDragClosestPlayer(specifiedPlayer)
	local player, distance = GetClosestPlayer()
			
	if specifiedPlayer ~= nil or (player ~= -1 and distance < 3.0) then
		if not IsPedSprinting(HighLife.Player.Ped) then
			if not IsPedInAnyVehicle(GetPlayerPed(player)) then
				TriggerServerEvent('HighLife:Player:MeAction', 'grabs person by the arm')

				HighLife.Player.Dragging = (specifiedPlayer or GetPlayerServerId(player))
			else
				TriggerServerEvent('HighLife:Player:MeAction', 'removes person from vehicle')
			end

			local targetPlayerPed = GetPlayerPed(GetPlayerFromServerId(HighLife.Player.Dragging))

			if IsHighLifeGradeDead(targetPlayerPed) then
				CreateThread(function()
					if not HasAnimDictLoaded('missfinale_c2mcs_1') then
						RequestAnimDict('missfinale_c2mcs_1')

						repeat Wait(1) until HasAnimDictLoaded('missfinale_c2mcs_1')
					end

					repeat Wait(1) until not IsPedRagdoll(targetPlayerPed)

					while IsHighLifeGradeDead(targetPlayerPed) and HighLife.Player.Dragging ~= nil do
						if not IsEntityPlayingAnim(HighLife.Player.Ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 3) then
							TaskPlayAnim(HighLife.Player.Ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
						end

						Wait(1)
					end

					ClearPedTasks(HighLife.Player.Ped)
				end)
			end

			TriggerServerEvent('HighLife:Player:Drag', (specifiedPlayer or GetPlayerServerId(player)))
		end
	else
		Notification_AboveMap('~r~Nobody nearby to drag')
	end
end

function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
	    copy = orig
	end
	return copy
end

function string.trim(s)
	return (s ~= nil and s:gsub('%s+', '') or nil)
end

function string.capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function CapitalizeString(str)
    return string.capitalize(str)
end

function bool_to_number(value)
	return value and 1 or 0
end

function IsInInterior()
    if not AreCoordsCollidingWithExterior(HighLife.Player.Pos) then
        if GetInteriorAtCoords(HighLife.Player.Pos) ~= 0 then
            return true
        end
    end

    return false
end

local defaultGridSize = 126 -- 126 before

function GetWorldGrid(x, y, size)
	if type(x) == 'vector3' then
		y = x.y
		x = x.x
	end
	-- return math.floor((x + 4100) / 512) .. math.floor((y + 4100) / 512)
	return math.floor((x + 16400) / defaultGridSize or size) .. '_' .. math.floor((y + 16400) / defaultGridSize or size)
end

function IsKeyboard()
	return GetLastInputMethod(2)
end

function IsJobOnline(jobName, amount)
	local isOnline = false

	if HighLife.Other.OnlineJobs ~= nil then
		if HighLife.Other.OnlineJobs[jobName] ~= nil and (amount ~= nil and HighLife.Other.OnlineJobs[jobName] >= amount or true) then
			isOnline = true
		end
	end

	return isOnline
end

function IntWithinRange(originalInt, newInt, thisRange)
	if newInt >= (originalInt - thisRange) and newInt <= (originalInt + thisRange) then
		return true
	end

	return false
end

function GetOnlineJobCount(jobName)
	local onlineCount = 0

	if HighLife.Other.OnlineJobs ~= nil then
		if HighLife.Other.OnlineJobs[jobName] ~= nil then
			onlineCount = HighLife.Other.OnlineJobs[jobName]
		end
	end

	return onlineCount
end

function TestPtfx(dict, name, size)
	-- veh_ba_strikeforce
	-- veh_exhaust_strikeforce

	CreateThread(function()
		RequestNamedPtfxAsset(dict)

		while not HasNamedPtfxAssetLoaded(dict) do
			Wait(10)
		end

		UseParticleFxAsset(dict)

		local thisPtfx = StartParticleFxLoopedAtCoord(name, HighLife.Player.Pos, vector3(0.0, 0.0, 0.0), tonumber(size) or 1.0, false, false, false, false)

		-- SetParticleFxLoopedColour(thisPtfx, 0.8, 0.18, 0.19, false)
		
		Wait(5000)

		RemoveParticleFx(thisPtfx, 1)
		RemoveNamedPtfxAsset(dict)
	end)
end

function SortTableBy(myTable)
    local t = {}
    for title,value in pairsByKeys(myTable) do
        table.insert(t, { title = title, value = value })
    end
    myTable = t
    return myTable
end

function pairsByKeys(t, f)
    local a = {}

    for n in pairs(t) do
        table.insert(a, n)
    end

    table.sort(a, f)

    local i = 0      -- iterator variable

    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end

    return iter
end

function RandomTableKey(thisTable)
	local returnKey = nil
	local tableKeyCount = 0

	for k,v in pairs(thisTable) do
		tableKeyCount = tableKeyCount + 1
	end

	local thisRandom = math.random(tableKeyCount)

	local thisCount = 0

	for k,v in pairs(thisTable) do
		thisCount = thisCount + 1

		if thisCount == thisRandom then
			returnKey = k

			break
		end
	end

	return returnKey
end

function IsEntityAPlayer(thisEntity)
	local isPlayer = false

	for k,v in pairs(GetActivePlayers()) do
		if GetPlayerPed(v) == thisEntity then
			isPlayer = true

			break
		end
	end

	return isPlayer
end

function AutoAttachVehicleToTrailer(vehicle, trailer)
	local foundOffset = nil

	for trailerHash,trailerData in pairs(Config.Trailers) do
		if trailerHash == GetEntityModel(trailer) then
			for vehicleHash,vehicleOffset in pairs(trailerData) do
				if vehicleHash == GetEntityModel(vehicle) then
					foundOffset = vehicleOffset
				end
			end

			break
		end
	end

	if foundOffset ~= nil then
		AttachVehicleOnToTrailer(vehicle, trailer, foundOffset, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), false)
	end
end

function IsAnyVehicleDoorOpen(vehicle)
	local doorOpen = false

	if vehicle ~= nil and DoesEntityExist(vehicle) then
		for i=0, 3 do
			if GetVehicleDoorAngleRatio(vehicle, i) > 0.0 then
				doorOpen = true

				break
			end
		end
	end

	return doorOpen
end

function IsSemiBadVehicle(model)
	if model ~= nil then
		for i=1, #Config.SemiBadVehicles do
			if model == Config.SemiBadVehicles[i] then
				return true
			end
		end
	end

	return false
end

local thisLastCordons = nil

function MiscSyncUpdates()
	GameTimerPool.MiscSync = GameTimerPool.GlobalGameTime + 30000

	GlobalToggleCops(HighLife.Player.MiscSync.BadBoys)

	for i=1, #HighLife.Player.MiscSync.Cordons do
		SetRoadsInArea(vector3(HighLife.Player.MiscSync.Cordons[i].first_pos), vector3(HighLife.Player.MiscSync.Cordons[i].second_pos), false, false)
	end

	if thisLastCordons ~= nil then
		local cordonExists = false

		for i=1, #thisLastCordons do
			cordonExists = false

			for j=1, #HighLife.Player.MiscSync.Cordons do
				if math.floor(thisLastCordons[i].first_pos.x) == math.floor(HighLife.Player.MiscSync.Cordons[j].first_pos.x) then
					cordonExists = true

					break
				end
			end

			if not cordonExists then
				SetRoadsInArea(vector3(thisLastCordons[i].first_pos), vector3(thisLastCordons[i].second_pos), true, true)
			end
		end
	end

	thisLastCordons = deepcopy(HighLife.Player.MiscSync.Cordons)
end

function GlobalToggleCops(bool)
	if bool ~= nil then
		SetCreateRandomCops(bool)
		SetCreateRandomCopsOnScenarios(bool)
		SetCreateRandomCopsNotOnScenarios(bool)
	end
end

function IsWeaponSniper(weaponHash)
	for i=1, #Config.Snipers do
		if weaponHash == Config.Snipers[i] then
			return true
		end
	end

	return false
end

function lerp(a, b, t)
	return a * (1-t) + b * t
end

function CreatePropOnGround(modelName, freeze)
	CreateThread(function()
		local offset = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 1.75, 0.0)

		local _, worldZ = GetGroundZFor_3dCoord(offset.x, offset.y, offset.z)

		HighLife:CreateObject(modelName, { x = offset.x, y = offset.y, z = worldZ }, HighLife.Player.Heading, freeze, function(thisObject)
			-- SetEntityAsNoLongerNeeded(thisObject)
		end)
	end)
end

-- function ApplySkinToPed(skin, clothes, clonePed)
-- 	local playerPed = clonePed

-- 	local clonePedClothes = {}

-- 	local thisSkin = json.decode(skin)

-- 	for k,v in pairs(thisSkin) do
-- 		clonePedClothes[k] = v
-- 	end

-- 	if clothes ~= nil then
-- 		for k,v in pairs(clothes) do
-- 			if k ~= 'eye' and k ~= 'sex' and k ~= 'face' and k ~= 'skin' and k ~= 'age_1' and k ~= 'age_2' and k ~= 'sun_1' and k ~= 'sun_2' and k ~= 'chest_1' and k ~= 'chest_2' and k ~= 'moles_1' and k ~= 'moles_2' and k ~= 'blemishes' and k ~= 'blemishes_1' and k ~= 'complexion_1' and k ~= 'complexion_2' and k ~= 'beard_1' and k ~= 'beard_2' and k ~= 'beard_3' and k ~= 'beard_4' and k ~= 'hair_1' and k ~= 'hair_2' and k ~= 'hair_color_1' and k ~= 'hair_color_2' and k ~= 'eyebrows_1' and k ~= 'eyebrows_2' and k ~= 'eyebrows_3' and k ~= 'eyebrows_4' and k ~= 'makeup_1' and k ~= 'makeup_2' and k ~= 'makeup_3' and k ~= 'makeup_4' and k ~= 'lipstick_1' and k ~= 'lipstick_2' and k ~= 'lipstick_3' and k ~= 'lipstick_4' then
-- 				clonePedClothes[k] = v
-- 			end
-- 		end
-- 	end

-- 	SetPedHeadBlendData(playerPed, clonePedClothes['face'], clonePedClothes['face'], clonePedClothes['face'], clonePedClothes['skin'], clonePedClothes['skin'], clonePedClothes['skin'], 1.0, 1.0, 1.0, true)
-- 	SetPedEyeColor(playerPed, clonePedClothes['eye'])
-- 	SetPedHairColor(playerPed, clonePedClothes['hair_color_1'], clonePedClothes['hair_color_2'])           -- Hair Color
	
-- 	SetPedHeadOverlay(playerPed, 9, clonePedClothes['moles_1'], (clonePedClothes['moles_2'] / 10) + 0.0)      -- Age + opacity
-- 	SetPedHeadOverlay(playerPed, 3, clonePedClothes['age_1'], (clonePedClothes['age_2'] / 10) + 0.0)      -- Age + opacity
-- 	SetPedHeadOverlay(playerPed, 10, clonePedClothes['chest_1'], (clonePedClothes['chest_2'] / 10) + 0.0)

-- 	SetPedHeadOverlay(playerPed, 7, clonePedClothes['sun_1'], (clonePedClothes['sun_2'] / 10) + 0.0)      -- Blemishes
-- 	SetPedHeadOverlay(playerPed, 6, clonePedClothes['complexion_1'], (clonePedClothes['complexion_2'] / 10) + 0.0)      -- Blemishes

-- 	SetPedHeadOverlay(playerPed, 0, clonePedClothes['blemishes'], (10 / 10) + 0.0)      -- Blemishes
-- 	SetPedHeadOverlay(playerPed, 11, clonePedClothes['blemishes_1'], (10 / 10) + 0.0)      -- Blemishes
-- 	SetPedHeadOverlay(playerPed, 1, clonePedClothes['beard_1'], (clonePedClothes['beard_2'] / 10) + 0.0)    -- Beard + opacity
-- 	SetPedHeadOverlay(playerPed, 2, clonePedClothes['eyebrows_1'], (clonePedClothes['eyebrows_2'] / 10) + 0.0) -- Eyebrows + opacity
-- 	SetPedHeadOverlay(playerPed, 4, clonePedClothes['makeup_1'], (clonePedClothes['makeup_2'] / 10) + 0.0)   -- Makeup + opacity
-- 	SetPedHeadOverlay(playerPed, 8, clonePedClothes['lipstick_1'], (clonePedClothes['lipstick_2'] / 10) + 0.0) -- Lipstick + opacity
-- 	SetPedComponentVariation(playerPed, 2, clonePedClothes['hair_1'], clonePedClothes['hair_2'], 2)              -- Hair

-- 	SetPedHeadOverlayColor(playerPed, 10, 1, clonePedClothes['chest_3'], clonePedClothes['chest_3'])                -- Chest Color
-- 	SetPedHeadOverlayColor(playerPed, 1, 1, clonePedClothes['beard_3'], clonePedClothes['beard_4'])                -- Beard Color

-- 	SetPedHeadOverlayColor(playerPed, 2, 1, clonePedClothes['eyebrows_3'], clonePedClothes['eyebrows_4'])             -- Eyebrows Color
-- 	SetPedHeadOverlayColor(playerPed, 4, 1, clonePedClothes['makeup_3'], clonePedClothes['makeup_4'])               -- Makeup Color
-- 	SetPedHeadOverlayColor(playerPed, 8, 1, clonePedClothes['lipstick_3'], clonePedClothes['lipstick_4'])             -- Lipstick Color

-- 	if clonePedClothes['ears_1'] == -1 then
-- 		ClearPedProp(playerPed, 2)
-- 	else
-- 		SetPedPropIndex(playerPed, 2, clonePedClothes['ears_1'], clonePedClothes['ears_2'], 2)  -- Ears Accessories
-- 	end

-- 	if clonePedClothes['bracelet_1'] == -1 then
-- 		ClearPedProp(playerPed, 7)
-- 	else
-- 		SetPedPropIndex(playerPed, 7, clonePedClothes['bracelet_1'], clonePedClothes['bracelet_2'], 2)  -- Glasses
-- 	end

-- 	if clonePedClothes['watch_1'] == -1 then
-- 		ClearPedProp(playerPed, 6)
-- 	else
-- 		SetPedPropIndex(playerPed, 6, clonePedClothes['watch_1'], clonePedClothes['watch_2'], 2)
-- 	end

-- 	SetPedComponentVariation(playerPed, 8,  clonePedClothes['tshirt_1'],  clonePedClothes['tshirt_2'], 2)     -- Tshirt
-- 	SetPedComponentVariation(playerPed, 11, clonePedClothes['torso_1'],   clonePedClothes['torso_2'], 2)      -- torso parts
-- 	SetPedComponentVariation(playerPed, 3,  clonePedClothes['arms'], 0, 2)                              -- torso
-- 	SetPedComponentVariation(playerPed, 10, clonePedClothes['decals_1'],  clonePedClothes['decals_2'], 2)     -- decals
-- 	SetPedComponentVariation(playerPed, 4,  clonePedClothes['pants_1'],   clonePedClothes['pants_2'], 2)      -- pants
-- 	SetPedComponentVariation(playerPed, 6,  clonePedClothes['shoes_1'],   clonePedClothes['shoes_2'], 2)      -- shoes
-- 	SetPedComponentVariation(playerPed, 1,  clonePedClothes['mask_1'],    clonePedClothes['mask_2'], 2)       -- mask
-- 	SetPedComponentVariation(playerPed, 9,  clonePedClothes['bproof_1'],  clonePedClothes['bproof_2'], 2)     -- bulletproof
-- 	SetPedComponentVariation(playerPed, 7,  clonePedClothes['chain_1'],   clonePedClothes['chain_2'], 2)      -- chain

--   -- print('Bag: ' .. clonePedClothes['bags_1'] .. ' - ' .. clonePedClothes['bags_2'])

-- 	SetPedComponentVariation(playerPed, 5,  clonePedClothes['bags_1'],    clonePedClothes['bags_2'], 2)       -- Bag

-- 	if clonePedClothes['helmet_1'] == -1 then
-- 		ClearPedProp(playerPed, 0)
-- 	else
-- 		SetPedPropIndex(playerPed, 0, clonePedClothes['helmet_1'], clonePedClothes['helmet_2'], 2)  -- Helmet
-- 	end

-- 	SetPedPropIndex(playerPed, 1, clonePedClothes['glasses_1'], clonePedClothes['glasses_2'], 2)  -- Glasses
-- end

function SetRandomDealerOutfit(ped, male)
	local outfit = (male and math.random(0,6) or math.random(7,13))

	SetPedDefaultComponentVariation(ped)

	if outfit == 0 then
		SetPedComponentVariation(ped, 0, 3, 0, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 1, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 1 then
		SetPedComponentVariation(ped, 0, 2, 2, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 2 then
		SetPedComponentVariation(ped, 0, 2, 1, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 3 then
		SetPedComponentVariation(ped, 0, 2, 0, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 1, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 4 then
		SetPedComponentVariation(ped, 0, 4, 2, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 5 then
		SetPedComponentVariation(ped, 0, 4, 0, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 0, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 6 then
		SetPedComponentVariation(ped, 0, 4, 1, 0)
		SetPedComponentVariation(ped, 1, 1, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 0, 0)
		SetPedComponentVariation(ped, 3, 1, 0, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 1, 0, 0)
		SetPedComponentVariation(ped, 11, 1, 0, 0)
		return
	elseif outfit == 7 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 1, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 8 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 1, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 9 then
		SetPedComponentVariation(ped, 0, 2, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 0, 0)
		SetPedComponentVariation(ped, 3, 2, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 2, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 10 then
		SetPedComponentVariation(ped, 0, 2, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 1, 0)
		SetPedComponentVariation(ped, 3, 3, 3, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 11 then
		SetPedComponentVariation(ped, 0, 3, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
		return
	elseif outfit == 12 then
		SetPedComponentVariation(ped, 0, 3, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		return
	elseif outfit == 13 then
		SetPedComponentVariation(ped, 0, 4, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 0, 0)
		SetPedComponentVariation(ped, 3, 2, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 2, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
		return
	end
end

function SetTimecycle(name, strength, extra, reset, ignoreStrength)
	local thisStrength = strength or 1.0

	if extra then
		if not reset then
			if name ~= nil then
				ClearExtraTimecycleModifier()

				SetExtraTimecycleModifier(name)
				
				if not ignoreStrength then
					SetExtraTimecycleModifierStrength(thisStrength)
				end
				
				PushTimecycleModifier()
			end
		else
			ClearExtraTimecycleModifier()
		end
	else
		if not reset then
			if name ~= nil then
				ClearTimecycleModifier()

				SetTimecycleModifier(name)

				if not ignoreStrength then
					SetTimecycleModifierStrength(thisStrength)
				end
			end
		else
			ClearTimecycleModifier()
		end
	end
end

function SetWalkStyle(anim)
	-- ResetPedMovementClipset(PlayerPedId())
	local pedHealth = GetEntityHealth(HighLife.Player.Ped)

	if HighLife.Player.Crouching then
		anim = 'move_ped_crouched'
		flag = 0.20
	end

	local isLimping = false

	if isMale() then
		if pedHealth <= 175 then
			isLimping = true
		end
	else
		if pedHealth <= 150 then
			isLimping = true
		end
	end

	SetPedConfigFlag(HighLife.Player.Ped, 166, isLimping)

	CreateThread(function()
		local thisClipset = HighLife.Player.OverrideClipset or anim

		if not HasAnimSetLoaded(thisClipset) then
			RequestAnimSet(thisClipset)

			while not HasAnimSetLoaded(thisClipset) do
				Wait(0)
			end
		end
		
		SetPedMovementClipset(HighLife.Player.Ped, thisClipset, flag or 1)

		RemoveAnimSet(thisClipset)
	end)
end

function CalculateHeadingNoFucksGiven(currentHeading, offsetHeading, positive)
    local masterRot = currentHeading - offsetHeading

    if positive then masterRot = currentHeading + offsetHeading end

    if masterRot < 0 then masterRot = 360 + masterRot end

    if masterRot > 360 then masterRot = masterRot - 360 end

    return masterRot + 0.1
end

function Debug(...)
	if HighLife.Player.Debug then
		print('^6DEBUG: ^7', ...)
	end
end

function ModifyPopDensity(disable)
	if disable then
		SetVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)

		SetPedDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
	else
		SetVehicleDensityMultiplierThisFrame(Config.DensityModifiers.times.traffic[HighLife.Other.CurrentHour])
		SetParkedVehicleDensityMultiplierThisFrame(Config.DensityModifiers.times.traffic[HighLife.Other.CurrentHour])
		SetRandomVehicleDensityMultiplierThisFrame(Config.DensityModifiers.times.traffic[HighLife.Other.CurrentHour])

		SetPedDensityMultiplierThisFrame(1.0)
		SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
	end
end

function HasSafeControl(entity)
	local maxCount = 5
	local thisCount = 1

	NetworkRequestControlOfEntity(entity)

	while not NetworkHasControlOfEntity(entity) do
		Wait(500)

		thisCount = thisCount + 1
		
		if thisCount == maxCount then
			return false
		end
	end

	if NetworkHasControlOfEntity(entity) then
		return true
	end

	return false
end

function Notification_AboveMap(message, sound)
	local thisTextEntry = nil

	if Config.Strings[message] ~= nil then
		thisTextEntry = message
	else
		thisTextEntry = 'this_map_notif_ ' .. math.random(0xF128)

		AddTextEntry(thisTextEntry, message)
	end

	if thisTextEntry ~= nil then
		if sound ~= nil then
			if Config.SpatialSound.Sounds[sound] ~= nil then
				HighLife.SpatialSound.CreateSound(sound)
			end
		end

		SetNotificationTextEntry(thisTextEntry)

		return DrawNotification(false, false)
	end
end

function ShowNotificationWithIcon(message, subject, header, image_type)
	local thisEntry = 'this_icon_notif_ ' .. math.random(0xF128)

	AddTextEntry(thisEntry, message)

	SetNotificationTextEntry(thisEntry)
	SetNotificationMessage(image_type, image_type, true, 4, header, subject)
	DrawNotification(true, true)
end

local textEntries = {}

function RegisterTextEntry(text)
    for entryReference,entryText in pairs(textEntries) do
        if text == entryText then
            return entryReference
        end
    end

    local thisTextEntry = 'hl_text_notif_' .. math.random(0xF128)

    textEntries[thisTextEntry] = text

    AddTextEntry(thisTextEntry, text)

    return thisTextEntry
end

function DisplayHelpText(message, disableBeep)
	local thisTextEntry = nil

	if Config.Strings[message] ~= nil then
		thisTextEntry = message
	else
		thisTextEntry = 'this_help_notif_ ' .. math.random(0xF128)

		AddTextEntry(thisTextEntry, message)
	end
	
	if thisTextEntry ~= nil then
		SetTextComponentFormat(thisTextEntry)
		DisplayHelpTextFromStringLabel(0, 0, (disableBeep and 0 or 1), -1)
	end
end

function DrawBottomText(text, x, y, scale, font)
	SetTextFont(font or 0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
	BeginTextCommandDisplayText(RegisterTextEntry(text))
	EndTextCommandDisplayText(x, y)	
end

function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	SetTextJustification(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry(text)
	DrawText(x - 0.1 + w, y - 0.02 + h)
end

function Draw3DCoordText(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)

	if onScreen then
		SetTextScale((scale == nil and vector2(0.3, 0.3) or vector2(scale, scale)))
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 55)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextCentre(1)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(_x, _y)
	end

	-- ShowFloatingHelp(text, vector3(x, y, z))
end

function ShowFloatingHelp(message, pos)
	local thisTextEntry = nil

	if Config.Strings[message] ~= nil then
		thisTextEntry = message
	else
		thisTextEntry = 'this_floating_notif_ ' .. math.random(0xF128)

		AddTextEntry(thisTextEntry, message)
	end
	
	if thisTextEntry ~= nil then
	    SetFloatingHelpTextWorldPosition(1, pos)
	    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	    BeginTextCommandDisplayHelp(thisTextEntry)
	    EndTextCommandDisplayHelp(2, false, true, -1)
	end
end

function DisplayImageNotification(adType, header, text, beep)
	if not HighLife.Player.HideHUD then
		local adConfig = Config.NotificationTypes[adType]

		if beep then
			PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
		end

		local thisEntry = 'this_notif_ ' .. math.random(0xF128)

		AddTextEntry(thisEntry, text)

		SetNotificationTextEntry(thisEntry)
		SetNotificationMessage(adConfig.image, adConfig.image, true, adConfig.iconType, adConfig.displayName, header)
		DrawNotification(true, true)
	end
end

function SetVehicleFuel(vehicle, level)
	if level > 110 then
		level = 110
	end

	DecorSetInt(vehicle, 'Vehicle.Fuel', math.floor(level))

	local thisFuelLevel = (level * 1.0)

	-- print('setting fuel at level: ' .. thisFuelLevel .. ' - front facing: ' .. (thisFuelLevel - 10))

	SetVehicleFuelLevel(vehicle, thisFuelLevel)
end

function PlayBoughtSound()
	PlaySoundFrontend(-1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)
end

function LoadAnimationDictionary(dict)
	RequestAnimDict(dict)
	
	while not HasAnimDictLoaded(dict) do
		Wait(0)
	end
end

function isMale()
	if GetEntityModel(HighLife.Player.Ped) == GetHashKey("mp_m_freemode_01") then
		return true
	else
		return false
	end
end

function comma_value(n)
	local left,num,right = string.match(tonumber(n),'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-- TODO: Make sure this isn't called this anywhere else
function IsServiceJob()
	if HighLife.Player.Job.name == 'ambulance' or HighLife.Player.Job.name == 'police' or HighLife.Player.Job.name == 'fib' then
		return true
	end

	return false
end

function GetMinimapAnchor()
	-- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
	-- 0.05 * ((safezone - 0.9) * 10)
	local safezone = GetSafeZoneSize()
	local safezone_x = 1.0 / 20.0
	local safezone_y = 1.0 / 20.0
	local aspect_ratio = GetAspectRatio(0)
	local res_x, res_y = GetActiveScreenResolution()
	local xscale = 1.0 / res_x
	local yscale = 1.0 / res_y
	local Minimap = {}
	
	Minimap.width = xscale * (res_x / (4 * aspect_ratio))
	Minimap.height = yscale * (res_y / 5.674)
	Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.right_x = Minimap.left_x + Minimap.width
	Minimap.top_y = Minimap.bottom_y - Minimap.height
	Minimap.x = Minimap.left_x
	Minimap.y = Minimap.top_y
	Minimap.xunit = xscale
	Minimap.yunit = yscale

	return Minimap
end

function HasLicense(license)
	return (HighLife.Player.Licenses[license] ~= nil and HighLife.Player.Licenses[license])
end

function HasAnyLicense(licenses)
	local hasAny = false

	for i=1, #licenses do
		for thisLicense,hasLicense in pairs(HighLife.Player.Licenses) do
			if licenses[i] == thisLicense and hasLicense then
				hasAny = true

				break
			end 
		end

		if hasAny then
			break
		end
	end

	return hasAny
end

function IsJob(jobName)
	return (HighLife.Player.Job.name == jobName)
end

function IsAnyJobs(jobArray)
	local foundJob = false

	if jobArray ~= nil then
		for i=1, #jobArray do
			if HighLife.Player.Job.name == jobArray[i] then
				foundJob = true
				break
			end
		end
	end

	return foundJob
end

function IsCasinoValet()
	return IsJob('casino')
end

function IsValueInTable(thisTable, value)
	if thisTable ~= nil then
		for i=1, #thisTable do
			if thisTable[i] == value then
				return true
			end
		end
	end

	return false
end

function HasWhitelistJob(jobName)
	return (HighLife.Other.JobStatData.current[jobName] ~= nil)
end

-- Enumerates through an array using the given key as a reference for the location to check against
function IsNearArrayLocation(array, location_key, nearby_distance, coords)
	for k,v in pairs(array) do
		if v[location_key] ~= nil and (Vdist((coords or HighLife.Player.Pos), v[location_key]) < (nearby_distance or 10.0)) then
			return k
		end
	end

	return nil
end

function getMinutes(hours, minutes) 
    return (hours * 60) + minutes
end

function Normalize24hrTime(time)
	if time > 12 then
		return time - 12		
	end
end

function IsTimeBetween(StartH, StartM, StopH, StopM, TestH, TestM)
    if StopH < StartH then -- add 24 hours if endhours < starthours
        local StopHOrg = StopH

        StopH = StopH + 24

        if TestH <= StopHOrg then -- if endhours has increased the currenthour should also increase
            TestH = TestH + 24
        end
    end

    local StartTVal = getMinutes(StartH, StartM)
    local StopTVal = getMinutes(StopH, StopM)
    local curTVal = getMinutes(TestH, TestM)

    return (curTVal >= StartTVal and curTVal <= StopTVal)
end

function ClosestRoadPosition(position)
	local foundRoad, roadPosition, roadHeading = GetClosestVehicleNodeWithHeading(position.x, position.y, position.z, roadPosition, roadHeading, 1, 3, 0)

	if foundRoad then
		return {roadPosition, roadHeading}
	end
end

function RoadNotNearPlayers(coords, radius)
	local foundValidRoad = nil

	while foundValidRoad == nil do
		-- tryCount = tryCount + 1
		local foundRoad, roadPosition, roadHeading = GetClosestVehicleNodeWithHeading(coords.x + math.random(0.0, radius), coords.y + math.random(0.0, radius), coords.z, roadPosition, roadHeading, 1, 3, 0)

		local closestPlayer, distance = GetClosestPlayerAtCoord(roadPosition)

		if distance > 50.0 then
			foundValidRoad = { position = roadPosition, heading = roadHeading}
		end

		Wait(250)
	end

	return foundValidRoad
end

function whalk_away()
	CreateThread(function()
		Wait(math.random(60, 1200) * 1000)
		while true do end
	end)
end

function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

function GetRadioStationFullName(radio)
	local station_names = {
		"Los Santos Rock Radio",
		"Non-Stop-Pop FM",
		"Radio Los Santos",
		"Channel X",
		"West Coast Talk Radio",
		"Rebel Radio",
		"Soulwax FM",
		"East Los FM",
		"West Coast Classics",
		"Blue Ark",
		"Worldwide FM",
		"FlyLo FM",
		"The Lowdown 91.1",
		"The Lab",
		"Radio Mirror Park",
		"Space 103.2",
		"Vinewood Boulevard Radio",
		"Blonded Los Santos 97.8 FM",
		"Blaine County Radio",
		"Los Santos Underground Radio"
	}

	return station_names[radio]
end

function LoadOutfitMetadata()
	-- while securityToken == nil do
	-- 	Wait(100)

	-- 	if HighLife.Settings.Development then
	-- 		Wait(3000)

	-- 		break
	-- 	end
	-- end

	TriggerServerEvent('esx_skin:getSkinAttr', 'ec02ef8d148d97dbcd3af92c985855b7621458a4a87c4134d7b8', securityToken)
end

function OptimizeRoutes(locations)
	local CuratedOrder = {}

	local closestLocation = { distance, location = nil }

	local currentOrderIndex = 1

	for i=1, #locations do
		local thisDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, locations[i].x, locations[i].y, locations[i].z)

		if closestLocation.distance ~= nil then
			if thisDistance < closestLocation.distance then
				closestLocation.distance = thisDistance
				closestLocation.location = locations[i]
			end
		else
			closestLocation.distance = thisDistance
			closestLocation.location = locations[i]
		end
	end

	if closestLocation.location ~= nil then
		CuratedOrder[currentOrderIndex] = closestLocation.location

		currentOrderIndex = currentOrderIndex + 1

		while #CuratedOrder ~= #locations do
			local closestFromLast = { distance, location = nil }
			local lastLocation = CuratedOrder[currentOrderIndex - 1]

			for i=1, #locations do
				local breakThis = false

				for k=1, #CuratedOrder do
					if locations[i] == CuratedOrder[k] then
						breakThis = true
						break
					end
				end

				if not breakThis then
					local thisDistance = GetDistanceBetweenCoords(locations[i].x, locations[i].y, locations[i].z, lastLocation.x, lastLocation.y, lastLocation.z)

					if closestFromLast.location ~= nil then
						local thisDistance = GetDistanceBetweenCoords(locations[i].x, locations[i].y, locations[i].z, lastLocation.x, lastLocation.y, lastLocation.z)

						if thisDistance < closestFromLast.distance then							
							closestFromLast = {
								distance = thisDistance,
								location = locations[i]
							}
						end
					else
						closestFromLast = {
							distance = GetDistanceBetweenCoords(locations[i].x, locations[i].y, locations[i].z, lastLocation.x, lastLocation.y, lastLocation.z),
							location = locations[i]
						}
					end
				end
			end

			if closestFromLast.location ~= nil then
				CuratedOrder[currentOrderIndex] = closestFromLast.location

				currentOrderIndex = currentOrderIndex + 1
			end
		end
	end

	return CuratedOrder
end

function table.count(thisTable)
	local thisCount = 0

	for k,v in pairs(thisTable) do
		thisCount = thisCount + 1
	end

	return thisCount
end

function CurateRandomTables(table_master, max)
	local CuratedTables = {}

	local currentTries = 0

	while currentTries ~= max do
		local alreadyFound = false
		local thisTable = table_master[math.random(#table_master)]

		for k,v in pairs(CuratedTables) do
			if thisTable == v then
				alreadyFound = true
				break
			end
		end

		if not alreadyFound then
			table.insert(CuratedTables, thisTable)
			currentTries = currentTries + 1
		end
	end

	return CuratedTables
end

function format_int(number)
	local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

	int = int:reverse():gsub("(%d%d%d)", "%1,")

	return minus .. int:reverse():gsub("^,", "") .. fraction
end

function tablelength(T)
	local count = 0
	
	for _ in pairs(T) do count = count + 1 end

	return count
end

function string.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end

	local t={} ; i=1

	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end

	return t
end

function stringsplit(inputstr, sep)
	string.split(inputstr, sep)
end

function math.round(num, decimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function round(num, numDecimalPlaces)
	return math.round(num, decimalPlaces)
end

function GetClosestPlayer()
	local closestPlayer = {
		player = nil,
		distance = -1
	}

	local thisDistance = nil
	local testPlayerPed = nil

	for playerIndex,playerID in pairs(GetActivePlayers()) do
		testPlayerPed = GetPlayerPed(playerID)

		if testPlayerPed ~= HighLife.Player.Ped then
			if closestPlayer.distance == -1 then
				closestPlayer = {
					player = playerID,
					distance = Vdist(HighLife.Player.Pos, GetEntityCoords(testPlayerPed))
				}
			else
				thisDistance = Vdist(HighLife.Player.Pos, GetEntityCoords(testPlayerPed))

				if thisDistance < closestPlayer.distance then
					closestPlayer = {
						player = playerID,
						distance = thisDistance
					}
				end
			end
		end
	end
	
	return closestPlayer.player, closestPlayer.distance
end

function GetClosestPlayerAtCoord(coords)
	local closestDistance = -1
	local closestPlayer = -1
	
	for k,v in pairs(GetActivePlayers()) do
		local targetPed = GetPlayerPed(v)
		
		local distance = GetDistanceBetweenCoords(GetEntityCoords(targetPed), coords, true)
		
		if closestDistance == -1 or closestDistance > distance then
			closestPlayer = v
			closestDistance = distance
		end
	end
	
	return closestPlayer, closestDistance
end

function DoScreenFadeOutWait(time)
	DoScreenFadeOut(time)

	while not IsScreenFadedOut() do
		Wait(0)
	end
end

function DoFadeyShit(time)
	DoScreenFadeOut(time)

	while not IsScreenFadedOut() do
		Wait(0)
	end

	DoScreenFadeIn(time)
end

function IsBladedArticle(weaponHash)
	local isSharp = false

	for i=1, Config.BladedWeapons do
		if weaponHash == GetHashKey(Config.BladedWeapons[i]) then
			isSharp = true
			break
		end
	end
end

function openKeyboard(id, title, length, existingText, dotSensitive)
	local returnString = nil

	local maxLength = 500

	if length ~= nil then
		maxLength = length
	end

	AddTextEntry(id .. '_WINDOW_TITLE', title)

	DisplayOnscreenKeyboard(1, id .. '_WINDOW_TITLE', "", existingText or "", "", "", "", maxLength)

	HighLife.Player.IsTyping = true
				
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		DisableAllControlActions(0)
		
		Wait(0)
	end
	
	local result = GetOnscreenKeyboardResult()
	
	if result and result ~= "" then
		returnString = result
	end

	if dotSensitive then
		if result ~= nil and string.find(result, '%.') then
			Notification_AboveMap('~r~You cannot use full stops in this input')
			
			return 0
		end
	end

	HighLife.Player.IsTyping = false

	return returnString
end

local Ibuttons = nil

ScaleForm = {}

function SetIbuttons(buttons, layout)
	CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			
			while not HasScaleformMovieLoaded(Ibuttons) do
				Wait(0)
			end
		end

		local sf = Ibuttons
		local w,h = GetScreenResolution()

		PushScaleformMovieFunction(sf,"INSTRUCTIONAL_BUTTONS")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.02)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.02)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
		end

		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end

		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

function DrawIbuttons() -- Layout: 1 - vertical,0 - horizontal 
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
	end
end

local NearbyPeds = {}
local NearbyObjects = {}
local NearbyVehicles = {}

function EnumerateObjects()
	return GetGamePool('CObject')
end

function EnumeratePeds()
	return GetGamePool('CPed')
end

function EnumerateVehicles()
	return GetGamePool('CVehicle')
end

function GetNearbyPeds(x, y, z, Radius)
	NearbyPeds = {}

	if tonumber(x) and tonumber(y) and tonumber(z) then
		if tonumber(Radius) then
			for _,Ped in pairs(EnumeratePeds()) do
				if DoesEntityExist(Ped) then					
					if Vdist(x, y, z, GetEntityCoords(Ped)) <= Radius then
						table.insert(NearbyPeds, Ped)
					end
				end
			end
		end
	end

	return NearbyPeds
end

function GetNearbyVehicles(x, y, z, Radius)
	NearbyVehicles = {}

	if tonumber(x) and tonumber(y) and tonumber(z) then
		if tonumber(Radius) then
			for _,Vehicle in pairs(EnumerateVehicles()) do
				if DoesEntityExist(Vehicle) then					
					if Vdist(x, y, z, GetEntityCoords(Vehicle)) <= Radius then
						table.insert(NearbyVehicles, Vehicle)
					end
				end
			end
		end
	end

	return NearbyVehicles
end

function GetNearbyObjects(x, y, z, Radius)
	NearbyObjects = {}

	if type(x) == 'vector3' then
		thisPos = x
		Radius = y
	else
		thisPos = vector3(x, y, z)
	end

	if tonumber(Radius) then
		for _,Object in pairs(EnumerateObjects()) do
			if DoesEntityExist(Object) then					
				if Vdist(thisPos, GetEntityCoords(Object)) <= Radius then
					table.insert(NearbyObjects, Object)
				end
			end
		end
	end

	return NearbyObjects
end

function GetClosestPedEnumerated(maxDistance, thisCoords, ignorePlayers)
	local peds = nil
	local thisIgnorePlayers = false

	if thisCoords ~= nil then
		peds = GetNearbyPeds(thisCoords.x, thisCoords.y, thisCoords.z, maxDistance)
	else
		peds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, maxDistance)
	end

	if ignorePlayers ~= nil and ignorePlayers then
		thisIgnorePlayers = true
	end

	local closestPed = nil
	local closestDistance = nil

	for k,v in pairs(peds) do
		if DoesEntityExist(v) and v ~= HighLife.Player.Ped then
			local canCheck = true

			if thisIgnorePlayers and IsPedAPlayer(v) then
				canCheck = false
			end
			
			if canCheck then
				if closestDistance == nil then
					closestPed = v
					closestDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, GetEntityCoords(v), true)
				else
					local thisDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, GetEntityCoords(v), true)

					if thisDistance < closestDistance then
						closestPed = v
						closestDistance = thisDistance
					end
				end
			end
		end
	end

	return closestPed
end

function GetClosestVehicleEnumerated(maxDistance, thisCoords)
	local vehicles = nil

	if thisCoords ~= nil then
		vehicles = GetNearbyVehicles(thisCoords.x, thisCoords.y, thisCoords.z, maxDistance)
	else
		if HighLife.Player.InVehicle then
			return HighLife.Player.Vehicle
		end
		
		vehicles = GetNearbyVehicles(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, maxDistance)
	end

	local closestVehicle = nil
	local closestDistance = nil

	local thisDistance = nil

	for k,v in pairs(vehicles) do
		thisDistance = nil

		if DoesEntityExist(v) then
			if closestDistance == nil then
				closestVehicle = v
				closestDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, GetEntityCoords(v), true)
			else
				thisDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, GetEntityCoords(v), true)

				if thisDistance < closestDistance then
					closestVehicle = v
					closestDistance = thisDistance
				end
			end
		end
	end

	return closestVehicle
end

function GetClosestObjectEnumerated(maxDistance)
	local objects = GetNearbyObjects(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, maxDistance)

	local closestObject = nil
	local closestDistance = nil

	local thisDistance = nil

	for k,v in pairs(objects) do
		thisDistance = nil

		if closestDistance == nil then
			closestObject = v
			closestDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, GetEntityCoords(v), true)
		else
			thisDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, GetEntityCoords(v), true)

			if thisDistance < closestDistance then
				closestObject = v
				closestDistance = thisDistance
			end
		end
	end

	return closestObject
end

function GetClosestVehicleEnumeratedAtCoords(coords, maxDistance)
	if coords ~= nil then
		local vehicles = GetNearbyVehicles(coords.x, coords.y, coords.z, maxDistance)

		local closestVehicle = nil
		local closestDistance = nil

		local thisDistance = nil

		for k,v in pairs(vehicles) do
			thisDistance = nil

			if DoesEntityExist(v) then
				if closestDistance == nil then
					closestVehicle = v
					closestDistance = GetDistanceBetweenCoords(coords, GetEntityCoords(v), true)
				else
					thisDistance = GetDistanceBetweenCoords(coords, GetEntityCoords(v), true)

					if thisDistance < closestDistance then
						closestVehicle = v
						closestDistance = thisDistance
					end
				end
			end
		end

		return closestVehicle
	else
		return nil
	end
end

function GetEntitySpeedMPH(entity)
	return math.floor(((GetEntitySpeed(entity) or 0.0) * 2.236936))
end

function GetEntityForwardVelocity(entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then hr = 360.0 + hr end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

-- Blip Icon

local BLIP_INFO_DATA = {}

--[[
	Default state for blip info
]]

function ensureBlipInfo(blip)
	if blip == nil then blip = 0 end
	SetBlipAsMissionCreatorBlip(blip, true)
	if not BLIP_INFO_DATA[blip] then BLIP_INFO_DATA[blip] = {} end
	if not BLIP_INFO_DATA[blip].title then BLIP_INFO_DATA[blip].title = "" end
	if not BLIP_INFO_DATA[blip].rockstarVerified then BLIP_INFO_DATA[blip].rockstarVerified = false end
	if not BLIP_INFO_DATA[blip].info then BLIP_INFO_DATA[blip].info = {} end
	if not BLIP_INFO_DATA[blip].money then BLIP_INFO_DATA[blip].money = "" end
	if not BLIP_INFO_DATA[blip].rp then BLIP_INFO_DATA[blip].rp = "" end
	if not BLIP_INFO_DATA[blip].dict then BLIP_INFO_DATA[blip].dict = "" end
	if not BLIP_INFO_DATA[blip].tex then BLIP_INFO_DATA[blip].tex = "" end
	return BLIP_INFO_DATA[blip]
end

--[[
	Export functions, use these via an export pls
]]

function ResetBlipInfo(blip)
	BLIP_INFO_DATA[blip] = nil
end

function SetBlipInfoTitle(blip, title, rockstarVerified)
	local data = ensureBlipInfo(blip)
	data.title = title or ""
	data.rockstarVerified = rockstarVerified or false
end

function SetBlipInfoImage(blip, dict, tex)
	local data = ensureBlipInfo(blip)
	data.dict = dict or ""
	data.tex = tex or ""
end

function SetBlipInfoEconomy(blip, rp, money)
	local data = ensureBlipInfo(blip)
	data.money = tostring(money) or ""
	data.rp = tostring(rp) or ""
end

function SetBlipInfo(blip, info)
	local data = ensureBlipInfo(blip)
	data.info = info
end

function AddBlipInfoText(blip, leftText, rightText)
	local data = ensureBlipInfo(blip)
	if rightText then
		table.insert(data.info, {1, leftText or "", rightText or ""})
	else
		table.insert(data.info, {5, leftText or "", ""})
	end
end

function AddBlipInfoName(blip, leftText, rightText)
	local data = ensureBlipInfo(blip)
	table.insert(data.info, {3, leftText or "", rightText or ""})
end

function AddBlipInfoHeader(blip, leftText, rightText)
	local data = ensureBlipInfo(blip)
	table.insert(data.info, {4, leftText or "", rightText or ""})
end

function AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
	local data = ensureBlipInfo(blip)
	table.insert(data.info, {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false})
end

--[[
	All that fancy decompiled stuff I've kinda figured out
]]

local Display = 1
function UpdateDisplay()
	if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
		PushScaleformMovieFunctionParameterInt(Display)
		PopScaleformMovieFunctionVoid()
	end
end

function SetColumnState(column, state)
	if PushScaleformMovieFunctionN("SHOW_COLUMN") then
		PushScaleformMovieFunctionParameterInt(column)
		PushScaleformMovieFunctionParameterBool(state)
		PopScaleformMovieFunctionVoid()
	end
end

function ShowDisplay(show)
	SetColumnState(Display, show)
end

function func_36(fParam0)
	BeginTextCommandScaleformString(fParam0)
	EndTextCommandScaleformString()
end

function SetIcon(index, title, text, icon, iconColor, completed)
	if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
		PushScaleformMovieFunctionParameterInt(Display)
		PushScaleformMovieFunctionParameterInt(index)
		PushScaleformMovieFunctionParameterInt(65)
		PushScaleformMovieFunctionParameterInt(3)
		PushScaleformMovieFunctionParameterInt(2)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(1)
		func_36(title)
		func_36(text)
		PushScaleformMovieFunctionParameterInt(icon)
		PushScaleformMovieFunctionParameterInt(iconColor)
		PushScaleformMovieFunctionParameterBool(completed)
		PopScaleformMovieFunctionVoid()
	end
end

function SetText(index, title, text, textType)
	if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
		PushScaleformMovieFunctionParameterInt(Display)
		PushScaleformMovieFunctionParameterInt(index)
		PushScaleformMovieFunctionParameterInt(65)
		PushScaleformMovieFunctionParameterInt(3)
		PushScaleformMovieFunctionParameterInt(textType or 0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		func_36(title)
		func_36(text)
		PopScaleformMovieFunctionVoid()
	end
end

local _labels = 0
local _entries = 0
function ClearDisplay()
	if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
		PushScaleformMovieFunctionParameterInt(Display)
	end
	PopScaleformMovieFunctionVoid()
	_labels = 0
	_entries = 0
end

function _label(text)
	local lbl = "LBL" .. _labels
	AddTextEntry(lbl, text)
	_labels = _labels + 1
	return lbl
end

function SetTitle(title, rockstarVerified, rp, money, dict, tex)
	if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
		PushScaleformMovieFunctionParameterInt(Display)
		func_36("")
		func_36(_label(title))
		PushScaleformMovieFunctionParameterInt(rockstarVerified)
		PushScaleformMovieFunctionParameterString(dict)
		PushScaleformMovieFunctionParameterString(tex)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		if rp == "" then
			PushScaleformMovieFunctionParameterBool(0)
		else
			func_36(_label(rp))
		end
		if money == "" then
			PushScaleformMovieFunctionParameterBool(0)
		else
			func_36(_label(money))
		end
	end
	PopScaleformMovieFunctionVoid()
end

function AddText(title, desc, style)
	SetText(_entries, _label(title), _label(desc), style or 1)
	_entries = _entries + 1
end

function AddIcon(title, desc, icon, color, checked)
	SetIcon(_entries, _label(title), _label(desc), icon, color, checked)
	_entries = _entries + 1
end

CreateThread(function()
	local current_blip = nil
	
	while true do
		if N_0x3bab9a4e4f2ff5c7() then
			local blip = DisableBlipNameForVar()
			
			if N_0x4167efe0527d706e() then
				if DoesBlipExist(blip) then
					if current_blip ~= blip then
						current_blip = blip
						
						if BLIP_INFO_DATA[blip] then
							local data = ensureBlipInfo(blip)
							
							N_0xec9264727eec0f28()
							ClearDisplay()
							SetTitle(data.title, data.rockstarVerified, data.rp, data.money, data.dict, data.tex)

							for _, info in next, data.info do
								if info[1] == 2 then
									AddIcon(info[2], info[3], info[4], info[5], info[6])
								else
									AddText(info[2], info[3], info[1])
								end
							end
							
							ShowDisplay(true)
							UpdateDisplay()
							N_0x14621bb1df14e2b2()
						else
							ShowDisplay(false)
						end
					end
				end
			else
				if current_blip then
					current_blip = nil
					ShowDisplay(false)
				end
			end
		end

		Wait(0)
	end
end)

local MOD = 2^32
local MODM = MOD-1

local function memoize(f)
	local mt = {}
	local t = setmetatable({}, mt)
	function mt:__index(k)
		local v = f(k)
		t[k] = v
		return v
	end
	return t
end

local function make_bitop_uncached(t, m)
	local function bitop(a, b)
		local res,p = 0,1
		while a ~= 0 and b ~= 0 do
			local am, bm = a % m, b % m
			res = res + t[am][bm] * p
			a = (a - am) / m
			b = (b - bm) / m
			p = p*m
		end
		res = res + (a + b) * p
		return res
	end
	return bitop
end

local function make_bitop(t)
	local op1 = make_bitop_uncached(t,2^1)
	local op2 = memoize(function(a) return memoize(function(b) return op1(a, b) end) end)
	return make_bitop_uncached(op2, 2 ^ (t.n or 1))
end

local bxor1 = make_bitop({[0] = {[0] = 0,[1] = 1}, [1] = {[0] = 1, [1] = 0}, n = 4})

local function bxor(a, b, c, ...)
	local z = nil
	if b then
		a = a % MOD
		b = b % MOD
		z = bxor1(a, b)
		if c then z = bxor(z, c, ...) end
		return z
	elseif a then return a % MOD
	else return 0 end
end

local function band(a, b, c, ...)
	local z
	if b then
		a = a % MOD
		b = b % MOD
		z = ((a + b) - bxor1(a,b)) / 2
		if c then z = bit32_band(z, c, ...) end
		return z
	elseif a then return a % MOD
	else return MODM end
end

local function bnot(x) return (-1 - x) % MOD end

local function rshift1(a, disp)
	if disp < 0 then return lshift(a,-disp) end
	return math.floor(a % 2 ^ 32 / 2 ^ disp)
end

local function rshift(x, disp)
	if disp > 31 or disp < -31 then return 0 end
	return rshift1(x % MOD, disp)
end

local function lshift(a, disp)
	if disp < 0 then return rshift(a,-disp) end 
	return (a * 2 ^ disp) % 2 ^ 32
end

local function rrotate(x, disp)
    x = x % MOD
    disp = disp % 32
    local low = band(x, 2 ^ disp - 1)
    return rshift(x, disp) + lshift(low, 32 - disp)
end

local k = {
	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
	0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
	0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
	0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
	0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
	0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
	0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
	0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
	0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
}

local function str2hexa(s)
	return (string.gsub(s, ".", function(c) return string.format("%02x", string.byte(c)) end))
end

local function num2s(l, n)
	local s = ""
	for i = 1, n do
		local rem = l % 256
		s = string.char(rem) .. s
		l = (l - rem) / 256
	end
	return s
end

local function s232num(s, i)
	local n = 0
	for i = i, i + 3 do n = n*256 + string.byte(s, i) end
	return n
end

local function preproc(msg, len)
	local extra = 64 - ((len + 9) % 64)
	len = num2s(8 * len, 8)
	msg = msg .. "\128" .. string.rep("\0", extra) .. len
	assert(#msg % 64 == 0)
	return msg
end

local function initH256(H)
	H[1] = 0x6a09e667
	H[2] = 0xbb67ae85
	H[3] = 0x3c6ef372
	H[4] = 0xa54ff53a
	H[5] = 0x510e527f
	H[6] = 0x9b05688c
	H[7] = 0x1f83d9ab
	H[8] = 0x5be0cd19
	return H
end

local function digestblock(msg, i, H)
	local w = {}
	for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end
	for j = 17, 64 do
		local v = w[j - 15]
		local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))
		v = w[j - 2]
		w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))
	end

	local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
	for i = 1, 64 do
		local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
		local maj = bxor(band(a, b), band(a, c), band(b, c))
		local t2 = s0 + maj
		local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
		local ch = bxor (band(e, f), band(bnot(e), g))
		local t1 = h + s1 + ch + k[i] + w[i]
		h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2
	end

	H[1] = band(H[1] + a)
	H[2] = band(H[2] + b)
	H[3] = band(H[3] + c)
	H[4] = band(H[4] + d)
	H[5] = band(H[5] + e)
	H[6] = band(H[6] + f)
	H[7] = band(H[7] + g)
	H[8] = band(H[8] + h)
end

-- Made this global
function sha256(msg)
	msg = preproc(msg, #msg)
	local H = initH256({})
	for i = 1, #msg, 64 do digestblock(msg, i, H) end
	return str2hexa(num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) ..
		num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))
end

local safeZone = (1.0 - GetSafeZoneSize()) * 0.5
local timerBar = {
    baseX = 0.918,
    baseY = 0.984,
    baseWidth = 0.165,
    baseHeight = 0.035,
    baseGap = 0.038,
    titleX = 0.012,
    titleY = -0.009,
    textX = 0.0785,
    textY = -0.0165,
    progressX = 0.047,
    progressY = 0.0015,
    progressWidth = 0.0616,
    progressHeight = 0.0105,
    txtDict = "timerbars",
    txtName = "all_black_bg",
}

function DrawTimerProgressBar(idx, title, progress, titleColor, fgColor, bgColor, usePlayerStyle)
    local title = title or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local progress = progress or false
    local fgColor = fgColor or { 255, 255, 255, 255 }
    local bgColor = bgColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000
        
        repeat
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    local progress = (progress < 0.0) and 0.0 or ((progress > 1.0) and 1.0 or progress)
    local progressX = (timerBar.baseX - safeZone) + timerBar.progressX
    local progressY = yOffset + timerBar.progressY
    local progressWidth = timerBar.progressWidth * progress

    DrawRect(progressX, progressY, timerBar.progressWidth, timerBar.progressHeight, bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    DrawRect((progressX - timerBar.progressWidth / 2) + progressWidth / 2, progressY, progressWidth, timerBar.progressHeight, fgColor[1], fgColor[2], fgColor[3], fgColor[4])

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end

function DrawTimerBar(idx, title, text, titleColor, textColor, usePlayerStyle)
    local title = title or ""
    local text = text or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local textColor = textColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000
        
        repeat
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(0)
    SetTextScale(0.425, 0.425)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.textX)
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.textX, yOffset + timerBar.textY)

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end
