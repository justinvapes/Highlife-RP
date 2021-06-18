local licenseNumber = "I1234562"
local licenseClass = "A"

local dateIssued = "01/10/2019"
local dateExpires = "01/10/2020"

local firstName = "JAY"
local lastName = "SON"

local dob = "14/07/1987"
local addressL1 = "2570 24TH STREET"
local addressL2 = "LOS SANTOS, SA 95818"

local sex = "M"

local hairColour = "BLK"
local eyeColour = "BRN"

local height = "5'-08\""
local weight = "150 lb"

local carIssued = "06/10/2019"
local carExpires = "06/10/2020"
local heliIssued = "06/10/2019"
local bikeIssued = "06/10/2019"
local bikeExpires = "06/10/2020"
local heliExpires = "06/10/2020"
local planeIssued = "06/10/2019"
local planeExpires = "06/10/2020"
local weaponIssued = "06/10/2019"
local weaponExpires = "06/10/2020"
local huntingIssued = "06/10/2019"
local huntingExpires = "06/10/2020"
local commercialIssued = "06/10/2019"
local commercialExpires = "06/10/2020"

local isViewingID = false

RegisterNetEvent('HighLife:ID:View')
AddEventHandler('HighLife:ID:View', function(playerNetID, playerData)
	if not isViewingID then
		isViewingID = true

		local hasCarLicense = true
		local hasBikeLicense = true
		local hasHeliLicense = false
		local hasPlaneLicense = false
		local hasWeaponLicense = true
		local hasHuntingLicense = false
		local hasCommercialLicense = true

		CreateThread(function()
			if not HasStreamedTextureDictLoaded("mpinventory") then
				RequestStreamedTextureDict("mpinventory", true)
				
				while not HasStreamedTextureDictLoaded("mpinventory") do
					Wait(1)
				end
			end

			local handle = RegisterPedheadshot(NetToPed(playerNetID))

			while not IsPedheadshotReady(handle) do
			    Wait(10)
			end

			local headshot = GetPedheadshotTxdString(handle)

			local frontDisplay = true

			while isViewingID do
				if IsControlJustPressed(1, 174) or IsControlJustPressed(1, 175) then
					frontDisplay = not frontDisplay
				end

				if IsControlJustPressed(1, 177) or IsControlJustPressed(1, 200) or IsControlJustPressed(1, 202) then
					isViewingID = false
				end

				if HighLife.Player.Dead then
					isViewingID = false
				end

				local idX = 0.87
				local idY = 0.835

				local offsetX = idX - 0.085
				local offsetY = idY - 0.084
				--rounded edges
				DrawSprite("mpinventory", "in_world_circle", offsetX, offsetY, 0.007, 0.0125, 0.0, 246, 244, 238, 255)
				offsetX = idX + 0.085
				DrawSprite("mpinventory", "in_world_circle", offsetX, offsetY, 0.007, 0.0125, 0.0, 246, 244, 238, 255)
				offsetX = idX - 0.085
				offsetY = idY + 0.084
				DrawSprite("mpinventory", "in_world_circle", offsetX, offsetY, 0.007, 0.0125, 0.0, 246, 244, 238, 255)
				offsetX = idX + 0.085
				DrawSprite("mpinventory", "in_world_circle", offsetX, offsetY, 0.007, 0.0125, 0.0, 246, 244, 238, 255)
				--fill between rounded edges
				offsetY = idY - 0.0874
				DrawRect(idX, offsetY, 0.1692, 0.0030, 246, 244, 238, 255)
				offsetY = idY + 0.0875
				DrawRect(idX, offsetY, 0.1692, 0.0030, 246, 244, 238, 255)
				offsetX = idX - 0.0865
				DrawRect(offsetX, idY, 0.0030, 0.1690, 246, 244, 238, 255)
				offsetX = idX + 0.0865
				DrawRect(offsetX, idY, 0.0030, 0.1690, 246, 244, 238, 255)
				--main card
				DrawRect(idX, idY, 0.1725, 0.1725, 246, 244, 238, 255)

				if (frontDisplay) then
					offsetX = idX - 0
					offsetY = idY - 0.06
					DrawRect(offsetX, offsetY, 0.176, 0.0015, 18, 67, 107, 255)
					offsetX = idX - 0.055
					offsetY = idY - 0
					DrawSprite(headshot, headshot, offsetX, offsetY, 0.05, 0.090, 0.0, 255, 255, 255, 255)
					offsetX = idX + 0.030
					offsetY = idY + 0.035
					DrawSprite(headshot, headshot, offsetX, offsetY, 0.025, 0.045, 0.0, 255, 255, 255, 69)

					SetTextFont(1)
					SetTextProportional(1)
					SetTextScale(0.0, 0.5)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("SAN ANDREAS")
					offsetX = idX - 0.075
					offsetY = idY - 0.085
					DrawText(offsetX, offsetY)

					SetTextFont(2)
					SetTextProportional(1)
					SetTextScale(0.0, 0.175)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("USA")
					offsetX = idX - 0
					offsetY = idY - 0.076
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.247)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("IDENTIFICATION")
					offsetX = idX + 0.010
					offsetY = idY - 0.085
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("LN")
					offsetX = idX - 0.028
					offsetY = idY - 0.015
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("FN")
					offsetX = idX - 0.028
					offsetY = idY - 0.0025
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("DL")
					offsetX = idX - 0.028
					offsetY = idY - 0.045
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.225)
					SetTextColour(162, 68, 53, 255)
					SetTextEntry("STRING")
					AddTextComponentString(licenseNumber)
					offsetX = idX - 0.021
					offsetY = idY - 0.049
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("CLASS")
					offsetX = idX + 0.040
					offsetY = idY - 0.039
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.190)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(licenseClass)
					offsetX = idX + 0.057
					offsetY = idY - 0.041
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("EXP")
					offsetX = idX - 0.028
					offsetY = idY - 0.028
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("END")
					offsetX = idX + 0.040
					offsetY = idY - 0.027
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.190)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString("NONE")
					offsetX = idX + 0.052
					offsetY = idY - 0.029
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.195)
					SetTextColour(162, 68, 53, 255)
					SetTextEntry("STRING")
					AddTextComponentString(dateExpires)
					offsetX = idX - 0.019
					offsetY = idY - 0.030
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(addressL1)
					offsetX = idX - 0.028
					offsetY = idY + 0.007
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(addressL2)
					offsetX = idX - 0.028
					offsetY = idY + 0.015
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("DOB")
					offsetX = idX - 0.028
					offsetY = idY + 0.025
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("RSTR")
					offsetX = idX - 0.028
					offsetY = idY + 0.034
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString("NONE")
					offsetX = idX - 0.015
					offsetY = idY + 0.034
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString("08311977")
					offsetX = idX + 0.055
					offsetY = idY + 0.034
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("SEX")
					offsetX = idX - 0.010
					offsetY = idY + 0.055
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("HAIR")
					offsetX = idX + 0.018
					offsetY = idY + 0.055
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("EYES")
					offsetX = idX + 0.048
					offsetY = idY + 0.055
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("HGT")
					offsetX = idX - 0.010
					offsetY = idY + 0.063
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("WGT")
					offsetX = idX + 0.018
					offsetY = idY + 0.063
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("ISS")
					offsetX = idX + 0.058
					offsetY = idY + 0.067
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(18, 67, 107, 255)
					SetTextEntry("STRING")
					AddTextComponentString("DD")
					offsetX = idX - 0.010
					offsetY = idY + 0.073
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.124)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString("00/00/0000NNNAN/ANFD/YY")
					offsetX = idX - 0.003
					offsetY = idY + 0.074
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.190)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(lastName)
					offsetX = idX - 0.021
					offsetY = idY - 0.017
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.190)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(firstName)
					offsetX = idX - 0.021
					offsetY = idY - 0.005
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.195)
					SetTextColour(162, 68, 53, 255)
					SetTextEntry("STRING")
					AddTextComponentString(dob)
					offsetX = idX - 0.017
					offsetY = idY + 0.023
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(sex)
					offsetX = idX - 0
					offsetY = idY + 0.055
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(hairColour)
					offsetX = idX + 0.030
					offsetY = idY + 0.055
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(eyeColour)
					offsetX = idX + 0.060
					offsetY = idY + 0.055
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(height)
					offsetX = idX - 0
					offsetY = idY + 0.063
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(weight)
					offsetX = idX + 0.030
					offsetY = idY + 0.063
					DrawText(offsetX, offsetY)

					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.150)
					SetTextColour(0, 0, 0, 255)
					SetTextEntry("STRING")
					AddTextComponentString(dateIssued)
					offsetX = idX + 0.058
					offsetY = idY + 0.074
					DrawText(offsetX, offsetY)
				else
					offsetX = idX - 0
					offsetY = idY - 0.07
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY - 0.05
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY - 0.03
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY - 0.01
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY + 0.01
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY + 0.03
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY + 0.05
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetY = idY + 0.07
					DrawRect(offsetX, offsetY, 0.15, 0.0015, 18, 67, 107, 255)
					offsetX = idX - 0.0745
					offsetY = idY - 0
					DrawRect(offsetX, offsetY, 0.0008, 0.14, 18, 67, 107, 255)
					offsetX = idX - 0.0445
					DrawRect(offsetX, offsetY, 0.0008, 0.14, 18, 67, 107, 255)
					offsetX = idX + 0.0145
					DrawRect(offsetX, offsetY, 0.0008, 0.14, 18, 67, 107, 255)
					offsetX = idX + 0.0745
					DrawRect(offsetX, offsetY, 0.0008, 0.14, 18, 67, 107, 255)

					offsetX = idX - 0.06
					offsetY = idY - 0.06
					DrawSprite("mpinventory", "mp_specitem_bike", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)
					offsetY = idY - 0.04
					DrawSprite("mpinventory", "mp_specitem_car", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)
					offsetY = idY - 0.02
					DrawSprite("mpinventory", "mp_specitem_steer_wheel", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)
					offsetY = idY - 0
					DrawSprite("mpinventory", "mp_specitem_heli", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)
					offsetY = idY + 0.02
					DrawSprite("mpinventory", "mp_specitem_plane", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)
					offsetY = idY + 0.04
					DrawSprite("mpinventory", "mp_specitem_weapons", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)
					offsetY = idY + 0.06
					DrawSprite("mpinventory", "shooting_range", offsetX, offsetY, 0.012, 0.020, 0.0, 18, 67, 107, 255)

					offsetX = idX - 0.035
					offsetY = idY - 0.069

					if (hasBikeLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(bikeIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(bikeExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY - 0.059
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end

					offsetX = idX - 0.035
					offsetY = idY - 0.049

					if (hasCarLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(carIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(carExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY - 0.039
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end

					offsetX = idX - 0.035
					offsetY = idY - 0.029

					if (hasCommercialLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(commercialIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(commercialExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY - 0.019
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end

					offsetX = idX - 0.035
					offsetY = idY - 0.009

					if (hasHeliLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(heliIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(heliExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY + 0.001
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end

					offsetX = idX - 0.035
					offsetY = idY + 0.011

					if (hasPlaneLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(planeIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(planeExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY + 0.021
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end

					offsetX = idX - 0.035
					offsetY = idY + 0.031

					if (hasWeaponLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(weaponIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(weaponExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY + 0.041
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end

					offsetX = idX - 0.035
					offsetY = idY + 0.051

					if (hasHuntingLicense) then
						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(huntingIssued)
						DrawText(offsetX, offsetY)

						SetTextFont(0)
						SetTextProportional(1)
						SetTextScale(0.0, 0.24)
						SetTextColour(0, 0, 0, 255)
						SetTextEntry("STRING")
						AddTextComponentString(huntingExpires)
						offsetX = idX + 0.025
						DrawText(offsetX, offsetY)
					else
						offsetX = idX - 0.016
						offsetY = idY + 0.061
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
						offsetX = idX + 0.044
						DrawRect(offsetX, offsetY, 0.035, 0.0015, 0, 0, 0, 255)
					end
				end

				Wait(1)
			end

			UnregisterPedheadshot(handle)
		end)
	end
end)