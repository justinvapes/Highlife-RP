MenuVariables = {
	GlobalColorNames = {'Black','Graphite','Black Steel','Dark Steel','Silver','Bluish Silver','Rolled Steel','Shadow Silver','Stone Silver','Midnight Silver','Cast Iron','Anthracite Black','Matte Black','Matte Gray','Matte Light','Util Black','Util Black','Util Dark','Util Silver','Util Gun','Util Shadow','Worn Black','Worn Graphite','Worn Silver','Worn Silver','Worn Blue','Worn Shadow','Red','Torino Red','Formula Red','Blaze Red','Grace Red','Garnet Red','Sunset Red','Cabernet Red','Candy Red','Sunrise Orange','Gold','Orange','Matte Red','Matte Dark','Matte Orange','Matte Yellow','Util Red','Util Bright','Util Garnet','Worn Red','Worn Golden','Worn Dark','Dark Green','Racing Green','Sea Green','Olive Green','Bright Green','Gasoline Green','Matte Lime','Util Dark','Util Green','Worn Dark','Worn Green','Worn Sea','Galaxy Blue','Dark Blue','Saxon Blue','Blue','Mariner Blue','Harbor Blue','Diamond Blue','Surf Blue','Nautical Blue','Ultra Blue','Schafter Purple','Spinnaker Purple','Racing Blue','Light Blue','Util Dark','Util Midnight','Util Blue','Util Sea','Util Lightning','Util Maui','Util Bright','Matte Dark','Matte Blue','Matte Midnight','Worn Dark','Worn Blue','Worn Baby','Yellow','Race Yellow','Bronze','Dew Yellow','Lime Green','Champagne','Feltzer Brown','Creek Brown','Chocolate Brown','Maple Brown','Saddle Brown','Straw Brown','Moss Brown','Bison Brown','WoodBeech Brown','BeechWood Brown','Sienna Brown','Sandy Brown','Bleached Brown','Cream','Util Brown','Util Medium','Util Light','Ice White','Frost White','Worn Honey','Worn Brown','Worn Dark','Worn Straw','Brushed Steel','Brushed Black','Brushed Aluminium','Chrome','Worn Off','Util Off','Worn Orange','Worn Light','Pea Green','Worn Taxi','Police Blue','Matte Green','Matte Brown','Worn Orange','Ice White','Worn White','Worn Olive','Pure White','Hot Pink','Salmon Pink','Pfister Pink','Bright Orange','Green Bright','Fluorescent Blue','Midnight Blue','Midnight Purple','Wine Red','Hunter Green','Bright Purple','Midnight Purple','Carbon Black','Matte Schafter','Matte Midnight','Lava Red','Matte Forest','Matte Olive','Matte Dark','Matte Desert','Matte Foliage','DefaultAlloyColor','Epsilon Blue','Pure Gold','Brushed Gold','MP100'},
	ID = {},
	Drugs = {
		Number = nil,
		Product = nil
	},
	Jobs = {
		Key = nil,
		Menu = nil,
		Config = nil,
		CurrentVehicle = nil,
		JobRequiresLicense = nil,

		CreatingVehicle = false,

		VehicleIndex = 1,

		JobClosed = false,
		InService = false,
		isCoreHoursBonus = false,

		ManagementOptions = {}
	},
	Paintball = {
		Gamemodes = {},
		CurrentArea = nil,
		CreateLobby = {
			GamemodeIndex = 1,

			Name = nil,
			Wager = nil,
			Gamemode = nil,
			Password = nil,
		}
	},
	Pawnshop = {
		CurrentStore = nil
	},
	Inventory = {
		CurrentItem = nil
	},
	Dynasty = {
		Add = {},
		Remove = {},

		PropertyTypes = {},
		PropertyTypeIndex = 1
	},
	Depositbox = {
		Storage = nil,
		NearReference = nil,
		AwaitingCallback = false
	},
	Property = {
		Storage = nil,
		NearReference = nil,
		AwaitingCallback = false
	},
	Trunk = {
		Storage = nil,
		NearReference = nil,
		AwaitingCallback = false
	},
	SearchMenu = {
		ExtraData = nil,
		PlayerData = nil,
		SearchEntity = nil
	},
	ClothingStore = {
		CurrentStore = nil,
		CurrentSection = nil
	},
	Barbershop = {
		CurrentStore = nil,
		CurrentSection = nil
	},
	PlasticSurgery = {
		CurrentStore = nil,
		CurrentSection = nil
	},
	Garages = {
		CurrentName = nil,
		CurrentType = nil,
		CurrentVehicle = nil,
		CurrentLocation = nil,
	},
	Character = {
		DOB = nil,
		LastName = nil,
		FirstName = nil
	},
	Stores = {
		Sorted = false,
		isSelling = nil,
		CurrentStore = nil,
		CurrentLocation = nil
	},
	Containers = {
		Type = nil,
		Reference = nil
	},
	Event = {
		Durations = {},
		Data = {
			name = nil,
			duration = 1,
			description = nil,
			blip = {
				id = nil,
				coords = nil,
			}
		}
	},
	Detention = {
		ICU = {
			Days = nil,
			Reason = nil,
			Person = nil,
		},
		Jail = {
			Days = nil,
			Reason = nil,
			Person = nil,
		},
		Morgue = {
			Days = nil,
			Reason = nil,
			Person = nil,
		}
	},
	Police = {
		Warrant = {
			Person = nil,
			Reason = nil,
			Crime_1 = nil,
			Crime_2 = nil,
			Crime_3 = nil,
		},
		DOA = false,
		SWAT = false,
	},
	Report = {
		Issue = {},
		Player = {},
	},
	Tattoo = {
		isMale = false,
		Preview = nil,
		HiddenMenuComponents = {}
	},
	Vehicle = {
		DoorIndex = 1,
		WindowIndex = 1,
		Doors = {
			{ Name = 'Front Left', Value = 0 },
			{ Name = 'Front Right', Value = 1 },
			{ Name = 'Back Left', Value = 2 },
			{ Name = 'Back Right', Value = 3 }
		}
	},
	Mechanics = {
		VehicleSet = false,
		RGBColorIndex = {},
		ColorNameIndex = {},
		Color = {
			Primary = {
				r = 1,
				g = 1,
				b = 1
			},
			Secondary = {
				r = 1,
				g = 1,
				b = 1
			},
			Wheels = 1,
			Interior = 1,
			Dashboard = 1,
			Pearlescent = 1,
		}
	}
}

for i=1, 255 do
	table.insert(MenuVariables.Mechanics.RGBColorIndex, { Name = i, Value = i })
end

for i=1, #MenuVariables.GlobalColorNames do
	table.insert(MenuVariables.Mechanics.ColorNameIndex, { Name = MenuVariables.GlobalColorNames[i], Value = i})
end

for k,v in pairs(Config.EventManager.Types) do
	table.insert(MenuVariables.Event.Durations, { 
		Name = v.title .. ' ($' .. comma_value(v.price) .. ')', 
		Value = k
	})
end

local propertyAddIndex = 1

for propertyName, propertyData in pairs(Config.Properties.Types) do
	if propertyData.canAdd == nil or propertyData.canAdd then
		table.insert(MenuVariables.Dynasty.PropertyTypes, { Name = (propertyData.displayName or propertyName), Reference = propertyName, Value = propertyAddIndex})

		propertyAddIndex = propertyAddIndex + 1
	end
end

HighLife.Other.MenuVariables = MenuVariables