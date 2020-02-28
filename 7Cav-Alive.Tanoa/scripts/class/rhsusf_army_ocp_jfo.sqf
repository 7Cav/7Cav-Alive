private _state = param [0, "", [""]];

if (_state == "init") then
{
	[] call Tac2_fnc_treeCutterInitPlayer;

	player setvariable ["ACE_IsEngineer", 2];

	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		// Let Apollo drive anything
		player setVariable [_x, [[TypeFilter_All, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver", "VP_Pilot", "VP_Gunner", "VP_Turret"];
};

if (_state == "respawn") then
{

};
