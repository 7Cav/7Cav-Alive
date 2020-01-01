private _state = param [0, "", [""]];

if (_state == "init") then
{
	[] call MAP_InitializeGeneral;
	[] call HUD_Infantry_Initialize;

	player setVariable ["SPM_BranchOfService", "infantry"];
	player setVariable ["TAC2_canFortify", true];
	player setvariable ["ACE_IsEngineer", 2];


	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		player setVariable [_x, [[TypeFilter_All, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver", "VP_Pilot", "VP_Gunner", "VP_Turret"];

	// Add MP/GM commands to Zeus map
	if (not (player diarySubjectExists "missioncontroller")) then { player createDiarySubject ["missioncontroller", "Mission Controller"] };
	player createDiaryRecord ["missioncontroller", ["Mission Controller Comands",
				DOC_MissionController + "<br/>" +
				"Bindings:<br/><br/>" +
				DOC_ZeusBindings + "<br/>" +
				"Commands:<br/><br/>" +
				DOC_MissionControllerCommands + "<br/>" +
				DOC_MilitaryPoliceCommands
			]];
};

if (_state == "respawn") then
{

};
