if (not isServer && hasInterface) exitWith {};

#include "..\scripts\server\baseCleanup.sqf" //Includes the baseCleanup script so everything can reference it 

missionNamespace setVariable["endMissionNumber",0]; //Variable init for missionEnd scripts located in scripts/missionEnd

// Alive initialization
[] execVM "alive\CustomFactions.sqf";
[] execVM "alive\Tasks.sqf";

//Curator execution
[] execVM "scripts\server\curator.sqf";