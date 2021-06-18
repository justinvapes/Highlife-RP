function HighLife:ServerCallback(callbackName, cb, ...)
	HighLife.Other.Callbacks.Data[HighLife.Other.Callbacks.RequestID] = cb

	TriggerServerEvent('HighLife:Callback:Register', callbackName, HighLife.Other.Callbacks.RequestID, ...)

	if HighLife.Other.Callbacks.RequestID < 65535 then
		HighLife.Other.Callbacks.RequestID = HighLife.Other.Callbacks.RequestID + 1
	else
		HighLife.Other.Callbacks.RequestID = 0
	end
end

RegisterNetEvent('HighLife:Callback:Call')
AddEventHandler('HighLife:Callback:Call', function(thisRequestID, ...)
	if HighLife.Other.Callbacks.Data[thisRequestID] ~= nil then
		HighLife.Other.Callbacks.Data[thisRequestID](...)
		HighLife.Other.Callbacks.Data[thisRequestID] = nil
	end
end)