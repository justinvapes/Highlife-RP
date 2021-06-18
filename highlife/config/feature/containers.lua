Config.Containers = {
	DefaultWeight = 1,
	InteractTypes = {
		Favorite = {
			Color = '~y~'
		},

		Use = {
			Color = '~b~'
		},

		Take = {
			Color = '~g~'
		},
		Deposit = {
			Color = '~g~'
		},

		Give = {
			Color = '~o~'
		},
		Drop = {
			Color = '~r~'
		},
	},
	ValidTypes = {
		fund = {
			IgnoreWeight = true
		},
		trunk = {
			Name = 'Trunk',
			Description = 'The vehicle inventory',
			MaxWeight = 100,
			MenuOptions = {
				Take = true,
				Deposit = true,
			},
			LimitReferences = {
				-- Compacts 
				[0] = {
					-- idk
					MaxWeight = 50
				},
				-- Sedans 
				[1] = {
					MaxWeight = 100
				},
				-- SUVs 
				[2] = {
					MaxWeight = 100
				},
				-- Coupes 
				[3] = {
					MaxWeight = 100
				},
				-- Muscle 
				[4] = {
					MaxWeight = 100
				},
				-- Classics 
				[5] = {
					MaxWeight = 100
				},
				-- Sports 
				[6] = {
					MaxWeight = 100
				},
				-- Super 
				[7] = {
					MaxWeight = 100
				},
				-- Motorcycles 
				[8] = {
					MaxWeight = 100
				},
				-- Offroad 
				[9] = {
					MaxWeight = 100
				},
				-- Industrial
				[10] = {
					MaxWeight = 100
				},
				-- Utility
				[11] = {
					MaxWeight = 100
				},
				-- Vans
				[12] = {
					MaxWeight = 100
				},
				-- Cycles
				[13] = {
					MaxWeight = 100
				},
				-- Boats
				[14] = {
					MaxWeight = 100
				},
				-- Helicopters
				[15] = {
					MaxWeight = 100
				},
				-- Planes
				[16] = {
					MaxWeight = 100
				},
				-- Service
				[17] = {
					MaxWeight = 100
				},
				-- Emergency
				[18] = {
					MaxWeight = 100
				},
				-- Military
				[19] = {
					MaxWeight = 100
				},
				-- Commercial
				[20] = {
					MaxWeight = 100
				},
				-- Trains
				[21] = {
					MaxWeight = 100
				},
				-- OpenWheel
				[22] = {
					MaxWeight = 100
				}
			}
		},
		player = {
			Name = 'Inventory',
			SaveOnExit = true,
			Description = 'Your pockets',
			MaxWeight = 100, -- 20kg/44lbs
			MenuOptions = {
				Use = {
					single = true,
					event = 'HighLife:Container:UseItem',
					params = 'item_id'
				},
				Favorite = {
					single = true,
					event = 'HighLife:Container:FavoriteItem',
					variableToggle = {
						on = 'item',
						variable = 'favorite',
					},
					params = 'item_id'
				},
				Give = true,
				Drop = true,
			}
		},
		property = {
			MenuOptions = {
				Take = true,
				Deposit = true,
			},
			MaxWeight = 100, -- 100 -- 20kg
			LimitReferences = {
				House_Nice = {
					MaxWeight = 100 -- 100 -- 20kg
				},
				House_Shabby = {
					MaxWeight = 100-- 100 -- 20kg
				},
			}
		},
		depositbox = {
			MenuOptions = {
				Take = true,
				Deposit = true,
			},
			MaxWeight = 100,
			LimitReferences = {
				PacificStandard = {
					-- items = 4, -- amount of inventory items can be stored
					-- money = 200000 -- combined amount of dirty + cash
					MaxWeight = 100, -- 8kg
					MaxMoney = 200000
				},
				BlaineCountySavings = {
					-- items = 2, -- amount of inventory items can be stored
					-- money = 100000 -- combined amount of dirty + cash
					MaxWeight = 100, -- 4kg
					MaxMoney = 100000
				},
			}
		},
	},
	Max = {
		Blood = 10,
		Prints = 10,
		-- CarryWeight = 1000.0 * 20 -- 20kg/44lbs
	},
	WeightQuantifiers = {
		Kilograms = {
			['g'] = 1.0,
			['kg'] = 1000.0,
		},
		Pounds = {
			['g'] = 1.0,
			['lb'] = 453.592,
		}
	}
}