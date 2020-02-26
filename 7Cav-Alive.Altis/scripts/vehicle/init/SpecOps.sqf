(_this select 0) addAction 
[
    "Request mission", 
    {
        [] execVM "mission\specialoperations\requestMission.sqf";
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "[_this] call BOTH_IsSpecOpsMember",
    10,
    false,
    "",
    ""
];

(_this select 0) addAction 
[
    "Join special operations", 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
		_caller setVariable ["SPM_SpecialOperations", true, true];
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "!([_this] call BOTH_IsSpecOpsMember)",
    10,
    false,
    "",
    ""
];

(_this select 0) addAction 
[
    "Leave special operations", 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
		_caller setVariable ["SPM_SpecialOperations", false, true];
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "[_this] call BOTH_IsSpecOpsMember",
    10,
    false,
    "",
    ""
];