params ["_roleDescription"];

_roleDescription = [toLower _roleDescription] call SPM_Util_CleanedRoleDescription;

private _requiredMissionControllers =
[
	"mission controlle*"
];

if (_requiredMissionControllers findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { ["MC"] };

private _requiredMilitaryPolice =
[
	"military polic*"
];

if (_requiredMilitaryPolice findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { ["MC", "MP"] };

private _requiredCameraOperators =
[
	"camera operator"
];

if (_requiredCameraOperators findIf { [_roleDescription, _x] call JB_fnc_regexMatch } >= 0) exitWith { ["MC", "MP", "CO"] };

["MC", "MP", "CO", ""]