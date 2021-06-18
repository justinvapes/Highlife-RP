local lastRoute = nil

local jobRoutes = nil
local jobRoutesCount = 1

local closestJob = nil

local currentMenu = nil

local jobStartTime = nil

local Blips = {
	core = nil,
	routes = nil
}

local currentRoute = {
	blip = nil,
	location = nil,
	distance = nil,
	nearbyTrigger = false
}

local current_object = {
	item = nil,
	entity = nil
}

local inMenu = false
local isFinished = false
local inWorkVehicle = false
local isCoreHoursBonus = false
local isTrailerAttached = false

local isDebugMode = false

items_menu = nil
outfit_menu = nil
weapons_menu = nil
equipment_menu = nil

for k,v in pairs(Config.Jobs) do
	HighLife.Player.Job.Data[string.lower(k)] = {
		actions_left = nil,
		actions_start = nil,

		current_strikes = 0,

		insurance_fee = 0,
		total_distance = 0,

		vehicle = {
			blip = nil,
			plate = nil,
			entity = nil
		},
		trailer = {
			blip = nil,
			entity = nil
		}
	}
end

RegisterNetEvent('HighLife:Jobs:UpdateJob')
AddEventHandler('HighLife:Jobs:UpdateJob', function(updateJobData)
	local latestJobData = json.decode(updateJobData)

	for jobName,jobData in pairs(latestJobData) do
		if HighLife.Other.JobStatData.current[jobName] ~= nil then
			if jobData.rank > HighLife.Other.JobStatData.current[jobName].rank then
				ShowPromotion(jobName, jobData.rank)
			end
		else
			ShowPromotion(jobName, jobData.rank)
		end

		HighLife.Other.JobStatData.current[jobName] = jobData
	end
end)

RegisterNetEvent('HighLife:Jobs:UpdateOutfitData')
AddEventHandler('HighLife:Jobs:UpdateOutfitData', function(jobName, jobOutfitData)
	if jobName ~= nil and jobOutfitData ~= nil then
		HighLife.Player.GlobalJobOutfitData[jobName] = json.decode(jobOutfitData)
	end
end)

function ShowPromotion(jobName, rank)
	CreateThread(function()
		ShowNotificationPic(Config.Jobs[jobName].MenuName, '~g~Headquarters', '~g~Congratulations~s~, you have earned a ~y~promotion ~s~at ~y~' .. Config.Jobs[jobName].MenuName .. '~s~!')
					
		Wait(2000)

		PlayMissionCompleteAudio("FRANKLIN_BIG_01")

		Wait(250)

		ShowNotificationPic(Config.Jobs[jobName].MenuName, '~g~Headquarters', 'You are now ~y~rank ~g~' .. rank)
	end)
end

RegisterNetEvent('HighLife:Jobs:ReturnMessage')
AddEventHandler('HighLife:Jobs:ReturnMessage', function(jobName, subject, message, completeSound)
	if completeSound then
		PlayMissionCompleteAudio("FRANKLIN_BIG_01")
	end

	Wait(500)
	
	ShowNotificationPic(Config.Jobs[jobName].MenuName, subject, message)
end)

function SpawnWorkVehicle(vehicleData, jobName, location)
	local bestRank = 0
	local useSecretKey = false

	local vehicleHash = GetHashKey(vehicleData.model)

	MenuVariables.Jobs.CreatingVehicle = true

	CreateThread(function()
		if vehicleData.price ~= nil and Config.Jobs[jobName].Society ~= nil then
			ShowNotificationPic(Config.Jobs[jobName].MenuName, '~g~Headquarters', '~r~$' .. vehicleData.price .. ' ~s~will be ~r~deducted ~s~from the fund if you do not return your vehicle')
		end

		HighLife:CreateVehicle(vehicleHash, {x = location.x, y = location.y, z = location.z + 0.5}, location.heading, true, true, function(workVehicle)
			if vehicleData.spawnOffset ~= nil then
				local preSpawnPos = {x = location.x, y = location.y, z = location.z + 0.5}

				SetEntityCoordsNoOffset(workVehicle, GetObjectOffsetFromCoords(preSpawnPos.x, preSpawnPos.y, preSpawnPos.z, location.heading, vehicleData.spawnOffset), false, false, false)
			end

			PlaceObjectOnGroundProperly(workVehicle)

			if not DecorExistOn(workVehicle, 'Vehicle.WorkVehicleOwner') then
				DecorSetInt(workVehicle, 'Vehicle.WorkVehicleOwner', GetPlayerServerId(HighLife.Player.Id))
			end

			if vehicleData.rank_data ~= nil then
				for k,v in pairs(vehicleData.rank_data) do
					if (HighLife.Other.JobStatData.current[jobName] ~= nil and HighLife.Other.JobStatData.current[jobName].rank or 1) >= k then
						if k > bestRank then
							bestRank = k
						end
					end
				end
			end

			HighLife.Player.Job.Data[jobName].actions_left = vehicleData.max_actions
			HighLife.Player.Job.Data[jobName].actions_start = vehicleData.max_actions
			HighLife.Player.Job.Data[jobName].vehicle.plate = string.gsub(Config.Jobs[jobName].VehiclePrefix .. math.random(100000, 999999), "%s+", "")

			SetVehicleDirtLevel(workVehicle, 0.0)
			SetVehicleFixed(workVehicle)
			SetVehicleOnGroundProperly(workVehicle)
			SetVehicleNumberPlateText(workVehicle, HighLife.Player.Job.Data[jobName].vehicle.plate)
			SetVehicleLivery(workVehicle, vehicleData.livery or 1) -- always try for the livery

			if vehicleData.extras ~= nil then
				if vehicleData.extras.tint ~= nil then
					SetVehicleWindowTint(workVehicle, vehicleData.extras.tint)
				end

				if vehicleData.extras.options ~= nil then
					for k,v in pairs(vehicleData.extras.options) do
						SetVehicleExtra(workVehicle, k, not v)
					end
				end

				if vehicleData.extras.livery ~= nil then
					if IsControlPressed(0, 182) then
						useSecretKey = true

						SetVehicleLivery(workVehicle, vehicleData.extras.livery.option)

						SetVehicleCustomPrimaryColour(workVehicle, vehicleData.extras.livery.primary_color[1], vehicleData.extras.livery.primary_color[2], vehicleData.extras.livery.primary_color[3])
						SetVehicleCustomSecondaryColour(workVehicle, vehicleData.extras.livery.secondary_color[1], vehicleData.extras.livery.secondary_color[2], vehicleData.extras.livery.secondary_color[3])
						SetVehicleExtraColours(workVehicle, vehicleData.extras.livery.pearlescent_color, 0)
					end
				end
			end

			if not useSecretKey then
				if vehicleData.rank_data ~= nil and vehicleData.rank_data[bestRank] ~= nil then
					local customOptions = vehicleData.rank_data[bestRank]

					if customOptions.primary_color ~= nil then
						SetVehicleCustomPrimaryColour(workVehicle, customOptions.primary_color[1], customOptions.primary_color[2], customOptions.primary_color[3])
					end

					if customOptions.secondary_color ~= nil then
						SetVehicleCustomSecondaryColour(workVehicle, customOptions.secondary_color[1], customOptions.secondary_color[2], customOptions.secondary_color[3])
					end

					if customOptions.pearlescent_color ~= nil then
						SetVehicleExtraColours(workVehicle, customOptions.pearlescent_color, 0)
					end
				end
			end

			if vehicleData.randomColor ~= nil and vehicleData.randomColor then
				local randomPrimary, randomSecondary = math.random(255), math.random(255)

				SetVehicleColours(workVehicle, randomPrimary, randomSecondary)
			end

			if vehicleData.blip ~= nil then
				BlipWorkVehicle(workVehicle, vehicleData.blip, jobName .. ' Vehicle', jobName)
			end

			SetVehicleModKit(workVehicle, 0)

			SetVehicleMod(workVehicle, 48, vehicleData.livery or 0, false)

			if vehicleData.hasUpgrades then
				SetVehicleMod(workVehicle, 11, 2) -- Engine
				SetVehicleMod(workVehicle, 12, 2) -- Brakes
				SetVehicleMod(workVehicle, 13, 2) -- Trans
				SetVehicleMod(workVehicle, 15, 3) -- Suspension
				SetVehicleMod(workVehicle, 16, 2) -- Armor
				
				ToggleVehicleMod(workVehicle, 18, 1) -- Turbo
			end

			if IsAprilFools() then
				SetVehicleMod(workVehicle, 14, 2) -- Horn
			end

			ShowNotificationPic(Config.Jobs[jobName].MenuName, '~g~Headquarters', 'Your vehicle is waiting for you at the ' .. Config.Jobs[jobName].MenuName .. ' ~s~depot, check your ~g~map')

			SetVehicleFuel(workVehicle, 110.0)

			LockVehicle(workVehicle, true)

			TriggerEvent('HighLife:LockSystem:GiveKeys', GetVehicleNumberPlateText(workVehicle), true)

			HighLife.Player.Job.Data[jobName].vehicle.entity = workVehicle
			HighLife.Player.Job.Data[jobName].vehicle.model = vehicleData.model
			HighLife.Player.Job.Data[jobName].vehicle.netID = NetworkGetNetworkIdFromEntity(workVehicle)

			MenuVariables.Jobs.CreatingVehicle = false

			if vehicleData.trailers ~= nil then
				local thisTrailerPos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Job.Data[jobName].vehicle.entity, 0.0, -5.0, 0.0)

				FreezeEntityPosition(HighLife.Player.Job.Data[jobName].vehicle.entity, true)

				HighLife:CreateVehicle(GetHashKey(vehicleData.trailers[math.random(#vehicleData.trailers)]), {x = thisTrailerPos.x, y = thisTrailerPos.y, z = thisTrailerPos.z}, GetEntityHeading(HighLife.Player.Job.Data[jobName].vehicle.entity), true, true, function(workTrailer)
					HighLife.Player.Job.Data[jobName].trailer.entity = workTrailer
					HighLife.Player.Job.Data[jobName].trailer.netID = NetworkGetNetworkIdFromEntity(HighLife.Player.Job.Data[jobName].trailer.entity)

					AttachVehicleToTrailer(HighLife.Player.Job.Data[jobName].vehicle.entity, workTrailer, 10.0)

					FreezeEntityPosition(HighLife.Player.Job.Data[jobName].vehicle.entity, false)

					if vehicleData.trailer_vehicle ~= nil then
						local trailerVehiclePos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Job.Data[jobName].trailer.entity, 0.0, 0.0, 5.0)

						HighLife:CreateVehicle(GetHashKey(vehicleData.trailer_vehicle), {x = trailerVehiclePos.x, y = trailerVehiclePos.y, z = trailerVehiclePos.z}, GetEntityHeading(HighLife.Player.Job.Data[jobName].trailer.entity), true, true, function(workTrailerVehicle)
							AutoAttachVehicleToTrailer(workTrailerVehicle, workTrailer)

							SetVehicleFuel(workTrailerVehicle, 110.0)

							LockVehicle(workTrailerVehicle, true)

							TriggerEvent('HighLife:LockSystem:GiveKeys', GetVehicleNumberPlateText(workTrailerVehicle), true)
						end)
					end
				end)
			end
		end)
	end)
end

function CapitalizeString(str)
    return (str:gsub("^%l", string.upper))
end

function DeleteWorkVehicle(jobName, withinRange)
	RemoveBlip(GetBlipFromEntity(HighLife.Player.Job.Data[jobName].vehicle.entity))

	if withinRange then
		TriggerServerEvent('HighLife:Entity:Delete', HighLife.Player.Job.Data[jobName].vehicle.netID)

		if HighLife.Player.Job.Data[jobName].trailer.netID ~= nil then
			TriggerServerEvent('HighLife:Entity:Delete', HighLife.Player.Job.Data[jobName].trailer.netID)
		end
	end

	HighLife.Player.Job.Data[jobName].vehicle.netID = nil
	HighLife.Player.Job.Data[jobName].vehicle.plate = nil
	HighLife.Player.Job.Data[jobName].vehicle.entity = nil
	HighLife.Player.Job.Data[jobName].vehicle.trailer = nil
end

function RemoveCurrentRoute()
	RemoveBlip(currentRoute.blip)

	currentRoute.location = nil
	currentRoute.distance = nil
	currentRoute.nearbyTrigger = false
end

function PlayBeepSound()
	PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
end

function ShowNotificationPic(jobName, subject, message)
	PlayBeepSound()

	local thisEntry = 'this_job_return_text_ ' .. math.random(0xF128)

	AddTextEntry(thisEntry, message)

	SetNotificationTextEntry(thisEntry)
	SetNotificationMessage('CHAR_MP_PROF_BOSS', 'CHAR_MP_PROF_BOSS', true, 4, jobName, subject)
	DrawNotification(false, true)
end

function DeleteWorldProp(entity)
	CreateThread(function()
		NetworkRequestControlOfEntity(entity)

		SetEntityAsMissionEntity(entity, true, true)
		DeleteObject(entity)
	end)
end

function BlipWorkVehicle(entity, data, name, jobName)
	HighLife.Player.Job.Data[jobName].vehicle.blip = AddBlipForEntity(entity)

	SetBlipAsShortRange(HighLife.Player.Job.Data[jobName].vehicle.blip, 0)
	SetBlipSprite(HighLife.Player.Job.Data[jobName].vehicle.blip, data.sprite)
	SetBlipColour(HighLife.Player.Job.Data[jobName].vehicle.blip, data.color)
	SetBlipScale(HighLife.Player.Job.Data[jobName].vehicle.blip, 0.6)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(name)
	EndTextCommandSetBlipName(HighLife.Player.Job.Data[jobName].vehicle.blip)
end

function DrawRoute(routeType, location)
	local blip_data = Config.Jobs[HighLife.Player.Job.CurrentJob].Blips[routeType]

	-- currentRoute.blip = AddBlipForCoord(location.x, location.y, location.z)
	currentRoute.blip = AddBlipForCoord(location.x, location.y, 563.43)

	SetBlipAsShortRange(currentRoute.blip, 0)
	SetBlipSprite(currentRoute.blip, blip_data.sprite)
	SetBlipColour(currentRoute.blip, blip_data.color)
	SetBlipRoute(currentRoute.blip, true)
	SetBlipScale(currentRoute.blip, 0.6)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(blip_data.name)
	EndTextCommandSetBlipName(currentRoute.blip)

	if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_start == HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left then
		DisplayHelpText('A new ~g~' .. routeType .. ' ~s~has been ~y~marked')
	end
end

function HighLife:ResetTempJobData(jobName)
	HighLife.Player.Job.Data[string.lower(jobName)] = {
		actions_left = nil,
		actions_start = nil,

		current_strikes = 0,

		insurance_fee = 0,
		total_distance = 0,

		vehicle = {
			blip = nil,
			plate = nil,
			entity = nil
		},
		trailer = {
			blip = nil,
			entity = nil
		}
	}

	current_object = {
		item = nil,
		entity = nil
	}

	TriggerServerEvent('HighLife:Jobs:startWorking', '', '', true)

	RemoveCurrentRoute()

	jobRoutes = nil
	jobRoutesCount = 1

	isFinished = false
end

function HighLife:OpenClosestJob()
	if HighLife.Player.JobReset then
		if closestJob ~= nil and closestJob.job ~= nil then
			if HighLife.Other.JobStatData.current[closestJob.job] ~= nil then
				DrawJobMenu(closestJob.job)
			end
		end
	end
end

function HighLife:EndCurrentJob(ignoreSkin)
	HighLife.Player.Job.InService = false

	HighLife.Player.JobClothingDebug = false

	if ignoreSkin == nil or not ignoreSkin then
		HighLife:ResetOverrideClothing()
	end

	if HighLife.Player.Job.CurrentJob ~= nil then
		if HighLife.Player.Job.CurrentJob == 'police' or HighLife.Player.Job.CurrentJob == 'fib' then
			SetPedArmour(HighLife.Player.Ped, 0)
		end
		
		if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity ~= nil then
			SetEntityAsNoLongerNeeded(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity)
		end

		if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity ~= nil then
			SetEntityAsNoLongerNeeded(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity)
		end

		RemoveBlip(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.blip)

		HighLife:ResetTempJobData(HighLife.Player.Job.CurrentJob)
	end
end

function DrawJobMenu(jobName)
	MenuVariables.Jobs.Vehicles = {}

	if Config.Jobs[jobName].Vehicles ~= nil then
		if Config.Jobs[jobName].SemiWhitelisted then
			for k,v in pairs(Config.Jobs[jobName].Vehicles) do
				local canAdd = false

				if v.license ~= nil then
					if HighLife.Player.Licenses[v.license] then
						canAdd = true
					end
				else
					canAdd = true
				end

				if canAdd then
					local vehicleName = v.name

					if v.max_actions ~= nil then
						vehicleName = v.name .. ' (' .. v.max_actions .. ')'
					end

					table.insert(MenuVariables.Jobs.Vehicles, vehicleName)
				end
			end
		else
			for k,v in pairs(Config.Jobs[jobName].Vehicles) do
				if HighLife.Other.JobStatData.current == nil then
					Wait(2000)

					print('Attempting to get JobStatData for ' .. jobName)
				end

				if HighLife.Other.JobStatData.current[jobName] ~= nil then
					if (HighLife.Other.JobStatData.current[jobName].rank >= v.rank) or HighLife.Player.Debug then
						local canAdd = false

						if v.air_vehicle ~= nil and v.air_vehicle then
							if closestJob.thisMenu.vehicle_spawn ~= nil and closestJob.thisMenu.vehicle_spawn.air_capable ~= nil and closestJob.thisMenu.vehicle_spawn.air_capable then
								canAdd = true
							end

							if closestJob.thisMenu.air_spawn ~= nil and closestJob.thisMenu.air_spawn.air_capable ~= nil and closestJob.thisMenu.air_spawn.air_capable then
								canAdd = true
							end
						elseif v.boat_vehicle ~= nil and v.boat_vehicle then
							if closestJob.thisMenu.vehicle_spawn ~= nil and closestJob.thisMenu.vehicle_spawn.boat_capable ~= nil and closestJob.thisMenu.vehicle_spawn.boat_capable then
								canAdd = true
							end

							if closestJob.thisMenu.boat_spawn ~= nil and closestJob.thisMenu.boat_spawn.boat_capable ~= nil and closestJob.thisMenu.boat_spawn.boat_capable then
								canAdd = true
							end
						else
							canAdd = true
						end

						if v.rank_attribute ~= nil then
							canAdd = false

							if (HighLife.Other.JobStatData.current[jobName].data ~= nil and HighLife.Other.JobStatData.current[jobName].data[v.rank_attribute] ~= nil and HighLife.Other.JobStatData.current[jobName].data[v.rank_attribute]) or HighLife.Player.Debug then
								canAdd = true
							end
						end
						
						if canAdd then
							local vehicleName = v.name

							if v.max_actions ~= nil then
								vehicleName = v.name .. ' (' .. v.max_actions .. ')'
							end

							table.insert(MenuVariables.Jobs.Vehicles, vehicleName)
						end
					end
				end
			end
		end
	end

	MenuVariables.Jobs.Key = string.lower(jobName)
	MenuVariables.Jobs.Menu = closestJob.thisMenu
	MenuVariables.Jobs.Config = Config.Jobs[jobName]

	RMenu:Get('job', 'main'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'main'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RMenu:Get('job', 'equipment'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'equipment'):SetSubtitle(Config.Jobs[jobName].MenuDesc)
	
	RMenu:Get('job', 'management'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'management'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RMenu:Get('job', 'manage_outfits'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'manage_outfits'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RMenu:Get('job', 'outfit_options'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'outfit_options'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RMenu:Get('job', 'items'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'items'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RMenu:Get('job', 'weapons'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'weapons'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RMenu:Get('job', 'uniforms'):SetTitle(Config.Jobs[jobName].MenuName)
	RMenu:Get('job', 'uniforms'):SetSubtitle(Config.Jobs[jobName].MenuDesc)

	RageUI.Visible(RMenu:Get('job', 'main'), true)
end

CreateThread(function()
	for k,v in pairs(Config.Jobs) do
		if v.JobActions.Menus ~= nil then
			for j,jobAction in pairs(v.JobActions.Menus) do
				if jobAction.blip ~= nil then
					local thisBlip = AddBlipForCoord(jobAction.x, jobAction.y, jobAction.z)

					SetBlipAsShortRange(thisBlip, 1)
					SetBlipSprite(thisBlip, jobAction.blip.sprite)
					SetBlipColour(thisBlip, jobAction.blip.color)
					SetBlipScale(thisBlip, 0.8)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(jobAction.blip.name)
					EndTextCommandSetBlipName(thisBlip)

					SetBlipInfoTitle(thisBlip, jobAction.blip.name, false)
					AddBlipInfoText(thisBlip, "Motto", '"' .. v.MenuDesc .. '~s~"')
					AddBlipInfoText(thisBlip, "Job Description", v.JobType)

					if v.PayoutPerFakeMile ~= nil then
						AddBlipInfoHeader(thisBlip, "Share Price", "$" .. v.PayoutPerFakeMile * 1000)
					end

					if jobAction.blip.image ~= nil then
						RequestStreamedTextureDict(jobAction.blip.image.dict, 1)
						while not HasStreamedTextureDictLoaded(jobAction.blip.image.dict)  do
							Wait(1)
						end
						
						SetBlipInfoImage(thisBlip, jobAction.blip.image.dict, jobAction.blip.image.name) 
					end
				end
			end
		else
			for j,jobAction in pairs(v.JobActions) do
				if jobAction.blip ~= nil then
					local thisBlip = AddBlipForCoord(jobAction.x, jobAction.y, jobAction.z)

					SetBlipAsShortRange(thisBlip, 1)
					SetBlipSprite(thisBlip, jobAction.blip.sprite)
					SetBlipColour(thisBlip, jobAction.blip.color)
					SetBlipScale(thisBlip, 0.8)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(jobAction.blip.name)
					EndTextCommandSetBlipName(thisBlip)

					SetBlipInfoTitle(thisBlip, jobAction.blip.name, false)
					AddBlipInfoText(thisBlip, "Company Motto", '"' .. v.MenuDesc .. '~s~"')
					AddBlipInfoText(thisBlip, "Job Description", v.JobType)

					if v.PayoutPerFakeMile ~= nil then
						AddBlipInfoHeader(thisBlip, "Share Price", "$" .. v.PayoutPerFakeMile * 1000)
					end

					if jobAction.blip.image ~= nil then
						RequestStreamedTextureDict(jobAction.blip.image.dict, 1)
						while not HasStreamedTextureDictLoaded(jobAction.blip.image.dict)  do
							Wait(1)
						end
						
						SetBlipInfoImage(thisBlip, jobAction.blip.image.dict, jobAction.blip.image.name) 
					end
				end
			end
		end
	end
end)

local JobDrawDistance = 25.0

CreateThread(function()
	local thisTry = false
	local thisClosest = nil

	local thisJobDistance = nil

	while true do
		canAdd = false
		thisTry = false

		thisClosest = nil

		if HighLife.Settings.Development then
			isDebugMode = true
		else
			isDebugMode = false
		end

		for k,v in pairs(Config.Jobs) do
			thisJobDistance = nil

			if v.JobActions.Menus ~= nil then
				for j,l in pairs(v.JobActions.Menus) do
					thisJobDistance = Vdist(HighLife.Player.Pos, vector3(l.x, l.y, l.z))

					if thisJobDistance < JobDrawDistance then
						thisTry = true

						canAdd = false

						if thisClosest ~= nil then
							if thisJobDistance < thisClosest.thisDistance then
								canAdd = true
							end
						else
							canAdd = true
						end

						if canAdd then
							thisClosest = {
								job = k,
								thisMenu = l,
								thisDistance = thisJobDistance
							}
						end
					end
				end
			else
				thisJobDistance = Vdist(HighLife.Player.Pos, vector3(v.JobActions.Menu.x, v.JobActions.Menu.y, v.JobActions.Menu.z))

				if thisJobDistance < JobDrawDistance then
					thisTry = true

					canAdd = false

					if thisClosest ~= nil then
						if thisJobDistance < thisClosest.thisDistance then
							canAdd = true
						end
					else
						canAdd = true
					end

					if canAdd then
						thisClosest = {
							job = k,
							thisMenu = v.JobActions.Menu,
							thisDistance = thisJobDistance
						}
					end
				end
			end
		end

		if thisClosest ~= nil then
			closestJob = thisClosest
		end

		if not thisTry then
			closestJob = nil
		end

		Wait(2000)
	end
end)

function IsAnyJobMenuVisible()
	return (RageUI.Visible(RMenu:Get('job', 'main')) or RageUI.Visible(RMenu:Get('job', 'vehicles')) or RageUI.Visible(RMenu:Get('job', 'equipment')) or RageUI.Visible(RMenu:Get('job', 'items')) or RageUI.Visible(RMenu:Get('job', 'uniforms')) or RageUI.Visible(RMenu:Get('job', 'weapons')) or RageUI.Visible(RMenu:Get('job', 'management')) or RageUI.Visible(RMenu:Get('job', 'manage_outfits')) or RageUI.Visible(RMenu:Get('job', 'outfit_options')))
end

CreateThread(function()
	local displayCurrentMenu = true

	local thisJob = nil

	while true do
		if not HighLife.Settings.IsTest then
			if not HighLife.Player.CD and HighLife.Other.JobStatData.Loaded and HighLife.Player.JobReset and not HighLife.Player.InCharacterMenu then
				if closestJob ~= nil then
					thisJob = Config.Jobs[closestJob.job]

					if not thisJob.Whitelisted or (thisJob.SemiWhitelisted ~= nil and thisJob.Whitelisted and thisJob.SemiWhitelisted) or (thisJob.Whitelisted and HighLife.Other.JobStatData.current ~= nil and HighLife.Other.JobStatData.current[closestJob.job] ~= nil) then
						if closestJob.thisMenu.ExternalTrigger == nil then
							DrawMarker(1, closestJob.thisMenu.x, closestJob.thisMenu.y, closestJob.thisMenu.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, thisJob.Color[1], thisJob.Color[2], thisJob.Color[3], 80, false, true, 2, false, false, false, false)
						end

						if Vdist2(HighLife.Player.Pos, closestJob.thisMenu.x, closestJob.thisMenu.y, closestJob.thisMenu.z, true) < (closestJob.thisMenu.ExternalTrigger ~= nil and 6.0 or 2.0) and not HighLife.Player.InVehicle then
							if currentMenu ~= closestJob.job then
								currentMenu = closestJob.job
							end

							displayCurrentMenu = true

							if HighLife.Player.Job.CurrentJob ~= nil then
								if closestJob.job ~= HighLife.Player.Job.CurrentJob then
									displayCurrentMenu = false
								end
							end

							if closestJob.thisMenu.ExternalTrigger == nil then
								if displayCurrentMenu then
									if not IsAnyJobMenuVisible() then
										DisplayHelpText("Press ~INPUT_PICKUP~ to work at " .. Config.Jobs[currentMenu].MenuName)
									end

									if IsControlJustReleased(0, 38) then
										if closestJob ~= nil and closestJob.job ~= nil then
											DrawJobMenu(closestJob.job)
										end
									end
								else
									DisplayHelpText("You are already working for " .. Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName)
								end
							end
						elseif IsAnyJobMenuVisible() then
							RageUI.CloseAll()
						end
					end
				end

				if HighLife.Player.Job.CurrentJob ~= nil and HighLife.Player.Job.InService then
					if not isFinished then
						inWorkVehicle = false
						isTrailerAttached = false

						if HighLife.Player.InVehicle then
							if HighLife.Player.Vehicle == HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity and HighLife.Player.VehicleSeat == -1 then
								inWorkVehicle = true

								if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity ~= nil then
									if IsVehicleAttachedToTrailer(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity) then
										local trailerStatus, foundTrailer = GetVehicleTrailerVehicle(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity)

										if DoesEntityExist(foundTrailer) then
											if foundTrailer == HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity then
												isTrailerAttached = true
											end
										end
									end
								end
							end
						end

						if Config.Jobs[HighLife.Player.Job.CurrentJob].VehicleInsuranceCost ~= nil then 
							if GetVehicleEngineHealth(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity) <= 0 then
								ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'You ~r~destroyed ~s~our vehicle! ~r~$' .. Config.Jobs[HighLife.Player.Job.CurrentJob].VehicleInsuranceCost .. ' ~s~has been taken for the damages')

								TriggerServerEvent('HighLife:Jobs:VehicleDestoyed', Config.Jobs[HighLife.Player.Job.CurrentJob].VehicleInsuranceCost)
								
								HighLife:EndCurrentJob()
							end
						end
					end
				end

				if HighLife.Player.Job.CurrentJob ~= nil and inWorkVehicle then
					-- FIXME: Make a check to see if they teleported here 
					if HighLife.Player.Pos.z == 563.43 then
						TriggerServerEvent('HCheat:magic', 'ME_JT')
						break
					end

					if Config.Jobs[HighLife.Player.Job.CurrentJob].Whitelisted == nil or (Config.Jobs[HighLife.Player.Job.CurrentJob].Whitelisted ~= nil and not Config.Jobs[HighLife.Player.Job.CurrentJob].Whitelisted) then
						if Config.Jobs[HighLife.Player.Job.CurrentJob].isObjectCollection == nil or not Config.Jobs[HighLife.Player.Job.CurrentJob].isObjectCollection then
							if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity == nil or (HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity ~= nil and isTrailerAttached) then
								if not isFinished then
									if currentRoute.location == nil then
										if jobRoutes == nil then
											jobRoutes = OptimizeRoutes(CurateRandomTables(Config.Jobs[HighLife.Player.Job.CurrentJob].Locations, HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_start))

											currentRoute.location = jobRoutes[jobRoutesCount]

											currentRoute.distance = math.floor(GetDistanceBetweenCoords(HighLife.Player.Pos, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z))
										else
											if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left ~= 0 then
												jobRoutesCount = jobRoutesCount + 1

												currentRoute.location = jobRoutes[jobRoutesCount]
												currentRoute.distance = math.floor(GetDistanceBetweenCoords(HighLife.Player.Pos, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z))
											else
												isFinished = true
											
												ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'You have no more deliveries to complete, return to ' .. Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName .. ' ~s~to get ~g~paid')
											
												currentRoute.nearbyTrigger = true
												currentRoute.location = Config.Jobs[HighLife.Player.Job.CurrentJob].JobActions.Menu

												DrawRoute('Return', currentRoute.location)
											end
										end

										if not isFinished then
											DrawRoute('Delivery', currentRoute.location)
										end
									else
										local thisLocation = Config.Jobs[HighLife.Player.Job.CurrentJob]

										local vehiclePosition = HighLife.Player.Pos

										if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].trailer.entity ~= nil then
											if IsVehicleAttachedToTrailer(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity) then
												vehiclePosition = GetOffsetFromEntityInWorldCoords(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity, 0.0, Config.Jobs[HighLife.Player.Job.CurrentJob].VehicleCollectionOffset, 0.0)
											end
										end

										if isDebugMode or GetDistanceBetweenCoords(HighLife.Player.Pos, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z) < 50.0 then
											DrawMarker(1, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.0, 4.0, 1.0, thisLocation.Color[1], thisLocation.Color[2], thisLocation.Color[3], 120, false, true, 2, false, false, false, false)

											if isDebugMode or GetDistanceBetweenCoords(vehiclePosition, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z) < 3.0 then
												if GetEntitySpeed(HighLife.Player.Vehicle) < 2.0 and HighLife.Player.VehicleSeat == -1 and not HighLife.Player.Dead then
													DisplayHelpText('JOBS_DELIVER')

													if IsControlJustReleased(0, 38) then
														local vehicle = HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity

														SetVehicleHandbrake(vehicle, true)

														if isDebugMode then
															SetEntityCoordsNoOffset(HighLife.Player.Vehicle, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z, false, false, false)
														end

														Wait((isDebugMode and 500 or 5000))

														SetVehicleHandbrake(vehicle, false)

														lastRoute = currentRoute.location

														HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left = HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left - 1
														HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].total_distance = HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].total_distance + currentRoute.distance

														TriggerServerEvent('HighLife:Jobs:initData', HighLife.Player.Job.CurrentJob, 1)

														if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left ~= 0 then
															if not isDebugMode then
																ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'You have ~y~' .. HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left .. ' ~s~deliveries left, check your ~g~map ~s~for the next ~y~delivery')
																
																if math.random(5) == 1 then
																	Wait(1000)

																	ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'You can return to ' .. Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName .. ' ~s~at anytime to finish your shift, ~g~progress will be saved!')
																end
															else
																print('Completed delivery')
															end
														end

														RemoveCurrentRoute()
													end
												end
											end
										end
									end
								end
							else
								DisplayHelpText('JOBS_NEEDTRAILER')
							end
						else
							if not isFinished then
								if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left ~= 0 then
									-- Object collection job
									local thisTry = false

									for k,v in pairs(Config.Jobs[HighLife.Player.Job.CurrentJob].ProximityItems) do
										for i=1, #v.props do
											local currentPos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity, 0.0, Config.Jobs[HighLife.Player.Job.CurrentJob].VehicleCollectionOffset, 0.0)

											local nearbyItem = GetClosestObjectOfType(currentPos, 1.0, GetHashKey(v.props[i]), false, 0, 0)
						
											if nearbyItem ~= 0 then
												current_object.item = v
												current_object.entity = nearbyItem
						
												thisTry = true
											end
										end
									end

									if not thisTry then
										if current_object.item ~= nil then
											current_object.item = nil
											current_object.entity = nil
										end
									end

									Wait(500)
								else
									isFinished = true

									ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'Return to ' .. Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName .. ' ~s~to get ~g~paid')
											
									currentRoute.nearbyTrigger = true
									currentRoute.location = Config.Jobs[HighLife.Player.Job.CurrentJob].JobActions.Menu

									DrawRoute('Return', currentRoute.location)
								end
							end
						end
					end
				end

				if HighLife.Player.Job.CurrentJob ~= nil then
					if currentRoute.nearbyTrigger then
						if GetDistanceBetweenCoords(HighLife.Player.Pos, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z) < Config.Jobs[HighLife.Player.Job.CurrentJob].MinumumReturnDistance then
							ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'Leave your ~y~vehicle ~s~close to ' .. Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName .. ' ~s~headquarters when you ~g~finish work')

							Wait(3000)

							RemoveCurrentRoute()
						end
					end
				end
			end
		else
			DisplayHelpText('Jobs are disabled due to an ongoing server test!')
		end

		Wait(1)
	end
end)

--[[
CreateThread(function()
	while true do
		if HighLife.Player.Job.CurrentJob ~= nil then
			if Config.Jobs[HighLife.Player.Job.CurrentJob].SpeedLimited ~= nil then
				if inWorkVehicle then
					local currentSpeed = GetEntitySpeed(HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity) * 2.236936

					if currentSpeed > Config.Jobs[HighLife.Player.Job.CurrentJob].SpeedLimited + 10 then
						HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].current_strikes = HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].current_strikes + 1

						if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].current_strikes == Config.Jobs[HighLife.Player.Job.CurrentJob].MaxStrikes then
							ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', "~o~We told you to slow down, ~r~you're fired! ~s~Leave your work clothes and vehicle at the side of the road")

							HighLife:EndCurrentJob(HighLife.Player.Job.CurrentJob)
						else
							ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', "~r~Slow it down! You're driving too fast")
						end

						Wait(5000)
					end
				end
			end
		end
		
		Wait(3000)
	end
end)
--]]

local WorkObjectStore = {}

CreateThread(function()
	local canPickup = true

	local entityPos = nil

	while true do
		canPickup = true

		entityPos = nil

		if inWorkVehicle then
			if DoesEntityExist(current_object.entity) then
				entityPos = GetEntityCoords(current_object.entity)

				FreezeEntityPosition(current_object.entity, true)

				if current_object.item.count > HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left then
					DisplayHelpText('JOBS_NOSTORAGE')
				else
					Draw3DCoordText(entityPos.x, entityPos.y, entityPos.z + 1.5, 'Press [~y~E~w~] to pickup the ' .. current_object.item.name .. ' (~o~' .. current_object.item.count .. '~s~)')

					if IsControlJustReleased(0, 38) then
						for i=1, #WorkObjectStore do
							if GameTimerPool.GlobalGameTime < WorkObjectStore[i].expire then
								if Vdist(GetEntityCoords(current_object.entity), WorkObjectStore[i].thisPos) < 10.0 then
									canPickup = false

									break
								end
							end
						end

						if canPickup then
							local vehicle = HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].vehicle.entity
							
							local thisObject = {
								entity = current_object.entity,
								count = current_object.item.count
							}

							SetVehicleHandbrake(vehicle, true)

							Wait(5000)

							SetVehicleHandbrake(vehicle, false)

							local thisObjectPos = GetEntityCoords(thisObject.entity)

							table.insert(WorkObjectStore, {
								thisPos = vector3(thisObjectPos.x, thisObjectPos.y, thisObjectPos.z),
								expire = GameTimerPool.GlobalGameTime + 2880000
							})

							HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left = HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left - thisObject.count

							TriggerServerEvent('HighLife:Jobs:initData', HighLife.Player.Job.CurrentJob, thisObject.count)

							if HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left ~= 0 then
								ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'You can store ~y~' .. HighLife.Player.Job.Data[HighLife.Player.Job.CurrentJob].actions_left .. ' ~s~units of ' .. Config.Jobs[HighLife.Player.Job.CurrentJob].ObjectCollectionName .. ' before you need to return to the ~y~depot')
								
								if math.random(0, 4) == 1 then
									Wait(1000)
									
									ShowNotificationPic(Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName, '~g~Headquarters', 'You can return to ' .. Config.Jobs[HighLife.Player.Job.CurrentJob].MenuName .. ' ~s~at anytime to finish your shift, ~g~progress will be saved!')
								end
							end
						else
							DisplayHelpText('You have already cleared trash in this area')
						end
					end
				end
			end
		end

		Wait(1)
	end
end)