/*
 * Author: Bojan
 * Give a select player full vehicle permissions
 */

params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

// Collect all objects to apply permissions to
private _selectedObjects = if (isNull _objectUnderCursor) then
{
	["Objects"] call Achilles_fnc_SelectUnits;
}
else
{
	[_objectUnderCursor];
};

// Get type of permission to apply
_dialogResult = [
	"Set Player Permission Type",
	[
		["Permissions to grant",
			[
				"All",
				"Transport Rotary",
				"Attack Rotary",
				"Fixed Wing Attack",
				"Tank / Heavy Armour",
				"Logistics Vehicles"
			],0]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

// Apply permission to each object
{
	private _unit = _x;
	if (_unit isKindOf "Man") then {

		_extra_permission = switch (_dialogResult select 0) do {
			case 0: { TypeFilter_All };
			case 1: { TypeFilter_TransportRotory };
			case 2: { TypeFilter_AttackRotory };
			case 3: { TypeFilter_GroundAttackAircraft };
			case 4: { TypeFilter_ArmoredVehicles };
			case 5: { TypeFilter_LogisticsVehicles };
		};

		[_unit] call CLIENT_SetInfantryVehiclePermissions;
		{
			_unit setVariable [_x, [[_extra_permission, [], {}]] + (_unit getVariable _x), true];
		} forEach ["VP_Driver", "VP_Pilot", "VP_Gunner", "VP_Turret"];

	};
} forEach _selectedObjects;