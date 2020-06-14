CLIENT_DB_Select = 
{
	params ["_table", "_id", ["_callBack", {}]];
	[_table, _id, _callback] remoteExec ['SERVER_DB_Select', 2];
};

CLIENT_DB_SelectFirst = 
{
	params ["_table", "_id", ["_callBack", {}]];
	[_table, _id, _callback] remoteExec ['SERVER_DB_SelectFirst', 2];
};

CLIENT_DB_Insert =
{
	params ["_table", "_params", ["_callBack", {}]];
	[_table, _params, _callback] remoteExec ['SERVER_DB_Insert', 2];
};

CLIENT_DB_Update =
{
	params ["_table", "_id", "_params", ["_callBack", {}]];
	[_table, _id, _params, _callback] remoteExec ['SERVER_DB_Update', 2];
};