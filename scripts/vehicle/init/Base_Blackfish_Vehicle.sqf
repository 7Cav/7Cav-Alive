[_this select 0,
	{
		(_this select 0) addBackpackCargoGlobal ["B_AssaultPack_rgr_Repair", 3];
		[_this select 0, "B_Parachute", 0] call JB_fnc_setBackpackCargoGlobal;
		[_this select 0, 30] call ace_cargo_fnc_setSpace;
	}
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 300] call JB_fnc_respawnVehicleWhenAbandoned;
