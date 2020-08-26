if (not isServer && hasInterface) exitWith {};

#include "..\scripts\server\baseCleanup.sqf" //Includes the baseCleanup script so everything can reference it 

// Need a few functions from the client code for logistics
#include "..\scripts\client\logistics\logisticsModules.sqf";
#include "..\scripts\server\logistics\personnelModule.sqf";

// Chat commands
#include "..\scripts\server\chatCommands.sqf";

// Curator execution
[] execVM "scripts\server\curator.sqf";

// Database connectors
#include "..\scripts\server\database\database.sqf"
#include "..\scripts\server\database\player.sqf"

// Database drivers
[] call compile preprocessFileLineNumbers "lib\extdb3\oo_extdb3.sqf";
EXTDB3 = "new" call OO_EXTDB3;
["setIniSectionDatabase", "Database"] call EXTDB3;
["setDatabaseName", "7cav_arma3_tact2"] call EXTDB3;
["setQueryType", "SQL"] call EXTDB3;
"connect" call EXTDB3;
