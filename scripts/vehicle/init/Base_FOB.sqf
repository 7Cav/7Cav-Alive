[_this select 0,
  {
    _radius = 100;
    missionNamespace setVariable ["acex_fortify_locations", [[_this select 0,_radius,_radius,0,false]], true];
    [_this select 0, 16] call ace_cargo_fnc_setSpace;
    [_this select 0, -1] call ace_cargo_fnc_setSize;
  }
] call JB_fnc_respawnVehicleInitialize;
[_this select 0, 60] call JB_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 99999] call JB_fnc_respawnVehicleWhenAbandoned;
