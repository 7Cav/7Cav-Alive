diag_log "initPlayerLocal start";

// Headless client
if (not hasInterface) exitWith
{
	CLIENT_InitPlayerLocalComplete = true;
	diag_log "initPlayerLocal end";
};

enableSaving [false, false];

// Enable group selection ('U' group menu)
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// Initialize player spawn position
player setVariable ["CLIENT_PlayerPosition", [getPosASL player, getDir player]];

// [[code, whatever], [code, whatever], ...]
CLIENT_PlayerDisconnectedHandlers = [];

// Disable faction changes due to team killing, vehicle destruction, etc.
player addEventHandler ["HandleRating", { 0 }];

// Activate advanced sling loading
[] execVM "ASL_AdvancedSlingLoading\overrideStandardSlingLoading.sqf";

// TODO-RENABLE: [] call JB_fnc_increasedFuelConsumption;

// Initialize foritify permissions
[] call tac2_fnc_fortifyPermissionsInitPlayer;

// Make diary entries
[] execVM "scripts\client\diary.sqf";

// Execute class-specific init
["init"] call compile preProcessFile format ["scripts\class\%1.sqf", typeOf player];

// CLIENT_CommandChatHandler =
// {
// 	params ["_channel", "_text"];

// 	if (_text find "gm " == 0 || _text find "mc " == 0 || _text find "mp " == 0) then
// 	{
// 		[_text] remoteExec ["SERVER_ExecuteCommand", 2];
// 	};
// };
// [CLIENT_CommandChatHandler] call JB_fnc_chatAddEventHandler;

CLIENT_InitPlayerLocalComplete = true;
diag_log "initPlayerLocal end";
