[_this select 0,
	{
		[_this select 0, 4] call ace_cargo_fnc_setSpace;
    	// Set a massive size so that it can only be loaded in the V-44X
    	[_this select 0, 30] call ace_cargo_fnc_setSize;
	}
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 300] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 600] call vehicle_fnc_respawnVehicleWhenAbandoned;