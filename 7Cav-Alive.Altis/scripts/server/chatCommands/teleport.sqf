SERVER_CMD_HandleCommandTeleport = 
{
	params ["_arguments", "_caller"];
	if (count _arguments != 4) exitWith { ["Invalid format. Expected: #mp teleport [player|vehicle] <name> [player] <name>"] call SERVER_CMD_MessageCaller; };
	_arguments params ["_subjectType", "_subject", "_targetType", "_target"];

	private _subjectObject = [_subject] call SERVER_CMD_GetPlayerByName;
	if (isNull _subjectObject) exitWith {};

	if ("player" find _subjectType == 0) then {};
	if ("vehicle" find _subjectType == 0) then { _subjectObject = vehicle _subjectObject };


	private _targetObject = [_target] call SERVER_CMD_GetPlayerByName;
	if (isNull _targetObject) exitWith {};

	[
		[_subjectObject, (getPosASL _targetObject)], 
		{ 
			["An MP is teleporting you...", 3] call utils_fnc_showBlackScreenMessage; 
			sleep 2; 
			(_this select 0) setPosASL ((_this select 1) vectorAdd [0,0,100]); 
			(_this select 0) setPosASL (_this select 1) }
	] remoteExec ["spawn", _subjectObject];

	[format ["Player '%1' teleported to '%2'", name _subjectObject, name _targetObject]] call SERVER_CMD_MessageCaller;
};


SERVER_CMD_GetPlayerByName =
{
	params ["_name"];

	private _lowerName = toLower _name;

	private _players = [];
	{
		if (toLower (name _x) == _lowerName) exitWith { _players = [_x] };
		if ((toLower name _x) find _lowerName >= 0) then { _players pushBack _x };
	} forEach (allPlayers select { not (_x isKindOf "HeadlessClient_F") });

	if (count _players == 0) exitWith { [format ["No player names contain '%1'", _name]] call SERVER_CMD_MessageCaller; objNull };
	if (count _players > 1) exitWith { [format ["'%1' is ambiguous, matching %2 player names (%3)", _name, count _players, _players joinString ", "]] call SERVER_CMD_MessageCaller; objNull };

	_players select 0
};

ROOT_MP_COMMANDS pushBack ["teleport", SERVER_CMD_HandleCommandTeleport];
