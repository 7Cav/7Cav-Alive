if (not isServer) exitWith {};

(_this select 0) setCaptive true;
[[_this select 0]] call SERVER_CurateEditableObjects;
(_this select 0) addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1 }];
[_this select 0, SERVER_Tracking_AirWithin1000] call JB_fnc_restrictedTargeting;
