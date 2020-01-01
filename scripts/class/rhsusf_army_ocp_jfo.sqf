private _state = param [0, "", [""]];

if (_state == "init") then
{
	[] call MAP_InitializeGeneral;
	[] call HUD_Infantry_Initialize;
	[] call HUD_Repair_Initialize;

	[] call Tac2_fnc_treeCutterInitPlayer;

	player setVariable ["SPM_BranchOfService", "support"];
	player setVariable ["JBA_LogisticsSpecialist", true, true];
	player setvariable ["ACE_IsEngineer", 2];
	player setVariable ["TAC2_canFortify", true];

	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		// Let Apollo drive anything
		player setVariable [_x, [[TypeFilter_All, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver", "VP_Pilot", "VP_Gunner", "VP_Turret"];
};

if (_state == "respawn") then
{

};
