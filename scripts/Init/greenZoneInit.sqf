/*
	The bulk of this script is in managing UAVs.  They can be used directly or operate autonomously.  When direct,
the projectiles they fire in a green zone must be deleted by the client.  When autonomous, the projectiles they fire
in a green zone must be deleted by the server.  A UAV client polls to keep track of which UAVs are in green zones.
This is done to generate informational messages for the UAV operator, but also to let that client know which
projectiles to delete.  UAV operators are still able to operate vehicle turrets as well as personal weapons.
*/

#define GREEN_ZONE_FIRING_MESSAGE "No firing is permitted in a green zone.  Please safe your weapon."
#define ENTER_GREEN_ZONE_MESSAGE "You are in a green zone.  Weapons are safed."
#define LEAVE_GREEN_ZONE_MESSAGE "You have left a green zone.  Weapon use is authorized."

#define UAV_FIRING_MESSAGE_DURATION 3
#define UAV_FIRING_MESSAGE_INTERVAL 6

GZ_InAnyArea =
{
	params ["_unit", "_list"];

	private _inArea = false;

	{
		_inArea = _unit inArea _x;
		if (_inArea) exitWith { };
	} foreach _list;

	_inArea;
};

GZ_GreenZoneUAVs = [];

GZ_UpdateGreenZoneUAVList =
{
	{
		private _unitIsInGreenZone = false;
		if (!([_x, _greenZoneExceptions] call GZ_InAnyArea)) then
		{
			_unitIsInGreenZone = ([_x, _greenZoneAreas] call GZ_InAnyArea);
		};

		if (_unitIsInGreenZone) then
		{
			if (not (_x in GZ_GreenZoneUAVs)) then
			{
				GZ_GreenZoneUAVs pushback _x;

				private _enterMessage = format ["The %1 has entered a green zone.  Its weapons have been disabled.", [typeOf _x] call JB_fnc_displayName];
				titleText [_enterMessage, "plain down", 0.3];
			};
		}
		else
		{
			if (_x in GZ_GreenZoneUAVs) then
			{
				GZ_GreenZoneUAVs = GZ_GreenZoneUAVs - [_x];

				private _leaveMessage = format ["The %1 has left a green zone.  Its weapons are enabled.", [typeOf _x] call JB_fnc_displayName];
				titleText [_leaveMessage, "plain down", 0.3];
			};
		};
	} forEach allUnitsUAV;
};

GZ_LastUAVFiringMessage = 0;

private _unit = param [0, objNull, [objNull]];
private _greenZoneAreas = param [1, [], [[]]];
private _greenZoneExceptions = param [2, [], [[]]];

private _isUAVOperator = _unit getUnitTrait "UAVHacker";
if (isNil "_isUAVOperator") then { _isUAVOperator = false };

/*
	Set up two code variables, _enterGreenZone and _leaveGreenZone, for each of three cases

	1. UAVs.  They independently follow green zone rules, but their projectiles are deleted
		by the operator if the operator is directly controlling them.
	2. UAV operators.  They follow green zone rules, but they also need to be structured to
		ignore UAV fire attributed to them because of the FiredMan event handler.
	3. All others.  In this case, a straight FiredMan handler deletes everything fired.
*/

private _enterGreenZone = {};
private _leaveGreenZone = {};

if (unitIsUAV _unit) then
{
	_enterGreenZone =
	{
		private _unit = (_this select 0);

		[_unit, true] remoteExec ["setCaptive", _unit];

		private _handlerIndex = _unit addEventHandler ["Fired",
			{
				deleteVehicle (_this select 6);
			} ];
		_unit setVariable ["GZ_HandlerIndex", _handlerIndex];
	};

	_leaveGreenZone =
	{
		private _unit = (_this select 0);

		[_unit, false] remoteExec ["setCaptive", _unit];

		private _handlerIndex = _unit getVariable ["GZ_HandlerIndex", -1];

		if (_handlerIndex >= 0) then
		{
			_unit removeEventHandler ["Fired", _handlerIndex];
			_unit setVariable ["GZ_HandlerIndex", nil];
		};
	};
}
else
{
	// If the player is a UAV operator, then we're going to need to ignore UAV fire attributed to him

	if (_isUAVOperator) then
	{
		_enterGreenZone =
		{
			private _unit = (_this select 0);

			// Apply safety measures
			_unit allowDamage false;
			_unit action ["SwitchWeapon", _unit, _unit, -1]; // Switch to no weapon

			// Curators may fire while remotely operating vehicles (e.g. enemy units)
			private _handlerIndex = _unit addEventHandler ["FiredMan",
				{
					private _projectile = _this select 6;
					private _unit = _this select 7;

					if (CLIENT_CuratorType == "MC") exitWith {};

					if (not unitIsUAV _unit) then
					{
						deleteVehicle (_projectile);
						[GREEN_ZONE_FIRING_MESSAGE, 1] call JB_fnc_showBlackScreenMessage;
					}
					else
					{
						if (_unit in GZ_GreenZoneUAVs) then
						{
							deleteVehicle (_projectile);

							private _tickTime = diag_tickTime;
							if ((_tickTime - GZ_LastUAVFiringMessage) > UAV_FIRING_MESSAGE_INTERVAL) then
							{
								private _violationMessage = format ["The %1 has fired in a green zone.", [typeOf _unit] call JB_fnc_displayName];
								titleText [_violationMessage, "plain", UAV_FIRING_MESSAGE_DURATION / 10];

								GZ_LastUAVFiringMessage = _tickTime;
							};
						};
					};
				} ];
			_unit setVariable ["GZ_HandlerIndex", _handlerIndex];

			if (lifeState player in ["INJURED", "HEALTHY"]) then
			{
				titleText [ENTER_GREEN_ZONE_MESSAGE, "plain down", 0.3];
			};
		};

		_leaveGreenZone =
		{
			private _unit = (_this select 0);

			private _handlerIndex = _unit getVariable ["GZ_HandlerIndex", -1];
			if (_handlerIndex >= 0) then
			{
				_unit removeEventHandler ["FiredMan", _handlerIndex];
				_unit setVariable ["GZ_HandlerIndex", nil];
			};

			// Remove safety measures
			_unit allowDamage true;
			if (lifeState player in ["INJURED", "HEALTHY"]) then
			{
				titleText [LEAVE_GREEN_ZONE_MESSAGE, "plain down", 0.3];
			};
		};
	}
	else // Not a UAV operator, so no remote operation, and we can discount all shots
	{
		_enterGreenZone =
		{
			params ["_unit"];

			// Apply safety measures
			_unit allowDamage false;
			_unit action ["SwitchWeapon", _unit, _unit, -1]; // Switch to no weapon

			// Disallow weapons fire
			private _dryFire = [GREEN_ZONE_FIRING_MESSAGE] call CLIENT_StartForceDryFire;
			player setVariable ["GZ_DryFireIndex", _dryFire];

			if (lifeState player in ["INJURED", "HEALTHY"]) then
			{
				titleText [ENTER_GREEN_ZONE_MESSAGE, "plain down", 0.3];
			};
		};

		_leaveGreenZone =
		{
			params ["_unit"];

			// Allow weapons free
			private _dryFire = player getVariable ["GZ_DryFireIndex", -1];
			[_dryFire] call CLIENT_EndForceDryFire;

			// Remove safety measures
			_unit allowDamage true;

			if (lifeState player in ["INJURED", "HEALTHY"]) then
			{
				titleText [LEAVE_GREEN_ZONE_MESSAGE, "plain down", 0.3];
			};
		};
	};
};

private _unitIsInGreenZone = false;
private _unitWasInGreenZone = false;

// Keep looking for transitions across the boundaries of green zone areas

while { alive _unit } do
{
	if (_isUAVOperator) then
	{
		call GZ_UpdateGreenZoneUAVList
	};

	_unitIsInGreenZone = false;
	if (!([_unit, _greenZoneExceptions] call GZ_InAnyArea)) then
	{
		_unitIsInGreenZone = ([_unit, _greenZoneAreas] call GZ_InAnyArea);
	};

	if (not (_unitIsInGreenZone isEqualTo _unitWasInGreenZone)) then
	{
		if (_unitIsInGreenZone) then
		{
			[_unit] call _enterGreenZone;
		}
		else
		{
			[_unit] call _leaveGreenZone;
		};

		_unitWasInGreenZone = _unitIsInGreenZone;
	};

	sleep 3;
};

// Unit is dead/destroyed, so make sure the handlers are removed if last in a green zone

if (_unitIsInGreenZone) then
{
	[_unit] call _leaveGreenZone;
};