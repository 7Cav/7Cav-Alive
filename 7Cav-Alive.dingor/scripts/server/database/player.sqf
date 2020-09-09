SERVER_DB_OnPlayerLogin = 
{
	params ["_player", "_callBack"];
	private _playerObj = ["players", getPlayerUID _player] call SERVER_DB_SelectFirst;
	if (_playerObj isEqualTo []) then {

		private _newPlayerParams = [[
			["id", getPlayerUID _player], 
			["name", name _player]
		]] call CBA_fnc_hashCreate;
		["players", _newPlayerParams, _callBack] call SERVER_DB_Insert;

	} else {

		private _updatePlayerParams = [[
			["name", name _player],
			["last_login", "#>now()"]
		]] call CBA_fnc_hashCreate;
		["players",  getPlayerUID _player, _updatePlayerParams, _callBack] call SERVER_DB_Update;
	};
};