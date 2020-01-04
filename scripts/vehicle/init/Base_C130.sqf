[_this select 0,
	{
		(_this select 0) addBackpackCargoGlobal ["B_AssaultPack_rgr_Repair", 3];
		[_this select 0, 31] call ace_cargo_fnc_setSpace;

	}
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 300] call vehicle_fnc_respawnVehicleWhenAbandoned;
