#include "..\script_component.hpp";
/*
 * Author: SGT.Brostrom.A
 * This function is partly based on Bojan and PFC.Vex.W Fortify system.
 * This function handles Fortify regeistrated objects.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * call cScripts_fnc_handleFortify
 *
 * Public: No
 */

if !(isServer) exitWith {};

#ifdef DEBUG_MODE
    [formatText["Adding Fortify registrated objects."]] call FUNC(logInfo);
#endif

params [
    ["_budget", 900, [900]]
];

_fortificationStructures = [
    ["Land_HBarrier_1_F", 1],
    ["Land_HBarrier_5_F", 5],
    ["Land_HBarrierWall4_F", 10],
    ["Base_WarfareBBarrier10xTall",10],
    ["Land_HBarrierTower_F", 25],
    ["Land_Fort_Watchtower_EP1", 25],
    ["Land_BagFence_Long_F", 5],
    ["Land_SandbagBarricade_01_hole_F", 5],
    ["Land_BagBunker_Small_F", 25],
    ["Land_BagBunker_Large_F", 50],
    ["Land_CncBarrierMedium_F", 5],
    ["Land_CncBarrierMedium4_F", 20],
    ["Land_HelipadCircle_F", 25],
    ["Land_PortableLight_double_F", 3],
    ["StorageBladder_01_fuel_sand_F", 175],
    ["Land_ClutterCutter_medium_F", 1],
    ["CargoPlaftorm_01_jungle_F", 50],
    ["Land_fort_rampart_EP1",5],
    ["Land_fort_artillery_nest_EP1",10],
    ["Land_Razorwire_F",2],
    ["Land_CamoNetVar_NATO_EP1",5],
    ["CUP_A2_Road_Bridge_wood_25", 25],
    ["Land_Hlaska",30]
];

[west, _budget, _fortificationStructures] call acex_fortify_fnc_registerObjects;
