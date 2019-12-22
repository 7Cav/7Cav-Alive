/*

[vehicle, distance, duration, move] call JB_fnc_respawnVehicleWhenAbandoned

This script handles respawn of a vehicle when it is abandoned by its crew and no friendly soldiers are within
a specified distance for a specified time.  Example call:

[MyVehicle, 300, 120] call JB_fnc_respawnVehicleWhenAbandoned;

vehicle			- the vehicle to be respawned (required)
distance		- the distance at which all friendlies must be before a vehicle is considered abandoned
				  (optional, default 300 meters, not less than 1 meter)
duration		- the duration of the time that the vehicle must remain abandoned
				  (optional, default 120 seconds, not less than 1 second)
move			- the distance which the vehicle must be moved from its spawn point before abandonment is considered
				  (optional, default 100 meters)

				  A value of -1 for distance, duration or move will use that parameter's default value.

*/

if (!isServer) exitWith {};

#define DEFAULT_ABANDONDISTANCE 300
#define DEFAULT_ABANDONDURATION 120
#define DEFAULT_MOVEDDISTANCE 100
#define DEFAULT_DELETEONABANDON false

private _vehicle = param [0, objNull, [objNull]];
private _abandonDistance = param [1, DEFAULT_ABANDONDISTANCE, [0]];
private _abandonDuration = param [2, DEFAULT_ABANDONDURATION, [0]];
private _movedDistance = param [3, DEFAULT_MOVEDDISTANCE, [0]];
private _deleteOnAbandon = param [4, DEFAULT_DELETEONABANDON, [true]];

_abandonDistance = _abandonDistance max 1;
_abandonDuration = _abandonDuration max 1;
_movedDistance = _movedDistance max 0;

_vehicle setVariable ["JB_RV_WhenAbandoned", [_abandonDistance, _abandonDuration, _movedDistance, _deleteOnAbandon]];