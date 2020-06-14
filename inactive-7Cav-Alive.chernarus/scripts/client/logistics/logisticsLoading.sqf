CLIENT_LoadingVehicles = [
	["Truck_01_flatbed_base_F", [0,-1.9,0.5]],
	["rhsusf_M1083A1P2_B_fmtv_usarmy", [0,-1.6,0.5]]
];

CLIENT_LoadCrate = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate"];

	private _cargoVehicles = nearestObjects [player, CLIENT_LoadingVehicles apply { _x select 0}, 10];
	private _targetVehicle = nil;
	
	{
		if (!(_x getVariable  ['LOGI_hasCrateLoaded', false])) exitWith {
			_targetVehicle = _x;
		}
	} forEach _cargoVehicles;

	_loadConfiguration = (CLIENT_LoadingVehicles select { (typeof _targetVehicle) isKindOf [_x select 0, configFile >> "CfgVehicles"]; }) select 0 select 1;
	_crate attachTo [_targetVehicle, _loadConfiguration];
	_crate setVariable ['LOGI_isLoaded', true, true];
	_targetVehicle setVariable ['LOGI_hasCrateLoaded', true, true];
};

CLIENT_PlaceUnloadedCrate = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_targetVehicle", "_unloadPosition"];
	
	detach _crate;
	_crate setPosASL _unloadPosition;
	_crate setVariable ['LOGI_isLoaded', false, true];
	_targetVehicle setVariable ['LOGI_hasCrateLoaded', false, true];
	
	[_crate] spawn { sleep 2; (_this select 0) setDamage 0 };
};

CLIENT_UnloadCrate = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate"];

	[[_crate, player], { (_this select 0) setOwner owner (_this select 1) }] remoteExec ["call", 2];

	private _targetVehicle = attachedTo _crate;
	private _unloadPosition = (_targetVehicle getPos [-8.5, (getDir _crate)]);
	_unloadPosition = [_unloadPosition select 0, _unloadPosition select 1, (getPosASL _targetVehicle select 2) + 1];

	private _tempCrate = (typeOf _crate) createVehicleLocal [0,0,0];
	_tempCrate enableSimulation false;
	_tempCrate setPosASL _unloadPosition;
	_tempCrate setDir (getDir _crate);

	acex_fortify_isPlacing = -1;

	["Confirm unload location", "Cancel"] call ace_interaction_fnc_showMouseHint;
	private _confirmActionId = player addAction [
		'', 
		{acex_fortify_isPlacing = 1},
		nil,
		-1,
		false,
		true,
		'DefaultAction',
		'acex_fortify_isPlacing != 1'
	];

	[{
		params ["_args", "_pfID"];
		_args params ["_unit", "_tempCrate", "_crate", "_targetVehicle", "_unloadPosition", "_confirmActionId"];

		if (acex_fortify_isPlacing != -1) exitWith {
			[_pfID] call CBA_fnc_removePerFrameHandler;
			[] call ace_interaction_fnc_hideMouseHint;
			deleteVehicle _tempCrate;

			_unit removeAction _confirmActionId;

			if (acex_fortify_isPlacing == 1) then {
				acex_fortify_isPlacing = -1;
				[5, [_crate, _targetVehicle, _unloadPosition], CLIENT_PlaceUnloadedCrate, {}, "Unloading crate from truck"] call ace_common_fnc_progressBar;
			};
		};

	}, 0, [player, _tempCrate, _crate, _targetVehicle, _unloadPosition, _confirmActionId]] call CBA_fnc_addPerFrameHandler;
};

CLIENT_CanLoadCrate = 
{
	params ["_crate"];
	
	private _canLoad = vehicle player == player;
	_canLoad = _canLoad && call CLIENT_PlayerCanUse;
	_canLoad = _canLoad && alive _crate;
	_canLoad = _canLoad && !(_crate getVariable ['LOGI_isModuleActivated', false]);
	_canLoad = _canLoad && isNull attachedTo _crate; 
	private _targetVehicle = nil;
	
	{
		if (!(_x getVariable ['LOGI_hasCrateLoaded', false])) exitWith {
			_targetVehicle = _x;
		}
	} forEach (nearestObjects[player, CLIENT_LoadingVehicles apply { _x select 0}, 10]);

	_canLoad = _canLoad && !(isNull _targetVehicle);
	_canLoad
};

CLIENT_CanUnloadCrate = 
{
	params ["_crate"];
	
	private _canUnload = vehicle player == player;
	_canUnload = _canUnload && call CLIENT_PlayerCanUse;
	_canUnload = _canUnload && _crate getVariable ['LOGI_isLoaded', false];
	_canUnload
};

CLIENT_AddLoadCrateAction = 
{
	params ["_crate"];
	
	_crate addAction [
		'    > Load Object',
		{[5, _this, CLIENT_LoadCrate, {}, "Loading crate onto truck"] call ace_common_fnc_progressBar},  
		[], 
		19 , 
		true, 
		true, 
		'', 
		'[_target] call CLIENT_CanLoadCrate'	
	]
};

CLIENT_AddUnloadCrateAction =  
{ 
	params ["_crate"]; 

	_crate addAction [ 
		'    > Unload Object', 
		CLIENT_UnloadCrate,  
		[], 
		19 , 
		true, 
		true, 
		'', 
		"[_target] call CLIENT_CanUnloadCrate" 
	] 
};