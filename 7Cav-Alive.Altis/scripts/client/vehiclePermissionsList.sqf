/*
Authors: Originally JB, rewritten by Bojan 

Define sets of permissions here for each type of class.
Permission sets can be combined with other sets (ie Transport Rotory + airfield logi vehicles).

TypeFilters are interpreted in order from top to bottom, looking for the first classname match. 
If we do something like this:

[
	["rhsusf_m113_usarmy*", false],
	["rhsusf_m113_usarmy_M240", true],
]

then the player will not be able to enter any M113s.

To set inclusion criteria, set all your classes to true and specify ['All', false] at the end
to exclude all types except those you specified. To set exclusion critera, set all your target classes
to false, and specify ['All', true] to permit usage of any vehicle except those you specified.

All TypeFilters should end with ['All', false] or ['All', true] (usually false).
*/


TypeFilter_All =
[
	["All", true]
];

TypeFilter_TransportRotory =
[
	["ParachuteBase", false],
	["RHS_UH60M*", true],
	["B_Heli_Transport_01_F", true],
	["B_Heli_Transport_03_unarmed_F", true],
	["B_Heli_Transport_03_F", true],
	["rhsusf_CH53E_USMC*", true],
	["RHS_UH1*", true],
	["B_CTRG_Heli_Transport_01_sand_F", true],
	["B_CTRG_Heli_Transport_01_tropic_F", true],
	["rhs_uh1h_hidf_unarmed", true],
	["rhs_uh1h_hidf_gunship", true],
	["rhs_uh1h_hidf", true],
	["I_Heli_light_03_unarmed_F", true],
	["I_Heli_light_03_dynamicLoadout_F", true],
	["I_Heli_Transport_02_F", true],
	["I_Heli_light_03_dynamicLoadout_F", true],
	["LOP_IRAN_CH47F", true],
	["LOP_IRAN_UH1Y_UN", true],
	["LOP_IRAN_CH47F", true],
	["LOP_IRAN_CH47F", true],
	["RHS_MELB_MH6M", true],
	["B_Heli_Light_01_F", true],
	["rhs_uh1h_hidf", true],
	["RHS_MELB_H6M", true],
	["B_Heli_Light_01_F", true],
	["RHS_CH_47F*", true],

	// Allowing Buffalo crew to run the armed blackfish as an AC130
	["B_T_VTOL_01_armed_F", true],

	// Titan vehicles
	["RHS_C130J", true],
	["B_T_VTOL_01_vehicle_F", true],
	["B_Heli_Transport_03_unarmed_F", true],

	["All", false]
];

//Raider Only
TypeFilter_AttackRotory =
[
	["ParachuteBase", false],
	["RHS_AH64D", true],
	["B_Heli_Attack_01_dynamicLoadout_F", true],
	["RHS_AH1Z", true],
	["RHS_AH64D", true],
	["RHS_AH64D", true],
	["RHS_MELB_AH6M", true],
	["B_Heli_Light_01_dynamicLoadout_F", true],
	["RHS_UH1Y_FFAR_d", true],
	["rhs_uh1h_hidf_gunship", true],
	["All", false]
];

// Ground attack aircraft
TypeFilter_GroundAttackAircraft =
[
	["ParachuteBase", false],
	["B_Plane_*", true],
	["FIR_*", true],
	["rhsusf_f22*", true],
	["RHS_A10*", true],
	["B_T_VTOL_01_armed_F", true],
	["USAF*", true],
	["All", false]
];


// Armored vehicles
TypeFilter_ArmoredVehicles =
[
	["MBT_03_base_F", true], // Leopard 2
	["MBT_01_base_F", true], // Most other western tanks (Abrams, Merkava)
	["RHS_M2A3*", true], // Add Bradleys here too so Manual Drive works for all
	["RHS_M6*", true],
	["rhsusf_m113*", true],
	["B_AFV_Wheeled_01*", true], // Rookiat tank destoryer
	["B_APC_Wheeled_01*", true],
	["I_APC_tracked_03*", true],
	["I_LT_01*", true],
	["All", false]
];

// Base service vehicles
TypeFilter_BaseServiceVehicles =
[
	["rhsusf_M97*", true], // Big slow logi vics
	["All", false]
];

TypeFilter_LogisticsVehicles =
[
	["B_Truck_*", true],
	["C_IDAP_Van_02_medevac_F", true],
	["rhsusf_M108*", true], // CP SOV + more logi trucks
	["rhsusf_M107*", true], // Rearm SOV + more logi trucks
	["rhsusf_M1230A1*", true], // Medical MRAP
	["rhsusf_M109*", true], // SPG
	["rhsusf_M142*", true], // MLRS
	["rhsusf_m113_usarmy_medical", true], //Medical M113
	["B_APC_Tracked_01*", true], //Bobcat
	["RHS_CH_47F*", true],	//Chinook is a logistics helicopter
	["B_Heli_Transport_03_F", true], //ditto
	["B_T_VTOL_01_vehicle_F", true], //Specifically the vehicle transport blackfish
	["All", false]
];

TypeFilter_InfantryVehicles =
[
	// Disable logistics vics since we wildcard them below
	["rhsusf_M108*", false],
	["rhsusf_M107*", false],
	["rhsusf_M97*", false],
	["rhsusf_M1230A1*", false], // Medical MRAP
	["B_Truck_01_medical_F", false], // Medical HEMTTs
	["C_IDAP_Van_02_medevac_F", false], // Ambulance
	["rhsusf_m113_usarmy_medical", false], // Medical M113
	["B_APC_Tracked_01_CRV_F", false], // Bobcat
	
	//Static weapoons
	["StaticWeapon", true],

	//Available Ao vehicles
	["LOP_US_UAZ_DshKM",true],
	["LOP_US_Ural",true],
	["LOP_US_UAZ_AGS",true],
	["LOP_US_UAZ_SPG",true],
	
	// Enable all MRAPs except medical MRAP
	["rhsusf_M1220_*", true], // MRAPs
	["rhsusf_M1230_*", true], // MRAPs
	["rhsusf_M1232_*", true], // MRAPs

	//M113 varients (Not Medical)
	["rhsusf_m113_usarmy_unarmed", true],
	["rhsusf_m113_usarmy_MK19_90", true],
	["rhsusf_m113_usarmy_MK19", true],
	["rhsusf_m113_usarmy_M240", true],
	["rhsusf_m113_usarmy_M2_90", true],
	["rhsusf_m113_usarmy", true],
	["rhsusf_m113_usarmy_supply", true],

	["rhsusf_stryker*", true],

	["Car", true],
	["O_HMG_01_*", true],
	["I_HMG_01_*", true],
	["Ship", true],
	["B_MRAP_01_F", true], // MATV
	["rhsusf_m998*", true], // Soft top HMMWV
	["rhsusf_m102*", true], //HMMWV
	["rhsusf_m104*", true], //HMMWV
	["rhsusf_mrzr*", true], // MRZR
	["rhsusf_m1240*", true], // RHS MATV
	["All", false]
];