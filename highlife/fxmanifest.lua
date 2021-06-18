fx_version 'bodacious'

game 'gta5'

name 'HighLife'

author 'Jarrrk'

lua54 'yes'

files {
	'http/*.html',
	
	'dat/*.dat',

	-- Portal NUI
	'nui/portal.html',

	'nui/**/*.*',
}

exports {
	'GetCD',
	'IsHandsUp',
	'GetBankID',
	'InAmbulance',
	'GetLicenses',
	'SetWalkStyle',
	'GetBaseConfig',
	'SetEntryCheck',
	'SetPhoneCaller',
	'NetworkVehicle',
	'LockVehicleHLL',
	'IsStreamerMode',
	'SetVehicleFuel',
	'CreateExtObject',
	'IsHidingInTrunk',
	'CreateExtVehicle',
	'GetIsDevelopment',
	'GetIsInDetention',
	'GetVehiclePrices',
	'GetPlayerJobData',
	'GetHandCuffStatus',
	'GetHasSpecialItem',
	'IsPlayingBlackjack',
	'CoreControlsBlocked',
	'IsCrouchingDisabled',
	'DeleteNetworkVehicle',
	'IsSwitchingCharacter',
	'GetCurrentCharacterData',

	-- js

	-- 'getShopPedProp',
	-- 'getTattooCollection',
	-- 'getShopPedComponent',
	-- 'getPedHeadBlendData',
}

server_exports {
	'CoreObject',
	'SetBanData',
	'IsRolePresent',
	'SendSentryIssue',
	'SetCartelNumbers',
	'GetCartelNumbers',
	'GetPlayerRogueToken',
}

ui_page 'nui/portal.html'
loadscreen 'https://cdn.highliferoleplay.net/fivem/loading_screen/?v1'

loadscreen_manual_shutdown 'yes'

dependencies {
	'NativeUILua_Reloaded'
}

ensure 'mysql-async'

client_scripts {
	"@NativeUILua_Reloaded/src/NativeUIReloaded.lua",

	'config/base.lua',
	'config/feature/*.lua',

	'client/functions.lua',
	'client/main.lua',

	"client/rageui/RMenu.lua",
	"client/rageui/menu/RageUI.lua",
	"client/rageui/menu/Menu.lua",
	"client/rageui/menu/MenuController.lua",
	"client/rageui/components/*.lua",
	"client/rageui/menu/elements/*.lua",
	"client/rageui/menu/items/*.lua",
	"client/rageui/menu/panels/*.lua",
	"client/rageui/menu/panels/*.lua",
	"client/rageui/menu/windows/*.lua",
	
	'client/core/*.lua',
	'client/dev/*.lua',
	'client/features/*.lua',
	'client/ext/*.lua',
	'client/hud/*.lua',
	'client/items/*.lua',
	'client/job/*.lua',

	-- Menu Debug
	-- 'client/menus/variables.lua',
	-- 'client/menus/skin.lua',

	'client/menus/*.lua',
	'client/menus/jobs/*.lua',
	'client/player/*.lua',
	'client/vehicle/*.lua',
	
	'client/jslibs/*.js',
	'client/csharplibs/*.dll',

	'client/runtime.lua',
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'config/base.lua',
	'config/feature/*.lua',

	'config_server/*.lua',

	'server/profiler.lua',

	'server/functions.lua',
	'server/main.lua',
	'server/sha.lua',

	'server/classes/*.lua',

	'server/runtime.lua',
}
