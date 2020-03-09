/*
	Author: JB
*/

params [["_class", "", [""]], ["_category", "", [""]]];

if (_category != "") exitWith { getText (configFile >> _category >> _class >> "displayName") };

private _displayName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
if (_displayName != "") exitWith { _displayName };

_displayName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
if (_displayName != "") exitWith { _displayName };

_displayName = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
if (_displayName != "") exitWith { _displayName };

getText (configFile >> "CfgAmmo" >> _class >> "displayName")