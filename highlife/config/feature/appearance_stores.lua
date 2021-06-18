Config.PlasticSurgery = {
	BasePrice = 2000,

	Locations = {
		city = {
			location = vector3(-940.93, -338.44, 38.98),
			spots = {
				vector3(-940.11, -366.06, 38.98),
				vector3(-942.87, -362.33, 38.98),
				vector3(-948.18, -359.24, 38.98),
			}
		}
	},
	Blip = {
		Sprite = 10,
		Color = 0
	}
}

Config.Barbershop = {
	BasePrice = 10,

	Stores = {
		Generic = {
			Locations = {
				vector3(-814.308, -183.823, 36.568),
				vector3(136.826, -1708.373, 28.291),
				vector3(-1282.604, -1116.757, 5.990),
				vector3(1931.513, 3729.671, 31.844),
				vector3(1212.840, -472.921, 65.208),
				vector3(-32.885, -152.319, 56.076),
				vector3(-278.077, 6228.463, 30.695),
			},
			Blip = {
				Sprite = 10,
				Color = 0
			}
		}
	}
}

Config.ClothingStore = {
	BasePrice = 17,

	Stores = {
		Generic = {
			Locations = {
				vector3(76.91, -1390.0, 29.38),
				vector3(11.632, 6514.224, 30.877),
				vector3(123.646, -219.440, 53.557),
				vector3(618.093, 2759.629, 41.088),
				vector3(428.694, -800.106, 28.491),
				vector3(1696.291, 4829.312, 41.063),
				vector3(1190.550, 2713.441, 37.222),
				vector3(-167.863, -298.969, 38.733),
				vector3(-703.776, -152.258, 36.415),
				vector3(-1193.429, -772.262, 16.324),
				vector3(-3172.496, 1048.133, 19.863),
				vector3(-1108.441, 2708.923, 18.107),
				vector3(-829.413, -1073.710, 10.328),
				vector3(-1447.797, -242.461, 48.820),
			},
			Blip = {
				Sprite = 10,
				Color = 0
			},
			MenuTexture = nil,

			SellTypes = {
				'Hat',
				'Arms',
				'Chain',
				'Pants',
				'Shoes',
				'Overshirt',
				'Undershirt',
			}
		},
		-- suits etc
		-- Ponsonboys = {
		-- 	MenuTexture = nil,

		-- 	Clothing = {
		-- 		Pants = {
		-- 			DrawableIndex = 4,
		-- 			Title = 'Pants',

		-- 			Items = {
		-- 				[0] = {
		-- 					[5] = {
		-- 						Variation = 5,
		-- 						Price = 30
		-- 					},
		-- 					[6]  = {
		-- 						Variation = 6,
		-- 						Price = 30
		-- 					},
		-- 				}
		-- 			}
		-- 		},
		-- 	}
		-- }
	}
}