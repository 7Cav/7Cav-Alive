params ["_roleDescription"];

_roleDescription = toLower _roleDescription;

private _roleSteamID =
[
];

if (_roleSteamID findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { 0 };

private _roleRole =
[
	"camera operator"
];

if (_roleRole findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { 1 };

private _roleLesserOfRoleAndSteamID =
[
	"mission controller",
	"military police",
	"cbrn*"
];

if (_roleLesserOfRoleAndSteamID findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { 2 };

private _roleGreaterOfRoleAndSteamID =
[
];

if (_roleGreaterOfRoleAndSteamID findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { 3 };

-1