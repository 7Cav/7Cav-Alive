if (not isServer && hasInterface) exitWith {};

#include "\serverscripts\zeusserverscripts\secretKey.sqf" //Includes the zeus security key.sqf so we can reference it for zeus IDs
#include "..\scripts\server\baseCleanup.sqf" //Includes the baseCleanup script so everything can reference it 

missionNamespace setVariable["LOYALTY_CIPHER", CIPHERSECRETKEY, true]; //variable init for loyalty cipher
missionNamespace setVariable["endMissionNumber",0]; //Variable init for missionEnd scripts located in scripts/missionEnd

[] execVM "scripts\server\curator.sqf";

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