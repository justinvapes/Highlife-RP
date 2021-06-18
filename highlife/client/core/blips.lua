local hangout_blip = nil
local hangout_area_blip = nil

RegisterNetEvent('HighLife:Blips:Hangout')
AddEventHandler('HighLife:Blips:Hangout', function(area)
	local current_area = Config.Hangout[area]

	if current_area ~= nil then
		if hangout_blip ~= nil then
			RemoveBlip(hangout_blip)
			RemoveBlip(hangout_area_blip)

			-- Notification_AboveMap('The hangout location has moved to ~g~' .. current_area.name)
		end

		hangout_blip = AddBlipForCoord(current_area.location)

		SetBlipSprite(hangout_blip, 171)
		SetBlipDisplay(hangout_blip, 4)
		SetBlipScale(hangout_blip, 1.0)
		SetBlipColour(hangout_blip, 24)
		SetBlipAsShortRange(hangout_blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Hangout: ' .. current_area.name)
		EndTextCommandSetBlipName(hangout_blip)
		
		hangout_area_blip = AddBlipForArea(current_area.location, current_area.width, current_area.height)

		SetBlipDisplay(hangout_area_blip, 3)
		SetBlipColour(hangout_area_blip, 12)
		SetBlipAlpha(hangout_area_blip, 160)
		SetBlipAsShortRange(hangout_area_blip, true)
		SetBlipRotation(hangout_area_blip, current_area.rotation)

		if current_area.image ~= nil then
			SetBlipInfoTitle(hangout_blip, current_area.name, false)
			AddBlipInfoText(hangout_blip, "Current Hangout", '~g~Active')

			if current_area.image ~= nil then
				RequestStreamedTextureDict(current_area.image.dict, 1)
				
				while not HasStreamedTextureDictLoaded(current_area.image.dict)  do
					Wait(1)
				end
				
				SetBlipInfoImage(hangout_blip, current_area.image.dict, current_area.image.name) 
			end
		end
	end
end)

CreateThread(function()
	if hangout_blip == nil then
		TriggerServerEvent('HighLife:Blips:GetHangout')
	end
	
	for _, blipData in pairs(Config.Blips.Locations) do
		blipData.blip = AddBlipForCoord(blipData.x, blipData.y, blipData.z)
		SetBlipSprite(blipData.blip, blipData.id)
		SetBlipDisplay(blipData.blip, 4)

		if blipData.interior ~= nil then
			SetBlipDisplay(blipData.blip, 0)
		end

		if blipData.money then
			SetBlipCategory(blipData.blip, 10)
		end

		if blipData.size then
			SetBlipScale(blipData.blip, blipData.size)
		else
			SetBlipScale(blipData.blip, 1.0)
		end

		local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

		AddTextEntry(thisEntry, blipData.title)
		
		SetBlipColour(blipData.blip, blipData.colour)
		SetBlipAsShortRange(blipData.blip, true)
		BeginTextCommandSetBlipName(thisEntry)
		EndTextCommandSetBlipName(blipData.blip)
	end

	while true do
		if not HighLife.Player.CD then
			for _, blipData in pairs(Config.Blips.Locations) do
				if blipData.interior ~= nil then
					if HighLife.Player.CurrentInterior == blipData.interior then
						-- display
						SetBlipDisplay(blipData.blip, 2)
					else
						SetBlipDisplay(blipData.blip, 0)
					end
				end
			end
		end

		Wait(1000)
	end
end)