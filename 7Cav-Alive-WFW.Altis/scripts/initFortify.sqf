diag_log "initFortify Start";

// Structures
private _fortificationStructures = [
    ["Land_HBarrier_1_F", 1],
    ["Land_HBarrier_5_F", 5],
    ["Land_HBarrierWall4_F", 10],
    ["Land_HBarrierTower_F", 25],
    ["Land_BagBunker_Tower_F", 25],
    ["Land_BagFence_Long_F", 5],
    ["Land_BagBunker_Small_F", 25],
    ["Land_SandbagBarricade_01_hole_F", 5],
    ["Land_BagBunker_Large_F", 50],
    ["Land_CncBarrierMedium_F", 5],
    ["Land_CncBarrierMedium4_F", 20],
    ["Land_HelipadCircle_F", 25],
    ["Land_PortableLight_double_F", 3],
    ["StorageBladder_01_fuel_forest_F", 175],
    ["Land_ClutterCutter_medium_F", 1],
    ["CUP_A2_Road_Bridge_wood_25", 25],
    ["CamoNet_BLUFOR_big_F", 1]
];

[west, 900, _fortificationStructures] call acex_fortify_fnc_registerObjects;

diag_log "initFortify End";
