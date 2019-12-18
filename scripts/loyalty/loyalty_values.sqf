// points = 50(level)^1.9 + 120
LoyaltyLevels = [
	[0,0],
	[1,170],
	[2,290],
	[3,480],
	[4,720],
	[5,1020],
	[6,1370],
	[7,1780],
	[8,2230],
	[9,2730],
	[10,3270],
	[11,3860],
	[12,4500],
	[13,5170],
	[14,5900],
	[15,6660],
	[16,7470],
	[17,8310],
	[18,9200],
	[19,10130],
	[20,11100],
	[21,12110],
	[22,13160],
	[23,14240],
	[24,15370],
	[25,16530],
	[26,17730],
	[27,18970],
	[28,20250],
	[29,21560],
	[30,22910]
];


// vehicle is defined by
// [classname, level, CavBuck Cost, cooldown (minutes), max # available at once, "message", "default spawn location (land/air)", {conditions}, {after create callback}]
LoyaltyVehicles = [
	// 1 - MRZR
	["rhsusf_mrzr4_d", 1, 10, 10, -1, "", "land", {}, {}],

	// 2 - Another MRAP
	["rhsusf_M1232_M2_usarmy_d", 2, 10, 10, -1, "", "land", {}, {}], 

	// 3 - Unarmed Quilin
	["B_LSV_01_unarmed_F", 3, 10, 10, -1, "", "land", {}, {}], 

	// 4 - M2 M113
	["rhsusf_m113d_usarmy", 4, 10, 20, -1, "", "land", {}, {}],

	// 5 - Leopard 2
	["I_MBT_03_cannon_F", 5, 10, 20, 2, "You must be in a Saber slot to drive/gun/command. Camo selection doesn't work", "land", {}, {	
		if (worldName in ["Altis", "Takistan", "tem_anizay"]) then {
			(_this select 0) setObjectTextureGlobal [0, "Data\TankBodyTexture.paa"];
			(_this select 0) setObjectTextureGlobal [1, "Data\TankTurretTexture.paa"];
			(_this select 0) setObjectTextureGlobal [2, "Data\TankTurretMGTexture.paa"];
		} else {
			(_this select 0) setObjectTextureGlobal [0, "Data\LEO1FRNT.jpg"];
			(_this select 0) setObjectTextureGlobal [1, "Data\LEO2TURRET.jpg"];
			(_this select 0) setObjectTextureGlobal [2, "Data\LEO3RCWS.jpg"];
		}
	}],

	// 6 - Inf. Blackfish
	["B_T_VTOL_01_infantry_F", 6, 10, 30, 2, "Must be in Buffalo/Titan slot to fly", "air", {}, {}],

	// 7 - Armed bobcat
	["B_APC_Tracked_01_CRV_F", 7, 10, 60, 2, "Must be in Apollo slot to drive", "land", {}, {
		[_this select 0, 16] call ace_cargo_fnc_setSpace;
		[_this select 0, -1] call ace_cargo_fnc_setSize;
		[_this select 0, 6000] call ace_refuel_fnc_setFuel;
		[_this select 0, 1200] call ace_rearm_fnc_setSupplyCount;
		(_this select 0) setVariable ["ACE_isRepairVehicle", true, true];
	}], 

	// 8 - Medical M113
	["rhsusf_m113d_usarmy_medical", 8, 10, 40, -1, "Must be in Mustang slot to drive", "land", {}, {(_this select 0) setvariable ["ace_medical_isMedicalFacility", true, true];}],

	// 9 - Merkava
	["B_MBT_01_cannon_F", 9, 10, 20, 2, "You must be in a Saber slot to drive/gun/command", "land", {}, {}],

	// 10 - UGV
	["B_UGV_01_F", 10, 10, 20, 1, "", "land", {}, {createVehicleCrew (_this select 0);}],

	// 11 - Medivac Buffalo
	["RHS_UH60M_MEV", 11, 10, 20, -1, "Must be in Buffalo slot to drive", "air", {}, {(_this select 0) setvariable ["ace_medical_isMedicalFacility", true, true];}],

	// 12 - Weisel
	["I_LT_01_cannon_F", 12, 10, 40, 2, "", "land", {}, {}],

	// 13 - Predator Drone
	["B_UAV_02_F", 13, 10, 40, 1, "", "air", {}, {createVehicleCrew (_this select 0);}],

	// 14  - Unarmed Huey & Warrior
	["rhs_uh1h_hidf", 14, 10, 40, -1, "Must be in Buffalo slot to fly", "air", {}, {}],
	["I_APC_tracked_03_cannon_F", 14, 10, 60, 2, "", "land", {}, {}],

	// 15 - MK19 HWWMV
	["rhsusf_m1025_w_mk19", 15, 10, 60, 1, "", "land", {}, {}],

 	// 16 - F/A-181
	["B_Plane_Fighter_01_F", 16, 20, 120, 1, "Must be in Eagle to fly", "air", {}, {}],

	// 17 - Rooikat
	["B_AFV_Wheeled_01_cannon_F", 17, 10, 60, 2, "Must be in Saber slot to drive/gun/command", "land", {}, {}],

	// 18 - Vanilla NATO APC
	["B_APC_Wheeled_01_cannon_F", 18, 20, 60, -1, "", "land", {}, {}],

	// 19 - Armed Marine UH1Y
	["RHS_UH1Y", 19, 20, 90, 1, "Must be in Buffalo slot to fly", "air", {}, {}],

	// 20 - AH1Z Viper
	["RHS_AH1Z", 20, 20, 90, 1, "Must be in Raider/Sparrow slot to fly/gun", "air", {}, {}],

	// 21 - Commanche
	["B_Heli_Attack_01_dynamicLoadout_F", 21, 20, 90, 1, "Must be in Raider/Sparrow slot to fly/gun", "air", {}, {}],

	// 22 - Armed Blackfish
	["B_T_VTOL_01_armed_F", 22, 20, 120, 1, "Must be in Buffalo to fly, all can gun", "air", {}, {}],

	// 23 - Stealth UAV
	["B_UAV_05_F", 23, 10, 60, 1, "", "air", {}, {createVehicleCrew (_this select 0);}], 

	// 24 - F22
	["rhsusf_f22", 24, 20, 120, 1, "Must be in Eagle to fly", "air", {}, {}]
];