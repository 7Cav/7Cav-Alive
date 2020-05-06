params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]]; 
private _obj = nearestTerrainObjects [_position,[],10]; 

_obj = _obj select {
	typeof _x != ""
};
	if (count _obj == 0) exitWith {};
_obj = _obj select 0;

private _newObj = typeof _obj createVehicle getPos _obj;
[[_newObj]] remoteExec ["SERVER_CurateEditableObjects", 2];