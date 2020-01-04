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