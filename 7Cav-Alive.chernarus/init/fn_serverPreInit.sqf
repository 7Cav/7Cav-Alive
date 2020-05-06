if (not isServer && hasInterface) exitWith {};

#include "..\scripts\server\baseCleanup.sqf" //Includes the baseCleanup script so everything can reference it 

// Need a few functions from the client code for logistics
#include "..\scripts\client\logistics\logisticsModules.sqf";
#include "..\scripts\server\logistics\personnelModule.sqf";

// Chat commands
#include "..\scripts\server\chatCommands.sqf";

//Curator execution
[] execVM "scripts\server\curator.sqf";
