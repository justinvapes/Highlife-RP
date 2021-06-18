HighLife.Skills = {}

RegisterNetEvent('debug_skill')
AddEventHandler('debug_skill', function(skillName, skillPoints)
	if HighLife.Settings.Development or HighLife.Player.Special then
		HighLife.Skills:AddSkillPoints(skillName, skillPoints)
	end
end)

function HighLife.Skills:IsValidSkill(thisSkillName)
	for skillName, skillData in pairs(Config.Skills) do
		if thisSkillName == skillName then
			return true
		end
	end

	return false
end

function HighLife.Skills:GetSkillConfig(getSkillName)
	if self:IsValidSkill(getSkillName) then
		for skillName,skillData in pairs(Config.Skills) do
			if getSkillName == skillName then
				return skillData
			end
		end
	end

	return nil
end

function HighLife.Skills:GetSkillPoints(getSkillName)
	if self:IsValidSkill(getSkillName) then
		if HighLife.Player.Skills ~= nil and HighLife.Player.Skills[getSkillName] ~= nil then
			return HighLife.Player.Skills[getSkillName]
		end

		return 0
	end

	return nil
end

function HighLife.Skills:GetSkillLevel(getSkillName)
	local calculatedLevel = 1
	
	if self:IsValidSkill(getSkillName) then
		if HighLife.Player.Skills ~= nil then
			for skillName,skillPoints in pairs(HighLife.Player.Skills) do
				if getSkillName == skillName then
					local thisSkillConfig = self:GetSkillConfig(getSkillName)

					if thisSkillConfig.LevelDivision ~= nil then
						local calculatedLevel = math.floor(skillPoints / thisSkillConfig.LevelDivision)

						return {
							points = skillPoints,
							level = calculatedLevel,
							useful_level = (thisSkillConfig.MaxUsefulLevel ~= nil and (calculatedLevel > thisSkillConfig.MaxUsefulLevel and thisSkillConfig.MaxUsefulLevel or calculatedLevel) or calculatedLevel)
						}
					end

					return {
						level = skillPoints,
						useful_level = skillPoints,
						points = skillPoints
					}
				end
			end
		end

		return {
			level = 1,
			points = 0,
			useful_level = 1,
		}
	end

	return nil
end

function HighLife.Skills:AddSkillPoints(thisSkillName, skillPoints)
	if self:IsValidSkill(thisSkillName) then
		local currentLevel = nil
		local thisSkillConfig = self:GetSkillConfig(thisSkillName)

		if HighLife.Player.Skills == nil then
			HighLife.Player.Skills = {}
		end

		if HighLife.Player.Skills[thisSkillName] == nil then
			HighLife.Player.Skills[thisSkillName] = (thisSkillConfig.startingPoints ~= nil and thisSkillConfig.startingPoints or 0)
		end
		
		if thisSkillConfig.LevelDivision ~= nil then
			currentLevel = math.floor(HighLife.Player.Skills[thisSkillName] / thisSkillConfig.LevelDivision)
		end

		HighLife.Player.Skills[thisSkillName] = HighLife.Player.Skills[thisSkillName] + skillPoints

		if currentLevel ~= nil and (math.floor(HighLife.Player.Skills[thisSkillName] / thisSkillConfig.LevelDivision) > currentLevel) then
			currentLevel = math.floor(HighLife.Player.Skills[thisSkillName] / thisSkillConfig.LevelDivision)

			ShowNotificationWithIcon(string.format('Your %s level is now ~y~%s!', string.lower(thisSkillName), currentLevel), '~g~You leveled up', 'Congratulations', 'CHAR_SOCIAL_CLUB')
		end

		if thisSkillConfig.Limit ~= nil then
			if HighLife.Player.Skills[thisSkillName] > thisSkillConfig.Limit then
				HighLife.Player.Skills[thisSkillName] = thisSkillConfig.Limit
			end
		end

		self:UpdateSkillData()
	end
end

function HighLife.Skills:RemoveSkillPoints(thisSkillName, skillPoints)
	if self:IsValidSkill(thisSkillName) then
		if HighLife.Player.Skills ~= nil and HighLife.Player.Skills[thisSkillName] ~= nil then
			HighLife.Player.Skills[thisSkillName] = HighLife.Player.Skills[thisSkillName] - skillPoints

			if HighLife.Player.Skills[thisSkillName] < 0 then
				HighLife.Player.Skills[thisSkillName] = 0
			end

			self:UpdateSkillData()
		end
	end
end

function HighLife.Skills:UpdateSkillData()
	if HighLife.Player.Skills ~= nil then
		HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(thisToken)
			TriggerServerEvent('HighLife:Skills:Update', json.encode(HighLife.Player.Skills), thisToken)
		end)
	end
end
