/*
Author: JB
*/
private _vehicle = param [0, objNull, [objNull]];

if ([_vehicle] call JB_RV_HasIgnoreParameters) exitWith {};

detach _vehicle;
_vehicle engineOn false;
_vehicle action ["LandGear", _vehicle];  // Logs a message if not present, but otherwise innocuous for non-geared vehicles

private _ejectOccupants =
{
	private _livingOccupants = false;

	{
		if (alive _x && not (_x isKindOf "B_UAV_AI")) then
		{
			moveOut _x;
			_livingOccupants = true;
		}
	} forEach crew _vehicle;

	not _livingOccupants
};

if (canSuspend) then
{
	[_ejectOccupants, 5, 1] call utils_fnc_timeoutWaitUntil;
}
else
{
	call _ejectOccupants;
};

if (not ([_vehicle] call JB_RV_HasRespawnParameters)) then
{
	deleteVehicle _vehicle;
}
else
{
	private _parameters = [_vehicle] call JB_RV_GetRespawnParameters;
	private _originalState = _parameters select 3;

	private _position = _originalState select JB_RV_STATE_POSITION;
	private _direction = _originalState select JB_RV_STATE_DIRECTION;

	// Move to limbo, rotate to correct orientation, move to correct location

	_vehicle setPosASL (call JB_MDI_RandomSpawnPosition);

	_vehicle setDir _direction;
	_vehicle setVelocity [0, 0, 0];
	_vehicle setVectorUp surfaceNormal _position;

	_vehicle hideObjectGlobal true;
	_vehicle setPosASL _position;

	{
		if (not isPlayer _x && { not isObjectHidden _x } && { ([_vehicle, _x] call utils_fnc_objectBoundsIntersect) }) then { [_x] call vehicle_fnc_respawnVehicleReturn };
	} forEach (_vehicle nearObjects ["AllVehicles", 30]);

	_vehicle hideObjectGlobal false;
};
