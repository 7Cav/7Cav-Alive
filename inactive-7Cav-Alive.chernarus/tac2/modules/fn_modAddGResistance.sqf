/*
 * Author: Bojan
 * Give a select player G-resistance for flying planes
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
	"G-Resistance",
	[
		["Enabled",
			[
				"True",
				"False"
			],0]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};

_gResistance = switch (_dialogResult select 0) do {
			case 0: { true };
			case 1: { false };
	};

// Apply permission to each object
{
	private _unit = _x;
	if (_unit isKindOf "Man") then {

		if(_gResistance) then {
			_unit setVariable ["ACE_GForceCoef", 0.35, true];	
		} else {
			_unit setVariable ["ACE_GForceCoef", 1, true];
		};
	};
} forEach _selectedObjects;