private _vehicle = _this select 0;
private _vehicleName = _this select 1;

if (_vehicleName != "") then
{
	missionNamespace setVariable [_vehicleName, _vehicle];
	[_vehicle, _vehicleName] remoteExec ["setVehicleVarName"]

//	private _command = format["[ { (objectFromNetID '%1') setVehicleVarName '%2' } ]", netID _vehicle, _vehicleName];
//	(call compile _command) remoteExec ["BIS_fnc_spawn"];
};