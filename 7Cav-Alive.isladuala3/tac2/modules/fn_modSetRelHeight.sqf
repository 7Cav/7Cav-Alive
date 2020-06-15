params [["_position", [0,0,0], [[]], 3], ["_baseObject", objNull, [objNull]]];
private _objs = ["Objects"] call Achilles_fnc_SelectUnits;
private _baseZ = getPos _baseObject select 2;
{
	private _objX = getPos _x select 0;
	private _objY = getPos _x select 1;
	_x setPos [_objX, _objY, _baseZ];
} forEach _objs;