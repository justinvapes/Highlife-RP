local event_durations = {}

function HighLife:ResetEventData()
	MenuVariables.Event.Data = {
		name = nil,
		duration = 1,
		description = nil,
		blip = {
			id = nil,
			coords = nil,
		}
	}
end

RegisterNetEvent("HighLife:Event:Sync")
AddEventHandler('HighLife:Event:Sync', function(eventData)
	local thisData = json.decode(eventData)

	CreateEventBlips(thisData)
end)

local EventBlips = {}

function CreateEventBlips(eventData)
	for i=1, #EventBlips do
		if DoesBlipExist(EventBlips[i]) then
			RemoveBlip(EventBlips[i])
		end
	end

	for i=1, #eventData do
		local thisBlipData = eventData[i]

		if not thisBlipData.dispersal then
			local thisPos = json.decode(thisBlipData.blip.coords)

			local thisEventBlip = AddBlipForCoord(thisPos.x, thisPos.y, thisPos.z)

			SetBlipDisplay(thisEventBlip, 4)
			SetBlipSprite(thisEventBlip, thisBlipData.blip.id)
			SetBlipColour(thisEventBlip, thisBlipData.blip.color)
			SetBlipScale(thisEventBlip, 1.0)
			SetBlipAsShortRange(thisEventBlip, true)

			local thisEntry = 'this_blip_event_title_ ' .. math.random(0xF128)

			AddTextEntry(thisEntry, 'Event: ' .. thisBlipData.name)
			BeginTextCommandSetBlipName(thisEntry)
			EndTextCommandSetBlipName(thisEventBlip)

			table.insert(EventBlips, thisEventBlip)
		else
			local thisPos = thisBlipData.position

			local thisEventBlip = AddBlipForRadius(thisPos.x, thisPos.y, thisPos.z, 100.0)

			if Vdist(thisPos.x, thisPos.y, thisPos.z, HighLife.Player.Pos) < 100.0 then
				Notification_AboveMap('~o~You are currently within a dispersal ordered area, please leave or face arrest')
			end

			SetBlipDisplay(thisEventBlip, 4)
			SetBlipColour(thisEventBlip, 26)
			SetBlipAlpha(thisEventBlip, 170)
			SetBlipAsShortRange(thisEventBlip, true)

			local thisEntry = 'this_blip_event_title_ ' .. math.random(0xF128)

			AddTextEntry(thisEntry, 'LSPD: Dispersal Order')
			BeginTextCommandSetBlipName(thisEntry)
			EndTextCommandSetBlipName(thisEventBlip)

			table.insert(EventBlips, thisEventBlip)
		end
	end
end