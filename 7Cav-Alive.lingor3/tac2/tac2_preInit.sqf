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
