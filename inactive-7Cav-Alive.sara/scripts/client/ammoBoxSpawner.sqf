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

{
  _object addAction
    [
        format ["<t color='#FF0000'>Spawn %1</t>", _x select 0],
        CLIENT_SpawnBox,
        [getMarkerPos _marker, _x select 1],
        10,
        true,
        true,
        "",
        "true",
        10,
        false,
        "",
        ""
    ];
} forEach _items;

private _ammoboxTypes = [
  [format ["<t color='#ff9933'>Small Empty Crate</t>"], CLIENT_spawn_small_box],
  [format ["<t color='#ff9933'>Big Empty Crate</t>"], CLIENT_spawn_big_box],
  [format ["<t color='#ff9933'>Air Drop Empty Crate</t>"], CLIENT_spawn_airDrop_box],
  [format ["<t color='#ff9933'>Vehicle Ammo Box</t>"], CLIENT_spawn_vehicleAmmo_box],
  [format ["<t color='#ff9933'>Fuel Pallet</t>"], CLIENT_spawn_fuel_box],
  [format ["<t color='#25b34b'>Medical Crate</t>"], CLIENT_SpawnMedicalBox],
  [format ["<t color='#ff0000'>Mixed AT Crate</t>"], CLIENT_SpawnAtBox],
  [format ["<t color='#0000FF'>Ammo Crate</t>"], CLIENT_SpawnAmmoBox],
  [format ["<t color='#ff0000'>Javelin Crate</t>"], CLIENT_SpawnJavelinBox],
  [format ["<t color='#0000FF'>Night Supply Crate</t>"], CLIENT_SpawnNightBox],
  [format ["<t color='#ff0000'>.50Cal HMG Crate</t>"], CLIENT_SpawnHMGBox],
  [format ["<t color='#ff0000'>Mk.19 GMG Crate</t>"], CLIENT_SpawnGMGBox],
  [format ["<t color='#ff0000'>TOW AT Crate</t>"], CLIENT_SpawnTOWBox],
  [format ["<t color='#ff0000'>Stinger AA Crate</t>"], CLIENT_SpawnAABox],
  [format ["<t color='#0000FF'>Barrett .50 Anti-Materiel Crate</t>"], CLIENT_SpawnAMBox],
  [format ["<t color='#0000FF'>240G GPMG Crate</t>"], CLIENT_SpawnGPMGBox]
];



_spawnBox = {
  	params ["_crate", "_caller", "_actionId", "_arguments"];
	  _arguments params ["_position", "_spawnFunction"];
    [_position] call _spawnFunction;
};

{
  _object addAction [
    _x select 0,
    _spawnBox,
    [getMarkerPos _marker, _x select 1],
    9,
    true,
    true,
    "",
    "true",
    10,
    false,
    "",
    ""
  ];
} forEach _ammoboxTypes;