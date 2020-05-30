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

  _crate addWeaponCargoGlobal ["launch_MRAWS_green_F", 3];  
  _crate addMagazineCargoGlobal ["MRAWS_HEAT_F", 17];
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