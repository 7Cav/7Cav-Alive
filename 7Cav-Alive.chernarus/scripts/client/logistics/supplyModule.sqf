CLIENT_AddSupply = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate"];

	if (!([_crate] call CLIENT_CanRedeemSupply)) exitWith { hint 'Cannot redeem supply in base or far away from FOB truck.'};

	_crate setPos [0, 0, 0];
	_crate setDamage 1;
	[west, 750, true] call acex_fortify_fnc_updateBudget;
};

CLIENT_CanRedeemSupply = 
{
	params ["_crate"];

	!(_crate inArea headquarters) && 
	{ player == vehicle player } &&
	{
		private _nearFOB = acex_fortify_locations isEqualTo [];
		{
			if (_crate inArea _x) exitWith {_nearFOB = true};
		} forEach acex_fortify_locations;
		_nearFOB
	}
};

CLIENT_InitializeSupplyModule = 
{
	params ["_crate"];
	if (isNull _crate) exitWith {};

	[_crate, "Logistics Supply Crate (750pts)"] call CLIENT_AddModuleTitleAction;

	[_crate] call CLIENT_AddLoadCrateAction;
	[_crate] call CLIENT_AddUnloadCrateAction;

	_crate addAction [ 
		'    > Redeem Supply', 
		{[5, _this, CLIENT_AddSupply, {}, "Collecting supplies from crate"] call ace_common_fnc_progressBar},  
		[], 
		18 , 
		true, 
		true, 
		"", 
		"[_target, 'supply'] call CLIENT_CanActivateResource" 
	] 
};