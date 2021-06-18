function GetWeightString(thisWeightValue)
	local useQuantifier = nil

	for weightName,weightValue in pairs(Config.Inventory.WeightQuantifiers[HighLife.Other.WeightPreference]) do
		if thisWeightValue > weightValue then
			if useQuantifier ~= nil then
				if weightValue > useQuantifier.value then
					useQuantifier = {
						quantifier = weightName,
						value = weightValue
					}
				end
			else
				useQuantifier = {
					quantifier = weightName,
					value = weightValue
				}
			end
		end
	end

	local finalWeight = (thisWeightValue / useQuantifier.value)

	return {
		short = finalWeight .. Config.Inventory.WeightQuantifiers[useQuantifier.quantifier],
		long = finalWeight .. ' ' .. useQuantifier.quantifier
	}
end