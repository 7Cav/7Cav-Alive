private _state = param [0, "", [""]];

if (_state == "init") then
{
	[] call MAP_InitializeGeneral;
	[] call HUD_Pilot_Initialize;

	player setVariable ["SPM_BranchOfService", "air"];
	player setvariable ["ACE_IsEngineer", 2];
	[player] call CLIENT_SetInfantryVehiclePermissions;


	{
		player setVariable [_x, [[TypeFilter_GroundAttackAircraft, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Pilot"];

	{
		player setVariable [_x, [[TypeFilter_BaseServiceVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver"];

};

if (_state == "respawn") then
{
	
};
