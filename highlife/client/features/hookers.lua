local playerCash = nil
local havingAGoodTime = false

local prostitute_models = {
	's_f_y_hooker_01',
	's_f_y_hooker_02',
	's_f_y_hooker_03',
}

local availablePed = nil
local currentPed = nil

function solicit(action)
	RequestScriptAudioBank("PROSTITUTE_BLOWJOB", false, -1)

	if action == 'bj' then
		RequestAnimDict("oddjobs@towing")
		
		while not HasAnimDictLoaded("oddjobs@towing") do 
			Wait(10)
		end

		TaskPlayAnim(currentPed, "oddjobs@towing", "f_blow_job_loop", 8.0, -8.0, -1, 2, 0.0, false, false, false)
		TaskPlayAnim(HighLife.Player.Ped,  "oddjobs@towing", "m_blow_job_loop", 8.0, -8.0, -1, 2, 0.0, false, false, false)

		RemoveAnimDict("oddjobs@towing")
	elseif action == 'sex' then
		RequestAnimDict("mini@prostitutes@sexlow_veh")
		
		while not HasAnimDictLoaded("mini@prostitutes@sexlow_veh") do 
			Wait(10)
		end

		TaskPlayAnim(currentPed,"mini@prostitutes@sexlow_veh","low_car_sex_loop_female", 8.0, -8.0, -1, 2, 0.0, false, false, false)
		TaskPlayAnim(HighLife.Player.Ped,"mini@prostitutes@sexlow_veh","low_car_sex_loop_player", 8.0, -8.0, -1, 2, 0.0, false, false, false)

		RemoveAnimDict("mini@prostitutes@sexlow_veh")
	elseif action == 'fuckoff' then
		TaskSetBlockingOfNonTemporaryEvents(currentPed, false)

		TaskLeaveVehicle(currentPed, HighLife.Player.Vehicle, 0)

		TaskWanderStandard(currentPed, 10.0, 10)
	end
end

CreateThread(function()
	local peds = nil
	
	local thisTry = false

	while true do
		if not havingAGoodTime and HighLife.Player.InVehicle and GetVehicleClass(HighLife.Player.Vehicle) ~= 13 and GetVehicleClass(HighLife.Player.Vehicle) ~= 8 and GetEntitySpeed(HighLife.Player.Vehicle) < 2.0 then
			peds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, 5.0)

			thisTry = false
			
			for k,v in pairs(peds) do
			    if v ~= nil and not IsEntityDead(v) then
			    	for i=1, #prostitute_models do
			    		if GetEntityModel(v) == GetHashKey(prostitute_models[i]) then
				    		thisTry = true
				    		availablePed = v
				    		break
				    	end
			    	end

			    	if thisTry then
			    		break
			    	end
			    end
			end

			if not thisTry then
				availablePed = nil
			end
		else
			availablePed = nil
		end

		Wait(250)
	end
end)

local canPay = false

CreateThread(function()
	while true do
		if availablePed ~= nil and not IsPedFleeing(availablePed) then
			DisplayHelpText('Press ~INPUT_PICKUP~ to be ~r~entertained ~g~$' .. Config.Hookers.Price)

			if IsControlJustPressed(0, 38) then
				playerCash = nil

				HighLife:ServerCallback('HighLife:GetMoney', function(amount)
					playerCash = amount
				end, 'cash')

				while playerCash == nil do
					Wait(0)
				end

				if playerCash >= Config.Hookers.Price then
					canPay = true
					
					TriggerServerEvent('HighLife:RemoveCash', Config.Hookers.Price)
				else
					canPay = false
				end
				
				currentPed = availablePed

				if canPay then
					havingAGoodTime = true
					
					PlayAmbientSpeech1(currentPed, "HOOKER_OFFER_SERVICE", "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)

					SetBlockingOfNonTemporaryEvents(currentPed, true)
					TaskEnterVehicle(currentPed, HighLife.Player.Vehicle, -1, 0, 1.0, 1, 0)

					while GetPedInVehicleSeat(HighLife.Player.Vehicle, 0) == 0 do
						Wait(0)
					end

					local speech = {'SOLICIT_FRANKLIN', 'SOLICIT_MICHAEL', 'SOLICIT_TREVOR'}

					PlayAmbientSpeech1(currentPed, speech[math.random(#speech)], "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)

					while IsAmbientSpeechPlaying(currentPed) do
						Wait(1000)
					end

					PlayAmbientSpeech1(currentPed, "HOOKER_SECLUDED", "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)

					DisplayHelpText('HOOKER_PARK')

					Wait(10000)

					while not IsVehicleStopped(HighLife.Player.Vehicle) do
						Wait(500)
					end

					SetVehicleLights(HighLife.Player.Vehicle, 1)

					solicit('bj')

					Wait(15000)

					ClearPedTasks(HighLife.Player.Ped)
					ClearPedTasks(currentPed)

					Wait(1000)

					solicit('sex')

					Wait(14000)

					SetVehicleLights(HighLife.Player.Vehicle, 1)

					ClearPedTasks(HighLife.Player.Ped)
					ClearPedTasks(currentPed)

					Wait(2000)

					while IsAmbientSpeechPlaying(currentPed) do
						Wait(1000)
					end

					PlayAmbientSpeech1(currentPed, "SEX_FINISHED", "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)

					DisplayHelpText('HOOKER_DROP')

					Wait(10000)

					while not IsVehicleStopped(HighLife.Player.Vehicle) do
						Wait(500)
					end

					solicit('fuckoff')

					Wait(10000)

					havingAGoodTime = false
				else
					DisplayHelpText('HOOKER_CASH')

					PlayAmbientSpeech1(currentPed, "HOOKER_DECLINED", "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)

					Wait(3000)
				end
			end
		end

		Wait(0)
	end
end)

CreateThread(function()
	while true do
		if currentPed ~= nil then
			while IsEntityPlayingAnim(currentPed, "oddjobs@towing", "f_blow_job_loop", 3) do
				if not IsAmbientSpeechPlaying(currentPed) then
					local speech = {"SEX_ORAL", "SEX_ORAL_FEM"}

					PlayAmbientSpeech1(currentPed, speech[math.random(#speech)], "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)
				end

				Wait(250)
			end

			while IsEntityPlayingAnim(currentPed, "mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", 3) do
				if not IsAmbientSpeechPlaying(currentPed) then
					local speech = {"SEX_GENERIC", "SEX_GENERIC_FEM"}

					PlayAmbientSpeech1(currentPed, speech[math.random(#speech)], "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)
				end

				Wait(250)
			end
		end

		Wait(0)
	end
end)