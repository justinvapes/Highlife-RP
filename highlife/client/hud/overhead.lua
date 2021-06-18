local houseHide = false

function DrawText3D_Labels(x, y, z, text) -- some useful function, use it if you want!
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = GetGameplayCamCoords()

	local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)

	local scale = (4.00001 / dist) * 0.4

	if scale > 0.2 then
		scale = 0.30
	elseif scale < 0.15 then
		scale = 0.20
	end

	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextFont(4)
		SetTextScale(scale, scale)
		SetTextProportional(true)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropshadow(1, 1, 1, 1, 1)
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(_x, _y - 0.025)
	end
end

RegisterNetEvent('HLabels:DisableLabels')
AddEventHandler('HLabels:DisableLabels', function(hide)
	houseHide = hide
end)

local registered_me_index = {}

RegisterNetEvent("HLabels:showMe")
AddEventHandler("HLabels:showMe", function(playerID, message)
	CreateThread(function()
		local showMeAction = true

		if registered_me_index[playerID] == nil then
			registered_me_index[playerID] = {}
		end

		local targetPed = GetPlayerPed(GetPlayerFromServerId(playerID))

		if not DoesEntityExist(targetPed) or GetPlayerFromServerId(playerID) == -1 then
			showMeAction = false
		end

		table.insert(registered_me_index[playerID], message)

		CreateThread(function()
			local showTime = 6
			local startTime = GameTimerPool.GlobalGameTime + (showTime * 1000) 

			while GameTimerPool.GlobalGameTime < startTime do
				Wait(1)
			end

			showMeAction = false
		end)

		local targetPos = nil

		while showMeAction do
			local thisIndex = 0

			for i=1, #registered_me_index[playerID] do
				if registered_me_index[playerID][i] == message then
					thisIndex = #registered_me_index[playerID] - (i - 1)

					break
				end
			end

			-- GetPedBoneCoords(GetPlayerPed(GetPlayerFromServerId(playerID)), 79, vector3(0, 0, 1.0 + (0.15 * thisIndex)))

			targetPos = (IsPedInAnyVehicle(targetPed) and GetPedBoneCoords(targetPed, 79, vector3(0, 0, 1.0)) or GetEntityCoords(targetPed) + vector3(0, 0, 1.0 + (0.15 * thisIndex)))

			if (HighLife.Player.IsSpectating and Vdist(GetGameplayCamCoord(), targetPos) < Config.PlayerLabelDistance) or Vdist(HighLife.Player.Pos, targetPos) < Config.PlayerLabelDistance then
				DrawText3D_Labels(targetPos.x, targetPos.y, targetPos.z, message)
			end

			Wait(1)
		end

		for i=1, #registered_me_index[playerID] do
			if registered_me_index[playerID][i] == message then
				table.remove(registered_me_index[playerID], i)

				break
			end
		end
	end)
end)

CreateThread(function()
	local foundRank = -1
	local nameColor = '~c~'

	local targetPos = nil
	local targetPed = nil

	local hideID = false

	while true do
		foundRank = -1
		nameColor = '~c~'

		if not HighLife.Player.HideHUD and HighLife.Player.ZMenuOpen then
			for _,playerID in pairs(GetActivePlayers()) do
				targetPed = GetPlayerPed(playerID)

				if HighLife.Player.IsSpectating and Vdist(GetGameplayCamCoord(), GetEntityCoords(targetPed)) < 60.0 or Vdist(HighLife.Player.Pos, GetEntityCoords(targetPed)) < (HighLife.Player.IsStaff and 30.0 or 10.0) then
					foundRank = -1

					if HighLife.Player.IsSpectating or HasEntityClearLosToEntity(HighLife.Player.Ped, targetPed, 17) then
						hideID = false

						-- I did this because people pissed me off
						-- if DecorExistOn(targetPed, 'Player.Rank') then
						-- 	foundRank = DecorGetInt(targetPed, 'Player.Rank')

						-- 	if foundRank == 6 then
						-- 		hideID = true
						-- 	end
						-- end

						if HighLife.Player.IsSpectating and targetPed == HighLife.Player.Ped then
							hideID = true
						end

						if not IsAnyJobs({'police', 'fib'}) then
							if IsPedInAnyPoliceVehicle(targetPed) then
								hideID = true
							end
						end
						
						if not hideID then
							targetPos = (IsPedInAnyVehicle(targetPed) and GetPedBoneCoords(targetPed, 79, vector3(0, 0, 1.0)) or GetEntityCoords(targetPed) + vector3(0, 0, 1.0))

							if HighLife.Player.IsSpectating or Vdist(HighLife.Player.Pos, targetPos) < (HighLife.Player.IsStaff and 30.0 or Config.PlayerLabelDistance) then
								if NetworkIsPlayerTalking(playerID) then
									DrawText3D_Labels(targetPos.x, targetPos.y, targetPos.z, "~g~" .. GetPlayerServerId(playerID))
								else
									-- if foundRank ~= -1 then
									-- 	if foundRank == Config.Ranks.BronzeSupporter then
									-- 		nameColor = '~o~'
									-- 	elseif foundRank == Config.Ranks.SilverSupporter then
									-- 		nameColor = '~w~'
									-- 	elseif foundRank == Config.Ranks.GoldSupporter then
									-- 		nameColor = '~y~'
									-- 	elseif foundRank == Config.Ranks.DiamondSupporter then
									-- 		nameColor = '~b~'
									-- 	end
									-- end

									DrawText3D_Labels(targetPos.x, targetPos.y, targetPos.z, nameColor .. GetPlayerServerId(playerID))
								end
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end)