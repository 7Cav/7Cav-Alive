SERVER_CMD_HandleCommandFortifyRemove = 
{
	params ["_arguments", "_caller"];
	private _points = (parseNumber (_arguments select 0)) * -1;

	[west, _points, true] call acex_fortify_fnc_updateBudget;
	[format ["%1 points have been added to the FOB budget", _points]] call SERVER_CMD_MessageCaller;
};

SERVER_CMD_HandleCommandFortifyAdd =
{
	params ["_arguments", "_caller"];
	private _points = parseNumber (_arguments select 0);
	[west, _points, true] call acex_fortify_fnc_updateBudget;
	[format ["%1 points have been added to the FOB budget", _points]] call SERVER_CMD_MessageCaller;
};

SERVER_CMD_HandleCommandFortify =
{
	params ["_commandWords", "_caller"];

	private _commands = [
		["add", SERVER_CMD_HandleCommandFortifyAdd],
		["remove", SERVER_CMD_HandleCommandFortifyRemove]
	];

	private _match = [_commandWords select 0, _commands] call SERVER_CMD_MatchCommand;
	[_commandWords, _match, _caller, _commands] call SERVER_CMD_HandleMatch;
};

ROOT_MC_COMMANDS pushBack ["fortify", SERVER_CMD_HandleCommandFortify];
