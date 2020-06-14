private _state = param [0, "", [""]];

if (_state == "init") then
{
	player setvariable ["ACE_IsEngineer", 2];
	[player] call CLIENT_SetArmorCrewVehiclePermissions;
};

if (_state == "respawn") then
{
	player setvariable ["ACE_IsEngineer", 2];
};