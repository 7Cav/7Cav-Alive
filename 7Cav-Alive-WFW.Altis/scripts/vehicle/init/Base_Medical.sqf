[_this select 0,
	{
		(_this select 0) setvariable ["ace_medical_isMedicalFacility", true, true];
	}
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 600] call vehicle_fnc_respawnVehicleWhenAbandoned;
