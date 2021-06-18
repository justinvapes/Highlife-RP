RMenu.Add('job', 'main', RageUI.CreateMenu("", ""))

RMenu.Add('job', 'vehicles', RageUI.CreateSubMenu(RMenu:Get('job', 'main'), nil, nil))
RMenu.Add('job', 'equipment', RageUI.CreateSubMenu(RMenu:Get('job', 'main'), nil, nil))
RMenu.Add('job', 'management', RageUI.CreateSubMenu(RMenu:Get('job', 'main'), nil, nil))

RMenu.Add('job', 'manage_outfits', RageUI.CreateSubMenu(RMenu:Get('job', 'management'), nil, nil))
RMenu.Add('job', 'outfit_options', RageUI.CreateSubMenu(RMenu:Get('job', 'manage_outfits'), nil, nil))

RMenu.Add('job', 'items', RageUI.CreateSubMenu(RMenu:Get('job', 'equipment'), nil, nil))
RMenu.Add('job', 'weapons', RageUI.CreateSubMenu(RMenu:Get('job', 'equipment'), nil, nil))
RMenu.Add('job', 'uniforms', RageUI.CreateSubMenu(RMenu:Get('job', 'equipment'), nil, nil))

RMenu:Get('job', 'main').Closed = function()
	MenuVariables.Jobs.CurrentVehicle = nil
end

local initOutfits = {}

local consolidatedOutfits = nil

CreateThread(function()
	while true do
		consolidatedOutfits = nil

		if MenuVariables.Jobs.Config ~= nil then
			MenuVariables.Jobs.JobRequiresLicense = nil

			if IsAnyJobMenuVisible() then
				if consolidatedOutfits == nil then
					consolidatedOutfits = (MenuVariables.Jobs.Config.Outfits ~= nil and deepcopy(MenuVariables.Jobs.Config.Outfits) or {})

					if HighLife.Player.GlobalJobOutfitData[MenuVariables.Jobs.Key] ~= nil then
						if consolidatedOutfits == nil then
							consolidatedOutfits = {}
						end

						for _, outfitData in pairs(HighLife.Player.GlobalJobOutfitData[MenuVariables.Jobs.Key]) do
							table.insert(consolidatedOutfits, {
								id = outfitData.id,
								name = outfitData.name,
								default = outfitData.is_default,
								outfit = {
									Male = outfitData.male_skin,
									Female = outfitData.female_skin
								},
								rank = outfitData.rank or 0,
								rank_attribute = outfitData.rank_attribute or nil
							})
						end
					elseif initOutfits[MenuVariables.Jobs.Key] == nil then
						initOutfits[MenuVariables.Jobs.Key] = true

						HighLife:ServerCallback('HighLife:Jobs:CallbackOutfits', function(jobOutfitData)
							if jobOutfitData ~= nil then
								HighLife.Player.GlobalJobOutfitData[MenuVariables.Jobs.Key] = json.decode(jobOutfitData)
							end
						end, MenuVariables.Jobs.Key)
					end
				end
			end

			RageUI.IsVisible(RMenu:Get('job', 'main'), true, false, true, function()
				RageUI.ButtonWithStyle(MenuVariables.Jobs.Config.MenuName, (not MenuVariables.Jobs.Config.Whitelisted and (HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key] ~= nil and (HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].actions_left_to_rank == 0 and '~g~You are the highest rank in ' .. MenuVariables.Jobs.Config.MenuName .. '!' or '~g~' .. HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].actions_left_to_rank .. ' ~s~' .. MenuVariables.Jobs.Config.RankDescriptionText .. ' left until next rank')) or ((HighLife.Other.JobStatData.current ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key] ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank_name) and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank_name)), { RightLabel = 'Rank: ' .. (HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key] ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank or 1) }, true)

				if IsAnyJobs({MenuVariables.Jobs.Key}) then
					if MenuVariables.Jobs.Config.Vehicles ~= nil then
						if MenuVariables.Jobs.Config.Whitelisted then
							if HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.entity ~= nil then
								RageUI.ButtonWithStyle('~y~Current Vehicle', "Your current work vehicle", { RightLabel = HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.plate }, true)
							end

							RageUI.List("Work Vehicles", MenuVariables.Jobs.Vehicles, MenuVariables.Jobs.VehicleIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
								MenuVariables.Jobs.VehicleIndex = Index

								MenuVariables.Jobs.CurrentVehicle = MenuVariables.Jobs.Vehicles[MenuVariables.Jobs.VehicleIndex]
							end)

							if MenuVariables.Jobs.Config.Equipment ~= nil or consolidatedOutfits ~= nil then
								RageUI.ButtonWithStyle('Equipment', 'Tools to get the job ~g~done', { RightLabel = "→→→" }, true, nil, RMenu:Get('job', 'equipment'))
							end

							if (HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank >= MenuVariables.Jobs.Config.MiscRankOptions.ManagementRank) or HighLife.Player.Debug then
								RageUI.ButtonWithStyle('~b~Management', 'Because you ~r~nag ~s~too much', { RightLabel = "→→→" }, true, nil, RMenu:Get('job', 'management'))
							end

							RageUI.ButtonWithStyle((HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.entity ~= nil and '~y~Return Vehicle' or '~g~Retrieve Vehicle'), (HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.entity ~= nil and "~y~Return your current work vehicle" or "Retrieve the selected work vehicle"), { RightLabel = '→→→' }, not MenuVariables.Jobs.CreatingVehicle, function(Hovered, Active, Selected)
								if Selected then
									if HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.netID ~= nil then
										local inReturnDistance = (Vdist(GetEntityCoords(NetToVeh(HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.netID)), HighLife.Player.Pos) < MenuVariables.Jobs.Config.MinumumReturnDistance)

										if MenuVariables.Jobs.Config.Society ~= nil then
											local returnVehicleData = nil

											for _,vehicleData in pairs(MenuVariables.Jobs.Config.Vehicles) do
												if vehicleData.model == HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.model then
													returnVehicleData = vehicleData

													break
												end
											end

											if returnVehicleData.price ~= nil then
												if MenuVariables.Jobs.Key == 'police' then
													TriggerServerEvent('HighLife:Discord:Log', 'police', GetPlayerName(HighLife.Player.Id) .. (not inReturnDistance and ' failed to' or '') .. ' returned THEIR ' .. returnVehicleData.name .. ' costing $' .. comma_value(returnVehicleData.price))
												end
												
												ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', (inReturnDistance and ('~g~$' .. comma_value(returnVehicleData.price) .. ' ~s~has been returned to the fund for returning your work vehicle') or ('~r~$' .. comma_value(returnVehicleData.price) .. ' ~s~has been lost for not returning your work vehicle')))

												if inReturnDistance then
													TriggerServerEvent('HighLife:Society:AddFund', MenuVariables.Jobs.Config.Society.name, returnVehicleData.price)
												end
											end
										end

										DeleteWorkVehicle(MenuVariables.Jobs.Key, inReturnDistance)
									else
										for _,vehicleData in pairs(MenuVariables.Jobs.Config.Vehicles) do
											local configVehicle = vehicleData.name

											if MenuVariables.Jobs.CurrentVehicle == configVehicle then
												CreateThread(function()
													local finalSpawnLocation = nil

													if vehicleData.air_vehicle ~= nil and vehicleData.air_vehicle then
														if MenuVariables.Jobs.Menu.air_spawn ~= nil then
															finalSpawnLocation = MenuVariables.Jobs.Menu.air_spawn
														end
													elseif vehicleData.boat_vehicle ~= nil and vehicleData.boat_vehicle then
														if MenuVariables.Jobs.Menu.boat_spawn ~= nil then
															finalSpawnLocation = MenuVariables.Jobs.Menu.boat_spawn
														end
													else
														if MenuVariables.Jobs.Menu.vehicle_spawns ~= nil then
															for spawnName,thisSpawn in pairs(MenuVariables.Jobs.Menu.vehicle_spawns) do
																if not GetClosestVehicleEnumeratedAtCoords(thisSpawn.location, thisSpawn.radius) then
																	finalSpawnLocation = {
																		x = thisSpawn.location.x,
																		y = thisSpawn.location.y,
																		z = thisSpawn.location.z,
																		heading = thisSpawn.location.w
																	}

																	break
																end
															end
														else
															finalSpawnLocation = MenuVariables.Jobs.Menu.vehicle_spawn
														end
													end

													local canSpawn = nil

													if MenuVariables.Jobs.Config.Society ~= nil and vehicleData.price ~= nil then
														HighLife:ServerCallback('HighLife:Society:GetFund', function(fund_size)
															if fund_size >= vehicleData.price then
																canSpawn = true

																TriggerServerEvent('HighLife:Society:RemoveFund', MenuVariables.Jobs.Config.Society.name, vehicleData.price)
															else
																canSpawn = false
															end
														end, MenuVariables.Jobs.Config.Society.name)
													else
														canSpawn = true
													end

													while canSpawn == nil do
														Wait(1)
													end

													if canSpawn or HighLife.Player.Debug then
														if finalSpawnLocation ~= nil then
															if MenuVariables.Jobs.Config.VehicleInsuranceCost ~= nil then
																ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', '~r~$' .. comma_value(MenuVariables.Jobs.Config.VehicleInsuranceCost) .. ' ~s~will be ~r~deducted ~s~if you do not return your ~y~work vehicle!')
															end

															SpawnWorkVehicle(vehicleData, MenuVariables.Jobs.Key, finalSpawnLocation)

															if MenuVariables.Jobs.Key == 'police' then
																TriggerServerEvent('HighLife:Discord:Log', 'police', GetPlayerName(HighLife.Player.Id) .. ' retrieved a ' .. vehicleData.name .. ' costing $' .. comma_value(vehicleData.price))
															end

															if MenuVariables.Jobs.Config.JobInfoMessage ~= nil then
																CreateThread(function()
																	Wait(1000)

																	ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', MenuVariables.Jobs.Config.JobInfoMessage)
																end)
															end
														else
															ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', "~r~There are no parking spots available to deliver your vehicle ")
														end
													else
														ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', "~r~Not enough available funds for this vehicle ~s~(~o~$" .. comma_value(vehicleData.price) .. "~s~)")
													end
												end)
											end
										end
									end
								end
							end)
						end
					end

					if HighLife.Player.Job.Data[MenuVariables.Jobs.Key].actions_start ~= nil then
						RageUI.ButtonWithStyle("~y~Current " .. CapitalizeString(MenuVariables.Jobs.Config.RankDescriptionText), "Your current amount of " .. MenuVariables.Jobs.Config.RankDescriptionText, { RightLabel = (HighLife.Player.Job.Data[MenuVariables.Jobs.Key].actions_start - HighLife.Player.Job.Data[MenuVariables.Jobs.Key].actions_left) }, true)
					end

					RageUI.Separator()
				end

				if MenuVariables.Jobs.Config.BonusTime ~= nil then
					local core_hours_pre_label = MenuVariables.Jobs.Config.BonusTime.start .. (MenuVariables.Jobs.Config.BonusTime.start >= 12 and 'pm' or 'am') .. ' - ' .. (MenuVariables.Jobs.Config.BonusTime.finish >= 12 and (MenuVariables.Jobs.Config.BonusTime.finish - 12) .. 'pm' or MenuVariables.Jobs.Config.BonusTime.finish .. 'am')

					if IsTimeBetween(MenuVariables.Jobs.Config.BonusTime.start, 0, MenuVariables.Jobs.Config.BonusTime.finish, 0, GetClockHours(), GetClockMinutes()) then
						core_hours_pre_label = core_hours_pre_label .. ' (~y~Active~s~)'
					end

					RageUI.ButtonWithStyle('~y~Core Hours', "~y~" .. MenuVariables.Jobs.Config.BonusTime.payoutModifier .. "x ~s~payout during these times", { RightLabel = core_hours_pre_label }, true)
				end

				if IsAnyJobs({'unemployed', MenuVariables.Jobs.Key}) then
					MenuVariables.Jobs.JobClosed = false

					if not HighLife.Player.Debug then
						if MenuVariables.Jobs.Config.RequiredLicenses ~= nil then
							for licenseKey,licenseData in pairs(MenuVariables.Jobs.Config.RequiredLicenses) do
								if not HighLife.Player.Licenses[licenseKey] then
									MenuVariables.Jobs.JobRequiresLicense = licenseData

									break
								end
							end
						end
					end

					if not MenuVariables.Jobs.Config.Whitelisted then
						RageUI.List("Work Vehicles", MenuVariables.Jobs.Vehicles, MenuVariables.Jobs.VehicleIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
							MenuVariables.Jobs.VehicleIndex = Index

							MenuVariables.Jobs.CurrentVehicle = MenuVariables.Jobs.Vehicles[MenuVariables.Jobs.VehicleIndex]
						end)

						if MenuVariables.Jobs.Config.OpenTime ~= nil then
							if not IsTimeBetween(MenuVariables.Jobs.Config.OpenTime.start, 0, MenuVariables.Jobs.Config.OpenTime.finish, 0, GetClockHours(), GetClockMinutes()) then
								MenuVariables.Jobs.JobClosed = true
							end
						end
					end

					RageUI.ButtonWithStyle((IsAnyJobs({MenuVariables.Jobs.Key}) and '~o~Finish' or (MenuVariables.Jobs.JobRequiresLicense ~= nil and '~o~' or '') .. '~g~Start') .. ' Shift', ((not HighLife.Player.Job.InService and MenuVariables.Jobs.JobClosed) and (MenuVariables.Jobs.Config.MenuName .. ' ~s~is currently ~o~closed ~s~(' .. MenuVariables.Jobs.Config.OpenTime.start .. 'am - ' .. MenuVariables.Jobs.Config.OpenTime.finish .. 'pm)') or (MenuVariables.Jobs.JobRequiresLicense ~= nil and 'You require a ~y~' .. MenuVariables.Jobs.JobRequiresLicense .. ' license ~s~to start this job' or nil)), { RightLabel = "→→→" }, (HighLife.Player.Job.InService or (not MenuVariables.Jobs.JobClosed and not MenuVariables.Jobs.JobRequiresLicense) or HighLife.Player.Debug), function(Hovered, Active, Selected)
						if Selected then
							if not HighLife.Player.Job.InService then
								MenuVariables.Jobs.isCoreHoursBonus = false
								
								if MenuVariables.Jobs.Config.BonusTime ~= nil then
									if IsTimeBetween(MenuVariables.Jobs.Config.BonusTime.start, 0, MenuVariables.Jobs.Config.BonusTime.finish, 0, GetClockHours(), GetClockMinutes()) then
										MenuVariables.Jobs.isCoreHoursBonus = true
									end
								end
							end

							HighLife.Player.Job.InService = not HighLife.Player.Job.InService

							HighLife.Player.Job.CurrentJob = MenuVariables.Jobs.Key

							local clockInRank = 0

							if HighLife.Other.JobStatData.current[HighLife.Player.Job.CurrentJob] ~= nil then
								clockInRank = HighLife.Other.JobStatData.current[HighLife.Player.Job.CurrentJob].rank
							end

							if HighLife.Player.Job.InService then
								TriggerServerEvent('HighLife:Jobs:startWorking', HighLife.Player.Job.CurrentJob, clockInRank, false)

								if IsAprilFools() then
									if HighLife.Player.Job.CurrentJob == 'police' then
										if HasJobAttribute('police', 'doa') then
											Notification_AboveMap('~b~DOA ~s~stealth mode ~g~ACTIVATED')
										end
									end
								end

								HighLife.Player.Job.StartTime = GameTimerPool.GlobalGameTime
							else
								-- FIXME: This should not be here
								if HighLife.Player.Job.name == 'police' then
									SetPedArmour(HighLife.Player.Ped, 0)
								end
							end

							local forceJobSkin = true

							if (MenuVariables.Jobs.Config.ForceJobClothes ~= nil and not MenuVariables.Jobs.Config.ForceJobClothes) or (MenuVariables.Jobs.Config.OwnClothingRank ~= nil and tonumber(clockInRank) >= MenuVariables.Jobs.Config.OwnClothingRank) then
								forceJobSkin = false
							end

							if forceJobSkin then
								if MenuVariables.Jobs.Config.RankOutfits ~= nil then
									HighLife:SetOverrideClothing((MenuVariables.Jobs.Config.RankOutfits[tonumber(clockInRank)] ~= nil and MenuVariables.Jobs.Config.RankOutfits[tonumber(clockInRank)] or MenuVariables.Jobs.Config.RankOutfits.default))
								else
									if initOutfits[MenuVariables.Jobs.Key] then
										for outfitKey,outfitData in pairs(consolidatedOutfits) do
											if outfitData.default then
												HighLife:SetOverrideClothing(outfitData.outfit)
											end
										end
									end
								end
							end

							if HighLife.Player.Job.InService then
								if MenuVariables.Jobs.Config.HeliLicenseRank ~= nil and HighLife.Other.JobStatData.current[HighLife.Player.Job.CurrentJob].rank >= MenuVariables.Jobs.Config.HeliLicenseRank then
									HighLife.Player.TempLicenses.fly_heli = true
								end

								if MenuVariables.Jobs.Config.PlaneLicenseRank ~= nil and HighLife.Other.JobStatData.current[HighLife.Player.Job.CurrentJob].rank >= MenuVariables.Jobs.Config.PlaneLicenseRank then
									HighLife.Player.TempLicenses.fly_plane = true
								end

								if MenuVariables.Jobs.Config.Vehicles ~= nil and not MenuVariables.Jobs.Config.Whitelisted then
									for k,v in pairs(MenuVariables.Jobs.Config.Vehicles) do
										local configVehicle = v.name
										
										if v.max_actions ~= nil then
											configVehicle = v.name .. ' (' .. v.max_actions .. ')'
										end

										if MenuVariables.Jobs.CurrentVehicle == configVehicle then
											CreateThread(function()
												local finalSpawnLocation = nil

												if MenuVariables.Jobs.Menu.vehicle_spawns ~= nil then
													for spawnName,thisSpawn in pairs(MenuVariables.Jobs.Menu.vehicle_spawns) do
														if not GetClosestVehicleEnumeratedAtCoords(thisSpawn.location, thisSpawn.radius) then
															finalSpawnLocation = {
																x = thisSpawn.location.x,
																y = thisSpawn.location.y,
																z = thisSpawn.location.z,
																heading = thisSpawn.location.w
															}

															break
														end
													end
												else
													finalSpawnLocation = MenuVariables.Jobs.Config.JobActions.SpawnVehicle
												end

												if finalSpawnLocation ~= nil then									
													ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', '~r~$' .. comma_value(MenuVariables.Jobs.Config.VehicleInsuranceCost) .. ' ~s~will be ~r~deducted ~s~if you do not return your ~y~work vehicle!')

													SpawnWorkVehicle(v, MenuVariables.Jobs.Key, finalSpawnLocation)

													if MenuVariables.Jobs.Config.JobInfoMessage ~= nil then
														CreateThread(function()
															Wait(1000)

															ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', MenuVariables.Jobs.Config.JobInfoMessage)
														end)
													end
												else
													HighLife.Player.Job.InService = not HighLife.Player.Job.InService

													ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', "~r~There are no parking spots available to deliver your vehicle ")
												end
											end)
										end
									end
								else
									if MenuVariables.Jobs.Config.JobInfoMessage ~= nil then
										CreateThread(function()
											Wait(1000)

											ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', MenuVariables.Jobs.Config.JobInfoMessage)						
										end)
									end
								end
							else
								HighLife.Player.Job.CurrentJob = nil

								HighLife.Player.TempLicenses.fly_heli = false
								HighLife.Player.TempLicenses.fly_plane = false

								HighLife.Player.JobClothingDebug = false

								HighLife:ResetOverrideClothing()

								local bestRank = 0

								if not MenuVariables.Jobs.Config.Whitelisted then
									for k,v in pairs(MenuVariables.Jobs.Config.Ranks) do										
										if HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank >= k then
											if k > bestRank then
												bestRank = k
											end
										end
									end

									local inReturnDistance = (Vdist(vehiclePos, HighLife.Player.Pos) > MenuVariables.Jobs.Config.MinumumReturnDistance)

									local trailerPos = nil
									local vehiclePos = GetEntityCoords(HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.entity)

									if HighLife.Player.Job.Data[MenuVariables.Jobs.Key].trailer.entity ~= nil then
										trailerPos = GetEntityCoords(HighLife.Player.Job.Data[MenuVariables.Jobs.Key].trailer.entity)
									end

									if not inReturnDistance then
										HighLife.Player.Job.Data[MenuVariables.Jobs.Key].insurance_fee = MenuVariables.Jobs.Config.VehicleInsuranceCost

										ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', '~r~$' .. MenuVariables.Jobs.Config.VehicleInsuranceCost .. ' ~s~has been deducted for not returning your work vehicle')
									end

									if trailerPos ~= nil and GetDistanceBetweenCoords(trailerPos, HighLife.Player.Pos) > MenuVariables.Jobs.Config.MinumumReturnDistance then
										HighLife.Player.Job.Data[MenuVariables.Jobs.Key].insurance_fee = HighLife.Player.Job.Data[MenuVariables.Jobs.Key].insurance_fee + MenuVariables.Jobs.Config.VehicleInsuranceCost

										ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', '~r~$' .. MenuVariables.Jobs.Config.VehicleInsuranceCost .. ' ~s~has been deducted for not returning your trailer')
									end

									if HighLife.Player.Job.Data[MenuVariables.Jobs.Key].actions_left == HighLife.Player.Job.Data[MenuVariables.Jobs.Key].actions_start then
										local notificationString = 'You made no deliveries, therefore have not been paid'

										if MenuVariables.Jobs.Config.isObjectCollection then
											notificationString = 'You did not collect any ' .. MenuVariables.Jobs.Config.ObjectCollectionName .. ', therefore have not been paid'
										end

										ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', notificationString)
									end

									if isDebugMode then
										print('Total Distance: ' .. HighLife.Player.Job.Data[MenuVariables.Jobs.Key].total_distance)
									end

									local timeTaken = 0

									if HighLife.Player.Job.StartTime ~= nil then
										timeTaken = (GameTimerPool.GlobalGameTime - HighLife.Player.Job.StartTime) / 1000

										HighLife.Player.Job.StartTime = nil
									end

									HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(thisToken)
										HighLife.Player.Job.Data[MenuVariables.Jobs.Key].token = thisToken

										TriggerServerEvent('HighLife:Jobs:UpdateDistance', MenuVariables.Jobs.Key, HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank, HighLife.Player.Job.Data[MenuVariables.Jobs.Key], MenuVariables.Jobs.isCoreHoursBonus, timeTaken)

										if DoesEntityExist(HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.entity) then
											DeleteWorkVehicle(MenuVariables.Jobs.Key, inReturnDistance)
										end

										HighLife:ResetTempJobData(MenuVariables.Jobs.Key)
									end)
								else
									if HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.netID ~= nil then
										local inReturnDistance = (Vdist(GetEntityCoords(NetToVeh(HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.netID)), HighLife.Player.Pos) < MenuVariables.Jobs.Config.MinumumReturnDistance)

										if MenuVariables.Jobs.Config.Society ~= nil then
											local returnVehicleData = nil

											for _,vehicleData in pairs(MenuVariables.Jobs.Config.Vehicles) do
												if vehicleData.model == HighLife.Player.Job.Data[MenuVariables.Jobs.Key].vehicle.model then
													returnVehicleData = vehicleData

													break
												end
											end

											if returnVehicleData.price ~= nil then
												if MenuVariables.Jobs.Key == 'police' then
													TriggerServerEvent('HighLife:Discord:Log', 'police', GetPlayerName(HighLife.Player.Id) .. (not inReturnDistance and ' failed to' or '') .. ' returned THEIR ' .. returnVehicleData.name .. ' costing $' .. comma_value(returnVehicleData.price))
												end
												
												ShowNotificationPic(MenuVariables.Jobs.Config.MenuName, '~g~Headquarters', (inReturnDistance and ('~g~$' .. comma_value(returnVehicleData.price) .. ' ~s~has been returned to the fund for returning your work vehicle') or ('~r~$' .. comma_value(returnVehicleData.price) .. ' ~s~has been lost for not returning your work vehicle')))

												if inReturnDistance then
													TriggerServerEvent('HighLife:Society:AddFund', MenuVariables.Jobs.Config.Society.name, returnVehicleData.price)
												end
											end
										end

										DeleteWorkVehicle(MenuVariables.Jobs.Key, inReturnDistance)
									end

									HighLife:ResetTempJobData(MenuVariables.Jobs.Key)
								end
							end
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'management'), true, false, true, function()
				MenuVariables.Jobs.ManagementOptions = {}

				RageUI.ButtonWithStyle('Manage Saved Uniforms', "This really doesn't need a description", { RightLabel = "→→→" }, true, nil, RMenu:Get('job', 'manage_outfits'))

				RageUI.ButtonWithStyle('Save Current Uniform', "Stores your current outfit to the job", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local outfitName = openKeyboard('SAVE_OUTFIT_NAME', 'The name of the outfit')
						local outfitRank = openKeyboard('SAVE_OUTFIT_RANK', 'The rank the outfit can be used (default: 0)')
						local outfitAttribute = openKeyboard('SAVE_OUTFIT_ATTRRIBUTE', 'The required attribute to wear this (e.g k9, doa) - leave blank if unsure')

						if (outfitName and outfitName ~= "") and (outfitRank and tonumber(outfitRank) ~= nil) then
							TriggerServerEvent('HighLife:Jobs:StoreOutfit', MenuVariables.Jobs.Key, outfitName, 0, json.encode(HighLife:GetCurrentClothing()), isMale(), outfitRank, outfitAttribute)
						else
							Notification_AboveMap('~y~Invalid requirements to store outfit, please retry')
						end
					end
				end)

				RageUI.Checkbox('~o~Job Clothing Debug Mode', "Allows you to use ~r~blacklisted ~y~clothing store ~s~items and put you in normal clothing temporarily", HighLife.Player.JobClothingDebug, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
					if Active then
						HighLife.Player.JobClothingDebug = not HighLife.Player.JobClothingDebug

						if HighLife.Player.JobClothingDebug then
							HighLife:ResetOverrideClothing()
						else
							if MenuVariables.Jobs.Config.RankOutfits ~= nil then
								HighLife:SetOverrideClothing((MenuVariables.Jobs.Config.RankOutfits[tonumber(clockInRank)] ~= nil and MenuVariables.Jobs.Config.RankOutfits[tonumber(clockInRank)] or MenuVariables.Jobs.Config.RankOutfits.default))
							else
								for outfitKey,outfitData in pairs(consolidatedOutfits) do
									if outfitData.default then
										HighLife:SetOverrideClothing(outfitData.outfit)
									end
								end
							end
						end
					end
				end)

				if HighLife.Player.JobClothingDebug then
					RageUI.ButtonWithStyle('~r~Open Debug Skin Menu', "Opens the debug skin menu", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							HighLife:OpenSkinMenu()
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'manage_outfits'), true, false, true, function()
				local hasOutfits = false

				for outfitKey,outfitData in pairs(consolidatedOutfits) do
					if outfitData.id ~= nil then
						hasOutfits = true

						RageUI.ButtonWithStyle(outfitData.name, (outfitData.description or nil), { RightLabel = "ID: " .. outfitData.id .. (outfitData.default and ' - ~b~Default' or '') }, true, function(Hovered, Active, Selected)
							if Selected then
								MenuVariables.Jobs.ManagementOptions.ManageOutfit = outfitKey
							end
						end, RMenu:Get('job', 'outfit_options'))
					end
				end

				if not hasOutfits then
					RageUI.ButtonWithStyle('None Found', nil, { RightLabel = nil }, true, nil, RMenu:Get('job', 'manage_outfits'))
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'outfit_options'), true, false, true, function()
				if consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit] ~= nil then
					RageUI.ButtonWithStyle('Rename Uniform', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							local newName = openKeyboard('EDIT_JOB_NAME', 'Enter new outfit name')

							if newName and newName ~= '' then
								TriggerServerEvent('HighLife:Jobs:RenameOutfit', MenuVariables.Jobs.Key, consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].id, newName)
							end
						end
					end)

					RageUI.ButtonWithStyle('Update ' .. (isMale() and 'Male' or 'Female') .. ' Uniform', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							local sure = openKeyboard('OVERWRITE_JOB_OUTFIT', 'Are you sure? (type: Yes, I am sure!)')

							if sure and sure == "Yes, I am sure!" then
								TriggerServerEvent('HighLife:Jobs:StoreOutfit', MenuVariables.Jobs.Key, 'update', consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].id, json.encode(HighLife:GetCurrentClothing()), isMale(), nil, nil)
							end
						end
					end)

					RageUI.ButtonWithStyle('Change Rank', nil, { RightLabel = ("Current: " .. consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].rank) }, true, function(Hovered, Active, Selected)
						if Selected then
							local newRank = openKeyboard('EDIT_JOB_RANK', 'Set outfit rank (Current: ' .. consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].rank .. ')')

							if newRank and newRank ~= '' and tonumber(newRank) then
								TriggerServerEvent('HighLife:Jobs:UpdateOutfitRank', MenuVariables.Jobs.Key, consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].id, newRank)
							end
						end
					end)

					RageUI.ButtonWithStyle('Change Rank Attribute', nil, { RightLabel = ((consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].rank_attribute ~= nil and ("Current: " .. consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].rank_attribute) or '~y~None Set')) }, true, function(Hovered, Active, Selected)
						if Selected then
							local newRankAttribute = openKeyboard('EDIT_JOB_RANK_ATTRIBUTE', 'Set outfit rank (Current: ' .. (consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].rank_attribute ~= nil and (consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].rank_attribute .. ', use "reset" to clear') or '~y~None Set') .. ')')

							if newRankAttribute and newRankAttribute ~= '' then
								TriggerServerEvent('HighLife:Jobs:UpdateOutfitRankAttribute', MenuVariables.Jobs.Key, consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].id, newRankAttribute)
							end
						end
					end)

					RageUI.Checkbox('Has Male Variant?', nil, (consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].outfit.Male ~= nil), { Style = RageUI.CheckboxStyle.Tick }, function()end)
					RageUI.Checkbox('Has Female Variant?', nil, (consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].outfit.Female ~= nil), { Style = RageUI.CheckboxStyle.Tick }, function()end)

					RageUI.ButtonWithStyle('~b~Set Default Outfit', (consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].default and '~o~This is already the default clock in outfit' or 'Sets the outfit as the default clock in outfit'), { RightLabel = "→→→" }, not consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].default, function(Hovered, Active, Selected)
						if Selected then
							local sure = openKeyboard('DEFAULT_JOB_OUTFIT', 'Are you sure? (type: Yes, I am sure!)')

							if sure and sure == "Yes, I am sure!" then
								TriggerServerEvent('HighLife:Jobs:SetDefaultOutfit', MenuVariables.Jobs.Key, consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].id)
							end
						end
					end)

					RageUI.ButtonWithStyle('~r~Delete Uniform', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							local sure = openKeyboard('DELETE_JOB_OUTFIT', 'Are you sure? (type: Yes, I am sure!)')

							if sure and sure == "Yes, I am sure!" then
								TriggerServerEvent('HighLife:Jobs:DeleteOutfit', MenuVariables.Jobs.Key, consolidatedOutfits[MenuVariables.Jobs.ManagementOptions.ManageOutfit].id)
							end
						end
					end)
				else
					RageUI.ButtonWithStyle('~o~Outfit Deleted!', nil, { RightLabel = nil }, true, nil)
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'equipment'), true, false, true, function()
				if MenuVariables.Jobs.Config.Equipment ~= nil then
					RageUI.ButtonWithStyle('Items', "Tools to get the job done", { RightLabel = "→→→" }, true, nil, RMenu:Get('job', 'items'))

					RageUI.ButtonWithStyle('Weapons', "Firepower for the the ~g~powers", { RightLabel = "→→→" }, true, nil, RMenu:Get('job', 'weapons'))
				end

				if consolidatedOutfits ~= nil then
					RageUI.ButtonWithStyle('Uniforms', "Threads for the occasion", { RightLabel = "→→→" }, true, nil, RMenu:Get('job', 'uniforms'))
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'items'), true, false, true, function()
				for equipmentName,equipmentData in pairs(MenuVariables.Jobs.Config.Equipment) do
					if HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank >= equipmentData.rank then
						local canAdd = true

						if equipmentData.rank_attribute ~= nil then
							canAdd = false

							if HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data[equipmentData.rank_attribute] ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data[equipmentData.rank_attribute] then
								canAdd = true
							end
						end

						if canAdd or HighLife.Player.Debug then
							if not string.match(equipmentData.item, 'WEAPON_') then
								RageUI.ButtonWithStyle(equipmentData.name, equipmentData.description or nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
									if Selected then
										TriggerServerEvent('HighLife:Jobs:GiveItem', MenuVariables.Jobs.Key, equipmentName)
									end
								end)
							end
						end
					end
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'uniforms'), true, false, true, function()
				for outfitKey,outfitData in pairs(consolidatedOutfits) do
					if HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank >= outfitData.rank then
						local canAdd = true

						if outfitData.rank_attribute ~= nil then
							canAdd = false

							if HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data[outfitData.rank_attribute] ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data[outfitData.rank_attribute] then
								canAdd = true
							end
						end

						if canAdd or HighLife.Player.Debug then
							if outfitData.outfit[(isMale() and 'Male' or 'Female')] ~= nil then
								outfitData.menu = NativeUI.CreateItem(outfitData.name, outfitData.description or '')

								RageUI.ButtonWithStyle(outfitData.name, outfitData.description or nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
									if Selected then
										HighLife:SetOverrideClothing(outfitData.outfit)
									end
								end)
							end
						end
					end
				end
			end)

			RageUI.IsVisible(RMenu:Get('job', 'weapons'), true, false, true, function()
				for equipmentName,equipmentData in pairs(MenuVariables.Jobs.Config.Equipment) do
					if equipmentData.rank == nil or (HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].rank >= equipmentData.rank) then
						local canAdd = true

						if equipmentData.rank_attribute ~= nil then
							canAdd = false

							if HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data[equipmentData.rank_attribute] ~= nil and HighLife.Other.JobStatData.current[MenuVariables.Jobs.Key].data[equipmentData.rank_attribute] then
								canAdd = true
							end
						end

						if canAdd or HighLife.Player.Debug then
							if string.match(equipmentData.item, 'WEAPON_') then
								RageUI.ButtonWithStyle(equipmentData.name, equipmentData.description or nil, { RightLabel = "→→→" }, (not HasPedGotWeapon(HighLife.Player.Ped, equipmentData.item, false)), function(Hovered, Active, Selected)
									if Selected then
										HighLife:WeaponGate()

										TriggerServerEvent('HighLife:Jobs:GiveItem', MenuVariables.Jobs.Key, equipmentName)

										if equipmentData.extras ~= nil then
											CreateThread(function()
												Wait(1000)

												for i=1, #equipmentData.extras do
													GiveWeaponComponentToPed(HighLife.Player.Ped, GetHashKey(equipmentData.item), GetHashKey(equipmentData.extras[i]))
												end
											end)
										end
									end
								end)
							end
						end
					end
				end
			end)
		end

		Wait(1)
	end
end)