HighLife.Player.Phone = {
	Number = nil,

	IsOpen = false,
	HasPhone = false,
	HasDarknet = false,
	Initialized = false,

	LastUpdate = GetGameTimer(),
}

function HighLife.Phone:Visibility(method)
	SendNUIMessage({
		nui_reference = 'phone',
		data = {
			visible = method
		}
	})

	if method == 'open' then
		HighLife.Player.Phone.IsOpen = true

		SetNuiFocus(true, true)
	end

	if method == 'close' then
		HighLife.Player.Phone.IsOpen = false

		SetNuiFocus(false, false)
	end
end

RegisterNUICallback('phone_exit', function()
	HighLife.Phone:Visibility('close')
end)

RegisterNUICallback('phone_requestFocus', function(data)
	SetNuiFocus(data.focus, data.focus)
end)

-- FIXME: Make sure they can't spoof their phone number

function HighLife.Phone:GetFormattedTime()
	return GetClockHours() ..':' .. (string.len(GetClockMinutes()) < 2 and '0' .. GetClockMinutes() or GetClockMinutes())
end

function HighLife.Phone:ProcessInput(thisKey)
	SendNUIMessage({
		nui_reference = 'phone',
		data = {
			inputKey = thisKey,
		}
	})
end

function HighLife.Phone:UpdateSettings(thisSettings)
	if thisSettings ~= nil then
		HighLife.Player.Phone.Number = thisSettings.number

		HighLife.Player.Phone.HasPhone = thisSettings.hasPhone
		HighLife.Player.Phone.HasDarknet = thisSettings.darkNetSimCard
	end

	local phoneSettings = {
		signal = (GetZoneScumminess(GetZoneAtCoords(HighLife.Player.Pos)) * 20),
		number = HighLife.Player.Phone.Number,
		hasPhone = HighLife.Player.Phone.HasPhone,
		darkNetSimCard = HighLife.Player.Phone.HasDarknet,
	}

	SendNUIMessage({
		nui_reference = 'phone',
		data = {
			settings = phoneSettings,
			identifier = HighLife.Player.Steam,
			updateTime = HighLife.Phone:GetFormattedTime()
		}
	})

	if not HighLife.Player.Phone.Initialized then
		HighLife.Player.Phone.Initialized = true
	end	
end

-- CreateThread(function()
-- 	SetNuiFocus(false, false)

-- 	while true do
-- 		if HighLife.Player.Phone.Initialized then
-- 			if (HighLife.Player.Phone.HasPhone ~= HighLife.Player.SpecialItems[Config.Phone.Item]) or HighLife.Player.Phone.HasDarknet ~= HighLife.Player.SpecialItems[Config.Phone.DarknetItem] then
-- 				if HighLife.Player.SpecialItems[Config.Phone.Item] ~= nil then
-- 					HighLife.Player.Phone.HasPhone = HighLife.Player.SpecialItems[Config.Phone.Item]

-- 					HighLife.Phone:UpdateSettings()
-- 				end

-- 				if HighLife.Player.SpecialItems[Config.Phone.DarknetItem] ~= nil then
-- 					HighLife.Player.Phone.HasDarknet = HighLife.Player.SpecialItems[Config.Phone.DarknetItem]
					
-- 					HighLife.Phone:UpdateSettings()
-- 				end
-- 			end

-- 			if IsKeyboard() then
-- 				if IsControlJustReleased(0, Config.Phone.Controls.OPEN) then
-- 					HighLife.Phone:Visibility((HighLife.Player.Phone.IsOpen and 'close' or 'open'))
-- 				end
-- 			end

-- 			if HighLife.Player.Phone.IsOpen then
-- 				for KeyName,KeyCode in pairs(Config.Phone.Controls) do
-- 					if IsControlJustReleased(0, KeyCode) then
-- 						HighLife.Phone:ProcessInput(KeyName)

-- 						break
-- 					end
-- 				end
-- 			end

-- 			if (GetGameTimer() - HighLife.Player.Phone.LastUpdate) > 2000 then
-- 				HighLife.Phone:UpdateSettings()

-- 				HighLife.Player.Phone.LastUpdate = GetGameTimer()
-- 			end
-- 		end

-- 		Wait(1)
-- 	end
-- end)