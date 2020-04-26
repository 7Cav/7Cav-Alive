[_this select 0,
	{
	}] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1000] call vehicle_fnc_respawnVehicleWhenAbandoned;