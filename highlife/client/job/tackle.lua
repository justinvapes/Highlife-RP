-- local Keys = {
-- 	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
-- 	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
-- 	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
-- 	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
-- 	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
-- 	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
-- 	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
-- 	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
-- 	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
-- }

-- local isTackling = false
-- local isGettingTackled = false

-- local tackleLib = 'missmic2ig_11'
-- local tackleAnim = 'mic_2_ig_11_intro_goon'
-- local tackleVictimAnim = 'mic_2_ig_11_intro_p_one'

-- local lastTackleTime = 0
-- local isRagdoll = false

-- local disableFiring = false

-- function isCop()
-- 	if HighLife.Player.Job.name == 'police' then
-- 		return true
-- 	end

-- 	return false
-- end

-- RegisterNetEvent('HTackle:getTackled')
-- AddEventHandler('HTackle:getTackled', function(target)
-- 	CreateThread(function()
-- 		isGettingTackled = true
-- 		disableFiring = true

-- 		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

-- 		RequestAnimDict(tackleLib)

-- 		while not HasAnimDictLoaded(tackleLib) do
-- 			Wait(10)
-- 		end

-- 		AttachEntityToEntity(HighLife.Player.Ped, targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
-- 		TaskPlayAnim(HighLife.Player.Ped, tackleLib, tackleVictimAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

-- 		RemoveAnimDict(tackleLib)

-- 		Wait(3000)

-- 		DetachEntity(HighLife.Player.Ped, true, false)

-- 		isRagdoll = true
		
-- 		Wait(3000)
		
-- 		isRagdoll = false

-- 		isGettingTackled = false
-- 		disableFiring = false
-- 	end)
-- end)

-- RegisterNetEvent('HTackle:playTackle')
-- AddEventHandler('HTackle:playTackle', function()
-- 	CreateThread(function()
-- 		RequestAnimDict(tackleLib)

-- 		while not HasAnimDictLoaded(tackleLib) do
-- 			Wait(10)
-- 		end

-- 		TaskPlayAnim(HighLife.Player.Ped, tackleLib, tackleAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

-- 		RemoveAnimDict(tackleLib)

-- 		Wait(3000)

-- 		isTackling = false
-- 	end)
-- end)

-- -- Main thread
-- CreateThread(function()
-- 	while true do
-- 		if isRagdoll then
-- 			SetPedToRagdoll(HighLife.Player.Ped, 1000, 1000, 0, 0, 0, 0)
-- 		end

-- 		if IsControlPressed(0, Keys['LEFTSHIFT']) and IsControlPressed(0, Keys['G']) and IsAnyJobs({'police', 'fib'}) and not isTackling and not isGettingTackled then	
-- 			if HighLife.Player.CurrentWeapon == Config.WeaponHashes.unarmed then
-- 				local closestPlayer, distance = ESX.Game.GetClosestPlayer()

-- 				if distance ~= -1 and distance <= 3.0 and not isTackling and not isGettingTackled and not HighLife.Player.InVehicle and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
-- 					isTackling = true
-- 					lastTackleTime = GameTimerPool.GlobalGameTime

-- 					TriggerServerEvent('HTackle:tryTackle', GetPlayerServerId(closestPlayer))
-- 				end
-- 			end
-- 		end

-- 		if disableFiring then
-- 			DisableControlAction(1, 142, true)
-- 			DisableControlAction(0, 25, true)
-- 			DisableControlAction(1, 25, true)
-- 			DisableControlAction(1, 68, true)
-- 			DisableControlAction(0, 91, true)
-- 			DisableControlAction(1, 91, true)
-- 			DisablePlayerFiring(HighLife.Player.Id, true) -- Disable weapon firing
-- 		end

-- 		Wait(0)
-- 	end
-- end)