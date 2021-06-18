local newSpawnMethod = false

function HighLife:CreateObject(modelName, coords, heading, freeze, cb)
	if newSpawnMethod then
		HighLife:ServerCallback('HighLife:CreateObject', function(createdObject)
			local thisObject = NetToObj(createdObject)

			if cb ~= nil then
				if cb == 'return' then
					return thisObject
				else
					cb(thisObject)
				end
			end
		end, modelName, { x = coords.x, y = coords.y, z = coords.z }, heading, freeze)
	else
		if not HasModelLoaded(modelName) then
			RequestModel(modelName)

			while not HasModelLoaded(modelName) do
				Wait(1)
			end
		end

		local thisObject = CreateObject(modelName, coords.x, coords.y, coords.z, true, false, true)

		SetEntityHeading(thisObject, heading)

		SetModelAsNoLongerNeeded(modelName)

		if cb ~= nil then
			if cb == 'return' then
				return thisObject
			else
				cb(thisObject)
			end
		end
	end
end

function HighLife:CreateVehicle(modelName, coords, heading, loadCollision, isNetworked, cb, oldMethod)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	if newSpawnMethod and not oldMethod then
		HighLife:ServerCallback('HighLife:CreateVehicle', function(vehicleNetID)
			local thisVehicleEntity = NetworkGetEntityFromNetworkId(vehicleNetID)

			while thisVehicleEntity == 0 or not DoesEntityExist(thisVehicleEntity) do
				Wait(1)

				thisVehicleEntity = NetworkGetEntityFromNetworkId(vehicleNetID)
			end

			SetVehicleOnGroundProperly(thisVehicleEntity)

			SetEntityHeading(thisVehicleEntity, HighLife.Player.Heading)

			SetVehRadioStation(thisVehicleEntity, "OFF")

			DecorSetBool(thisVehicleEntity, 'Vehicle.PlayerOwned', true)
			DecorSetBool(thisVehicleEntity, 'Vehicle.Legit', true)

			if cb ~= nil then
				if cb == 'return' then
					return thisVehicleEntity
				else
					cb(thisVehicleEntity)
				end
			end
		end, model, {x = coords.x, y = coords.y, z = coords.z}, heading)
	else
		RequestModel(model)

		while not HasModelLoaded(model) do
			Wait(1)
		end

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, isNetworked, false)

		if isNetworked then
			local id = NetworkGetNetworkIdFromEntity(vehicle)

			SetNetworkIdCanMigrate(id, true)
			SetEntityAsMissionEntity(vehicle, true, false)
			SetVehicleHasBeenOwnedByPlayer(vehicle, true)

			N_0xc1805d05e6d4fe10(vehicle)
			SetVehicleRadioLoud(vehicle, true)
		end

		SetVehRadioStation(vehicle, "OFF")

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		DecorSetBool(vehicle, 'Vehicle.PlayerOwned', true)
		DecorSetBool(vehicle, 'Vehicle.Legit', true)

		SetModelAsNoLongerNeeded(model)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		if loadCollision then
			while not HasCollisionLoadedAroundEntity(vehicle) do
				Wait(0)
			end
		end

		if cb ~= nil then
			if cb == 'return' then
				return vehicle
			else
				cb(vehicle)
			end
		end
	end
end

function HighLife:DeleteVehicle(vehicle)
	SetEntityAsMissionEntity(vehicle, false, true)
	
	DeleteVehicle(vehicle)
end

function HighLife:GetVehicleProperties(vehicle)
	local color1, color2 = GetVehicleColours(vehicle)
	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

	local pr, pg, pb = GetVehicleCustomPrimaryColour(vehicle)
	local sr, sg, sb = GetVehicleCustomSecondaryColour(vehicle)

	local interiorColor = GetVehicleInteriorColour(vehicle)
	local dashboardColor = GetVehicleDashboardColour(vehicle)

	local thisVehicleColor = {
		primary = {
			r = pr,
			g = pg,
			b = pb,
		},
		secondary = {
			r = sr,
			g = sg,
			b = sb,
		},
		interior = interiorColor,
		dashboard = dashboardColor,
		pearlescent = pearlescentColor,
		wheels = wheelColor
	}

	return {
		model = GetEntityModel(vehicle),
		plate = GetVehicleNumberPlateText(vehicle),
		plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
		health = GetEntityHealth(vehicle),
		dirtLevel = GetVehicleDirtLevel(vehicle),
		color1 = color1,
		color2 = color2,
		colorData = thisVehicleColor,
		pearlescentColor = pearlescentColor,
		wheelColor = wheelColor,
		wheels = GetVehicleWheelType(vehicle),
		windowTint = GetVehicleWindowTint(vehicle),
		neonEnabled = {
			IsVehicleNeonLightEnabled(vehicle, 0),
			IsVehicleNeonLightEnabled(vehicle, 1),
			IsVehicleNeonLightEnabled(vehicle, 2),
			IsVehicleNeonLightEnabled(vehicle, 3),
		},
		neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
		tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),
		modSpoilers = GetVehicleMod(vehicle, 0),
		modFrontBumper = GetVehicleMod(vehicle, 1),
		modRearBumper = GetVehicleMod(vehicle, 2),
		modSideSkirt = GetVehicleMod(vehicle, 3),
		modExhaust = GetVehicleMod(vehicle, 4),
		modFrame = GetVehicleMod(vehicle, 5),
		modGrille = GetVehicleMod(vehicle, 6),
		modHood = GetVehicleMod(vehicle, 7),
		modFender = GetVehicleMod(vehicle, 8),
		modRightFender = GetVehicleMod(vehicle, 9),
		modRoof = GetVehicleMod(vehicle, 10),
		modEngine = GetVehicleMod(vehicle, 11),
		modBrakes = GetVehicleMod(vehicle, 12),
		modTransmission = GetVehicleMod(vehicle, 13),
		modHorns = GetVehicleMod(vehicle, 14),
		modSuspension = GetVehicleMod(vehicle, 15),
		modArmor = GetVehicleMod(vehicle, 16),
		modTurbo = IsToggleModOn(vehicle,  18),
		modSmokeEnabled = IsToggleModOn(vehicle,  20),
		modXenon = IsToggleModOn(vehicle,  22),
		modFrontWheels = GetVehicleMod(vehicle, 23),
		modBackWheels = GetVehicleMod(vehicle, 24),
		modPlateHolder = GetVehicleMod(vehicle, 25),
		modVanityPlate = GetVehicleMod(vehicle, 26),
		modTrimA = GetVehicleMod(vehicle, 27),
		modOrnaments = GetVehicleMod(vehicle, 28),
		modDashboard = GetVehicleMod(vehicle, 29),
		modDial = GetVehicleMod(vehicle, 30),
		modDoorSpeaker = GetVehicleMod(vehicle, 31),
		modSeats = GetVehicleMod(vehicle, 32),
		modSteeringWheel = GetVehicleMod(vehicle, 33),
		modShifterLeavers = GetVehicleMod(vehicle, 34),
		modAPlate = GetVehicleMod(vehicle, 35),
		modSpeakers = GetVehicleMod(vehicle, 36),
		modTrunk = GetVehicleMod(vehicle, 37),
		modHydrolic = GetVehicleMod(vehicle, 38),
		modEngineBlock = GetVehicleMod(vehicle, 39),
		modAirFilter = GetVehicleMod(vehicle, 40),
		modStruts = GetVehicleMod(vehicle, 41),
		modArchCover = GetVehicleMod(vehicle, 42),
		modAerials = GetVehicleMod(vehicle, 43),
		modTrimB = GetVehicleMod(vehicle, 44),
		modTank = GetVehicleMod(vehicle, 45),
		modWindows = GetVehicleMod(vehicle, 46),
		modLivery = GetVehicleMod(vehicle, 48),
		fuel = GetVehicleFuelLevel(vehicle),
		modXenonColor = GetVehicleXenonLightsColour(vehicle),
		distance_travelled = math.floor(DecorGetInt(vehicle, 'Vehicle.TravelDistance'))
	}
end

function HighLife:SetVehicleProperties(vehicle, props)
	SetVehicleModKit(vehicle,  0)

	if props.plate ~= nil then
		SetVehicleNumberPlateText(vehicle, props.plate)
	end

	if props.modXenonColor ~= nil then
		SetVehicleHeadlightsColour(vehicle, props.modXenonColor)
	end

	if props.fuel ~= nil then
		SetVehicleFuel(vehicle, props.fuel)
	end

	if props.distance_travelled ~= nil then
		DecorSetInt(vehicle, 'Vehicle.TravelDistance', props.distance_travelled)
	end

	if props.plateIndex ~= nil then
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	end

	if props.health ~= nil then
		SetEntityHealth(vehicle, props.health)
	end

	if props.dirtLevel ~= nil then
		SetVehicleDirtLevel(vehicle, props.dirtLevel)
	end

	if props.color1 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if props.color2 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if props.colorData ~= nil then
		if props.colorData.primary.r ~= nil then
			SetVehicleCustomPrimaryColour(vehicle, props.colorData.primary.r, props.colorData.primary.g, props.colorData.primary.b)
		end

		if props.colorData.secondary.r ~= nil then
			SetVehicleCustomSecondaryColour(vehicle, props.colorData.secondary.r, props.colorData.secondary.g, props.colorData.secondary.b)
		end

		if props.colorData.interior ~= nil then
			SetVehicleInteriorColour(vehicle, props.colorData.interior)
		end

		if props.colorData.dashboard ~= nil then
			SetVehicleDashboardColour(vehicle, props.colorData.dashboard)
		end
	end

	if props.pearlescentColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		
		SetVehicleExtraColours(vehicle,  props.pearlescentColor,  wheelColor)
	end

	if props.wheelColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		
		SetVehicleExtraColours(vehicle,  pearlescentColor,  props.wheelColor)
	end

	if props.wheels ~= nil then
		SetVehicleWheelType(vehicle,  props.wheels)
	end

	if props.windowTint ~= nil then
		SetVehicleWindowTint(vehicle,  props.windowTint)
	end

	if props.neonEnabled ~= nil then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	end

	if props.neonColor ~= nil then
		SetVehicleNeonLightsColour(vehicle,  props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if props.modSmokeEnabled ~= nil then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if props.tyreSmokeColor ~= nil then
		SetVehicleTyreSmokeColor(vehicle,  props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if props.modSpoilers ~= nil then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if props.modFrontBumper ~= nil then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if props.modRearBumper ~= nil then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if props.modSideSkirt ~= nil then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if props.modExhaust ~= nil then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if props.modFrame ~= nil then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if props.modGrille ~= nil then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if props.modHood ~= nil then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if props.modFender ~= nil then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if props.modRightFender ~= nil then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if props.modRoof ~= nil then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if props.modEngine ~= nil then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if props.modBrakes ~= nil then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if props.modTransmission ~= nil then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if props.modHorns ~= nil then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if props.modSuspension ~= nil then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if props.modArmor ~= nil then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if props.modTurbo ~= nil then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if props.modXenon ~= nil then
		ToggleVehicleMod(vehicle,  22, props.modXenon)
	end

	if props.modFrontWheels ~= nil then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	end

	if props.modBackWheels ~= nil then
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	end

	if props.modPlateHolder ~= nil then
		SetVehicleMod(vehicle, 25, props.modPlateHolder , false)
	end

	if props.modVanityPlate ~= nil then
		SetVehicleMod(vehicle, 26, props.modVanityPlate , false)
	end

	if props.modTrimA ~= nil then
		SetVehicleMod(vehicle, 27, props.modTrimA , false)
	end

	if props.modOrnaments ~= nil then
		SetVehicleMod(vehicle, 28, props.modOrnaments , false)
	end

	if props.modDashboard ~= nil then
		SetVehicleMod(vehicle, 29, props.modDashboard , false)
	end

	if props.modDial ~= nil then
		SetVehicleMod(vehicle, 30, props.modDial , false)
	end

	if props.modDoorSpeaker ~= nil then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker , false)
	end

	if props.modSeats ~= nil then
		SetVehicleMod(vehicle, 32, props.modSeats , false)
	end

	if props.modSteeringWheel ~= nil then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel , false)
	end

	if props.modShifterLeavers ~= nil then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers , false)
	end

	if props.modAPlate ~= nil then
		SetVehicleMod(vehicle, 35, props.modAPlate , false)
	end

	if props.modSpeakers ~= nil then
		SetVehicleMod(vehicle, 36, props.modSpeakers , false)
	end

	if props.modTrunk ~= nil then
		SetVehicleMod(vehicle, 37, props.modTrunk , false)
	end

	if props.modHydrolic ~= nil then
		SetVehicleMod(vehicle, 38, props.modHydrolic , false)
	end

	if props.modEngineBlock ~= nil then
		SetVehicleMod(vehicle, 39, props.modEngineBlock , false)
	end

	if props.modAirFilter ~= nil then
		SetVehicleMod(vehicle, 40, props.modAirFilter , false)
	end

	if props.modStruts ~= nil then
		SetVehicleMod(vehicle, 41, props.modStruts , false)
	end

	if props.modArchCover ~= nil then
		SetVehicleMod(vehicle, 42, props.modArchCover , false)
	end

	if props.modAerials ~= nil then
		SetVehicleMod(vehicle, 43, props.modAerials , false)
	end

	if props.modTrimB ~= nil then
		SetVehicleMod(vehicle, 44, props.modTrimB , false)
	end

	if props.modTank ~= nil then
		SetVehicleMod(vehicle, 45, props.modTank , false)
	end

	if props.modWindows ~= nil then
		SetVehicleMod(vehicle, 46, props.modWindows , false)
	end

	if props.modLivery ~= nil then
		SetVehicleMod(vehicle, 48, props.modLivery , false)
	end
end