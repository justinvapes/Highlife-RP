local blackBarHeight = 0.0

RegisterNetEvent("HighLife:HUD:ForceState")
AddEventHandler("HighLife:HUD:ForceState", function(state)
	HighLife.Player.HideHUD = state
end)

function SwitchBlackBarHeight()
    if blackBarHeight == 0.0 then
    	HighLife.Player.HideHUD = true

        blackBarHeight = 0.1
    elseif blackBarHeight == 0.1 then
        blackBarHeight = 0.15
    elseif blackBarHeight == 0.15 then
        blackBarHeight = 0.19
    elseif blackBarHeight == 0.19 then
    	HighLife.Player.HideHUD = false
    	
        blackBarHeight = 0.0
    end
end

CreateThread(function()
    while true do
        -- Left Alt + Up Arrow
        if IsControlPressed(0, 19) and IsControlJustPressed(0, 172) then
            SwitchBlackBarHeight()
        end

        if blackBarHeight ~= 0.0 then
            DrawRect(0.5, blackBarHeight / 2, 1.0, blackBarHeight, 0, 0, 0, 255)
            DrawRect(0.5, 1 - blackBarHeight / 2, 1.0, blackBarHeight, 0, 0, 0, 255)
        end

        HideHudComponentThisFrame(1)  -- Wanted Stars
		HideHudComponentThisFrame(3) -- Cash
		HideHudComponentThisFrame(4) -- MP Cash
		HideHudComponentThisFrame(13) -- Cash
		HideHudComponentThisFrame(17) -- Save
		HideHudComponentThisFrame(20) -- Weaponh

        Wait(1)
    end
end)

SafeZone = {}
SafeZone.__index = SafeZone

SafeZone.Size = function() return GetSafeZoneSize() end

SafeZone.Left = function() return (1.0 - SafeZone.Size()) * 0.5 end
SafeZone.Right = function() return 1.0 - SafeZone.Left() end

SafeZone.Top = SafeZone.Left
SafeZone.Bottom = SafeZone.Right

Bar = {}
Bar.__index = Bar

Bar.Width = 0.165
Bar.Height = 0.035

Bar.ProgressWidth = Bar.Width / 2.65
Bar.ProgressHeight = Bar.Height / 2.65

Bar.Texture = 'all_black_bg'
Bar.TextureDict = 'timerbars'

Text = { }
Text.__index = Text

Text.Alignment = {
	['Left'] = 1,
	['Center'] = 2,
	['Right'] = 3,
}
function Bar.DrawTextBar(title, text, index)
	RequestStreamedTextureDict(Bar.TextureDict)
	if not HasStreamedTextureDictLoaded(Bar.TextureDict) then return end

	local index = index or 1
	local x = SafeZone.Right() - Bar.Width / 2
	local y = SafeZone.Bottom() - Bar.Height / 2 - (index - 1) * (Bar.Height + 0.0038) - 0.05

	DrawSprite(Bar.TextureDict, Bar.Texture, x, y, Bar.Width, Bar.Height, 0.0, 255, 255, 255, 160)

	Text.Draw(tostring(title), { x = SafeZone.Right() - Bar.Width / 2, y = y - 0.009 }, false, false, 0.3, false, false, Text.Alignment.Right)
	Text.Draw(tostring(text), { x = SafeZone.Right() - 0.00285, y = y - 0.0165 }, false, false, 0.425, false, false, Text.Alignment.Right)
end

function Bar.DrawProgressBar(title, progress, index, color)
	RequestStreamedTextureDict(Bar.TextureDict)
	if not HasStreamedTextureDictLoaded(Bar.TextureDict) then return end

	local index = index or 1
	local x = SafeZone.Right() - Bar.Width / 2
	local y = SafeZone.Bottom() - Bar.Height / 2 - (index - 1) * (Bar.Height + 0.0038) - 0.05

	DrawSprite(Bar.TextureDict, Bar.Texture, x, y, Bar.Width, Bar.Height, 0.0, 255, 255, 255, 160)

	Text.Draw(tostring(title), { x = SafeZone.Right() - Bar.Width / 2, y = y - 0.009 }, false, false, 0.3, false, false, Text.Alignment.Right)

	local barColor = color or { r = 255, g = 255, b = 255 }
	local progressX = x + Bar.Width / 2 - Bar.ProgressWidth / 2 - 0.00285 * 2
	DrawRect(progressX, y, Bar.ProgressWidth, Bar.ProgressHeight, barColor.r, barColor.g, barColor.b, 96)

	local progressWidth = Bar.ProgressWidth * progress
	DrawRect(progressX - (Bar.ProgressWidth - progressWidth) / 2, y, progressWidth, Bar.ProgressHeight, barColor.r, barColor.g, barColor.b, 255)
end

function Text.Draw(text, position, font, color, scale, outline, shadow, alignment, width)
	SetTextFont(font or 0)

	if not color then color = { r = 255, g = 255, b = 255, a = 255 } end
	SetTextColour(color.r, color.g, color.b, color.a)

	SetTextScale(scale or 1.0, scale or 1.0)

	if outline then SetTextOutline() end

	if shadow then
		SetTextDropShadow()
		SetTextDropshadow(2, 0, 0, 0, 255)
	end

	if alignment then
		if alignment == Text.Alignment.Center then SetTextCentre(true)
		elseif alignment == Text.Alignment.Right then
			SetTextRightJustify(true)

			if width then SetTextWrap(position.x - width, position.x)
			else SetTextWrap(SafeZone.Left(), position.x) end
		end
	end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(position.x, position.y)
end