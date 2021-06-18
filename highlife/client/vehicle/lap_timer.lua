RegisterCommand('lap_timer', function()
	CreateLapTimer()
end)

local ActiveLapTimer = nil

function CreateLapTimer()
	if ActiveLapTimer ~= nil then
		ActiveLapTimer = nil

		return
	end

	ActiveLapTimer = {
		lapCount = 0,
		bestTime = nil,
		startTime = nil,
		canFinish = false,
		startPos = HighLife.Player.Pos,
	}

	CreateThread(function()
		while ActiveLapTimer ~= nil do
			if ActiveLapTimer.startTime ~= nil then
				if Vdist(HighLife.Player.Pos, ActiveLapTimer.startPos) > 20.0 then
					ActiveLapTimer.canFinish = true
				end

				if ActiveLapTimer.canFinish then
					DrawMarker(4, ActiveLapTimer.startPos, 0, 0, 0, vector3(0.0, 0.0, 0.0), vector3(3.0, 3.0, 3.0), vector4(255, 0, 0, 255), 0, 0, 0, 0)

					if Vdist(HighLife.Player.Pos, ActiveLapTimer.startPos) < 10.0 then
						ActiveLapTimer.lapCount = ActiveLapTimer.lapCount + 1

						ActiveLapTimer.canFinish = false

						if ActiveLapTimer.bestTime ~= nil then
							if (GameTimerPool.GlobalGameTime - ActiveLapTimer.startTime) < ActiveLapTimer.bestTime then
								ActiveLapTimer.bestTime = (GameTimerPool.GlobalGameTime - ActiveLapTimer.startTime)
							end
						else
							ActiveLapTimer.bestTime = (GameTimerPool.GlobalGameTime - ActiveLapTimer.startTime)
						end

						ActiveLapTimer.startTime = GameTimerPool.GlobalGameTime
					end
				end
			elseif Vdist(ActiveLapTimer.startPos, HighLife.Player.Pos) > 0.5 then
				ActiveLapTimer.startTime = GameTimerPool.GlobalGameTime
			end

			DrawBottomText(string.format('~y~Current time~s~: %s', (ActiveLapTimer.startTime ~= nil and ((GameTimerPool.GlobalGameTime - ActiveLapTimer.startTime) / 1000.0)) or 'Awaiting Start'), 0.5, 0.90, 0.4)
			DrawBottomText(string.format('~g~Best~s~: %s - ~b~Laps~s~: %s', (ActiveLapTimer.bestTime ~= nil and (ActiveLapTimer.bestTime / 1000.0) or 'Not set'), ActiveLapTimer.lapCount), 0.5, 0.95, 0.4)

			Wait(1)
		end
	end)
end