// Currently all humvees, MRAPs, MATV

[_this select 0,
	{
		[_this select 0, 4] call ace_cargo_fnc_setSpace;
    [_this select 0, -1] call ace_cargo_fnc_setSize;
	}
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1000, 600] call JB_fnc_respawnVehicleWhenAbandoned;
