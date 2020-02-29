if (not isServer && hasInterface) exitWith {};

#include "..\scripts\server\baseCleanup.sqf" //Includes the baseCleanup script so everything can reference it 

//Curator execution
[] execVM "scripts\server\curator.sqf";