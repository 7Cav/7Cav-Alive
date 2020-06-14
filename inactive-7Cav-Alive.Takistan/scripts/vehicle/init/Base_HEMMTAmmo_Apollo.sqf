//Combat logistics vehicle script for WFW.
[_this select 0,
  {
    [_this select 0, 20] call ace_cargo_fnc_setSpace;
    [_this select 0, -1] call ace_cargo_fnc_setSize;
    [_this select 0, 1200] call ace_rearm_fnc_setSupplyCount;
    (_this select 0) setVariable ["ACE_isRepairVehicle", true, true];
  }
] call vehicle_fnc_respawnVehicleInitialize;
[_this select 0, 60] call vehicle_fnc_respawnVehicleWhenKilled;
[_this select 0, 1500, 99999] call vehicle_fnc_respawnVehicleWhenAbandoned;
