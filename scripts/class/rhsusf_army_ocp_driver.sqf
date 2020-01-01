private _state = param [0, "", [""]];

if (_state == "init") then
{

	[] call MAP_InitializeGeneral;
	[] call HUD_Armor_Initialize;

	player setVariable ["SPM_BranchOfService", "armor"];
	player setvariable ["ACE_IsEngineer", 2];
	[player] call CLIENT_SetArmorCrewVehiclePermissions;
};

if (_state == "respawn") then
{
	
};