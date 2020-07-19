diag_log "initServer start";

// Increase ACE max carry and drag weights
ACE_maxWeightCarry = 9000;
ACE_maxWeightDrag = 200000;

bis_fnc_drawMinefields_active = true;

//Make the RHS M119 towable
//Sweetwater
SA_TOW_RULES_OVERRIDE = [["AllVehicles", "CAN_TOW", "RHS_M119_WD"]];

// Alive initialization
[] execVM "alive\CustomFactions.sqf";
[] execVM "alive\Tasks.sqf";
// Base Cleanup
[] execVM "scripts\baseCleanup.sqf";
// Advance Scripts
[] execVM "ASL_AdvancedSlingLoading\functions\fn_advancedSlingLoadInit.sqf";
[] execVM "AT_AdvancedTowing\functions\fn_advancedTowingInit.sqf";
[] execVM "AUR_AdvancedUrbanRappelling\functions\fn_advancedUrbanRappellingInit.sqf";

//Bis Dynamic Group Stuff
["Initialize"] call BIS_fnc_dynamicGroups;

diag_log "initServer end";
