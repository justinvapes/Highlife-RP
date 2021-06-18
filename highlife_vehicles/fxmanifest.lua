fx_version 'bodacious'

game 'gta5'

name 'HighLife Vehicles'

author 'Jarrrk'

files {
    'meta/vehicle_layouts.meta',
    'meta/carcols.meta',
    'meta/handling.meta',
    'meta/vehicles.meta',
    'meta/carvariations.meta'
}

data_file 'VEHICLE_LAYOUTS_FILE' 'meta/vehicle_layouts.meta'
data_file 'CARCOLS_FILE' 'meta/carcols.meta'
data_file 'HANDLING_FILE' 'meta/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'meta/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'meta/carvariations.meta'

data_file 'WEAPON_METADATA_FILE' 'meta/vehicle_weaponarchetypes.meta'
data_file 'WEAPONINFO_FILE' 'meta/vehicle_weapons.meta'

client_script 'vehicle_names.lua'