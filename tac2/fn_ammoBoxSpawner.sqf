/*
Description: Adds ACE interaction options to an object, allowing players to spawn empty ammo boxes on a given marker.
Usage: In editor, add the following to the object's init:

null = [this, "MARKER_NAME", [["Small box", "Box_NATO_Ammo_F"], ["Big box", "Box_NATO_Wps_F"]]] execVM "scripts\ammoBoxSpawner.sqf";

Replace MARKER_NAME with the name of a marker the boxes will spawn around. You can change the boxes available by editing
the array following the marker definition. The array has the structure of:

[["Display Name1", "Class Name1"], ["Display Name2", "Class Name2"], etc,etc,etc]
*/

// Get the object the spawn options will belong to
_this params ["_object", "_marker", "_items"];

_spawn_box = {
  params ["_target", "_player", "_id", "_params"];
  _params params ["_class", "_marker"];

  // Spawn a box on the marker
  _crate = _class createVehicle (getMarkerPos _marker);

  // Empty the crate
  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;

  [[_crate]] call SERVER_CurateEditableObjects;
};

_spawn_medical_box = {
   params ["_target", "_player", "_id", "_params"];
  _params params ["_class", "_marker"];

  // Spawn a box on the marker
  _crate = "ACE_medicalSupplyCrate_advanced" createVehicle (getMarkerPos _marker);

  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;

  _crate addItemCargoGlobal ["ACE_quikclot", 100]; 
  _crate addItemCargoGlobal ["ACE_epinephrine", 20]; 
  _crate addItemCargoGlobal ["ACE_morphine", 20]; 
  _crate addItemCargoGlobal ["ACE_EarPlugs", 5]; 
  _crate addItemCargoGlobal ["ACE_surgicalKit", 4]; 
  _crate addItemCargoGlobal ["ACE_elasticBandage", 100]; 
  _crate addItemCargoGlobal ["ACE_personalAidKit", 20]; 
  _crate addItemCargoGlobal ["ACE_salineIV", 30]; 
  _crate addItemCargoGlobal ["ACE_tourniquet", 30]; 
  _crate addItemCargoGlobal ["ACE_packingBandage", 100];

  [[_crate]] call SERVER_CurateEditableObjects;
};

_spawn_at_box = {
   params ["_target", "_player", "_id", "_params"];
  _params params ["_class", "_marker"];

  // Spawn a box on the marker
  _crate = "Box_NATO_WpsLaunch_F" createVehicle (getMarkerPos _marker);

  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;

  _crate addWeaponCargoGlobal ["launch_MRAWS_green_F", 3];  
  _crate addMagazineCargoGlobal ["MRAWS_HEAT_F", 17];

  [[_crate]] call SERVER_CurateEditableObjects;
};

_spawn_ammo_box = {
   params ["_target", "_player", "_id", "_params"];
  _params params ["_class", "_marker"];

  // Spawn a box on the marker
  _crate = "ACE_Box_Ammo" createVehicle (getMarkerPos _marker);

  clearweaponcargoGlobal _crate; 
  clearmagazinecargoGlobal _crate; 
  clearitemcargoGlobal _crate; 
  clearbackpackcargoGlobal _crate; 
 
  _crate addItemCargoGlobal ["ACE_EarPlugs", 5];  
  _crate addItemCargoGlobal ["ACE_CableTie", 10];  
 
  _crate addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 20]; 
  _crate addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 20]; 
  _crate addMagazineCargoGlobal ["rhs_200rnd_556x45_M_SAW", 9]; 
  _crate addMagazineCargoGlobal ["rhsusf_100Rnd_762x51_m61_ap", 5]; 
  _crate addMagazineCargoGlobal ["rhs_mag_m67", 10]; 
  _crate addMagazineCargoGlobal ["SmokeShell", 10]; 
  _crate addMagazineCargoGlobal ["SmokeShellRed", 5]; 
  _crate addMagazineCargoGlobal ["SmokeShellBlue", 5]; 
  _crate addMagazineCargoGlobal ["ACE_M84", 2]; 
  _crate addMagazineCargoGlobal ["rhs_mag_M441_HE", 15]; 
  _crate addMagazineCargoGlobal ["rhs_mag_m714_White", 5];
  
  [[_crate]] call SERVER_CurateEditableObjects;
};

_spawn_night_box = {
   params ["_target", "_player", "_id", "_params"];
  _params params ["_class", "_marker"];

  // Spawn a box on the marker
  _crate = "Box_NATO_Support_F" createVehicle (getMarkerPos _marker);

  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;

  _crate addItemCargoGlobal ["ACE_NVG_Wide", 12]; 
  _crate addItemCargoGlobal ["ACRE_PRC343", 5];
  _crate addItemCargoGlobal ["ACRE_PRC152", 5];

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
  _crate addMagazineCargoGlobal ["SmokeShellBlue", 20]; 
  _crate addMagazineCargoGlobal ["SmokeShell", 20]; 
  _crate addMagazineCargoGlobal ["SmokeShellPurple", 20]; 
  _crate addMagazineCargoGlobal ["SmokeShellRed", 20]; 

  [[_crate]] call SERVER_CurateEditableObjects;
};

_spawn_javelin_box = {
   params ["_target", "_player", "_id", "_params"];
  _params params ["_class", "_marker"];

  // Spawn a box on the marker
  _crate = "Box_NATO_WpsSpecial_F" createVehicle (getMarkerPos _marker);

  clearweaponcargoGlobal _crate;
  clearmagazinecargoGlobal _crate;
  clearitemcargoGlobal _crate;
  clearbackpackcargoGlobal _crate;

  _crate addWeaponCargoGlobal ["rhs_weap_fgm148", 1]; 
  _crate addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 5]; 

  [[_crate]] call SERVER_CurateEditableObjects;
};

// Interaction option for each type of box
{
  _object addAction
    [
        format ["<t color='#FF0000'>Spawn %1</t>", _x select 0],
        _spawn_box,
        [_x select 1, _marker],
        10,
        true,
        true,
        "",
        "true", // _target, _this, _originalTarget
        10,
        false,
        "",
        ""
    ];

} forEach _items;

_object addAction
  [
      format ["<t color='#0000FF'>Spawn Medical Crate</t>"],
      _spawn_medical_box,
      [_x select 1, _marker],
      9,
      true,
      true,
      "",
      "true", // _target, _this, _originalTarget
      10,
      false,
      "",
      ""
  ];

_object addAction
  [
      format ["<t color='#0000FF'>Spawn AT Crate</t>"],
      _spawn_at_box,
      [_x select 1, _marker],
      9,
      true,
      true,
      "",
      "true", // _target, _this, _originalTarget
      10,
      false,
      "",
      ""
  ];

_object addAction
  [
      format ["<t color='#0000FF'>Spawn Ammo Crate</t>"],
      _spawn_ammo_box,
      [_x select 1, _marker],
      9,
      true,
      true,
      "",
      "true", // _target, _this, _originalTarget
      10,
      false,
      "",
      ""
  ];

_object addAction
  [
      format ["<t color='#0000FF'>Spawn Javelin Crate</t>"],
      _spawn_javelin_box,
      [_x select 1, _marker],
      9,
      true,
      true,
      "",
      "true", // _target, _this, _originalTarget
      10,
      false,
      "",
      ""
  ];

_object addAction
  [
      format ["<t color='#0000FF'>Spawn Night Supply Crate</t>"],
      _spawn_night_box,
      [_x select 1, _marker],
      9,
      true,
      true,
      "",
      "true", // _target, _this, _originalTarget
      10,
      false,
      "",
      ""
  ];