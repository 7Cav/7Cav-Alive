/* 
 * Author: Bojan
 * Makes a unit undercover, adds event handlers if the unit blows their cover
 * Executes on the local players machine
 * I know its messy, it was a quick hack for some MCCs!
*/ 
UNDERCOVER_spotDistance = _this select 0;
UNDERCOVER_fov = _this select 1;
UNDERCOVER_suppresedRange = _this select 2;
UNDERCOVER_unsuppresedRange = _this select 3;

if (isServer) exitWith {};

UNDERCOVER_resetEHs = {	
	// Reset player's event handlers
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
};

UNDERCOVER_setCoverBlown = {
	if (not(player getVariable ["coverBlown", true])) then {
		player setVariable ["coverBlown", nil];
		player setVariable ["coverTempBlown", nil];
		player setCaptive false;
		titleText ["Your cover is blown!", "plain", 1];
		[] call UNDERCOVER_resetEHs;
	};
};

UNDERCOVER_isSuppressed = {
	params ["_unit"];

	_s = _unit weaponAccessories (currentWeapon _unit) select 0;
	if(_s != "") exitWith
	{
		_a = getNumber (configfile >> "CfgWeapons" >> _s >> "ItemInfo" >> "AmmoCoef" >> "audibleFire");
		if(_a < 1) then
		{true}
		else
		{false};
	};

	_mag = currentMagazine (vehicle _unit);
	_ammo = getText (configFile >> "cfgMagazines" >> _mag >> "ammo");
	_ammoAudible = getNumber (configFile >> "cfgAmmo" >> _ammo >> "audibleFire");
	if(_ammoAudible < 5.5) then 
	{true}
	else
	{false};
};




// Initialize
player setCaptive true;
player action ["SwitchWeapon", player, player, -1];
titleText ["You are now undercover.", "plain", 1];
[] call UNDERCOVER_resetEHs;
player setVariable ["coverBlown", false];
player setVariable ["coverTempBlown", false];

// Switching weapons, etc
_EHWeapon = ["weapon", {
	params ["_unit", "_weapon"];

	// Current weapon is not binos or empty
	// Loop around until they're spotted, shoot, or put it away
	if (!( (currentWeapon player == binocular player) || (currentWeapon player == "") )) then {
		[] spawn {
			player setVariable ["coverTempBlown", true];
			private _shouldBlowCover = false;
			waitUntil {
				sleep 0.5;

				// Check line of sight with enemy units in 100m radius
				private _isVisibleToLocalUnits = {
					if([player, _x, UNDERCOVER_fov] call Tac2_fnc_hasLineOfSight) exitWith { _shouldBlowCover = true; true };
				} forEach (player nearEntities ["Man", UNDERCOVER_spotDistance] select { side _x != side player && side _x != west});
				if (not isNil "_isVisibleToLocalUnits") exitWith { true };

				// their cover is totally blown (they shot, or Zeus changed it)
				// Default is true because we set it to nil (ie reset it) when cover is blown
				if ((player getVariable ["coverBlown", true])) exitWith { _shouldBlowCover = true; true };
		
				// coverTempBlown is false again (they put their gun away)
				if (not (player getVariable ["coverTempBlown", false])) exitWith { true };
				false
			};

			// Remove all EH if we exited because of LOS or shooting
			if (_shouldBlowCover) then {
				[] call UNDERCOVER_setCoverBlown;
			};
		};
	} else {
		player setVariable ["coverTempBlown", false];
	};
}] call CBA_fnc_addPlayerEventHandler;
player setVariable ["undercoverEHWeapon",_EHWeapon];


// ACE adv. throwing and firing
_EHFiredAce = ["ace_firedPlayer", {
	private _nearEnemies = [];
	if ([player] call UNDERCOVER_isSuppressed) then {
		_nearEnemies = player nearEntities ["Man", UNDERCOVER_suppresedRange] select { side _x != side player && side _x != west};
	} else {
		_nearEnemies = player nearEntities ["Man", UNDERCOVER_unsuppresedRange] select { side _x != side player && side _x != west}; 
	};
	if (count _nearEnemies > 0) then {
		[] call UNDERCOVER_setCoverBlown;
	};	
}] call CBA_fnc_addEventHandler;
player setVariable ["undercoverEHFiredAce",_EHFiredAce];

// Player respawns
_EHRespawn = player addEventHandler ["Respawn", {
	[] call UNDERCOVER_setCoverBlown;
}];
player setVariable ["undercoverEHRespawn",_EHRespawn];

