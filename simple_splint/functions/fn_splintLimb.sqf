/*
Name: SimpleSplint
Author: Bojan

Plays an animation and shows the ACE progress bar
*/
params ["_hitPoint", "_selectionNumbers", "_player", "_target"];

// Play animation only if on-foot
if (_player == vehicle _player) then { 
	_player playMove "AinvPknlMstpSlayWrflDnon_medicOther";
};

private _splint_time = missionNamespace getVariable ["simple_splint_time",20];

_onInterrupt = {
	// Don't do animations in vehicle
	params ["_args"];
	_args params ["_hitPoint", "_selectionNumbers", "_player", "_target"];
	if (_player == vehicle _player) then { 
		_player switchMove "AmovPknlMstpSrasWrflDnon"
	 };
};

// _checkDistance = {
// 	params ["_args"];
// 	_args params ["_hitPoint", "_selectionNumbers", "_player", "_target"];

// 	// Both players are in a vehicle
// 	if (_player == vehicle _player && _target == vehicle _player) exitWith { true };

// 	if(_player distance _target < 5) { exitWith true };

// 	false;
// };

[_splint_time, [_hitPoint, _selectionNumbers, _player, _target], simple_splint_fnc_fixLimb, _onInterrupt, "Applying SAM Splint", {true}, ["isNotInside", "isNotSwimming"]] call ace_common_fnc_progressBar;
