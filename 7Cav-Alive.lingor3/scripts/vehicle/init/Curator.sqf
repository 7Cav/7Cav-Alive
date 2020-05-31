if (not isServer) exitWith {};

params ["_curator"];

if (isNil "SERVER_CuratorMaster" || { isNull SERVER_CuratorMaster }) then
{
	SERVER_CuratorMaster = _curator;
};

[_curator, [-1, -2, 0]] call BIS_fnc_setCuratorVisionModes;
