[_this select 0] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 50, 120] call vehicle_fnc_respawnVehicleWhenAbandoned;
