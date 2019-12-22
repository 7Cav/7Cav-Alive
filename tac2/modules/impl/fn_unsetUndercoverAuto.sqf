/* 
 * Author: Bojan
 * Removes a players 'undercover' state, and destroy EH if they have them
 * Executes on the local players machine
*/ 
_EHWeapon = player getVariable ["undercoverEHWeapon",-1];
if (_EHWeapon > 0) then {
	["weapon", _EHWeapon] call CBA_fnc_removePlayerEventHandler;
	player setVariable ["undercoverEHWeapon", nil];
};

_EHFiredAce = player getVariable ["undercoverEHFiredAce",-1];
if (_EHFiredAce > 0) then {
	["ace_firedPlayer", _EHFiredAce] call CBA_fnc_removeEventHandler;
	player setVariable ["undercoverEHFiredAce", nil];
};

_EHRespawn = player getVariable ["undercoverEHRespawn",-1];
if (_EHRespawn > 0) then {
	player removeEventHandler ["Respawn", _EHRespawn];
	player setVariable ["undercoverEHRespawn", nil];
};

player setVariable ["coverBlown", nil];
player setVariable ["coverTempBlown", nil];
player setCaptive false;
titleText ["Your cover is blown!", "plain", 1];