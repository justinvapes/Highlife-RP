-- local phone_objects = {
-- 	GetHashKey('p_phonebox_01b_s'),
-- 	GetHashKey('p_phonebox_02_s'),
-- 	GetHashKey('prop_phonebox_01a'),
-- 	GetHashKey('prop_phonebox_01b'),
-- 	GetHashKey('prop_phonebox_01c'),
-- 	GetHashKey('prop_phonebox_02'),
-- 	GetHashKey('prop_phonebox_03'),
-- 	GetHashKey('prop_phonebox_04'),
-- }

-- local isNearPhoneBooth = false

-- CreateThread(function()
-- 	while HighLife.Player.CD do
-- 		Wait(100)
-- 	end

-- 	for k,v in pairs(Config.PhoneObjects) do
-- 		local thisObj = CreateObject(v.model, v.pos, false, true, false)

-- 		SetEntityHeading(thisObj, v.heading)
-- 	end
	
-- 	while true do
-- 		isNearPhoneBooth = false

-- 		if not HighLife.Player.Dead then
-- 			for i=1, #phone_objects do
-- 				local closestObj = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, phone_objects[i], true, true, true)

-- 				if closestObj ~= 0 then
-- 					isNearPhoneBooth = true

-- 					break
-- 				end
-- 			end
-- 		end

-- 		Wait(2000)
-- 	end
-- end)

-- CreateThread(function()
-- 	local isMakingCall = false

-- 	while true do
-- 		if isNearPhoneBooth then
-- 			if not isMakingCall then
-- 				DisplayHelpText('Press ~INPUT_PICKUP~ to make a call for ~g~$1')

-- 				if IsControlJustPressed(0, 38) then
-- 					isMakingCall = true

-- 					TriggerEvent('gcPhone:makeBoxCall')
-- 				end
-- 			end
-- 		else
-- 			isMakingCall = false
-- 		end

-- 		Wait(1)
-- 	end
-- end)