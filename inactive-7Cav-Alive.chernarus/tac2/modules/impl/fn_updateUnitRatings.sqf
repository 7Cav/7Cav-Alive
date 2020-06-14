params ["_newRatings", "_isCivies"];

if (not isServer && hasInterface) exitWith {};

if (_isCivies) then {
	SPM_InfantryGarrison_CallupsCivilian = _newRatings apply { [configName _x, [1, 1, 1.0]] };
	SPM_InfantryGarrison_RatingsCivilian = _newRatings apply { [configName _x, [1, 1]] };
} else {
	SPM_InfantryGarrison_CallupsSyndikat = _newRatings apply { [configName _x, [1, 1, 1.0]] };
	SPM_InfantryGarrison_RatingsSyndikat = _newRatings apply { [configName _x, [1, 1]] };
	SPM_InfantryGarrison_InitialCallupsSyndikat = SPM_InfantryGarrison_CallupsSyndikat;

	SPM_MissionAdvance_Patrol_CallupsSyndikat = [];
	SPM_MissionAdvance_Patrol_RatingsSyndikat = SPM_MissionAdvance_Patrol_CallupsSyndikat apply { [_x select 0, (_x select 1) select [0, 2]] };
	
	SPM_Transport_CallupsEastTruck = [];
};
