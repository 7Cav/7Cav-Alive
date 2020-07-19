diag_log "postInit Start";

// Set ALiVE force pool
[ALIVE_globalForcePool,"BLU_F", 1000] call ALIVE_fnc_hashSet;

// Fortify
[] execVM "Scripts\initFortify.sqf";

diag_log "postInit End";