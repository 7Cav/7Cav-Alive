if (not hasInterface) exitWith {};

// Automatically close the briefing screen
if (isNumber (missionConfigFile >> "briefing") && { getNumber (missionConfigFile >> "briefing") == 1 }) then
{
	[] spawn
	{
		scriptName "CloseBriefingScreen";

		waitUntil
			{
				if (getClientState == "BRIEFING READ") exitWith { true };
				if (not isNull findDisplay 53) exitWith
				{
					ctrlActivate (findDisplay 53 displayCtrl 1);
					findDisplay 53 closeDisplay 1;
					true
				};
				false
			};
	};
};

// Action (scroll wheel) override framework
#include "..\scripts\client\overrideAction.sqf";

// Curator (Zeus) assignment and permissions framework
#include "..\scripts\client\curator.sqf";

// Vehicle permissions framework
#include "..\scripts\client\vehiclePermissions.sqf";

// Logistics framework
#include "..\scripts\client\logistics\ammoModule.sqf";
#include "..\scripts\client\logistics\logisticsLoading.sqf";
#include "..\scripts\client\logistics\logisticsModules.sqf";
#include "..\scripts\client\logistics\personnelModule.sqf";
#include "..\scripts\client\logistics\supplyModule.sqf";
#include "..\scripts\client\logistics\vehicleModule.sqf";

// Ammo box types
#include "..\scripts\client\ammoBoxList.sqf";

// Commands
#include "..\scripts\client\chatCommands.sqf";

// Database connectors
#include "..\scripts\client\database.sqf"