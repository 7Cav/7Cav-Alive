[_this select 0] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 300] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1000, 600] call JB_fnc_respawnVehicleWhenAbandoned;
