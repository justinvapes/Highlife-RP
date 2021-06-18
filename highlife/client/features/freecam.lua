--------------------------------------------------
------- FREECAM FOR FIVEM MADE BY KIMINAZE -------
--------------------------------------------------

Cfg = {}

-- specify, if menu should be accessible via button press
Cfg.useButton = true
-- default: 178 (DELETE)
Cfg.button = 178

-- specify, if menu should be accessible via chat command
Cfg.useCommand = false
-- specify command string
Cfg.command = "freecam"

-- Show an extra option to have a completely free to move camera
Cfg.detachOption = true

-- value in meters
-- default: 5.0
-- used to prevent e.g. Meta-Gaming and Bug-Abuse (looking through walls etc.)
-- with 10,000 you can basically fly above the whole map from the middle but keep in mind, that LoD-states (Level of Detail) won't change as your character stays at its position
Cfg.maxDistance = 15.0

-- min and max FoV settings (should always be in between 1.0f and 130.0f!)
Cfg.minFov = 1.0
Cfg.maxFov = 130.0

-- all strings
Cfg.strings = {
    noAccessError   = "[ERROR] FreeCam: At least one of the following values must be true! Cfg.useButton, Cfg.useCommand",

    menuTitle       = "Camera Rig",
    menuSubtitle    = "pew pew, click click",

    toggleCam       = "Camera active",
    toggleCamDesc   = "Toggle camera on/off",

    precision       = "Camera Precision",
    precisionDesc   = "Change camera precision movement",

    camFov          = "Camera Field of View",
    camFovDesc      = "Change camera Field of View",

    filter          = "Filter",
    filterDesc      = "Change camera Filter",

    filterInten     = "Filter Intensity",
    filterIntenDesc = "Change camera Filter Intensity",
    
    delFilter       = "Reset Filter",
    delFilterDesc   = "Remove filter and reset values",

    showMap         = "Show Minimap",
    showMapDesc     = "Toggle minimap on/off",

    attachCam       = "Camera attached to player",
    attachCamDesc   = "Should the camera be attached to the player?",

    ctrlHelpRoll    = "Roll Left/Right",
    ctrlHelpMove    = "Movement",
    ctrlHelpRotate  = "Rotate"
}

-- list of available filters ( https://pastebin.com/kVPwMemE )
Cfg.filterList = {
    "None",
    "AmbientPUSH",
    "AP1_01_B_IntRefRange", 
    "AP1_01_C_NoFog", 
    "Bank_HLWD", 
    "Barry1_Stoned", 
    "BarryFadeOut", 
    "baseTONEMAPPING", 
    "BeastIntro01", 
    "BeastIntro02", 
    "BeastLaunch01", 
    "BeastLaunch02", 
    "BikerFilter", 
    "BikerForm01", 
    "BikerFormFlash", 
    "Bikers", 
    "BikersSPLASH", 
    "blackNwhite", 
    "BlackOut", 
    "BleepYellow01", 
    "BleepYellow02", 
    "Bloom", 
    "BloomLight", 
    "BloomMid", 
    "buggy_shack", 
    "buildingTOP", 
    "BulletTimeDark", 
    "BulletTimeLight", 
    "CAMERA_BW", 
    "CAMERA_secuirity", 
    "CAMERA_secuirity_FUZZ", 
    "canyon_mission", 
    "carMOD_underpass", 
    "carpark", 
    "carpark_dt1_02", 
    "carpark_dt1_03", 
    "Carpark_MP_exit", 
    "cashdepot", 
    "cashdepotEMERGENCY", 
    "cBank_back", 
    "cBank_front", 
    "ch2_tunnel_whitelight", 
    "CH3_06_water", 
    "CHOP", 
    "cinema", 
    "cinema_001", 
    "cops", 
    "CopsSPLASH", 
    "crane_cam", 
    "crane_cam_cinematic", 
    "CrossLine01", 
    "CrossLine02", 
    "CS1_railwayB_tunnel", 
    "CS3_rail_tunnel", 
    "CUSTOM_streetlight", 
    "damage", 
    "DeadlineNeon01", 
    "default", 
    "DefaultColorCode", 
    "DONT_overide_sunpos", 
    "Dont_tazeme_bro", 
    "dont_tazeme_bro_b", 
    "downtown_FIB_cascades_opt", 
    "DrivingFocusDark", 
    "DrivingFocusLight", 
    "DRUG_2_drive", 
    "Drug_deadman", 
    "Drug_deadman_blend", 
    "drug_drive_blend01", 
    "drug_drive_blend02", 
    "drug_flying_01", 
    "drug_flying_02", 
    "drug_flying_base", 
    "DRUG_gas_huffin", 
    "drug_wobbly", 
    "Drunk", 
    "dying", 
    "eatra_bouncelight_beach", 
    "epsilion", 
    "exile1_exit", 
    "exile1_plane", 
    "ExplosionJosh", 
    "EXT_FULLAmbientmult_art", 
    "ext_int_extlight_large", 
    "EXTRA_bouncelight", 
    "eyeINtheSKY", 
    "Facebook_NEW", 
    "facebook_serveroom", 
    "FIB_5", 
    "FIB_6", 
    "FIB_A", 
    "FIB_B", 
    "FIB_interview", 
    "FIB_interview_optimise", 
    "FinaleBank", 
    "FinaleBankexit", 
    "FinaleBankMid", 
    "fireDEPT", 
    "FORdoron_delete", 
    "Forest", 
    "fp_vig_black", 
    "fp_vig_blue", 
    "fp_vig_brown", 
    "fp_vig_gray", 
    "fp_vig_green", 
    "fp_vig_red", 
    "FrankilinsHOUSEhills", 
    "frankilnsAUNTS_new", 
    "frankilnsAUNTS_SUNdir", 
    "FRANKLIN", 
    "FranklinColorCode", 
    "FranklinColorCodeBasic", 
    "FranklinColorCodeBright", 
    "FullAmbientmult_interior", 
    "gallery_refmod", 
    "garage", 
    "gen_bank", 
    "glasses_black", 
    "Glasses_BlackOut", 
    "glasses_blue", 
    "glasses_brown", 
    "glasses_Darkblue", 
    "glasses_green", 
    "glasses_orange", 
    "glasses_pink", 
    "glasses_purple", 
    "glasses_red", 
    "glasses_Scuba", 
    "glasses_VISOR", 
    "glasses_yellow", 
    "gorge_reflection_gpu", 
    "gorge_reflectionoffset", 
    "gorge_reflectionoffset2", 
    "graveyard_shootout", 
    "gunclub", 
    "gunclubrange", 
    "gunshop", 
    "gunstore", 
    "half_direct", 
    "hangar_lightsmod", 
    "Hanger_INTmods", 
    "heathaze", 
    "heist_boat", 
    "heist_boat_engineRoom", 
    "heist_boat_norain", 
    "helicamfirst", 
    "heliGunCam", 
    "Hicksbar", 
    "HicksbarNEW", 
    "hillstunnel", 
    "Hint_cam", 
    "hitped", 
    "hud_def_blur", 
    "hud_def_blur_switch", 
    "hud_def_colorgrade", 
    "hud_def_desat_cold", 
    "hud_def_desat_cold_kill", 
    "hud_def_desat_Franklin", 
    "hud_def_desat_Michael", 
    "hud_def_desat_Neutral", 
    "hud_def_desat_switch", 
    "hud_def_desat_Trevor", 
    "hud_def_desatcrunch", 
    "hud_def_flash", 
    "hud_def_focus", 
    "hud_def_Franklin", 
    "hud_def_lensdistortion", 
    "hud_def_lensdistortion_subtle", 
    "hud_def_Michael", 
    "hud_def_Trevor", 
    "id1_11_tunnel", 
    "ImpExp_Interior_01", 
    "impexp_interior_01_lift", 
    "IMpExt_Interior_02", 
    "IMpExt_Interior_02_stair_cage", 
    "InchOrange01", 
    "InchOrange02", 
    "InchPickup01", 
    "InchPickup02", 
    "InchPurple01", 
    "InchPurple02", 
    "int_amb_mult_large", 
    "int_Barber1", 
    "int_carmod_small", 
    "int_carrier_control", 
    "int_carrier_control_2", 
    "int_carrier_hanger", 
    "int_carrier_rear", 
    "int_carrier_stair", 
    "int_carshowroom", 
    "int_chopshop", 
    "int_clean_extlight_large", 
    "int_clean_extlight_none", 
    "int_clean_extlight_small", 
    "int_ClothesHi", 
    "int_clotheslow_large", 
    "int_cluckinfactory_none", 
    "int_cluckinfactory_small", 
    "int_ControlTower_none", 
    "int_ControlTower_small", 
    "int_dockcontrol_small", 
    "int_extlght_sm_cntrst", 
    "int_extlight_large", 
    "int_extlight_large_fog", 
    "int_extlight_none", 
    "int_extlight_none_dark", 
    "int_extlight_none_dark_fog", 
    "int_extlight_none_fog", 
    "int_extlight_small", 
    "int_extlight_small_clipped", 
    "int_extlight_small_fog", 
    "int_Farmhouse_none", 
    "int_Farmhouse_small", 
    "int_FranklinAunt_small", 
    "INT_FullAmbientmult", 
    "INT_FULLAmbientmult_art", 
    "INT_FULLAmbientmult_both", 
    "INT_garage", 
    "int_GasStation", 
    "int_hanger_none", 
    "int_hanger_small", 
    "int_Hospital2_DM", 
    "int_Hospital_Blue", 
    "int_Hospital_BlueB", 
    "int_hospital_dark", 
    "int_Hospital_DM", 
    "int_hospital_small", 
    "int_lesters", 
    "int_Lost_none", 
    "int_Lost_small", 
    "INT_mall", 
    "int_methlab_small", 
    "int_motelroom", 
    "INT_NO_fogALPHA", 
    "INT_NoAmbientmult", 
    "INT_NoAmbientmult_art", 
    "INT_NoAmbientmult_both", 
    "INT_NOdirectLight", 
    "INT_nowaterREF", 
    "int_office_Lobby", 
    "int_office_LobbyHall", 
    "INT_posh_hairdresser", 
    "INT_smshop", 
    "INT_smshop_indoor_bloom", 
    "INT_smshop_inMOD", 
    "INT_smshop_outdoor_bloom", 
    "INT_streetlighting", 
    "int_tattoo", 
    "int_tattoo_B", 
    "INT_trailer_cinema", 
    "int_tunnel_none_dark", 
    "interior_WATER_lighting", 
    "introblue", 
    "jewel_gas", 
    "jewel_optim", 
    "jewelry_entrance", 
    "jewelry_entrance_INT", 
    "jewelry_entrance_INT_fog", 
    "Kifflom", 
    "KT_underpass", 
    "lab_none", 
    "lab_none_dark", 
    "lab_none_dark_fog",
    "lab_none_dark_OVR", 
    "lab_none_exit", 
    "lab_none_exit_OVR", 
    "LectroDark", 
    "LectroLight", 
    "li", 
    "LifeInvaderLOD", 
    "lightning", 
    "lightning_cloud", 
    "lightning_strong", 
    "lightning_weak", 
    "LightPollutionHills", 
    "lightpolution", 
    "LIGHTSreduceFALLOFF", 
    "LODmult_global_reduce", 
    "LODmult_global_reduce_NOHD", 
    "LODmult_HD_orphan_LOD_reduce", 
    "LODmult_HD_orphan_reduce", 
    "LODmult_LOD_reduce", 
    "LODmult_SLOD1_reduce", 
    "LODmult_SLOD2_reduce", 
    "LODmult_SLOD3_reduce", 
    "lodscaler", 
    "LostTimeDark", 
    "LostTimeFlash", 
    "LostTimeLight", 
    "maxlodscaler", 
    "metro", 
    "METRO_platform", 
    "METRO_Tunnels", 
    "METRO_Tunnels_entrance", 
    "MichaelColorCode", 
    "MichaelColorCodeBasic", 
    "MichaelColorCodeBright", 
    "MichaelsDarkroom", 
    "MichaelsDirectional", 
    "MichaelsNODirectional", 
    "micheal", 
    "micheals_lightsOFF", 
    "michealspliff", 
    "michealspliff_blend", 
    "michealspliff_blend02", 
    "militarybase_nightlight", 
    "mineshaft", 
    "morebloom", 
    "morgue_dark", 
    "morgue_dark_ovr", 
    "Mp_apart_mid", 
    "mp_bkr_int01_garage", 
    "mp_bkr_int01_small_rooms", 
    "mp_bkr_int01_transition", 
    "mp_bkr_int02_garage", 
    "mp_bkr_int02_hangout", 
    "mp_bkr_int02_small_rooms", 
    "mp_bkr_ware01", 
    "mp_bkr_ware02_dry", 
    "mp_bkr_ware02_standard", 
    "mp_bkr_ware02_upgrade", 
    "mp_bkr_ware03_basic", 
    "mp_bkr_ware03_upgrade", 
    "mp_bkr_ware04", 
    "mp_bkr_ware05", 
    "MP_Bull_tost", 
    "MP_Bull_tost_blend", 
    "MP_corona_heist", 
    "MP_corona_heist_blend", 
    "MP_corona_heist_BW", 
    "MP_corona_heist_BW_night", 
    "MP_corona_heist_DOF", 
    "MP_corona_heist_night", 
    "MP_corona_heist_night_blend", 
    "MP_corona_selection", 
    "MP_corona_switch", 
    "MP_corona_tournament", 
    "MP_corona_tournament_DOF", 
    "MP_death_grade", 
    "MP_death_grade_blend01", 
    "MP_death_grade_blend02", 
    "MP_deathfail_night", 
    "mp_exec_office_01", 
    "mp_exec_office_02", 
    "mp_exec_office_03", 
    "mp_exec_office_03_blue", 
    "mp_exec_office_03C", 
    "mp_exec_office_04", 
    "mp_exec_office_05", 
    "mp_exec_office_06", 
    "mp_exec_warehouse_01", 
    "MP_Garage_L", 
    "MP_H_01_Bathroom", 
    "MP_H_01_Bedroom", 
    "MP_H_01_New", 
    "MP_H_01_New_Bathroom", 
    "MP_H_01_New_Bedroom", 
    "MP_H_01_New_Study", 
    "MP_H_01_Study", 
    "MP_H_02", 
    "MP_H_04", 
    "mp_h_05", 
    "MP_H_06", 
    "mp_h_07", 
    "mp_h_08", 
    "MP_heli_cam", 
    "mp_imx_intwaremed", 
    "mp_imx_intwaremed_office", 
    "mp_imx_mod_int_01", 
    "MP_intro_logo", 
    "MP_job_end_night", 
    "MP_job_load", 
    "MP_job_load_01", 
    "MP_job_load_02", 
    "MP_job_lose", 
    "MP_job_preload", 
    "MP_job_preload_blend", 
    "MP_job_preload_night", 
    "MP_job_win", 
    "MP_Killstreak", 
    "MP_Killstreak_blend", 
    "mp_lad_day", 
    "mp_lad_judgment", 
    "mp_lad_night", 
    "MP_Loser", 
    "MP_Loser_blend", 
    "MP_lowgarage", 
    "MP_MedGarage", 
    "MP_Powerplay", 
    "MP_Powerplay_blend", 
    "MP_race_finish", 
    "MP_select", 
    "Mp_Stilts", 
    "Mp_Stilts2", 
    "Mp_Stilts2_bath", 
    "Mp_Stilts_gym", 
    "Mp_Stilts_gym2", 
    "MP_Studio_Lo", 
    "MPApart_H_01", 
    "MPApart_H_01_gym", 
    "MPApartHigh", 
    "MPApartHigh_palnning", 
    "mugShot", 
    "mugShot_lineup", 
    "Multipayer_spectatorCam", 
    "multiplayer_ped_fight", 
    "nervousRON_fog", 
    "NeutralColorCode", 
    "NeutralColorCodeBasic", 
    "NeutralColorCodeBright", 
    "NeutralColorCodeLight", 
    "NEW_abattoir", 
    "new_bank", 
    "NEW_jewel", 
    "NEW_jewel_EXIT", 
    "NEW_lesters", 
    "new_MP_Garage_L", 
    "NEW_ornate_bank", 
    "NEW_ornate_bank_entrance", 
    "NEW_ornate_bank_office", 
    "NEW_ornate_bank_safe", 
    "New_sewers", 
    "NEW_shrinksOffice", 
    "NEW_station_unfinished", 
    "new_stripper_changing", 
    "NEW_trevorstrailer", 
    "NEW_tunnels", 
    "NEW_tunnels_ditch", 
    "new_tunnels_entrance", 
    "NEW_tunnels_hole", 
    "NEW_yellowtunnels", 
    "NewMicheal", 
    "NewMicheal_night", 
    "NewMicheal_upstairs", 
    "NewMichealgirly", 
    "NewMichealstoilet", 
    "NewMichealupstairs", 
    "nextgen", 
    "NG_blackout", 
    "NG_deathfail_BW_base", 
    "NG_deathfail_BW_blend01", 
    "NG_deathfail_BW_blend02", 
    "NG_filmic01", 
    "NG_filmic02", 
    "NG_filmic03", 
    "NG_filmic04", 
    "NG_filmic05", 
    "NG_filmic06", 
    "NG_filmic07", 
    "NG_filmic08", 
    "NG_filmic09", 
    "NG_filmic10", 
    "NG_filmic11", 
    "NG_filmic12", 
    "NG_filmic13", 
    "NG_filmic14", 
    "NG_filmic15", 
    "NG_filmic16", 
    "NG_filmic17", 
    "NG_filmic18", 
    "NG_filmic19", 
    "NG_filmic20", 
    "NG_filmic21", 
    "NG_filmic22", 
    "NG_filmic23", 
    "NG_filmic24", 
    "NG_filmic25", 
    "NG_filmnoir_BW01", 
    "NG_filmnoir_BW02", 
    "NG_first", 
    "nightvision", 
    "NO_coronas", 
    "NO_fog_alpha", 
    "NO_streetAmbient", 
    "NO_weather", 
    "NoAmbientmult", 
    "NoAmbientmult_interior", 
    "NOdirectLight", 
    "NoPedLight", 
    "NOrain", 
    "overwater", 
    "Paleto", 
    "paleto_nightlight", 
    "paleto_opt", 
    "PennedInDark", 
    "PennedInLight", 
    "PERSHING_water_reflect", 
    "phone_cam", 
    "phone_cam1", 
    "phone_cam10", 
    "phone_cam11", 
    "phone_cam12", 
    "phone_cam13", 
    "phone_cam2", 
    "phone_cam3", 
    "phone_cam3_REMOVED", 
    "phone_cam4", 
    "phone_cam5", 
    "phone_cam6", 
    "phone_cam7", 
    "phone_cam8", 
    "phone_cam8_REMOVED", 
    "phone_cam9", 
    "plane_inside_mode", 
    "player_transition", 
    "player_transition_no_scanlines", 
    "player_transition_scanlines", 
    "PlayerSwitchNeutralFlash", 
    "PlayerSwitchPulse", 
    "plaza_carpark", 
    "PoliceStation", 
    "PoliceStationDark", 
    "polluted", 
    "poolsidewaterreflection2", 
    "PORT_heist_underwater", 
    "powerplant_nightlight", 
    "powerstation", 
    "PPFilter", 
    "PPGreen01", 
    "PPGreen02", 
    "PPOrange01", 
    "PPOrange02", 
    "PPPink01", 
    "PPPink02", 
    "PPPurple01", 
    "PPPurple02", 
    "prison_nightlight", 
    "projector", 
    "prologue", 
    "prologue_ending_fog", 
    "prologue_ext_art_amb", 
    "prologue_reflection_opt", 
    "prologue_shootout", 
    "Prologue_shootout_opt", 
    "pulse", 
    "RaceTurboDark", 
    "RaceTurboFlash", 
    "RaceTurboLight", 
    "ranch", 
    "REDMIST", 
    "REDMIST_blend", 
    "ReduceDrawDistance", 
    "ReduceDrawDistanceMAP", 
    "ReduceDrawDistanceMission", 
    "reducelightingcost", 
    "ReduceSSAO", 
    "reducewaterREF", 
    "refit", 
    "reflection_correct_ambient", 
    "RemoteSniper", 
    "resvoire_reflection", 
    "rply_brightness", 
    "rply_brightness_neg", 
    "rply_contrast", 
    "rply_contrast_neg", 
    "rply_motionblur", 
    "rply_saturation", 
    "rply_saturation_neg", 
    "rply_vignette", 
    "rply_vignette_neg", 
    "SALTONSEA", 
    "sandyshore_nightlight", 
    "SAWMILL", 
    "scanline_cam", 
    "scanline_cam_cheap", 
    "scope_zoom_in", 
    "scope_zoom_out", 
    "secret_camera", 
    "services_nightlight", 
    "shades_pink", 
    "shades_yellow", 
    "SheriffStation", 
    "ship_explosion_underwater", 
    "ship_lighting", 
    "Shop247", 
    "Shop247_none", 
    "sleeping", 
    "Sniper", 
    "SP1_03_drawDistance", 
    "spectator1", 
    "spectator10", 
    "spectator2", 
    "spectator3", 
    "spectator4", 
    "spectator5", 
    "spectator6", 
    "spectator7", 
    "spectator8", 
    "spectator9", 
    "StadLobby", 
    "stc_coroners", 
    "stc_deviant_bedroom", 
    "stc_deviant_lounge", 
    "stc_franklinsHouse", 
    "stc_trevors", 
    "stoned", 
    "stoned_aliens", 
    "stoned_cutscene", 
    "stoned_monkeys", 
    "StreetLighting", 
    "StreetLightingJunction", 
    "StreetLightingtraffic", 
    "STRIP_changing", 
    "STRIP_nofog", 
    "STRIP_office", 
    "STRIP_stage", 
    "StuntFastDark", 
    "StuntFastLight", 
    "StuntSlowDark", 
    "StuntSlowLight", 
    "subBASE_water_ref", 
    "sunglasses", 
    "superDARK", 
    "switch_cam_1", 
    "switch_cam_2", 
    "telescope", 
    "TinyGreen01", 
    "TinyGreen02", 
    "TinyPink01", 
    "TinyPink02", 
    "TinyRacerMoBlur", 
    "torpedo", 
    "traffic_skycam", 
    "trailer_explosion_optimise", 
    "TREVOR", 
    "TrevorColorCode", 
    "TrevorColorCodeBasic", 
    "TrevorColorCodeBright", 
    "Trevors_room", 
    "trevorspliff", 
    "trevorspliff_blend", 
    "trevorspliff_blend02", 
    "Tunnel", 
    "tunnel_entrance", 
    "tunnel_entrance_INT", 
    "TUNNEL_green", 
    "Tunnel_green1", 
    "TUNNEL_green_ext", 
    "tunnel_id1_11", 
    "TUNNEL_orange", 
    "TUNNEL_orange_exterior", 
    "TUNNEL_white", 
    "TUNNEL_yellow", 
    "TUNNEL_yellow_ext", 
    "ufo", 
    "ufo_deathray", 
    "underwater", 
    "underwater_deep", 
    "underwater_deep_clear", 
    "v_abattoir", 
    "V_Abattoir_Cold", 
    "v_bahama", 
    "v_cashdepot", 
    "V_CIA_Facility", 
    "v_dark", 
    "V_FIB_IT3", 
    "V_FIB_IT3_alt", 
    "V_FIB_IT3_alt5", 
    "V_FIB_stairs", 
    "v_foundry", 
    "v_janitor", 
    "v_jewel2", 
    "v_metro", 
    "V_Metro2", 
    "V_Metro_station", 
    "v_michael", 
    "v_michael_lounge", 
    "V_Office_smoke", 
    "V_Office_smoke_ext", 
    "V_Office_smoke_Fire", 
    "v_recycle", 
    "V_recycle_dark", 
    "V_recycle_light", 
    "V_recycle_mainroom", 
    "v_rockclub", 
    "V_Solomons", 
    "v_strip3", 
    "V_strip_nofog", 
    "V_strip_office", 
    "v_strpchangerm", 
    "v_sweat", 
    "v_sweat_entrance", 
    "v_sweat_NoDirLight", 
    "v_torture", 
    "Vagos", 
    "vagos_extlight_small", 
    "VAGOS_new_garage", 
    "VAGOS_new_hangout", 
    "VagosSPLASH", 
    "VC_tunnel_entrance", 
    "vehicle_subint", 
    "venice_canal_tunnel", 
    "vespucci_garage", 
    "VolticBlur", 
    "VolticFlash", 
    "VolticGold", 
    "WAREHOUSE", 
    "WATER _lab_cooling", 
    "WATER_CH2_06_01_03", 
    "WATER_CH2_06_02", 
    "WATER_CH2_06_04", 
    "WATER_cove", 
    "WATER_hills", 
    "WATER_ID2_21", 
    "WATER_lab", 
    "WATER_militaryPOOP", 
    "WATER_muddy", 
    "WATER_port", 
    "WATER_REF_malibu", 
    "WATER_refmap_high", 
    "WATER_refmap_hollywoodlake", 
    "WATER_refmap_low", 
    "WATER_refmap_med", 
    "WATER_refmap_off", 
    "WATER_refmap_poolside", 
    "WATER_refmap_silverlake", 
    "WATER_refmap_venice", 
    "WATER_refmap_verylow", 
    "WATER_resevoir", 
    "WATER_RichmanStuntJump", 
    "WATER_river", 
    "WATER_salton", 
    "WATER_salton_bottom", 
    "WATER_shore", 
    "WATER_silty", 
    "WATER_silverlake", 
    "whitenightlighting", 
    "WhiteOut", 
    "winning_room", 
    "yacht_DLC", 
    "yell_tunnel_nodirect", 
}

-- disables character/vehicle controls when using camera movements
Cfg.disabledControls = {
    30,     -- A and D (Character Movement)
    31,     -- W and S (Character Movement)
    21,     -- LEFT SHIFT
    36,     -- LEFT CTRL
    44,     -- Q
    38,     -- E
    71,     -- W (Vehicle Movement)
    72,     -- S (Vehicle Movement)
    59,     -- A and D (Vehicle Movement)
    60,     -- LEFT SHIFT and LEFT CTRL (Vehicle Movement)
    85,     -- Q (Radio Wheel)
    86,     -- E (Vehicle Horn)
}


--------------------------------------------------
------- FREECAM FOR FIVEM MADE BY KIMINAZE -------
--------------------------------------------------



--------------------------------------------------
------------------- VARIABLES --------------------
--------------------------------------------------

-- main variables
local cam = nil

local offsetRotX = 0.0
local offsetRotY = 0.0
local offsetRotZ = 0.0

local itemCamPrecision
local itemCamFov

local currFilter = 1
local currFilterIntensity = 10

local isAttached = true
local camCoords

-- menu variables
local _menuPool = NativeUI.CreatePool()
local camMenu

-- print error if no menu access was specified
if (not(Cfg.useButton or Cfg.useCommand)) then
    print(Cfg.strings.noAccessError)
end



--------------------------------------------------
---------------------- LOOP ----------------------
--------------------------------------------------
Citizen.CreateThread(function()
    camMenu = NativeUI.CreateMenu(Cfg.strings.menuTitle, Cfg.strings.menuSubtitle)
	_menuPool:Add(camMenu)

    while true do
        Citizen.Wait(1)
        
        -- process menu
        if (_menuPool:IsAnyMenuOpen()) then
            _menuPool:ProcessMenus()
        end

        -- open / close menu on button press
        if (Cfg.useButton and GetLastInputMethod(2) and IsControlJustReleased(1, Cfg.button)) then
            if IsAnyJobs({'weazel', 'ghost'}) then
                if (camMenu:Visible()) then
                    camMenu:Visible(false)
                else
                    GenerateCamMenu()
                    camMenu:Visible(true)
                end
            end
        end

        -- process cam controls if cam exists
        if (cam) then
            ProcessCamControls()
        end
    end
end)



--------------------------------------------------
---------------------- MENU ----------------------
--------------------------------------------------
function GenerateCamMenu()
    _menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    collectgarbage()
    
    camMenu = NativeUI.CreateMenu(Cfg.strings.menuTitle, Cfg.strings.menuSubtitle)
    _menuPool:Add(camMenu)
    
    -- add additional control help
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 38, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 44, true), Cfg.strings.ctrlHelpRoll})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 36, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 21, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 30, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 31, true), Cfg.strings.ctrlHelpMove})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 2, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 1, true), Cfg.strings.ctrlHelpRotate})

    local itemToggleCam = NativeUI.CreateCheckboxItem(Cfg.strings.toggleCam, DoesCamExist(cam), Cfg.strings.toggleCamDesc)
    camMenu:AddItem(itemToggleCam)

    local precision = {}
    for i=0.1, 2.01, 0.1 do table.insert(precision, tostring(i)) end
    itemCamPrecision = NativeUI.CreateListItem(Cfg.strings.precision, precision, 10, Cfg.strings.precisionDesc)
    camMenu:AddItem(itemCamPrecision)

    local fovs = {}
    for i=Cfg.minFov, Cfg.maxFov, 1.0 do table.insert(fovs, i) end
    local currFov
    if (cam) then
        currFov = GetCamFov(cam)
    else
        currFov = GetGameplayCamFov()
    end
    itemCamFov = NativeUI.CreateListItem(Cfg.strings.camFov, fovs, math.floor(currFov-Cfg.minFov)+1.0, Cfg.strings.camFovDesc)
    camMenu:AddItem(itemCamFov)
    
    local submenuFilter = _menuPool:AddSubMenu(camMenu, Cfg.strings.filter, Cfg.strings.filterDesc)
    camMenu.Items[#camMenu.Items]:SetLeftBadge(15)
    local itemFilter = NativeUI.CreateListItem(Cfg.strings.filter, Cfg.filterList, currFilter, Cfg.strings.filterDesc)
    submenuFilter.SubMenu:AddItem(itemFilter)
    local filterInten = {}
    for i=0.1, 2.01, 0.1 do table.insert(filterInten, tostring(i)) end
    local itemFilterIntensity = NativeUI.CreateListItem(Cfg.strings.filterInten, filterInten, currFilterIntensity, Cfg.strings.filterIntenDesc)
    submenuFilter.SubMenu:AddItem(itemFilterIntensity)
    local itemDelFilter = NativeUI.CreateItem(Cfg.strings.delFilter, Cfg.strings.delFilterDesc)
    submenuFilter.SubMenu:AddItem(itemDelFilter)
    
    local itemShowMap = NativeUI.CreateCheckboxItem(Cfg.strings.showMap, not IsRadarHidden(), Cfg.strings.showMapDesc)
    camMenu:AddItem(itemShowMap)

    local itemAttachCam = NativeUI.CreateCheckboxItem(Cfg.strings.attachCam, isAttached, "")
    if (Cfg.detachOption) then
        if HighLife.Player.Special then
            camMenu:AddItem(itemAttachCam)
        end
    end
    

    itemToggleCam.CheckboxEvent = function(menu, item, checked)
        if (checked) then
            StartFreeCam(itemCamFov.Items[itemCamFov._Index])
            _menuPool:RefreshIndex()
        else
            EndFreeCam()
            _menuPool:RefreshIndex()
        end
    end

    itemCamFov.OnListChanged = function(menu, item, newindex)
        if (DoesCamExist(cam)) then
            SetCamFov(cam, itemCamFov.Items[newindex])
        end
    end

    itemShowMap.CheckboxEvent = function(menu, item, checked)
        DisplayRadar(checked)
    end

    if (Cfg.detachOption) then
        itemAttachCam.CheckboxEvent = function(menu, item, checked)
            if (checked) then
                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)
                local rot       = GetEntityRotation(playerPed)
                SetCamCoord(cam, coords)
                SetCamRot(cam, rot)
                Citizen.Wait(1)
                AttachCamToEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
            else
                DetachCam(cam)
            end

            isAttached = checked
        end
    end

    itemFilter.OnListChanged = function(menu, item, newindex)
        SetTimecycleModifier(Cfg.filterList[newindex])
        currFilter = newindex
    end

    itemFilterIntensity.OnListChanged = function(menu, item, newindex)
        SetTimecycleModifier(Cfg.filterList[currFilter])
        SetTimecycleModifierStrength(tonumber(filterInten[newindex]))
        currFilterIntensity = newindex
    end

    submenuFilter.SubMenu.OnItemSelect = function(menu, item, index)
        if (item == itemDelFilter) then
            ClearTimecycleModifier()
            itemFilter._Index   = 1
            currFilter          = 1
            itemFilterIntensity._Index  = 10
            currFilterIntensity         = 10
        end
    end


    camMenu:GoDown()
    submenuFilter.SubMenu:GoDown()

    _menuPool:ControlDisablingEnabled(false)
    _menuPool:MouseControlsEnabled(false)

    --_menuPool:RefreshIndex()
end



--------------------------------------------------
------------------- FUNCTIONS --------------------
--------------------------------------------------

-- initialize camera
function StartFreeCam(fov)
    ClearFocus()

    local playerPed = GetPlayerPed(-1)
    
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, fov * 1.0)

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, false)
    
    SetCamAffectsAiming(cam, false)

    if (isAttached) then
        AttachCamToEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    end
end

-- destroy camera
function EndFreeCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    
    offsetRotX = 0.0
    offsetRotY = 0.0
    offsetRotZ = 0.0

    cam = nil
end

-- process camera controls
function ProcessCamControls()
    -- disable 1st person as the 1st person camera can cause some glitches
    DisableFirstPersonCamThisFrame()
    
    local playerPed = GetPlayerPed(-1)
    local playerRot = GetEntityRotation(playerPed, 2)

    local rotX = playerRot.x
    local rotY = playerRot.y
    local rotZ = playerRot.z

    if (_menuPool:IsAnyMenuOpen()) then
        -- disable character/vehicle controls
        for k, v in pairs(Cfg.disabledControls) do
            DisableControlAction(0, v, true)
        end
        
        -- mouse controls
        offsetRotX = offsetRotX - (GetDisabledControlNormal(1, 2) * 8.0)
        offsetRotZ = offsetRotZ - (GetDisabledControlNormal(1, 1) * 8.0)
        if (offsetRotX > 90.0) then offsetRotX = 90.0 elseif (offsetRotX < -90.0) then offsetRotX = -90.0 end
        if (offsetRotY > 90.0) then offsetRotY = 90.0 elseif (offsetRotY < -90.0) then offsetRotY = -90.0 end
        if (offsetRotZ > 360.0) then offsetRotZ = offsetRotZ - 360.0 elseif (offsetRotZ < -360.0) then offsetRotZ = offsetRotZ + 360.0 end
        
        -- calculate coord and rotation offset of cam
        if (isAttached) then
            local offsetCoords = GetOffsetFromEntityGivenWorldCoords(playerPed, GetCamCoord(cam))
            local x = offsetCoords.x
            local y = offsetCoords.y
            local z = offsetCoords.z
            
            if (IsDisabledControlPressed(1, 32)) then -- W
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 33)) then -- S
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 34)) then -- A
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 35)) then -- D
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                z = z + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                z = z - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 44)) then -- Q
                offsetRotY = offsetRotY - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                if (offsetRotY < -360.0) then offsetRotY = offsetRotY + 360.0 end
            end
            if (IsDisabledControlPressed(1, 38)) then -- E
                offsetRotY = offsetRotY + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                if (offsetRotY > 360.0) then offsetRotY = offsetRotY - 360.0 end
            end

            -- set coords of cam
            AttachCamToEntity(cam, playerPed, x, y, z, true)
            
            SetFocusEntity(playerPed)

            -- reset coords of cam if too far from player
            if (Vdist(0.0, 0.0, 0.0, x, y, z) > Cfg.maxDistance) then
                AttachCamToEntity(cam, playerPed, offsetCoords.x, offsetCoords.y, offsetCoords.z, true)
            end
        else
            local camCoords = GetCamCoord(cam)
            local x = camCoords.x
            local y = camCoords.y
            local z = camCoords.z
            
            if (IsDisabledControlPressed(1, 32)) then -- W
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 33)) then -- S
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 34)) then -- A
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 35)) then -- D
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                z = z + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                z = z - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 44)) then -- Q
                offsetRotY = offsetRotY - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 38)) then -- E
                offsetRotY = offsetRotY + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            
            SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
            SetCamCoord(cam, x, y, z)
        end
    end
    
    -- set rotation of cam
    if (isAttached) then
        SetCamRot(cam, rotX+offsetRotX, rotY+offsetRotY, rotZ+offsetRotZ, 2)
    else
        SetCamRot(cam, offsetRotX, offsetRotY, offsetRotZ, 2)
    end
end