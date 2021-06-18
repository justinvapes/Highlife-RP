local street = {}
local streetName = {}

-- Configuration. Please be careful when editing. It does not check for errors.
streetName.show = true
streetName.position = {x = 0.5, y = 0.02, centered = true}
streetName.textSize = 0.35
streetName.textColour = {r = 255, g = 255, b = 255, a = 255}
-- End of configuration

local isHidden = false

RegisterNetEvent('HHud:HideHud')
AddEventHandler('HHud:HideHud', function(hide)
	isHidden = hide
end)

Citizen.CreateThread(function()
	local lastStreetA = 0
	local lastStreetB = 0
	local lastStreetName = {}
	
	while streetName.show do
		Wait(350)
			
		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local streetA, streetB = Citizen.InvokeNative(0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
		
		if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
			-- Ignores the switcharoo while doing circles on intersections
			lastStreetA = streetA
			lastStreetB = streetB
		end

		street = {}
		
		if lastStreetA ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
		end
		
		if lastStreetB ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if not agustHide and not isHidden and not hideHeading and streetName ~= nil then
			drawText( table.concat( street, " & " ), streetName.position.x, streetName.position.y, {
				size = streetName.textSize,
				colour = streetName.textColour,
				outline = true,
				centered = streetName.position.centered
			})
		end
	end
end)