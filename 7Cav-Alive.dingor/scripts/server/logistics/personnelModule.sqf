SERVER_LogisticMobileSpawnEnemyRadius = 300;

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

SERVER_FOB_POSITION = [0,0,0];

SERVER_InitEnemyAttack =
{
	params ["_crate"];

	if ( not call SERVER_FOBAttackEnabled ) exitWith {};

	private _cratePosition = getPos _crate;
	if ((_cratePosition distance2D SERVER_FOB_POSITION) < 500) exitWith {};

	SERVER_FOB_POSITION = _cratePosition;

	[_crate] spawn {
		params ["_crate"];
		sleep 600;

		if (getPos _crate isEqualTo SERVER_FOB_POSITION && { not call SERVER_EnemyObjectiveInitialized }) then {
			[SERVER_FOB_POSITION] call SERVER_CreateEnemyAttack;
		} else {
			call SERVER_DisableEnemyAttack;
			[SERVER_FOB_POSITION] call SERVER_CreateEnemyAttack;
		};
	}
};

SERVER_FOBAttackEnabled =
{
	(['settings', str 'fob.enemy_attacks'] call SERVER_DB_SelectFirst) select 1;
};

SERVER_FOBAttackPriority =
{
	(['settings', str 'fob.enemy_attacks.priority'] call SERVER_DB_SelectFirst) select 1;
};

SERVER_FOBAttackSize =
{
	(['settings', str 'fob.enemy_attacks.size'] call SERVER_DB_SelectFirst) select 1;
};

SERVER_EnemyObjectiveInitialized = 
{
	count (([OPCOM_INSTANCES select 0,"objectives"] call ALiVE_fnc_HashGet) apply { [_x, 'objectiveID'] call ALiVE_fnc_HashGet } select { _x find "OPCOM_custom_FOB" >= 0 }) > 0
};

SERVER_CreateEnemyAttack = 
{
	params ["_pos"];
	[OPCOM_INSTANCES select 0,"addObjective", ["OPCOM_custom_FOB", _pos, call SERVER_FOBAttackSize, "MIL", call SERVER_FOBAttackPriority]] call ALiVE_fnc_OPCOM;
};

SERVER_DisableEnemyAttack = 
{
	[OPCOM_INSTANCES select 0,"removeObjective", "OPCOM_custom_FOB" ] call ALiVE_fnc_OPCOM;
};
