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
	if ((_UnitRole == "Admin @ Icarus 1")
	or (_UnitRole == "Admin @ Icarus 2")) then
	{_Role = "ADMIN"};

	// Command
	if (_UnitRole == "Officer @ Privateer") then
	{_Role = "CO"};

    // GROUND
		//SL
			if ((_UnitRole == "Squad leader"))
			 then
			{_Role = "SL"};
		//MEDIC
			if ((_UnitRole == "Medic")) then
			{_Role = "MEDIC"};
		//MARKSMAN
			if ((_UnitRole == "Marksman")) then
			{_Role = "MARKSMAN"};
		//ENGINEER
			if  ((_UnitRole == "Engineer")) then
			{_Role = "ENGINEER"};
		//AUTORIFLEMAN
			if ((_UnitRole == "AutoRifleman"))then
			{_Role = "AUTORIFLEMAN"};
		//AT
			if ((_UnitRole == "AT")) then
			{_Role = "AT"};
		//RIFLEMAN
			if ((_UnitRole == "Rifleman"))then
			{_Role = "RIFLEMAN"};

	// ARMOUR
	if ((_UnitRole == "Commander")
	or (_UnitRole == "Driver")
	or (_UnitRole == "Gunner")) then
	{_Role = "Keystone"};

	// JACKAL
	if ((_UnitRole == "Pilot"))then
	{_Role = "Jackal"};

	//CLAPTRAP
	if ((_UnitRole == "JFO"))then
	{_Role = "JFO"};



	//Empty array of gear to add to the arsenal per player.
	Private _GearToAdd = [];

	//Define the gear for each Role
	Private _DefaultGear = [
	//Uniform


	//weapons

	//secondary

"Tier1_P320",
"rhs_weap_M320",

	//launchers
	"rhs_weap_M136",
	"rhs_weap_M136_hedp",
	"rhs_weap_M136_hp",
	"launch_NLAW_F",
	//ammo

	// attachments



	"ACE_Fortify",
	//Grenades
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"HandGrenade",
	"B_IR_Grenade",
	"ACE_HandFlare_Green",
	"ACE_HandFlare_Red",
	"ACE_HandFlare_White",
	"ACE_HandFlare_Yellow",
	"rhs_mag_an_m14_th3",
	"rhs_mag_mk84",
	"ACE_Chemlight_HiBlue",
	"ACE_Chemlight_HiGreen",
	"ACE_Chemlight_HiRed",
	"ACE_Chemlight_HiWhite",
	"ACE_Chemlight_HiYellow",
	"ACE_Chemlight_IR",
	"ACE_Chemlight_UltraHiOrange",
	//facewear
	
	//items
	"Attachable_Helistretcher",
  "ACE_rope36",
  "ACE_rope27",
  "ACE_rope18",
	"ACE_Banana",
	"ACE_fieldDressing",
	"ACE_elasticBandage",
	"ACE_packingBandage",
	"ACE_quikclot",
	"ACE_salineIV",
	"ACE_salineIV_250",
	"ACE_salineIV_500",
	"ACE_bodyBag",
	"ACE_CableTie",
	"ACE_EarPlugs",
	"ACE_EntrenchingTool",
	"ACE_epinephrine",
	"ItemcTabHCam",
	"ACE_IR_Strobe_Item",
	"ACE_Flashlight_XL50",
	"ACE_MapTools",
	"ACE_microDAGR",
	"ACE_morphine",
	"ACE_personalAidKit",
	"ACE_splint",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_tourniquet",
	"ACE_wirecutter",
	"ACE_NVG_Wide_Black",
	"ACE_NVG_Wide",
	"Laserdesignator",
	"ACE_Vector",
	"ItemMap",
	"ItemGPS",
	"ItemAndroid",
	"ItemcTab",
	"ItemWatch",
	"TFAR_anprc152",
	"ACE_VMH3",
	"ACE_WaterBottle",
	"tfw_rf3080Item",
	"ACE_RangeTable_82mm",
	"ACE_artilleryTable",
	"ACE_DefusalKit"
	];

	Private _ADMIN = [
	//secondary
	"rhs_weap_M320",
	//uniform
	"U_I_C_Soldier_Bandit_4_F",
	//vests
	//backpacks
	"B_rhsusf_B_BACKPACK",
	//items
	"ToolKit",
	"ACE_wirecutter",
	"ACE_surgicalKit",
	"ACE_SpareBarrel_Item",
	"ACE_RangeCard",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ACE_DefusalKit",
	"adv_aceCPR_AED",
	"ACE_adenosine",
	"ACE_HuntIR_monitor",
	"B_UavTerminal",
	"kat_aatKit",
    "kat_accuvac",
    "kat_X_AED",
    "kat_AED",
    "kat_crossPanel",
    "kat_chestSeal",
    "KAT_Empty_bloodIV_250",
    "KAT_Empty_bloodIV_500",
    "kat_larynx",
    "kat_stethoscope",
    "kat_guedel",
    "kat_Pulseoximeter",
	"kat_bloodIV_O",
	"kat_bloodIV_O_250",
	"kat_bloodIV_O_500"
	];

	Private _CO = [
	//secondary
	"rhs_weap_M320",
	//backpacks
	"B_rhsusf_B_BACKPACK",
	"B_UAV_01_backpack_F",
	//vests
	"rhsusf_spc_patchless",
	"rhsusf_spc_patchless_radio",
    //items
	"ACE_HuntIR_monitor",
	"B_UavTerminal"
    ];

	Private _SL = [
	//secondary
	"rhs_weap_M320",
	//backpacks
	"B_UAV_01_backpack_F",
	//vests
	"rhsusf_spc_patchless",
	"rhsusf_spc_patchless_radio",
	//items
	"ACE_HuntIR_monitor",
	"B_UavTerminal"
	];

	Private _MEDIC = [
	//uniforms
	"U_Marshal",
	"U_C_Scientist",
	//vests
	//items
	"ACE_adenosine",
	"ACE_surgicalKit",
	"kat_aatKit",
    "kat_accuvac",
    "kat_X_AED",
    "kat_Painkiller",
    "kat_AED",
    "kat_crossPanel",
    "kat_chestSeal",
    "kat_larynx",
    "kat_stethoscope",
    "kat_guedel",
    "kat_Pulseoximeter",
	"KAT_Empty_bloodIV_250",
	"KAT_Empty_bloodIV_500",
	"kat_bloodIV_O",
	"kat_bloodIV_O_250",
	"kat_bloodIV_O_500"
	];

	Private _MARKSMAN = [
	//vests
	//weapons
	//Items
	"ACE_ATragMX",
	"ACE_Kestrel4500",
	"ACE_Flashlight_KSF1",
	"ACE_RangeCard",
	"ACE_SpottingScope"
	];

	Private _ENGINEER = [
	//vests

	//Explosives
	"SatchelCharge_Remote_Mag",
	"rhsusf_m112_mag",
	"rhsusf_m112x4_mag",
	"B_UGV_02_Demining_backpack_F",
	"DemoCharge_Remote_Mag",
	//Items
	"ToolKit",
	"ACE_DefusalKit",
	"ACE_M26_Clacker",
	"ACE_Clacker",
	"B_UavTerminal"
	];

	Private _AUTORIFLEMAN = [
	//weapons


	//attachments
	//vests
	//Items
	"ACE_WaterBottle"
	];

	Private _AT = [
	//launchers
	"CTRG_Retexture_MAAWS_tropic",
	"launch_MRAWS_olive_F",
	"launch_NLAW_F",
	"launch_B_Titan_short_tna_F",
	"launch_B_Titan_tna_F"
	];

	Private _RIFLEMAN = [
	//weapons
	
	//secondary
	"rhs_weap_M320",
	//items
	"ACE_Banana",
	"ACE_WaterBottle"
	];

	Private _ARMOR = [
	//uniforms
	"U_C_WorkerCoveralls",
	//helm
	"rhs_tsh4",
	"rhs_tsh4_bala",
	"rhs_tsh4_ess",
	"rhs_tsh4_ess_bala",
	"rhsusf_cvc_green_alt_helmet",
	"rhsusf_cvc_green_ess",
	"rhsusf_cvc_helmet",
	"rhsusf_cvc_alt_helmet",
	"rhsusf_cvc_ess",

	//Items
	"ToolKit",
	"B_UavTerminal",
	"kat_guedel",
    "kat_Pulseoximeter"
	];

	Private _JACKAL = [
	//uniforms
	"U_B_HeliPilotCoveralls",
	"U_B_PilotCoveralls",
	//vests
	"rhsusf_spc_crewman",
	"V_Chestrig_rgr",
	"V_Chestrig_khk",
	"V_Chestrig_oli",
	//helm
	"RHS_jetpilot_usaf",
	"rhsusf_hgu56p_black",
	"rhsusf_hgu56p_mask_black",
	"rhsusf_hgu56p_visor_black",
	"rhsusf_hgu56p_visor_mask_black",
	"rhsusf_hgu56p_green",
	"rhsusf_hgu56p_mask_green",
	"rhsusf_hgu56p_visor_green",
	"rhsusf_hgu56p_visor_mask_green",
	"rhsusf_hgu56p_olive",
	"rhsusf_hgu56p_mask_olive",
	"rhsusf_hgu56p_visor_olive",
	"rhsusf_hgu56p_visor_mask_olive",
	"rhsusf_hgu56p_pink",
	"rhsusf_hgu56p_visor_pink",
	"rhsusf_hgu56p_tan",
	"rhsusf_hgu56p_visor_tan",
	"rhsusf_hgu56p_tan",
    "rhsusf_hgu56p_mask_tan",
    "rhsusf_hgu56p_visor_tan",
    "rhsusf_hgu56p_visor_mask_tan",
	//Items
	"ToolKit",
	"B_UavTerminal",
	"kat_guedel",
    "kat_Pulseoximeter"
	];

	Private _JFO = [];

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
	  case "Keystone": {
	    _GearToAdd = _DefaultGear + _ARMOR;
	  };
	  case "Jackal": {
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
