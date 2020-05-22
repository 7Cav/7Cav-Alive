diag_log "initServer start";

#include "scripts\baseCleanup.sqf"

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

["Initialize"] call BIS_fnc_dynamicGroups;

[] execVM "ASL_AdvancedSlingLoading\functions\fn_advancedSlingLoadInit.sqf";
[] execVM "AT_AdvancedTowing\functions\fn_advancedTowingInit.sqf";
[] execVM "AUR_AdvancedUrbanRappelling\functions\fn_advancedUrbanRappellingInit.sqf";

enableEnvironment [true, true];

diag_log "initServer end";
