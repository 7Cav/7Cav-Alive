params ["_roleDescription"];

_roleDescription = [toLower _roleDescription] call SPM_Util_CleanedRoleDescription;

private _roleMissionControllers =
[
	"mission controlle*"
];

if (_roleMissionControllers findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { "MC" };

private _roleMilitaryPolice =
[
	"military polic*"
];

if (_roleMilitaryPolice findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { "MP" };

private _roleCameraOperators =
[
	"camera operator"
];

if (_roleCameraOperators findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { "CO" };

""
