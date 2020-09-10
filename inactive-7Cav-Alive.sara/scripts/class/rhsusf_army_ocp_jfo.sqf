private _state = param [0, "", [""]];

if (_state == "init") then
{
	[] call Tac2_fnc_treeCutterInitPlayer;

	player setvariable ["ACE_IsEngineer", 2];
	player setVariable ["TAC2_canFortify", true, true];

	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		player setVariable [_x, [[TypeFilter_LogisticsVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver", "VP_Pilot", "VP_Gunner", "VP_Turret"];

	{
		player setVariable [_x, [[TypeFilter_ArmoredVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver"];
};

if (_state == "respawn") then
{
	player setvariable ["ACE_IsEngineer", 2];
};
