RMenu.Add('jobs', 'police', RageUI.CreateMenu('LSPD', "~b~Obey and survive"))

RMenu.Add('jobs', 'police_citizen', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police'), 'LSPD', nil))
RMenu.Add('jobs', 'police_vehicle', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police'), 'LSPD', nil))
RMenu.Add('jobs', 'police_objects', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police'), 'LSPD', nil))
RMenu.Add('jobs', 'police_licenses', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police'), 'LSPD', nil))
RMenu.Add('jobs', 'police_processing', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police'), 'LSPD', nil))

RMenu.Add('jobs', 'police_icu', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police_processing'), 'LSPD', nil))
RMenu.Add('jobs', 'police_jail', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police_processing'), 'LSPD', nil))
RMenu.Add('jobs', 'police_morgue', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police_processing'), 'LSPD', nil))
RMenu.Add('jobs', 'police_warrant', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police_processing'), 'LSPD', nil))

RMenu.Add('jobs', 'police_k9', RageUI.CreateMenu("K9", "~g~Your bundle of joy"))
RMenu.Add('jobs', 'police_k9_anims', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police_k9'), 'K9', nil))

RMenu.Add('jobs', 'police_cordon', RageUI.CreateSubMenu(RMenu:Get('jobs', 'police_citizen'), 'Cordon', nil))

local PermRemoveLicense = false

CreateThread(function()
	local inAnyCordon = false
	local lastCordonTime = nil
	local hasTrackerOptions = false

	local cordonData = {
		first_pos = nil,
		second_pos = nil
	}

	while true do
		if IsAnyJobs({'fib', 'police'}) then
			inAnyCordon = false

			hasTrackerOptions = false
			
			RageUI.IsVisible(RMenu:Get('jobs', 'police'), true, false, true, function()
				RageUI.ButtonWithStyle('Drag', 'Drag the person in front of you or remove someone from a vehicle', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						SetDragClosestPlayer()
					end
				end)

				RageUI.ButtonWithStyle('Handcuff Person', 'Place someone in handcuffs', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.0 then
							if not IsPedSprinting(HighLife.Player.Ped) then
								TriggerServerEvent('HighLife:Player:MeAction', 'places in handcuffs')

								RequestAnimDict('mp_arrest_paired')

								while not HasAnimDictLoaded('mp_arrest_paired') do
									Wait(1)
								end

								TaskPlayAnim(HighLife.Player.Ped, 'mp_arrest_paired', 'cop_p3_fwd', 10.0, -8.0, -1, 48, 0, false, false, false)

								RemoveAnimDict('mp_arrest_paired')

								TriggerServerEvent('HighLife:Player:Cuff', GetPlayerServerId(player))
							end
						else
							Notification_AboveMap('~r~Nobody nearby to cuff')
						end
					end
				end)

				RageUI.ButtonWithStyle('Tighten Handcuffs', 'Kinky', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.0 then
							TriggerServerEvent('HighLife:Player:MeAction', 'tightens handcuffs')

							TriggerServerEvent('HighLife:Player:CuffTighten', GetPlayerServerId(player))

							RequestAnimDict('mp_arresting')

							while not HasAnimDictLoaded('mp_arresting') do
								Wait(1)
							end

							TaskPlayAnim(HighLife.Player.Ped, 'mp_arresting', 'a_uncuff', 10.0, -8.0, -1, 48, 0, false, false, false)

							SetTimeout(3000, function()
								ClearPedTasks(HighLife.Player.Ped)
							end)

							RemoveAnimDict('mp_arresting')
						else
							Notification_AboveMap('~r~Nobody nearby to tighten cuffs')
						end
					end
				end)

				RageUI.ButtonWithStyle('Remove Handcuffs', 'Remove someone from handcuffs', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.0 then
							TriggerServerEvent('HighLife:Player:MeAction', 'removes from handcuffs')

							RequestAnimDict('mp_arresting')

							while not HasAnimDictLoaded('mp_arresting') do
								Wait(1)
							end

							TaskPlayAnim(HighLife.Player.Ped, 'mp_arresting', 'a_uncuff', 10.0, -8.0, -1, 48, 0, false, false, false)

							RemoveAnimDict('mp_arresting')

							TriggerServerEvent('HighLife:Player:UnCuff', GetPlayerServerId(player))
						else
							Notification_AboveMap('~r~Nobody nearby to cuff')
						end
					end
				end)

				RageUI.Separator()

				RageUI.ButtonWithStyle('~y~Citizen Actions', "Lay down injustice", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_citizen'))
				RageUI.ButtonWithStyle('~b~Vehicle Actions', "Ronnie is on ~y~standby", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_vehicle'))
				RageUI.ButtonWithStyle('~o~Processing Actions', "Don't fuck it up!", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_processing'))

				RageUI.Separator()

				RageUI.ButtonWithStyle('Object Menu', "Allows for placing objects", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_objects'))

				if HighLife.Player.Debug or HasJobAttribute('police', 'doa') then
					if not hasTrackerOptions then
						RageUI.Separator()
					end

					hasTrackerOptions = true

					RageUI.Checkbox('DOA Mode', "~b~Switches tracker to DOA mode", MenuVariables.Police.DOA, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						if Active then
							MenuVariables.Police.DOA = not MenuVariables.Police.DOA

							TriggerServerEvent('HighLife:Group:SetAttribute', (MenuVariables.Police.DOA and 'doa' or nil))
						end
					end)
				end

				if HighLife.Player.Debug or HasJobAttribute('police', 'swat') then
					if not hasTrackerOptions then
						RageUI.Separator()
					end

					hasTrackerOptions = true

					RageUI.Checkbox('SWAT Mode', "~b~Switches tracker to SWAT mode", MenuVariables.Police.SWAT, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						if Active then
							MenuVariables.Police.SWAT = not MenuVariables.Police.SWAT

							TriggerServerEvent('HighLife:Group:SetAttribute', (MenuVariables.Police.SWAT and 'swat' or nil))
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.police.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('police')
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_objects'), true, false, true, function()
				for k,v in pairs(Config.Police.Objects) do
					RageUI.ButtonWithStyle('Place ' .. v.name, "Places the object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							CreatePropOnGround(v.object, v.freeze)
						end
					end)
				end

				RageUI.ButtonWithStyle('Remove Closest Object', "Removes the closest object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						for k,v in pairs(Config.Police.Objects) do
							local closestObj = GetClosestObjectOfType(HighLife.Player.Pos, 3.0, v.object, false, true, false)

							if closestObj ~= 0 then
								TriggerServerEvent('HighLife:Entity:Delete', NetworkGetNetworkIdFromEntity(closestObj))

								break
							end
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_citizen'), true, false, true, function()
				RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:GetClosestPlayerID()
					end
				end)

				RageUI.ButtonWithStyle('Frisk Suspect', 'To find weapons and other bulges', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:Player:MeAction', 'pats down suspect')

						RageUI.CloseAll()

						Wait(2000)

						HighLife:PoliceSearchPlayer(true)
					end
				end)

				RageUI.ButtonWithStyle('Cavity Search Suspect', 'Have you read them their rights?', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:Player:MeAction', 'searches suspect')

						RageUI.CloseAll()

						Wait(3000)

						HighLife:PoliceSearchPlayer()
					end
				end)

				RageUI.ButtonWithStyle('Examine Patient', 'Examine a patient injuries', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local nearPlayer, distance = GetClosestPlayer()
			
						if distance ~= -1 and distance <= 3.0 and not HighLife.Player.InVehicle then	
							TriggerServerEvent('HighLife:Player:MeAction', 'examines patients for injuries')

							TriggerServerEvent('HighLife:Player:DeathReason', GetPlayerServerId(nearPlayer))
						end
					end
				end)

				RageUI.ButtonWithStyle('Stabilize Patient', 'Stabilize a patient', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							if IsHighLifeGradeDead(GetPlayerPed(player)) then
								CreateThread(function()
									Notification_AboveMap('~o~Stabilizing patient')
									
									TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									
									Wait(10000)
									
									ClearPedTasks(HighLife.Player.Ped)
									
									TriggerServerEvent('HighLife:EMS:Stabilize', GetPlayerServerId(player))
									
									Notification_AboveMap('~g~Patient has been stabilized')
								end)
							end
						else
							Notification_AboveMap('~r~Nobody nearby to stabilize')
						end
					end
				end)

				RageUI.ButtonWithStyle('Revive Patient', 'The infamous button...', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							if IsHighLifeGradeDead(GetPlayerPed(player)) then
								HighLife:ServerCallback('HighLife:RemoveItem', function(validRemove)
									if validRemove then
										CreateThread(function()							
											TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
											
											Wait(10000)

											-- TriggerServerEvent('HighLife:Player:MeAction', 'helps patient to their feet')
											
											ClearPedTasks(HighLife.Player.Ped)
											
											TriggerServerEvent('HighLife:EMS:Revive', GetPlayerServerId(player))
										end)
									else
										Notification_AboveMap("~o~You don't have any items to help the patient with")
									end
								end, 'medical_kit', 1)

							end
						else
							Notification_AboveMap('~r~Nobody nearby to revive')
						end
					end
				end)

				RageUI.ButtonWithStyle('Create Cordon', 'Blocks off a rectangled area', { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_cordon'))

				RageUI.ButtonWithStyle('Body Bag Body', 'With grace', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerEvent('HBodyBag:bagLocal')
					end
				end)

				RageUI.ButtonWithStyle('Place Suspect on bed', 'Move the suspect to the bed', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 4.0 then
							TriggerServerEvent('HighLife:Player:StopDrag', GetPlayerServerId(player))
							
							TriggerServerEvent("HighLife:Player:ClosestBed", GetPlayerServerId(player))
						else
							Notification_AboveMap('~r~Nobody nearby to set into the bed')
						end
					end
				end)

				RageUI.ButtonWithStyle('Check Serial Numbers', 'Check money for illegal bills', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							TriggerServerEvent("HighLife:Police:TestMoney", GetPlayerServerId(player))
						else
							Notification_AboveMap('~r~Nobody nearby')
						end

						RageUI.CloseAll()
					end
				end)

				RageUI.ButtonWithStyle('Breathalyzer', "A little drinky-poo", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							CreateThread(function()
								Notification_AboveMap('~o~Breathalyzing person')
								
								TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
								
								Wait(10000)
								
								ClearPedTasks(HighLife.Player.Ped)
								
								TriggerServerEvent('HighLife:Player:Breathalyze', GetPlayerServerId(player))
							end)
						else
							Notification_AboveMap('~r~Nobody nearby to breathalyze')
						end
					end
				end)

				RageUI.ButtonWithStyle('Revoke Licenses', "Back to school they go!", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						PermRemoveLicense = false
					end
				end, RMenu:Get('jobs', 'police_licenses'))

				if HighLife.Player.Job.rank >= Config.Jobs.police.MiscRankOptions.PermRevokeRank then
					RageUI.ButtonWithStyle('Perm Revoke Licenses', "Back to ~o~nowhere ~s~they go!", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							PermRemoveLicense = true
						end
					end, RMenu:Get('jobs', 'police_licenses'))
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_licenses'), true, false, true, function()
				for k,v in pairs(Config.Licenses) do
					if v.name ~= nil then
						RageUI.ButtonWithStyle(v.name .. ' License', 'Remove the persons ' .. v.name .. ' license', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								HighLife:PoliceRevokeLicense(k, PermRemoveLicense)
							end
						end)
					end
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_cordon'), true, false, true, function()
				inAnyCordon = false

				if HighLife.Player.MiscSync.Cordons ~= nil then
					for i=1, #HighLife.Player.MiscSync.Cordons do
						if IsEntityInArea(HighLife.Player.Ped, vector3(HighLife.Player.MiscSync.Cordons[i].first_pos), vector3(HighLife.Player.MiscSync.Cordons[i].second_pos), true, true, 0) then
							inAnyCordon = true

							break
						end
					end
				end

				if not inAnyCordon then
					RageUI.ButtonWithStyle('Set Corner', 'Start of the cordon', { RightLabel = (cordonData.first_pos ~= nil and '~g~SET' or "→→→") }, true, function(Hovered, Active, Selected)
						if Selected then
							cordonData.first_pos = (vector3(HighLife.Player.Pos) - vector3(0.0, 0.0, 50.0))
						end
					end)

					RageUI.ButtonWithStyle('Set Opposite Corner', 'The opposite corner to the start position, think like a rectangle', { RightLabel = (cordonData.second_pos ~= nil and '~g~SET' or "→→→") }, true, function(Hovered, Active, Selected)
						if Selected then
							if Vdist(cordonData.first_pos, HighLife.Player.Pos) < 333.0 then
								cordonData.second_pos = (vector3(HighLife.Player.Pos) + vector3(0.0, 0.0, 50.0))
							else
								Notification_AboveMap('~r~Cordon is too big!')
							end
						end
					end)

					RageUI.ButtonWithStyle('Start Cordon', ((HighLife.Player.Debug or (GameTimerPool.GlobalGameTime > GameTimerPool.MiscSync)) and 'Sets the cordon in motion' or 'Not possible right now, please wait'), { RightLabel = "→→→" }, (cordonData.first_pos ~= nil and cordonData.second_pos ~= nil and (HighLife.Player.Debug or (GameTimerPool.GlobalGameTime > GameTimerPool.MiscSync))), function(Hovered, Active, Selected)
						if Selected then
							local newCordonData = deepcopy(HighLife.Player.MiscSync.Cordons)

							table.insert(newCordonData, {
								first_pos = cordonData.first_pos,
								second_pos = cordonData.second_pos
							})

							TriggerServerEvent('HighLife:MiscGlobals:SetSyncedGlobal', 'Cordons', json.encode(newCordonData))

							cordonData = {
								first_pos = nil,
								second_pos = nil
							}
						end
					end)
				else
					RageUI.ButtonWithStyle('Remove Cordon', ((HighLife.Player.Debug or (GameTimerPool.GlobalGameTime > GameTimerPool.MiscSync)) and 'Removes the closest cordon' or 'Not possible right now, please wait'), { RightLabel = "→→→" }, (HighLife.Player.Debug or (GameTimerPool.GlobalGameTime > GameTimerPool.MiscSync)), function(Hovered, Active, Selected)
						if Selected then
							local closest = {
								closest = nil,
								distance = nil
							}

							for i=1, #HighLife.Player.MiscSync.Cordons do								
								if closest.distance ~= nil then
									if Vdist(HighLife.Player.Pos, vector3(HighLife.Player.MiscSync.Cordons[i].first_pos)) < closest.distance then
										closest = {
											closest = i,
											distance = Vdist(HighLife.Player.Pos, vector3(HighLife.Player.MiscSync.Cordons[i].first_pos))
										}
									end
								else
									closest = {
										closest = i,
										distance = Vdist(HighLife.Player.Pos, vector3(HighLife.Player.MiscSync.Cordons[i].first_pos))
									}
								end
							end

							if closest.closest ~= nil then
								table.remove(HighLife.Player.MiscSync.Cordons, closest.closest)

								TriggerServerEvent('HighLife:MiscGlobals:SetSyncedGlobal', 'Cordons', json.encode(HighLife.Player.MiscSync.Cordons))
							end
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_vehicle'), true, false, true, function()
				RageUI.ButtonWithStyle('Place in Vehicle', 'Place someone in a vehicle', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.0 then
							local vehicle = GetClosestVehicleEnumerated(3.0)
							local playerId = GetPlayerServerId(player)

							if vehicle ~= nil then
								TriggerServerEvent('HighLife:Player:MeAction', 'places in vehicle')

								TriggerEvent('HighLife:Player:PlaceInVehicle', playerId)

								Notification_AboveMap('~y~Person has been placed in the vehicle')
							else
								Notification_AboveMap('~r~No vehicle nearby')
							end
						else
							Notification_AboveMap('~r~Nobody nearby to put in vehicle')
						end
					end
				end)

				RageUI.ButtonWithStyle('Impound Vehicle', 'Get Ronnie on the job', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local impound_price = openKeyboard('IMPOUND_PRICE', 'Enter the Impound price (Max: $' .. Config.Impound.MaxImpoundPrice .. ')', 8)
						local impound_days = openKeyboard('IMPOUND_DAYS', 'Enter the Impound days (Max: ' .. Config.Impound.MaxImpoundTime .. ' days)', 8)

						local thisImpoundDays = 0

						if impound_days ~= nil and tonumber(impound_days) ~= nil then
							thisImpoundDays = tonumber(impound_days)
						end

						if tonumber(impound_price) ~= nil and tonumber(impound_price) then
							HighLife:RonnieImpoundVehicle(tonumber(impound_price), thisImpoundDays)
						end
					end
				end)

				RageUI.ButtonWithStyle('Force Entry to Vehicle', 'Brute force, I like it', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerEvent('HighLife:Items:Lockpick', true)
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_processing'), true, false, true, function()
				RageUI.ButtonWithStyle('Jail', "Put someone in the pen", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_jail'))
				RageUI.ButtonWithStyle('ICU', "Put someone in PJ's", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_icu'))
				RageUI.ButtonWithStyle('Morgue', "Put someone in the grave", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_morgue'))

				if HighLife.Player.Job.rank >= Config.Jobs.police.MiscRankOptions.WarrantRank then
					RageUI.Separator()

					RageUI.ButtonWithStyle('Request Warrant', "For the knock knock bang bang techique", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_warrant'))
				end

				RageUI.Separator()

				RageUI.ButtonWithStyle('Fine (Funeral Costs)', "\"you can't fine a dead body\"~n~~n~~y~hold that", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						HighLife:FinePlayer(-1, false)

						RageUI.CloseAll()
					end
				end)

				RageUI.ButtonWithStyle('Fine (Criminal Charge)', "Hit em' where it hurts", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						HighLife:FinePlayer(-1, false)

						RageUI.CloseAll()
					end
				end)
			end)

			-- WARRANT
			RageUI.IsVisible(RMenu:Get('jobs', 'police_warrant'), true, false, true, function()
				RageUI.ButtonWithStyle('Suspect Name', 'The full name of the suspect', { RightLabel = (MenuVariables.Police.Warrant.Person ~= nil and MenuVariables.Police.Warrant.Person or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('WARRANT_PERSON', 'The full name of the suspect', nil, MenuVariables.Police.Warrant.Person)

						if input ~= nil then
							MenuVariables.Police.Warrant.Person = input
						end
					end
				end)

				RageUI.ButtonWithStyle('Reason', '~y~The reason for the warrant' .. (MenuVariables.Police.Warrant.Reason ~= nil and '~s~:~n~~n~' .. MenuVariables.Police.Warrant.Reason or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('WARRANT_REASON', 'Reason for the warrant', nil, MenuVariables.Police.Warrant.Reason)

						if input ~= nil then
							MenuVariables.Police.Warrant.Reason = input
						end
					end
				end)

				RageUI.ButtonWithStyle('Crime #1', '~y~Information for the first crime - if available' .. (MenuVariables.Police.Warrant.Crime_1 ~= nil and '~s~: ~n~~n~' .. MenuVariables.Police.Warrant.Crime_1 or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('WARRANT_REASON', 'Reason for the warrant', nil, MenuVariables.Police.Warrant.Crime_1)

						if input ~= nil then
							MenuVariables.Police.Warrant.Crime_1 = input
						end
					end
				end)

				RageUI.ButtonWithStyle('Crime #2', '~y~Information for the first crime - if available' .. (MenuVariables.Police.Warrant.Crime_2 ~= nil and '~s~: ~n~~n~' .. MenuVariables.Police.Warrant.Crime_2 or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('WARRANT_REASON', 'Reason for the warrant', nil, MenuVariables.Police.Warrant.Crime_2)

						if input ~= nil then
							MenuVariables.Police.Warrant.Crime_2 = input
						end
					end
				end)

				RageUI.ButtonWithStyle('Crime #3', '~y~Information for the first crime - if available' .. (MenuVariables.Police.Warrant.Crime_3 ~= nil and '~s~: ~n~~n~' .. MenuVariables.Police.Warrant.Crime_3 or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('WARRANT_REASON', 'Reason for the warrant', nil, MenuVariables.Police.Warrant.Crime_3)

						if input ~= nil then
							MenuVariables.Police.Warrant.Crime_3 = input
						end
					end
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Police.Warrant.Reason ~= nil and MenuVariables.Police.Warrant.Person ~= nil) and '~g~' or '~r~') .. 'Submit Request', "Into the void!", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if MenuVariables.Police.Warrant.Reason ~= nil and MenuVariables.Police.Warrant.Person ~= nil then
							if HighLife.Player.Discord ~= nil then
								MenuVariables.Police.Warrant.Submitter = HighLife.Player.Discord
							else
								MenuVariables.Police.Warrant.Submitter = GetPlayerName(HighLife.Player.Id)
							end

							TriggerServerEvent('HighLife:Police:SubmitWarrant', json.encode(MenuVariables.Police.Warrant))

							MenuVariables.Police.Warrant = {
								Person = nil,
								Reason = nil,
								Crime_1 = nil,
								Crime_2 = nil,
								Crime_3 = nil
							}
						else
							Notification_AboveMap('~o~You must fill in all the required info')
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_jail'), true, false, true, function()
				RageUI.ButtonWithStyle('Citizen', 'The ID of the citizen to jail', { RightLabel = (MenuVariables.Detention.Jail.Person ~= nil and MenuVariables.Detention.Jail.Person or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('JAIL_PERSON', 'ID of the citizen to Jail', nil, MenuVariables.Detention.Jail.Person)

						if input ~= nil and tonumber(input) ~= nil then
							local thisPerson = tonumber(input)

							if GetPlayerName(GetPlayerFromServerId(thisPerson)) ~= '**Invalid**' then
								if HighLife.Player.Debug or (thisPerson ~= HighLife.Player.ServerId) then
									MenuVariables.Detention.Jail.Person = thisPerson
								else
									Notification_AboveMap('You cannot jail yourself')
								end
							else
								Notification_AboveMap('Citizen with ID: ' .. thisPerson .. ' does not ~r~exist')
							end
						end
					end
				end)

				RageUI.ButtonWithStyle('Days', 'How long to jail for', { RightLabel = (MenuVariables.Detention.Jail.Days ~= nil and MenuVariables.Detention.Jail.Days .. ' days' or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('JAIL_TIME', 'Days to spend in the jail', nil, MenuVariables.Detention.Jail.Days)

						if input ~= nil and tonumber(input) ~= nil then
							local thisTime = tonumber(input)

							if HighLife.Player.Job.name == 'police' then
								if thisTime > Config.Detention.Jail.MaxTime then
									thisTime = Config.Detention.Jail.MaxTime
								end
							end

							MenuVariables.Detention.Jail.Days = thisTime
						end
					end
				end)

				RageUI.ButtonWithStyle('Reason', '~y~The reason for the jail' .. (MenuVariables.Detention.Jail.Reason ~= nil and '~s~:~n~~n~' .. MenuVariables.Detention.Jail.Reason or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('JAIL_REASON', 'Reason for jail', nil, MenuVariables.Detention.Jail.Reason)

						if input ~= nil then
							MenuVariables.Detention.Jail.Reason = input
						end
					end
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Detention.Jail.Days ~= nil and MenuVariables.Detention.Jail.Reason ~= nil and MenuVariables.Detention.Jail.Person ~= nil) and '~g~' or '~r~') .. 'Call Prison Transport', 'Don\'t drop the soap!', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if MenuVariables.Detention.Jail.Days ~= nil and MenuVariables.Detention.Jail.Reason ~= nil and MenuVariables.Detention.Jail.Person ~= nil then
							TriggerServerEvent('HighLife:Detention:Send', 'jail', MenuVariables.Detention.Jail.Person, MenuVariables.Detention.Jail.Days, MenuVariables.Detention.Jail.Reason)

							MenuVariables.Detention.Jail = {
								Days = nil,
								Reason = nil,
								Person = nil,
							}
						else
							Notification_AboveMap('~o~You must fill in all the required info')
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_morgue'), true, false, true, function()
				RageUI.ButtonWithStyle('Citizen', 'The ID of the citizen to morgue', { RightLabel = (MenuVariables.Detention.Morgue.Person ~= nil and MenuVariables.Detention.Morgue.Person or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('MORGUE_PERSON', 'ID of the citizen to morgue', nil, MenuVariables.Detention.Morgue.Person)

						if input ~= nil and tonumber(input) ~= nil then
							local thisPerson = tonumber(input)

							if GetPlayerName(GetPlayerFromServerId(thisPerson)) ~= '**Invalid**' then
								if HighLife.Player.Debug or (thisPerson ~= HighLife.Player.ServerId) then
									MenuVariables.Detention.Morgue.Person = thisPerson
								else
									Notification_AboveMap('You cannot morgue yourself')
								end
							else
								Notification_AboveMap('Citizen with ID: ' .. thisPerson .. ' does not ~r~exist')
							end
						end
					end
				end)

				RageUI.ButtonWithStyle('Days', 'How long to morgue for', { RightLabel = (MenuVariables.Detention.Morgue.Days ~= nil and MenuVariables.Detention.Morgue.Days .. ' days' or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('MORGUE_TIME', 'Days to spend in the morgue', nil, MenuVariables.Detention.Morgue.Days)

						if input ~= nil and tonumber(input) ~= nil then
							local thisTime = tonumber(input)

							if thisTime > Config.Detention.Morgue.MaxTime then
								thisTime = Config.Detention.Morgue.MaxTime
							end

							MenuVariables.Detention.Morgue.Days = thisTime
						end
					end
				end)

				RageUI.ButtonWithStyle('Reason', '~y~The reason for the morgue' .. (MenuVariables.Detention.Morgue.Reason ~= nil and '~s~:~n~~n~' .. MenuVariables.Detention.Morgue.Reason or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('MORGUE_REASON', 'Reason for morgue', nil, MenuVariables.Detention.Morgue.Reason)

						if input ~= nil then
							MenuVariables.Detention.Morgue.Reason = input
						end
					end
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Detention.Morgue.Days ~= nil and MenuVariables.Detention.Morgue.Reason ~= nil and MenuVariables.Detention.Morgue.Person ~= nil) and '~g~' or '~r~') .. 'Call Coroner', 'Get them in the grave', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if MenuVariables.Detention.Morgue.Days ~= nil and MenuVariables.Detention.Morgue.Reason ~= nil and MenuVariables.Detention.Morgue.Person ~= nil then
							TriggerServerEvent('HighLife:Detention:Send', 'morgue', MenuVariables.Detention.Morgue.Person, MenuVariables.Detention.Morgue.Days, MenuVariables.Detention.Morgue.Reason)

							MenuVariables.Detention.Morgue = {
								Days = nil,
								Reason = nil,
								Person = nil,
							}
						else
							Notification_AboveMap('~o~You must fill in all the required info')
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_icu'), true, false, true, function()
				RageUI.ButtonWithStyle('Citizen', 'The ID of the citizen to ICU', { RightLabel = (MenuVariables.Detention.ICU.Person ~= nil and MenuVariables.Detention.ICU.Person or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('ICU_PERSON', 'ID of the citizen to ICU', nil, MenuVariables.Detention.ICU.Person)

						if input ~= nil and tonumber(input) ~= nil then
							local thisPerson = tonumber(input)

							if GetPlayerName(GetPlayerFromServerId(thisPerson)) ~= '**Invalid**' then
								if HighLife.Player.Debug or (thisPerson ~= HighLife.Player.ServerId) then
									MenuVariables.Detention.ICU.Person = thisPerson
								else
									Notification_AboveMap('You cannot ICU yourself')
								end
							else
								Notification_AboveMap('Citizen with ID: ' .. thisPerson .. ' does not ~r~exist')
							end
						end
					end
				end)

				RageUI.ButtonWithStyle('Days', 'How long to ICU for', { RightLabel = (MenuVariables.Detention.ICU.Days ~= nil and MenuVariables.Detention.ICU.Days .. ' days' or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('ICU_TIME', 'Days to spend in the ICU', nil, MenuVariables.Detention.ICU.Days)

						if input ~= nil and tonumber(input) ~= nil then
							local thisTime = tonumber(input)

							if thisTime > Config.Detention.ICU.MaxTime then
								thisTime = Config.Detention.ICU.MaxTime
							end

							MenuVariables.Detention.ICU.Days = thisTime
						end
					end
				end)

				RageUI.ButtonWithStyle('Reason', '~y~The reason for the ICU' .. (MenuVariables.Detention.ICU.Reason ~= nil and '~s~:~n~~n~' .. MenuVariables.Detention.ICU.Reason or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('ICU_REASON', 'Reason for ICU', nil, MenuVariables.Detention.ICU.Reason)

						if input ~= nil then
							MenuVariables.Detention.ICU.Reason = input
						end
					end
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Detention.ICU.Days ~= nil and MenuVariables.Detention.ICU.Reason ~= nil and MenuVariables.Detention.ICU.Person ~= nil) and '~g~' or '~r~') .. 'Place in the ICU', 'Get them tucked in bed', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if MenuVariables.Detention.ICU.Days ~= nil and MenuVariables.Detention.ICU.Reason ~= nil and MenuVariables.Detention.ICU.Person ~= nil then
							TriggerServerEvent('HighLife:Detention:Send', 'icu', MenuVariables.Detention.ICU.Person, MenuVariables.Detention.ICU.Days, MenuVariables.Detention.ICU.Reason)

							MenuVariables.Detention.ICU = {
								Days = nil,
								Reason = nil,
								Person = nil,
							}
						else
							Notification_AboveMap('~o~You must fill in all the required info')
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_k9'), true, false, true, function()
				if HighLife.Other.Pet.entity ~= nil then
					if HighLife.Other.Pet.task == 'attack' or HighLife.Other.Pet.attackTarget ~= nil then
						RageUI.ButtonWithStyle('Stop Attacking', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								if HighLife.Other.Pet.task ~= 'in_vehicle' then
									HighLife:SetPetFollow()

									HighLife.Other.Pet.attackTarget = nil
								end
							end
						end)
					end

					if HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == -1 then
						if not IsPedInAnyVehicle(HighLife.Other.Pet.entity) then
							RageUI.ButtonWithStyle('Dog in vehicle', 'Dog doo this', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
								if Selected then
									HighLife:SetPetEnterVehicle()
								end
							end)
						else
							RageUI.ButtonWithStyle('Dog out vehicle', 'Like bug out, but with a dog', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
								if Selected then
									HighLife:SetPetLeaveVehicle()
								end
							end)
						end
					else
						-- not in a vehicle
						if not IsPedInAnyVehicle(HighLife.Other.Pet.entity) then
							RageUI.ButtonWithStyle('Tricks', "No treats", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'police_k9_anims'))
						end
					end

					RageUI.ButtonWithStyle('Follow', 'Sheepish, almost', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							HighLife:SetPetFollow()
						end
					end)

					RageUI.ButtonWithStyle('Pickup', "Difficult at times", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							HighLife:RemovePet(false)

							RageUI.CloseAll()
						end
					end)
					
					RageUI.ButtonWithStyle((HighLife.Other.Pet.isSniffing and 'Stop' or 'Start') .. ' Sniffing', "Hard to stop", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							HighLife.Other.Pet.isSniffing = not HighLife.Other.Pet.isSniffing

							if not isSniffing then
								HighLife.Other.Pet.foundSniffingEntity = nil

								HighLife:SetPetFollow()
							end
						end
					end)
				else
					RageUI.ButtonWithStyle('Release the Pupper', "~b~WHO'S A GOOD BOY", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							HighLife:CreatePet('a_c_shepherd')
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'police_k9_anims'), true, false, true, function()
				for commandName,commandData in pairs(Config.Pets.Models['a_c_rottweiler'].anims) do
					if commandData.name ~= nil then
						RageUI.ButtonWithStyle(commandData.name, nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Selected then
								HighLife:SetPetAnimation(commandName)
							end
						end)
					end
				end
			end)
		end

		Wait(1)
	end
end)