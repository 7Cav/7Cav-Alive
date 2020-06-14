SERVER_CuratorMaster = objNull;
SERVER_MissionControllers = [];
SERVER_MilitaryPolice = [];
SERVER_CameraOperators = [];

// This is run on every player respawn, adding the player to the servers editabled objects
// and, if valid, grants the player curator permissions
SERVER_CuratePlayer = 
{
	params ["_player"];

	[[_player]] call SERVER_CurateEditableObjects;

	[_player] call SERVER_CuratorAssign;
};

// Gets called for every player on (re)spawn, assigns curator if needed, enforces
// role requirements (removing players from slots they aren't alloweed to be in)
SERVER_CuratorAssign = 
{
	params ["_player"];

	// Don't touch players who already have Zeus assigned & validate the caching system is operating
	if (not isNull getAssignedCuratorLogic _player) exitWith {};
	if (isNull SERVER_CuratorMaster) exitWith {};

	private _curatorType = [_player] call SERVER_CuratorType;

	// Boot players who are not allowed to be in this slot
	if (not ([_player, _curatorType, roleDescription _player] call SERVER_MeetsRoleRequirement)) exitWith { 
		[] remoteExec ["CLIENT_DoesNotMeetRequirements", _player] 
	};

	if (not (_curatorType in ["MC", "MP", "CO"])) exitWith {};

	// Find an unused curator logic
	private _curator = objNull;
	{
		if (isNull getAssignedCuratorUnit _x && _x != SERVER_CuratorMaster) exitWith
		{
			_curator = _x;
		};
	} forEach allCurators;

	// If we found an empty logic
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

	[_curatorType] remoteExec ["CLIENT_SetCuratorType", _player];
	[[_player, _curatorType], "CLIENT_AnnounceCurator"] call SERVER_RemoteExecCurators;
};

// Check if a given curatorType is allowed to use a role
// Regular players (curatorType = "") only meet the default requirement
SERVER_MeetsRoleRequirement = 
{
	params ["_player", "_curatorType", "_roleDescription"];
	
	private _requirements = [roleDescription _player] call SERVER_RoleRequirements;
	_curatorType in _requirements
};

// Define curator type required for each type of slot
SERVER_RoleRequirements =
{
	params ["_roleDescription"];

	_roleDescription = [toLower _roleDescription] call utils_fnc_cleanedRoleDescription;

	private _requiredMissionControllers = [ "mission controlle*" ];
	if (_requiredMissionControllers findIf { [_roleDescription, _x] call utils_fnc_regexMatch } >= 0) exitWith { ["MC"] };

	private _requiredMilitaryPolice = [ "military polic*" ];
	if (_requiredMilitaryPolice findIf { [_roleDescription, _x] call utils_fnc_regexMatch } >= 0) exitWith { ["MC", "MP"] };

	private _requiredCameraOperators = [ "camera operator" ];
	if (_requiredCameraOperators findIf { [_roleDescription, _x] call utils_fnc_regexMatch } >= 0) exitWith { ["MC", "MP", "CO"] };

	["MC", "MP", "CO", ""]
};

// Get a players curator type base on their in-game role and GUID
SERVER_CuratorType =
{
	params ["_player"];

	private _curatorTypeByID = "";
	private _curatorTypeByRole = "";

	_curatorTypeByID = [getPlayerUID _player] call SERVER_CuratorTypeBySteamID;
	if (_curatorTypeByID == "DD") exitWith { "MC" };

	_curatorTypeByRole = [roleDescription _player] call SERVER_CuratorTypeByRole;

	if (_curatorTypeByID == "MC" && _curatorTypeByRole == "MC") exitWith { "MC" };
	if (_curatorTypeByID in ["MC", "MP"] && _curatorTypeByRole in ["MC", "MP"]) exitWith { "MP" };
	if (_curatorTypeByID in ["MC", "MP", "CO"] && _curatorTypeByRole in ["MC", "MP", "CO"]) exitWith { "CO" };

	""
};

// Get the curator type based on the players steam ID
SERVER_CuratorTypeBySteamID =
{
	params ["_uid"];

	private _uidDevelopers = [];
	_uidDevelopers pushBackUnique "76561198048006094"; // Bojan
	if (_uid in _uidDevelopers) exitWith { "DD" };

	// To be re-enabled once S6 comes up with a way of handling this
	// (["players", _uid] call SERVER_DB_SelectFirst) select 4

	private _uids = call SERVER_ZeusGuids;

	_uids params ["_uidDevelopers", "_uidMissionControllers", "_uidMilitaryPolice", "_uidCameraOperators"];

	if (_uid in _uidDevelopers) exitWith { "DD" };
	if (_uid in _uidMissionControllers) exitWith { "MC" };
	if (_uid in _uidMilitaryPolice) exitWith { "MP" };
	if (_uid in _uidCameraOperators) exitWith { "CO" };

	""
};

// To be replaced by database
SERVER_ZeusGuids = 
{
	private _uidDevelopers = [];
	private _uidMissionControllers = [];
	private _uidMilitaryPolice = [];
	private _uidCameraOperators = [];

	#include "\serverscripts\zeusserverscripts\tac2_zeus_guids.sqf"

	[_uidDevelopers, _uidMissionControllers, _uidMilitaryPolice, _uidCameraOperators]
};

// Get the curator type based on the players role (slot)
SERVER_CuratorTypeByRole = 
{
	params ["_roleDescription"];
	_roleDescription = [toLower _roleDescription] call utils_fnc_cleanedRoleDescription;

	private _roleMissionControllers = [ "mission controlle*" ];
	if (_roleMissionControllers findIf { [_roleDescription, _x] call utils_fnc_regexMatch } >= 0) exitWith { "MC" };

	private _roleMilitaryPolice = [ "military polic*" ];
	if (_roleMilitaryPolice findIf { [_roleDescription, _x] call utils_fnc_regexMatch } >= 0) exitWith { "MP" };

	private _roleCameraOperators = [ "camera operator" ];
	if (_roleCameraOperators findIf { [_roleDescription, _x] call utils_fnc_regexMatch } >= 0) exitWith { "CO" };

	""
};

// Helper script to add an object to the list of curator objects
// Also adds objects to the SERVER_CuratorMaster to help with syncing objects between curators
SERVER_CurateEditableObjects = 
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

SERVER_CuratorUnassign =
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

// Execute a remote command on a specific subset of curators
SERVER_RemoteExecCurators = 
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

SERVER_RemoteCallerCuratorType =
{
	private _caller = [remoteExecutedOwner] call utils_fnc_getOwnerPlayer;

	if (isNull _caller) exitWith { "" };

	private _curator = getAssignedCuratorLogic _caller;

	if (isNull _curator) exitWith { "" };

	if (_curator in SERVER_MissionControllers) exitWith { "MC" };

	if (_curator in SERVER_MilitaryPolice) exitWith { "MP" };

	"CO"
};

SERVER_InitializeObject =
{
	params ["_object"];

	if (_object isEqualType objNull) exitWith
	{
		if (not (_object isKindOf "Static")) then { [[_object]] call SERVER_CurateEditableObjects };
	};

	if (_object isEqualType grpNull) exitWith { [[units _object]] call SERVER_CurateEditableObjects };
};
