// Used for random stuff on base that people shouldn't really be driving, or stuff that is a vehicle but doesnt move
// For example, rearm objects or other random things that can be blown up accidentally

[_this select 0] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 10] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 100, 120] call vehicle_fnc_respawnVehicleWhenAbandoned;
