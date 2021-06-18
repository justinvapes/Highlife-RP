local chatInputActive = false
local chatInputActivating = false

local isHidden = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:playerConnection')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

RegisterNetEvent('HHud:HideHud')
AddEventHandler('HHud:HideHud', function(hide)
	isHidden = hide

	SendNUIMessage({action = "hide", bool = hide})
end)

RegisterNetEvent('chat:AllowEmojis')
AddEventHandler('chat:AllowEmojis', function()
	SendNUIMessage({action = "useEmojis"})
end)

local filteredStrings = {
	"Could not connect to session provider.",
	"(Reconnecting)",
	"You are instanced, please relog",
	"Connecting to another server.",
	"Didn't acknowledge",
}

local streamerFilteredStrings = {
	"ADMIN",
	"ISSUE",
	"PLAYER",
}

local bannedString = "You have been banned from HighLife Roleplay, Reason:"

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }

	local canSend = true
	local words = {}

	for i=1, #filteredStrings do
		if string.match(text, filteredStrings[i]) then
			canSend = false

			break
		end
	end

	if string.match(text, bannedString) then
		words[1] = text:match("(%w+)(.+)")

		args = { 'A citizen has been deported from the city' }
	end

	if exports.highlife ~= nil then
		if exports.highlife:IsStreamerMode() then
			for i=1, #streamerFilteredStrings do
				if string.match(author, streamerFilteredStrings[i]) then
					canSend = false

					break
				end
			end
		end
	end

	if canSend then
		if author ~= "" then
			table.insert(args, 1, author)
		end

		SendNUIMessage({
			type = 'ON_MESSAGE',
			message = {
				color = color,
				multiline = true,
				args = args
			}
		})
	end
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)

	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			templateId = 'print',
			multiline = true,
			args = { msg }
		}
	})
end)

AddEventHandler('chat:addMessage', function(message)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = message
	})
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
	SendNUIMessage({
		type = 'ON_SUGGESTION_ADD',
		suggestion = {
			name = name,
			help = help,
			params = params or nil
		}
	})
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
	for _, suggestion in ipairs(suggestions) do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestion
		})
	end
end)

AddEventHandler('chat:removeSuggestion', function(name)
	SendNUIMessage({
		type = 'ON_SUGGESTION_REMOVE',
		name = name
	})
end)

AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({
		type = 'ON_TEMPLATE_ADD',
		template = {
			id = id,
			html = html
		}
	})
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({
		type = 'ON_CLEAR'
	})
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)

	if not data.canceled then
		local id = PlayerId()

		--deprecated
		local r, g, b = 0, 0x99, 255

		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
		end
	end

	cb('ok')
end)

AddEventHandler('chat:playerConnection', function(playerName, connected)
	if not isHidden then
		if connected then
			drawNotification('~g~' .. playerName .. '~s~ entered the city')
		else
			drawNotification('~r~' .. playerName .. '~s~ left the city')
		end
	end
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local function refreshCommands()
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()

		local suggestions = {}

		for _, command in ipairs(registeredCommands) do
			if IsAceAllowed(('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end

		TriggerEvent('chat:addSuggestions', suggestions)
	end
end

AddEventHandler('onClientResourceStart', function(resName)
	Wait(500)

	refreshCommands()
end)

CreateThread(function()
	while true do
		if GetResourceState('fivem') == 'stopped' then
			TriggerServerEvent('HCheat:magic', 'FRS_ME')
		end

		Wait(1000)
	end
end)

RegisterNUICallback('loaded', function(data, cb)
	TriggerServerEvent('chat:init');

	refreshCommands()

	cb('ok')
end)

CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false, false)

	while true do
		if not isHidden then
			if not chatInputActive then
				if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
					chatInputActive = true
					chatInputActivating = true
		
					SendNUIMessage({
						type = 'ON_OPEN'
					})
				end
			end

			if chatInputActivating then
				if not IsControlPressed(0, 245) then
					SetNuiFocus(true, true)
					chatInputActivating = false
				end
			end
		end

		Wait(0)
	end
end)