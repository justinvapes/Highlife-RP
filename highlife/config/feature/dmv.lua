Config.DMV = {
	Locations = {
		DrivingSchool = {
			pos = vector3(1088.2, -352.76, 67.09),
			blip = {
				id = 498,
				color = 0
			},
			vehicle_spawns = {
				parking_1 = {
					pos = vector4(1099.04, -341.07, 66.69, 34.31),
					type = 'small'
				},
				parking_2 = {
					pos = vector4(1101.32, -339.42, 66.69, 31.92),
					type = 'small'
				},
				parking_3 = {
					pos = vector4(1104.41, -337.3, 66.69, 31.83),
					type = 'small'
				},
				parking_4 = {
					pos = vector4(1101.0, -325.95, 66.69, 162.59),
					type = 'small'
				},
				parking_5 = {
					pos = vector4(1103.75, -324.90, 66.69, 165.59),
					type = 'small'
				},
				parking_6 = {
					pos = vector4(1107.44, -323.08, 66.61, 161.59),
					type = 'small'
				},
				parking_7 = {
					pos = vector4(1096.80, -329.04, 66.61, 125.59),
					type = 'small'
				},
				parking_8 = {
					pos = vector4(1092.01, -332.41, 66.69, 125.12),
					type = 'small'
				},
				parking_9 = {
					pos = vector4(1091.21, -333.58, 67.45, 123.92),
					type = 'small'
				},
				parking_10 = {
					pos = vector4(1082.56, -339.41, 67.46, 123.87),
					type = 'large'
				},
				parking_11 = {
					pos = vector4(1065.38, -340.10, 67.38, 57.31),
					type = 'large'
				},
				parking_12 = {
					pos = vector4(1056.08, -334.2, 67.4, 57.6),
					type = 'large'
				},
				parking_13 = {
					pos = vector4(1044.52, -326.99, 67.39, 67.39),
					type = 'large'
				},
				parking_14 = {
					pos = vector4(1055.37, -351.29, 67.39, 56.56),
					type = 'large'
				},
				parking_15 = {
					pos = vector4(1044.91, -344.72, 67.39, 57.5),
					type = 'large'
				},
			},
			Tests = {
				theory = {
					price = 600,
					license = 'dmv',
				},
				practical = {
					price = 1500,
					max_points = 6,
					route_test = true,
					license = 'drive',
					valid_vehicles = {
						GetHashKey('futo'),
						GetHashKey('issi2'),
						GetHashKey('panto'),
						GetHashKey('blista'),
						GetHashKey('prairie'),
						GetHashKey('blista2'),
						GetHashKey('rhapsody'),
						GetHashKey('dilettante'),
					}
				},
				motorcycle = {
					price = 300,
					max_points = 6,
					route_test = true,
					license = 'drive_bike',
					bypass_seatbelt = true,
					valid_vehicles = {
						GetHashKey('pcj'),
						GetHashKey('faggio'),
						GetHashKey('faggio3'), -- TODO: Available in DLC?
						GetHashKey('ruffian'),
					}
				},
				commercial = {
					price = 750,
					max_points = 6,
					large_spawn = true,
					route_test = true,
					license = 'drive_truck',
					valid_vehicles = {
						GetHashKey('mule'),
						GetHashKey('mule2'),
						GetHashKey('mule3'),
					}
				}
			},
			Routes = {
				{
					{
						pos = vector4(1029.11, -323.67, 66.95, 60.0427),
						params = {
							speed = 40,
							hint = "Welcome to your test, so long as you stick to your theory test answers you'll be fine!"
						}
					},
					{
						pos = vector4(978.9786, -293.9839, 66.51933, 58.75565),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1012.613, -217.3803, 69.68216, 327.3287),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(813.5289, -62.15966, 80.22671, 56.24244),
						params = {
							speed = 40,
							hint = "Make sure to come to a ~r~stop ~s~ at the sign!",
							stop = 2000
						}
					},
					{
						pos = vector4(712.1085, -1.975871, 83.59441, 58.29669),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(628.2169, -48.37312, 76.72636, 117.7554),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(504.9254, -129.7092, 59.21741, 161.9547),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(484.0187, -291.7174, 46.53065, 142.8757),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(523.2554, -352.8623, 43.0543, 166.9947),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(600.2098, -599.5401, 41.24763, 233.896),
						params = {
							speed = 70,
							hint = 'Get that ~g~speed up~s~, when joining the freeway we want to be going ~b~70~s~mph!'
						}
					},
					{
						pos = vector4(809.3943, -687.4073, 41.30775, 242.2521),
						params = {
							speed = 70,
							hint = nil
						}
					},
					{
						pos = vector4(1041.971, -1046.645, 27.18813, 194.7601),
						params = {
							speed = 70,
							hint = nil
						}
					},
					{
						pos = vector4(1052.612, -1675.656, 31.84854, 187.9323),
						params = {
							speed = 70,
							hint = nil
						}
					},
					{
						pos = vector4(1129.008, -1732.309, 35.31112, 289.7723),
						params = {
							speed = 70,
							hint = "Time to slow it down, you're coming back to a ~b~40~s~mph zone!"
						}
					},
					{
						pos = vector4(1324.748, -1627.548, 51.76946, 306.6261),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1264.711, -1447.733, 34.75811, 21.35845),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1161.746, -963.699, 46.92295, 1.87632),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1199.772, -775.5062, 56.85772, 351.6155),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1181.651, -530.6252, 64.42741, 349.4333),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1210.274, -390.4122, 68.01456, 348.9838),
						params = {
							speed = 40,
							hint = nil
						}
					},
					{
						pos = vector4(1129.909, -355.5511, 66.61201, 92.77812),
						params = {
							speed = 40,
							hint = 'Return the car to the back of the ~b~DMV'
						}
					},
					{
						pos = vector4(1110.78, -335.0, 66.69, 35.60449),
						params = {
							speed = 40,
							hint = nil,
							radius = 3.0
						}
					},
				}
			},
			Plate = {
				MaxLength = 8,
				PriceModifier = 178572
			}
		}
	},
}