[_this select 0,
	{
		[_this select 0, 16] call ace_cargo_fnc_setSpace;
		[_this select 0, -1] call ace_cargo_fnc_setSize;
		[_this select 0, 6000] call ace_refuel_fnc_setFuel;
		[_this select 0, 1200] call ace_rearm_fnc_setSupplyCount;
		(_this select 0) setVariable ["ACE_isRepairVehicle", true, true];
		{ (_this select 0) removeWeapon _x } forEach weapons (_this select 0);
		(_this select 0) animate ["HideTurret", 1];

		(_this select 0) addMPEventHandler ["MPKilled", { if (local (_this select 0)) then { [_this select 0, 0.8, 1.0] call SPM_RemoveRandomAmmunition } }];
	}
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 99999] call JB_fnc_respawnVehicleWhenAbandoned;