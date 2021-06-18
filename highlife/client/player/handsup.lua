local handsup = false
local cuffed = false

local inAnim = false

local handsupAnim = {
	dict = 'missminuteman_1ig_2',
	anim = 'handsup_enter'
}

CreateThread(function()		
	while true do
		-- to stop them exploiting the handsup dead thing
		if HighLife.Player.DeathLogging and not HighLife.Player.IsSellingDrugs and not HighLife.Player.PlayingBlackjack and HighLife.Player.Dragging == nil then
			if IsControlPressed(1, 323) and not inAnim and not HighLife.Player.Cuffed and (HighLife.Player.VehicleClass ~= 8 and HighLife.Player.VehicleClass ~= 13) then
				DisablePlayerFiring(HighLife.Player.Ped, true)

				HighLife.Player.HandsUp = true

				DisableControlAction(0, 22, true)
				DisableControlAction(0, 25, true)
				
				if not HighLife.Player.Dead then
					if not handsup then
						handsup = true

						LoadAnimationDictionary(handsupAnim.dict)

						ResetCurrentPedWeapon()

						TaskPlayAnim(HighLife.Player.Ped, handsupAnim.dict, handsupAnim.anim, 7.0, 1.0, -1, 50, 0, false, false, false)

						RemoveAnimDict(handsupAnim.dict)
					end
				end
			end

			if handsup and HighLife.Player.Cuffed then
				handsup = false

				HighLife.Player.HandsUp = false
				
				ClearPedTasks(HighLife.Player.Ped)
			end

			if handsup and IsControlReleased(1, 323) then
				handsup = false

				HighLife.Player.HandsUp = false

				CreateThread(function()
					local enableFiring = false

					CreateThread(function()
						Wait(1000)

						enableFiring = true
					end)
					
					while not enableFiring do
						DisablePlayerFiring(HighLife.Player.Ped, true)

						Wait(1)
					end
				end)

				DisableControlAction(0, 21, true)
				DisableControlAction(0, 137, true)

				ClearPedTasks(HighLife.Player.Ped)
			end

			if HighLife.Player.Dead and handsup then
				handsup = false
			end
		end

		Wait(1)
	end
end)