local mp_pointing = false
local keyPressed = false

local once = true
local oldval = false
local oldvalped = false

AddEventHandler('baseevents:onPlayerDied', function(killerType, coords)
    mp_pointing = false
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
    mp_pointing = false
end)

local function startPointing()
    LoadAnimationDictionary("anim@mp_point")

    SetPedCurrentWeaponVisible(HighLife.Player.Ped, 0, 1, 1, 1)
    SetPedConfigFlag(HighLife.Player.Ped, 36, 1)

    Citizen.InvokeNative(0x2D537BA194896636, HighLife.Player.Ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)

    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()    
    Citizen.InvokeNative(0xD01015C7316AE176, HighLife.Player.Ped, "Stop")
   
    if not IsPedInjured(HighLife.Player.Ped) then
        ClearPedSecondaryTask(HighLife.Player.Ped)
    end

    if not IsPedInAnyVehicle(HighLife.Player.Ped, 1) then
        SetPedCurrentWeaponVisible(HighLife.Player.Ped, 1, 1, 1, 1)
    end

    SetPedConfigFlag(HighLife.Player.Ped, 36, 0)
    ClearPedSecondaryTask(HighLife.Player.Ped)
end

CreateThread(function()
    while true do
        if not HighLife.Player.Cuffed then
            if once then
                once = false
            end

            if not keyPressed then
                if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(HighLife.Player.Ped) then
                    Wait(200)
                    if not IsControlPressed(0, 29) then
                        keyPressed = true
                        startPointing()
                        mp_pointing = true
                    else
                        keyPressed = true
                        while IsControlPressed(0, 29) do
                            Wait(50)
                        end
                    end
                elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(HighLife.Player.Ped) and mp_pointing) then
                    keyPressed = true
                    mp_pointing = false
                    stopPointing()
                end
            end

            if keyPressed then
                if not IsControlPressed(0, 29) then
                    keyPressed = false
                end
            end
            
            if Citizen.InvokeNative(0x921CE12C489C4C41, HighLife.Player.Ped) and not mp_pointing then
                stopPointing()
            end

            if Citizen.InvokeNative(0x921CE12C489C4C41, HighLife.Player.Ped) then
                if not IsPedOnFoot(HighLife.Player.Ped) then
                    stopPointing()
                else
                    local camPitch = GetGameplayCamRelativePitch()

                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end

                    camPitch = (camPitch + 70.0) / 112.0

                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)

                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end

                    camHeading = (camHeading + 180.0) / 360.0

                    local blocked = 0
                    local nn = 0

                    local coords = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, HighLife.Player.Ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)

                    Citizen.InvokeNative(0xD5BB4025AE449A4E, HighLife.Player.Ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, HighLife.Player.Ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, HighLife.Player.Ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, HighLife.Player.Ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

                end
            end
        end

        Wait(1)
    end
end)