CLIENT_LogiVehicles = [
	["B_Quadbike_01_F", 200, "", {}, {}],
	["rhsusf_mrzr4_d", 300, "", {}, {}],
	["rhsusf_m998_d_2dr", 300, "", {}, {}],
	["rhsusf_m1025_d_m2", 500, "", {}, {}],
	["rhsusf_m1240a1_m240_usarmy_d", 800, "", {}, {}],
	["RHS_M119_D", 500, "", {}, {}],
	["I_HMG_02_high_F", 150, "", {}, {}]
];

CLIENT_LogiSpawnVehicle = 
{
	params ["_addActionParams"];
	_addActionParams params ["_crate", "_caller", "_actionId", "_arguments"];
	_arguments params ["_vehicleClass", "_cost"];

	if (!([_cost] call CLIENT_FobHasEnoughSupply)) exitWith { hint 'Insufficient supply points to spawn this vehicle' };

	private _spawnLocation = (getPos _crate) findEmptyPosition [5, 50, _vehicleClass];
	private _vehicle = createVehicle [ _vehicleClass, _spawnLocation, [], 0,""];

	_caller setDir (_caller getDir _spawnLocation);
	[west, -(_cost), true] call acex_fortify_fnc_updateBudget;
};

CLIENT_CanSpawnVehicle = 
{
	params ["_crate"];
	private _canSpawn =  vehicle player == player;
	_canSpawn = _canSpawn && call CLIENT_PlayerCanUse;
	_canSpawn = _canSpawn && _crate getVariable ['LOGI_isModuleActivated', false];
	_canSpawn
};


CLIENT_InitializeVehicleModule = 
{
	params ["_crate"];
	if (isNull _crate) exitWith {};

	[_crate, "Logistics Vehicle Module"] call CLIENT_AddModuleTitleAction;

	private _type = "ammo";
	[_crate, _type] call CLIENT_AddActivateModuleAction;
	[_crate, _type] call CLIENT_AddDeactivateModuleAction;

	[_crate] call CLIENT_AddLoadCrateAction;
	[_crate] call CLIENT_AddUnloadCrateAction;

	{
		_x params ["_vehicleClass", "_cost"];
		_crate addAction [ 
			'    > Spawn ' + (getText(configFile >> "cfgVehicles" >> _vehicleClass >> "displayName") + " (" + str _cost + "pts)"), 
			{[5, _this, CLIENT_LogiSpawnVehicle, {}, "Requisitioning vehicle"] call ace_common_fnc_progressBar},  
			[_vehicleClass, _cost], 
			18 , 
			true, 
			true, 
			'', 
			"[_target] call CLIENT_CanSpawnVehicle" 
		] 
	} forEach CLIENT_LogiVehicles;
};