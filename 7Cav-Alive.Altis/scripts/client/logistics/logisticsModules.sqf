CLIENT_PlayerCanUse = 
{
	player getVariable ["TAC2_canFortify", false]
};

CLIENT_FobHasEnoughSupply = 
{
	params ["_amount"];
	([west] call acex_fortify_fnc_getBudget) >= _amount
};

BOTH_ActivateModule = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_caller", "_actionId", "_arguments"];
	_arguments params ["_type"];

	private _nearFOB = acex_fortify_locations isEqualTo [];
	{
		if (_crate inArea _x) exitWith {_nearFOB = true};
	} forEach acex_fortify_locations;
	if (!_nearFob) exitWith { hint 'Modules can only be activated near a FOB.' };

	if (_type == "vehicle") then { _crate setVariable ['LOGI_isModuleActivated', true, true] };
	if (_type == "ammo") then { 
		_crate setVariable ['LOGI_isModuleActivated', true, true]; 
		[_crate, true] call ace_arsenal_fnc_initBox;
		[_crate, [
			"launch_I_Titan_F",
			"launch_O_Titan_ghex_F",
			"launch_O_Titan_F",
			"launch_B_Titan_tna_F",
			"launch_B_Titan_F",
			"launch_O_Titan_short_F",
			"launch_O_Titan_short_ghex_F",
			"launch_I_Titan_short_F",
			"launch_B_Titan_short_F",
			"launch_B_Titan_short_tna_F",
			"rhsusf_5Rnd_HE",
			"rhsusf_5Rnd_FRAG",
			"rhsusf_8Rnd_HE",
			"rhsusf_8Rnd_FRAG",
			"H_HelmetO_ViperSP_ghex_F",
			"H_HelmetO_ViperSP_hex_F",
			"arifle_ARX_hex_F",
			"arifle_ARX_ghex_F",
			"arifle_ARX_blk_F",
			"U_O_V_Soldier_Viper_hex_F",
			"U_O_V_Soldier_Viper_F",
			"U_B_Protagonist_VR",
			"U_O_Protagonist_VR",
			"U_C_Protagonist_VR",
			"U_I_Protagonist_VR",
			"O_NVGoggles_urb_F",
			"O_NVGoggles_hex_F",
			"O_NVGoggles_ghex_F",
			"rhsusf_m112x4_mag",
			"rhsusf_m112_mag",
			"kka3_ace_extension_Campfire_burning_F",
			"ACRE_PRC148",
			"ACRE_PRC77",
			"ACRE_SEM52SL",
			"ACRE_SEM70",
			"B_Respawn_Sleeping_bag_blue_F",
			"B_Respawn_Sleeping_bag_brown_F",
			"B_Respawn_TentDome_F",
			"B_Patrol_Respawn_bag_F",
			"B_Respawn_Sleeping_bag_F",
			"B_Respawn_TentA_F",
			"I_GMG_01_A_weapon_F",
			"O_GMG_01_A_weapon_F",
			"B_GMG_01_A_weapon_F",
			"I_HMG_01_A_weapon_F",
			"B_HMG_01_A_weapon_F",
			"O_HMG_01_A_weapon_F",
			"I_HMG_01_weapon_F",
			"O_HMG_01_weapon_F",
			"O_GMG_01_high_weapon_F",
			"I_GMG_01_high_weapon_F",
			"O_HMG_01_high_weapon_F",
			"I_HMG_01_high_weapon_F",
			"I_GMG_01_weapon_F",
			"O_GMG_01_weapon_F",
			"RHS_DShkM_Gun_Bag",
			"RHS_DShkM_TripodHigh_Bag",
			"RHS_DShkM_TripodLow_Bag",
			"RHS_Kord_Tripod_Bag",
			"RHS_Kord_Gun_Bag",
			"rhs_M252_Bipod_Bag",
			"rhs_M252_Gun_Bag",
			"RHS_NSV_Gun_Bag",
			"RHS_NSV_Tripod_Bag",
			"O_Static_Designator_02_weapon_F",
			"I_AA_01_weapon_F",
			"O_AA_01_weapon_F",
			"O_AT_01_weapon_F",
			"I_AT_01_weapon_F",
			"I_UAV_06_backpack_F",
			"O_UAV_06_backpack_F",
			"I_UAV_06_medical_backpack_F",
			"O_UAV_06_medical_backpack_F",
			"C_IDAP_UAV_06_medical_backpack_F",
			"launch_B_Titan_olive_F",
			"launch_I_Titan_eaf_F",
			"ACE_Can_Franta",
			"ACE_Can_RedGull",
			"ACE_Can_Spirit",
			"ACE_Canteen",
			"ACE_Canteen_Empty",
			"ACE_Canteen_Half",
			"ACE_Cellphone",
			"ACE_DeadManSwitch",
			"ACE_MRE_BeefStew",
			"ACE_MRE_ChickenTikkaMasala",
			"ACE_MRE_ChickenHerbDumplings",
			"ACE_MRE_CreamChickenSoup",
			"ACE_MRE_CreamTomatoSoup",
			"ACE_MRE_LambCurry",
			"ACE_MRE_MeatballsPasta",
			"ACE_MRE_SteakVegetables",
			"ACE_WaterBottle",
			"ACE_WaterBottle_Empty",
			"ACE_WaterBottle_Half",
			"I_E_UavTerminal",
			"O_UavTerminal",
			"C_UavTerminal",
			"I_UavTerminal",
			"I_E_GMG_01_A_Weapon_F",
			"I_E_HMG_01_A_Weapon_F",
			"I_E_HMG_01_high_Weapon_F",
			"I_E_HMG_01_Weapon_F",
			"I_E_GMG_01_high_Weapon_F",
			"I_E_GMG_01_Weapon_F",
			"I_E_UAV_06_medical_backpack_F",
			"I_E_UAV_06_backpack_F",
			"I_E_AT_01_weapon_F",
			"I_E_AA_01_weapon_F",
			"RHS_SPG9_Tripod_Bag",
			"RHS_SPG9_Gun_Bag",
			"ALIVE_Terminal",
			"ALiVE_Handgrenade_stone",
			"ALiVE_Handgrenade_can",
			"ALiVE_Handgrenade_bottle",
			"ACE_CTS9",
			"launch_MRAWS_sand_F",
			"launch_MRAWS_olive_F",
			"launch_MRAWS_green_F",
			"launch_MRAWS_green_rail_F",
			"launch_MRAWS_sand_rail_F",
			"launch_MRAWS_olve_rail_F",
			"launch_O_Vorona_brown_F",
			"launch_O_Vorona_green_F",
			"rhs_weap_panzerfaust60",
			"launch_NLAW_F",
			"launch_RPG32_F",
			"launch_RPG32_green_F",
			"launch_RPG32_ghex_F",
			"ALIVE_Tablet"
		]] call ace_arsenal_fnc_removeVirtualItems;
		};
	if (_type == "personnel") then { _crate setVariable ['LOGI_isModuleActivated', true, true]; [_crate] call CLIENT_EnableMobileSpawn };


	[_crate, false] remoteExec ["enableSimulationGlobal", 2];
};

BOTH_DeactivateModule = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_caller", "_actionId", "_arguments"];
	_arguments params ["_type"];

	_crate setVariable ['LOGI_isModuleActivated', false, true];
	[_crate, true] remoteExec ["enableSimulationGlobal", 2];

	if (_type == "personnel") then { [] call CLIENT_DisableMobileSpawn };
	if (_type == "ammo") then { [_crate, true] call ace_arsenal_fnc_removeBox};
};

CLIENT_CanActivateResource = 
{
	params ['_crate', '_type'];
	private _canActivate = true;
	_canActivate = _canActivate && call CLIENT_PlayerCanUse;
	_canActivate = _canActivate && alive _crate;
	_canActivate = _canActivate && player == vehicle player;
	_canActivate = _canActivate && !(_crate getVariable ['LOGI_isModuleActivated', false]);
	_canActivate = _canActivate && !(_crate getVariable ['LOGI_isLoaded', false]);
	_canActivate	 
};

CLIENT_CanDeactivateResource = 
{
	params ['_crate', '_type'];
	private _canDeactivate = true;
	_canDeactivate = _canDeactivate && call CLIENT_PlayerCanUse;
	_canDeactivate = _canDeactivate && player == vehicle player;
	_canDeactivate = _canDeactivate && (_crate getVariable ['LOGI_isModuleActivated', false]);
	_canDeactivate = _canDeactivate && !(_crate getVariable ['LOGI_isLoaded', false]);
	_canDeactivate
};

CLIENT_AddModuleTitleAction =
{
	params ["_crate", "_title"];
	_crate addAction [
		"<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa'/><t font='PuristaBold'>" + _title + "</t>",
		{},
		[],
		20
	];
};

CLIENT_AddActivateModuleAction =  
{ 
	params ["_crate", "_type"]; 

	_crate addAction [ 
		'    > Unpack Resource', 
		{[5, _this, BOTH_ActivateModule, {}, "Unpacking crate"] call ace_common_fnc_progressBar}, 
		[_type], 
		19 , 
		true, 
		true, 
		'', 
		"[_target, '" + _type + "'] call CLIENT_CanActivateResource" 
	] 
};

CLIENT_AddDeactivateModuleAction =  
{ 
	params ["_crate", "_type"]; 

	_crate addAction [ 
		'    > Pack Up Resource',
		{[5, _this, BOTH_DeactivateModule, {}, "Packing up crate"] call ace_common_fnc_progressBar},  
		[_type], 
		18 , 
		true, 
		true, 
		'', 
		"[_target, '" + _type + "'] call CLIENT_CanDeactivateResource" 
	] 
};