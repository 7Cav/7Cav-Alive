//Currently Abrams

[_this select 0, {}] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 420] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 600] call vehicle_fnc_respawnVehicleWhenAbandoned;