local radar = {
	shown = true,
	freeze = false,
	info = "~y~Ready",
	info2 = "~y~Ready",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1 + w, y - 0.02 + h)
end

local freezeRadar = false

local lastVehicle = {
	front = {
		vehicle = nil,
		time = 0
	},
	rear = {
		vehicle = nil,
		time = 0
	}
}

CreateThread(function()
	while true do		
		if not HighLife.Player.HideHUD and HighLife.Player.InVehicle then
			if IsPedInAnyPoliceVehicle(HighLife.Player.Ped) then			
				if HighLife.Player.VehicleClass ~= 15 and HighLife.Player.VehicleClass ~= 14 and HighLife.Player.VehicleClass ~= 13 then
					if IsKeyboard() and GetLastInputMethod(2) and IsControlJustReleased(0, 182) then -- L
						freezeRadar = not freezeRadar
					end

					local coordA = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, HighLife.Player.Vehicle, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					
					if not freezeRadar then 
						if IsEntityAVehicle(e) then
							local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
							local fvspeed = GetEntitySpeed(e)*2.236936
							local fplate = GetVehicleNumberPlateText(e)

							if lastVehicle.front.vehicle ~= e then
								lastVehicle.front.vehicle = e
								lastVehicle.front.time = GameTimerPool.GlobalGameTime
							else
								if lastVehicle.front.time ~= nil then
									if (GameTimerPool.GlobalGameTime - lastVehicle.front.time) > 7000 then
										if IsVehicleStolen(lastVehicle.front.vehicle) then
											lastVehicle.front.time = GameTimerPool.GlobalGameTime

											local notifyString = 'Radar: FRONT~n~Vehicle Plate: ~y~' .. fplate .. '~s~~n~Vehicle Model: ~y~' .. fmodel .. '~n~~s~Status: ~r~Stolen~n~~n~~o~Proceed with caution'

											ShowNotificationWithIcon(notifyString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')
										else
											if HighLife.Other.CAD_DATA ~= nil then
												local boloVehicle = nil

												for k,v in pairs(HighLife.Other.CAD_DATA.active_bolos) do
													if v.plate == fplate then
														boloVehicle = v
														break
													end
												end

												if boloVehicle ~= nil then
													lastVehicle.front.time = GameTimerPool.GlobalGameTime
													
													CreateThread(function()
														local statusString = 'Status: ~o~WANTED'

														if boloVehicle.boolcode5 then
															statusString = 'Status: ~o~WANTED ~r~(CODE 5 STOP)'
														end

														local initString = 'Radar: FRONT~n~Vehicle Plate: ~y~' .. fplate .. '~s~~n~Vehicle Model: ~y~' .. fmodel .. '~n~~s~' .. statusString .. '~s~~n~Issuing Officer: ' .. boloVehicle.officer
														local infoString = 'WARRANT REF: ~y~#' .. boloVehicle.id .. '~s~~n~Reason: ' .. boloVehicle.wanted_for .. '~n~Description: ' .. boloVehicle.description

														ShowNotificationWithIcon(initString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')

														Wait(3000)

														ShowNotificationWithIcon(infoString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')
													end)
												end
											end
										end
									end
								end
							end

							radar.info = string.format("~y~Plate: ~w~%s  ~y~Model: ~w~%s  ~y~Speed: ~w~%s mph", fplate, fmodel, math.ceil(fvspeed))
						end
						
						local bcoordB = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, -105.0, 0.0)
						local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, HighLife.Player.Vehicle, 7)
						local f, g, h, i, j = GetShapeTestResult(rearcar)
						
						if IsEntityAVehicle(j) then
							local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
							local bvspeed = GetEntitySpeed(j) * 2.236936
							local bplate = GetVehicleNumberPlateText(j)

							if lastVehicle.rear.vehicle ~= j then
								lastVehicle.rear.vehicle = j
								lastVehicle.rear.time = GameTimerPool.GlobalGameTime
							else
								if lastVehicle.rear.time ~= nil then
									if (GameTimerPool.GlobalGameTime - lastVehicle.rear.time) > 7000 then
										if IsVehicleStolen(lastVehicle.rear.vehicle) then
											lastVehicle.rear.time = GameTimerPool.GlobalGameTime

											local notifyString = 'Radar: REAR~n~Vehicle Plate: ~y~' .. bplate .. '~s~~n~Vehicle Model: ~y~' .. bmodel .. '~n~~s~Status: ~r~Stolen~n~~n~~o~Proceed with caution'

											ShowNotificationWithIcon(notifyString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')
										else
											if HighLife.Other.CAD_DATA ~= nil then
												local boloVehicle = nil

												for k,v in pairs(HighLife.Other.CAD_DATA.active_bolos) do
													if v.plate == bplate then
														boloVehicle = v
														break
													end
												end

												if boloVehicle ~= nil then
													lastVehicle.rear.time = GameTimerPool.GlobalGameTime

													CreateThread(function()
														local statusString = 'Status: ~o~WANTED'

														if boloVehicle.boolcode5 then
															statusString = 'Status: ~o~WANTED ~r~(CODE 5 STOP)'
														end

														local initString = 'Radar: REAR~n~Vehicle Plate: ~y~' .. bplate .. '~s~~n~Vehicle Model: ~y~' .. bmodel .. '~n~~s~' .. statusString .. '~s~~n~Issuing Officer: ' .. boloVehicle.officer
														local infoString = 'WARRANT REF: ~y~#' .. boloVehicle.id .. '~s~~n~Reason: ' .. boloVehicle.wanted_for .. '~n~Description: ' .. boloVehicle.description

														ShowNotificationWithIcon(initString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')

														Wait(3000)

														ShowNotificationWithIcon(infoString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')
													end)
												end
											end
										end
									end
								end
							end

							radar.info2 = string.format("~y~Plate: ~w~%s  ~y~Model: ~w~%s  ~y~Speed: ~w~%s mph", bplate, bmodel, math.ceil(bvspeed))
						end
					end

					DrawRect(0.508, 0.94, 0.196, 0.116, 0, 0, 0, 150)

					if freezeRadar then 
						DrawAdvancedText(0.591, 0.953, 0.005, 0.0028, 0.4, "~y~Rear Radar ~s~- ~b~FROZEN", 0, 191, 255, 255, 6, 0)
						DrawAdvancedText(0.591, 0.903, 0.005, 0.0028, 0.4, "~y~Front Radar ~s~- ~b~FROZEN", 0, 191, 255, 255, 6, 0)
					else
						DrawAdvancedText(0.591, 0.953, 0.005, 0.0028, 0.4, "~y~Rear Radar", 0, 191, 255, 255, 6, 0)
						DrawAdvancedText(0.591, 0.903, 0.005, 0.0028, 0.4, "~y~Front Radar", 0, 191, 255, 255, 6, 0)
					end

					DrawAdvancedText(0.6, 0.928, 0.005, 0.0028, 0.4, radar.info, 255, 255, 255, 255, 6, 0)
					DrawAdvancedText(0.6, 0.979, 0.005, 0.0028, 0.4, radar.info2, 255, 255, 255, 255, 6, 0)
				end
			end
		end

		Wait(1)
	end
end)