CLIENT_PlayerCanUse = 
{
	player getVariable ["TAC2_canFortify", false]
};

CLIENT_FobHasEnoughSupply = 
{
	params ["_amount"];
	([west] call acex_fortify_fnc_getBudget) >= _amount
};

BOTH_ActivateModule = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_caller", "_actionId", "_arguments"];
	_arguments params ["_type"];

	private _nearFOB = acex_fortify_locations isEqualTo [];
	{
		if (_crate inArea _x) exitWith {_nearFOB = true};
	} forEach acex_fortify_locations;
	if (!_nearFob) exitWith { hint 'Modules can only be activated near a FOB.' };

	if (_type == "vehicle") then { _crate setVariable ['LOGI_isModuleActivated', true, true] };
	if (_type == "ammo") then { _crate setVariable ['LOGI_isModuleActivated', true, true] };
	if (_type == "personnel") then { _crate setVariable ['LOGI_isModuleActivated', true, true]; [_crate] call CLIENT_EnableMobileSpawn };


	[_crate, false] remoteExec ["enableSimulationGlobal", 2];
};

BOTH_DeactivateModule = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_caller", "_actionId", "_arguments"];
	_arguments params ["_type"];

	_crate setVariable ['LOGI_isModuleActivated', false, true];
	[_crate, true] remoteExec ["enableSimulationGlobal", 2];

	if (_type == "personnel") then { [] call CLIENT_DisableMobileSpawn };
};

CLIENT_CanActivateResource = 
{
	params ['_crate', '_type'];
	private _canActivate = true;
	_canActivate = _canActivate && call CLIENT_PlayerCanUse;
	_canActivate = _canActivate && alive _crate;
	_canActivate = _canActivate && player == vehicle player;
	_canActivate = _canActivate && !(_crate getVariable ['LOGI_isModuleActivated', false]);
	_canActivate = _canActivate && !(_crate getVariable ['LOGI_isLoaded', false]);
	_canActivate	 
};

CLIENT_CanDeactivateResource = 
{
	params ['_crate', '_type'];
	private _canDeactivate = true;
	_canDeactivate = _canDeactivate && call CLIENT_PlayerCanUse;
	_canDeactivate = _canDeactivate && player == vehicle player;
	_canDeactivate = _canDeactivate && (_crate getVariable ['LOGI_isModuleActivated', false]);
	_canDeactivate = _canDeactivate && !(_crate getVariable ['LOGI_isLoaded', false]);
	_canDeactivate
};

CLIENT_AddModuleTitleAction =
{
	params ["_crate", "_title"];
	_crate addAction [
		"<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa'/><t font='PuristaBold'>" + _title + "</t>",
		{},
		[],
		20
	];
};

CLIENT_AddActivateModuleAction =  
{ 
	params ["_crate", "_type"]; 

	_crate addAction [ 
		'    > Unpack Resource', 
		{[5, _this, BOTH_ActivateModule, {}, "Unpacking crate"] call ace_common_fnc_progressBar}, 
		[_type], 
		19 , 
		true, 
		true, 
		'', 
		"[_target, '" + _type + "'] call CLIENT_CanActivateResource" 
	] 
};

CLIENT_AddDeactivateModuleAction =  
{ 
	params ["_crate", "_type"]; 

	_crate addAction [ 
		'    > Pack Up Resource',
		{[5, _this, BOTH_DeactivateModule, {}, "Packing up crate"] call ace_common_fnc_progressBar},  
		[_type], 
		18 , 
		true, 
		true, 
		'', 
		"[_target, '" + _type + "'] call CLIENT_CanDeactivateResource" 
	] 
};