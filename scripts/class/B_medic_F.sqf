private _state = param [0, "", [""]];

if (_state == "init") then
{

	[] call MAP_InitializeGeneral;
	[] call HUD_Medic_Initialize;
	[] call HUD_Infantry_Initialize;

	player setVariable ["SPM_BranchOfService", "infantry"];

	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		player setVariable [_x, [[TypeFilter_LogisticsVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver"];
};

if (_state == "respawn") then
{

};
