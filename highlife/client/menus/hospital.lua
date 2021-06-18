RMenu.Add('hospital', 'main', RageUI.CreateMenu("Hospital", "Easy to swallow pills here"))

CreateThread(function()
	local isGettingInBed = false

	while true do
		if not isGettingInBed then
			RageUI.IsVisible(RMenu:Get('hospital', 'main'), true, false, true, function()
				if HasWhitelistJob('ambulance') and IsAnyJobs({'ambulance', 'unemployed'}) then
					RageUI.ButtonWithStyle('Work', 'Pain is but a number', { RightLabel = "→→→" }, (not HighLife.Player.Dead), function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenClosestJob()
						end
					end)
				end

				RageUI.ButtonWithStyle('Shop', 'Purchase medical goodies', { RightLabel = "→→→" }, (not HighLife.Player.Dead), function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						Wait(25)

						HighLife:OpenClosestShop()
					end
				end)

				RageUI.ButtonWithStyle('Sign out', 'Sign out from the hopsital and get your ~y~clothes ~s~back', { RightLabel = "→→→" }, (not HighLife.Player.Dead), function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:EMS:GiveClothes', HighLife.Player.ServerId)

						Notification_AboveMap("Thank you, don't come back soon!")
						
						RageUI.CloseAll()
					end
				end)

				if HighLife.Player.Debug or HighLife.Player.Dead then
					RageUI.ButtonWithStyle('Check in', "You're ~o~badly injured~s~, lets get you into a ~g~bed~s~, kid", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							isGettingInBed = true

							RageUI.CloseAll()

							local foundBed = nil
							local closestHospital = nil

							for hospitalName, hospitalData in pairs(Config.EMS.TreatmentLocations) do
								if Vdist(hospitalData.location, HighLife.Player.Pos) <= 20.0 then
									closestHospital = hospitalName

									break
								end
							end

							if closestHospital ~= nil then
								local nearbyObjects = GetNearbyObjects(Config.EMS.TreatmentLocations[closestHospital].bed_area.location, 10.0)

								for i=1, #nearbyObjects do
									for j=1, #Config.EMS.TreatmentLocations[closestHospital].bed_area.bed_objects do
										if Config.EMS.TreatmentLocations[closestHospital].bed_area.bed_objects[j] == GetEntityModel(nearbyObjects[i]) then
											foundBed = (not IsAnyPlayerNearCoords(GetEntityCoords(nearbyObjects[i]), 1.0) and nearbyObjects[i] or nil)

											if foundBed ~= nil then break end
										end
									end

									if foundBed ~= nil then
										break
									end
								end

								if foundBed ~= nil then
									if not HighLife.Player.Debug then
										DoScreenFadeOut(5000)

										repeat Wait(1) until IsScreenFadedOut()
									end

									HighLife:RevivePlayer(true, nil, true)

									Wait(500)

									SetEntityCoords(HighLife.Player.Ped, GetEntityCoords(foundBed))

									HighLife.Player.CheckInHospital = true

									Wait(100)

									ForceSitClosestChair()

									if not HighLife.Player.Debug then
										TriggerServerEvent('HighLife:Detention:Send', 'icu')

										DoScreenFadeIn(20000)

										repeat Wait(1) until IsScreenFadedIn()
									end

									HighLife.Player.CheckInHospital = false
								else
									Notification_AboveMap('~o~There are no free beds to take you right now')
								end
							end

							isGettingInBed = false
						end
					end)
				end

				RageUI.Separator('Medical Personnel Available: ~y~' .. GetOnlineJobCount('ambulance'))
			end)
		end

		Wait(1)
	end
end)