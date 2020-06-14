SERVER_CMD_HandleCommandLoyaltyPoints =
{
	params ["_arguments", "_caller"];
	_arguments params ["_recipientType", "_name", "_amount"];
	if (count _arguments != 3) exitWith { ["Invalid format. Expected: #mc loyalty points [player|group] <name of player> <amount>"] call SERVER_CMD_MessageCaller; };

	_amount = parseNumber _amount;

	private _subjectObject = [_name] call SERVER_CMD_GetPlayerByName;
	if (isNull _subjectObject) exitWith {};

	private _targets = [];
	if ("player" find _recipientType == 0) then { _targets = [_subjectObject] };
	if ("group" find _recipientType == 0) then { _targets = (units (group _subjectObject)) select { isPlayer _x } };

	{
		[[_amount], LOYALTY_fnc_addPointsLocal] remoteExec ["call", _x];
	} forEach _targets;


	[format ["%1 loyalty points have been added", _amount]] call SERVER_CMD_MessageCaller;
};

SERVER_CMD_HandleCommandLoyaltyCooldown =
{
	params ["_arguments", "_caller"];
	_arguments params ["_name", "_cooldown"];
	if (count _arguments != 2) exitWith { ["Invalid format. Expected: #mc loyalty cooldown <name of player> <length in minutes>"] call SERVER_CMD_MessageCaller; };

	private _subjectObject = [_name] call SERVER_CMD_GetPlayerByName;
	if (isNull _subjectObject) exitWith {};

	[[_cooldown], LOYALTY_fnc_setCooldownLocal] remoteExec ["call", _subjectObject];
	[format ["%1 minutes of cooldown has been set for %2", _cooldown, name _subjectObject]] call SERVER_CMD_MessageCaller;
};

SERVER_CMD_HandleCommandLoyaltyCavBucks =
{
	params ["_arguments", "_caller"];
	_arguments params ["_recipientType", "_name", "_amount"];
	if (count _arguments != 3) exitWith { ["Invalid format. Expected: #mc loyalty cavbucks [player|group] <name of player> <amount>"] call SERVER_CMD_MessageCaller; };

	_amount = parseNumber _amount;

	private _subjectObject = [_name] call SERVER_CMD_GetPlayerByName;
	if (isNull _subjectObject) exitWith {};

	private _targets = [];
	if ("player" find _recipientType == 0) then { _targets = [_subjectObject] };
	if ("group" find _recipientType == 0) then { _targets = (units (group _subjectObject)) select { isPlayer _x } };

	{
		[[_amount], LOYALTY_fnc_addCavBucksLocal] remoteExec ["call", _x];
	} forEach _targets;


	[format ["%1 CavBucks(tm) have been added", _amount]] call SERVER_CMD_MessageCaller;
};

SERVER_CMD_HandleCommandLoyalty =
{
	params ["_commandWords", "_caller"];

	private _commands = [
		["points", SERVER_CMD_HandleCommandLoyaltyPoints],
		["cooldown", SERVER_CMD_HandleCommandLoyaltyCooldown],
		["cavbucks", SERVER_CMD_HandleCommandLoyaltyCavBucks]
	];

	private _match = [_commandWords select 0, _commands] call SERVER_CMD_MatchCommand;
	[_commandWords, _match, _caller, _commands] call SERVER_CMD_HandleMatch;
};

ROOT_MC_COMMANDS pushBack ["loyalty", SERVER_CMD_HandleCommandLoyalty];
