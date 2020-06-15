[_this select 0,
  {
    [_this select 0, 100] call cScripts_fnc_addFortifyArea;
    [_this select 0, 32] call ace_cargo_fnc_setSpace;
    [_this select 0, -1] call ace_cargo_fnc_setSize;
  }
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 99999] call vehicle_fnc_respawnVehicleWhenAbandoned;
