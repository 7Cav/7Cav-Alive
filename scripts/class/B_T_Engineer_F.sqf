private _state = param [0, "", [""]];

if (_state == "init") then
{

	[player] call CLIENT_SetInfantryVehiclePermissions;
	{
		player setVariable [_x, [[TypeFilter_LogisticsVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver"];

	[] call MAP_InitializeGeneral;
	[] call HUD_Infantry_Initialize;

	player setVariable ["SPM_BranchOfService", "support"];
};

if (_state == "respawn") then
{

};