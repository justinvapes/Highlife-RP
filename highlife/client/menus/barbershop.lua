RMenu.Add('barbershop', 'main', RageUI.CreateMenu('Barbershop', 'I like your cut, ~y~G'))
RMenu.Add('barbershop', 'subsection', RageUI.CreateSubMenu(RMenu:Get('barbershop', 'main'), nil, nil))
RMenu:Get('barbershop', 'subsection').EnableMouse = true

local SkinCamera = nil
local thisAngle = 90.0
local CamHeading = 90.0

function CreateBarberCam()
	if not DoesCamExist(SkinCamera) then
		SkinCamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(SkinCamera, true)
	RenderScriptCams(true, true, 500, true, true)
	SetCamRot(SkinCamera, 0.0, 0.0, 270.0, true)
end

function DeleteBarberCam()  
	SetCamActive(SkinCamera, false)
	RenderScriptCams(false, true, 500, true, true)

	SkinCamera = nil

	ClearFocus()
end

CreateThread(function()
	local isIncrease = false

	local thisAngle = 90.0
	local CamHeading = 90.0

	local BarbershopAppearance = nil

	for shopIndex,shopData in pairs(Config.Barbershop.Stores) do
		if shopData.Blip ~= nil and shopData.Locations ~= nil then
			for i=1, #shopData.Locations do
				local thisBlip = AddBlipForCoord(shopData.Locations[i])

				SetBlipDisplay(thisBlip, 4)
				SetBlipSprite(thisBlip, 71)
				SetBlipColour(thisBlip, 4)
				SetBlipScale(thisBlip, 0.8)
				SetBlipAsShortRange(thisBlip, true)

				local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

				AddTextEntry(thisEntry, 'Barbershop')
				
				BeginTextCommandSetBlipName(thisEntry)
				EndTextCommandSetBlipName(thisBlip)
			end
		end
	end

	while true do
		if MenuVariables.Barbershop.CurrentStore ~= nil then
			RageUI.IsVisible(RMenu:Get('barbershop', 'main'), true, false, true, function()
				if MenuVariables.Barbershop.CurrentStore ~= nil then
					RageUI.ButtonWithStyle('Shop Cuts', 'Get a new cut', {}, true, function(Hovered, Active, Selected)
						if Selected then
							if BarbershopAppearance == nil then
								BarbershopAppearance = deepcopy(HighLife.Player.VariablesSkin.Appearance)
							end
						end
					end, RMenu:Get('barbershop', 'subsection'))

					if BarbershopAppearance ~= nil then
						local thisPrice = 0

						for itemName,itemData in pairs(BarbershopAppearance) do
							if itemData.Index ~= nil and itemData.Index ~= HighLife.Player.VariablesSkin.Appearance[itemName].Index then
								thisPrice = thisPrice + Config.Barbershop.BasePrice
							end

							if itemData.Opacity ~= nil and itemData.Opacity ~= HighLife.Player.VariablesSkin.Appearance[itemName].Opacity then
								thisPrice = thisPrice + Config.Barbershop.BasePrice
							end

							if itemData.Color ~= nil then
								if itemData.Color.Primary ~= nil and itemData.Color.Primary.CurrentIndex ~= HighLife.Player.VariablesSkin.Appearance[itemName].Color.Primary.CurrentIndex then
									thisPrice = thisPrice + Config.Barbershop.BasePrice
								end

								if itemData.Color.Secondary ~= nil and itemData.Color.Secondary.CurrentIndex ~= HighLife.Player.VariablesSkin.Appearance[itemName].Color.Secondary.CurrentIndex then
									thisPrice = thisPrice + Config.Barbershop.BasePrice
								end
							end
						end

						if thisPrice > 0 then
							RageUI.ButtonWithStyle('~g~Purchase Makeover', "What're you waiting for? Spend some ~g~green~s~!", { RightLabel = '$' .. thisPrice, Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, true, function(Hovered, Active, Selected)
								if Selected then
									HighLife:ServerCallback('HighLife:Purchase', function(hasPaid)
										if hasPaid then
											PlayBoughtSound()

											HighLife.Skin:OverrideAppearance(BarbershopAppearance, true)

											BarbershopAppearance = nil

											Notification_AboveMap('~g~Excellent choice~s~, come back soon!')
										else
											Notification_AboveMap('You ~o~cannot afford ~s~to purchase the makeover')
										end
									end, thisPrice)
								end
							end)
						end
					end
				end
			end)

			RageUI.IsVisible(RMenu:Get('barbershop', 'subsection'), true, false, true, function()
				DisablePlayerFiring(HighLife.Player.Id, false)

				RageUI.List("Hair", Config.Skin.Appearance.Hair.Options[HighLife.Player.VariablesSkin.Gender], BarbershopAppearance.Hair.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
					if Active then
						BarbershopAppearance.MenuIndex = 'Hair'

						if BarbershopAppearance.Hair.Index ~= Index then
							isIncrease = (Index > BarbershopAppearance.Hair.Index)

							BarbershopAppearance.Hair.Index = Index

							while Config.Skin.Appearance.Hair.Options[HighLife.Player.VariablesSkin.Gender][BarbershopAppearance.Hair.Index].Disable do
								BarbershopAppearance.Hair.Index = BarbershopAppearance.Hair.Index + (isIncrease and 1 or -1)
							end

							HighLife:SetOverrideAppearance(BarbershopAppearance)
						end
					end
				end)

				RageUI.List("Eyebrows", Config.Skin.Appearance.Eyebrows.Options, BarbershopAppearance.Eyebrows.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
					if Active then
						BarbershopAppearance.MenuIndex = 'Eyebrows'

						if BarbershopAppearance.Eyebrows.Index ~= Index then
							BarbershopAppearance.Eyebrows.Index = Index

							HighLife:SetOverrideAppearance(BarbershopAppearance)
						end
					end
				end)

				RageUI.List("Facial Hair", Config.Skin.Appearance.FacialHair.Options, BarbershopAppearance.FacialHair.Index, nil, {}, isMale(), function(Hovered, Active, Selected, Index)
					if Active then
						BarbershopAppearance.MenuIndex = 'FacialHair'

						if BarbershopAppearance.FacialHair.Index ~= Index then
							BarbershopAppearance.FacialHair.Index = Index

							HighLife:SetOverrideAppearance(BarbershopAppearance)
						end
					end
				end)

				RageUI.List("Makeup", Config.Skin.Appearance.Makeup.Options, BarbershopAppearance.Makeup.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
					if Active then
						BarbershopAppearance.MenuIndex = 'Makeup'

						if BarbershopAppearance.Makeup.Index ~= Index then
							BarbershopAppearance.Makeup.Index = Index

							HighLife:SetOverrideAppearance(BarbershopAppearance)
						end
					end
				end)

				RageUI.List("Lipstick", Config.Skin.Appearance.Lipstick.Options, BarbershopAppearance.Lipstick.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
					if Active then
						BarbershopAppearance.MenuIndex = 'Lipstick'

						if BarbershopAppearance.Lipstick.Index ~= Index then
							BarbershopAppearance.Lipstick.Index = Index

							HighLife:SetOverrideAppearance(BarbershopAppearance)
						end
					end
				end)

				if BarbershopAppearance.MenuIndex ~= nil and BarbershopAppearance[BarbershopAppearance.MenuIndex] ~= nil and Config.Skin.Appearance[BarbershopAppearance.MenuIndex].Opacity ~= nil and Config.Skin.Appearance[BarbershopAppearance.MenuIndex].Opacity then				
					RageUI.PercentagePanel(BarbershopAppearance[BarbershopAppearance.MenuIndex].Opacity, "Opacity", "0%", "100%", function(Hovered, Active, Percent)
						if BarbershopAppearance[BarbershopAppearance.MenuIndex].Opacity ~= Percent then
							BarbershopAppearance[BarbershopAppearance.MenuIndex].Opacity = Percent

							HighLife:SetOverrideAppearance(BarbershopAppearance)
						end
					end)
				end

				if BarbershopAppearance.MenuIndex ~= nil and BarbershopAppearance[BarbershopAppearance.MenuIndex] ~= nil and Config.Skin.Appearance[BarbershopAppearance.MenuIndex].Color ~= nil and Config.Skin.Appearance[BarbershopAppearance.MenuIndex].Color then
					if BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Primary ~= nil then
						RageUI.ColourPanel("Primary Color", RageUI.PanelColour.HairCut, BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Primary.MinimumIndex, BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Primary.CurrentIndex, function(Hovered, Active, MinimumIndex, CurrentIndex)
							if BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Primary.CurrentIndex ~= CurrentIndex then
								BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Primary.MinimumIndex = MinimumIndex
								BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Primary.CurrentIndex = CurrentIndex
								
								HighLife:SetOverrideAppearance(BarbershopAppearance)
							end
						end)
					end

					if BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Secondary ~= nil then
						RageUI.ColourPanel("Secondary Color", RageUI.PanelColour.HairCut, BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Secondary.MinimumIndex, BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Secondary.CurrentIndex, function(Hovered, Active, MinimumIndex, CurrentIndex)
							if BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Secondary.CurrentIndex ~= CurrentIndex then
								BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Secondary.MinimumIndex = MinimumIndex
								BarbershopAppearance[BarbershopAppearance.MenuIndex].Color.Secondary.CurrentIndex = CurrentIndex
								
								HighLife:SetOverrideAppearance(BarbershopAppearance)
							end
						end)
					end
				end
			end)
		end

		if not HighLife.Player.CD and not HighLife.Player.InCharacterMenu then
			if MenuVariables.Barbershop.CurrentStore ~= nil then
				if HighLife.Player.Job.CurrentJob ~= nil then
					DisplayHelpText('You cannot change your cut while on the job!')
				else
					if not RageUI.Visible(RMenu:Get('barbershop', 'main')) and not RageUI.Visible(RMenu:Get('barbershop', 'subsection')) then
						DisplayHelpText('Press ~INPUT_PICKUP~ to browse ~y~new styles')

						if IsKeyboard() and IsControlJustReleased(0, 38) then
							RageUI.Visible(RMenu:Get('barbershop', 'main'), true)
						end
					end
				end
			else
				if RageUI.Visible(RMenu:Get('barbershop', 'main')) or RageUI.Visible(RMenu:Get('barbershop', 'subsection')) then
					RageUI.CloseAll()
				end

				if BarbershopAppearance ~= nil then
					BarbershopAppearance = nil

					HighLife:ResetOverrideAppearance()
				end
			end
		end

		if RageUI.Visible(RMenu:Get('barbershop', 'subsection')) then
			TaskStandStill(HighLife.Player.Ped, -1)
			DisablePlayerFiring(HighLife.Player.Id, false)

			DisplayHelpText('Press ~INPUT_VEH_FLY_ROLL_LEFT_ONLY~ and ~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~ to rotate the camera.~n~Alternatively, use ~INPUT_MOVE_LEFT_ONLY~ and ~INPUT_MOVE_RIGHT_ONLY~ to rotate')

			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)

			DisableControlAction(0, 177, true)
			DisableControlAction(0, 200, true)
			DisableControlAction(0, 202, true)
			DisableControlAction(0, 322, true)

			DisableControlAction(0, 18, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 96, true)

			DisableControlAction(0, 25, true)
			DisableControlAction(0, 69, true)
			DisableControlAction(0, 92, true)
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 122, true)
			DisableControlAction(0, 135, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 144, true)
			DisableControlAction(0, 168, true)
			DisableControlAction(0, 176, true)

			if not DoesCamExist(SkinCamera) then
				CreateBarberCam()
			else
				if IsControlPressed(0, 108) or IsDisabledControlPressed(0, 34) then
					thisAngle = thisAngle - 1
				elseif IsControlPressed(0, 109) or IsDisabledControlPressed(0, 35) then
					thisAngle = thisAngle + 1
				end

				if thisAngle > 360 then
					thisAngle = thisAngle - 360
				elseif thisAngle < 0 then
					thisAngle = thisAngle + 360
				end

				CamHeading = thisAngle + 0.0

				local heightOffset = 0.65
				local zoomOffset = 0.6

				local CamAngle = CamHeading * math.pi / 180.0

				local angleToLook = CamHeading - 180.0

				if angleToLook > 360 then
					angleToLook = angleToLook - 360
				elseif angleToLook < 0 then
					angleToLook = angleToLook + 360
				end

				angleToLook = angleToLook * math.pi / 180.0

				SetCamCoord(SkinCamera, HighLife.Player.Pos.x + (zoomOffset * math.cos(CamAngle)), HighLife.Player.Pos.y + (zoomOffset * math.sin(CamAngle)), HighLife.Player.Pos.z + heightOffset)
				
				PointCamAtCoord(SkinCamera, HighLife.Player.Pos.x + (zoomOffset * math.cos(angleToLook)), HighLife.Player.Pos.y + (zoomOffset * math.sin(angleToLook)), HighLife.Player.Pos.z + heightOffset)
			end
		else
			if DoesCamExist(SkinCamera) then
				DeleteBarberCam()

				ClearPedTasks(HighLife.Player.Ped)
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	while true do
		MenuVariables.Barbershop.CurrentStore = nil

		if not HighLife.Player.InVehicle then
			for k,v in pairs(Config.Barbershop.Stores) do
				for i=1, #v.Locations do
					if Vdist(HighLife.Player.Pos, v.Locations[i]) < 15.0 and GetInteriorFromEntity(HighLife.Player.Ped) ~= 0 then
						MenuVariables.Barbershop.CurrentStore = v

						break
					end
				end

				if MenuVariables.Barbershop.CurrentStore then
					break
				end
			end
		end

		Wait(1000)
	end
end)