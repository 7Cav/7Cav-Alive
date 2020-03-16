/*
	Author: JB
*/

params ["_weapon"];

if (_weapon isKindOf ["CarHorn", configFile >> "CfgWeapons"]) exitWith { false };
if (_weapon isKindOf ["SmokeLauncher", configFile >> "CfgWeapons"]) exitWith { false };
if (_weapon isKindOf ["Laserdesignator_mounted", configFile >> "CfgWeapons"]) exitWith { false };
if (_weapon isKindOf ["FlareLauncher", configFile >> "CfgWeapons"]) exitWith { false };
if (_weapon isKindOf ["CounterMeasuresLauncher", configFile >> "CfgWeapons"]) exitWith { false };
if (_weapon isKindOf ["rhsusf_weap_LWIRCM", configFile >> "CfgWeapons"]) exitWith { false };
if (_weapon isKindOf ["rhsusf_weap_ANALQ144", configFile >> "CfgWeapons"]) exitWith { false };

true