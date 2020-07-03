[_this select 0,
	{
		(_this select 0) addBackpackCargoGlobal ["B_AssaultPack_rgr_Repair", 3];
		[_this select 0, 30] call ace_cargo_fnc_setSpace;
	}
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 500, 1800] call vehicle_fnc_respawnVehicleWhenAbandoned;