local SetWalkStyle = 'move_m@multiplayer'

local isDrunk = false
local isCrouching = false

function WalkMenuStart(name, bypassSet)
	if name == 'default' then
		name = SetWalkStyle
	end

	if name == 'Reset' then
		SetWalkStyle = 'Reset'

		isCrouching = false

		if isMale() then
			name = 'move_m@multiplayer'
		else
			name = 'move_f@multiplayer'
		end
	end

	if not bypassSet then
		SetWalkStyle = name
	end

	RequestWalking(name)
	SetPedMovementClipset(PlayerPedId(), name, 0.2)
	RemoveAnimSet(name)
end

function isMale()
	if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
		return false
	end

	return true
end

RegisterNetEvent("dpEmotes:SetDefaultWalkStyle")
AddEventHandler("dpEmotes:SetDefaultWalkStyle", function(walkstyle)
	WalkMenuStart(walkstyle or 'Reset')
end)

RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function()
	isCrouching = false

	WalkMenuStart(SetWalkStyle)
end)

local isCuffed = false
local crouchingDisable = false

CreateThread(function()
	while true do
		if IsDisabledControlJustPressed(0, 36) and IsPlayerControlOn(PlayerId()) and not isCuffed and not crouchingDisable then
			isCrouching = not isCrouching

			if not isCrouching then
				WalkMenuStart(SetWalkStyle)
			else
				WalkMenuStart('move_ped_crouched', true)
			end
		end

		if crouchingDisable then
			if isCrouching then
				WalkMenuStart(SetWalkStyle)

				isCrouching = false
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	while true do
		isCuffed = exports.highlife:GetHandCuffStatus()
		crouchingDisable = exports.highlife:IsCrouchingDisabled()

		Wait(1000)
	end
end)

-- CreateThread(function()
-- 	while true do
-- 		if not isSurrendering then
-- 			if drunkLevel > 0.9 then
-- 				if drunkLevel > 7 then
-- 					SetWalkStyle('move_m@drunk@verydrunk')
-- 				elseif drunkLevel > 4 then
-- 					SetWalkStyle('move_m@drunk@moderatedrunk')
-- 				elseif drunkLevel > 1 then
-- 					SetWalkStyle('move_m@drunk@slightlydrunk')
-- 				end
-- 			else
-- 				SetWalkStyle(currentWalkStyle)
-- 			end
-- 		end
		
-- 		Wait(5000)
-- 	end
-- end)

local drunkLevel = 0.0
local drunkWalk = nil

RegisterNetEvent("HAnimations:SetDrunk")
AddEventHandler("HAnimations:SetDrunk", function(thisIsDrunk, thisDrunkWalk)
	isDrunk = thisIsDrunk

	drunkWalk = thisDrunkWalk
end)

CreateThread(function()
	while true do
		local thisHealth = GetEntityHealth(PlayerPedId())

		local ovveride = false
		local isLimping = false

		if not isDrunk then
			if isMale() then
				if thisHealth <= 175 then
					isLimping = true
				end
			else
				if thisHealth <= 150 then
					isLimping = true
				end
			end

			if not isCrouching then
				WalkMenuStart(SetWalkStyle)
			end
		else
			WalkMenuStart(drunkWalk, true)

			ovveride = true
		end

		SetPedConfigFlag(PlayerPedId(), 166, isLimping)

		if not ovveride then
			if isCrouching and IsPedInAnyVehicle(PlayerPedId()) then
				isCrouching = false

				WalkMenuStart(SetWalkStyle)
			end
		end

		Wait(5000)
	end
end)

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
	Citizen.Wait(1)
  end 
end

function WalksOnCommand(source, args, raw)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
	WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("To reset do /walk reset")
end

function WalkCommandStart(source, args, raw)
  local name = firstToUpper(args[1])

  if name == "Reset" then
  	  SetWalkStyle = 'Reset'
	  ResetPedMovementClipset(PlayerPedId()) return
  end

  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
	WalkMenuStart(name2)
  else
	EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end