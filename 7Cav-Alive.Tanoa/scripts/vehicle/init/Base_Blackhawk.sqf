[_this select 0,
	{
		(_this select 0) setvariable ["ace_medical_isMedicalVehicle", true, true];
		[_this select 0] call ace_fastroping_fnc_equipFRIES;
	}
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 300] call vehicle_fnc_respawnVehicleWhenAbandoned;
