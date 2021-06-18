local isSpinningWheel = false

local wheelEntity = nil

local WheelWinIndex = nil

local finishSpinng = false

RegisterNetEvent("HighLife:Casino:SpinWheel")
AddEventHandler("HighLife:Casino:SpinWheel", function(thisWinIndex, player)
	CreateThread(function()
		-- 20 total win options
		local thisAngle = (((thisWinIndex - 1) * 18) + (360 * 20)) / 2

		local wheelSpinning = true 

		local thisSpinPlayer = player

		WheelWinIndex = thisWinIndex

		Debug('Lucky7Wheel Index: ' .. WheelWinIndex)

		local currentWheelAngle = nil

		local spinSpeed = 15.0 -- 15.0

		local endPosAngle = (thisWinIndex * 18.0)

		if math.random(2) == 1 then
			endPosAngle = endPosAngle - ToFloat(math.random(1, 4))
		else
			endPosAngle = endPosAngle + ToFloat(math.random(1, 4))
		end
		
		if thisSpinPlayer == HighLife.Player.ServerId then
			local initWheelSound = GetSoundId()

			PlaySoundFromCoord(initWheelSound, "Spin_Start", Config.Casino.LuckyWheel.WheelPosition, "dlc_vw_casino_lucky_wheel_sounds", true, 0, 0)

			ReleaseSoundId(initWheelSound)
		end

		Wait(100)

		SetEntityRotation(wheelEntity, 0.0, endPosAngle, 0.0, 1, true)

		local playSound = nil

		local tickSoundId = nil

		local flooredAngle = nil

		local lastTime = GameTimerPool.GlobalGameTime

		while wheelSpinning do
			currentWheelAngle = GetEntityRotation(wheelEntity, 1)

			flooredAngle = math.floor(currentWheelAngle.y)

			if flooredAngle < 0 then
				flooredAngle = flooredAngle * -1.0
			end

			if thisSpinPlayer == HighLife.Player.ServerId then
				if spinSpeed < 2.5 then
					if Config.Casino.LuckyWheel.TickPoints[flooredAngle] then
						if playSound == nil or playSound ~= flooredAngle then
							playSound = flooredAngle

							if tickSoundId ~= nil then
								ReleaseSoundId(tickSoundId)
							end

							tickSoundId = GetSoundId()

							PlaySoundFromCoord(tickSoundId, "Spin_Single_Ticks", Config.Casino.LuckyWheel.WheelPosition, "dlc_vw_casino_lucky_wheel_sounds", true, 0, 0)
						end
					end
				end
			end

			spinSpeed = spinSpeed - (spinSpeed < 1.0 and (spinSpeed < 0.5 and 0.0005 or 0.001) or 0.01)

			if spinSpeed <= 0.0 then
				wheelSpinning = false
			end

			wheelAngle = currentWheelAngle.y - spinSpeed

			SetEntityRotation(wheelEntity, 0.0, wheelAngle, 0.0, 1, true)

			Wait(1)
		end

		if thisSpinPlayer == HighLife.Player.ServerId then
			finishSpinng = true

			local winSoundId = GetSoundId()

			PlaySoundFromCoord(winSoundId, "Win", Config.Casino.LuckyWheel.WheelPosition, "dlc_vw_casino_lucky_wheel_sounds", true, 0, 0)

			SetVariableOnSound(winSoundId, "winSize", 1.0) -- TODO: prize index variable win

			ReleaseSoundId(winSoundId)
		end

		Wait(50)

		isSpinningWheel = false
	end)
end)

AddEventHandler("onResourceStop", function(r)
	if r == GetCurrentResourceName() then
		if wheelEntity ~= nil then
			DeleteEntity(wheelEntity)
		end
	end
end)

function PlaySpinAnimation(thisAnim, loopScene, spinDelay, animPreTime)
	local testVec = vector3(1111.052, 229.8492, -50.6409)
	local testRot = vector3(0.0, 0.0, 0.0)

	local thisAnimDict = Config.Casino.LuckyWheel.AnimDict .. (isMale() and 'male' or 'female')

	if not HasAnimDictLoaded(thisAnimDict) then
		RequestAnimDict(thisAnimDict)

		repeat Wait(1) until HasAnimDictLoaded(thisAnimDict)
	end

	local thisScene = NetworkCreateSynchronisedScene(testVec, testRot, 2, not loopScene, loopScene, 1065353216, 0, 1065353216)

	NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, thisScene, thisAnimDict, thisAnim, 8.0, -8.0, 5, 0, 1148846080, 0)

	NetworkStartSynchronisedScene(thisScene)

	RemoveAnimDict(thisAnimDict)

	if spinDelay ~= nil then
		CreateThread(function()
			Wait(spinDelay)

			TriggerServerEvent('HighLife:Casino:SpinWheel')
		end)
	end

	if not loopScene then
		Wait((math.floor(GetAnimDuration(thisAnimDict, thisAnim) * 1000) - 10) - (animPreTime and animPreTime or 0))
	end
end

CreateThread(function()
	-- init the wheel face
	if not HasModelLoaded(Config.Casino.LuckyWheel.SpinWheelModel) then
		RequestModel(Config.Casino.LuckyWheel.SpinWheelModel)

		repeat Wait(0) until HasModelLoaded(Config.Casino.LuckyWheel.SpinWheelModel)
	end

	wheelEntity = CreateObjectNoOffset(Config.Casino.LuckyWheel.SpinWheelModel, Config.Casino.LuckyWheel.WheelFrontPosition, false, false, true)

	SetEntitySomething(wheelEntity, true)
	SetEntityCanBeDamaged(wheelEntity, false)

	local canSpinThisTime = false

	while true do
		if not HighLife.Player.CD then
			if not isSpinningWheel then
				if Vdist(HighLife.Player.Pos, Config.Casino.LuckyWheel.WheelPosition) < 2.0 then
					if HighLife.Settings.Development or HighLife.Player.Debug then
						DisplayHelpText('Press ~INPUT_PICKUP~ to spin the ~b~lucky wheel')

						if IsControlJustReleased(0, 38) then
							isSpinningWheel = true 

							HighLife:ServerCallback('HighLife:Casino:SpinWheel', function(canSpin)
								if HighLife.Player.Debug or canSpin then
									TaskGoStraightToCoord(HighLife.Player.Ped, Config.Casino.LuckyWheel.AnimOffsetPosition, 1.0, 3000, 315.50, 0.0)

									Wait(2000)

									PlaySpinAnimation('Enter_to_ArmRaisedIDLE', false, nil, 30)

									PlaySpinAnimation('ArmRaisedIDLE_to_SpinningIDLE_High', false, 30)

									PlaySpinAnimation('SpinningIDLE_High', true)
								else
									isSpinningWheel = false
								end
							end)
						end
					else
						DisplayHelpText('Coming soon...')
					end
				end
			else
				if finishSpinng then
					finishSpinng = false

					TriggerServerEvent('HighLife:Casino:GetPrize')

					-- if WheelWinIndex > 0 then
						PlaySpinAnimation('Win', false)
					-- elseif WheelWinIndex > 7 then
					-- 	PlaySpinAnimation('Win_Big', false)
					-- elseif WheelWinIndex > 15 then
					-- 	PlaySpinAnimation('Win_Huge', false)
					-- end

					ClearPedTasks(HighLife.Player.Ped)
				end
			end
		end

		Wait(1)
	end
end)