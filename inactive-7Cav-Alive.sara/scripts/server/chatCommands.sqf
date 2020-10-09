COMMAND_MATCH = 0;
COMMAND_NOTFOUND = -1;
COMMAND_AMBIGUOUS = -2;
ROOT_DD_COMMANDS = [];
ROOT_MC_COMMANDS = [];
ROOT_MP_COMMANDS = [];
ROOT_RG_COMMANDS = [];

#include ".\chatCommands\logistics.sqf"
#include ".\chatCommands\teleport.sqf"

SERVER_CMD_RootCommands = 
{
	params ["_commandWords", "_caller", "_commandNamespace"];

	private _availableCommands = [];
	switch (_commandNamespace) do {
		case "DD": { _availableCommands = ROOT_DD_COMMANDS };
		case "MC": { _availableCommands = ROOT_MC_COMMANDS };
		case "MP": { _availableCommands = ROOT_MP_COMMANDS };
		default { _availableCommands = ROOT_RG_COMMANDS };
	};

	private _match = [_commandWords select 0, _availableCommands] call SERVER_CMD_MatchCommand;
	[_commandWords, _match, _caller, _availableCommands] call SERVER_CMD_HandleMatch;
};

SERVER_CMD_HandleCommand = 
{
	params ["_commandString", "_caller", "_commandNamespace"];

	private _commandWords = _commandString splitString " ";
	[_commandWords, _caller, _commandNamespace] call SERVER_CMD_RootCommands;
};

SERVER_CMD_MessageCaller =
{
	params ["_message"];
	[_message] remoteExec ["systemChat", remoteExecutedOwner];
};

SERVER_CMD_HandleMatch = 
{
	params ["_commandWords", "_match", "_caller", "_availableCommands"];
	_match params ["_matchedStatus", "_matchedCommand"];

	if (_matchedStatus == COMMAND_MATCH) then {
		[_commandWords select [1, 1e3], _caller] call _matchedCommand;
	};

	if (_matchedStatus == COMMAND_NOTFOUND) then {
		[
			format [
				"%1 - Command not found. Possible commands are: %2", 
				(_commandWords select 0), 
				(_availableCommands apply { _x select 0 } joinString ", ")
			]
		] call SERVER_CMD_MessageCaller;
	};

	if (_matchedStatus == COMMAND_AMBIGUOUS) then {
		[
			format [
				"%1 - Ambiguous command. Possible commands are: %2", 
				(_commandWords select 0), 
				(_availableCommands apply { _x select 0 } joinString ", ")
			]
		] call SERVER_CMD_MessageCaller;
	};
};

SERVER_CMD_MatchCommand = 
{
	params ["_commandSearchTerm", "_commands"];

	if (isNil "_commandSearchTerm") exitWith { [COMMAND_NOTFOUND, {}] };

	private _result = [COMMAND_NOTFOUND, {}];

	{
		private _commandName = toLower (_x select 0);

		if (_commandName == _commandSearchTerm) exitWith {
			_result = [COMMAND_MATCH, _x select 1];
		};

		private _partialMatch = _commandName find _commandSearchTerm == 0;

		if (_partialMatch && (_result select 0) == COMMAND_MATCH) exitWith {
			_result = [COMMAND_AMBIGUOUS, ''];
		};

		if (_partialMatch) then {
			_result = [COMMAND_MATCH, _x select 1];
		};
	} forEach _commands;


	_result
};
