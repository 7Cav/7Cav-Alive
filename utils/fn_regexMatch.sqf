params ["_string", "_pattern"];

_string = toString [1] + _string + toString [2];
_pattern = (toString [1] + _pattern + toString [2]) splitstring "*";

private _match = true;
private _index = -1;
for "_i" from 0 to count _pattern - 1 do
{
	_index = _string find (_pattern select _i);
	if (_index == -1) exitWith { _match = false };
	_string = _string select [_index + count (_pattern select _i)];
};

_match && (count _string == 0)