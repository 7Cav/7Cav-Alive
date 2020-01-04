/*
	Define extra conditions here to limit the usage of certain vehicles based on certain criteria.
*/

VPC_UnlessOccupied =
{
	params ["_vehicle", "_player", "_type"];

	if (count crew _vehicle == 0) exitWith { "" };

	private _vehicleName = [typeOf _vehicle, "CfgVehicles"] call utils_fnc_displayName;

	format ["You may not drive this %1 while it is occupied", _vehicleName]
};

VPC_UnlessArmed =
{
	params ["_vehicle", "_player", "_type"];

	if ((weapons _vehicle) findIf { [_x] call utils_fnc_isOffensiveWeapon } == -1) exitWith { "" };

	private _vehicleName = [typeOf _vehicle, "CfgVehicles"] call utils_fnc_displayName;

	switch (_type) do
	{
		case "VP_Pilot" : { format ["You may not fly this %1 because it is armed", _vehicleName] };
		default { format ["You may not operate weapons on this %1", _vehicleName] };
	};
};

VPC_UnlessTurretArmed =
{
	params ["_vehicle", "_player", "_type"];

	private _turretWeapons = [];
	{ _turretWeapons append (_vehicle weaponsTurret _x) } forEach allTurrets _vehicle;

	if (_turretWeapons findIf { [_x] call utils_fnc_isOffensiveWeapon } == -1) exitWith { "" };

	private _vehicleName = [typeOf _vehicle, "CfgVehicles"] call utils_fnc_displayName;

	format ["You may not operate weapons on this %1", _vehicleName]
};