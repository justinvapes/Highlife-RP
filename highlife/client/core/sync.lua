local CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather

local initWeather = true

local CurrentTime = {
	Hours = 12,
	Minutes = 0
}

local freezeTime = false
local blackout = false

local globalRainAmount = 0.0
local globalCloudHat = 0.0
local currentRainAmount = 0.0

RegisterNetEvent('HighLife:Sync:Update')
AddEventHandler('HighLife:Sync:Update', function(time, freeze, NewWeather, newblackout, rainAmount, cloudHat)
	freezeTime = freeze

	globalCloudHat = cloudHat
	globalRainAmount = rainAmount

	NetworkOverrideClockTime(time.h, time.m, 0)

	SetMillisecondsPerGameMinute(4000)

	CurrentWeather = NewWeather
	blackout = newblackout
end)

local isSmoothingRain = false

local firstSpawn = true

CreateThread(function()
	TriggerServerEvent('HighLife:Sync:requestSync')
	
	while true do
		if IsChristmas() then
			CurrentWeather = 'XMAS'
			
			RequestIpl('christmas')
		else
			RemoveIpl('christmas')
		end

		if HighLife.Settings.Development then
			CurrentWeather = 'EXTRASUNNY'

			-- my fav time
			-- NetworkOverrideClockTime(19, 30, 0)
		end

		if firstSpawn then
			firstSpawn = false

			ClearOverrideWeather()
			ClearWeatherTypePersist()

			SetWeatherTypeNowPersist(CurrentWeather)
		end

		if lastWeather ~= CurrentWeather or initWeather then
			lastWeather = CurrentWeather

			if initWeather then
				ClearWeatherTypePersist()

				initWeather = false
			end

			SetWeatherTypeOverTime(CurrentWeather, (CurrentWeather == 'THUNDER' and 60.0 or 150.0))

			if HighLife.Player.CD then
				SetCloudHatOpacity(math.random(2, 8) * 0.10)
			end

			if CurrentWeather == 'RAIN' then
				if not isSmoothingRain then
					isSmoothingRain = true

					CreateThread(function()
						local thisRainAmount = 0.0

						while thisRainAmount ~= globalRainAmount do
							thisRainAmount = thisRainAmount + 0.001

							if thisRainAmount > globalRainAmount then thisRainAmount = globalRainAmount end

							SetRainFxIntensity(thisRainAmount)

							Wait(100)
						end

						isSmoothingRain = false
					end)
				end
			elseif CurrentWeather == 'CLEARING' then
				SetRainFxIntensity(globalRainAmount)
			else
				-- smooth out the 
				if not isSmoothingRain then
					isSmoothingRain = true

					CreateThread(function()
						while globalRainAmount ~= 0.0 do
							globalRainAmount = globalRainAmount - 0.001

							if globalRainAmount < 0.0 then globalRainAmount = 0.0 end

							SetRainFxIntensity(globalRainAmount)

							Wait(100)
						end

						isSmoothingRain = false
					end)
				end
			end
		end

		if CurrentWeather == 'HALLOWEEN' then
			if CurrentTime.Hours > 21 or CurrentTime.Hours < 4 then
				if GetGameTimer() > lightning_flash then
					lightning_flash = GetGameTimer() + math.random(15000, 120000)
					
					ForceLightningFlash()
				end
			end
		end

		Wait(2500) -- Wait 0 seconds to prevent crashing.
		
		SetBlackout(blackout)
		-- ClearWeatherTypePersist()
		-- SetWeatherTypePersist(lastWeather)
		-- SetWeatherTypeNow(lastWeather)
		-- SetWeatherTypeNowPersist(lastWeather)

		if lastWeather == 'XMAS' then
			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)

			RemoveDecalsInRange(HighLife.Player.Pos, 500.0)
		else
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end
	end
end)

-- CreateThread(function()
-- 	local showHelp = true
-- 	local loaded = false
	
-- 	while true do
-- 		if IsNextWeatherType('XMAS') then			
-- 			N_0xc54a08c85ae4d410(3.0)

-- 			SetForceVehicleTrails(true)
-- 			SetForcePedFootstepsTracks(true)
			
-- 			if not loaded then
-- 				RequestScriptAudioBank("ICE_FOOTSTEPS", false)
-- 				RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
-- 				RequestNamedPtfxAsset("core_snow")
				
-- 				while not HasNamedPtfxAssetLoaded("core_snow") do
-- 					Wait(0)
-- 				end

-- 				UseParticleFxAssetNextCall("core_snow")
-- 				loaded = true
-- 			end
-- 		else
-- 			-- disable frozen water effect
-- 			loaded = false
-- 			RemoveNamedPtfxAsset("core_snow")
-- 			ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
-- 			ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
-- 			SetForceVehicleTrails(false)
-- 			SetForcePedFootstepsTracks(false)
-- 			N_0xc54a08c85ae4d410(1.0)
-- 		end

-- 		Wait()
-- 	end
-- end)