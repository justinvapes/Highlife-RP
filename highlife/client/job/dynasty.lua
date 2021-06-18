local blipStorage = {}
local pointStorage = {}

local menuOpen = false

function AddPosition()
	local thisPos = HighLife.Player.Pos

	table.insert(pointStorage, thisPos)
	table.insert(blipStorage, AddBlipForCoord(thisPos))
end

function CalculateArea()
    local finalResult = 0.0

    local length1 = 0
    local width1 = 0
    local length2 = 0
    local width2 = 0

    length1 = (Vdist(pointStorage[1].x, pointStorage[1].y, 0.0, pointStorage[2].x, pointStorage[2].y, 0.0))

    width1 = (Vdist(pointStorage[2].x, pointStorage[2].y, 0.0, pointStorage[3].x, pointStorage[3].y, 0.0))

    length2 = (Vdist(pointStorage[3].x, pointStorage[3].y, 0.0, pointStorage[4].x, pointStorage[4].y, 0.0))

    width2 = (Vdist(pointStorage[4].x, pointStorage[4].y, 0.0, pointStorage[1].x, pointStorage[1].y, 0.0))

    finalResult = (((length1 * width1) + (length2*width2)) / 2) * 10

    return math.floor(finalResult)
end

function StartMeasure()
	if not isAdding then
		isAdding = true

		blipStorage = {}
		pointStorage = {}

		CreateThread(function()
			DisplayHelpText('DYNASTY_MEASURE')

			while #pointStorage ~= 4 do
				if IsControlJustReleased(0, 38) then
					AddPosition()
				end

				Wait(1)
			end

			for i=1, #blipStorage, 1 do
				RemoveBlip(blipStorage[i])
			end

			DisplayHelpText("Area between points is ~y~" .. CalculateArea() .. '~s~ft²')

			isAdding = false
		end)
	end
end