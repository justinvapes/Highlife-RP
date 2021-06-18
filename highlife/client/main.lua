ESX = nil

CreateThread(function()
	TriggerServerEvent('HighLife:GetServerInfo')
	
	TriggerEvent('GAYsx:getSharedObject', function(obj) ESX = obj end)

	while ESX == nil do
		Wait(1)
	end
end)

GlobalFunTable = {}

-- Variables

firstJoin = true

PlayerInventory = nil

HighLife = {
	Info = {
		ServerID = nil
	},
	Settings = {
		IsTest = false,
		Whitelist = false,
		Development = false,
		MaxPlayers = Config.MaxPlayers,
		DisableTraffic = Config.NoTraffic,
	},
	Player = {
		Id = PlayerId(),
		Ped = PlayerPedId(),
		Pos = vector3(1592.14, 3220.32, 40.41),
		ServerId = GetPlayerServerId(PlayerId()),

		Steam = 'none',
		Discord = nil,

		Drunk = 0.0,
		Stoned = 0.0,
		Heading = nil,
		
		GridID = 0,
		BankID = 0,
		FireMode = 1,
		PlaytimeHours = 0,
		LastDamagedBone = 0,

		Health = nil,
		Health_N = {
			Blood = 6000,
			DamagedBoneArray = {},
		},

		Vehicle = nil,
		LastJob = nil,
		Dragger = nil,
		Dragging = nil,
		Upgrades = nil,
		Inventory = nil,
		Supporter = nil,
		OutfitData = nil,
		VehicleSeat = nil,
		LastGasTime = nil,
		ChopshopData = nil,
		OwnedClothing = nil,
		CurrentWeapon = nil,
		LastDeathData = nil,
		SpectatingPed = nil,
		LoginPosition = nil,
		LastEpochTime = nil,
		VehicleAirTime = nil,
		DraggingPlayer = nil,
		OverrideClipset = nil,
		CurrentInterior = nil,
		CurrentCharacterReference = nil,

		Vitals = {},
		BanData = {},
		Tattoos = {},
		Licenses = {},
		Invoices = {},
		WarningData = {},
		VehicleKeys = {},
		SpecialItems = {},
		OwnedVehicles = {},
		CharacterData = {},
		CurrentCharacter = {},
		ActivePlayerData = {},
		OwnedDepositBoxes = {},
		GlobalJobOutfitData = {},

		CD = true,
		Bish = false,
		Dead = false,
		Debug = false,
		Nitro = false,
		Autism = false,
		EntGun = false,
		Cuffed = false,
		Smells = false,
		IC3Gun = false,
		IsAtSea = false,
		Special = false,
		LastHUD = false,
		HideHUD = false,
		Stunned = false,
		IsStaff = false,
		HandsUp = false,
		AfkCheck = true,
		Magneto = false,
		Autistic = false,
		JobReset = false,
		IsStable = false,
		IsTyping = false,
		SillyGun = false,
		Bleeding = false,
		IsEditor = false,
		IsHelper = false,
		CatLover = false,
		Robbable = false,
		Seatbelt = false,
		LocalGun = false,
		InCasino = false,
		CanSwitch = false,
		Crouching = false,
		IsHealing = false,
		InVehicle = false,
		ZMenuOpen = false,
		FirstSpawn = true,
		InArmyBase = false,
		KnockedOut = false,
		EntryCheck = false,
		Instructor = false,
		EventsTeam = false,
		ChilliadGun = false,
		InPhoneCall = false,
		InPauseMenu = false,
		InAmbulance = false,
		VitalsReady = false,
		ManualGears = false,
		WeaponCheck = false,
		InHeliCamera = false,
		StreamerMode = false,
		IsSpectating = false,
		AllowShuffle = false,
		DeathLogging = false,
		NitroBoosted = false,
		IsSittingDown = false,
		CruiseControl = false,
		IsCookingMeth = false,
		HidingInTrunk = false,
		KnockoutReady = false,
		PropertyDebug = false,
		IsSellingDrugs = false,
		HideAllPlayers = false,
		BypassFOVCheck = false,
		IsNewCharacter = false,
		SentIdentifier = false,
		BlockSwitchCam = false,
		TravelProperty = false,
		HasDragRequest = false,
		DisableJumping = false,
		CheckInHospital = false,
		DisableShooting = false,
		InCharacterMenu = false,
		AllowHolsterAnim = true,
		JobClothingDebug = false,
		InPlasticSurgery = false,
		GoForRollProgram = false,
		PlayingBlackjack = false,
		DisableCrouching = false,
		HasReadDisclaimer = false,
		BlockWeaponSwitch = false,
		VisibleItemBlocker = false,
		IsInventoryVisible = false,
		IsInvalidCharacter = false,
		InstanceCheckActive = true,
		SwitchingCharacters = false,

		MiscSync = Config.MiscSync,

		Stats = {
			Playtime = 0
		},
		Preferences = {
			VehicleLock = 0
		},
		Skin = {
			JobSkin = nil,
			CurrentSkin = nil
		},
		Weapons = {
			Lock = true,
			Last = nil,
			Current = nil,
		},
		TimecycleModifier = {
			name = nil,
			strength = nil
		},
		TimecycleModifierExtra = {
			name = nil,
			strength = nil
		},
		DispatchOverride = {
			Pos = nil,
			SafeLock = true
		},
		Instanced = {
			isInstanced = false,
			instanceReference = nil,
			instanceConfigReference = nil
		},
		TempLicenses = {
			fly_heli = false,
			fly_plane = false
		},
		Detention = {
			Active = false,

			InICU = false,
			InJail = false,
			InMorgue = false,
		},
		Job = {
			Data = {},

			rank = 0,
			name = 'unemployed',
			rank_name = 'unemployed'
		},
		Voice = {
			Previous = nil,
			PhoneChannel = nil,
			PropertyChannel = nil,

			CurrentProximity = 2,
			Current = Config.Voice.DefaultChannel,
		}
	},
	DMV = {},
	Skin = {},
	Phone = {},
	Container = {
		Init = false,
		
		ActiveContainer = nil,

		Data = {}
	},
	SpatialSound = {},
	Other = {
		CAD_DATA = nil,
		NetworkPeds = nil,
		RobberyData = nil,
		ClosestProperty = nil,
		GlobalPropertyData = nil,

		TrunkHiders = {},

		Time = {GetUtcTime()},

		ErrorQueue = {},

		RadiusPropHashes = 1,

		TreasureData = {},
		SpecialEvents = {},
		VehiclePrices = {},
		InvisiblePlayers = {},

		InDealership = false,

		GarageData = nil,

		OnlineJobs = nil,

		LootingEnabled = false,

		WeightPreference = 'Kilograms',

		CurrentHour = 6,

		Callbacks = {
			RequestID = 0,
			Data = {}
		},

		JobStatData = {
			current = {},
			previous = {},
			Loaded = false
		}
	}
}

GameTimerPool = {
	ST = GetGameTimer(),
	GlobalGameTime = GetGameTimer(),
	CharacterSwitch = GetGameTimer() + (300 * 1000),

	GSR = nil,
	Melee = nil,
	Bleeding = nil,

	MiscSync = GetGameTimer(),

	Heli = GetGameTimer(),
	Death = GetGameTimer(),
	Clean = GetGameTimer(),
	Stats = GetGameTimer(),
	Props = GetGameTimer(),
	Ragdoll = GetGameTimer(),
	Garbage = GetGameTimer(),
	Dispatch = GetGameTimer(),
	ItemCheck = GetGameTimer(),
	HourCheck = GetGameTimer(),
	MiscChecks = GetGameTimer(),
	RogueChecks = GetGameTimer(),
	BlockedModels = GetGameTimer(),
	InventoryCheck = GetGameTimer(),
	DetentionAttack = GetGameTimer(),
}

function HighLife:DisableCoreControls(disable)
	-- this fixes F5 from being blocked, somehow
	if HighLife.Player.Dragging == nil then
		DisableControlAction(0, 19, disable) -- ALT
		DisableControlAction(0, 21, disable)
		
		DisableControlAction(0, 27, disable) -- UP ARROW
	end

	DisableControlAction(0, 323, disable) -- X

	DisableControlAction(0, 311, disable) -- K

	DisableControlAction(0, 199, disable) -- P

	DisableControlAction(0, 170, disable) -- F3

	DisableControlAction(0, 246, disable) -- Y

	DisableControlAction(0, 23, disable) -- F
	DisableControlAction(0, 75, disable) -- F

	DisableControlAction(0, 29, disable) -- Pointing (B)

	DisableControlAction(0, 29, disable) -- Pointing (B)

	-- G
	DisableControlAction(0, 47, disable)
	DisableControlAction(0, 58, disable)
	DisableControlAction(0, 183, disable)

	-- Aim/Attack
	DisableControlAction(0, 24, disable)
	DisableControlAction(0, 25, disable)

	-- Weapon wheel
	DisableControlAction(0, 37, disable)
	
	-- Punching/Reload
	DisableControlAction(0, 45, disable)
	DisableControlAction(0, 140, disable)

	-- ESC
	-- DisableControlAction(0, 177, true)
	DisableControlAction(0, 200, disable)
	DisableControlAction(0, 202, disable)
	DisableControlAction(0, 322, disable)

	-- Shooting disables
	DisableControlAction(1, 25, disable)
	DisableControlAction(1, 68, disable)
	DisableControlAction(1, 91, disable)
	DisableControlAction(1, 142, disable)
	
	HighLife.Player.CoreControlBlocker = disable
end

-- Functions

-- Events

function HighLife:IsValidPlayerToken(localToken, cb)
	local isValid = nil

	HighLife:ServerCallback('HighLife:TwoCups' .. GlobalFunTable[GameTimerPool.ST .. '_onesteve'], function(validToken)
		isValid = validToken
	end, localToken)

	while isValid == nil do
		Wait(1)
	end

	return isValid
end

RegisterNetEvent('HighLife:returnServerInfo')
AddEventHandler('HighLife:returnServerInfo', function(data)
	local serverData = json.decode(data)

	-- Update sea water salt density
	GlobalFunTable[GameTimerPool.ST .. '_onesteve'] = serverData.ST

	HighLife.Info.ServerID = serverData.serverID
	HighLife.Settings.Whitelist = serverData.isWhitelist
	HighLife.Settings.Development = serverData.isDevelopment

	exports.fivem:EnableChecking(true, HighLife.Settings.Development)
end)

function HighLife:SendServerNetEvent(eventName, ...)
	if eventName ~= nil then
		TriggerServerEvent(eventName, ...)
	end
end

RegisterNetEvent('HighLife:Core:SyncPlayers')
AddEventHandler('HighLife:Core:SyncPlayers', function(activePlayerData)
	HighLife.Player.ActivePlayerData = json.decode(activePlayerData)
end)

RegisterNetEvent('HighLife:ToggleTraffic')
AddEventHandler('HighLife:ToggleTraffic', function()
	HighLife.Settings.DisableTraffic = not HighLife.Settings.DisableTraffic
end)

RegisterNetEvent('HighLife:notify')
AddEventHandler('HighLife:notify', function(text, delayTime, thisSound)
	if delayTime ~= nil then
		CreateThread(function()
			while HighLife.Player.CD do
				Wait(100)
			end

			Wait(delayTime)

			Notification_AboveMap(text, thisSound)
		end)
	else
		Notification_AboveMap(text, thisSound)
	end
end)

RegisterNetEvent('HighLife:HelpText')
AddEventHandler('HighLife:HelpText', function(text)
	DisplayHelpText(text)
end)