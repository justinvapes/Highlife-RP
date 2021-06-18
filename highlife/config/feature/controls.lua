Config.Controls = {
	-- Alt for services radio
	[19] = {
		group = 0,
		pressed = {
			func = {
				name = nil,
				params = true
			}
		},
		released = {
			func = {
				name = nil,
				params = false
			}
		},
		holding_time = 0,
		keyboard_only = true,
		jobs_required = {'police', 'ambulance'},
	}
}