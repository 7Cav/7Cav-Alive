/*
 * Author: Bojan
 * Chain, or unchain a unit spawned in by SPM
 */

params ["_units", "_makeChained"];

if (not isServer && hasInterface) exitWith {};

{
	_unit = _x;
	if (_unit isKindOf "Man") then {
		if (_makeChained) then {
			[_unit] call SPM_Occupy_ChainUnit;
		} else {
			[_unit] call SPM_Occupy_UnchainUnit;
		};
	};
} forEach _units;


