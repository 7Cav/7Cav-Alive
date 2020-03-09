params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

private _dialogResult =
    [
		"Hide Terrain Objects",
		[
			["Hide?", ["True","False"], 0],
			["Radius", "", "50"],
			["Filter (Optional)", "", ""]
		]
    ] call Ares_fnc_showChooseDialog;
 
 _dialogResult params ["_hide", "_radius", "_filter"];
if (count _dialogResult == 0) exitWith {};

[
	[_position,_hide,_radius,_filter], 
	{
		params ["_position","_hide", "_radius", "_filter"];
		_position = [(_position select 0),(_position select 1)];

		_hide = switch (_hide) do {
			case 0: { true };
			case 1: { false };
		};

    	if (_filter == "") then {
            {_x hideObjectGlobal _hide} foreach nearestTerrainObjects [_position, [], (parseNumber _radius), false];
        }
        else {
            {_x hideObjectGlobal _hide} foreach nearestTerrainObjects [_position, [_filter], (parseNumber _radius), false];
        };	
	}
] remoteExec ["bis_fnc_call", 2];
