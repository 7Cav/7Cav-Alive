[_this select 0, {	
	[(_this select 0)] remoteExec ["CLIENT_InitializeVehicleModule", 0, true];
	[[(_this select 0)]] call SERVER_CurateEditableObjects;
}] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 99999] call vehicle_fnc_respawnVehicleWhenAbandoned;