// Init custom Ares modules
call Tac2_fnc_initAresModules;


//Chat messages for Team kills of blufor players;
[] spawn {
    waitUntil {!(isNull player)};
    player addEventHandler ["killed", {
    params ["_unit", "_killer", "_instigator"];
        if (side _unit == west && side _instigator == west) exitWith {
            _msg = format ["%1 was killed by %2", _unit, _instigator];
            _msg remoteExec ["systemChat", 0];
        };
    }];
};

// Initialize loyalty rewards GUI
_vehDialog = [] spawn compile PreprocessFileLineNumbers "Tac2\loyalty\loyalty_fnc.sqf";

[] spawn {
	sleep 900;
	while { true } do {
		private _lastPosition = profileNamespace getVariable ["Tac2Loyalty_lastPosition", [0,0,0]];
		private _currentPosition = getPos player;

		while {_lastPosition distance _currentPosition < 7} do {
			_currentPosition = getPos player;
			sleep 1;
		};

		[10, "for activity"] call LOYALTY_fnc_addPointsLocal;
		profileNamespace setVariable ["Tac2Loyalty_lastPosition", _currentPosition];

		sleep 900;
	};
};

