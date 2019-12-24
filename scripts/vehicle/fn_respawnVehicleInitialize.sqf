/*
Author: JB

[vehicle, vehicleInit] call vehicle_fnc_respawnVehicleInitialize

Set up a vehicle for respawn

_null = [MyVehicle, { MyVehicle engineOn true }] call vehicle_fnc_respawnVehicleInitialize;

vehicle			- the vehicle to be respawned (required)
vehicleInit		- the script which is executed whenever the vehicle is created. (optional)

				  vehicleInit is called by this function as part of respawn initialization:

						[newVehicle, oldVehicle] call vehicleInit;
*/

if (!isServer) exitWith {};

#define DEFAULT_VEHICLEINIT nil

private _vehicle = param [0, objNull, [objNull]];
private _vehicleInit = param [1, DEFAULT_VEHICLEINIT, [{}]];

diag_log format ["RespawnVehicleInitialize: %1", typeOf _vehicle];

[_vehicle] call SERVER_InitializeObject;

private _animationSources = ("getText (_x >> 'source') == 'user'" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "AnimationSources")) apply { [configName _x, _vehicle animationPhase configName _x] };

_state = [];
_state set [JB_RV_STATE_POSITION, getPosASL _vehicle];
_state set [JB_RV_STATE_DIRECTION, getDir _vehicle];
_state set [JB_RV_STATE_PYLONMAGAZINES, getPylonMagazines _vehicle];
_state set [JB_RV_STATE_TEXTURES, getObjectTextures _vehicle];
_state set [JB_RV_STATE_ANIMATIONSOURCES, _animationSources];

_vehicle setVariable ["JB_RV_State", _state];

if (!isNil "_vehicleInit") then
{
	[_vehicle, "JB_RV_Initializer", _vehicleInit] call JB_RV_SetInitializer;
	[_vehicle, objNull] call _vehicleInit;
};

[_vehicle] spawn JB_RV_Monitor;
