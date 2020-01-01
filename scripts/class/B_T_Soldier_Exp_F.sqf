private _state = param [0, "", [""]];

if (_state == "init") then
{

	[] call MAP_InitializeGeneral;
	[] call HUD_Infantry_Initialize;
	[] call HUD_Repair_Initialize;

	player setVariable ["SPM_BranchOfService", "support"];
	player setVariable ["JBA_LogisticsSpecialist", true, true]; //JIP

	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		player setVariable [_x, [[TypeFilter_LogisticsVehicles, [], {}], [TypeFilter_All, [], {}]] + (player getVariable _x)];
		player setVariable [_x, [[TypeFilter_BaseServiceVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver"];
};

if (_state == "respawn") then
{

};
