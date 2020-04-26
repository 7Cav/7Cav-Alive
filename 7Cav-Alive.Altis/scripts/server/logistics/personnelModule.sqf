SERVER_LogisticMobileSpawnEnemyRadius = 500;

SERVER_InitPersonnelTrigger = 
{
	params ["_crate"];
	private _location = getPosASL _crate;

	missionNamespace setVariable["LOGISTICS_MOBILE_SPAWN", _crate, true];
	'Mobile spawn enabled.' remoteExec ["hint"];

	if (!isNil 'LOGISTICS_MOBILE_SPAWN_TRIGGER_EAST') then {
		deleteVehicle LOGISTICS_MOBILE_SPAWN_TRIGGER_EAST;
	};

	if (!isNil 'LOGISTICS_MOBILE_SPAWN_TRIGGER_INDP') then {
		deleteVehicle LOGISTICS_MOBILE_SPAWN_TRIGGER_INDP;
	};

	private _triggerEast = createTrigger ["EmptyDetector", _location];
	_triggerEast setTriggerArea [SERVER_LogisticMobileSpawnEnemyRadius, SERVER_LogisticMobileSpawnEnemyRadius, 0, false];
	_triggerEast setTriggerActivation ["EAST", "PRESENT", true];
	_triggerEast setTriggerStatements ["this", "[] call CLIENT_EnemyTriggerStart", "[] call CLIENT_EnemyTriggerStop"];
	missionNamespace setVariable["LOGISTICS_MOBILE_SPAWN_TRIGGER_EAST", _triggerEast, true];

	private _triggerIndp = createTrigger ["EmptyDetector", _location];
	_triggerIndp setTriggerArea [SERVER_LogisticMobileSpawnEnemyRadius, SERVER_LogisticMobileSpawnEnemyRadius, 0, false];
	_triggerIndp setTriggerActivation ["GUER", "PRESENT", true];
	_triggerIndp setTriggerStatements ["this", "[] call CLIENT_EnemyTriggerStart", "[] call CLIENT_EnemyTriggerStop"];
	missionNamespace setVariable["LOGISTICS_MOBILE_SPAWN_TRIGGER_INDP", _triggerIndp, true];
};

CLIENT_EnemyTriggerStart = { ['Enemies within ' + str SERVER_LogisticMobileSpawnEnemyRadius + 'm of FOB, mobile spawn disabled!'] call SERVER_DisableMobileSpawn; };
CLIENT_EnemyTriggerStop = { 'FOB enemy presence clear. Manual intervention of FOB Personnel Module required to renable mobile spawning.' remoteExec ["hint"]; };

SERVER_DisableMobileSpawn = 
{
	params [["_reason", "", [""]]];
	if (isNil "LOGISTICS_MOBILE_SPAWN") exitWith {};

	[LOGISTICS_MOBILE_SPAWN, '', '', ['personnel_skip_callback'] ] call BOTH_DeactivateModule;
	missionNamespace setVariable["LOGISTICS_MOBILE_SPAWN", nil, true];

	if (count _reason > 0) then {
		_reason remoteExec ["hint"];
	} else {
		'Mobile spawn disabled.' remoteExec ["hint"];
	};
};