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

[] execVM "scripts\client\curator.sqf";