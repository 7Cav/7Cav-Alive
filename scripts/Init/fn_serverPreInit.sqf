#include "..\SPM\strongpoint.h"
#include "..\OP\op.h"

SERVER_Magazines_TitanToRPG =
[
	["Titan_AT", "RPG32_F"],
	["Titan_AP", "RPG32_HE_F"],
//	["Titan_AA", "RPG32_HE_F"],
	["NLAW_F", "RPG7_F"],
	["RPG32_HE_F", "RPG7_F"],
	["RPG32_F", "RPG7_F"]
];

SERVER_Magazines_TitanToMAAWS =
[
	["Titan_AT", "MRAWS_HEAT_F"],
	["Titan_AP", "MRAWS_HE_F"],
	["Titan_AA", "MRAWS_HE_F"],
	["NLAW_F", "MRAWS_HE_F"]
];

SERVER_Magazines_MAAWSToRPG =
[
	["MRAWS_HEAT_F", "RPG32_F"],
	["MRAWS_HE_F", "RPG32_HE_F"]
];

SERVER_Weapons_LauncherDowngrade =
[
	["launch_B_Titan_F", "launch_MRAWS_sand_F"],
	["launch_B_Titan_tna_F", "launch_MRAWS_sand_F"],
	["launch_B_Titan_short_F", "launch_MRAWS_sand_F"],
	["launch_B_Titan_short_tna_F", "launch_MRAWS_sand_F"],
	["launch_I_Titan_short_F", "launch_RPG32_F"],
	["launch_O_Titan_short_F", "launch_RPG32_F"],
	["launch_O_Titan_short_ghex_F", "launch_RPG32_F"],
	["launch_NLAW_F", ""],
	["launch_RPG32_F", "launch_RPG7_F"]
];

OO_TRACE_DECL(SERVER_C_AnnounceCurator) =
{
	params ["_curator", "_curatorType"];

	switch (_curatorType) do
	{
		case "MC":
		{
			systemchat format ["%1 has been assigned curator abilities (Mission Controller)", name _curator];
		};

		case "MP":
		{
			systemchat format ["%1 has been assigned curator abilities (Military Police)", name _curator];
		};

		case "CO":
		{
			systemchat format ["%1 has been assigned curator abilities (Camera Operator)", name _curator];
		};
	};
};

OO_TRACE_DECL(SPM_C_CuratorRequirementsNotMet) =
{
	params ["_requirements"];

	endMission "RestrictedRole";
};

// Thanks to lecks from the Bohemia forums for posting this

OO_TRACE_DECL(SERVER_C_DisableZeusWatermark) =
{
	[] spawn
	{
		scriptName "SERVER_C_DisableZeusWatermark";

		disableSerialization;

		private _display = displayNull;
		private _ctrl = controlNull;

		while {true} do
		{
			waitUntil { sleep 1; !isNull (findDisplay 312) };
			_display = (findDisplay 312);
			_ctrl = _display displayCtrl 15717;
			_ctrl ctrlSetText "";
			_ctrl ctrlCommit 0;
			waitUntil { sleep 1; isNull (findDisplay 312) };
		};
	};
};

OO_TRACE_DECL(SERVER_C_SetCuratorType) =
{
	params ["_curatorType"];

	CLIENT_CuratorType = _curatorType;

	switch (_curatorType) do
	{
		case "MC":
		{
			[] call SERVER_C_DisableZeusWatermark;

			addMissionEventHandler ["Draw3D", TRACE_DrawObjectValues];

			player createDiaryRecord ["diary", ["Mission controller",
				DOC_MissionController + "<br/>" +
				"Bindings:<br/><br/>" +
				DOC_ZeusBindings + "<br/>" +
				"Commands:<br/><br/>" +
				DOC_MissionControllerCommands + "<br/>" +
				DOC_MilitaryPoliceCommands
			]];

			[] call OP_fnc_initClient; // Turn on the on-the-fly Strongpoint stuff

			[] execVM "scripts\curatorUtilitiesInit.sqf";
		};

		case "MP":
		{
			[] call SERVER_C_DisableZeusWatermark;

			player createDiaryRecord ["diary", ["Military police",
				DOC_MilitaryPolice + "<br/>" +
				"Bindings:<br/><br/>" +
				DOC_ZeusBindings + "<br/>" +
				"Commands:<br/><br/>" +
				DOC_MilitaryPoliceCommands
			]];

			[] execVM "scripts\curatorUtilitiesInit.sqf";
		};

		case "CO":
		{
			[] call SERVER_C_DisableZeusWatermark;

			player createDiaryRecord ["diary", ["Camera operator",
				DOC_CameraOperator
			]];
		};
	};
};

if (not isServer && hasInterface) exitWith {};

SERVER_AllowEODCarry =
{
	params ["_player"];

	_player getUnitTrait "explosiveSpecialist"
};

SERVER_LightParaDrop =
[
	["B_supplyCrate_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"],
	["B_CargoNet_01_ammo_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"]
];

SERVER_HeavyParaDrop =
[
	["B_Slingload_01_Repair_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"],
	["B_Slingload_01_Medevac_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"],
	["B_Slingload_01_Fuel_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"]
];

SERVER_PodParaDrop =
[
	["Land_Pod_Heli_Transport_04_bench_F", "B_Parachute_02_F", 40, "B_IRStrobe", ""],
	["Land_Pod_Heli_Transport_04_covered_F", "B_Parachute_02_F", 40, "B_IRStrobe", ""],
	["Land_Pod_Heli_Transport_04_fuel_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"],
	["Land_Pod_Heli_Transport_04_medevac_F", "B_Parachute_02_F", 40, "B_IRStrobe", ""],
	["Land_Pod_Heli_Transport_04_repair_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"],
	["Land_Pod_Heli_Transport_04_box_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"],
	["Land_Pod_Heli_Transport_04_ammo_F", "B_Parachute_02_F", 40, "B_IRStrobe", "SmokeShellBlue"]
];

SERVER_Ammo_Vehicle =
[
	["200Rnd_65x39_Belt_Tracer_Red", 200],
	["200Rnd_762x51_Belt_T_Red", 200],
	["500Rnd_127x99_mag_Tracer_Red", 500],
	["200Rnd_127x99_mag_Tracer_Red", 200],
	["100Rnd_127x99_mag_Tracer_Red", 100],
	["130Rnd_338_Mag", 130],
	["140Rnd_30mm_MP_shells_Tracer_Red", 140],
	["60Rnd_30mm_APFSDS_shells_Tracer_Red", 60],
//	["680Rnd_35mm_AA_shells_Tracer_Red", 680],
	["24Rnd_120mm_APFSDS_shells_Tracer_Red", 24],
	["12Rnd_120mm_APFSDS_shells_Tracer_Red", 12],
	["12Rnd_120mm_HEAT_MP_T_Red", 12],
	["8Rnd_120mm_HEAT_MP_T_Red", 8],
	["4Rnd_120mm_LG_cannon_missiles", 4],
	["4Rnd_Titan_long_missiles", 4],
	["Laserbatteries", 2],
	["SmokeLauncherMag", 4]
];

SERVER_Ammo_Artillery =
[
	["32Rnd_155mm_Mo_shells", 32],
	["2Rnd_155mm_Mo_Cluster", 2],
	["2Rnd_155mm_Mo_LG", 2],
	["2Rnd_155mm_Mo_guided", 2],
	["6Rnd_155mm_Mo_smoke", 6],
	["Laserbatteries", 2],
	["SmokeLauncherMag", 4]
];

SERVER_Ammo_Aircraft =
[
	["2000Rnd_65x39_Belt_Tracer_Red", 2000],
	["1000Rnd_20mm_shells", 1000],
	["1000Rnd_Gatling_30mm_Plane_CAS_01_F", 1000],
	["500Rnd_Cannon_30mm_Plane_CAS_02_F", 500],
	["24Rnd_missiles", 24],
	["24Rnd_PG_missiles", 24],
	["2Rnd_GBU12_LGB", 2],
	["2Rnd_Missile_AA_03_F", 2],
	["4Rnd_AAA_missiles", 4],
	["4Rnd_Bomb_04_F", 4],
	["4Rnd_GAA_missiles", 4],
	["6Rnd_LG_scalpel", 6],
	["6Rnd_Missile_AGM_02_F", 6],
	["7Rnd_Rocket_04_AP_F", 7],
	["7Rnd_Rocket_04_HE_F", 7],
	["240Rnd_CMFlare_Chaff_Magazine", 240],
	["168Rnd_CMFlare_Chaff_Magazine", 168],
	["120Rnd_CMFlare_Chaff_Magazine", 120],
	["200Rnd_40mm_G_belt", 200],
	["SmokeLauncherMag", 2],
	["Laserbatteries", 2],
	["SmokeLauncherMag_boat", 2]
];

//IMPORTANT: A curator should be the very first object in the mission so that it gets initialized and its initializer can
// set the value of SERVER_CuratorMaster.
SERVER_CuratorMaster = objNull;
SERVER_MissionControllers = [];
SERVER_MilitaryPolice = [];
SERVER_CameraOperators = [];

OO_TRACE_DECL(SERVER_DeleteWeaponHolders) =
{
	params ["_center", "_a", "_b", "_angle", "_isRectangle", "_c"];

	{
		deleteVehicle _x;
	} forEach (nearestObjects [_center, ["WeaponHolder"], sqrt (_a*_a + _b*_b)]) inAreaArray [_center, _a, _b, _angle, _isRectangle, _c];
};

OO_TRACE_DECL(SERVER_DeleteDeadBodies) =
{
	params ["_center", "_a", "_b", "_angle", "_isRectangle", "_c"];

	{
		deleteVehicle _x;
	} forEach (allDeadMen inAreaArray [_center, _a, _b, _angle, _isRectangle, _c]);
};

OO_TRACE_DECL(SERVER_CurateEditableObjects) =
{
	params ["_objects"];

	if (not isServer) exitWith { [_objects] remoteExec ["SERVER_CurateEditableObjects", 2] };

	// If not using our curator scheme, then just add the objects to all known curators;
	if (isNull SERVER_CuratorMaster) exitWith
	{
		{
			_x addCuratorEditableObjects [_objects, false];
		} forEach allCurators;
	};

	SERVER_CuratorMaster addCuratorEditableObjects [_objects, false];
	{	
		_x addCuratorEditableObjects [_objects, false];
	} forEach SERVER_MissionControllers;
	{
		_x addCuratorEditableObjects [_objects select { isPlayer _x }, false];
	} forEach SERVER_MilitaryPolice;
};

OO_TRACE_DECL(SERVER_RemoteExecCurators) =
{
	params ["_parameters", "_command", ["_curatorTypes", ["MC","MP"], [[]]]];

	private _remoteExec =
	{
		params ["_parameters", "_command", "_curators"];

		{
			private _unit = getAssignedCuratorUnit _x;
			if (not isNull _unit) then
			{
				_parameters remoteExec [_command, _unit];
			};
		} forEach _curators;
	};

	if ("MC" in _curatorTypes) then
	{
		[_parameters, _command, SERVER_MissionControllers] call _remoteExec;
	};

	if ("MP" in _curatorTypes) then
	{
		[_parameters, _command, SERVER_MilitaryPolice] call _remoteExec;
	};

	if ("CO" in _curatorTypes) then
	{
		[_parameters, _command, SERVER_MilitaryPolice] call _remoteExec;
	};
};

OO_TRACE_DECL(SERVER_CuratorType) =
{
	params ["_player", "_scheme"];

	// Override for Vex + Bojan
	SuperUsers = [
		"76561198048006094", //Bojan
		"76561198089890491" // Vex.W
	];
	if ((getPlayerUID _player) in SuperUsers) exitWith { "MC" };

	private _curatorType = "";
	private _curatorTypeByID = "";
	private _curatorTypeByRole = "";

	_curatorTypeByID = [getPlayerUID _player] call CLIENT_fnc_curatorTypeBySteamID;
	if (_curatorTypeByID == "DD") exitWith { "MC" };

	switch (_scheme) do
	{
		case 0: // Steam ID
		{
			_curatorType = _curatorTypeByID;
		};
		
		case 1: // Role
		{
			_curatorType = [roleDescription _player] call CLIENT_fnc_curatorTypeByRole;
		};
		
		case 2: // Role and Steam ID
		{
			_curatorTypeByRole = [roleDescription _player] call CLIENT_fnc_curatorTypeByRole;

			if (_curatorTypeByID == "MC" && _curatorTypeByRole == "MC") exitWith { _curatorType = "MC" };
			if (_curatorTypeByID in ["MC", "MP"] && _curatorTypeByRole in ["MC", "MP"]) exitWith { _curatorType = "MP" };
			if (_curatorTypeByID in ["MC", "MP", "CO"] && _curatorTypeByRole in ["MC", "MP", "CO"]) exitWith { _curatorType = "CO" };
		};
		
		case 3: // Role or Steam ID
		{
			_curatorTypeByRole = [roleDescription _player] call CLIENT_fnc_curatorTypeByRole;

			if (_curatorTypeByID == "MC" || _curatorTypeByRole == "MC") exitWith { _curatorType = "MC" };
			if (_curatorTypeByID == "MP" || _curatorTypeByRole == "MP") exitWith { _curatorType = "MP" };
			if (_curatorTypeByID == "CO" || _curatorTypeByRole == "CO") exitWith { _curatorType = "CO" };
		};

		case 4: // Per-slot scheme
		{
			_scheme = [roleDescription _player] call CLIENT_fnc_curatorSchemeByRole;
			if (_scheme in [0,1,2,3]) then { _curatorType = [_player, _scheme] call SERVER_CuratorType };
		};
	};

	_curatorType
};

OO_TRACE_DECL(SERVER_CuratorAssign) =
{
	params ["_player"];

	if (not isNull getAssignedCuratorLogic _player) exitWith {};

	if (isNull SERVER_CuratorMaster) exitWith {};

	private _scheme = ["CuratorTypeScheme"] call JB_MP_GetParamValue;
	private _curatorType = [_player, _scheme] call SERVER_CuratorType;

	private _requirements = [roleDescription _player] call CLIENT_fnc_curatorTypeRoleRequirements;

	if (not (_curatorType in _requirements)) exitWith { [_requirements] remoteExec ["SPM_C_CuratorRequirementsNotMet", _player] };

	if (not (_curatorType in ["MC", "MP", "CO"])) exitWith {};

	private _curator = objNull;
	{
		if (isNull getAssignedCuratorUnit _x && _x != SERVER_CuratorMaster) exitWith
		{
			_curator = _x;
		};
	} forEach allCurators;

	if (not isNull _curator) then
	{

		switch (_curatorType) do
		{
			case "MC":
			{
				_curator addCuratorEditableObjects [curatorEditableObjects SERVER_CuratorMaster, false];

				SERVER_MissionControllers pushBackUnique _curator;
			};

			case "MP":
			{
				_curator addCuratorEditableObjects [(curatorEditableObjects SERVER_CuratorMaster) select { isPlayer _x }, false];

				SERVER_MilitaryPolice pushBackUnique _curator;
			};

			case "CO":
			{
				SERVER_CameraOperators pushBackUnique _curator;
			};
		};

		_curator setVariable ["showNotification", false, true]; //JIP
		_curator setVariable ["bird", objNull, true]; //JIP

		_player assignCurator _curator;
	};

	[_curatorType] remoteExec ["SERVER_C_SetCuratorType", _player];
	[[_player, _curatorType], "SERVER_C_AnnounceCurator"] call SERVER_RemoteExecCurators;
};

OO_TRACE_DECL(SERVER_CuratorUnassign) =
{
	params ["_player"];

	if (not isServer && hasInterface) exitWith {};

	private _curator = getAssignedCuratorLogic _player;
	if (not isNull _curator) then
	{
		SERVER_MissionControllers = SERVER_MissionControllers - [_curator];
		SERVER_MilitaryPolice = SERVER_MilitaryPolice - [_curator];
		SERVER_CameraOperators = SERVER_CameraOperators - [_curator];

		_curator removeCuratorEditableObjects [curatorEditableObjects _curator, false];
		unassignCurator _curator;
	};
};

OO_TRACE_DECL(SERVER_CuratePlayer) =
{
	private _player = param [0, objNull, [objNull]];

	[[_player]] call SERVER_CurateEditableObjects;

	[_player] call SERVER_CuratorAssign;
};

OO_TRACE_DECL(SERVER_RemoteCallerCuratorType) =
{
	private _caller = [remoteExecutedOwner] call SPM_Util_GetOwnerPlayer;

	if (isNull _caller) exitWith { "" };

	private _curator = getAssignedCuratorLogic _caller;

	if (isNull _curator) exitWith { "" };

	if (_curator in SERVER_MissionControllers) exitWith { "MC" };

	if (_curator in SERVER_MilitaryPolice) exitWith { "MP" };

	"CO"
};

OO_TRACE_DECL(SERVER_COMMAND_GM__FortifyPoints) =
{
	params ["_pointCount"];
	_points = parseNumber (_pointCount select 0);
	[west, _points, true] call acex_fortify_fnc_updateBudget;

	[format ["%1 points have been added to the FOB budget", _points]] call SPM_Util_MessageCaller;

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__Fortify) =
{
	params ["_commandWords"];

	private _commands =
	[
	["points", SERVER_COMMAND_GM__FortifyPoints]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 < 0) exitWith { _match };

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};

OO_TRACE_DECL(SERVER_COMMAND_GM__LoyaltyPoints) =
{
	(_this select 0) params ["_points", "_name"];
	_points = parseNumber (_points);
	_player = [_name] call SERVER_COMMAND_MP_GetPlayerByName;

	[[_points], LOYALTY_fnc_addPointsLocal] remoteExec ["call", _player];
	[format ["%1 points have been awarded %2", _points, name _player]] call SPM_Util_MessageCaller;

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__LoyaltyCooldown) =
{
	(_this select 0) params ["_cooldown", "_name"];
	_cooldown = parseNumber (_cooldown) * 60;
	_player = [_name] call SERVER_COMMAND_MP_GetPlayerByName;

	[[_cooldown], LOYALTY_fnc_setCooldownLocal] remoteExec ["call", _player];
	[format ["%1 minutes of cooldown has been set for %2", _cooldown/60, name _player]] call SPM_Util_MessageCaller;

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__LoyaltyCavBucks) =
{
	(_this select 0) params ["_cavBucks", "_name"];
	_cavBucks = parseNumber (_cavBucks);
	_player = [_name] call SERVER_COMMAND_MP_GetPlayerByName;

	[[_cavBucks], LOYALTY_fnc_addCavBucksLocal] remoteExec ["call", _player];
	[format ["%1 CavBucks have been awarded %2", _cavBucks, name _player]] call SPM_Util_MessageCaller;

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__Loyalty) =
{
	params ["_commandWords"];

	private _commands =
	[
		["points", SERVER_COMMAND_GM__LoyaltyPoints],
		["cooldown", SERVER_COMMAND_GM__LoyaltyCooldown],
		["cavbucks", SERVER_COMMAND_GM__LoyaltyCavBucks]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 < 0) exitWith { _match };

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};

OO_TRACE_DECL(SERVER_COMMAND_GM__Weather) =
{
	(_this select 0) params ["_state"];

	ZeusEnabledWeather = (toLower _state) isEqualTo "true";

	[format ["Automatic weather has been set to %1", _state]] call SPM_Util_MessageCaller;

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__DiceRoll) =
{
	(_this select 0) params [["_sides", "0"]];
	_sides = parseNumber _sides;
	if (_sides < 2) then {
		[format ["Die must have at least 2 sides"]] call SPM_Util_MessageCaller;
	}
	else {
		private _value = round(random(_sides));
		[format ["1d%1: %2", _sides, _value]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__MissionEndGet) =
{
	[format ["Match will try to end in %1 minutes", ((MissionEndTime - serverTime)/60)]] call SPM_Util_MessageCaller;
	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__MissionEndAdd) =
{
	params ["_minutesStr"];
	_minutes = parseNumber (_minutesStr select 0);

	MissionEndTime = MissionEndTime + (_minutes * 60);
	MissionEndWarningGiven = false;

	[format ["%1 minutes added to mission end time. Mission will end in %2 minutes, after AO finishes.", _minutes, ((MissionEndTime - serverTime)/60)]] call SPM_Util_MessageCaller;
	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__MissionEnd) =
{
	params ["_commandWords"];

	private _commands =
	[
		["get", SERVER_COMMAND_GM__MissionEndGet],
		["add", SERVER_COMMAND_GM__MissionEndAdd]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 < 0) exitWith { _match };

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};


OO_TRACE_DECL(SERVER_COMMAND_GM__CurateAll) =
{
	params ["_commandWords"];

	if (count _commandWords > 1) exitWith { [format ["GM: Expected only a class name at '%1'", _commandWords joinString " "]] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	private _class = if (count _commandWords == 1) then { _commandWords select 0 } else { "All" };

	private _filter = [[_class, true], ["All", false]];
	private _vehicles = vehicles select { [typeOf _x,  _filter] call JB_fnc_passesTypeFilter };
	private _units = allUnits select { [typeOf _x,  _filter] call JB_fnc_passesTypeFilter };

	if (count _vehicles + count _units == 0) exitWith { [format ["GM: No objects match the class name '%1'", _class]] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	[_vehicles + _units] call SERVER_CurateEditableObjects;

	if (count _commandWords == 0) then
	{
		[format ["%1 units and vehicles have been curated for all mission controllers", count _vehicles + count _units]] call SPM_Util_MessageCaller;
	}
	else
	{
		[format ["%1 units and vehicles of class %2 have been curated for all mission controllers", count _vehicles + count _units, _class]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__CurateVisible) =
{
	params ["_commandWords"];

	if (count _commandWords > 1) exitWith { [format ["GM: Expected only a class name at '%1'", _commandWords joinString " "]] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	private _class = if (count _commandWords == 1) then { _commandWords select 0 } else { "All" };

	private _withinLimits =
	{
		params ["_position"];

		(_position select 0) >= safeZoneX && { (_position select 0) <= safeZoneX + safeZoneW } && { (_position select 1) >= safeZoneY } && { (_position select 1) <= safeZoneY + safeZoneH }
	};

	private _filter = [[_class, true], ["All", false]];
	private _vehicles = vehicles select { [typeOf _x,  _filter] call JB_fnc_passesTypeFilter && { [worldToScreen getPosATL _x] call _withinLimits } };
	private _units = allUnits select { [typeOf _x,  _filter] call JB_fnc_passesTypeFilter && { [worldToScreen getPosATL _x] call _withinLimits } };

	if (count _vehicles + count _units == 0) exitWith { [format ["GM: No visible objects match the class name '%1'", _class]] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	[_vehicles + _units] call SERVER_CurateEditableObjects;

	if (count _commandWords == 0) then
	{
		[format ["%1 visible units and vehicles have been curated for all mission controllers", count _vehicles + count _units]] call SPM_Util_MessageCaller;
	}
	else
	{
		[format ["%1 visible units and vehicles of class %2 have been curated for all mission controllers", count _vehicles + count _units, _class]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_GM__Curate) =
{
	params ["_commandWords"];

	private _commands =
	[
		["all", SERVER_COMMAND_GM__CurateAll],
		["visible", SERVER_COMMAND_GM__CurateVisible]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 < 0) exitWith { _match };

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};

OO_TRACE_DECL(SERVER_COMMAND_GM) =
{
	params ["_commandString"];

	if (not (([] call SERVER_RemoteCallerCuratorType) in ["MC"])) exitWith { ["MC: command is reserved to mission controllers"] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };
	private _commandWords = _commandString splitString " ";

	private _commands =
	[
		["curate", SERVER_COMMAND_GM__Curate],
		["fortify", SERVER_COMMAND_GM__Fortify],
		["loyalty", SERVER_COMMAND_GM__Loyalty],
		["weather", SERVER_COMMAND_GM__Weather],
		["missionend", SERVER_COMMAND_GM__MissionEnd],
		["diceroll", SERVER_COMMAND_GM__DiceRoll]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 == OP_COMMAND_RESULT_UNRECOGNIZED) exitWith
	{
		[_commandString] call OP_COMMAND_Execute;
	};

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};

OO_TRACE_DECL(SERVER_COMMAND_MP_GetPlayerByName) =
{
	params ["_name"];

	private _lowerName = toLower _name;

	private _players = [];
	{
		if (toLower (name _x) == _lowerName) exitWith { _players = [_x] };
		if ((toLower name _x) find _lowerName >= 0) then { _players pushBack _x };
	} forEach (allPlayers select { not (_x isKindOf "HeadlessClient_F") });

	if (count _players == 0) exitWith { [format ["MP: no player names contain '%1'", _name]] call SPM_Util_MessageCaller; objNull };
	if (count _players > 1) exitWith { [format ["MP: '%1' is ambiguous, matching &2 player names (%3)", _name, count _players, _players joinString ", "]] call SPM_Util_MessageCaller; objNull };

	_players select 0
};

OO_TRACE_DECL(SERVER_COMMAND_MP__Boot) =
{
	params ["_commandWords"];

	if (count _commandWords == 0) exitWith { ["MP: Specify a player name"] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	if (_commandWords select 0 == "ALL") then
	{
		{ "BootAll" remoteExec ["endMission", _x]; } forEach (allPlayers select { not (_x isKindOf "HeadlessClient_F") });

		["Booting all players"] call SPM_Util_MessageCaller;
	}
	else
	{
		private _player = [_commandWords select 0] call SERVER_COMMAND_MP_GetPlayerByName;

		if (not isNull _player) then
		{
			"PoliceEjection" remoteExec ["endMission", _player];

			[format ["Player '%1' has been booted", name _player]] call SPM_Util_MessageCaller;
		};
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_MP__Eject) =
{
	params ["_commandWords"];

	if (count _commandWords == 0) exitWith { ["MP: Specify a player name"] call SPM_Util_MessageCaller; OP_COMMAND_RESULT_MATCHED };

	private _player = [_commandWords select 0] call SERVER_COMMAND_MP_GetPlayerByName;

	if (not isNull _player) then
	{
		[[], { player action ["Eject", vehicle player] }] remoteExec ["call", _player];

		[format ["Player '%1' has been ejected from his vehicle", name _player]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_MP__Rule) =
{
	params ["_commandWords"];

	if (count _commandWords == 0) exitWith { ["MP: Specify a rule number between 1 and 7"] call SPM_Util_MessageCaller; OP_COMMAND_RESULT_MATCHED };
	if (count _commandWords == 1) exitWith { ["MP: Specify the name of the player who should receive the rules"] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	_commandWords params ["_rule", "_playerName"];

	private _ruleNumber = (["1", "2", "3", "4", "5", "6", "7"] find _rule) + 1;

	if (_ruleNumber == 0) exitWith { ["MP: '%1' is not a valid rule number.  Please specify a value between 1 and 7"] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	private _player = [_playerName] call SERVER_COMMAND_MP_GetPlayerByName;

	if (not isNull _player) then
	{
		[_ruleNumber] remoteExec ["Billboard_ShowRule", _player];

		[format ["Player '%1' has been reminded of rule %2", name _player, _ruleNumber]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_MP__SafetyOn) =
{
	params ["_commandWords"];

	if (count _commandWords == 0) exitWith { ["MP: Specify a player name"] call SPM_Util_MessageCaller; OP_COMMAND_RESULT_MATCHED };

	private _player = [_commandWords select 0] call SERVER_COMMAND_MP_GetPlayerByName;

	if (not isNull _player) then
	{
		private _dryFire =
		{
			if (isNil "MP_DryFire") then
			{
				MP_DryFire = ["An MP has removed your ability to fire any weapon"] call CLIENT_StartForceDryFire;
			};
		};
		[[], _dryFire] remoteExec ["call", _player];

		[format ["Player '%1' can no longer fire weapons", name _player]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_MP__SafetyOff) =
{
	params ["_commandWords"];

	if (count _commandWords == 0) exitWith { ["MP: Specify a player name"] call SPM_Util_MessageCaller; OP_COMMAND_RESULT_MATCHED };

	private _player = [_commandWords select 0] call SERVER_COMMAND_MP_GetPlayerByName;

	if (not isNull _player) then
	{
		private _dryFire =
		{
			if (not isNil "MP_DryFire") then
			{
				[MP_DryFire] call CLIENT_EndForceDryFire;
			};
		};
		[[], _dryFire] remoteExec ["call", _player];

		[format ["Player '%1' can now fire weapons per standard mission parameters", name _player]] call SPM_Util_MessageCaller;
	};

	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_MP__Safety) =
{
	params ["_commandWords"];

	private _commands =
	[
		["on", SERVER_COMMAND_MP__SafetyOn],
		["off", SERVER_COMMAND_MP__SafetyOff]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 < 0) exitWith { _match };

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};

SERVER_COMMAND_AllLocations = [];

OO_TRACE_DECL(SERVER_COMMAND_MP__Teleport) =
{
	params ["_commandWords"];

	if (count _commandWords != 4) exitWith { ["MP: expected [player|vehicle] name [player|marker|location] name"] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	_commandWords params ["_sourceType", "_sourceName", "_destinationType", "_destinationName"];

	private _sourceTypes = ["player", "vehicle"];
	private _sourceTypeMatches = _sourceTypes select { _x find _sourceType == 0 };
	if (count _sourceTypeMatches != 1) exitWith { [format ["MP: expected 'player' or 'vehicle' at '%1'", _sourceType]] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	private _destinationTypes = ["player", "marker", "location"];
	private _destinationTypeMatches = _destinationTypes select { _x find _destinationType == 0 };
	if (count _destinationTypeMatches != 1) exitWith { [format ["MP: expected 'player', 'marker' or 'location' at '%1'", _destinationType]] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	private _sourceObject = [_sourceName] call SERVER_COMMAND_MP_GetPlayerByName;
	if (isNull _sourceObject) exitWith { [OP_COMMAND_RESULT_MATCHED] };

	private _sourcePlayer = _sourceObject;
	switch (_sourceTypeMatches select 0) do
	{
		case "player": {};
		case "vehicle": { _sourceObject = vehicle _sourceObject };
	};

	private _getMarkerPosition =
	{
		params ["_markerName"];

		_markerName = toLower _markerName;

		// All markers with the text
		private _markers = allMapMarkers select { (toLower (markerText _x)) find _markerName >= 0 };

		// Look for a marker that exactly matches the text
		private _match = _markers select { (toLower (markerText _x)) == _markerName };
		if (count _match == 1) exitWith { markerPos (_match select 0) };

		// If not exactly one partial match, return the count of partial matches
		if (count _markers != 1) exitWith { [count _markers] };

		// If exactly one partial match, return the position of the match
		markerPos (_markers select 0)
	};

	private _dropAtDestination = false;
	private _destination = [];
	private _direction = getDir _sourceObject;

	switch (_destinationTypeMatches select 0) do
	{
		case "player":
		{
			private _destinationPlayer = [_destinationName] call SERVER_COMMAND_MP_GetPlayerByName;
			if (not isNull _destinationPlayer) then { _destination = getPosASL _destinationPlayer };
		};

		case "marker":
		{
			_dropAtDestination = true;
			private _result = [[_destinationName], _getMarkerPosition, remoteExecutedOwner] call JB_fnc_remoteCall;
			if (_result select 0 != JBRC_TIMEDOUT) then
			{
				if (count (_result select 1) > 1) then
				{
					_destination = _result select 1;
				}
				else
				{
					switch (_result select 1 select 0) do
					{
						case 0: { [format ["MP: '%1' is an unknown marker name", _destinationName]] call SPM_Util_MessageCaller };
						default { [format ["MP: '%1' is an ambiguous marker name", _destinationName]] call SPM_Util_MessageCaller };
					};
				};
			};
		};

		case "location":
		{
			_dropAtDestination = true;
			if (count SERVER_COMMAND_AllLocations == 0) then { SERVER_COMMAND_AllLocations = nearestLocations [[worldSize / 2, worldSize / 2, 0], ["NameCityCapital", "NameCity", "NameVillage", "NameMarine", "NameLocal", "Mount", "Hill"], worldSize / 2 * 1.4] };
			private _locations = SERVER_COMMAND_AllLocations select { (toLower text _x) find _destinationName >= 0 };
			if (count _locations > 1) then
			{
				_locations = _locations select { (toLower text _x) == _destinationName }; // Exact name
				if (count _locations > 1) then
				{
					_locations = _locations apply { [_sourcePlayer distance getPos _x, _x] };
					_locations sort true;
					_locations = [_locations select 0 select 1]; // Closest location with exact name
				};
			};
			switch (count _locations) do
			{
				case 0: { [format ["MP: '%1' is an unknown location name", _destinationName]] call SPM_Util_MessageCaller };
				case 1:
					{
						_destination = getPos (_locations select 0);
						_destination set [2, 0];

						private _positions = (_destination nearRoads 50) apply { getpos _x };

						if (count _positions > 0) then
						{
							_destination = [_positions, _destination] call SPM_Util_ClosestPosition;
							private _road = roadAt _destination;
							private _connected = roadsConnectedTo _road;
							if (count _connected > 0) then { _direction = _road getDir (_connected select 0) };
						}
						else
						{
							private _positions = [_destination, 0, 5 * sizeOf typeOf _sourceObject, sizeOf typeOf _sourceObject] call SPM_Util_SampleAreaGrid;
							[_positions, ["#GdtWater"]] call SPM_Util_ExcludeSamplesBySurfaceType;
							[_positions, sizeOf typeOf _sourceObject / 2.0, ["FENCE", "WALL", "BUILDING", "HOUSE", "ROCK", "TREE"]] call SPM_Util_ExcludeSamplesByProximity;

							if (count _positions > 0) then { _destination = [_positions, _destination] call SPM_Util_ClosestPosition };
						};
					};
				default { [format ["MP: '%1' is an ambiguous location name", _destinationName]] call SPM_Util_MessageCaller };
			};
		};
	};

	if (count _destination == 0) exitWith { [OP_COMMAND_RESULT_MATCHED] };

	if (_dropAtDestination) then
	{
		private _destinationASL = AGLtoASL _destination;
		private _intersections = lineIntersectsSurfaces [_destinationASL vectorAdd [0,0,30], _destinationASL vectorAdd [0,0,-1], objNull, objNull, true, -1];
		_intersections = _intersections select { not ((_x select 3) isKindOf "Man") }; // Ignore intersections that contact a person
		_intersections = _intersections select { isNull (_x select 3) || { typeof (_x select 3) != "" } || { ((getModelInfo (_x select 3)) select 1) find "a3\plants_f" == -1 } }; // Terrain, full objects (e.g. buildings), or simple objects that aren't plants (e.g. walls)
		if (count _intersections > 0) then { _destination = _intersections select 0 select 0 };
	};

	if (_sourceObject != _sourcePlayer) then
	{
		{
			if (isPlayer _x) then { ["An MP is teleporting you...", 3] remoteExec ["JB_fnc_showBlackScreenMessage", _x] };
		} forEach ((crew _sourceObject) - [_sourcePlayer]);
	};
	[[_sourceObject, _destination, _direction], { ["An MP is teleporting you...", 3] call JB_fnc_showBlackScreenMessage; sleep 2; (_this select 0) setPosASL ((_this select 1) vectorAdd [0,0,100]); (_this select 0) setDir (_this select 2); (_this select 0) setPosASL (_this select 1) }] remoteExec ["spawn", _sourcePlayer];

	[format ["Player '%1'%2 has been teleported to %3", name _sourcePlayer, if (_sourceObject != _sourcePlayer) then { "s vehicle" } else { "" }, (_destination select [0,2]) apply { round _x }]] call SPM_Util_MessageCaller;


	[OP_COMMAND_RESULT_MATCHED]
};

OO_TRACE_DECL(SERVER_COMMAND_MP) =
{
	params ["_commandString"];

	if (not (([] call SERVER_RemoteCallerCuratorType) in ["MC", "MP"])) exitWith { ["MP: command is reserved to mission controllers and military police"] call SPM_Util_MessageCaller; [OP_COMMAND_RESULT_MATCHED] };

	private _commandWords = _commandString splitString " ";

	private _commands =
	[
		["boot", SERVER_COMMAND_MP__Boot],
		["eject", SERVER_COMMAND_MP__Eject],
		["rule", SERVER_COMMAND_MP__Rule],
		["safety", SERVER_COMMAND_MP__Safety],
		["teleport", SERVER_COMMAND_MP__Teleport]
	];

	private _match = [_commandWords select 0, _commands] call OP_COMMAND_Match;

	if (_match select 0 < 0) exitWith { _match };

	private _command = _match select 1;

	[_commandWords select [1, 1e3]] call (_command select 1);
};

SERVER_ExecuteCommand =
{
	params ["_command"];

	private _result = [];

	switch (true) do
	{
		case ((toLower _command) find "gm " == 0 || { (toLower _command) find "mc " == 0 } ):
		{
			_result = [_command select [3]] call SERVER_COMMAND_GM;
		};

		case ((toLower _command) find "mp " == 0):
		{
			_result = [_command select [3]] call SERVER_COMMAND_MP;
		};

		default
		{
			_result = [OP_COMMAND_RESULT_UNRECOGNIZED, _command];
		};
	};

	switch (_result select 0) do
	{
		case OP_COMMAND_RESULT_MATCHED: {};
		case OP_COMMAND_RESULT_NOCOMMAND: { [format ["Incomplete command.  Please specify one of %1", (_result select 1) joinString ", "]] call SPM_Util_MessageCaller };
		case OP_COMMAND_RESULT_AMBIGUOUS: { [format ["Ambiguous: %1", _result select 1]] call SPM_Util_MessageCaller };
		case OP_COMMAND_RESULT_UNRECOGNIZED: { [format ["Unrecognized: %1", _result select 1]] call SPM_Util_MessageCaller };
	};

	(_result select 0)
};

OO_TRACE_DECL(SERVER_GetPlayerByUID) =
{
	params ["_uid"];

	private _players = +allPlayers;
	private _index = _players findIf { getPlayerUID _x == _uid };
	if (_index == -1) then { objNull } else { _players select _index }
};

OO_TRACE_DECL(SERVER_PlayerConnected) =
{
	_this spawn
	{
		params ["_id", "_uid", "_name", "_jip", "_owner"];

		scriptName "SERVER_PlayerConnected";

		if (_name == "__SERVER__") exitWith {}; // Server declaring its creation

		private _player = objNull;
		[{ _player = [_uid] call SERVER_GetPlayerByUID; not isNull _player }, 30, 1] call JB_fnc_timeoutWaitUntil;

		if (isNull _player) then
		{
			diag_log format ["ERROR: SERVER_PlayerConnected: unable to translate UID %1 to a player object", _uid];
		}
		else
		{
			_player addMPEventHandler ["MPKilled", { if (isServer) then { [_this select 0] call SERVER_CuratorUnassign } }];
		};
	};
};

OO_TRACE_DECL(SERVER_PlayerDisconnected) =
{
	params ["_id", "_uid", "_name", "_jip", "_owner"];

	if (_name == "__SERVER__") exitWith {}; // Server declaring its demise.

	private _player = [_uid] call SERVER_GetPlayerByUID;

	if (isNull _player) then
	{
		diag_log format ["SERVER_PlayerDisconnected: could not locate player by UID %1", _uid];
	}
	else
	{
		_player spawn
		{
			private _player = _this;

			scriptName "SERVER_PlayerDisconnected";

			[_player] remoteExec ["CLIENT_PlayerDisconnected", 0];

			sleep 3;

			// Hide and delete the disconnecting unit.  The unit is hidden in case it's in a vehicle
			_player hideObjectGlobal true;
			deleteVehicle _player;
		};
	};

	false
};

OO_TRACE_DECL(SERVER_Supply_PackContainer) =
{
	params ["_container", "_supplyTypes", "_capacity"];

	if (count _supplyTypes == 0) exitWith { 0 };

	private _oversizedTypes = [];
	private _remainingCapacity = _capacity;
	private _capacityPerType = 0;
	private _supplyType = [];
	private _count = 0;

	while { true } do
	{	
		// Discard the largest type that won't fit into an equitable split, then try to split
		// the available space again.  Repeat until we have no more types or the remaining types all fit.
		while { count _supplyTypes > 0 } do
		{
			_capacityPerType = _remainingCapacity / count _supplyTypes;
			_oversizedTypes = _supplyTypes select { _x select 0 > _capacityPerType };

			// No oversized types, so we're good to continue
			if (count _oversizedTypes == 0) exitWith {};

			_oversizedTypes sort false;
			_supplyTypes = _supplyTypes - [_oversizedTypes select 0];
		};

		// If no types remain, we're done
		if (count _supplyTypes == 0) exitWith {};

		_capacityPerType = _remainingCapacity / count _supplyTypes;

		{
			_supplyType = _x;
			switch (_supplyType select 1) do
			{
				case "weapon":
				{
					_count = floor (_capacityPerType / (_supplyType select 0));
					_container addWeaponCargoGlobal [_supplyType select 2, _count];
					_remainingCapacity = _remainingCapacity - _count * (_supplyType select 0);
				};

				case "magazine":
				{
					_count = floor (_capacityPerType / (_supplyType select 0));
					_container addMagazineCargoGlobal [_supplyType select 2, _count];
					_remainingCapacity = _remainingCapacity - _count * (_supplyType select 0);
				};

				case "item":
				{
					_count = floor (_capacityPerType / (_supplyType select 0));
					_container addItemCargoGlobal [_supplyType select 2, _count];
					_remainingCapacity = _remainingCapacity - _count * (_supplyType select 0);
				};

				case "backpack":
				{
					_count = floor (_capacityPerType / (_supplyType select 0));
					_container addBackpackCargoGlobal [_supplyType select 2, _count];
					_remainingCapacity = _remainingCapacity - _count * (_supplyType select 0);
				};
			};
		} forEach _supplyTypes;
	};

	_capacity - _remainingCapacity
};

OO_TRACE_DECL(SERVER_Supply_StockAmmunitionContainer) =
{
	params ["_container", ["_capacity", -1, [0]], ["_clear", true, [true]]];

	if (_clear) then
	{
		[_container] call JB_fnc_containerClear;
	};

	if (_capacity == -1) then { _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad") };

	private _gear = [] call CLIENT_fnc_arsenalGear;
	private _supplyTypes = [(_gear select 0) + ["Put", "Throw"]] call CLIENT_fnc_whitelistMagazines;
	_supplyTypes = _supplyTypes select { _x find "Grenade" == -1 && _x find "Flare" == -1 };

	_supplyTypes = _supplyTypes apply { [getText (configFile >> "CfgMagazines" >> _x >> "displayName"), _x] };
	_supplyTypes sort true;
	_supplyTypes = _supplyTypes apply { [getNumber (configFile >> "CfgMagazines" >> (_x select 1) >> "mass"), "magazine", _x select 1] };

	{
		_supplyTypes pushBack [getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass"), "item", _x];
	} forEach ["FirstAidKit"];

	{
		_supplyTypes pushBack [getNumber (configFile >> "CfgMagazines" >> _x >> "mass"), "magazine", _x];
	} forEach ["DemoCharge_Remote_Mag", "HandGrenade", "MiniGrenade", "1Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell", "SmokeShell", "1Rnd_Smoke_Grenade_shell", "3Rnd_Smoke_Grenade_shell", "UGL_FlareWhite_F", "3Rnd_UGL_FlareWhite_F"];

	[_container, _supplyTypes, _capacity] call SERVER_Supply_PackContainer;
};

OO_TRACE_DECL(SERVER_Supply_StockExplosivesContainer) =
{
	params ["_container", ["_capacity", -1, [0]], ["_clear", true, [true]]];

	if (_clear) then
	{
		[_container] call JB_fnc_containerClear;
	};

	if (_capacity == -1) then { _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad") };

	private _supplyTypes = [["Put"]] call CLIENT_fnc_whitelistMagazines;
	_supplyTypes = _supplyTypes apply { [getText (configFile >> "CfgMagazines" >> _x >> "displayName"), _x] };
	_supplyTypes sort true;
	_supplyTypes = _supplyTypes apply { [getNumber (configFile >> "CfgMagazines" >> (_x select 1) >> "mass"), "magazine", _x select 1] };

	[_container, _supplyTypes, _capacity] call SERVER_Supply_PackContainer;
};

OO_TRACE_DECL(SERVER_Supply_StockWeaponsContainer) =
{
	params ["_container", ["_capacity", -1, [0]], ["_clear", true, [true]]];

	if (_clear) then
	{
		[_container] call JB_fnc_containerClear;
	};

	if (_capacity == -1) then { _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad") };

	private _type = "";
	private _config = (configFile >> "CfgWeapons");
	private _supplyTypes = ([] call CLIENT_fnc_arsenalGear) select 0;
	_supplyTypes = _supplyTypes select { _type = _x; _supplyTypes findIf { _type != _x && { _type isKindOf [_x, _config] } } == -1 }; // Select weapons that are not a subclass of another weapon type
	_supplyTypes = _supplyTypes apply { [getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass"), "weapon", _x] };

	[_container, _supplyTypes, _capacity] call SERVER_Supply_PackContainer;
};

OO_TRACE_DECL(SERVER_Supply_StockStaticWeaponsContainer) =
{
	params ["_container", ["_capacity", -1, [0]], ["_clear", true, [true]]];

	if (_clear) then
	{
		[_container] call JB_fnc_containerClear;
	};

	if (_capacity == -1) then { _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad") };

	private _backpackTypes = ([] call CLIENT_fnc_whitelistGear) select 1;
	
	private _weaponTypes = _backpackTypes select { getText (configFile >> "CfgVehicles" >> _x >> "assembleInfo" >> "assembleTo") != "" && { toLower (getText (configFile >> "CfgVehicles" >> _x >> "displayName")) find "mortar" == -1 } };

	private _assembledTypes = _weaponTypes apply { getText (configFile >> "CfgVehicles" >> _x >> "assembleInfo" >> "assembleTo") };
	private _componentTypes = _assembledTypes apply { getArray (configFile >> "CfgVehicles" >> _x >> "assembleInfo" >> "dissasembleTo") };

	private _staticTypes = [];
	{
		{
			_staticTypes pushBackUnique _x;
		} forEach _x;
	} forEach _componentTypes;

	private _supplyTypes = _staticTypes apply { [getNumber (configFile >> "CfgVehicles" >> _x >> "mass"), "backpack", _x] };

	[_container, _supplyTypes, _capacity] call SERVER_Supply_PackContainer;
};

OO_TRACE_DECL(SERVER_Supply_StockMortarsContainer) =
{
	params ["_container", ["_capacity", -1, [0]], ["_clear", true, [true]]];

	if (_clear) then
	{
		[_container] call JB_fnc_containerClear;
	};

	if (_capacity == -1) then { _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad") };

	private _backpackTypes = ([] call CLIENT_fnc_whitelistGear) select 1;
	
	private _mortarTypes = _backpackTypes select { toLower (getText (configFile >> "CfgVehicles" >> _x >> "displayName")) find "mortar" >= 0 };

	private _supplyTypes = _mortarTypes apply { [getNumber (configFile >> "CfgVehicles" >> _x >> "mass"), "backpack", _x] };

	[_container, _supplyTypes, _capacity] call SERVER_Supply_PackContainer;
};

OO_TRACE_DECL(SERVER_Supply_StockItemsContainer) =
{
	params ["_container", ["_capacity", -1, [0]], ["_clear", true, [true]]];

	if (_clear) then
	{
		[_container] call JB_fnc_containerClear;
	};

	if (_capacity == -1) then { _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad") };

	private _itemTypes = ([] call CLIENT_fnc_whitelistGear) select 2;

	_itemTypes = _itemTypes select { getText (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "uniformModel") == "" && { getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass") != 0 } };
	
	_supplyTypes = _itemTypes apply { [getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass"), "item", _x] };

	[_container, _supplyTypes, _capacity] call SERVER_Supply_PackContainer;
};

OO_TRACE_DECL(Base_Supply_Drop_AnnounceStockStart) =
{
	private _arguments = ["Loading container...", "plain down", 0.2];
	if (isRemoteExecuted && remoteExecutedOwner != 2) then { _arguments remoteExec ["titleText", remoteExecutedOwner] } else { titleText _arguments };
};

OO_TRACE_DECL(Base_Supply_Drop_AnnounceStockEnd) =
{
	private _arguments = ["Loading complete", "plain down", 0.2];
	if (isRemoteExecuted && remoteExecutedOwner != 2) then { _arguments remoteExec ["titleText", remoteExecutedOwner] } else { titleText _arguments };
};

OO_TRACE_DECL(Base_Supply_Drop_Ammo_StockContainer) =
{
	params ["_container"];

	[] call Base_Supply_Drop_AnnounceStockStart;

	private _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
	[_container, _capacity, true] call SERVER_Supply_StockAmmunitionContainer;

	[] call Base_Supply_Drop_AnnounceStockEnd;
};

OO_TRACE_DECL(Base_Supply_Drop_Items_StockContainer) =
{
	params ["_container"];

	[] call Base_Supply_Drop_AnnounceStockStart;

	private _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
	[_container, _capacity, true] call SERVER_Supply_StockItemsContainer;

	[] call Base_Supply_Drop_AnnounceStockEnd;
};

OO_TRACE_DECL(Base_Supply_Drop_Mortars_StockContainer) =
{
	params ["_container"];

	[] call Base_Supply_Drop_AnnounceStockStart;

	private _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
	[_container, _capacity, true] call SERVER_Supply_StockMortarsContainer;

	[] call Base_Supply_Drop_AnnounceStockEnd;
};

OO_TRACE_DECL(Base_Supply_Drop_StaticWeapons_StockContainer) =
{
	params ["_container"];

	[] call Base_Supply_Drop_AnnounceStockStart;

	private _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
	[_container, _capacity, true] call SERVER_Supply_StockStaticWeaponsContainer;

	[] call Base_Supply_Drop_AnnounceStockEnd;
};

OO_TRACE_DECL(Base_Supply_Drop_Weapons_StockContainer) =
{
	params ["_container"];

	[] call Base_Supply_Drop_AnnounceStockStart;

	private _capacity = getNumber (configFile >> "CfgVehicles" >> typeOf _container >> "maximumLoad");
	[_container, _capacity * 0.8, true] call SERVER_Supply_StockWeaponsContainer;
	[_container, _capacity * 0.8, false] call SERVER_Supply_StockItemsContainer;

	[] call Base_Supply_Drop_AnnounceStockEnd;
};

SERVER_Tracking_AirWithinRange =
{
	params ["_unit", "_range"];

	private _aircraft = _unit nearEntities ["Air", _range];

	_aircraft = _aircraft select { alive _x && { not isPlayer driver _x } && { (getPosATL _x) select 2 > 10 } && { not (_x isKindOf "ParachuteBase") } };

	if (count _aircraft == 0) exitWith { [] };

	_aircraft = _aircraft apply { [speed _x, _x] };
	_aircraft sort true;
	_aircraft = _aircraft apply { _x select 1 };

	_aircraft
};

SERVER_Tracking_AirWithin1000 =
{
	params ["_unit"];

	([_unit, 1000] call SERVER_Tracking_AirWithinRange)
};

SERVER_Tracking_AirWithin3500 =
{
	params ["_unit"];

	([_unit, 3500] call SERVER_Tracking_AirWithinRange)
};

SERVER_Tracking_AirWithin5000 =
{
	params ["_unit"];

	([_unit, 5000] call SERVER_Tracking_AirWithinRange)
};

SERVER_IsNightOperation =
{
	private _times = [date] call BIS_fnc_sunriseSunsetTime;
	private _dawn = (_times select 0);
	private _dusk = (_times select 1);

	(dayTime < _dawn) || (dayTime + 1.0 > _dusk)
};

// Name, min, default, max.  Note that ARMA itself remaps these values again.  Most significantly, aimingSpeed's minimum possible value is 0.5
SERVER_Skill_Default =
[
	["aimingAccuracy", 0.05, 0.20, 0.85],
	["aimingShake", 0.05, 0.20, 0.25],
	["aimingSpeed", 0.05, 0.30, 0.85],
	["spotDistance", 0.00, 0.30, 0.90],
	["spotTime", 0.00, 0.30, 1.00],
	["reloadSpeed", 0.75, 0.90, 1.00],
	["commanding", 1.00, 1.00, 1.00],
	["courage", 1.00, 1.00, 1.00],
	["endurance", 1.00, 1.00, 1.00],
	["general", 0.00, 0.00, 0.00]
];

// Interpolate all skills from default values towards either min (_skill < 0.5) or max (_skill > 0.5) 
OO_TRACE_DECL(SERVER_InitializeObject_SetSkill) =
{
	params ["_unit", "_skill"];

	_skill = (_skill min 1.0) max 0.0;

	if (_skill > 0.5) then
	{
		private _multiplier = linearConversion [0.5, 1.0, _skill, 0.0, 1.0];
		{ _unit setSkill [_x select 0, (_x select 2) + ((_x select 3) - (_x select 2)) * _multiplier] } forEach SERVER_Skill_Default;
	}
	else
	{
		private _multiplier = linearConversion [0.0, 0.5, _skill, 1.0, 0.0];
		{ _unit setSkill [_x select 0, (_x select 2) + ((_x select 1) - (_x select 2)) * _multiplier] } forEach SERVER_Skill_Default;
	}
};

OO_TRACE_DECL(SERVER_InitializeObject_Civilian) =
{
	params ["_category", "_group"];
	
	_group allowFleeing 1.0;

	private _armedProbability = 0.01;

	private _area = OO_GET(_category,ForceCategory,Area);
	if (count _area > 0) then
	{
		private _location = [] call OO_METHOD(_area,StrongpointArea,GetNearestLocation);
		_armedProbability = if (type _location == "NameVillage") then { 0.20 } else { 0.01 };
	};

	private _armedTypes = ["I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Bandit_8_F"];

	{
		if (random 1 < _armedProbability) then
		{
			_x setUnitLoadout (getUnitLoadout selectRandom _armedTypes);
		};
	} forEach units _group;
};

OO_TRACE_DECL(SERVER_InitializeObject_Syndikat) =
{
	params ["_category", "_group"];

	_group allowFleeing 0.2;

	private _skillLevel = OO_GET(_category,ForceCategory,SkillLevel);

	{
		[_x, _skillLevel] call SERVER_InitializeObject_SetSkill;

		_x enableFatigue false;
		_x unassignItem "NVGoggles_INDEP";
		_x removeItem "NVGoggles_INDEP";
		_x addPrimaryWeaponItem "acc_flashlight";
	} forEach units _group;
};

OO_TRACE_DECL(SERVER_InitializeObject_CSAT) =
{
	params ["_category", "_group"];

	_group allowFleeing 0.0;

	private _skillLevel = OO_GET(_category,ForceCategory,SkillLevel);

	{
		[_x, _skillLevel] call SERVER_InitializeObject_SetSkill;

		[_x, "AAF_1stRegiment"] call BIS_fnc_setUnitInsignia;

		_x enableFatigue false;

		_x unassignItem "NVGoggles_OPFOR";
		_x removeItem "NVGoggles_OPFOR";

		_x addPrimaryWeaponItem "acc_flashlight";

		if (headgear _x == "LOP_U_US_Fatigue_01") then { removeHeadgear _x; _x addHeadgear "LOP_H_6B27M_Skol" }; // Drop the Armor V helmets to Armor III

	} forEach units _group;

	if (OO_INSTANCE_ISOFCLASS(_category,InfantryGarrisonCategory) && { OO_GET(_category,InfantryGarrisonCategory,IsUrbanEnvironment) }) then
	{
		private _unit = objNull;
		private _items = [];
		{
			_unit = _x;

			if (uniform _x in ["U_O_CombatUniform_ocamo"]) then
			{
				_items = uniformItems _unit;
				removeUniform _unit;
				_unit addUniform "U_O_CombatUniform_oucamo";
				{ _unit addItemToUniform _x } forEach _items;
			};

			if (headgear _x in ["H_ShemagOpen_tan"]) then
			{
				removeHeadgear _x;
				_x addHeadgear "H_ShemagOpen_khk";
			};
		} forEach units _group;
	};
};

SERVER_VehicleLockFilter =
[
	["O_APC_Tracked_02_AA_F", true],	// Tigris
	["O_MBT_04*", true],				// Angara
	["Tank", false],
	["APC_Wheeled_03_base_F", false],	// Gorgon
	["O_MRAP_02_hmg_F", false],			// Ifrit
	["O_LSV_02_armed_F", false],		// Qilin
	["I_C_Offroad_02_LMG_F", false],	// Syndikat LMG Jeep
	["I_C_Offroad_02_AT_F", false],		// Syndikat AT Jeep
	["O_HMG_01_high_F", false],			// Static HMG
	["All", true]
];

OO_TRACE_DECL(SERVER_InitializeCategoryObject_Object) =
{
	params ["_category", "_object"];

	// Mark boxes created by this objective so that our EOD guys can pick them up
	if (OO_INSTANCE_ISOFCLASS(_category,AmmoCachesCategory)) then
	{
		if ([_object] call JB_fnc_containerIsContainer) then
		{
			[_object, SERVER_AllowEODCarry, { ([_this select 0] call JB_fnc_containerMass) * MASS_TO_KG }] call JB_fnc_carryObjectInitObject;
		}
		else
		{
			[_object, SERVER_AllowEODCarry, { ([_this select 0] call JB_fnc_objectVolume) * 45 }] call JB_fnc_carryObjectInitObject; // Non-containers mass 45kg per cubic meter
		};
	};

	// Make sure various weapons in containers are downgraded
	if ([_object] call JB_fnc_containerIsContainer) then { [_object, SERVER_Magazines_TitanToRPG, SERVER_Weapons_LauncherDowngrade] call JB_fnc_containerSubstitute };

	// Make sure vehicles are locked as appropriate
	if ([typeOf _object, SERVER_VehicleLockFilter] call JB_fnc_passesTypeFilter) then { _object setVehicleLock "lockedplayer" };

	switch (true) do
	{
		// Give Zamack transports the same inventory as an Ifrit
		case (_object isKindOf "O_Truck_02_transport_F"): { [_object, "O_MRAP_02_F"] call JB_fnc_containerClone };

		// Prevent disassembly of spawned static weapons
		case (_object isKindOf "StaticWeapon"): { _object enableWeaponDisassembly false };

		// Prevent air crews from ejecting
		case (_object isKindOf "Air"): { _object allowCrewInImmobile true };

		// Put flags on all east and independent vehicles
		default
		{
			switch (side effectiveCommander _object) do
			{
				case east: { _object forceFlagTexture "\A3\Data_F\Flags\Flag_CSAT_CO.paa" };
				case independent: { _object forceFlagTexture "a3\data_f_exp\flags\flag_synd_co.paa" };
			};
		};
	};

	[[_object]] call SERVER_CurateEditableObjects;
};

OO_TRACE_DECL(SERVER_InitializeCategoryObject_Group) =
{
	params ["_category", "_group"];

	if (OO_INSTANCE_ISOFCLASS(_category,InfantryGarrisonCategory) && { not OO_GET(_category,InfantryGarrisonCategory,InitialForceCreated) }) then
	{
		_group setSpeedMode "limited";
		_group setBehaviour "safe";
		_group setCombatMode "white";
	}
	else
	{
		_group setSpeedMode "normal";
		_group setBehaviour "aware";
		_group setCombatMode "yellow";
	};

	{
		if (toLower typeOf _x in ["o_soldier_lat_f", "o_soldier_at_f", "o_soldier_aat_f"]) then { [_x, SERVER_Magazines_TitanToRPG, SERVER_Weapons_LauncherDowngrade] call JB_fnc_substituteEquipment };

		_x disableAI "minedetection";
	} forEach units _group;

	switch (side _group) do
	{
		case civilian : { [_category, _group] call SERVER_InitializeObject_Civilian };
		case independent : { [_category, _group] call SERVER_InitializeObject_Syndikat };
		case east : { [_category, _group] call SERVER_InitializeObject_CSAT };
	};

	[units _group] call SERVER_CurateEditableObjects;
};

OO_TRACE_DECL(SERVER_InitializeCategoryObject) =
{
	params ["_category", "_object"];

	if (_object isEqualType objNull) exitWith { [_category, _object] call SERVER_InitializeCategoryObject_Object };

	if (_object isEqualType grpNull) exitWith { [_category, _object] call SERVER_InitializeCategoryObject_Group };
};

OO_TRACE_DECL(SERVER_InitializeObject) =
{
	params ["_object"];

	if (_object isEqualType objNull) exitWith
	{
		if (not (_object isKindOf "Static")) then { [[_object]] call SERVER_CurateEditableObjects };
	};

	if (_object isEqualType grpNull) exitWith { [[units _object]] call SERVER_CurateEditableObjects };
};

OO_TRACE_DECL(SERVER_Infantry_MakeSpecialForces) =
{
	params ["_group", "_skillLevel"];

	private _headgear = "";
	switch (uniform leader _group) do
	{
		case "U_O_CombatUniform_ocamo": { _headgear = "H_HelmetO_ocamo" };
		case "U_O_CombatUniform_oucamo": { _headgear = "H_HelmetO_oucamo" };
	};

	{
		removeBackpack _x;

		removeHeadgear _x;
		_x addHeadgear _headgear;
		
		[_x, "CSAT_ScimitarRegiment"] call BIS_fnc_setUnitInsignia;

		[_x, _skillLevel] call SERVER_InitializeObject_SetSkill;

#ifdef SPECIAL_FORCES_NIGHT_VISION
		// If this is a night operation, give the special forces guys night vision gear.  Note that we have to make sure there's room
		// in his vest before adding the gear, so we empty the vest, add and wear the goggles, then give him back his vest items
		if ([] call SERVER_IsNightOperation) then
		{
			private _vest = vestContainer _x;
			private _magazines = getMagazineCargo _vest;
			clearMagazineCargoGlobal _vest;

			_x addItem "NVGoggles_OPFOR";
			_x assignItem "NVGoggles_OPFOR";

			{  _vest addItemCargoGlobal [_x, _magazines select 1 select _forEachIndex] } forEach (_magazines select 0);
		};
#endif
	} forEach units _group;
};

OO_TRACE_DECL(SERVER_Infantry_OnStartPatrol) =
{
	params ["_category", "_group"];

	if ((["Name"] call OO_METHOD(_category,Category,GetTagValue)) == "CSATSpecialForcesPatrol") then
	{
		private _garrison = OO_GET(_category,InfantryPatrolCategory,Garrison);
		private _skillLevel = OO_GET(_garrison,ForceCategory,SkillLevel);
		
		[_group, _skillLevel * 1.5] call SERVER_Infantry_MakeSpecialForces;
	};
};

OO_TRACE_DECL(SERVER_Ghosthawk_DoorManager) =
{
	_this spawn
	{
		params ["_vehicle"];

		scriptName "SERVER_Ghosthawk_DoorManager";

		private _doorsOpen = false;
		private _heightAGL = 0;

		while { alive _vehicle } do
		{
			_heightAGL = (getPosATL _vehicle) select 2;

			switch (true) do
			{
				case (not isEngineOn _vehicle):
				{
					if (not _doorsOpen) then
					{
						[[_vehicle], { { (_this select 0) animateDoor [_x, 1] } forEach ["Door_L", "Door_R"] }] remoteExec ["call", _vehicle];
						_doorsOpen = true;
					};

					sleep 5;
				};

				case (_doorsOpen):
				{
					if (_heightAGL > 25 || abs speed _vehicle > 100) then
					{
						[[_vehicle], { { (_this select 0) animateDoor [_x, 0] } forEach ["Door_L", "Door_R"] }] remoteExec ["call", _vehicle];
						_doorsOpen = false;
					};
					sleep ((log (abs (_heightAGL - 25) * 0.2)) max 0.1);
				};

				default // Doors are closed
				{
					if (_heightAGL < 10 && abs speed _vehicle < 40) then
					{
						[[_vehicle], { { (_this select 0) animateDoor [_x, 1] } forEach ["Door_L", "Door_R"] }] remoteExec ["call", _vehicle];
						_doorsOpen = true;
					};
					sleep ((log (abs (_heightAGL - 10) * 0.2)) max 0.1);
				};
			};
		};
	};
};

OO_TRACE_DECL(SERVER_Huron_RampManager) =
{
	_this spawn
	{
		params ["_vehicle"];

		scriptName "SERVER_Huron_RampManager";

		private _doorsOpen = false;
		private _heightAGL = 0;

		while { alive _vehicle } do
		{
			_heightAGL = (getPosATL _vehicle) select 2;

			switch (true) do
			{
				case (not isEngineOn _vehicle):
				{
					if (not _doorsOpen) then
					{
						[[_vehicle], { (_this select 0) animateDoor ["door_rear_source", 1] }] remoteExec ["call", _vehicle];
						_doorsOpen = true;
					};

					sleep 5;
				};

				case (_doorsOpen):
				{
					if (_heightAGL > 5 || abs speed _vehicle > 20) then
					{
						[[_vehicle], { (_this select 0) animateDoor ["door_rear_source", 0] }] remoteExec ["call", _vehicle];
						_doorsOpen = false;
					};
					sleep ((log (abs (_heightAGL - 3) * 0.2)) max 0.1);
				};

				default // Doors are closed
				{
					if (_heightAGL < 2 && abs speed _vehicle < 10) then
					{
						[[_vehicle], { (_this select 0) animateDoor ["door_rear_source", 1] }] remoteExec ["call", _vehicle];
						_doorsOpen = true;
					};
					sleep ((log (abs (_heightAGL - 1) * 0.2)) max 0.1);
				};
			};
		};
	};
};

OO_TRACE_DECL(SERVER_TaruPod_DoorManager) =
{
	_this spawn
	{
		params ["_vehicle"];

		scriptName "SERVER_TaruPod_DoorManager";

		private _doorsOpen = false;
		private _heightAGL = 0;

		while { alive _vehicle } do
		{
			_heightAGL = (getPosATL _vehicle) select 2;

			switch (true) do
			{
				case (isNull attachedTo _vehicle && isTouchingGround _vehicle):
				{
					if (not _doorsOpen) then
					{
						[_vehicle, 1] remoteExec ["TaruPod_AnimateDoors", _vehicle];
						_doorsOpen = true;
					};

					sleep 5;
				};

				case (_doorsOpen):
				{
					if (_heightAGL > 7 || abs speed _vehicle > 20) then
					{
						[_vehicle, 0] remoteExec ["TaruPod_AnimateDoors", _vehicle];
						_doorsOpen = false;
					};
					sleep ((log (abs (_heightAGL - 3) * 0.2)) max 0.1);
				};

				default // Doors are closed
				{
					if (_heightAGL < 4 && abs speed _vehicle < 10) then
					{
						[_vehicle, 1] remoteExec ["TaruPod_AnimateDoors", _vehicle];
						_doorsOpen = true;
					};
					sleep ((log (abs (_heightAGL - 1) * 0.2)) max 0.1);
				};
			};
		};
	};
};

OO_TRACE_DECL(SERVER_Blackfish_RampManager) =
{
	_this spawn
	{
		params ["_vehicle"];

		scriptName "SERVER_Blackfish_RampManager";

		private _doorsOpen = false;
		private _heightAGL = 0;

		while { alive _vehicle } do
		{
			_heightAGL = (getPosATL _vehicle) select 2;

			switch (true) do
			{
				case (not isEngineOn _vehicle):
				{
					if (not _doorsOpen) then
					{
						[[_vehicle], { (_this select 0) animateDoor ["door_1_source", 1] }] remoteExec ["call", _vehicle];
						_doorsOpen = true;
					};

					sleep 5;
				};

				case (_doorsOpen):
				{
					if (_heightAGL > 5 || abs speed _vehicle > 20) then
					{
						[[_vehicle], { (_this select 0) animateDoor ["door_1_source", 0] }] remoteExec ["call", _vehicle];
						_doorsOpen = false;
					};
					sleep ((log (abs (_heightAGL - 3) * 0.2)) max 0.1);
				};

				default // Doors are closed
				{
					if (_heightAGL < 2 && abs speed _vehicle < 10) then
					{
						[[_vehicle], { (_this select 0) animateDoor ["door_1_source", 1] }] remoteExec ["call", _vehicle];
						_doorsOpen = true;
					};
					sleep ((log (abs (_heightAGL - 1) * 0.2)) max 0.1);
				};
			};
		};
	};
};

SERVER_SetTaruInvulnerableNearPods =
{
	_this spawn
	{
		params ["_taru"];

		scriptName "SERVER_SetTaruInvulnerableNearPods";

		private _allowDamage = true;

		while { alive _taru } do
		{
			_allowDamage = true;

			if (isEngineOn _taru && { count crew _taru > 0 }) then
			{
				if (attachedObjects _taru findIf { _x isKindOf "Pod_Heli_Transport_04_crewed_base_F" || _x isKindOf "Pod_Heli_Transport_04_base_F"} == -1) then
				{
					private _nearPods = nearestObjects [getPos _taru, ["Pod_Heli_Transport_04_crewed_base_F", "Pod_Heli_Transport_04_base_F"], 15, false]; // sizeOf Taru is 25
					if (count _nearPods > 0) then
					{
						_allowDamage = false;
					};
				};
			};

			if (not (isDamageAllowed _taru isEqualTo _allowDamage)) then
			{
				[_taru, _allowDamage] remoteExec ["allowDamage", 0];
			};

			sleep 1.0;
		};
	};
};

OO_TRACE_DECL(SERVER_OperationBlacklist) =
{
	params ["_paddingFromBases", "_paddingFromStrongpoints", "_paddingFromAdvance"];

	private _blacklist = [];

	if (_paddingFromAdvance != -1) then { _blacklist append (Advance_Sites apply { [_paddingFromAdvance, _x select 1] }) };

	if (_paddingFromStrongpoints != -1) then
	{
		private _parameters = [_blacklist];
		private _code =
			{
				params ["_blacklist"];
				_blacklist pushBack [OO_GET(_x,Strongpoint,ControlRadius) + _paddingFromStrongpoints, OO_GET(_x,Strongpoint,Position)];
				false
			};
		OO_FOREACHINSTANCE(Strongpoint,_parameters,_code);
	};

	if (_paddingFromBases != -1) then
	{
		_blacklist pushBack ([_paddingFromBases, getPos Headquarters] + triggerArea Headquarters);
		_blacklist pushBack ([_paddingFromBases, getPos Carrier] + triggerArea Carrier);
	};

	_blacklist
};

SERVER_Proximity_CS = call JB_fnc_criticalSectionCreate;

SERVER_ProximityRequests = [];
SERVER_RequestProximityRound =
{
	params [["_minProximity", 0, [0]], ["_maxProximity", 100, [0]], ["_direction", 0, [0]], ["_sweepAngle", 360, [0]], ["_roundType", "SmallSecondary", [""]]];

	private _players = allPlayers select { owner _x == remoteExecutedOwner };
	if (count _players == 0) exitWith {};

	SERVER_Proximity_CS call JB_fnc_criticalSectionEnter;

	SERVER_ProximityRequests pushBack ([_players select 0] + _this);

	SERVER_Proximity_CS call JB_fnc_criticalSectionLeave;
};

SERVER_MonitorProximityRoundRequests =
{
	[] spawn
	{
		private _requests = [];
		private _samples = [];
		private _sample = [];
		private _impact = [];
		private _extrapolated = [];
		private _round = objNull;

		private _proximityDelay = 1.0;
		private _speed = 0;

		private _samplesDirection = [];

		while { sleep 1; isNil "SERVER_MonitorProximityRoundRequests_STOP" } do
		{
			SERVER_Proximity_CS call JB_fnc_criticalSectionEnter;

			_requests = SERVER_ProximityRequests;
			SERVER_ProximityRequests = [];

			SERVER_Proximity_CS call JB_fnc_criticalSectionLeave;

			{
				_x params ["_unit", "_minProximity", "_maxProximity", "_direction", "_sweepAngle", "_roundType"];

				_proximityDelay = 0;
				_sound = [];
				_speed = 0;
				
				if (getNumber (configFile >> "CfgAmmo" >> _roundType >> "timeToLive") > 5) then
				{
					private _fall = getArray (configFile >> "CfgAmmo" >> _roundType >> "soundFakeFall");
					if (count _fall > 0) then
					{
						_sound = getArray (configFile >> "CfgAmmo" >> _roundType >> selectRandomWeighted _fall);
						_proximityDelay = 4.95; // The duration of the shell drop sound.  Here's hoping the only sound is the shell sound.
						_speed = getNumber (configFile >> "CfgAmmo" >> _roundType >> "typicalSpeed");
					};
				};

				_samples = [(getPos _unit) vectorAdd ((velocity _unit) vectorMultiply _proximityDelay), _minProximity, _maxProximity, (_maxProximity * 0.2) max 1.0] call SPM_Util_SampleAreaGrid;

				// Samples that are in the requested direction
				_samplesDirection = [];
				[_samples, getPos _unit, _direction, _sweepAngle, _samplesDirection] call SPM_Util_ExcludeSamplesByDirection;

				// Samples that are not inside _minProximity of another player (account for movement by player)
				_extrapolated = allPlayers apply { (getPos _x) vectorAdd ((velocity _x) vectorMultiply _proximityDelay) };
				_samples = _samplesDirection select { _sample = _x; _extrapolated findIf { _sample distance2D _x < _minProximity } == -1 };

				if (count _samples > 0) then
				{
					if (getNumber (configFile >> "CfgAmmo" >> _roundType >> "timeToLive") < 2) then
					{
						_sample = ATLtoASL (selectRandom _samples);

						_impact = lineIntersectsSurfaces [_sample vectorAdd [0,0,20], _sample vectorAdd [0,0,-1], objNull, objNull, true, 1, "VIEW", "", true];
						_impact = ASLtoATL (_impact select 0 select 0);
						if (vehicle _unit isKindOf "Air") then { _impact set [2, ((_unit select 2) - _maxProximity + random (_maxProximity * 2)) max 0.0] };

						_round = _roundType createVehicle _impact;

						// Slam into ground to detonate
						_round setVelocity [0,0,-100];

						// Detonate directly
						_round setDamage 1;
					}
					else
					{
						// Mortar and artillery rounds
						_sample = selectRandom _samples;
						_round = _roundType createVehicle (_sample vectorAdd [0,0,_speed * _proximityDelay]);
						playSound3D [(_sound select 0) + ".wss", objNull, false, _sample, _sound select 1, _sound select 2, _sound select 3];
						_round setVelocity [0,0,-_speed];
					};
				};
			} forEach _requests;
		};
	};
};

Logistics_SourceResources = [];

Logistics_GetSourceResources =
{
	params ["_tag"];

	private _index = Logistics_SourceResources findIf { (_x select 0) == _tag };
	if (_index == -1) exitWith { [] };

	Logistics_SourceResources select _index select 1
};

Logistics_SetSourceResources =
{
	params ["_tag", "_resources"];

	private _index = Logistics_SourceResources findIf { (_x select 0) == _tag };

	if (_index == -1) then { _index = count Logistics_SourceResources };

	Logistics_SourceResources set [_index, [_tag, _resources]];
};