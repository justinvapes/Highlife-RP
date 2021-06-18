fx_version 'bodacious'

game 'gta5'

name 'HighLife Assets'

author 'Jarrrk'

replace_level_meta 'meta/gta5'

files {
	'meta/gta5.meta',

	'dat/materialfx.dat',

	'ymt/a_c_shepherd.ymt',
}

data_file 'DLC_ITYP_REQUEST' 'stream/props/highlife_props.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/crops_fix/v_crops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/gaspump_fix/v_utility.ytyp'

data_file 'PEDSTREAM_FILE' 'ymt/a_c_shepherd.ymt'

exports {
	'SetAlreadySpawned',
	'GetAlreadySpawned'
}

client_script 'exports.lua'
