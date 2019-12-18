params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];
private _selectedObjects = if (isNull _objectUnderCursor) then
	{
		["Objects"] call Achilles_fnc_SelectUnits;
	}
	else
	{
		[_objectUnderCursor];
	};

{
		[] remoteExec ["Tac2_fnc_unsetUndercoverAuto", _x];
} forEach _selectedObjects