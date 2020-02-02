/*
	Author: JB
*/

params ["_owner"];

private _player = objNull; // Server (_owner == 2) returns objNull
{
	if ((_x getVariable ["CLIENT_Owner", objNull]) == _owner) exitWith { _player = _x };
} forEach allPlayers;

_player