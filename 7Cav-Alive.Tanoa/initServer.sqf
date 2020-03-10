diag_log "initServer start";

#include "\serverscripts\zeusserverscripts\secretKey.sqf"
missionNamespace setVariable["LOYALTY_CIPHER", CIPHERSECRETKEY, true];
missionNamespace setVariable["endMissionNumber",0]; //Variable init for missionEnd scripts located in scripts/missionEnd

// _null = [] execVM "scripts\sessionTimeMessagesInit.sqf";

// Disable RHS engine start up so vehicles move immediately when spawned
RHS_ENGINE_STARTUP_OFF = 1;

// Increase ACE max carry and drag weights
ACE_maxWeightCarry = 750;
ACE_maxWeightDrag = 1000;

// Make sure armed civilians won't attack NATO
civilian setFriend [west, 1];
// Make sure AAF won't attack CSAT
independent setFriend [east, 1];
east setFriend [independent, 1];
// Make sure AAF will attack NATO
independent setFriend [west, 0];

//BUG: Fool BIS_fnc_drawMinefields into believing that it's already running.  This turns off the automatic display of minefields on the map.  The difficulty setting in the server configuration file doesn't seem to work.
bis_fnc_drawMinefields_active = true;

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

// BEGIN TASKS
[ //TERMINAL 1 ( Term1 )
  BLUFOR, //Group (can be boolean)
  "Deactivate the Airfield!", //Task ID
  [ //task description, title, marker
    "Deactivate the satellite to prevent the enemy air commander from being able to call in air strikes!", //Task description
    "Deactivate the Airfield!", //Task Title
    "Term1" //Task location
  ],
  Term1, //Object that the task will be put onto
  "CREATED", //Task State
  0, //Priority (goes in priority from high to low, 10 being higher tan 9 and so on)
  true, //Show notification
  "destroy", //Type (string)
  false //Visible in 3d space
] call BIS_fnc_taskCreate;

[ //TERMINAL 2 ( Term2 )
  BLUFOR, //Group (can be boolean)
  "Deactivate the Armored Corps!", //Task ID
  [ //task description, title, marker
    "Deactivate the satellite to prevent the enemy armored commander from being able to call in armored support!", //Task description
    "Deactivate the Armored Corps!", //Task Title
    "Term2" //Task location
  ],
  Term2, //Object that the task will be put onto
  "CREATED", //Task State
  0, //Priority (goes in priority from high to low, 10 being higher tan 9 and so on)
  true, //Show notification
  "destroy", //Type (string)
  false //Visible in 3d space
] call BIS_fnc_taskCreate;

[ //TERMINAL 3 ( Term3 )
  BLUFOR, //Group (can be boolean)
  "Deactivate the Mechanized Corps!", //Task ID
  [ //task description, title, marker
    "Deactivate the satellite to prevent the enemy mechanized infantry commander from being able to call in mechanized infantry support!", //Task description
    "Deactivate the Mechanized Corps!", //Task Title
    "Term3" //Task location
  ],
  Term3, //Object that the task will be put onto
  "CREATED", //Task State
  0, //Priority (goes in priority from high to low, 10 being higher tan 9 and so on)
  true, //Show notification
  "destroy", //Type (string)
  false //Visible in 3d space
] call BIS_fnc_taskCreate;

[ //TERMINAL 4 ( Term4 )
  BLUFOR, //Group (can be boolean)
  "Deactivate the Specops headquarters!", //Task ID
  [ //task description, title, marker
    "Deactivate the satellite to prevent the enemy special operations commander from being able to sabotage our efforts!", //Task description
    "Deactivate the Specops headquarters!", //Task Title
    "Term4" //Task location
  ],
  Term4, //Object that the task will be put onto
  "CREATED", //Task State
  0, //Priority (goes in priority from high to low, 10 being higher tan 9 and so on)
  true, //Show notification
  "destroy", //Type (string)
  false //Visible in 3d space
] call BIS_fnc_taskCreate;

//ALiVE headless
if (!hasInterface && !isDedicated) then {
headlessClients = [];
headlessClients set [(count headlessClients), player];
publicVariable "headlessClients";
isHC = true;
};

diag_log "initServer end";
