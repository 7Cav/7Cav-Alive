CLIENT_SpawnSupplyBox =
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_caller", "_actionId", "_arguments"];
	_arguments params ["_type"];

	if (!([100] call CLIENT_FobHasEnoughSupply)) exitWith { hint 'Insufficient supply points to spawn this ammo box' };

	private _position = (getPos _crate) findEmptyPosition [5, 50];
	_caller setDir (_caller getDir _position);
	[west, -100, true] call acex_fortify_fnc_updateBudget;

	if (_type == 'medical') exitWith { [_position] call CLIENT_SpawnMedicalBox };
	if (_type == 'at') exitWith { [_position] call CLIENT_SpawnAtBox };
	if (_type == 'ammo') exitWith { [_position] call CLIENT_SpawnAmmoBox };
	if (_type == 'javelin') exitWith { [_position] call CLIENT_SpawnJavelinBox };
	if (_type == 'night') exitWith { [_position] call CLIENT_SpawnNightBox };
};

CLIENT_CanSpawnAmmo = 
{
	params ["_crate"];
	private _canSpawn =  vehicle player == player;
	_canSpawn = _canSpawn && call CLIENT_PlayerCanUse;
	_canSpawn = _canSpawn && _crate getVariable ['LOGI_isModuleActivated', false];
	_canSpawn
};

CLIENT_InitializeAmmoModule = 
{
	params ["_crate"];
	if (isNull _crate) exitWith {};

	[_crate, "Logistics Ammo Module"] call CLIENT_AddModuleTitleAction;
	
	private _type = "ammo";
	[_crate, _type] call CLIENT_AddActivateModuleAction;
	[_crate, _type] call CLIENT_AddDeactivateModuleAction;

	[_crate] call CLIENT_AddLoadCrateAction;
	[_crate] call CLIENT_AddUnloadCrateAction;

	private _ammoboxTypes = [
		[format ["Spawn Medical Crate (100pts)"], 'medical'],
		[format ["Spawn AT Crate (100pts)"], 'at'],
		[format ["Spawn Ammo Crate (100pts)"], 'ammo'],
		[format ["Spawn Javelin Crate (100pts)"], 'javelin'],
		[format ["Spawn Night Supply Crate (100pts)"], 'night']
	];

	{
		_crate addAction [
			'    > ' + (_x select 0),
			{[5, _this, CLIENT_SpawnSupplyBox, {}, "Requisitioning ammo supplies"] call ace_common_fnc_progressBar},
			[_x select 1],
			18,
			true,
			true,
			"",
			"[_target] call CLIENT_CanSpawnAmmo" 
		];
	} forEach _ammoboxTypes;
};