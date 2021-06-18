local canWash = false
local isWashing = false

RegisterNetEvent('HighLife:CarWash:Success')
AddEventHandler('HighLife:CarWash:Success', function(success)
	CreateThread(function()
		if success then
			local thisVehicle = HighLife.Player.Vehicle

			FreezeEntityPosition(thisVehicle, true)

			local thisPtfxConfig = 'carwash'

			RequestNamedPtfxAsset(Config.ParticleEffects[thisPtfxConfig].dict)

			while not HasNamedPtfxAssetLoaded(Config.ParticleEffects[thisPtfxConfig].dict) do
				Wait(10)
			end

			UseParticleFxAssetNextCall(Config.ParticleEffects[thisPtfxConfig].dict)

			local thisPtfx = StartNetworkedParticleFxLoopedOnEntity(Config.ParticleEffects[thisPtfxConfig].anim, thisVehicle, Config.ParticleEffects[thisPtfxConfig].offset or vector3(0.0, 0.0, 0.0), Config.ParticleEffects[thisPtfxConfig].rotation or vector3(0.0, 0.0, 0.0), Config.ParticleEffects[thisPtfxConfig].scale, false, false, false)

			SetParticleFxLoopedColour(thisPtfx, 0.8, 0.18, 0.19, false)

			local thisSoundID = GetSoundId()

			PlaySoundFromEntity(thisSoundID, "SPRAY", GetVehiclePedIsIn(PlayerPedId()), 'CARWASH_SOUNDS', 0, 0)

			Wait(15000)

			RemoveDecalsFromVehicle(thisVehicle)
			WashDecalsFromVehicle(thisVehicle, 1.0)
			SetVehicleDirtLevel(thisVehicle, 0.0)

			Notification_AboveMap('CARWASH_CLEANED')

			Wait(1000)

			StopSound(thisSoundID)

			StopParticleFxLooped(thisPtfx, false)

			FreezeEntityPosition(thisVehicle, false)

			isWashing = false
		else
			isWashing = false

			Notification_AboveMap('CARWASH_MONEY')
		end

		canWash = false
	end)
end)

CreateThread(function()
	local thisTry = false

	while true do
		thisTry = false

		if HighLife.Player.InVehicle then
			if HighLife.Player.VehicleSeat == -1 then
				for k,v in pairs(Config.CarWash.Locations) do
					if Vdist(HighLife.Player.Pos, v.location) < 3.5 then
						thisTry = true
						canWash = true

						break
					end
				end

				if not thisTry then
					canWash = false
				end
			end
		else
			thisTry = false
			canWash = false
		end

		Wait(750)
	end
end)

CreateThread(function()
	for k,v in pairs(Config.CarWash.Locations) do
		local stationBlip = AddBlipForCoord(v.location)
		
		SetBlipSprite(stationBlip, 100)
		SetBlipScale(stationBlip, 0.8)
		SetBlipAsShortRange(stationBlip, true)
	end

	while true do
		if canWash and HighLife.Player.InVehicle then
			if isWashing then
				DisplayHelpText('CARWASH_CLEANING')
			else
				if GetEntitySpeed(HighLife.Player.Vehicle) < 1.0 then
					DisplayHelpText("Press ~INPUT_PICKUP~ to wash your car (~g~$" .. Config.CarWash.Price .. "~s~)")
					
					if IsControlJustPressed(1, 38) then
						isWashing = true

						TriggerServerEvent('HighLife:CarWash:Check')
					end
				else
					DisplayHelpText('CARWASH_STOP')
				end
			end
		end
		
		Wait(1)
	end
end)