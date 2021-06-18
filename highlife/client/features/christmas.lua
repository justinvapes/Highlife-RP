local snowTime = GameTimerPool.GlobalGameTime + 30000

CreateThread(function()
	local showHelp = true
	local loaded = false
	
	while true do
		if IsNextWeatherType('XMAS') then			
			N_0xc54a08c85ae4d410(3.0)

			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)
			
			if not loaded then
				loaded = true

				RequestScriptAudioBank("ICE_FOOTSTEPS", false)
				RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
				RequestNamedPtfxAsset("core_snow")
				
				while not HasNamedPtfxAssetLoaded("core_snow") do
					Wait(0)
				end

				UseParticleFxAssetNextCall("core_snow")
			end
			
			RequestAnimDict('anim@mp_snowball') -- pre-load the animation
			
			if IsControlJustReleased(0, 47) and not HighLife.Player.CD and not HighLife.Player.InVehicle and not IsPlayerFreeAiming(HighLife.Player.Id) and not IsPedSwimming(HighLife.Player.Ped) and not IsPedSwimmingUnderWater(HighLife.Player.Ped) and not IsPedRagdoll(HighLife.Player.Ped) and not IsPedFalling(HighLife.Player.Ped) and not IsPedRunning(HighLife.Player.Ped) and not IsPedSprinting(HighLife.Player.Ped) and GetInteriorFromEntity(HighLife.Player.Ped) == 0 and not IsPedShooting(HighLife.Player.Ped) and not IsPedUsingAnyScenario(HighLife.Player.Ped) and not IsPedInCover(HighLife.Player.Ped, 0) then
				SetCurrentPedWeapon(HighLife.Player.Ped, -1569615261, true)

				TaskPlayAnim(HighLife.Player.Ped, 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 48, 1, 0, 0, 0)

				Wait(1000)

				HighLife:WeaponGate()

				GiveWeaponToPed(HighLife.Player.Ped, GetHashKey('WEAPON_SNOWBALL'), 1, false, true)

				SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_SNOWBALL'), true)

				Wait(950)
			end

			if GameTimerPool.GlobalGameTime > snowTime then
				snowTime = GameTimerPool.GlobalGameTime + 600000

				if not HighLife.Player.CD and not HighLife.Player.InVehicle and not IsPlayerFreeAiming(HighLife.Player.Id) and not IsPedSwimming(HighLife.Player.Ped) and not IsPedSwimmingUnderWater(HighLife.Player.Ped) and not IsPedRagdoll(HighLife.Player.Ped) and not IsPedFalling(HighLife.Player.Ped) and not IsPedRunning(HighLife.Player.Ped) and not IsPedSprinting(HighLife.Player.Ped) and GetInteriorFromEntity(HighLife.Player.Ped) == 0 and not IsPedShooting(HighLife.Player.Ped) and not IsPedUsingAnyScenario(HighLife.Player.Ped) and not IsPedInCover(HighLife.Player.Ped, 0) then
					DisplayHelpText("Press ~INPUT_DETONATE~ while on foot to make a snowball")
				end
			end
		else
			-- disable frozen water effect
			if loaded then
				N_0xc54a08c85ae4d410(0.0)

				if HasNamedPtfxAssetLoaded("core_snow") then
					RemoveNamedPtfxAsset("core_snow")
				end
			end

			loaded = false
			
			ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
			ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end

		Wait(1)
	end
end)