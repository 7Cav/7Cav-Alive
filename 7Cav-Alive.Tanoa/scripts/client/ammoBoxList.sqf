CLIENT_SpawnBox = {
  params ["_position", "_class"];

  _crate = _class createVehicle _position;

  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;

  [[_crate]] call SERVER_CurateEditableObjects;
  _crate
};

CLIENT_spawn_small_box = {
  params ["_position"];

  _crate = [_position, "ACE_Box_Misc"] call CLIENT_SpawnBox;

  // Empty the crate
  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;
};

CLIENT_spawn_big_box = {
  params ["_position"];

  _crate = [_position, "Box_NATO_Uniforms_F"] call CLIENT_SpawnBox;

  // Empty the crate
  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;
};

CLIENT_spawn_airDrop_box = {
  params ["_position"];

  _crate = [_position, "C_IDAP_supplyCrate_F"] call CLIENT_SpawnBox;

  // Empty the crate
  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;
};

CLIENT_spawn_vehicleAmmo_box = {
  params ["_position"];

  _crate = [_position, "Box_NATO_AmmoVeh_F"] call CLIENT_SpawnBox;

  //add vehicle ammo
  _crate setVariable ["ace_rearm_isSupplyVehicle", true];
  [_crate, 1000] call ace_rearm_fnc_setSupplyCount;
};

CLIENT_spawn_fuel_box = {
  params ["_position"];

  _crate = [_position, "CargoNet_01_barrels_F"] call CLIENT_SpawnBox;

  //Add fuel
  [_crate, 600] call ace_refuel_fnc_makeSource
};

CLIENT_SpawnMedicalBox = {
  params ["_position"];

  _crate = [_position, "ACE_medicalSupplyCrate_advanced"] call CLIENT_SpawnBox;

  _crate addItemCargoGlobal ["ACE_quikclot", 100]; 
  _crate addItemCargoGlobal ["ACE_epinephrine", 20]; 
  _crate addItemCargoGlobal ["ACE_morphine", 20]; 
  _crate addItemCargoGlobal ["ACE_EarPlugs", 5]; 
  _crate addItemCargoGlobal ["ACE_surgicalKit", 2]; 
  _crate addItemCargoGlobal ["ACE_elasticBandage", 200]; 
  _crate addItemCargoGlobal ["ACE_personalAidKit", 8]; 
  _crate addItemCargoGlobal ["ACE_splint", 30]; 
  _crate addItemCargoGlobal ["ACE_salineIV", 20]; 

};

CLIENT_SpawnAtBox = {
  params ["_position"];

  _crate = [_position, "Box_NATO_WpsLaunch_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["rhs_weap_maaws", 2];  
  _crate addMagazineCargoGlobal ["rhs_mag_maaws_HEAT", 10];
  _crate addMagazineCargoGlobal ["rhs_mag_maaws_HEDP", 5];
  _crate addItemCargoGlobal ["rhs_optic_maaws", 2];
  _crate addWeaponCargoGlobal ["rhs_weap_m72a7", 4];
  _crate addWeaponCargoGlobal ["rhs_weap_M136_hedp", 2];
};

CLIENT_SpawnAmmoBox = {
  params ["_position"];

  _crate = [_position, "ACE_Box_Ammo"] call CLIENT_SpawnBox;
 
  _crate addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 24]; 
  _crate addMagazineCargoGlobal ["rhsusf_200rnd_556x45_mixed_soft_pouch_coyote", 10]; 
  _crate addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m62_tracer", 10]; 
  _crate addMagazineCargoGlobal ["rhs_mag_m67", 10]; 
  _crate addMagazineCargoGlobal ["SmokeShell", 10]; 
  _crate addMagazineCargoGlobal ["SmokeShellRed", 10]; 
  _crate addMagazineCargoGlobal ["SmokeShellBlue", 10];
  _crate addMagazineCargoGlobal ["rhs_mag_M441_HE", 20]; 
  _crate addMagazineCargoGlobal ["rhs_mag_m714_White", 10];
  _crate addMagazineCargoGlobal ["rhs_mag_m713_Red", 10];
  };

CLIENT_SpawnNightBox = {
  params ["_position"];

  _crate = [_position, "Box_NATO_Support_F"] call CLIENT_SpawnBox;

  _crate addItemCargoGlobal ["ACE_NVG_Wide", 12]; 

  _crate addMagazineCargoGlobal ["ACE_Chemlight_UltraHiOrange", 20]; 
  _crate addMagazineCargoGlobal ["ACE_Chemlight_HiYellow", 20]; 
  _crate addMagazineCargoGlobal ["ACE_Chemlight_HiWhite", 20]; 
  _crate addMagazineCargoGlobal ["ACE_Chemlight_HiRed", 20]; 
  _crate addMagazineCargoGlobal ["ACE_Chemlight_HiGreen", 20]; 
  _crate addMagazineCargoGlobal ["ACE_Chemlight_HiBlue", 20]; 
  _crate addMagazineCargoGlobal ["ACE_Chemlight_IR", 30]; 
  _crate addMagazineCargoGlobal ["B_IR_Grenade", 30]; 
  _crate addMagazineCargoGlobal ["ACE_HandFlare_Green", 10]; 
  _crate addMagazineCargoGlobal ["ACE_HandFlare_Red", 10]; 
  _crate addMagazineCargoGlobal ["ACE_HandFlare_White", 10]; 
  _crate addMagazineCargoGlobal ["ACE_HandFlare_Yellow", 10]; 
};

CLIENT_SpawnJavelinBox = {
  params ["_position"];

  _crate = [_position, "Box_NATO_WpsSpecial_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["rhs_weap_fgm148", 1]; 
  _crate addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 5]; 
};

CLIENT_SpawnHMGBox = {
  params ["_position"];

  _crate = [_position, "Box_NATO_Equip_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["ace_csw_m3CarryTripodLow", 2]; 
  _crate addWeaponCargoGlobal ["ace_csw_m3CarryTripod", 2];
  _crate addWeaponCargoGlobal ["ace_compat_rhs_usf3_m2_carry", 2];
  _crate addMagazineCargoGlobal ["ace_csw_100Rnd_127x99_mag_red", 20];
};

CLIENT_SpawnGMGBox = {
  params ["_position"];

  _crate = [_position, "Box_NATO_Equip_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["ace_csw_m3CarryTripodLow", 2]; 
  _crate addWeaponCargoGlobal ["ace_compat_rhs_usf3_mk19_carry", 2];
  _crate addMagazineCargoGlobal ["ace_compat_rhs_usf3_48Rnd_40mm_MK19_M430A1", 20];
};

CLIENT_SpawnTOWBox = {
  params ["_position"];

  _crate = [_position, "B_supplyCrate_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["ace_csw_m220CarryTripod", 1]; 
  _crate addWeaponCargoGlobal ["ace_compat_rhs_usf3_tow_carry", 1];
  _crate addMagazineCargoGlobal ["ace_compat_rhs_usf3_mag_TOW2b", 6];
  _crate addMagazineCargoGlobal ["ace_compat_rhs_usf3_mag_TOW2bb", 2];
};

CLIENT_SpawnAABox = {
  params ["_position"];

  _crate = [_position, "Box_EAF_WpsLaunch_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["rhs_weap_fim92", 1]; 
  _crate addMagazineCargoGlobal ["rhs_fim92_mag", 6];
};

CLIENT_SpawnAMBox = {
  params ["_position"];

  _crate = [_position, "Box_T_NATO_WpsSpecial_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["rhs_weap_M107", 1]; 
  _crate addMagazineCargoGlobal ["rhsusf_mag_10Rnd_STD_50BMG_mk211", 5];
  _crate addMagazineCargoGlobal ["rhsusf_mag_10Rnd_STD_50BMG_M33", 15];
};

CLIENT_SpawnGPMGBox = {
  params ["_position"];

  _crate = [_position, "Box_NATO_Wps_F"] call CLIENT_SpawnBox;

  _crate addWeaponCargoGlobal ["rhs_weap_m240G", 2]; 
  _crate addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m80a1epr", 15];
  _crate addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m61_ap", 5];
};