// Currently all armed Vehicles with the Mk19

[_this select 0,
	{
	(_this select 0) removeMagazines "RHS_48Rnd_40mm_MK19_M1001";
	[_this select 0, 4] call ace_cargo_fnc_setSpace;
    [_this select 0, -1] call ace_cargo_fnc_setSize;
	}
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1000, 600] call JB_fnc_respawnVehicleWhenAbandoned;
