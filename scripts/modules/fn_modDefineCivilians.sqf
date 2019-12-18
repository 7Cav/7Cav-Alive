private _selectedObjects = ["Objects"] call Achilles_fnc_SelectUnits;
private _newRatings = [];
{
	_newRatings pushBack (configFile >> "CfgVehicles" >> typeof _x)
} forEach _selectedObjects;

// Needs to exec on server
[_newRatings, true] remoteExec ["Tac2_fnc_updateUnitRatings", 2, false];