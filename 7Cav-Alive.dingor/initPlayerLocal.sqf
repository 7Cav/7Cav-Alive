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

// Load no fire on base script
player addEventHandler ["Fired", {
	if ((getPos (_this select 0)) inArea headquarters)  then	
	{
		deleteVehicle (_this select 6);
		titleText ["Firing weapons and placing / throwing explosives at base is STRICTLY PROHIBITED!", "PLAIN", 3];
	};
}]; 

CLIENT_InitPlayerLocalComplete = true;
diag_log "initPlayerLocal end";