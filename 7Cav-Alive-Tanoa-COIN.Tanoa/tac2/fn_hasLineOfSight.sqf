params ["_player", "_bad", "_fov"];

private _hasLOS = true;
private _eyePosPlayer = eyePos _player;
private _eyePosBad = eyePos _bad;

private _eyeDirBV = eyeDirection _bad;
private _eyeDirB = ((_eyeDirBV select 0) atan2 (_eyeDirBV select 1));
if (_eyeDirB < 0) then {_eyeDirB = 360 + _eyeDirB};

_dirTo = [_bad, _player] call BIS_fnc_dirTo;

// Check if player is within FOV of the unit
if ( (abs(_dirTo - _eyeDirB) >= (180-_fov)) && (abs(_dirTo - _eyeDirB) <= (360-_fov)) ) then {
	_hasLOS = false;
} else {
	// Player is within FOV, is there anything between them?
	if (count (lineIntersectsSurfaces [eyepos _bad, eyePos player, _bad, player]) > 0) then { 
		_hasLOS = false;
	};
};

_hasLOS

