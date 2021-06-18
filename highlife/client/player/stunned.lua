local stunTime = 10000 -- in miliseconds >> 1000 ms = 1s

CreateThread(function()
	while true do
		if IsPedBeingStunned(HighLife.Player.Ped) then
			SetPadShake(0, 5000, 255)
			
			if HighLife.Player.OverrideClipset == nil then
				HighLife.Player.OverrideClipset = 'MOVE_M@BAIL_BOND_NOT_TAZERED'
	
				CreateThread(function()
					while IsPedBeingStunned(HighLife.Player.Ped) do
						Wait(30000)

						if not IsPedBeingStunned(HighLife.Player.Ped) then
							HighLife.Player.OverrideClipset = nil
						end
					end
				end)
			end
		end

		Wait(500)
	end
end)