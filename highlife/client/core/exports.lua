local allowed_export_configs = {
	'Licenses',
	'Dealerships'
}

function GetBaseConfig(key)
	local exportConfig = false

	for i=1, #allowed_export_configs do
		if allowed_export_configs[i] == key then
			exportConfig = true

			break
		end
	end

	if exportConfig then
 		return Config[key]
	else
		TriggerServerEvent('HCheat:magic', 'LUAVME')
	end
end

function LockVehicleHLL(vehicle, locked, overrideStatus)
	LockVehicle(vehicle, locked, overrideStatus)
end

function GetIsDevelopment()
	return HighLife.Settings.Development
end

function IsStreamerMode()
	return HighLife.Player.StreamerMode
end

function IsCrouchingDisabled()
	return HighLife.Player.DisableCrouching
end

function GetCD()
	return HighLife.Player.CD
end

function IsSwitchingCharacter()
	return HighLife.Player.InCharacterMenu
end

function IsPlayingBlackjack()
	return HighLife.Player.PlayingBlackjack
end

function GetBankID()
	return HighLife.Player.BankID
end

function GetLicenses()
    return HighLife.Player.Licenses
end

function IsHandsUp()
    return HighLife.Player.HandsUp
end

function InAmbulance()
    return HighLife.Player.InAmbulance
end

function GetHandCuffStatus()
    return HighLife.Player.Cuffed
end

function SetPhoneChannel(channel)
	HighLife.Player.Voice.PhoneChannel = channel
end

function SetEntryCheck()
	HighLife.Player.EntryCheck = true
end

function IsHidingInTrunk()
	return HighLife.Player.HidingInTrunk
end

function GetHasSpecialItem(itemName)
	return (HighLife.Player.SpecialItems[itemName] ~= nil and HighLife.Player.SpecialItems[itemName] or false)
end

function GetPlayerJobData()
	return HighLife.Player.Job
end

function CoreControlsBlocked()
	return HighLife.Player.CoreControlBlocker
end

function CreateExtObject(model, coords, heading, freeze)
	local thisObject = nil

	HighLife:CreateObject(model, { x = coords.x, y = coords.y, z = coords.z }, heading, freeze, function(object)
		thisObject = object
	end)

	while thisObject == nil do
		Wait(1)
	end

	return thisObject
end

function CreateExtVehicle(model, coords, heading, freeze)
	local thisVehicle = nil

	HighLife:CreateVehicle(model, {x = coords.x, y = coords.y, z = coords.z }, heading, true, true, function(vehicle)
		thisVehicle = vehicle
	end)

	while thisVehicle == nil do
		Wait(1)
	end

	return thisVehicle
end

function GetIsInDetention()
	if HighLife.Player.Detention.InJail or HighLife.Player.Detention.InMorgue or HighLife.Player.Detention.InICU then
		return true
	end
	
	return false
end

function GetCurrentCharacterData()
	local characterData = nil

	if HighLife.Player.CharacterData ~= nil and HighLife.Player.CurrentCharacterReference ~= nil then
		for _,thisCharacterData in pairs(HighLife.Player.CharacterData) do
			if thisCharacterData.reference == HighLife.Player.CurrentCharacterReference then
				characterData = thisCharacterData

				break
			end
		end
	end

	return characterData
end