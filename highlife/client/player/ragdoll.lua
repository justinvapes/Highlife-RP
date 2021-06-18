CreateThread(function()
	while true do
		if not HighLife.Player.InVehicle and not IsPedInAnyTrain(HighLife.Player.Ped) and not IsPedInParachuteFreeFall(HighLife.Player.Ped) and GetPedParachuteState(HighLife.Player.Ped) == -1 then
			if GetEntitySpeed(HighLife.Player.Ped) > 20.0 then
				SetPedToRagdoll(HighLife.Player.Ped, 1000, 2000, 0, true, true, false)
				
				Wait(5000)
			end
		end
		
		Wait(1000)
	end
end)