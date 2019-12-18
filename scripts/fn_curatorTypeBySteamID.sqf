params ["_uid"];

private _uids = call compile preprocessFile "scripts\zeusGUIDs.sqf";

_uids params ["_uidDevelopers", "_uidMissionControllers", "_uidMilitaryPolice", "_uidCameraOperators"];

if (_uid in _uidDevelopers) exitWith { "DD" };
if (_uid in _uidMissionControllers) exitWith { "MC" };
if (_uid in _uidMilitaryPolice) exitWith { "MP" };
if (_uid in _uidCameraOperators) exitWith { "CO" };

""
