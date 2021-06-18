RegisterNetEvent("HighLife:Container:Update")
AddEventHandler('HighLife:Container:Update', function(container_reference, container_data)
	HighLife.Container:SetContainerData(container_reference, container_data)

	if HighLife.Container.ActiveContainerReference ~= nil and HighLife.Container.ActiveContainerReference == container_reference then
		HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config = Config.Containers.ValidTypes[HighLife.Container:GetContainerType(HighLife.Container.Data[HighLife.Container.ActiveContainerReference])]
	end
end)

RegisterNetEvent("HighLife:Container:OpenContainer")
AddEventHandler('HighLife:Container:OpenContainer', function(container_type, container_reference)
	HighLife.Container.Data[container_reference] = json.decode(container_data)
end)

RegisterCommand('ct_open', function(source, args, mis)
	-- TODO: remove this afterwards
	if HighLife.Settings.Development or HighLife.Player.Special then
		if args[1] ~= nil then
			HighLife.Container:OpenContainer(args[1])
		end
	end
end)

RegisterCommand('ct_inventory', function(source, args, mis)
	-- TODO: remove this afterwards
	if HighLife.Settings.Development or HighLife.Player.Special then
		HighLife.Container:OpenContainer('player:' .. string.format('%s:%s', HighLife.Player.Identifier, HighLife.Player.CurrentCharacterReference))
	end
end)

function HighLife.Container:SetContainerData(reference, data)
	if reference ~= nil and data ~= nil then
		HighLife.Container.Data[reference] = (type(data) == 'string' and json.decode(data) or data)
	end
end

function HighLife.Container:GetContainerType(container)
	return container.type
end

function HighLife.Container:GetContainerWeight(container, specificItem)
	local thisWeight = 0

	if container ~= nil and container.data ~= nil then
		local skip = false

		for i=1, #container.data do
			skip = false

			if specificItem ~= nil and container.data[i].item ~= specificItem then
				skip = true
			end
			
			if not skip then
				thisWeight = thisWeight + tonumber(container.data[i].weight)
			end
		end
	end

	return math.floor(thisWeight)
end

function HighLife.Container:GetContainer(container_reference, container_limit_reference)
	local containerCallbackFailed = false

	if container_reference ~= nil then
		if HighLife.Container.Data[container_reference] ~= nil then
			if HighLife.Container.Data[container_reference].canStore then
				return container_reference
			else
				HighLife.Container.Data[container_reference] = nil
			end
		end

		HighLife:ServerCallback('HighLife:Container:GetContainer', function(containerData, canStore)
			if containerData ~= nil then
				HighLife.Container.Data[container_reference] = json.decode(containerData)
			else
				containerCallbackFailed = true
			end
		end, container_reference, container_limit_reference)

		while HighLife.Container.Data[container_reference] == nil and not containerCallbackFailed do
			Wait(1)
		end

		if not containerCallbackFailed then
			return container_reference
		end
	end

	return nil
end

function HighLife.Container:OpenContainer(container_reference, container_limit_reference)
	HighLife.Container.ActiveContainerReference = nil

	if container_reference ~= nil then
		HighLife.Container.ActiveContainerReference = self:GetContainer(container_reference, container_limit_reference)
	else
		print('invalid container somehow')
	end

	if HighLife.Container.ActiveContainerReference ~= nil then
		TriggerServerEvent('HighLife:Container:ViewStatus', HighLife.Container.Data[HighLife.Container.ActiveContainerReference].reference, true)

		if HighLife.Container:GetContainerType(HighLife.Container.Data[HighLife.Container.ActiveContainerReference]) ~= nil then
			HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config = Config.Containers.ValidTypes[HighLife.Container:GetContainerType(HighLife.Container.Data[HighLife.Container.ActiveContainerReference])]

			RMenu:Get('container', 'main'):SetTitle(HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.Name or 'ctn-name invalid')
			RMenu:Get('container', 'main'):SetSubtitle((HighLife.Container.Data[HighLife.Container.ActiveContainerReference].config.Description or ''))

			RageUI.Visible(RMenu:Get('container', 'main'), true)
		else
			HighLife.Container.Data[HighLife.Container.ActiveContainerReference] = nil

			Notification_AboveMap('Invalid container type "' .. tostring(HighLife.Container:GetContainerType(HighLife.Container.Data[HighLife.Container.ActiveContainerReference])) .. '"')
		end
	end
end