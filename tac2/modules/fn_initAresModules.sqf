if !(isClass (configFile >> "CfgPatches" >> "achilles_data_f_ares")) exitWith { false };

["7Cav - Tac2", "Grant player vehicle permissions",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modAddVehiclePermissions;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2", "Grant player G-resistance",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modAddGResistance;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2", "Grant player Fortify permission",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modAddFortify;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2", "Set player 'undercover' (auto)",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modSetUndercoverAuto;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2", "Set player 'undercover' (man)",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modSetUndercoverManual;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2", "Unset player 'undercover'",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modUnsetUndercover;
}] call Ares_fnc_RegisterCustomModule;

/*
 * Tools for editing the environment
*/

["7Cav - Tac2 - Objects", "Hide Objects",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modHideObjects;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2 - Objects", "Copy Terrain Object",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modCopyTerrainObject;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2 - Objects", "Set Relative Object Height",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modSetRelHeight;
}] call Ares_fnc_RegisterCustomModule;


/*
 * SPM related tools
*/

["7Cav - Tac2 SPM Tools", "Define Civilian Units",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modDefineCivilians;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2 SPM Tools", "Chain Units",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modChainUnit;
}] call Ares_fnc_RegisterCustomModule;

["7Cav - Tac2 SPM Tools", "Unchain Units",{
    [(_this select 0), (_this select 1)] call Tac2_fnc_modUnchainUnit;
}] call Ares_fnc_RegisterCustomModule;