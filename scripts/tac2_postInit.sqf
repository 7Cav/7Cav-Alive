// Temp fix for 'god mode' glitch
player addEventHandler ["Respawn", { [player] call ace_common_fnc_resetAllDefaults; }];

// Ensure that enhanced movement vehicle enter menu doesn't work
[] spawn {
	if (isDedicated) exitWith {};
	waitUntil {
		private _c = babe_core_modkeydata select { 
			_x select 1 == "Use" 
		};
		count _c > 0
	};
	babe_core_modkeydata = babe_core_modkeydata select { 
		_x select 1 != "Use" 
	};
};
