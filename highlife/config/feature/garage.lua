Config.ImpoundInsurance = {
	InsuranceValueModifiers = {
		[0] = 4.8,
		[250000] = 4.6,
		[500000] = 4.4,
		[750000] = 4.2,
		[1000000] = 4.0
	},
	ImpoundValueModifiers = {
		[0] = 5.2,
		[250000] = 5.0,
		[500000] = 4.8,
		[750000] = 4.6,
		[1000000] = 4.4
	},
}

Config.Garage = {
	Garage_Driveway = {
		playerOwned = true
	},
	Garage_Small = {
		playerOwned = true
	},
	Garage_Medium = {
		playerOwned = true
	},
	Garage_Large = {
		playerOwned = true
	},
	Garage = {
		Subtitle = '~y~Your collection of vehicles',
		IgnoreClasses = {14, 15, 16},
		Blip = {
			sprite = 473,
			color = 3
		},
		Locations = {
			{id = 1, disabled = true, name ='Legion Square', x = 42.48, y = -871.41, z = 30.45},
			{id = 2, name ='Clinton Ave', x = 371.41, y = 280.57, z = 103.38},
			{id = 3, name ='Harmony', x = 1123.70, y = 2656.12, z = 38.57},
			{id = 4, name ='Airport', x = -786.70, y = -2398.12, z = 14.57},
			{id = 5, name ='Buen Vino', x = -1909.70, y = 2041.12, z = 140.57},
			{id = 6, name ='Procopio Drive', x = 137.26, y = 6601.87, z = 31.40},
			{id = 7, name ='Algonquin Blvd', x = 1723.36, y = 3713.84, z = 33.83},
			{id = 8, name ='Del Perro', x = -1546.59, y = -412.33, z = 41.85},
			{id = 9, name ='Hawick Ave', x = -360.67, y = -87.17, z = 45.58},
			{id = 10, name ='Peaceful Street', x = -302.67, y = -759.17, z = 33.58},
			{id = 11, name ='Grove Street', x = -56.673, y = -1838.87, z = 26.18},
			{id = 12, name ='Bay City Ave', x = -960.14, y = -1584.37, z = 5.18},
			{id = 13, name ='Senora Way', x = 2723.7, y = 1361.58, z = 24.52},
			{id = 14, name ='Mirror Park', x = 1029.25, y = -775.77, z = 58.52},
			{id = 15, name ='Occupation Ave', x = 282.25, y = -333.77, z = 44.52},
			{id = 16, name ='Sinner Street', x = 471.37, y = -899.78, z = 35.52},
			{id = 17, name ='Strawberry Ave', x = 140.88, y = -1328.33, z = 29.2, range = 8.0, job = {vanilla = 2}, venueName = 'the ~p~Vanilla Unicorn'},
			{id = 18, name ='Integrity Way', x = 338.58, y = -624.33, z = 29.2, range = 10.0},
			{id = 19, name ='Vinewood Park Dr', x = 884.30, y = -45.11, z = 78.7, range = 15.0, valet = true},
			{id = 20, name ='Boilingbroke', x = 1873.30, y = 2644.95, z = 45.7, range = 15.0},
			{id = 21, name ='Hanger Way', x = 810.30, y = -2482.95, z = 22.7, range = 8.0},
			{id = 22, name ='Innocence Blvd', x = -186.41, y = -1270.95, z = 32.29, range = 8.0, job = {mecano = 1}, venueName = '~r~DW Customs'},
			{id = 23, name ='Eclipse Blvd', x = -608.36, y = 337.68, z = 85.11},
		}
	},
	Heliport = {
		Subtitle = '~g~Living the true HighLife',
		IgnoreLocation = true,
		ValidClasses = {15},
		Blip = {
			sprite = 360,
			color = 3
		},
		Locations = {
			{x = -735.09, y = -1456.38, z = 5.0},
			{x = 1770.31, y = 3239.38, z = 42.0},
		}
	},
	PlaneParking = {
		Subtitle = '~g~Living the trueER HighLife',
		IgnoreLocation = true,
		ValidClasses = {16},
		Blip = {
			sprite = 359,
			color = 3
		},
		Locations = {
			{x = -1649.48, y = -3138.02, z = 14.0},
			{x = 1410.89, y = 3007.79, z = 40.0},
			{x = 2135.99, y = 4810.79, z = 41.53},
		}
	},
	Dock = {
		Subtitle = '~p~Fun fact, Kissane killed this',
		IgnoreLocation = true,
		ValidClasses = {14},
		Blip = {
			sprite = 455,
			color = 3
		},
		Locations = {
			{x = -1004.09, y = -1400.38, z = 1.0, spawnLocation = vector4(-999.35, -1399.1, 0.0, 19.0)},
			{x = 3854.0, y = 4460.01, z = 1.0, spawnLocation = vector4(3854.3, 4453.48, 0.0, 270.0)},
			{x = 1309.2, y = 4263.83, z = 33.91, spawnLocation = vector4(1314.40, 4251.0, 30.30, 170.0)},
		}
	},
	DockInsurance = {
		Subtitle = '~o~Here to pickup a boat?',
		ValidStatus = 0,
		ValidClasses = {14},
		Blip = {
			sprite = 356,
			color = 64
		},
		Locations = {
			{x = -332.5, y = -2792.56, z = 5.0, spawnLocation = vector4(-293.30, -2763.01, 0.0, 270.0)},
		}
	},
	HeliInsurance = {
		Subtitle = '~o~Here to cry?',
		ValidStatus = 0,
		ValidClasses = {15},
		Blip = {
			sprite = 360,
			color = 64
		},
		Locations = {
			{x = 1737.76, y = 3284.34, z = 40.84},
		}
	},
	PlaneInsurance = {
		Subtitle = '~o~Here to cry, even harder?',
		ValidStatus = 0,
		ValidClasses = {16},
		Blip = {
			sprite = 359,
			color = 64
		},
		Locations = {
			{x = -1226.52, y = -2274.01, z = 14.4},
		}
	},
	Insurance = {
		Subtitle = '~o~Here to pickup a vehicle?',
		ValidStatus = 0,
		IgnoreClasses = {14, 15, 16},
		Blip = {
			sprite = 380,
			color = 64
		},
		Locations = {
			-- { x = 482.896, y = -1316.557, z = 28.301}, -- old
			{x = 478.67016601563, y = -1281.3981933594, z = 28.53932762146, range = 15.0 },
			{x = -729.40130615234, y = -413.82681274414, z = 34.164039611816, range = 15.0 },
			{x = -185.187, y = 6272.027, z = 30.580, range = 15.0 },
			{x = 2350.1520996094, y = 3133.9833984375, z = 47.2087059021, range = 15.0 }
		}
	},
	DockImpound = {
		Subtitle = '~o~Here for a boat, pirate?',
		ValidStatus = 2,
		ValidClasses = {14},
		Blip = {
			sprite = 356,
			color = 38
		},
		Locations = {
			{x = -786.69, y = -1355.13, z = 5.15, spawnLocation = vector4(-767.35, -1379.38, 0.4, 230.0)},
		}
	},
	Impound = {
		Subtitle = '~b~Bring a license.',
		ValidStatus = 2,
		RequireLicense = {'dmv', 'drive'},
		IgnoreClasses = {14, 15, 16},
		Blip = {
			sprite = 285,
			color = 38 
		},
		Locations = {
			{x = 400.88, y = -1631.56, z = 29.29}
		}
	}
}

Config.Garage_Settings = {
	InsurancePrice = 1500,
	ImpoundPrice = 2500,
	DefaultRange = 15.0,
	StatusTypes = {
		[0] = {
			text = '~y~Claim at the insurance depot',
			color = '~o~'
		},
		[1] = {
			text = 'Available',
			color = '~g~'
		},
		[2] = {
			text = '~y~Impounded by the ~b~LSPD',
			color = '~b~'
		}
	},
	VehicleClassModifiers = {
		1.3, -- Compacts
		1.4, -- Sedans
		1.7, -- SUVs
		1.5, -- Coupes
		1.8, -- Muscle
		2.2, -- Sports Classics
		1.6, -- Sports
		3.7, -- Super
		1.3, -- Motorcycles
		1.5, -- Off-road
		1.5, -- Industrial
		1.5, -- Utility
		1.6, -- Vans
		0, -- Cycles
		1.3, -- Boats
		0.83, -- Helicopters
		0.83, -- Planes
		1.3, -- Service
		1.3, -- Emergency
		1.3, -- Military
		1.3, -- Commercial
		1.3 -- Trains
	}
}