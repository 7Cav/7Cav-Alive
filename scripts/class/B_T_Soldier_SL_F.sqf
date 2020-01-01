private _state = param [0, "", [""]];

if (_state == "init") then
{

	[] call MAP_InitializeGeneral;
	[] call HUD_Infantry_Initialize;

	player setVariable ["SPM_BranchOfService", "support"];

	[player] call CLIENT_SetInfantryVehiclePermissions;
};

if (_state == "respawn") then
{

};