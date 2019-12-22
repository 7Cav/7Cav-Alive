[_this select 0,
	{
    [_this select 0, 2] call ace_cargo_fnc_setSize;
	}
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 300] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1000, 600] call JB_fnc_respawnVehicleWhenAbandoned;
