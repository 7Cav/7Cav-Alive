[_this select 0,
	{
		(_this select 0) setvariable ["ace_medical_isMedicalFacility", true, true];
	}
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 600] call JB_fnc_respawnVehicleWhenAbandoned;
