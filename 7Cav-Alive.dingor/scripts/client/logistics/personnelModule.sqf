CLIENT_LogisticMobileSpawnEnemyRadius = 300;
CLIENT_LogisticMobileSpawnCost = 50;

CLIENT_EnableMobileSpawn = 
{
	params ["_crate"];
	private _location = getPosASL _crate;

	private _enemies = _location nearEntities ["Man", CLIENT_LogisticMobileSpawnEnemyRadius];
	_enemies = _enemies select { side _x == east || side _x == independent };

	if (count _enemies > 0) exitWith { 
		hint ('Enemies within ' + str CLIENT_LogisticMobileSpawnEnemyRadius + 'm, cannot enable mobile spawn!');
		[_crate, '', '', ['personnel_skip_callback'] ] call BOTH_DeactivateModule;
	};

	[_crate] remoteExec ["SERVER_InitPersonnelTrigger"];
	[_crate] remoteExec ["SERVER_InitEnemyAttack"];
};

CLIENT_DisableMobileSpawn = 
{
	params [["_reason", "", [""]]];
	[_reason] remoteExec ["SERVER_DisableMobileSpawn"];
};

CLIENT_CanTeleportToFob = 
{
	!(isNil "LOGISTICS_MOBILE_SPAWN")
};

CLIENT_TeleportToFob = 
{
	params ["_teleporter", "_caller", "_actionId", "_arguments"];
	_caller setPos (getPos LOGISTICS_MOBILE_SPAWN vectorAdd (boundingBoxReal LOGISTICS_MOBILE_SPAWN select 0));
	[west, -50, true] call acex_fortify_fnc_updateBudget;
};

CLIENT_InitializePersonnelTeleporter = 
{
	params ["_teleporter"];

	_teleporter addAction [ 
		'Teleport to FOB', 
		CLIENT_TeleportToFob, 
		[], 
		1, 
		true, 
		true, 
		'', 
		"[] call CLIENT_CanTeleportToFob && [CLIENT_LogisticMobileSpawnCost] call CLIENT_FobHasEnoughSupply" 
	];

	_teleporter addAction [ 
		'FOB teleport not available', 
		{}, 
		[], 
		1, 
		true, 
		true, 
		'', 
		"!([] call CLIENT_CanTeleportToFob)" 
	];

	_teleporter addAction [ 
		'Insufficient FOB supply points to teleport', 
		{}, 
		[], 
		1, 
		true, 
		true, 
		'', 
		"([] call CLIENT_CanTeleportToFob) && !([CLIENT_LogisticMobileSpawnCost] call CLIENT_FobHasEnoughSupply)" 
	];
};

CLIENT_InitializePersonnelModule = 
{
	params ["_crate"];
	if (isNull _crate) exitWith {};

	[_crate, "Logistics Personnel Module"] call CLIENT_AddModuleTitleAction;

	private _type = "personnel";
	[_crate, _type] call CLIENT_AddActivateModuleAction;
	[_crate, _type] call CLIENT_AddDeactivateModuleAction;

	[_crate] call CLIENT_AddLoadCrateAction;
	[_crate] call CLIENT_AddUnloadCrateAction;
};a