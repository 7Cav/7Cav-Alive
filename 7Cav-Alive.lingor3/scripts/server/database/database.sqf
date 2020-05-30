SERVER_DB_Select = 
{
	params ["_table", "_id", ["_callBack", {}]];
	private _query = format ["SELECT * FROM %1 WHERE id = %2", _table, _id];
	private _response = ["executeQuery", _query] call EXTDB3;

	if (_callback isEqualTo {}) exitWith { _response };
	[[_response], _callBack] remoteExec ["call", remoteExecutedOwner];
};

SERVER_DB_SelectFirst = 
{
	params ["_table", "_id", ["_callBack", {}]];
	private _response = ([_table, _id] call SERVER_DB_Select);
	if (count _response == 0) then {
		_response = [] 
	} else {
		_response = _response select 0;
	};

	if (_callback isEqualTo {}) exitWith { _response };
	[[_response], _callBack] remoteExec ["call", remoteExecutedOwner];
};

SERVER_DB_Insert =
{
	params ["_table", "_params", ["_callBack", {}]];
	private _fields = [_params] call CBA_fnc_hashKeys;
	private _values = [];
	{
		_values pushBack str ([_params, _x] call CBA_fnc_hashGet)
	} forEach _fields;

	private _query = format ["INSERT INTO %1 (%2) VALUES (%3);", _table, _fields joinString ", ", _values joinString ", "];
	private _response = ["executeQuery", _query] call EXTDB3;

	if (_callback isEqualTo {}) exitWith { _response };
	[[_response], _callBack] remoteExec ["call", remoteExecutedOwner];
};

SERVER_DB_Update =
{
	params ["_table", "_id", "_params", ["_callBack", {}]];
	private _fields = [_params] call CBA_fnc_hashKeys;
	private _numFields = count _fields;

	private _query = format ["UPDATE %1 SET ", _table];
	{
		private _field = ([_params, _x] call CBA_fnc_hashGet);
		if (typeName _field == 'STRING' && {_field find "#>" == 0}) then {
			_query = _query + _x + "=" + (_field select [2, 1e3]);
		} else {
			_query = _query + _x + "=" + str _field;
		};

		if (_forEachIndex + 1 < _numFields) then { _query = _query + ", " };
	} forEach _fields;
	_query = _query + " WHERE id = " + _id;
	private _response = ["executeQuery", _query] call EXTDB3;

	if (_callback isEqualTo {}) exitWith { _response };
	[[_response], _callBack] remoteExec ["call", remoteExecutedOwner];
};

SERVER_DB_Exec =
{
	params ["_query", "_callBack"];
	[[["executeQuery", _query] call EXTDB3], _callBack] remoteExec ["call", remoteExecutedOwner];
};