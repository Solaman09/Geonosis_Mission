//Function Parms
//[0] = Arsenal Object
//[1] = Player
// Usage:
// [_box, _player] call roleArsenal;
roleArsenal = {
	params ["_box", "_player"];

	//diag_log "[Watergard] - Entered Role Restricted Arsenal Script";

	Private _UnitRole = roleDescription _player;

	//Clear the inventory
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	clearWeaponCargoGlobal _box;

	_Role = [];

	// Admin
	if ((_UnitRole == "Admin@Icarus 1")
	or (_UnitRole == "Admin@Icarus 2")) then
	{_Role = "ADMIN"};

	// Command
	if ((_UnitRole == "Knight@Command")
	or (_UnitRole == "Salmon@Command")
	or (_UnitRole == "Metal@Command")
	or (_UnitRole == "CompanyCommander@Leviathon")
	or (_UnitRole == "PlatoonLeader@Leviathon")	) then
	{_Role = "CO"};

    // GROUND
		//SL
			if ((_UnitRole == "173 Squad Leader@Phoenix 3")
			or (_UnitRole == "173 Squad Leader@Phoenix 2")
			or (_UnitRole == "173 Squad Leader@Phoenix 1")
			or (_UnitRole == "Squad Leader@Basilisk")
			or (_UnitRole == "Aux. Squad Leader@Basilisk")
			or (_UnitRole == "Squad Leader@Tyr")
			or (_UnitRole == "Team Leader@Tyr")) then
			{_Role = "SL"};
		//MEDIC
			if ((_UnitRole == "173 Medic@Phoenix 1")
			or (_UnitRole == "173 Medic@Phoenix 2")
			or (_UnitRole == "173 Medic@Phoenix 3")
			or (_UnitRole == "Medic@Basilisk") 
			or (_UnitRole == "Medic@Tyr")
			or (_UnitRole == "Medic@Dagger"))then
			{_Role = "MEDIC"};
		//MARKSMAN
			if ((_UnitRole == "173 Marksman@Phoenix 1")
			or (_UnitRole == "173 Marksman@Phoenix 2")
			or (_UnitRole == "173 Marksman@Phoenix 3")) then
			{_Role = "MARKSMAN"};
		//ENGINEER
			if ((_UnitRole == "173 Demolition@Phoenix 1")
			or (_UnitRole == "173 Demolition@Phoenix 2")
			or (_UnitRole == "173 Demolition@Phoenix 3")) then
			{_Role = "ENGINEER"};
		//AUTORIFLEMAN
			if ((_UnitRole == "173 Autorifleman@Phoenix 1")
			or (_UnitRole == "173 Autorifleman@Phoenix 2")
			or (_UnitRole == "173 Autorifleman@Phoenix 3")
			or (_UnitRole == "AutoRifleman@Tyr")
			or (_UnitRole == "Autorifleman@Dagger")) then
			{_Role = "AUTORIFLEMAN"};
		//AT
			if ((_UnitRole == "173 Anti Tank@Phoenix 1")
			or (_UnitRole == "173 Anti Tank@Phoenix 2")
			or (_UnitRole == "173 Anti Tank@Phoenix 3")
			or (_UnitRole == "Anti Tank@Tyr")
			or (_UnitRole == "Anti Tank@Dagger")) then
			{_Role = "AT"};
		//RIFLEMAN
			if ((_UnitRole == "Rifleman@Phoenix 1")
			or (_UnitRole == "Rifleman@Phoenix 2")
			or (_UnitRole == "Rifleman@Phoenix 3")
			or (_UnitRole == "Rifleman@Tyr")
			or (_UnitRole == "Rifleman@Dagger")) then
			{_Role = "RIFLEMAN"};



	// ARMOUR
	if ((_UnitRole == "Commander@Keystone")
	or (_UnitRole == "Driver@Keystone")
	or (_UnitRole == "Gunner@Keystone")) then
	{_Role = "KEYSTONE"};

	// Epsilon
	if ((_UnitRole == "173 Pilot@Epsilon")
	or (_UnitRole == "Pilot@Orion")
	or (_UnitRole == "Pilot@Hermes")) then
	{_Role = "Epsilon"};

	//ClapTrap
	if ((_UnitRole == "JFO@Claptrap")
	or (_UnitRole == "PlatoonRTO@Leviathon"))
 then
	{_Role = "JFO"};


	//Empty array of gear to add to the arsenal per player.
	Private _GearToAdd = [];

	//Define the gear for each Role
	Private _DefaultGear = 
["41st_Shemagh_Arctic","41st_Shemagh_Arctic_UP","41st_Shemagh_BlkMulticam","41st_Shemagh_BlkMulticam_UP","41st_Shemagh_McDraugr","41st_Shemagh_McDraugr_UP","41st_Shemagh_McFenrir","41st_Shemagh_McFenrir_UP","41st_Shemagh_McGungnir","41st_Shemagh_McGungnir_UP","41st_Shemagh_McHeimdall","41st_Shemagh_McHeimdall_UP","41st_Shemagh_McHelljumper","41st_Shemagh_McHelljumper_UP","41st_Shemagh_McLoki","41st_Shemagh_McLoki_UP","41st_Shemagh_McSkoll","41st_Shemagh_McSkoll_UP","41st_Shemagh_McSurtr","41st_Shemagh_McSurtr_UP","41st_Shemagh_McSvalinn","41st_Shemagh_McSvalinn_UP","41st_Shemagh_McValkyrie","41st_Shemagh_McValkyrie_UP","41st_Shemagh_MTP","41st_Shemagh_MTP_UP","41st_Shemagh_Multicam","41st_Shemagh_Multicam_UP","41st_Shemagh_Olive","41st_Shemagh_Olive_UP","41st_Shemagh_Tan","41st_Shemagh_Tan_UP","41st_Shemagh_Woodland","41st_Shemagh_Woodland_UP","G_Balaclava_blk","G_Balaclava_BlueStrips","G_Balaclava_combat","G_Balaclava_Flecktarn","G_Balaclava_Halloween_01","G_Balaclava_lowprofile","G_Balaclava_oli","G_Balaclava_Flames1","G_Balaclava_Scarecrow_01","G_Balaclava_Skull1","G_Balaclava_Tropentarn","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_BlueFlame1","G_Bandanna_BlueFlame2","G_Bandanna_CandySkull","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_OrangeFlame1","G_Bandanna_RedFlame1","G_Bandanna_shades","G_Bandanna_Skull1","G_Bandanna_Syndikat1","G_Bandanna_Skull2","G_Bandanna_Vampire_01","OPTRE_Glasses_Cigar","OPTRE_Glasses_Cigarette","OPTRE_CBRN_S2","OPTRE_CBRN_S","OPTRE_CBRN","OPTRE_NVG_UAB","OPTRE_NVG_UA","OPTRE_NVG_UL_HUL","OPTRE_NVG_UL_CNM","OPTRE_NVG_UAB_UL_HUL","OPTRE_NVG_UAB_UL_CNM","OPTRE_NVG_UAB_UL","OPTRE_NVG_UAB_HUL","OPTRE_NVG_UAB_CNM","OPTRE_NVG_UA_UL_CNM","OPTRE_NVG_UA_UL","OPTRE_NVG_UA_HURS_HUL","OPTRE_NVG_UA_HURS_CNM","OPTRE_NVG_UA_HURS","OPTRE_NVG_UA_HUL","OPTRE_NVG_UA_CNM","OPTRE_NVG_MVI_UL_HUL","OPTRE_NVG_MVI_UL_CNM","OPTRE_NVG_MVI_UL","OPTRE_NVG_MVI_HUL","OPTRE_NVG_MVI_CNM","immersion_cigs_cigar0_nv","murshun_cigs_cig0_nv","OPTRE_NVGT_C","ACE_adenosine","DMNS_Biofoam","ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_quikclot","OPTRE_Biofoam","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","MRH_BluForTransponder","ACE_bodyBag","ACE_bodyBag_white","ACE_CableTie","ACE_bodyBag_blue","ACE_Chemlight_Shield","ACE_EarPlugs","ACE_EntrenchingTool","ACE_epinephrine","ACE_Fortify","ItemAndroid","ItemcTabHCam","ACE_IR_Strobe_Item","ace_marker_flags_black","ace_marker_flags_blue","ace_marker_flags_green","ace_marker_flags_orange","ace_marker_flags_purple","ace_marker_flags_red","ace_marker_flags_white","ace_marker_flags_yellow","ACE_morphine","ACE_painkillers","ItemcTab","ACE_Tripod","ACE_tourniquet","ACE_splint","ACE_SpareBarrel","ACE_WaterBottle","ACE_WaterBottle_Half","ACE_M14","Chemlight_blue","Chemlight_green","ACE_Chemlight_HiBlue","ACE_Chemlight_HiGreen","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite","ACE_Chemlight_HiYellow","ACE_Chemlight_IR","ACE_Chemlight_Orange","Chemlight_red","ACE_Chemlight_UltraHiOrange","ACE_Chemlight_White","Chemlight_yellow","OPTRE_ELB47_Strobe","ACE_HandFlare_White","ACE_HandFlare_Yellow","OPTRE_M2_Smoke_Blue","OPTRE_M2_Smoke_Green","OPTRE_M2_Smoke_Orange","OPTRE_M2_Smoke_Purple","OPTRE_M2_Smoke_Red","OPTRE_M2_Smoke","OPTRE_M2_Smoke_Yellow","ACE_HandFlare_Red","ACE_HandFlare_Green","OPTRE_M8_Flare_Blue","OPTRE_M8_Flare_Green","OPTRE_M8_Flare","OPTRE_M8_Flare_White","OPTRE_M8_Flare_Yellow","OPTRE_M9_Frag","ACE_Altimeter","TFAR_microdagr","ChemicalDetector_01_watch_F","ItemWatch","TFAR_anprc152","ItemCompass","ItemMap","OPTRE_Smartfinder","OPTRE_Smartfinder_Vector","OPTRE_Binoculars","UNSC_Knife_reversed","UNSC_Knife","OPTRE_M6D","OPTRE_M6D_Black","OPTRE_M6D_Desert","OPTRE_M6D_Jungle","OPTRE_M6G","OPTRE_M6C","OPTRE_M6B","OPTRE_M319M","Knife_kukri","41st_Kukri","OPTRE_SRM_Sight","OPTRE_M393_EOTECH","Optre_Recon_Sight_UNSC","Optre_Recon_Sight_Snow","Optre_Recon_Sight_Red","Optre_Recon_Sight_Green","Optre_Recon_Sight_Desert","Optre_Recon_Sight","OPTRE_SRS99_Scope","OPTRE_SRS99C_Scope","OPTRE_MA5C_SmartLink","OPTRE_MA5_SmartLink","OPTRE_MA5_BUIS","OPTRE_M73_SmartLink","OPTRE_M6G_Scope","OPTRE_M7_Sight","OPTRE_M6D_Scope_Jungle","OPTRE_M6D_Scope_Desert","OPTRE_M6D_Scope_Black","OPTRE_M6C_Scope","OPTRE_M6D_Scope","OPTRE_M12_Optic_Green","OPTRE_M12_Optic_Red","OPTRE_M393_ACOG","OPTRE_BMR_Scope","OPTRE_M392_Scope","OPTRE_M393_Scope","OPTRE_HMG38_CarryHandle","OPTRE_BR45_Scope","OPTRE_BR55HB_Scope","OPTRE_BR55HB_Scope_Grey","MA_BR55HB_Scope","19_UNSC_MA5A_smartlink","19_UNSC_M7_optic","19_UNSC_br_scope","OPTRE_MA37_Smartlink_Scope","OPTRE_M12_Optic","OPTRE_BMR_Laser","OPTRE_DMR_Light","OPTRE_BMR_Flashlight","OPTRE_M12_Laser","OPTRE_M45_Flashlight","OPTRE_M45_Flashlight_blue","OPTRE_M45_Flashlight_cyan","OPTRE_M45_Flashlight_green","OPTRE_M45_Flashlight_purple","OPTRE_M45_Flashlight_red","OPTRE_M45_Flashlight_yellow","OPTRE_M6C_Laser","OPTRE_M6D_Flashlight","OPTRE_M6G_Flashlight","OPTRE_M6D_Flashlight_Black","OPTRE_M6D_Flashlight_Desert","OPTRE_M6D_Flashlight_Jungle","OPTRE_M6D_IR_Laser","OPTRE_M6D_IR_Black","OPTRE_M6D_IR_Desert","OPTRE_M6D_IR_Jungle","OPTRE_M6D_Vis_Red_Laser","OPTRE_M6D_Vis_Red_Black","OPTRE_M6D_Vis_Red_Desert","OPTRE_M6D_Vis_Red_Jungle","OPTRE_M7_Flashlight","OPTRE_M7_Laser","19_UNSC_M7_LAM","19_UNSC_MA5A_LAM","19_UNSC_MA5A_gl_LAM","19_UNSC_BR55_LAM","ACE_DBAL_A3_Green","ACE_DBAL_A3_Red","OPTRE_MA5Suppressor","19_UNSC_MA5A_Suppressor","OPTRE_MA37KSuppressor","19_UNSC_m7_Suppressor","OPTRE_M7_silencer","OPTRE_M6C_compensator","OPTRE_M6_silencer","OPTRE_M393_Suppressor","OPTRE_M12_Suppressor","19_UNSC_BR55_Suppressor","OPTRE_Riot_Shield_Icon_A2S","bipod_01_F_blk","bipod_02_F_blk","bipod_03_F_blk","OPTRE_BR45Grip","173_Odst_Helmet_Stripe","173_Odst_Helmet_Standard","173_Odst_Helmet_Wrap","173_Odst_Helmet_Dual","OPTRE_8Rnd_127x40_Mag","OPTRE_12Rnd_127x40_Desert_Mag","OPTRE_16Rnd_127x40_Desert_Mag","UGL_FlareGreen_F","UGL_FlareYellow_F","1Rnd_SmokeBlue_Grenade_shell","OPTRE_1Rnd_MasterKey_Pellets","ACE_40mm_Flare_ir","OPTRE_3Rnd_SmokeYellow_Grenade_shell","OPTRE_16Rnd_127x40_Black_Mag","UGL_FlareWhite_F","UGL_FlareCIR_F","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell","OPTRE_1Rnd_SmokeYellow_Grenade_shell","OPTRE_12Rnd_127x40_Black_Mag","OPTRE_12Rnd_127x40_Mag_Black_Tracer","OPTRE_1Rnd_Smoke_Grenade_shell","OPTRE_1Rnd_SmokePurple_Grenade_shell","OPTRE_signalSmokeY","OPTRE_3Rnd_SmokeRed_Grenade_shell","OPTRE_3Rnd_SmokePurple_Grenade_shell","M319_Buckshot","3Rnd_SmokeRed_Grenade_shell","ACE_40mm_Flare_red","OPTRE_3Rnd_SmokeGreen_Grenade_shell","OPTRE_12Rnd_127x40_Mag_Tracer","M319_HEDP_Grenade_Shell","M319_Smoke_Red","OPTRE_signalSmokeG","ACE_40mm_Flare_white","OPTRE_3Rnd_SmokeBlue_Grenade_shell","M319_HE_Grenade_Shell","M319_Smoke_Green","3Rnd_HE_Grenade_shell","OPTRE_3Rnd_SmokeOrange_Grenade_shell","OPTRE_12Rnd_127x40_Mag","OPTRE_16Rnd_127x40_Mag_Jungle_Tracer","1Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","OPTRE_signalSmokeR","1Rnd_Smoke_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","3Rnd_UGL_FlareGreen_F","OPTRE_1Rnd_SmokeOrange_Grenade_shell","OPTRE_signalSmokeB","3Rnd_UGL_FlareWhite_F","3Rnd_SmokeYellow_Grenade_shell","OPTRE_1Rnd_SmokeBlue_Grenade_shell","OPTRE_signalSmokeP","OPTRE_3Rnd_Smoke_Grenade_shell","OPTRE_12Rnd_127x40_Mag_Jungle_Tracer","OPTRE_16Rnd_127x40_Mag","OPTRE_1Rnd_SmokeRed_Grenade_shell","OPTRE_8Rnd_127x40_Mag_Tracer","OPTRE_12Rnd_127x40_Mag_Desert_Tracer","1Rnd_HE_Grenade_shell","OPTRE_16Rnd_127x40_Mag_Tracer","OPTRE_16Rnd_127x40_Jungle_Mag","M319_Smoke_Orange","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareYellow_F","OPTRE_1Rnd_MasterKey_Slugs","ACE_40mm_Flare_green","OPTRE_12Rnd_127x40_Jungle_Mag","OPTRE_16Rnd_127x40_Mag_Black_Tracer","OPTRE_1Rnd_SmokeGreen_Grenade_shell","OPTRE_signalSmokeO","OPTRE_16Rnd_127x40_Mag_Desert_Tracer","3Rnd_Smoke_Grenade_shell","ACE_HuntIR_M203","OPTRE_8Rnd_127x40_AP_Mag","M319_Smoke","UGL_FlareRed_F","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","3Rnd_UGL_FlareCIR_F","3Rnd_SmokeOrange_Grenade_shell","19_UNSC_M7","OPTRE_BR37","OPTRE_BR45_Black","OPTRE_BR45","OPTRE_BR45GL","OPTRE_BR45GL_black","OPTRE_BR55","OPTRE_BR55_Grey","OPTRE_BR55HB","OPTRE_BR55HB_Grey","OPTRE_CQS48_Bulldog_Automatic","OPTRE_CQS48_Bulldog_Automatic_Desert","OPTRE_CQS48_Bulldog_Automatic_Green","OPTRE_CQS48S_Chihuahua_Automatic","OPTRE_CQS48S_Chihuahua_Automatic_Desert","OPTRE_CQS48S_Chihuahua_Automatic_Green","OPTRE_CQS48_Bulldog_Automatic_Snow","OPTRE_CQS48S_Chihuahua_Automatic_Snow","OPTRE_M295_BMR","OPTRE_M295_BMR_Desert","OPTRE_M295_BMR_Snow","OPTRE_M295_BMR_Woodland","OPTRE_M392_DMR","OPTRE_M393_DMR","OPTRE_M393S_DMR","OPTRE_M58S","OPTRE_M7","OPTRE_M45ATAC","OPTRE_M45TAC","OPTRE_MA32GL","OPTRE_MA32","OPTRE_MA37GL","OPTRE_MA37","OPTRE_MA37K","OPTRE_MA5AGL","OPTRE_MA5A","OPTRE_MA37BGL","OPTRE_MA37B","OPTRE_MA32BGL","OPTRE_MA32B","OPTRE_MA5B","OPTRE_MA5BGL","OPTRE_MA5C","OPTRE_MA5CGL","OPTRE_MA5K","OPTRE_Commando_Tan","OPTRE_Commando_Snow","OPTRE_Commando_Red","OPTRE_Commando_Black","OPTRE_Commando","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Sand_Tracer_Green","ACE_30Rnd_556x45_Stanag_Tracer_Dim","OPTRE_60Rnd_5x23mm_Mag_tracer","OPTRE_60Rnd_5x23mm_Mag_tracer_yellow","30Rnd_556x45_Stanag_green","OPTRE_12Rnd_12Gauge_Pellets_Tracer","OPTRE_15Rnd_762x51_AP_Mag","OPTRE_48Rnd_5x23mm_FMJ_Mag","OPTRE_60Rnd_762x51_Mag_Tracer_Yellow","30Rnd_556x45_Stanag_Sand_Tracer_Red","OPTRE_10RND_338_SP","OPTRE_36Rnd_95x40_Mag","OPTRE_25Rnd_762x51_AP_Mag_Tracer","OPTRE_15Rnd_762x51_Mag","OPTRE_25Rnd_762x51_AP_Mag","OPTRE_12Rnd_8Gauge_Slugs","OPTRE_32Rnd_762x51_Mag_Tracer","30Rnd_556x45_Stanag_Sand_green","ACE_30Rnd_556x45_Stanag_M995_AP_mag","ACE_30Rnd_556x45_Stanag_Mk318_mag","OPTRE_12Rnd_12Gauge_HE_Tracer","OPTRE_42Rnd_95x40_Mag","OPTRE_42Rnd_95x40_Mag_Tracer","OPTRE_48Rnd_5x23mm_Mag","OPTRE_12Rnd_8Gauge_Pellets","OPTRE_12Rnd_12Gauge_Pellets","OPTRE_12Rnd_12Gauge_HE","OPTRE_12Rnd_12Gauge_Smoke_Tracer","OPTRE_25Rnd_762x51_Mag","OPTRE_15Rnd_762x51_Mag_Tracer","OPTRE_32Rnd_762x51_Mag","OPTRE_32Rnd_762x51_Mag_UW","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Yellow","OPTRE_10RND_338_VLD","OPTRE_36Rnd_95x40_Mag_Tracer","OPTRE_42Rnd_95x40_Mag_Tracer_Yellow","OPTRE_6Rnd_8Gauge_Slugs","Commando_20Rnd_65_Mag","Commando_20Rnd_65_ReloadY_Mag","60Rnd_5x23_m7_fmj","30Rnd_556x45_Stanag_Sand","OPTRE_10RND_338_AP","OPTRE_12Rnd_12Gauge_Smoke","OPTRE_12Rnd_8Gauge_HEDP","OPTRE_32Rnd_762x51_Mag_Tracer_Yellow","Commando_20Rnd_65_TracerY_Mag","30Rnd_556x45_Stanag_red","OPTRE_15Rnd_762x51_Mag_Tracer_Yellow","OPTRE_48Rnd_5x23mm_JHP_Mag","OPTRE_6Rnd_8Gauge_Pellets","60Rnd_5x23_m7_fmj_tracer","30Rnd_556x45_Stanag_Sand_red","OPTRE_60Rnd_5x23mm_Mag","OPTRE_48Rnd_5x23mm_Mag_tracer_yellow","OPTRE_60Rnd_762x51_Mag_Tracer","OPTRE_48Rnd_5x23mm_Mag_tracer","ACE_30Rnd_556x45_Stanag_Mk262_mag","OPTRE_36Rnd_95x40_Mag_Tracer_Yellow","OPTRE_25Rnd_762x51_Mag_Tracer","OPTRE_6Rnd_8Gauge_HEDP","Command_20Rnd_65_TracerR_Mag","30Rnd_556x45_Stanag_Sand_Tracer_Yellow","OPTRE_25Rnd_762x51_Mag_Tracer_Yellow","OPTRE_15Rnd_762x51_AP_Mag_Tracer","OPTRE_60Rnd_762x51_Mag","Commando_20Rnd_65_ReloadR_Mag","ItemMicroDAGR","ACE_HuntIR_monitor","DMNS_M96_LAW","173_gry_uniform","173_urb_uniform","173_wdl_uniform","173_M52D_Basic","173_M52D_Autorifleman","173_M52D_Marksman","173_M52D_martin","173_M52D_Medic","173_M52D_Scout","173_M52D_Sniper","173_Mar_gry_Rucksack","173_Mar_gry_Rucksack_hev","173_Mar_urb_Rucksack_hev","173_Mar_wdl_Rucksack_hev","173_Mar_gry_Rucksack_med","173_Mar_urb_Rucksack_med","173_Mar_wdl_Rucksack_med","173_Mar_gry_Rucksack_rto","173_Mar_urb_Rucksack_rto","173_Mar_wdl_Rucksack_rto","173_Mar_urb_Rucksack","173_Mar_wdl_Rucksack","173_Mar_Rucksack_invis","173_Mar_Rucksack_invis_rto","173_Recon_Helmet_Standard","B_UavTerminal"];


	Private _ADMIN = 
[
"173_wdl_uniform","173_urb_uniform","173_gry_uniform","173_Dress_Uniform_Salmon","173_M52D_blue","173_M52D_cowboy","173_M52D_Knight","173_M52D_Light","173_M52D_metal","173_M52D_prophet","173_M52D_Salmon","MRH_TacticalDisplay","MRH_FoldedSatcomAntenna","ACE_UAVBattery","acex_intelitems_notepad","ACE_RangeCard","ACE_PlottingBoard","173_Mar_gry_Rucksack_rto","173_Mar_urb_Rucksack_rto","173_Mar_wdl_Rucksack_rto","173_Mar_Rucksack_invis_rto","173_Recon_Helmet_Salmon","173_Recon_Helmet_metal","173_Recon_Helmet_Standard","173_Odst_Helmet_Knight","173_Odst_Helmet_Cowboy","173_Odst_Helmet_Blue","173_Odst_Helmet_Alaskan","173_Odst_Helmet_Stripe","173_Odst_Helmet_Standard","173_Odst_Helmet_Wrap","173_Odst_Helmet_Dual"
];






	Private _CO = 
[
"173_wdl_uniform","173_urb_uniform","173_gry_uniform","173_Dress_Uniform_Salmon","173_M52D_blue","173_M52D_cowboy","173_M52D_Knight","173_M52D_Light","173_M52D_metal","173_M52D_prophet","173_M52D_Salmon","MRH_TacticalDisplay","MRH_FoldedSatcomAntenna","ACE_UAVBattery","acex_intelitems_notepad","ACE_RangeCard","ACE_PlottingBoard","173_Mar_gry_Rucksack_rto","173_Mar_urb_Rucksack_rto","173_Mar_wdl_Rucksack_rto","173_Mar_Rucksack_invis_rto","173_Recon_Helmet_Salmon","173_Recon_Helmet_metal","173_Recon_Helmet_Standard","173_Odst_Helmet_Knight","173_Odst_Helmet_Cowboy","173_Odst_Helmet_Blue","173_Odst_Helmet_Alaskan","173_Odst_Helmet_Stripe","173_Odst_Helmet_Standard","173_Odst_Helmet_Wrap","173_Odst_Helmet_Dual"
];



	Private _SL = 
[
"173_wdl_uniform","173_urb_uniform","173_gry_uniform","173_Dress_Uniform_Salmon","173_M52D_blue","173_M52D_cowboy","173_M52D_Knight","173_M52D_Light","173_M52D_metal","173_M52D_prophet","173_M52D_Salmon","MRH_TacticalDisplay","MRH_FoldedSatcomAntenna","ACE_UAVBattery","acex_intelitems_notepad","ACE_RangeCard","ACE_PlottingBoard","173_Mar_gry_Rucksack_rto","173_Mar_urb_Rucksack_rto","173_Mar_wdl_Rucksack_rto","173_Mar_Rucksack_invis_rto","173_Recon_Helmet_Salmon","173_Recon_Helmet_metal","173_Recon_Helmet_Standard","173_Odst_Helmet_Knight","173_Odst_Helmet_Cowboy","173_Odst_Helmet_Blue","173_Odst_Helmet_Alaskan","173_Odst_Helmet_Stripe","173_Odst_Helmet_Standard","173_Odst_Helmet_Wrap","173_Odst_Helmet_Dual"
];

	Private _JFO = 
[
"173_wdl_uniform","173_urb_uniform","173_gry_uniform","173_Dress_Uniform_Salmon","173_M52D_blue","173_M52D_cowboy","173_M52D_Knight","173_M52D_Light","173_M52D_metal","173_M52D_prophet","173_M52D_Salmon","MRH_TacticalDisplay","MRH_FoldedSatcomAntenna","ACE_UAVBattery","acex_intelitems_notepad","ACE_RangeCard","ACE_PlottingBoard","173_Mar_gry_Rucksack_rto","173_Mar_urb_Rucksack_rto","173_Mar_wdl_Rucksack_rto","173_Mar_Rucksack_invis_rto","173_Recon_Helmet_Salmon","173_Recon_Helmet_metal","173_Recon_Helmet_Standard","173_Odst_Helmet_Knight","173_Odst_Helmet_Cowboy","173_Odst_Helmet_Blue","173_Odst_Helmet_Alaskan","173_Odst_Helmet_Stripe","173_Odst_Helmet_Standard","173_Odst_Helmet_Wrap","173_Odst_Helmet_Dual"
];


	Private _MEDIC = 
[
	"173_Mar_gry_Rucksack_med","173_Mar_urb_Rucksack_med","173_Mar_wdl_Rucksack_med","ACE_bodyBag","ACE_bodyBag_blue","ACE_bodyBag_white","ACE_bloodIV_500","ACE_bloodIV_250","ACE_bloodIV","OPTRE_Biofoam","ACE_quikclot","ACE_packingBandage","ACE_elasticBandage","ACE_fieldDressing","ACE_epinephrine","ACE_morphine","OPTRE_Medigel","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_painkillers","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_surgicalKit","ACE_suture","ACE_tourniquet","173_M52D_Medic"

];



	Private _MARKSMAN = 
[
"OPTRE_SRM77_S1","OPTRE_SRM77_S1_Green","OPTRE_SRM77_S1_Blue","OPTRE_SRM77_S1_Red","OPTRE_SRM77_S2","OPTRE_SRM77_S2_Green","OPTRE_SRM77_S2_Blue","OPTRE_SRM77_S2_Red","OPTRE_SRS99C","OPTRE_SRS99D","OPTRE_M99A2S3","OPTRE_10Rnd_127x99","OPTRE_5Rnd_127x99_Subsonic","OPTRE_5Rnd_127x99_Subsonic_noTracer","OPTRE_4Rnd_145x114_HEDP_Mag_D","OPTRE_10Rnd_127x99_Subsonic","OPTRE_10Rnd_127x99_Subsonic_noTracer","OPTRE_7Rnd_20mm_APFSDS_Mag","OPTRE_4Rnd_145x114_HVAP_Mag","OPTRE_4Rnd_145x114_HVAP_Mag_D","OPTRE_7Rnd_20mm_HEDP_Mag","OPTRE_5Rnd_127x99","OPTRE_10Rnd_127x99_noTracer","OPTRE_4Rnd_145x114_HEDP_Mag","OPTRE_5Rnd_127x99_noTracer","OPTRE_4Rnd_145x114_APFSDS_Mag","OPTRE_4Rnd_145x114_APFSDS_Mag_D","optic_tws_mg","optic_SOS","optic_MRCO","optic_Arco_blk_F","optic_LRPS_tna_F","optic_Arco_AK_arid_F","Optre_Recon_Sight","optic_tws","optic_DMS_weathered_Kir_F","optic_Arco_AK_blk_F","ACE_optic_LRPS_PIP","optic_AMS","Optre_Recon_Sight_UNSC","ACE_optic_Arco_2D","ACE_optic_SOS_PIP","optic_KHS_hex","optic_Arco","optic_ERCO_snd_F","optic_Holosight_khk_F","OPTRE_MA5_BUIS","OPTRE_BR55HB_Scope_Grey","optic_AMS_snd","optic_ACO_grn","optic_DMS_weathered_F","optic_Arco_lush_F","optic_Nightstalker","optic_KHS_old","Optre_Recon_Sight_Snow","OPTRE_BR45_Scope","ACE_optic_Hamr_PIP","ACE_optic_MRCO_2D","optic_KHS_tan","optic_Aco","optic_Holosight_smg","optic_Arco_arid_F","optic_Holosight_arid_F","OPTRE_M393_ACOG","optic_SOS_khk_F","optic_Arco_ghex_F","optic_Arco_AK_lush_F","OPTRE_M7_Sight","OPTRE_M12_Optic_Green","OPTRE_MA5C_SmartLink","OPTRE_SRM_Sight","OPTRE_SRS99_Scope","ACE_optic_Hamr_2D","ACE_optic_Arco_PIP","optic_Hamr","optic_ERCO_khk_F","optic_Holosight_smg_khk_F","OPTRE_M12_Optic","Optre_Recon_Sight_Red","OPTRE_BMR_Scope","optic_LRPS","optic_ACO_grn_smg","OPTRE_M392_Scope","OPTRE_SRS99C_Scope","OPTRE_M73_SmartLink","OPTRE_MA5_SmartLink","OPTRE_M393_EOTECH","optic_AMS_khk","optic_ERCO_blk_F","OPTRE_M6C_Scope","Optre_Recon_Sight_Desert","optic_dms","optic_LRPS_ghex_F","optic_Holosight_blk_F","optic_Holosight_lush_F","OPTRE_HMG38_CarryHandle","OPTRE_M12_Optic_Red","optic_NVS","optic_DMS_ghex_F","OPTRE_M6G_Scope","Optre_Recon_Sight_Green","OPTRE_BR55HB_Scope","optic_KHS_blk","optic_Aco_smg","optic_Holosight","optic_Hamr_khk_F","optic_Holosight_smg_blk_F","OPTRE_M393_Scope","ACE_optic_SOS_2D","ACE_optic_LRPS_2D","OPTRE_M7_Laser","acc_pointer_IR","OPTRE_BMR_Laser","acc_flashlight","ACE_DBAL_A3_Green","OPTRE_M45_Flashlight","OPTRE_M7_Flashlight","OPTRE_M6C_Laser","OPTRE_M6G_Flashlight","OPTRE_M12_Laser","ACE_DBAL_A3_Red","ACE_SPIR","ACE_acc_pointer_green","muzzle_snds_B_lush_F","muzzle_snds_B","muzzle_snds_B_arid_F","OPTRE_M6C_compensator","OPTRE_MA5Suppressor","muzzle_snds_B_snd_F","OPTRE_M7_silencer","OPTRE_M393_Suppressor","OPTRE_M12_Suppressor","ACE_muzzle_mzls_B","OPTRE_SRS99D_Suppressor","muzzle_snds_B_khk_F","OPTRE_M6_silencer","OPTRE_MA37KSuppressor","173_M52D_Marksman"

];


	Private _ENGINEER = 
[
	
"173_M52D_Demo","173_Mar_gry_Rucksack_hev","173_Mar_urb_Rucksack_hev","173_Mar_wdl_Rucksack_hev","C7_Remote_Mag","C12_Remote_Mag","OPTRE_FC_BubbleShield","APERSMineDispenser_Mag","UNSCMine_Range_Mag","M168_Remote_Mag","M41_IED_C_Remote_Mag","M41_IED_Remote_Mag","M41_IED_B_Remote_Mag","ToolKit","ACE_DefusalKit","ACE_DeadManSwitch","ACE_Clacker","ACE_M26_Clacker","MineDetector","ACE_SpraypaintRed","ACE_SpraypaintBlue","ACE_wirecutter","B_UavTerminal"

];

	Private _AUTORIFLEMAN = 
[
"OPTRE_HMG38","OPTRE_M247","OPTRE_M247H_Etilka","UGL_FlareGreen_F","UGL_FlareYellow_F","1Rnd_SmokeBlue_Grenade_shell","OPTRE_1Rnd_MasterKey_Pellets","ACE_40mm_Flare_ir","OPTRE_3Rnd_SmokeYellow_Grenade_shell","OPTRE_40Rnd_30x06_Mag_Tracer","OPTRE_100Rnd_30x06_Mag","OPTRE_100Rnd_30x06_Mag_Tracer","UGL_FlareWhite_F","UGL_FlareCIR_F","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell","OPTRE_1Rnd_SmokeYellow_Grenade_shell","OPTRE_400Rnd_762x51_Box_Tracer","OPTRE_40Rnd_30x06_Mag","OPTRE_1Rnd_Smoke_Grenade_shell","OPTRE_1Rnd_SmokePurple_Grenade_shell","OPTRE_signalSmokeY","OPTRE_3Rnd_SmokeRed_Grenade_shell","OPTRE_3Rnd_SmokePurple_Grenade_shell","OPTRE_200Rnd_127x99_M247H_Etilka","3Rnd_SmokeRed_Grenade_shell","ACE_40mm_Flare_red","OPTRE_3Rnd_SmokeGreen_Grenade_shell","OPTRE_signalSmokeG","ACE_40mm_Flare_white","OPTRE_3Rnd_SmokeBlue_Grenade_shell","OPTRE_100Rnd_762x51_Box","3Rnd_HE_Grenade_shell","OPTRE_3Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","OPTRE_signalSmokeR","OPTRE_100Rnd_762x51_Box_Tracer","OPTRE_200Rnd_127x99_M247H_Etilka_Ball","1Rnd_Smoke_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","3Rnd_UGL_FlareGreen_F","OPTRE_1Rnd_SmokeOrange_Grenade_shell","OPTRE_signalSmokeB","3Rnd_UGL_FlareWhite_F","3Rnd_SmokeYellow_Grenade_shell","OPTRE_1Rnd_SmokeBlue_Grenade_shell","OPTRE_signalSmokeP","OPTRE_3Rnd_Smoke_Grenade_shell","OPTRE_100Rnd_762x51_Box_Tracer_Yellow","OPTRE_1Rnd_SmokeRed_Grenade_shell","1Rnd_HE_Grenade_shell","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareYellow_F","OPTRE_1Rnd_MasterKey_Slugs","ACE_40mm_Flare_green","OPTRE_1Rnd_SmokeGreen_Grenade_shell","OPTRE_signalSmokeO","3Rnd_Smoke_Grenade_shell","ACE_HuntIR_M203","UGL_FlareRed_F","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","3Rnd_UGL_FlareCIR_F","3Rnd_SmokeOrange_Grenade_shell","OPTRE_CSW_M247H_Carry_Tripod","OPTRE_CSW_M247T_Carry_Tripod","OPTRE_CSW_M247H_Weapon","OPTRE_CSW_M247H_Shield_Weapon","OPTRE_CSW_M247T_Weapon","ACE_Tripod","173_Mar_gry_Rucksack_hev","173_Mar_urb_Rucksack_hev","173_Mar_wdl_Rucksack_hev","OPTRE_M247H_Weapon_bag","OPTRE_M247T_Weapon_bag","OPTRE_AU_44_Mortar_Bag_Weapon","173_M52D_Autorifleman"

];

	Private _AT = 
[
	"OPTRE_M41_SSR","OPTRE_M41_Twin_Smoke_O","OPTRE_M41_Twin_HEAP","OPTRE_M41_Twin_Smoke_P","OPTRE_M41_Twin_Smoke_R","OPTRE_M41_Twin_HE","OPTRE_M41_Twin_Smoke_B","OPTRE_M41_Twin_Smoke_W","OPTRE_M41_Twin_HE_SACLOS_ProximityFuse","OPTRE_M41_Twin_Smoke_G","OPTRE_M41_Twin_Smoke_Y","OPTRE_M41_Twin_HEAT_Thermal","OPTRE_M41_Twin_HE_Thermal_ProximityFuse","OPTRE_M41_Twin_HEAT","OPTRE_M41_Twin_HEAT_SALH","OPTRE_M41_Twin_HE_SALH_ProximityFuse","OPTRE_M41_Twin_HEAT_SACLOS","OPTRE_M41_Twin_HEAT_G","173_Mar_gry_Rucksack_hev","173_Mar_urb_Rucksack_hev","173_Mar_wdl_Rucksack_hev"

];

	Private _RIFLEMAN = 
[
"OPTRE_M41_SSR","OPTRE_M41_Twin_Smoke_O"
];


	Private _KEYSTONE = 
[

"173_M52D_Demo","173_Mar_gry_Rucksack_hev","173_Mar_urb_Rucksack_hev","173_Mar_wdl_Rucksack_hev","C7_Remote_Mag","C12_Remote_Mag","OPTRE_FC_BubbleShield","APERSMineDispenser_Mag","UNSCMine_Range_Mag","M168_Remote_Mag","M41_IED_C_Remote_Mag","M41_IED_Remote_Mag","M41_IED_B_Remote_Mag","ToolKit","ACE_DefusalKit","ACE_DeadManSwitch","ACE_Clacker","ACE_M26_Clacker","MineDetector","ACE_SpraypaintRed","ACE_SpraypaintBlue","ACE_wirecutter","B_UavTerminal"

];

	Private _Epsilon = 
[
"NSM_neutral_XD_1_backpack","NSM_neutral_XD_1_black_backpack","NSM_neutral_XD_1_LTU_backpack","NSM_neutral_XD_1_LTU_black_backpack","173_Air_Helmet_Prophet","173_Air_Helmet_Standard"
];

	switch (_Role) do {
	  case "ADMIN": {
	    _GearToAdd = _DefaultGear + _ADMIN;
	  };
	  case "CO": {
	    _GearToAdd = _DefaultGear + _CO;
	  };
	  case "SL": {
	    _GearToAdd = _DefaultGear + _SL;
	  };
	  case "MEDIC": {	
	    _GearToAdd = _DefaultGear + _MEDIC;
	  };
	  case "MARKSMAN": {
	    _GearToAdd = _DefaultGear + _MARKSMAN;
	  };
	  case "ENGINEER": {
	    _GearToAdd = _DefaultGear + _ENGINEER;
	  };
	  case "AUTORIFLEMAN": {
	    _GearToAdd = _DefaultGear + _AUTORIFLEMAN;
	  };
	  case "AT": {
	    _GearToAdd = _DefaultGear + _AT;
	  };
	  case "RIFLEMAN": {
	    _GearToAdd = _DefaultGear + _RIFLEMAN;
	  };
	  case "KEYSTONE": {
	    _GearToAdd = _DefaultGear + _KEYSTONE;
	  };
	  case "JACKAL": {
	    _GearToAdd = _DefaultGear + _JACKAL;
	  };
		  case "JFO": {
	    _GearToAdd = _DefaultGear + _JFO;
	  };
	  default {
	    _GearToAdd = _DefaultGear + ["ACE_Banana"];
	  };
	};

	[_box, false] call ace_arsenal_fnc_removeBox;
	[_box, _GearToAdd, false] call ace_arsenal_fnc_initBox;
}
