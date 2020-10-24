diag_log "initServer start";

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

// Start times selected randomly throughout the daylight hours between sunrise and one hour before sunset
waitUntil { time > 0 }; // Allow time subsystem to initialize so that missionStart is correct
private _date = missionStart select [0, 5];

private _times = [_date] call BIS_fnc_sunriseSunsetTime;
private _startTime = (_times select 0) + (random ((_times select 1) - (_times select 0) - 1));
private _startHour = floor _startTime;
private _startMinute = (_startTime - _startHour) * 60;

_date set [3, _startHour];
_date set [4, _startMinute];

setDate _date;

// Alive initialization
[] execVM "alive\CustomFactions.sqf";
[] execVM "alive\Tasks.sqf";
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
