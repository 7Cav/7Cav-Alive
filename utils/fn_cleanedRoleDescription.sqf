/*
	Author: JB
*/

params ["_description"];

private _paren = _description find "(";
if (_paren >= 0) then
{
	_description = _description select [0, _paren];
	_description = [_description, "end"] call utils_fnc_trimWhitespace;
};

_description;