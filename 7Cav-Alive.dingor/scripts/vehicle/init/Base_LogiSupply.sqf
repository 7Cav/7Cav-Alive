[_this select 0, {	
	[(_this select 0)] remoteExec ["CLIENT_InitializeSupplyModule", 0, true];
	[[(_this select 0)]] call SERVER_CurateEditableObjects;
}] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 420] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 50, 900] call vehicle_fnc_respawnVehicleWhenAbandoned;