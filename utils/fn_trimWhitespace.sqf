private _string = param [0, "", [""]];
private _location = param [1, "", [""]];

private _stringArray = toArray _string;

if (_location == "end" || _location == "both") then
{
	for "_i" from (count _stringArray) - 1 to 0 step -1 do
	{
		if (_stringArray select _i != 32) exitWith {};
		_stringArray deleteAt _i;
	};
};

if (_location == "beginning" || _location == "both") then
{
	while { count _stringArray > 0 && { _stringArray select 0 == 32 }} do
	{
		_stringArray deleteAt 0;
	};
};

toString _stringArray;