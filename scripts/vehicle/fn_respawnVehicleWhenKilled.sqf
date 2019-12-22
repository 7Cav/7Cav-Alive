/*

[vehicle, respawnDelay] call JB_fnc_respawnVehicleWhenKilled

This script handles respawn of a vehicle after its destruction.  This script should be called in the vehicle's Init
section.  For example:

_null = [MyVehicle, 20] call JB_fnc_vehicleRespawn;

vehicle			- the vehicle to be respawned (required)
respawnDelay	- the delay between the vehicle being destroyed and being respawned (optional)

*/

#define DEFAULT_RESPAWNDELAY 60

if (!isServer) exitWith {};

private _vehicle = param [0, objNull, [objNull]];
private _respawnDelay = param [1, DEFAULT_RESPAWNDELAY, [0]];

_vehicle setVariable ["JB_RV_WhenKilled", [_respawnDelay]];