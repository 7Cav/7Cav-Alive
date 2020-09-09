diag_log "initServer start";

#include "\serverscripts\zeusserverscripts\secretKey.sqf"
missionNamespace setVariable["LOYALTY_CIPHER", CIPHERSECRETKEY, true];
missionNamespace setVariable["endMissionNumber", 0, true]; //Variable init for missionEnd scripts located in scripts/missionEnd

// Disable RHS engine start up so vehicles move immediately when spawned
RHS_ENGINE_STARTUP_OFF = 1;

// Increase ACE max carry and drag weights
ACE_maxWeightCarry = 9000;
ACE_maxWeightDrag = 200000;

// Make sure armed civilians won't attack NATO
civilian setFriend [west, 1];
// Make sure AAF won't attack CSAT
independent setFriend [east, 1];
east setFriend [independent, 1];
// Make sure AAF will attack NATO
independent setFriend [west, 0];

//BUG: Fool BIS_fnc_drawMinefields into believing that it's already running.  This turns off the automatic display of minefields on the map.  The difficulty setting in the server configuration file doesn't seem to work.
bis_fnc_drawMinefields_active = true;

//Make the RHS M119 towable
//Sweetwater
SA_TOW_RULES_OVERRIDE = [["AllVehicles", "CAN_TOW", "RHS_M119_WD"]];

waitUntil { time > 0 }; // Allow time subsystem to initialize so that missionStart is correct

// Alive initialization
[] execVM "alive\CustomFactions.sqf";
["Initialize"] call BIS_fnc_dynamicGroups;
[] execVM "ASL_AdvancedSlingLoading\functions\fn_advancedSlingLoadInit.sqf";
[] execVM "AT_AdvancedTowing\functions\fn_advancedTowingInit.sqf";
[] execVM "AUR_AdvancedUrbanRappelling\functions\fn_advancedUrbanRappellingInit.sqf";
[] execVM "cScripts\CavFnc\functions\init\fn_initFortify.sqf";

enableEnvironment [false, true];

//ALiVE headless
if (!hasInterface && !isDedicated) then {
headlessClients = [];
headlessClients set [(count headlessClients), player];
publicVariable "headlessClients";
isHC = true;
};

diag_log "initServer end";
