/*
Author: JB
*/
// If a player is moving faster than this speed (m/s) then they are not considered to be near a vehicle and it can be considered abandoned
#define ABANDON_SPEED 6.0

JB_RV_STATE_POSITION = 0;
JB_RV_STATE_DIRECTION = 1;
JB_RV_STATE_PYLONMAGAZINES = 2;
JB_RV_STATE_TEXTURES = 3;
JB_RV_STATE_ANIMATIONSOURCES = 4;

JB_RV_SetInitializer =
{
	params ["_vehicle", "_initName", "_initCode"];

	private _vehicleInit = _vehicle getVariable "JB_RV_Initializers";
	private _vehicleInitCount = 0;

	if (!isNil "_vehicleInit") then
	{
		_vehicleInitCount = count _vehicleInit;
	}
	else
	{
		_vehicleInit = [];
		_vehicleInitCount = 0;
	};

	private _newName = true;

	{
		if (_x select 0 == _initName) then
		{
			_x set [1, _initCode];
			_newName = false;
		};
	} foreach _vehicleInit;

	if (_newName) then
	{
		_vehicleInit = _vehicleInit + [[_initName, _initCode]];
	};

	_vehicle setVariable ["JB_RV_Initializers", _vehicleInit];
};

/*

[parameters] = [vehicle] call JB_RV_GetRespawnParameters

	This function obtains the parameters needed for JB_RV_RespawnVehicle.  This function exists
	so that the parameters can be collected at one time and then used at another time.  That
	ability is particularly important for vehicle_fnc_respawnVehicleWhenKilled.  The vehicle
	will be Killed, and then the parameters can be immediately collected.  The WhenKilled script
	can then delay for however long it likes, other software can remove the wrecked vehicle,
	and the parameters that were saved can be supplied to JB_RV_RespawnVehicle.

*/
JB_RV_GetRespawnParameters =
{
	private _vehicle = param [0, objNull, [objNull]];

	private _originalState = _vehicle getVariable "JB_RV_State";
	if (isNil "_originalState") exitWith { [_vehicle] };

	private _type = typeOf _vehicle;
	private _vehicleName = vehicleVarName _vehicle;

	private _initializers = _vehicle getVariable ["JB_RV_Initializers", []];
	private _whenKilled = _vehicle getVariable ["JB_RV_WhenKilled", []];
	private _whenAbandoned = _vehicle getVariable ["JB_RV_WhenAbandoned", []];

	[_vehicle, _type, _vehicleName, _originalState, _initializers, _whenKilled, _whenAbandoned]
};

/*
	Determine if the vehicle is tracked by this system.
*/
JB_RV_HasRespawnParameters =
{
	not isNil { (_this select 0) getVariable "JB_RV_State" }
};

/*
	Determain if the vehicle should be ignored by the system
*/
JB_RV_HasIgnoreParameters =
{
	not isNil { (_this select 0) getVariable "JB_RV_Ignore" }
};

/*
	Mark the vehicle such that it is no longer tracked by this system.
*/
JB_RV_RemoveRespawnParameters =
{
	params ["_vehicle"];

	_vehicle setVariable ["JB_RV_State", nil];
	_vehicle setVariable ["JB_RV_Initializers", nil];
	_vehicle setVariable ["JB_RV_WhenKilled", nil];
	_vehicle setVariable ["JB_RV_WhenAbandoned", nil];
};

/*

newVehicle = [parameters] call utils_fnc_respawnVehicle

	Immediately respawn a vehicle that has been initialized by vehicle_fnc_respawnVehicleInitialize.  The
	vehicle will be recreated using the location and initialization script supplied at that time.

	The parameters to this function are defined by utils_fnc_respawnVehicleParameters, which collects
	the parameters from the old vehicle for use by this function.  This permits scripts to collect
	the respawn parameters at one time and use them at another.

*/

JB_RV_RespawnVehicle =
{
	params ["_vehicle", "_type", "_vehicleName", "_originalState", "_initializers", "_whenKilled", "_whenAbandoned"];

	// Hide the object, ensuring that it won't intersect a new one.  Next, recreate the vehicle
	// at some random location away from the map, rotate it and move it to the final
	// location.  Last, update the vehicle's variable name to point at the new vehicle.

	_vehicle hideObjectGlobal true;

	private _newVehicle = createVehicle [_type, [_startPosition select 0, _startPosition select 1, 10000], [], 0, "can_collide"];

	_newVehicle setVariable ["JB_RV_State", _originalState];

	private _pylonPaths = ("true" configClasses (configFile >> "CfgVehicles" >> _type >> "Components" >> "TransportPylonsComponent" >> "Pylons")) apply { [configName _x, getArray (_x >> "turret")] };
	{ _newVehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _newVehicle;
	{ _newVehicle setPylonLoadOut [_pylonPaths select _forEachIndex select 0, _x, true, _pylonPaths select _forEachIndex select 1] } forEach (_originalState select JB_RV_STATE_PYLONMAGAZINES);

	{ _newVehicle setObjectTextureGlobal [_forEachIndex, _x] } forEach (_originalState select JB_RV_STATE_TEXTURES);

	{ _newVehicle animate _x } forEach (_originalState select JB_RV_STATE_ANIMATIONSOURCES);

	if (!isNil "_initializers") then
	{
		_newVehicle setVariable ["JB_RV_Initializers", _initializers];
		{
			[_newVehicle, _vehicle] call (_x select 1);
		} foreach _initializers;
	};

	if (count _whenKilled > 0) then
	{
		_newVehicle setVariable ["JB_RV_WhenKilled", _whenKilled];
	};

	if (count _whenAbandoned > 0) then
	{
		_newVehicle setVariable ["JB_RV_WhenAbandoned", _whenAbandoned];
	};

	// External initialization
	[_newVehicle] call SERVER_InitializeObject;

	// Delete the old vehicle

	deleteVehicle _vehicle;

	// Set the vehicle's variable name to point to the respawned vehicle on the server and on all clients
	[_newVehicle, _vehicleName] call vehicle_fnc_setVehicleVarName;

	[_newVehicle] call vehicle_fnc_respawnVehicleReturn;

	_newVehicle;
};

JB_RV_VehicleDeleted =
{
	params ["_vehicle"];

	private _whenKilled = _vehicle getVariable "JB_RV_WhenKilled";

	if (not isNil "_whenKilled") then
	{
		private _parameters = [_vehicle] call JB_RV_GetRespawnParameters;
		
		[_whenKilled, _parameters] spawn
		{
			params ["_whenKilled", "_parameters"];

			sleep (_whenKilled select 0);
			private _vehicle = _parameters call JB_RV_RespawnVehicle;

			[_vehicle] spawn JB_RV_Monitor;
		};
	};
};

JB_RV_Monitor =
{
	params ["_vehicle"];

	scriptName format ["JB_RV_Monitor %1", typeOf _vehicle];

	private _originalState = _vehicle getVariable "JB_RV_State";

	private _lastAbandoned = 0;
	private _isAbandoned = false;
	private _startPosition = _originalState select JB_RV_STATE_POSITION;
	private _marker = format ["JB_RV_%1-%2", floor (_startPosition select 0), floor (_startPosition select 1)];

	private _deleteHandlerIndex = _vehicle addEventHandler ["Deleted", JB_RV_VehicleDeleted];

	while { alive _vehicle && not _isAbandoned } do
	{
		private _whenAbandoned = _vehicle getVariable "JB_RV_WhenAbandoned";
		if (not isNil "_whenAbandoned") then
		{
			private _abandonDistanceCondition = _whenAbandoned select 0;
			private _abandonDurationCondition = _whenAbandoned select 1;
			private _movedDistanceCondition = _whenAbandoned select 2;

			private _currentlyAbandoned = false;

			if (getPosASL _vehicle distance _startPosition >= _movedDistanceCondition) then
			{
				if ({ alive _x } count crew _vehicle == 0) then
				{
					private _vehicleVelocity = velocity _vehicle;

					// Considered abandoned if no one is nearby and moving below a certain speed (i.e. driving by above that speed does not mark the vehicle as no longer abandoned)
					_currentlyAbandoned = true;
					{
						if ((getPosASL _x distance getPosASL _vehicle) <= _abandonDistanceCondition && vectorMagnitude (_vehicleVelocity vectorDiff (velocity _x)) < ABANDON_SPEED) exitWith { _currentlyAbandoned = false };
					} forEach (allPlayers select { not (_x isKindOf "HeadlessClient_F") });
				};
			};

			if (not _currentlyAbandoned) then
			{
				if (_lastAbandoned > 0) then
				{
					_lastAbandoned = 0;
					deleteMarker _marker;
				};
			}
			else
			{
				if (_lastAbandoned == 0) then
				{
					_lastAbandoned = diag_tickTime;

					createMarker [_marker, getPos _vehicle];
					_marker setMarkerType "mil_dot";
					_marker setMarkerText getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
				}
				else
				{
					_marker setMarkerPos [getPos _vehicle select 0, getPos _vehicle select 1];

					// Delay reaction if the vehicle is damaged
					_abandonDurationCondition = _abandonDurationCondition + (120 * damage _vehicle);

					_abandonedDuration = diag_tickTime - _lastAbandoned;
					if (_abandonedDuration >= _abandonDurationCondition) then
					{
						_isAbandoned = true;
					};
				};
			};
		};

		sleep 5;
	};

	if (_lastAbandoned != 0) then
	{
		deleteMarker _marker;
	};

	if (isNull _vehicle) exitWith {}; // Vehicle was deleted, and the Deleted handler resolves things

	_vehicle removeEventHandler ["Deleted", _deleteHandlerIndex];

	private _shouldReturn = false;
	private _returnDelay = 0;
	private _shouldRespawn = false;
	private _respawnDelay = 0;
	private _shouldDelete = false;
	private _deleteDelay = 0;

	if (not alive _vehicle) then
	{
		private _whenKilled = _vehicle getVariable "JB_RV_WhenKilled";

		if (isNil "_whenKilled") then
		{
			_shouldDelete = true;
			_deleteDelay = 300;
		}
		else
		{
			_shouldRespawn = true;
			_respawnDelay = _whenKilled select 0;
		};
	}
	else
	{
		if (_isAbandoned) then
		{
			private _whenAbandoned = _vehicle getVariable "JB_RV_WhenAbandoned";
			private _deleteOnAbandon = _whenAbandoned select 3;

			if (_deleteOnAbandon) then
			{
				_shouldDelete = true;
				_deleteDelay = 0;
			}
			else
			{
				_vehicle setOwner 2;
				[{ owner _vehicle == 2 }, 5] call utils_fnc_timeoutWaitUntil;

				// Sort out aircraft from which a player ejected
				if (_vehicle isKindOf "Plane" && _vehicle animationPhase "canopy_hide" == 1) then
				{
					_vehicle animate ["ejection_seat_hide", 0];
					_vehicle animate ["canopy_hide", 0];
					_vehicle setVehicleLock "unlocked";
				};

				_vehicle setDamage 0;
				_vehicle setFuel 1;

				_shouldReturn = true;
				_returnDelay = 0;
			};
		};
	};

	if (_shouldRespawn) then
	{
		private _parameters = [_vehicle] call JB_RV_GetRespawnParameters;

		sleep _respawnDelay;
		_vehicle = _parameters call JB_RV_RespawnVehicle;

		[_vehicle] spawn JB_RV_Monitor;
	};

	if (_shouldReturn) then
	{
		sleep _respawnDelay;
		[_vehicle] call vehicle_fnc_respawnVehicleReturn;

		[_vehicle] spawn JB_RV_Monitor;
	};

	if (_shouldDelete) then
	{
		sleep _deleteDelay;
		deleteVehicle _vehicle;
	};
};