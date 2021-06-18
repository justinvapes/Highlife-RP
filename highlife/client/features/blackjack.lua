local initSystem = false
local renderBet = false 
local renderHand = false
local renderTime = false
local renderScaleform = false

local cameraPosOffset = vector3(0.03, 0.0, 3.1936)
local cameraRotOffset = vector2(-90.0, 0.0) -- z is the table rotation

local currentBet = 0
local timeLeft = 0
local selectedBet = 1
local seatSideAngle = 30

local hand = {}
local splitHand = {}

local chips = nil
local handObjs = nil
local spawnedPeds = nil
local spawnedObjects = nil
local dealerHandObjs = nil

local jokerModel = `vw_prop_casino_cards_single`

local initCard = {}
local dealerHand = {}

local myTableID = nil

local OverheadCam = nil
local OverheadCamEnabled = false

local PlayerDealers = {}
local playerDealerTable = nil

local isBlackjackDealer = false

local bjDebug = false

RegisterCommand('bjdebug', function()
	if HighLife.Player.Special or HighLife.Player.Debug then
		bjDebug = not bjDebug
	end
end)

function DebugPrint(str)
	if bjDebug and str then
		return print("BLACKJACK: "..tostring(str))
	end
end

function Notification(text, color, blink)
	if color then ThefeedNextPostBackgroundColor(color) end
	PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", 0)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(blink or false, false)
end

function SetSubtitle(subtitle, duration)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringWebsite(subtitle)
	EndTextCommandPrint(duration, true)
	DebugPrint("SUBTITLE: "..subtitle)
end

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < -180 and t + 180 or t
end

function cardValue(card)
	local rank = 10
	for i=2,11 do
		if string.find(card, tostring(i)) then
			rank = i
		end
	end
	if string.find(card, 'ACE') then
		rank = 11
	end
	
	return rank
end

function handValue(hand)
	local tmpValue = 0
	local numAces = 0
	
	for i,v in pairs(hand) do
		tmpValue = tmpValue + cardValue(v)
	end
	
	for i,v in pairs(hand) do
		if string.find(v, 'ACE') then numAces = numAces + 1 end
	end
	
	repeat
		if tmpValue > 21 and numAces > 0 then
			tmpValue = tmpValue - 10
			numAces = numAces - 1
		else
			break
		end
	until numAces == 0
	
	return tmpValue
end

function CanSplitHand(hand)
	if hand[1] and hand[2] then
		if hand[1]:sub(-3) == hand[2]:sub(-3) and #hand == 2 then
			if cardValue(hand[1]) == cardValue(hand[2]) then
				return true
			end
		end
	end

	return HighLife.Player.Debug
end

local orderedChipValues = Config.Casino.Blackjack.chipValues

table.sort(orderedChipValues, function(a, b) return a > b end)

function getChips(amount)
	local toTake = amount

	if amount < 500000 then
		local finalChips = {}

		local stack = 1

		local resetOrderedChips = false

		while toTake ~= 0 do
			resetOrderedChips = false

			for chipAmount=1, #orderedChipValues do
				if orderedChipValues[chipAmount] <= toTake then
					toTake = toTake - orderedChipValues[chipAmount]

					if finalChips[stack] ~= nil then
						for stackTypeIter=1, #finalChips[stack] do
							if finalChips[stack][stackTypeIter] ~= Config.Casino.Blackjack.chipModels[orderedChipValues[chipAmount]] then
								stack = stack + 1

								finalChips[stack] = {}

								break
							end
						end
					else
						finalChips[stack] = {}
					end

					if stack > 4 then
						stack = 4
					end

					table.insert(finalChips[stack], Config.Casino.Blackjack.chipModels[orderedChipValues[chipAmount]])

					resetOrderedChips = true
				end

				if resetOrderedChips then break end
			end

			Wait(1)
		end

		return false, finalChips
	end
end

function leaveBlackjack()
	myTableID = nil
	leavingBlackjack = true
	renderScaleform = false
	renderTime = false
	renderBet = false 
	renderHand = false
	currentBet = 0
	selectedBet = 1
	hand = {}
	splitHand = {}

	HighLife.Player.PlayingBlackjack = false

	HighLife.Player.Voice.CurrentProximity = 2

	RenderScriptCams(false, false, 3000, 1, 0, 0)

	OverheadCamEnabled = false

	DestroyCam(OverheadCam, false)

	OverheadCam = nil
end

function CheckDealerPeds()
	if spawnedPeds ~= nil then
		for tableIndex,v in pairs(Config.Casino.Blackjack.ActiveTables) do
			if DoesEntityExist(spawnedPeds[tableIndex]) then
				SetEntityVisible(spawnedPeds[tableIndex], (PlayerDealers[tableIndex] == nil))
			end
		end
	end
end

function s2m(s)
    if s <= 0 then
        return "00:00"
    else
        local m = string.format("%02.f", math.floor(s/60))
        return m..":"..string.format("%02.f", math.floor(s - m * 60))
    end
end

AddEventHandler("onResourceStop", function(r)
	if r == GetCurrentResourceName() then
		for i,v in ipairs(spawnedPeds) do
			DeleteEntity(v)
		end
		for i,v in ipairs(spawnedObjects) do
			DeleteEntity(v)
		end
	end
end)

CreateThread(function()
    scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")

    repeat Wait(0) until HasScaleformMovieLoaded(scaleform)

	while true do Wait(0)
		if renderScaleform then
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		
		local barCount = {1}

		if renderTime and timeLeft ~= nil then
			if timeLeft > 0 then
				DrawTimerBar(barCount, "TIME", s2m(timeLeft))
			end
		end

		if renderBet then
			DrawTimerBar(barCount, "BET", '~g~$' .. currentBet)
		end

		if renderHand then
			if #splitHand > 0 then
				DrawTimerBar(barCount, "SPLIT", handValue(splitHand))
			end

			DrawTimerBar(barCount, "HAND", handValue(hand))
		end

		if HighLife.Player.Debug then
			for i,p in pairs(Config.Casino.Blackjack.chipOffsets) do
				for _,v in pairs(p) do
					for n,m in pairs(Config.Casino.Blackjack.ActiveTables) do
						local x, y, z = GetObjectOffsetFromCoords(m.coords.x, m.coords.y, m.coords.z, m.coords.w, v)
						
						if Vdist(GetGameplayCamCoord(), x, y, z, true) < 5.0 then
							DrawMarker(28, v.x, v.y, Config.Casino.Blackjack.chipHeights[1], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 150, 150, 255, 150, false, false, false, false)
						
							SetTextFont(0)
							SetTextProportional(1)
							SetTextScale(0.0, 0.35)
							SetTextColour(255, 255, 255, 255)
							SetTextDropshadow(0, 0, 0, 0, 255)
							SetTextEdge(2, 0, 0, 0, 150)
							SetTextDropShadow()
							SetTextOutline()
							SetTextCentre(1)
							SetTextEntry("STRING")
							SetDrawOrigin(GetObjectOffsetFromCoords(m.coords.x, m.coords.y, m.coords.z, m.coords.w, v.x, v.y, Config.Casino.Blackjack.chipHeights[1]))
							AddTextComponentString(tostring(_))
							DrawText(0.0, 0.0)
							ClearDrawOrigin()
						end
					end
				end
			end
		
			if #hand > 0 then
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.35)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextCentre(1)
				SetTextEntry("STRING")
				AddTextComponentString("HAND VALUE: " .. handValue(hand))
				DrawText(0.90, 0.15)
				
				for i,v in ipairs(hand) do
					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.35)
					SetTextColour(255, 255, 255, 255)
					SetTextDropshadow(0, 0, 0, 0, 255)
					SetTextEdge(2, 0, 0, 0, 150)
					SetTextDropShadow()
					SetTextOutline()
					SetTextCentre(1)
					SetTextEntry("STRING")
					AddTextComponentString(v.." ("..cardValue(v)..")")
					DrawText(0.90, 0.15+(i/40))
				end				
			end
		end
	end
end)

function InitDealerPeds()
	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@") then
		RequestAnimDict("anim_casino_b@amb@casino@games@shared@dealer@")

		while not HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@") do
			Wait(100)
		end
	end

	for i,v in pairs(Config.Casino.Blackjack.ActiveTables) do
		local scene = CreateSynchronizedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2)
		TaskSynchronizedScene(spawnedPeds[i], scene, "anim_casino_b@amb@casino@games@shared@dealer@", "idle", 1000.0, -8.0, 4, 1, 1148846080, 0)
	end
end

RegisterNetEvent("HighLife:Blackjack:SetDealer")
AddEventHandler("HighLife:Blackjack:SetDealer", function(tableIndex, dealer, remove)
	if remove then
		PlayerDealers[tableIndex] = nil
	else
		PlayerDealers[tableIndex] = dealer
	end

	if spawnedPeds ~= nil then
		if DoesEntityExist(spawnedPeds[tableIndex]) then
			SetEntityVisible(spawnedPeds[tableIndex], (PlayerDealers[tableIndex] == nil))
		end
	end
end)

function InitBlackjack()
	hand = {}
	chips = {}
	handObjs = {}
	splitHand = {}
	dealerHand = {}
	dealerHandObjs = {}

	spawnedPeds = {}
	
	for i,v in pairs(Config.Casino.Blackjack.ActiveTables) do
		dealerHand[i] = {}
		dealerHandObjs[i] = {}

		local isMale = false -- (math.random(1, 3) == 1)

		local model = (v.model ~= nil and v.model or (isMale and `s_m_y_casino_01` or `s_f_y_casino_01`))

		chips[i] = {}
		
		for x=1,4 do
			chips[i][x] = {}
		end
		handObjs[i] = {}
		
		for x=1,4 do
			handObjs[i][x] = {}
		end
		
		if not HasModelLoaded(model) then
			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
		end
		
		local dealer = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)

		SetEntityCanBeDamaged(dealer, false)
		SetBlockingOfNonTemporaryEvents(dealer, true)
		SetPedCanRagdollFromPlayerImpact(dealer, false)
		SetEntityProofs(dealer, true, true, true, false, true, 1, 1, 1)

		SetPedCanBeTargetted(dealer, false)
		
		SetPedResetFlag(dealer, 249, true)
		SetPedConfigFlag(dealer, 185, true)
		SetPedConfigFlag(dealer, 108, true)
		SetPedConfigFlag(dealer, 208, true)
		
		if v.model == nil then
			SetRandomDealerOutfit(dealer, isMale)
		end
		
		spawnedPeds[i] = dealer
	end

	spawnedObjects = {}

	for i,v in pairs(Config.Casino.Blackjack.ActiveTables) do
		if v.custom then
			local model = `vw_prop_casino_blckjack_01`

			if v.highStakes then
				model = `vw_prop_casino_blckjack_01b`
			end

			if v.hide then
				CreateModelHide(v.coords.x, v.coords.y, v.coords.z, 3.0, v.hide, true)
			end
			
			if not HasModelLoaded(model) then
				RequestModel(model)
				repeat Wait(0) until HasModelLoaded(model)
			end
		
			local tableObj = CreateObjectNoOffset(model, v.coords.x, v.coords.y, v.coords.z, false, false, false)
			SetEntityRotation(tableObj, 0.0, 0.0, v.coords.w, 2, 1)
			SetObjectTextureVariant(tableObj, v.color or 3)
			table.insert(spawnedObjects, tableObj)
		else
			if v.color ~= nil then
				local thisTable = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 3.0, v.tableModel, false, false, false)

				if thisTable ~= 0 then
					SetObjectTextureVariant(thisTable, v.color or 3)
				end
			end
		end
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer") then
		RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@dealer")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer")
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@") then
		RequestAnimDict("anim_casino_b@amb@casino@games@shared@dealer@")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@")
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@player") then
		RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@player")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@player")
	end

	InitDealerPeds()

	initSystem = true
end

RegisterNetEvent("BLACKJACK:SyncTimer")
AddEventHandler("BLACKJACK:SyncTimer", function(_timeLeft)
	timeLeft = _timeLeft
end)

RegisterNetEvent("BLACKJACK:PlayDealerAnim")
AddEventHandler("BLACKJACK:PlayDealerAnim", function(tableIndex, animDict, anim, lastFrame)
	DebugPrint("PLAYING " .. anim:upper() .. " ON DEALER " .. tableIndex)

	if (HighLife.Player.PlayingBlackjack or HighLife.Player.InCasino) and spawnedPeds ~= nil and spawnedPeds[tableIndex] ~= nil then
		if PlayerDealers[tableIndex] == nil or (PlayerDealers[tableIndex] ~= nil and PlayerDealers[tableIndex] == HighLife.Player.ServerId) then
			CreateThread(function()
				local v = Config.Casino.Blackjack.ActiveTables[tableIndex]
				
				if not HasAnimDictLoaded(animDict) then
					RequestAnimDict(animDict)

					repeat Wait(0) until HasAnimDictLoaded(animDict)
				end

				if PlayerDealers[tableIndex] ~= nil and isMale() then
					anim = anim:gsub("female_", "")
				end

				if PlayerDealers[tableIndex] ~= nil then
					ClearPedTasks(HighLife.Player.Ped)

					local netScene = NetworkCreateSynchronisedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2, (lastFrame ~= nil), false, 1065353216, 0, 1065353216)

					NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, netScene, animDict, anim, 2.0, -2.0, 13, 16, 1148846080, 0)

	                NetworkStartSynchronisedScene(netScene)

	                playerDealerTable = tableIndex
				else
					local scene = CreateSynchronizedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2)

					TaskSynchronizedScene(spawnedPeds[tableIndex], scene, animDict, anim, 8.0, 8.0, 4, 1, 1148846080, 0)
	            end
			
				-- if anim == 'female_turn_card' or anim == 'female_check_and_turn_card' or anim == 'female_check_card' then
				-- 	CreateThread(function()
				-- 		for i=1, 99999999 do
				-- 			if IsControlJustReleased(0, 38) then
				-- 				print(i)
				-- 			end

				-- 			Wait(0)
				-- 		end
				-- 	end)

				-- 	if dealerHandObjs ~= nil and dealerHandObjs[tableIndex] ~= nil and dealerHandObjs[tableIndex][1] ~= nil then
				-- 		local thisCardPos = GetEntityCoords(dealerHandObjs[tableIndex][1]) - vector3(0.0, 0.0, 0.95)
				-- 		local thisCardRot = GetEntityRotation(dealerHandObjs[tableIndex][1], 2)

				-- 		FreezeEntityPosition(dealerHandObjs[tableIndex][1], true)

				-- 		if anim == 'female_turn_card' or anim == 'female_check_and_turn_card' then
				-- 			DeleteEntity(dealerHandObjs[tableIndex][1])

				-- 			dealerHandObjs[tableIndex][1] = CreateObject(initCard[tableIndex], thisCardPos, false, false, false)

				-- 			FreezeEntityPosition(dealerHandObjs[tableIndex][1], true)
							
				-- 			SetEntityRotation(dealerHandObjs[tableIndex][1], thisCardRot, 2)

				-- 			Wait(95)
				-- 			-- Wait(math.floor(GetAnimDuration(animDict, anim) * 500))
				-- 		end

				-- 		AttachEntityToEntity(dealerHandObjs[tableIndex][1], spawnedPeds[tableIndex], GetPedBoneIndex(spawnedPeds[tableIndex], 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1);

				-- 		Wait(1500)

				-- 		print('da')

				-- 		DetachEntity(dealerHandObjs[tableIndex][1], 0, true)

				-- 		SetEntityCoords(dealerHandObjs[tableIndex][1], GetEntityCoords(dealerHandObjs[tableIndex][1]) + vector3(0.0, 0.0, 0.01))

				-- 		-- if anim == 'female_turn_card' or anim == 'female_check_and_turn_card' then
				-- 		-- 	SetEntityCoords(dealerHandObjs[tableIndex][1], thisCardPos)
				-- 		-- end

				-- 		-- SetEntityRotation(dealerHandObjs[tableIndex][1], 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w + Config.Casino.Blackjack.cardRotationOffsetsDealer[1].z)
				-- 	end
				-- end
			end)
		end
	end
end)

RegisterNetEvent("BLACKJACK:DealerTurnOverCard")
AddEventHandler("BLACKJACK:DealerTurnOverCard", function(tableIndex)
	if dealerHandObjs ~= nil and dealerHandObjs[tableIndex] ~= nil and dealerHandObjs[tableIndex][1] ~= nil then
		-- jokerModel
		local thisCardPos = GetEntityCoords(dealerHandObjs[tableIndex][1]) - vector3(0.0, 0.0, 1.0)

		DeleteEntity(dealerHandObjs[tableIndex][1])

		dealerHandObjs[tableIndex][1] = CreateObject(initCard[tableIndex], thisCardPos, false, false, false)

		SetEntityRotation(dealerHandObjs[tableIndex][1], 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w + Config.Casino.Blackjack.cardRotationOffsetsDealer[1].z)
	end
end)

RegisterNetEvent("BLACKJACK:PlayDealerSpeech")
AddEventHandler("BLACKJACK:PlayDealerSpeech", function(tableIndex, speech)
	if spawnedPeds ~= nil and spawnedPeds[i] ~= nil and speech ~= nil then
		if myTableID == nil or (myTableID ~= nil and myTableID == tableIndex) then
			if not isBlackjackDealer then
				if PlayerDealers[tableIndex] == nil then
					CreateThread(function()
						DebugPrint("PLAYING SPEECH "..speech:upper().." ON DEALER "..i)
						StopCurrentPlayingAmbientSpeech(spawnedPeds[tableIndex])
						PlayAmbientSpeech1(spawnedPeds[tableIndex], speech, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
					end)
				end
			end
		end
	end
end)

RegisterNetEvent("BLACKJACK:SplitHand")
AddEventHandler("BLACKJACK:SplitHand", function(tableIndex, seat, splitHandSize, _hand, _splitHand)
	if Config.Casino.Blackjack.ActiveTables[tableIndex] ~= nil and handObjs ~= nil and handObjs[tableIndex] ~= nil and handObjs[tableIndex][seat] ~= nil then
		if tableIndex == g_seat and seat == closestChair then
			hand = _hand
			splitHand = _splitHand
		end

		DebugPrint("splitHandSize = " .. splitHandSize)
		DebugPrint("split card coord = " .. tostring(GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[tableIndex].coords.x, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.y, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.z, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w, Config.Casino.Blackjack.cardSplitOffsets[seat][1])))
		
		SetEntityCoordsNoOffset(handObjs[tableIndex][seat][#handObjs[tableIndex][seat]], GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[tableIndex].coords.x, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.y, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.z, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w, Config.Casino.Blackjack.cardSplitOffsets[(5 - seat)][1]))
		SetEntityRotation(handObjs[tableIndex][seat][#handObjs[tableIndex][seat]], 0.0, 0.0, Config.Casino.Blackjack.cardSplitRotationOffsets[seat][splitHandSize])
	end
end)

RegisterNetEvent("BLACKJACK:PlaceBetChip")
AddEventHandler("BLACKJACK:PlaceBetChip", function(index, seat, bet, double, split)
	if spawnedObjects ~= nil and chips ~= nil and chips[index] ~= nil and chips[index][seat] ~= nil then
		CreateThread(function()
			local chipPile, props = getChips(bet)
			
			if chipPile then
				local model = GetHashKey(props)
			
				RequestModel(model)

				repeat Wait(0) until HasModelLoaded(model)

				local location = 1

				if double == true then location = 2 end
				
				local chip = CreateObjectNoOffset(model, Config.Casino.Blackjack.ActiveTables[index].coords.x, Config.Casino.Blackjack.ActiveTables[index].coords.y, Config.Casino.Blackjack.ActiveTables[index].coords.z, false, false, false)

				table.insert(spawnedObjects, chip)
				table.insert(chips[index][seat], chip)

				if not split then
					SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[index].coords.x, Config.Casino.Blackjack.ActiveTables[index].coords.y, Config.Casino.Blackjack.ActiveTables[index].coords.z, Config.Casino.Blackjack.ActiveTables[index].coords.w, Config.Casino.Blackjack.pileOffsets[seat][location].x, Config.Casino.Blackjack.pileOffsets[seat][location].y, Config.Casino.Blackjack.chipHeights[1]))
					SetEntityRotation(chip, 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[index].coords.w + Config.Casino.Blackjack.pileRotationOffsets[seat][3 - location].z)
				else
					SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[index].coords.x, Config.Casino.Blackjack.ActiveTables[index].coords.y, Config.Casino.Blackjack.ActiveTables[index].coords.z, Config.Casino.Blackjack.ActiveTables[index].coords.w, Config.Casino.Blackjack.pileOffsets[seat][2].x, Config.Casino.Blackjack.pileOffsets[seat][2].y, Config.Casino.Blackjack.chipHeights[1]))
					SetEntityRotation(chip, 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[index].coords.w + Config.Casino.Blackjack.pileRotationOffsets[seat][3 - location].z)
				end
			else
				local chipXOffset = 0.0
				local chipYOffset = 0.0
				
				if split or double then
					if seat == 1 then
						chipXOffset = chipXOffset + 0.03
						chipYOffset = chipYOffset + 0.05
					elseif seat == 2 then
						chipXOffset = chipXOffset + 0.05
						chipYOffset = chipYOffset + 0.02
					elseif seat == 3 then
						chipXOffset = chipXOffset + 0.05
						chipYOffset = chipYOffset - 0.02
					elseif seat == 4 then
						chipXOffset = chipXOffset + 0.02
						chipYOffset = chipYOffset - 0.05
					end
				end
				
				for i=1, #props do
					local chipGap = 0.0

					for j=1, #props[i] do
						local model = GetHashKey(props[i][j])
						
						DebugPrint(bet)
						DebugPrint(seat)
						DebugPrint(tostring(props[i][j]))
						DebugPrint(tostring(Config.Casino.Blackjack.chipOffsets[seat]))
					
						RequestModel(model)
						repeat Wait(0) until HasModelLoaded(model)
					
						local location = i
						-- if double == true then location = 2 end
						
						local chip = CreateObjectNoOffset(model, Config.Casino.Blackjack.ActiveTables[index].coords.x, Config.Casino.Blackjack.ActiveTables[index].coords.y, Config.Casino.Blackjack.ActiveTables[index].coords.z, false, false, false)
						
						table.insert(spawnedObjects, chip)
						table.insert(chips[index][seat], chip)

						if Config.Casino.Blackjack.chipOffsets[seat][location] ~= nil and Config.Casino.Blackjack.chipRotationOffsets[seat][location] ~= nil then
							SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[index].coords.x, Config.Casino.Blackjack.ActiveTables[index].coords.y, Config.Casino.Blackjack.ActiveTables[index].coords.z, Config.Casino.Blackjack.ActiveTables[index].coords.w, Config.Casino.Blackjack.chipOffsets[seat][location].x + chipXOffset, Config.Casino.Blackjack.chipOffsets[seat][location].y + chipYOffset, Config.Casino.Blackjack.chipHeights[1] + chipGap))
							SetEntityRotation(chip, 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[index].coords.w + Config.Casino.Blackjack.chipRotationOffsets[seat][location].z)
						end

						chipGap = chipGap + ((Config.Casino.Blackjack.chipThickness[model] ~= nil) and Config.Casino.Blackjack.chipThickness[model] or 0.0)
					end
				end
			end
		end)
	end
end)

RegisterNetEvent("BLACKJACK:BetReceived")

local upPressed = false
local downPressed = false

RegisterNetEvent("BLACKJACK:RequestBets")
AddEventHandler("BLACKJACK:RequestBets", function(index, _timeLeft)
	timeLeft = _timeLeft
	if leavingBlackjack == true then leaveBlackjack() return end

	local initSet = true

	CreateThread(function()
		scrollerIndex = index
		renderScaleform = true
		renderTime = true
		renderBet = true

		hand = {}
		splitHand = {}

		customBet = nil

		while true do Wait(0)
			PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
			PopScaleformMovieFunctionVoid()

			BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamInt(80)
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 202, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Exit")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(1)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 38, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Custom Bet")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(2)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 201, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Place Bet")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(3)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 204, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Max Bet")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(4)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 175, 0))
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 174, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Adjust Bet")
			EndScaleformMovieMethod()
		
			BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
			EndScaleformMovieMethod()

			if not IsAudioSceneActive('DLC_VW_Casino_Cards_Focus_Hand') then
				StartAudioScene('DLC_VW_Casino_Cards_Focus_Hand')
			end

			local tableLimit = (Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes and #Config.Casino.Blackjack.bettingNums or Config.Casino.Blackjack.lowTableLimit)

			if initSet then
				initSet = false

				if Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes and selectedBet < Config.Casino.Blackjack.lowTableLimit then
					selectedBet = (Config.Casino.Blackjack.lowTableLimit + 1)
				end
			end

			if IsControlJustPressed(1, 204) then -- TAB / Y
				selectedBet = tableLimit
			elseif IsControlJustPressed(1, 202) then -- ESC / B
				if not HighLife.Player.IsInventoryVisible then
					leavingBlackjack = true
					renderScaleform = false
					renderTime = false
					renderBet = false
					renderHand = false
					selectedBet = 1

					HighLife.Player.Voice.CurrentProximity = 2

					return
				end
			end

			if not upPressed then
				if IsControlJustPressed(1, 175) then -- RIGHT ARROW / DPAD RIGHT
					customBet = nil

					upPressed = true
					CreateThread(function()
						selectedBet = selectedBet + 1

						if selectedBet > (tableLimit) then
							selectedBet = (Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes and ((Config.Casino.Blackjack.lowTableLimit + 1)) or 1)
						end

						Wait(175)
						while IsControlPressed(1, 175) do
							selectedBet = selectedBet + 1

							if selectedBet > (tableLimit) then
								selectedBet = (Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes and ((Config.Casino.Blackjack.lowTableLimit + 1)) or 1)
							end

							Wait(125)
						end

						upPressed = false
					end)
				end
			end

			if not downPressed then
				if IsControlJustPressed(1, 174) then -- LEFT ARROW / DPAD LEFT
					customBet = nil

					downPressed = true
					CreateThread(function()
						selectedBet = selectedBet - 1

						if Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes then
							if selectedBet < (Config.Casino.Blackjack.lowTableLimit + 1) then
								selectedBet = tableLimit
							end
						else
							if selectedBet < 1 then selectedBet = (tableLimit) end
						end

						Wait(175)
						while IsControlPressed(1, 174) do
							selectedBet = selectedBet - 1

							if Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes then
								if selectedBet < (Config.Casino.Blackjack.lowTableLimit + 1) then
									selectedBet = tableLimit
								end
							else
								if selectedBet < 1 then selectedBet = (tableLimit) end
							end

							Wait(125)
						end

						downPressed = false
					end)
				end
			end

			currentBet = customBet or Config.Casino.Blackjack.bettingNums[selectedBet]

			if IsControlJustPressed(1, 38) then
				local thisBet = openKeyboard('CUSTOM_BET', 'Custom bet (multiple of ~g~$10)')

				if thisBet ~= nil and tonumber(thisBet) then
					thisBet = tonumber(thisBet)

					if (thisBet % 10 ~= 0) then
						thisBet = thisBet + (10 - thisBet % 10)
					end

					if Config.Casino.Blackjack.ActiveTables[scrollerIndex].highStakes then
						if thisBet > Config.Casino.Blackjack.bettingNums[#Config.Casino.Blackjack.bettingNums] then
							thisBet = Config.Casino.Blackjack.bettingNums[#Config.Casino.Blackjack.bettingNums]
						elseif thisBet < Config.Casino.Blackjack.bettingNums[Config.Casino.Blackjack.lowTableLimit+1] then
							thisBet = Config.Casino.Blackjack.bettingNums[Config.Casino.Blackjack.lowTableLimit+1]
						end
					else
						if thisBet > Config.Casino.Blackjack.bettingNums[Config.Casino.Blackjack.lowTableLimit] then
							thisBet = Config.Casino.Blackjack.bettingNums[Config.Casino.Blackjack.lowTableLimit]
						elseif thisBet < 10 then
							thisBet = 10
						end
					end

					if thisBet >= 10 then
						customBet = thisBet
					end
				end
			end
		
			if IsControlJustPressed(1, 201) then -- ENTER / A
				TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, currentBet)

				local betCheckRecieved = false
				local canBet = false

				local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
					betCheckRecieved = true
					canBet = _canBet
				end)
				
				repeat Wait(0) until betCheckRecieved == true

				RemoveEventHandler(eventHandler)
				
				if canBet then
					renderScaleform = false
					renderTime = false
					renderBet = false

					if selectedBet < 27 then
						if leavingBlackjack == true then leaveBlackjack() return end

						local anim = "place_bet_small"
						
						playerBusy = true
						
						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, 0, 1, 1065353216, 0, 1065353216)
						
						NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 2.0, 0)
						NetworkStartSynchronisedScene(scene)
						
						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500) - 600)
						
						if leavingBlackjack == true then leaveBlackjack() return end

						TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, currentBet, selectedBet, false)

						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))
						
						if leavingBlackjack == true then leaveBlackjack() return end

						playerBusy = false
						
						local idleVar = "idle_var_0"..math.random(1,5)
						
						DebugPrint("IDLING POST-BUSY: "..idleVar)
						
						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
						NetworkStartSynchronisedScene(scene)
					else
						if leavingBlackjack == true then leaveBlackjack() return end

						local anim = "place_bet_large"
						
						playerBusy = true
						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 2.0, 0)
						NetworkStartSynchronisedScene(scene)
						
						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500) - 600)
						
						if leavingBlackjack == true then leaveBlackjack() return end

						TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, currentBet, selectedBet, false)

						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

						if leavingBlackjack == true then leaveBlackjack() return end
						
						playerBusy = false
						
						local idleVar = "idle_var_0"..math.random(1,5)
						
						DebugPrint("IDLING POST-BUSY: "..idleVar)

						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
						NetworkStartSynchronisedScene(scene)
					end
					return
				else
					DisplayHelpText("You don't have enough cash for the bet.", 5000)
				end
			end
		end
		-- TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet)
	end)
end)

RegisterNetEvent("BLACKJACK:RequestMove")
AddEventHandler("BLACKJACK:RequestMove", function(tableIndex, _timeLeft)
	CreateThread(function()
		if tableIndex == nil then
			return
		end

		timeLeft = _timeLeft
		if leavingBlackjack == true then leaveBlackjack() return end
		
		renderScaleform = true
		renderTime = true
		renderHand = true
		
		while true do Wait(0)	
			BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamInt(80)
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(0)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 19, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Overhead Camera")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(1)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 201, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Hit")
			EndScaleformMovieMethod()

			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(2)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 203, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Stand")
			EndScaleformMovieMethod()
			
			if #hand < 3 and #splitHand == 0 then
				BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
				ScaleformMovieMethodAddParamInt(3)
				ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 192, 0))
				ScaleformMovieMethodAddParamPlayerNameString("Double Down")
				EndScaleformMovieMethod()
			end

			if CanSplitHand(hand) == true then
				BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
				ScaleformMovieMethodAddParamInt(4)
				ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 209, 0))
				ScaleformMovieMethodAddParamPlayerNameString("Split")
				EndScaleformMovieMethod()
			end
			
			BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
			EndScaleformMovieMethod()

			if IsControlJustPressed(1, 201) then
				if leavingBlackjack == true then DebugPrint("returning") return end
				
				TriggerServerEvent("BLACKJACK:ReceivedMove", tableIndex, "hit")
				
				renderScaleform = false
				renderTime = false
				renderHand = false
				local anim = Config.Casino.Blackjack.requestCardAnims[math.random(1,#Config.Casino.Blackjack.requestCardAnims)]
				
				playerBusy = true
				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 2.0, 0)
				NetworkStartSynchronisedScene(scene)
				Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*990))

				if leavingBlackjack == true then leaveBlackjack() return end

				playerBusy = false
			
				local idleVar = "idle_var_0"..math.random(1,5)
				
				DebugPrint("IDLING POST-BUSY: "..idleVar)

				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
				NetworkStartSynchronisedScene(scene)
				
				return
			end
			if IsControlJustPressed(1, 203) then
				if leavingBlackjack == true then leaveBlackjack() return end

				TriggerServerEvent("BLACKJACK:ReceivedMove", tableIndex, "stand")
				
				renderScaleform = false
				renderTime = false
				renderHand = false
				local anim = Config.Casino.Blackjack.declineCardAnims[math.random(1,#Config.Casino.Blackjack.declineCardAnims)]
				
				playerBusy = true
				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 2.0, 0)
				NetworkStartSynchronisedScene(scene)
				Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*990))

				if leavingBlackjack == true then leaveBlackjack() return end

				playerBusy = false
				
				local idleVar = "idle_var_0"..math.random(1,5)
				
				DebugPrint("IDLING POST-BUSY: "..idleVar)

				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
				NetworkStartSynchronisedScene(scene)

				return
			end
			if IsControlJustPressed(1, 192) and #hand == 2 and #splitHand == 0 then
				if leavingBlackjack == true then leaveBlackjack() return end

				TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, currentBet)

				local betCheckRecieved = false
				local canBet = false
				local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
					betCheckRecieved = true
					canBet = _canBet
				end)
				
				repeat Wait(0) until betCheckRecieved

				RemoveEventHandler(eventHandler)
				
				if canBet then
					if leavingBlackjack then
						leaveBlackjack()

						return
					end

					TriggerServerEvent("BLACKJACK:ReceivedMove", tableIndex, "double")
					
					renderScaleform = false
					renderTime = false
					renderHand = false
					local anim = "place_bet_double_down"
					
					playerBusy = true
					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 2.0, 0)
					NetworkStartSynchronisedScene(scene)
					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500) - 600)
					
					if leavingBlackjack then
						leaveBlackjack()

						return
					end

					TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, currentBet, selectedBet, true)
					
					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

					if leavingBlackjack then
						leaveBlackjack()

						return
					end

					playerBusy = false
					
					local idleVar = "idle_var_0"..math.random(1,5)
					
					DebugPrint("IDLING POST-BUSY: "..idleVar)

					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
					NetworkStartSynchronisedScene(scene)

					return
				else
					DisplayHelpText("You don't have enough money to double down.", 5000)
				end
			end
			if IsControlJustPressed(1, 209) and CanSplitHand(hand) == true then
				if leavingBlackjack == true then leaveBlackjack() return end

				TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, currentBet)

				local betCheckRecieved = false
				local canBet = false
				local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
					betCheckRecieved = true
					canBet = _canBet
				end)
				
				repeat Wait(0) until betCheckRecieved == true

				RemoveEventHandler(eventHandler)
				
				if canBet then
					if leavingBlackjack == true then leaveBlackjack() return end

					TriggerServerEvent("BLACKJACK:ReceivedMove", tableIndex, "split")
					
					renderScaleform = false
					renderTime = false
					renderHand = false
					local anim = "place_bet_small_split"
					
					if selectedBet > 27 then
						anim = "place_bet_large_split"
					end
					
					playerBusy = true
					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 2.0, 0)
					NetworkStartSynchronisedScene(scene)
					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))
					
					if leavingBlackjack == true then leaveBlackjack() return end

					TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, currentBet, selectedBet, false, true)
					
					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

					if leavingBlackjack == true then leaveBlackjack() return end

					playerBusy = false
					
					local idleVar = "idle_var_0"..math.random(1,5)
					
					DebugPrint("IDLING POST-BUSY: "..idleVar)

					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
					NetworkStartSynchronisedScene(scene)

					return
				else
					DisplayHelpText("You don't have enough money to split.", 5000)
				end
			end
		end
	end)
end)

RegisterNetEvent("BLACKJACK:GameEndReaction")
AddEventHandler("BLACKJACK:GameEndReaction", function(result, reset)
	CreateThread(function()
		
		if #hand == 2 and handValue(hand) == 21 and result == "good" then
			DisplayHelpText("You have Blackjack!", 5000)
		elseif handValue(hand) > 21 and result ~= "good" then
			DisplayHelpText("You went bust.", 5000)
		-- else
		-- 	DisplayHelpText("You " .. Config.Casino.Blackjack.resultNames[result] .. " with " .. handValue(hand) .. ".", 5000)
		end
		
		if reset then
			hand = {}
			splitHand = {}
			renderHand = false
		end

		if leavingBlackjack == true then leaveBlackjack() return end

		local anim = "reaction_"..result.."_var_0"..math.random(1, (result == 'impartial' and 8 or 4))
		
		DebugPrint("Reacting: "..anim)
		
		playerBusy = true
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, false, false, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", anim, 2.0, -2.0, 13, 16, 2.0, 0)
		NetworkStartSynchronisedScene(scene)
		Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", anim)*990))

		if leavingBlackjack == true then leaveBlackjack() return end

		playerBusy = false
		
		idleVar = "idle_var_0"..math.random(1,5)

		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
		NetworkStartSynchronisedScene(scene)
	end)
end)

RegisterNetEvent("BLACKJACK:ForceLeave")
AddEventHandler("BLACKJACK:ForceLeave", function()
	leavingBlackjack = true

	myTableID = nil
end)

RegisterNetEvent("BLACKJACK:RetrieveCards")
AddEventHandler("BLACKJACK:RetrieveCards", function(tableIndex, seat)
	if seat == 0 then
		if dealerHandObjs ~= nil and dealerHandObjs[tableIndex] ~= nil then
			for x,v in pairs(dealerHandObjs[tableIndex]) do
				DeleteEntity(v)
				dealerHandObjs[tableIndex][x] = nil
			end
		end
	else
		if handObjs ~= nil and handObjs[tableIndex] ~= nil and handObjs[tableIndex][seat] ~= nil then
			for x,v in pairs(handObjs[tableIndex][seat]) do
				DeleteEntity(v)
			end
		end

		if chips ~= nil and chips[tableIndex] ~= nil and chips[tableIndex][(5 - seat)] ~= nil then
			for x,v in pairs(chips[tableIndex][(5 - seat)]) do
				DeleteEntity(v)
			end
		end
	end
end)
	
RegisterNetEvent("BLACKJACK:GiveCard")
AddEventHandler("BLACKJACK:GiveCard", function(tableIndex, seat, handSize, card, flipped, split)
	if tableIndex ~= nil and dealerHandObjs ~= nil and dealerHandObjs[tableIndex] ~= nil and handObjs ~= nil and handObjs[tableIndex] ~= nil and spawnedObjects ~= nil then
		CreateThread(function()
			flipped = flipped or false
			split = split or false

			local thisDealerPed = spawnedPeds[tableIndex]

			if PlayerDealers[tableIndex] ~= nil then
				thisDealerPed = GetPlayerPed(GetPlayerFromServerId(PlayerDealers[tableIndex]))
			end
			
			if tableIndex == g_seat and seat == closestChair then
				if split then
					table.insert(splitHand, card)
				else
					table.insert(hand, card)
				end
				
				DebugPrint("GOT CARD " .. card .. " (" .. cardValue(card) .. ")")
				DebugPrint("HAND VALUE " .. handValue(hand))
			elseif seat == 0 then
				table.insert(dealerHand[tableIndex], card)
			end
			
			local model = GetHashKey("vw_prop_cas_card_"..card)
			
			if not HasModelLoaded(model) then
				RequestModel(model)

				repeat Wait(0) until HasModelLoaded(model)
			end

			local card = nil

			if flipped then
				if not HasModelLoaded(jokerModel) then
					RequestModel(jokerModel)

					while not HasModelLoaded(jokerModel) do
						Wait(0)
					end
				end

				initCard[tableIndex] = model

				card = CreateObject(jokerModel, GetEntityCoords(thisDealerPed) - vector3(0.0, 0.0, 1.0), false, false, false)
			end

			if card == nil then
				card = CreateObject(model, GetEntityCoords(thisDealerPed) - vector3(0.0, 0.0, 1.0), false, false, false)
			end

			SetEntityVisible(card, false, 0)
			
			table.insert(spawnedObjects, card)
			
			if seat > 0 then
				table.insert(handObjs[tableIndex][seat], card)
			end

			Wait(100)

			if HighLife.Player.PlayingBlackjack or HighLife.Player.InCasino then
				AttachEntityToEntity(card, thisDealerPed, GetPedBoneIndex(thisDealerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)

				Wait(360)

				SetEntityVisible(card, true, 0)
			end
			
			Wait(840)
			
			DetachEntity(card, 0, true)
			
			if seat == 0 then
				table.insert(dealerHandObjs[tableIndex], card)
				
				SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[tableIndex].coords.x, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.y, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.z, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w, Config.Casino.Blackjack.cardOffsetsDealer[handSize]))
				
				if flipped then
					SetEntityRotation(card, 180.0, 0.0, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w + Config.Casino.Blackjack.cardRotationOffsetsDealer[handSize].z)

					CreateModelSwap(GetEntityCoords(card), 1.0, model, jokerModel, true)
				else
					SetEntityRotation(card, 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w + Config.Casino.Blackjack.cardRotationOffsetsDealer[handSize].z)
				end
			else
				if split then
					SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[tableIndex].coords.x, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.y, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.z, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w, Config.Casino.Blackjack.cardSplitOffsets[5 - seat][handSize]))
					SetEntityRotation(card, 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w + Config.Casino.Blackjack.cardSplitRotationOffsets[5 - seat][handSize])
				else
					SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(Config.Casino.Blackjack.ActiveTables[tableIndex].coords.x, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.y, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.z, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w, Config.Casino.Blackjack.cardOffsets[5 - seat][handSize]))
					SetEntityRotation(card, 0.0, 0.0, Config.Casino.Blackjack.ActiveTables[tableIndex].coords.w + Config.Casino.Blackjack.cardRotationOffsets[5 - seat][handSize])
				end
			end
		end)
	end
end)

CreateThread(function()
	while true do
		if HighLife.Player.PlayingBlackjack then
			if IsControlJustReleased(0, 19) then
				if DoesCamExist(OverheadCam) then
					OverheadCamEnabled = not OverheadCamEnabled

					RenderScriptCams(OverheadCamEnabled, false, 3000, 1, 0, 0)
				end
			end
		else
			if OverheadCamEnabled then
				RenderScriptCams(false, false, 3000, 1, 0, 0)
			end

			if DoesCamExist(OverheadCam) then
				DestroyCam(OverheadCam, 0)
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	RequestAnimDict("anim_casino_b@amb@casino@games@shared@player@")

	local tableObj = nil
	
	while true do
		if not initSystem then
			InitBlackjack()
		end

		if not HighLife.Player.CD and not HighLife.Player.Dead then
			for i,v in pairs(Config.Casino.Blackjack.ActiveTables) do				
				if Vdist(v.coords.x, v.coords.y, v.coords.z, HighLife.Player.Pos) < 3.0 then
					tableObj = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, `vw_prop_casino_blckjack_01`, false, false, false)
					
					if tableObj == 0 then
						tableObj = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, `vw_prop_casino_blckjack_01b`, false, false, false)
					end
					
					if tableObj ~= 0 then
						closestChair = 1

						local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0" .. closestChair))
						local rot = GetWorldRotationOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0" .. closestChair))

						dist = Vdist(coords, GetEntityCoords(HighLife.Player.Ped))
						
						for i=1,4 do
							local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..i))

							if Vdist(coords, GetEntityCoords(HighLife.Player.Ped)) < dist then
								dist = Vdist(coords, GetEntityCoords(HighLife.Player.Ped))

								closestChair = i
							end
						end
						
						local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0" .. closestChair))
						local rot = GetWorldRotationOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0" .. closestChair))
						
						g_coords = coords
						g_rot = rot
						
						local seatAnim = (math.random(2) == 1 and "sit_enter_left_side" or "sit_enter_right_side")

						local canSit = true

						if (Vdist(coords, HighLife.Player.Pos) < 1.5 and not IsAnyPlayerNearCoords(coords, 0.5) and canSit) or IsJob('casino') then
							if IsAnyJobs({'casino'}) then
								if not isBlackjackDealer then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to be the ~y~dealer")
								end

								renderScaleform = isBlackjackDealer

								PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
								PopScaleformMovieFunctionVoid()

								BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
								ScaleformMovieMethodAddParamInt(0)
								ScaleformMovieMethodAddParamInt(0)
								ScaleformMovieMethodAddParamInt(0)
								ScaleformMovieMethodAddParamInt(80)
								EndScaleformMovieMethod()

								BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
								ScaleformMovieMethodAddParamInt(0)
								ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 22, 0))
								ScaleformMovieMethodAddParamPlayerNameString("Start Early")
								EndScaleformMovieMethod()

								BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
								ScaleformMovieMethodAddParamInt(1)
								ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 38, 0))
								ScaleformMovieMethodAddParamPlayerNameString("Leave")
								EndScaleformMovieMethod()
							
								BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
								EndScaleformMovieMethod()

								if IsControlJustPressed(0, 22) then
									TriggerServerEvent('BLACKJACK:DealerOverride', i)
								end

								if IsControlJustPressed(0, 38) then
									isBlackjackDealer = not isBlackjackDealer

									TriggerServerEvent('HighLife:Blackjack:SetDealer', i, not isBlackjackDealer)

									HighLife.Player.PlayingBlackjack = isBlackjackDealer
									HighLife.Player.BlockWeaponSwitch = isBlackjackDealer

									if not isBlackjackDealer then
										ClearPedTasks(HighLife.Player.Ped)

										playerDealerTable = nil
									else
										if not DoesCamExist(OverheadCam) then
											OverheadCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', 1)

											local tableRot = GetEntityRotation(tableObj, 2)

											local cameraPos = GetEntityCoords(tableObj) + cameraPosOffset
											local cameraRot = vector3(cameraRotOffset, tableRot.z)

											SetCamCoord(OverheadCam, cameraPos)
											SetCamFov(OverheadCam, 23.0)
											SetCamRot(OverheadCam, cameraRot, 2)
										end
									
										local scene = NetworkCreateSynchronisedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2, false, true, 1065353216, 0, 1065353216)

										NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@dealer@", "idle", 1000.0, -2.0, 13, 16, 1148846080, 0)

                						NetworkStartSynchronisedScene(scene)
									end

								end
							else
								if v.highStakes then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to play ~y~High-Limit ~p~Blackjack")
								else
									DisplayHelpText("Press ~INPUT_CONTEXT~ to play ~p~Blackjack")
								end
								
								if HighLife.Player.Debug then
									SetTextFont(0)
									SetTextProportional(1)
									SetTextScale(0.0, 0.45)
									SetTextColour(255, 255, 255, 255)
									SetTextDropshadow(0, 0, 0, 0, 255)
									SetTextEdge(2, 0, 0, 0, 150)
									SetTextDropShadow()
									SetTextOutline()
									SetTextEntry("STRING")
									SetTextCentre(1)
									SetDrawOrigin(v.coords)
									AddTextComponentString("table = "..i)
									DrawText(0.0, 0.0)
									ClearDrawOrigin()
								end
								
								if IsControlJustPressed(1, 51) then
									HighLife.Player.PlayingBlackjack = true

									HighLife.Player.BlockWeaponSwitch = true

									HighLife.Player.Voice.CurrentProximity = 5

									local tableRot = GetEntityRotation(tableObj, 2)

									local cameraPos = GetEntityCoords(tableObj) + cameraPosOffset
									local cameraRot = vector3(cameraRotOffset, tableRot.z)

									if not DoesCamExist(OverheadCam) then
										OverheadCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', 1)

										SetCamCoord(OverheadCam, cameraPos)
										SetCamFov(OverheadCam, 23.0)
										SetCamRot(OverheadCam, cameraRot, 2)
									end

									local initPos = GetAnimInitialOffsetPosition("anim_casino_b@amb@casino@games@shared@player@", seatAnim, coords, rot, 0.01, 2)
									local initRot = GetAnimInitialOffsetRotation("anim_casino_b@amb@casino@games@shared@player@", seatAnim, coords, rot, 0.01, 2)
									
									TaskGoStraightToCoord(HighLife.Player.Ped, initPos, 1.0, 800, initRot.z, 0.01)

									Wait(1200)
									
									SetPedCurrentWeaponVisible(HighLife.Player.Ped, 0, true, 0, 0)
									
									local scene = NetworkCreateSynchronisedScene(coords, rot, 2, 0, 1, 1065353216, 0, 1065353216)
									NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", seatAnim, 2.0, -2.0, 13, 16, 2.0, 0)
									NetworkStartSynchronisedScene(scene)

									local scene = NetworkConvertSynchronisedSceneToSynchronizedScene(scene)
									repeat Wait(0) until GetSynchronizedScenePhase(scene) >= 0.99 or HasAnimEventFired(HighLife.Player.Ped, 2038294702) or HasAnimEventFired(HighLife.Player.Ped, -1424880317)

									Wait(1000)

									idleVar = "idle_cardgames"

									scene = NetworkCreateSynchronisedScene(coords, rot, 2, 0, 1, 1065353216, 0, 1065353216)
									NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 2.0, -2.0, 13, 16, 2.0, 0)
									NetworkStartSynchronisedScene(scene)

									repeat Wait(0) until IsEntityPlayingAnim(HighLife.Player.Ped, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 3) == 1

									g_seat = i

									myTableID = g_seat
			
									leavingBlackjack = false

									TriggerServerEvent("BLACKJACK:PlayerSatDown", i, closestChair)

									local endTime = GetGameTimer() + math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", idleVar)*990)

									CreateThread(function() -- Disable pause when while in-blackjack
										local startCount = false
										local count = 0
										while true do
											Wait(0)
											SetPauseMenuActive(false)

											if leavingBlackjack then
												startCount = true
											end

											if startCount == true then
												count = count + 1
											end

											if count > 3000 then -- Make it so it enables 3 seconds after hitting the leave button so the pause menu doesn't show up when trying to leave
												break
											end
										end
									end)

									while true do
										Wait(0)

										if GetGameTimer() >= endTime then
											if playerBusy then
												while playerBusy do
													if HighLife.Player.Dead then
														TriggerServerEvent("BLACKJACK:PlayerRemove", i)

														ClearPedTasks(HighLife.Player.Ped)

														leaveBlackjack()

														break
													end

													Wait(0)
												end
											end
											
											if not leavingBlackjack then
												idleVar = "idle_var_0"..math.random(1,5)

												local scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, false, 1065353216, 0, 1065353216)
												NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 2.0, 0)
												NetworkStartSynchronisedScene(scene)
												endTime = GetGameTimer() + math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", idleVar)*990)
												-- DebugPrint("idling again")
											end
										end
										
										if leavingBlackjack then
											HighLife.Player.PlayingBlackjack = false

											HighLife.Player.BlockWeaponSwitch = false

											if IsAudioSceneActive('DLC_VW_Casino_Cards_Focus_Hand') then
												StopAudioScene('DLC_VW_Casino_Cards_Focus_Hand')
											end

											local scene = NetworkCreateSynchronisedScene(coords, rot, 2, false, false, 1065353216, 0, 1065353216)
											
											NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, "anim_casino_b@amb@casino@games@shared@player@", (math.random(2) == 1 and "sit_exit_left" or "sit_exit_right"), 2.0, -2.0, 13, 16, 2.0, 0)
											NetworkStartSynchronisedScene(scene)
											
											TriggerServerEvent("BLACKJACK:PlayerSatUp", i)

											hand = {}
											splitHand = {}

											OverheadCamEnabled = false

											RenderScriptCams(false, false, 3000, 1, 0, 0)

											Wait(3000)

											ClearPedTasks(HighLife.Player.Ped)

											break
										else
											if HighLife.Player.Dead then
												TriggerServerEvent("BLACKJACK:PlayerRemove", i)
												
												ClearPedTasks(HighLife.Player.Ped)
												
												leaveBlackjack()

												break
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		Wait(0)
	end
end)