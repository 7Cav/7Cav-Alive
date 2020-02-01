(_this select 0) allowDamage false;
(_this select 0) setVariable ["AT_DONOTTOW", true, true];
(_this select 0) setVariable ["ASL_DONOTSLING", true, true];
(_this select 0) addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1 }];

// Only shoot at armed aircraft
_this spawn
{
	params ["_vehicle"];

	scriptName "spawnBase_Cheetah_Static";

	while { alive _vehicle } do
	{
		{
			if (not ((vehicle _x) isKindOf "Air") || { not ([vehicle _x] call SPM_Util_HasOffensiveWeapons) }) then
			{
				_vehicle forgetTarget _x;
			};
		} forEach (effectiveCommander _vehicle targets [true]);

		sleep 0.5;
	};
};