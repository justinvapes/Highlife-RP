local firstLoad = true
local isInMenu = false

local isLoaded = false
local isClearingAlarms = false

local PlayerJob = nil

local canPanic = true

local quickActions = {
	'10-78: Request Backup',
	'10-52: Request Medical',
	'10-33: Panic Button'
}

local quickRoutes = {'Mission Row PD', 'Sandy Shores PD', 'Bolingbroke', 'Pillbox Hill', 'LS Central Hospital', 'Sandy Shores Hospital'}

local currentRoute = {
	blip = nil,
	location = nil
}

local Locations = {
	['Mission Row PD'] = {
		x = 408.41,
		y = -986.58,
		z = 29.27,
	},
	['Sandy Shores PD'] = {
		x = 1857.49,
		y = 3679.61,
		z = 33.77,
	},
	['Bolingbroke'] = {
		x = 1854.87,
		y = 2589.36,
		z = 45.67,
	},
	['Pillbox Hill'] = {
		x = 362.14,
		y = -591.03,
		z = 28.67,
	},
	['LS Central Hospital'] = {
		x = 300.0,
		y = -1439.99,
		z = 29.0,
	},
	['Sandy Shores Hospital'] = {
		x = 1829.88,
		y = 3672.53,
		z = 34.0,
	},
}

local temp_data = {
	lastEmsCount = 0,
	lastOfficerCount = 0,

	officer_data = {},

	bolo_pool = {},

	bolo_info = {
		plate = '',
		description = '',
		wanted_for = '',
		wanted_name = '',
		code5 = false
	}
}

function ShowNotificationEmergency(message, subject)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(message)
	SetNotificationMessage('CHAR_CALL911', 'CHAR_CALL911', true, 4, 'LSPD CAD', subject)
	DrawNotification(false, true)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerJob = xPlayer.job
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerJob = job

	if PlayerJob.name ~= 'police' or PlayerJob.name ~= 'ambulance' then
		-- DoBlips()
		
		isLoaded = false

		temp_data.lastEmsCount = 0
		temp_data.lastOfficerCount = 0
	end
end)

RegisterNetEvent('HighLife:CAD:Notify')
AddEventHandler('HighLife:CAD:Notify', function(message, subject, withSound)
	if IsAnyJobs({'police', 'ambulance', 'fib'}) then
		if withSound then
			HighLife.SpatialSound.CreateSound('PoliceRadioTetra3')
		end
		
		if subject ~= nil then
			PlaySound('long_beep')
			ShowNotificationEmergency(message, subject)
		else
			PlaySound('short_beep')

			Notification_AboveMap(message)
		end
	end
end)

RegisterNetEvent('HighLife:CAD:SendCallDetails')
AddEventHandler('HighLife:CAD:SendCallDetails', function(callData)
	if IsAnyJobs({'police', 'ambulance', 'fib'}) then
		if callData ~= nil then
			DrawQuickRoute(nil, callData.position, callData.requestee)
		end
	end
end)

CreateThread(function()
	while HighLife.Player.CD do
		Wait(1000)
	end

	Wait(10000)

	RegisterNetEvent('HighLife:CAD:TrackerDestroyed')
	AddEventHandler('HighLife:CAD:TrackerDestroyed', function()
		if HighLife.Player.Job.name == 'ambulance' then
			HighLife:DispatchEvent('panic_ems')
		else
			HighLife:DispatchEvent('panic_cop')
		end
	end)
end)

function RemoveCurrentCadRoute()
	RemoveBlip(currentRoute.blip)

	currentRoute = {
		blip = nil,
		location = nil
	}
end

function DrawQuickRoute(location, playerPos, routeName)
	local thisName = nil
	local thisLocation = nil

	if location ~= nil then
		thisName = location
		thisLocation = Locations[location]
	else
		thisName = routeName
		thisLocation = playerPos
	end

	if currentRoute.blip ~= nil then
		RemoveCurrentCadRoute()
	end

	currentRoute.location = thisLocation
	currentRoute.blip = AddBlipForCoord(thisLocation.x, thisLocation.y, thisLocation.z)

	SetBlipAsShortRange(currentRoute.blip, 0)
	SetBlipSprite(currentRoute.blip, 398)
	SetBlipColour(currentRoute.blip, 5)
	SetBlipRoute(currentRoute.blip, true)
	BeginTextCommandSetBlipName("STRING")

	AddTextComponentString("CAD: " .. thisName)

	EndTextCommandSetBlipName(currentRoute.blip)

	PlaySound('short_beep')
	Notification_AboveMap('Route to ~y~' .. thisName .. ' ~s~has been ~g~marked')
end

RegisterNetEvent('HighLife:CAD:IncomingCall')
AddEventHandler('HighLife:CAD:IncomingCall', function(data)
	if IsAnyJobs({'police', 'ambulance', 'fib'}) then
		if data.requestee_source ~= GetPlayerServerId(PlayerId()) then
			CreateThread(function()
				local displayTime = 17
				local currentTime = 0

				TriggerEvent('HighLife:CAD:Notify', '~y~#' .. data.id .. '~s~: ~b~' .. data.requestee .. ' ~s~' .. data.message, data.title)

				Wait(1000)

				TriggerEvent('HighLife:CAD:Notify', '[1] to ~g~accept ~s~[2] to ~r~decline', nil)

				CreateThread(function()
					while currentTime ~= displayTime do
						currentTime = currentTime + 1
						Wait(1000)
					end
				end)
				
				while currentTime ~= displayTime do
					if IsControlJustReleased(0, 157) then
						TriggerServerEvent('HighLife:CAD:ProcessCall', data.id, true)

						TriggerEvent('HighLife:CAD:Notify', 'You ~g~accepted ~s~the call, location marked', nil)

						currentTime = displayTime
					end

					if IsControlJustReleased(0, 158) then
						TriggerServerEvent('HighLife:CAD:ProcessCall', data.id, false)

						TriggerEvent('HighLife:CAD:Notify', 'You ~r~declined ~s~the call', nil)

						currentTime = displayTime
					end

					Wait(1)	
				end
			end)
		end
	end
end)

RegisterNetEvent('HighLife:CAD:UpdateData')
AddEventHandler('HighLife:CAD:UpdateData', function(data)
	if IsAnyJobs({'police', 'ambulance', 'fib'}) then
		HighLife.Other.CAD_DATA = json.decode(data)
		
		if IsAnyJobs({'police', 'ambulance', 'fib'}) then
			if not isLoaded then
				isLoaded = true

				PlaySound('short_beep')
				Notification_AboveMap('~g~CAD Initialized ~s~(~b~' .. HighLife.Other.CAD_DATA.misc.version .. '~w~) [~y~F6~s~]')
			end
		
			if temp_data.lastOfficerCount ~= HighLife.Other.CAD_DATA.misc.officer_count then
				temp_data.lastOfficerCount = HighLife.Other.CAD_DATA.misc.officer_count

				if isLoaded then
					PlaySound('short_beep')
				end

				Notification_AboveMap('~b~Officers ~y~on duty: ~g~' .. temp_data.lastOfficerCount)
			end

			if temp_data.lastEmsCount ~= HighLife.Other.CAD_DATA.misc.ems_count then
				temp_data.lastEmsCount = HighLife.Other.CAD_DATA.misc.ems_count

				if isLoaded then
					PlaySound('short_beep')
				end
		
				Notification_AboveMap('~r~EMS ~y~on duty: ~g~' .. temp_data.lastEmsCount)
			end

			-- DoBlips()
		end
	end
end)

_cadMenuPool = NativeUI.CreatePool()

local emsMenu = NativeUI.CreateMenu("EMS CAD", "~g~System fully operational", 1380, 200)
local saspMenu = NativeUI.CreateMenu("LSPD CAD", "~g~System fully operational", 1380, 200)

_cadMenuPool:Add(emsMenu)
_cadMenuPool:Add(saspMenu)

function PlaySound(soundName)
	if soundName == 'short_beep' then
		PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
	elseif soundName == 'long_beep' then
		PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
	end
end

function ShowNotificationPic(message, subject)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(message)
	SetNotificationMessage('CHAR_CALL911', 'CHAR_CALL911', true, 4, 'LSPD CAD', subject)
	DrawNotification(false, true)
end

function EmsMenu(menu)
	local quick_actions = NativeUI.CreateListItem("Quick Actions", quickActions, 0, "Quick actions")
	local draw_route = NativeUI.CreateListItem("Quick Route", quickRoutes, 0, "Draw a route to known location")
	local remove_route = NativeUI.CreateItem("~r~Remove Current Route", "Removes any existing route")

	menu:AddItem(quick_actions)
	menu:AddItem(draw_route)
	menu:AddItem(remove_route)

	menu.OnListSelect = function(sender, item, index)
		if item == draw_route then		
			DrawQuickRoute(item:IndexToItem(index), nil, nil)
		end

		if item == quick_actions then
			local position = {
				x = HighLife.Player.Pos.x,
				y = HighLife.Player.Pos.y,
				z = HighLife.Player.Pos.z,
			}

			if item:IndexToItem(index) == '10-33: Panic Button' then			
				if canPanic then
					canPanic = false

					HighLife:DispatchEvent('panic_ems')
					
					CreateThread(function()
						Wait(120000)

						canPanic = true
					end)
				end
			end

			if item:IndexToItem(index) == '10-78: Request Backup' then
				TriggerServerEvent('HighLife:CAD:RequestSupport', 'police_assistance', position)
			end

			if item:IndexToItem(index) == '10-52: Request Medical' then
				TriggerServerEvent('HighLife:CAD:RequestSupport', 'medical_assistance', position)
			end
		end
	end

	menu.OnItemSelect = function(sender, item, index)
		if item == remove_route then
			RemoveBlip(currentRoute.blip)
			currentRoute.location = nil
		end
	end
end

function PoliceMenu(menu)
	local quick_actions = NativeUI.CreateListItem("Quick Actions", quickActions, 0, "Quick actions")
	local draw_route = NativeUI.CreateListItem("Quick Route", quickRoutes, 0, "Draw a route to known location")
	local search_plate = NativeUI.CreateItem('Number Plate Search', 'Search to see who owns a vehicle')
	local remove_route = NativeUI.CreateItem("~r~Remove Current Route", "Removes any existing route")
	local clear_alarms = NativeUI.CreateItem("~r~Silence Alarms", "Silences any robbery alarms")
	local issue_dispersal = NativeUI.CreateItem("~o~Issue Dispersal Order", "Creates a dispersal order at a marked position")

	menu:AddItem(quick_actions)
	menu:AddItem(draw_route)
	menu:AddItem(remove_route)

	menu:AddItem(NativeUI.CreateItem("____________________________", ''))

	local input_bolo = _cadMenuPool:AddSubMenu(menu, '~g~Create Warrant', 'Add a warrant into the CAD', "", true)
	local active_bolo = _cadMenuPool:AddSubMenu(menu, '~y~Active Warrants', 'View all active warrants', "", true)
	
	menu:AddItem(NativeUI.CreateItem("____________________________", ''))

	menu:AddItem(clear_alarms)
	menu:AddItem(issue_dispersal)

	menu:AddItem(NativeUI.CreateItem("____________________________", ''))
	menu:AddItem(search_plate)

	local input_warrant = NativeUI.CreateItem("Enter Warrant", "Puts a warrant in the CAD")
	local active_warrant = NativeUI.CreateItem("Active Warrants", "View all active warrants")

	local search_fines = NativeUI.CreateItem("Search Fines", "Search all jail sentences")
	local search_person = NativeUI.CreateItem("Search Citizens", "Search for a citizen")
	local search_bolo = NativeUI.CreateItem("Search all Warrants", "Search all Warrants")
	local search_warrant = NativeUI.CreateItem("Search all Warrants", "Search all warrants")
	local search_jail = NativeUI.CreateItem("Search Jail Sentences", "Search all jail sentences")

	menu.OnListSelect = function(sender, item, index)
		if item == quick_actions then
			local position = {
				x = HighLife.Player.Pos.x,
				y = HighLife.Player.Pos.y,
				z = HighLife.Player.Pos.z,
			}

			if item:IndexToItem(index) == '10-33: Panic Button' then			
				if canPanic then
					canPanic = false

					HighLife:DispatchEvent('panic_cop')
					
					CreateThread(function()
						Wait(120000)

						canPanic = true
					end)
				end
			end

			if item:IndexToItem(index) == '10-78: Request Backup' then
				TriggerServerEvent('HighLife:CAD:RequestSupport', 'police_assistance', position)
			end

			if item:IndexToItem(index) == '10-52: Request Medical' then
				TriggerServerEvent('HighLife:CAD:RequestSupport', 'medical_assistance', position)
			end
		end

		if item == draw_route then		
			DrawQuickRoute(item:IndexToItem(index), nil, nil)
		end
	end

	menu.OnItemSelect = function(sender, item, index)
		if item == remove_route then
			RemoveBlip(currentRoute.blip)
			currentRoute.location = nil
		end

		if item == issue_dispersal then
			local thisEventData = {
				position = {
					x = HighLife.Player.Pos.x,
					y = HighLife.Player.Pos.y,
					z = HighLife.Player.Pos.z,
				},
				streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z))
			}

			TriggerServerEvent('HighLife:Event:Create', json.encode(thisEventData), true)
		end

		if item == clear_alarms then
			if not isClearingAlarms then
				isClearingAlarms = true

				CreateThread(function()
					TriggerEvent('HighLife:CAD:Notify', '~y~Sending request for bank & store alarms to be silenced...', 'Commercial Alarm Index')

					Wait(math.random(15000, 35000))

					TriggerEvent('HighLife:CAD:Notify', '~g~Alarm silence request has been approved and processed', 'Commercial Alarm Index')

					HighLife.SpatialSound:StopNamedSounds('alarm_', true)

					isClearingAlarms = false
				end)
			end
		end

		if item == search_plate then		
			local input = openKeyboard('VEH_PLATE', 'Registration Plate', 8)

			if input ~= nil then
				local plate = string.upper(input)

				if string.len(plate) == 8 then
					HighLife.SpatialSound.CreateSound('PoliceRadioTetra2')

					TriggerEvent('HighLife:CAD:Notify', 'Plate: ~y~' .. plate .. ' ~s~is being run through the database...', 'Vehicle Registration Check')
					TriggerServerEvent('HighLife:CAD:CheckPlate', plate)
				else
					TriggerEvent('HighLife:CAD:Notify', '~r~No valid plate entered\n(8 characters)', 'Vehicle Registration Check')
				end
			end
		end
	end
	
	menu.OnMenuChanged = function(menu, newmenu, forward)
		if newmenu == active_bolo.SubMenu then
			active_bolo.SubMenu:Clear()

			temp_data.bolo_pool = {}

			for k,v in pairs(HighLife.Other.CAD_DATA.active_bolos) do
				if temp_data.bolo_pool[k] == nil then
					temp_data.bolo_pool[k] = _cadMenuPool:AddSubMenu(active_bolo.SubMenu, '#' .. v.id .. ' | ' .. v.wanted_name .. ' (' .. v.plate .. ')', '~y~Wanted for~s~: ' .. v.wanted_for, "", true)
					
					local reason = NativeUI.CreateItem('~y~Description ~s~(Hover to view)', v.description)
					local officer = NativeUI.CreateItem('~b~Trooper~s~: ' .. v.officer, 'The submitter of the warrant')
					local code5 = NativeUI.CreateItem('~o~Code 5 stop?', '~y~If the stop is Code 5')
					local time = NativeUI.CreateItem('Time', 'The time submitted (GMT)')
					local served = NativeUI.CreateItem('~g~Mark as served', '~y~This will remove the warrant')

					served:SetRightBadge(BadgeStyle.Tick)

					code5:RightLabel(v.code5)
					time:RightLabel(v.time)
					
					active_bolo.SubMenu:AddItem(temp_data.bolo_pool[k].SubMenu)

					temp_data.bolo_pool[k].SubMenu:AddItem(reason)
					temp_data.bolo_pool[k].SubMenu:AddItem(officer)
					temp_data.bolo_pool[k].SubMenu:AddItem(code5)
					temp_data.bolo_pool[k].SubMenu:AddItem(time)
					temp_data.bolo_pool[k].SubMenu:AddItem(served)

					temp_data.bolo_pool[k].SubMenu:CurrentSelection(0)

					temp_data.bolo_pool[k].SubMenu.OnItemSelect = function(sender, item, index)
						if item == served then
							if v.id ~= nil then
								TriggerServerEvent('HighLife:CAD:Bolo', 'served', v)
							end
						end
					end
				end
			end

			active_bolo.SubMenu:CurrentSelection(0)
		end
	end

	--[[ Enter BOLO --]]

	local veh_reg = NativeUI.CreateItem('Plate', 'The vehicles license plate number')
	local wan_name = NativeUI.CreateItem('Person', 'Name of the suspect')
	local veh_des = NativeUI.CreateItem('Description', 'Info related to the vehicle, color etc')
	local veh_wan = NativeUI.CreateItem('Wanted For', 'Reason as to why the vehicle is wanted')
	local veh_cod = NativeUI.CreateCheckboxItem('Code 5 Stop?', temp_data.bolo_info.code5, "Whether it's a Code 5 stop")
	local veh_sav = NativeUI.CreateItem('~g~Save Warrant', 'Save the warrant into the CAD')

	veh_sav:SetRightBadge(BadgeStyle.Tick)

	-- 35 Chars per item

	function resetBOLOFields()
		veh_reg:RightLabel('')
		wan_name:RightLabel('')
		veh_des:RightLabel('')
		veh_wan:RightLabel('')

		temp_data.bolo_info = {
			plate = '',
			description = '',
			waned_name = '',
			wanted_for = '',
			code5 = false
		}
	end

	input_bolo.SubMenu.OnCheckboxChange = function(sender, item, checked_)
		if item == veh_cod then
			temp_data.bolo_info.code5 = checked_
		end
	end

	input_bolo.SubMenu.OnItemSelect = function(sender, item, index)
		if item == veh_reg then
			local input = openKeyboard('VEH_REG', 'Vehicle Registration', 10)

			if input ~= nil then
				temp_data.bolo_info.plate = string.upper(input)
				veh_reg:RightLabel('~y~' .. temp_data.bolo_info.plate)
			end
		end

		if item == veh_des then
			local input = openKeyboard('VEH_DEC', 'Vehicle Description', nil)

			if input ~= nil then
				temp_data.bolo_info.description = input:sub(1,1):upper()..input:sub(2)
				veh_des:RightLabel(temp_data.bolo_info.description)
			end
		end

		if item == veh_wan then
			local input = openKeyboard('VEH_WAN', 'Wanted For', nil)

			if input ~= nil then
				temp_data.bolo_info.wanted_for = input
				veh_wan:RightLabel('~r~' .. input)
			end
		end

		if item == wan_name then
			local input = openKeyboard('VEH_WAN_NAME', 'Warrant Name (Person)', nil)

			if input ~= nil then
				temp_data.bolo_info.wanted_name = input
				wan_name:RightLabel('~r~' .. input)
			end
		end

		if item == veh_sav then
			if temp_data.bolo_info.plate ~= '' and temp_data.bolo_info.description ~= '' and temp_data.bolo_info.wanted_for ~= '' then
				TriggerServerEvent('HighLife:CAD:Bolo', 'add', temp_data.bolo_info)
	
				resetBOLOFields()
			else
				Notification_AboveMap('CAD_WARRANT_MISSINGINFO')
			end
		end
	end

	input_bolo.SubMenu:AddItem(wan_name)
	input_bolo.SubMenu:AddItem(veh_reg)
	input_bolo.SubMenu:AddItem(veh_des)
	input_bolo.SubMenu:AddItem(veh_wan)
	input_bolo.SubMenu:AddItem(veh_cod)
	input_bolo.SubMenu:AddItem(veh_sav)
	
	-- menu:AddItem(divider)
	
	-- menu:AddItem(input_bolo)
	-- menu:AddItem(active_bolo)
	-- menu:AddItem(input_warrant)
	-- menu:AddItem(active_warrant)
	-- menu:AddItem(search_fines)
	-- menu:AddItem(search_person)
	-- menu:AddItem(search_bolo)
	-- menu:AddItem(search_warrant)
	-- menu:AddItem(search_jail)

	input_bolo.SubMenu:CurrentSelection(0)

	menu:CurrentSelection(0)
end

_cadMenuPool:RefreshIndex()
_cadMenuPool:MultilineFormats(true)

CreateThread(function()
	EmsMenu(emsMenu)
	PoliceMenu(saspMenu)

	while true do
		if IsAnyJobs({'police', 'ambulance'}) then
			_cadMenuPool:ControlDisablingEnabled(false)
			_cadMenuPool:MouseControlsEnabled(false)

			_cadMenuPool:ProcessMenus()

			if not HighLife.Player.Dead then
				if GetLastInputMethod(2) and IsControlJustPressed(1, 167) then
					if HighLife.Player.Job.name == 'police' and isLoaded then
						saspMenu:Visible(not saspMenu:Visible())
					elseif HighLife.Player.Job.name == 'ambulance' and isLoaded then
						emsMenu:Visible(not emsMenu:Visible())
					end
				end
			else
				if saspMenu:Visible() or emsMenu:Visible() then
					emsMenu:Visible(false)
					saspMenu:Visible(false)
				end
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	local remindMinutes = 15 * 60000
	local currentMinutes = 0

	while true do
		if currentMinutes ~= remindMinutes then
			currentMinutes = currentMinutes + 1000
		else
			if IsAnyJobs({'police', 'fib'}) then
				if HighLife.Other.CAD_DATA ~= nil and HighLife.Other.CAD_DATA.active_bolos ~= nil then
					if #HighLife.Other.CAD_DATA.active_bolos > 0 then
						PlaySound('short_beep')
						
						Notification_AboveMap('There are currently ~y~' .. #HighLife.Other.CAD_DATA.active_bolos .. ' ~s~active ~r~warrants')
						
						currentMinutes = 0
					end
				end
			end
		end

		if currentRoute.location ~= nil then
			if GetDistanceBetweenCoords(HighLife.Player.Pos, currentRoute.location.x, currentRoute.location.y, currentRoute.location.z, true) < 20.0 then
				RemoveCurrentCadRoute()
			end
		end

		Wait(1000)
	end
end)


-- FIXME: This gets replaced with cad.misc.officers_online or something like that
local active_troopers = {}
local active_medical = {}

local active_units = {
	police = active_troopers,
	ambulance = active_medical
}

function CalculateRectangleCornerPositions(position, width, height, rotation)
	local rectDiag = math.sqrt((width / 2) * (width / 2) + (height / 2) * (height / 2))
	local rectAngle = math.atan2(height / 2, height / 2)

	-- TL
	local top_left = vector2((position.x + -rectDiag * math.cos(-rectAngle + rotation)), (position.y + -rectDiag * math.sin(-rectAngle + rotation)))
	local top_right = vector2((position.x + rectDiag * math.cos(rectAngle + rotation)), (position.y + rectDiag * math.sin(rectAngle + rotation)))
	local bottom_right = vector2((position.x + rectDiag * math.cos(-rectAngle + rotation)), (position.y + rectDiag * math.sin(-rectAngle + rotation)))
	local bottom_left = vector2((position.x + -rectDiag * math.cos(rectAngle + rotation)), (position.y + -rectDiag * math.sin(rectAngle + rotation)))

	return {
		top_left = top_left,
		top_right = top_right,
		bottom_right = bottom_right,
		bottom_left = bottom_left
	}
end

-- local currentEms = nil
-- local currentCops = nil

-- FIXME: Patrol zones
-- CreateThread(function()
-- 	while true do
-- 		if IsAnyJobs({'police', 'ambulance'}) then
-- 			active_medical = {}
-- 			active_troopers = {}

-- 			for k,v in pairs(currentEms) do
-- 				if DoesEntityExist(GetPlayerPed(v.id)) then
-- 					table.insert(active_medical, {
-- 						rank = v.rank,
-- 						entity = GetPlayerPed(v.id)
-- 					})
-- 				end
-- 			end

-- 			for k,v in pairs(currentCops) do
-- 				if DoesEntityExist(GetPlayerPed(v.id)) then
-- 					table.insert(active_troopers, {
-- 						rank = v.rank,
-- 						entity = GetPlayerPed(v.id), 
-- 					})
-- 				end
-- 			end

-- 			if IsAnyJobs({'police'}) then
-- 				table.insert(active_troopers, {
-- 					rank = HighLife.Player.Job.rank,
-- 					entity = PlayerPedId(),
-- 				})
-- 			end

-- 			if IsAnyJobs({'ambulance'}) then
-- 				table.insert(active_medical, {
-- 					rank = HighLife.Player.Job.rank,
-- 					entity = PlayerPedId(),
-- 				})
-- 			end

-- 			active_units = {
-- 				police = active_troopers,
-- 				ambulance = active_medical
-- 			}

-- 			for k,v in pairs(Config.PatrolZones.Zones[HighLife.Player.Job.name]) do
-- 				local areaActive = true

-- 				if v.requires ~= nil then
-- 					areaActive = false

-- 					for requiredArea,requiredAreaUnits in pairs(v.requires) do
-- 						if DoesBlipExist(Config.PatrolZones.Zones[HighLife.Player.Job.name][requiredArea].blip) then
-- 							if Config.PatrolZones.Zones[HighLife.Player.Job.name][requiredArea].activeUnits >= requiredAreaUnits then
-- 								areaActive = true
-- 							else
-- 								areaActive = false
-- 								break
-- 							end
-- 						else
-- 							areaActive = false
-- 							break
-- 						end
-- 					end
-- 				end

-- 				SetBlipDisplay() -- 3 only on map, 6 for both

-- 				if v.blip == nil or not DoesBlipExist(v.blip) then
-- 					if areaActive then
-- 						v.blip = AddBlipForArea(v.position, v.width, v.height)

-- 						if v.cornerOverride == nil and v.cornerPositions == nil then
-- 							v.cornerPositions = CalculateRectangleCornerPositions(v.position, v.width, v.height, v.rotation)
							
-- 							if Config.PatrolZones.Debug then
-- 								AddBlipForCoord(v.cornerPositions.top_right, 0.0)
-- 								AddBlipForCoord(v.cornerPositions.bottom_left, 0.0)
-- 							end
-- 						end

-- 						SetBlipColour(v.blip, v.defaultColor)
-- 						SetBlipAlpha(v.blip, Config.PatrolZones.AreaBlipAlpha) 
-- 						SetBlipRotation(v.blip, math.ceil(180.0)) -- FIXME: this should take v.rotation - should work now with 0?
-- 					end
-- 				end

-- 				if areaActive then
-- 					if v.isActive == nil or not v.isActive then
-- 						v.isActive = true

-- 						Notification_AboveMap('~y~' .. v.name .. ' ~s~is available for units to patrol')
-- 					end

-- 					v.activeUnits = 0

-- 					for i=1, #active_units[HighLife.Player.Job.name] do
-- 						-- Cadets don't count!
-- 						if active_units[HighLife.Player.Job.name][i].rank ~= 0 then
-- 							if v.cornerOverride ~= nil then
-- 								if IsEntityInArea(active_units[HighLife.Player.Job.name][i].entity, v.cornerOverride.bottom_left, -Config.PatrolZones.AreaHeightCheck, v.cornerOverride.top_right, Config.PatrolZones.AreaHeightCheck, false, true, false) then
-- 									v.activeUnits = v.activeUnits + 1
-- 								end
-- 							else
-- 								if IsEntityInArea(active_units[HighLife.Player.Job.name][i].entity, v.cornerPositions.bottom_left, -Config.PatrolZones.AreaHeightCheck, v.cornerPositions.top_right, Config.PatrolZones.AreaHeightCheck, false, true, false) then
-- 									v.activeUnits = v.activeUnits + 1
-- 								end
-- 							end
-- 						end
-- 					end

-- 					if v.activeUnits ~= 0 then
-- 						SetBlipDisplay(v.blip, 4)
-- 					else
-- 						SetBlipDisplay(v.blip, 6)
-- 					end

-- 					if v.activeUnits < v.unitsRequired then
-- 						if v.activeUnits == 0 then
-- 							SetBlipColour(v.blip, v.defaultColor)
-- 						else
-- 							SetBlipColour(v.blip, Config.PatrolZones.Zone_Colors.orange)
-- 						end
-- 					else
-- 						SetBlipColour(v.blip, Config.PatrolZones.Zone_Colors.green)
-- 					end
-- 				else
-- 					v.isActive = false
-- 					v.activeUnits = 0

-- 					if v.blip ~= nil then
-- 						if DoesBlipExist(v.blip) then
-- 							RemoveBlip(v.blip)
-- 						end

-- 						v.blip = nil
-- 					end
-- 				end
-- 			end
-- 		else
-- 			for k,v in pairs(Config.PatrolZones.Zones.police) do
-- 				if v.blip ~= nil then
-- 					if DoesBlipExist(v.blip) then
-- 						RemoveBlip(v.blip)
-- 					end

-- 					v.blip = nil
-- 				end
-- 			end

-- 			for k,v in pairs(Config.PatrolZones.Zones.ambulance) do
-- 				if v.blip ~= nil then
-- 					if DoesBlipExist(v.blip) then
-- 						RemoveBlip(v.blip)
-- 					end

-- 					v.blip = nil
-- 				end
-- 			end
-- 		end

-- 		Wait(Config.PatrolZones.UpdateInterval * 1000)
-- 	end
-- end)

-- For marking new areas
-- if Config.PatrolZones.Debug then
-- 	local debug_blip_width = 50.0
-- 	local debug_blip_height = 50.0

-- 	local hasUpdated = true

-- 	RegisterCommand("patrol_debug", function(source, args, raw) --change command here
-- 		debug_blip_width = tonumber(args[1])
-- 		debug_blip_height = tonumber(args[2])

-- 		hasUpdated = false
-- 	end, false)

-- 	CreateThread(function()
-- 		local thisArea = AddBlipForArea(vector3(0.0, 0.0, 0.0), 500.0, 500.0)

-- 		SetBlipColour(thisArea, 10)
-- 		SetBlipAlpha(thisArea, 160)
-- 		SetBlipRotation(thisArea, math.ceil(180.0))

-- 		while true do
-- 			SetBlipCoords(thisArea, GetEntityCoords(PlayerPedId()))

-- 			if not hasUpdated then
-- 				RemoveBlip(thisArea)

-- 				hasUpdated = true

-- 				thisArea = AddBlipForArea(GetEntityCoords(PlayerPedId()), debug_blip_width, debug_blip_height)

-- 				print('debug patrol area updated with W: ' .. debug_blip_width .. ' and H: ' .. debug_blip_height)
-- 			end
			
-- 			Wait(1)
-- 		end
-- 	end)
-- end
