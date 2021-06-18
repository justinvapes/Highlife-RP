local oldError = error
local oldTrace = Citizen.Trace

local preError = nil
local preErrorLock = false

local errorWords = {"failure", "error", "not", "failed", "not safe", "invalid", "cannot", ".lua", "server", "client", "attempt", "traceback", "stack", "function"}
local whitelistWords = {"NotSupportedError", "AbortError"}

RegisterNetEvent("HighLife:Sentry:Feedback")
AddEventHandler('HighLife:Sentry:Feedback', function(error_data)
	if error_data ~= nil then
		local thisData = json.decode(error_data)

		table.insert(HighLife.Other.ErrorQueue, {
			issue_id = thisData.issue_id,
			error = thisData.errorText
		})

		Notification_AboveMap('An ~o~error ~s~has occurred, please view your ~y~F1 ~s~menu to report any additional information')
	end
end)

RegisterNUICallback('SentryLoseFocus', function()
	SetNuiFocus(false, false)
end)

function error(...)
	if preError ~= nil then
		preError = preError .. args

		preErrorLock = true

		TriggerServerEvent("HighLife:LogError", GetCurrentResourceName(), preError)

		preError = nil
	else
		preError = args

		CreateThread(function()
			Wait(50)

			if not preErrorLock then
				TriggerServerEvent("HighLife:LogError", GetCurrentResourceName(), preError)

				preError = nil
			end

			preErrorLock = false
		end)
	end
end

local ignoreError = false

function Citizen.Trace(...)
	oldTrace(...)

	ignoreError = false

	if type(...) == "string" then
		args = string.lower(...)

		for _, word in ipairs(errorWords) do
			if string.find(args, word) then
				for _, word in ipairs(whitelistWords) do
					if string.find(args, word) then
						ignoreError = true

						break
					end
				end

				if not ignoreError then
					error(...)
				end

				return
			end
		end
	end
end