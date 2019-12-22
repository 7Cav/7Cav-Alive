[_this select 0] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 50, 120] call JB_fnc_respawnVehicleWhenAbandoned;
