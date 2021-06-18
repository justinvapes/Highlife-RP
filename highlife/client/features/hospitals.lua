local nearHospital = nil

local inHospitalMenu = false

CreateThread(function()
	while true do
		nearHospital = nil

		if not HighLife.Player.InVehicle then
			for treatmentLocation,treatmentLocationData in pairs(Config.EMS.TreatmentLocations) do
				if Vdist(HighLife.Player.Pos, treatmentLocationData.location) < 25.0 then
					nearHospital = treatmentLocation

					break
				end
			end
		end

		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		if nearHospital ~= nil then
			if not RageUI.Visible(RMenu:Get('hospital', 'main')) and not RageUI.Visible(RMenu:Get('store', 'main')) and not IsAnyJobMenuVisible() then
				DrawMarker(2, Config.EMS.TreatmentLocations[nearHospital].location + vector3(0.0, 0.0, 0.4), 0.0, 0.0, 0.0, vector3(0.0, 180.0, 0.0), 0.5, 0.5, 0.5, 255, 255, 255, 100, false, false, 2, true, false, false, false)
			end

			if Vdist(HighLife.Player.Pos, Config.EMS.TreatmentLocations[nearHospital].location) < (HighLife.Player.Dead and 3.0 or 1.5) then
				if not RageUI.Visible(RMenu:Get('hospital', 'main')) and not RageUI.Visible(RMenu:Get('store', 'main')) and not IsAnyJobMenuVisible() then
					if HighLife.Player.Dragger == nil then
						DisplayHelpText('Welcome to ~r~' .. (Config.EMS.TreatmentLocations[nearHospital].name or nearHospital) .. ' ~s~hospital~n~~n~Press ~INPUT_PICKUP~ for available options')
						
						if IsControlJustReleased(0, 38) then
							RMenu:Get('job', 'main').Index = 1

							RageUI.Visible(RMenu:Get('hospital', 'main'), true)

							inHospitalMenu = true
						end
					end
				end
			else
				if inHospitalMenu then
					inHospitalMenu = false

					RageUI.CloseAll()
				end
			end
		end

		Wait(0)
	end
end)