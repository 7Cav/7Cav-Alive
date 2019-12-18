VP_CheckPermissions =
{
	params ["_type", "_target", "_caller"];

	private _permissions = _caller getVariable [_type, []];
	private _applicable = _permissions select { [typeOf _target, _x select 0] call JB_fnc_passesTypeFilter };
	private _permitted = [];
	private _allMessages = [];

	// The vehicle type wasn't mentioned in any permissions, so show a generic refusal message to the player.
	if (count _applicable == 0) exitWith
	{
		private _targetName = [typeOf _target, "CfgVehicles"] call JB_fnc_displayName;

		switch (_type) do
		{
			case "VP_Driver": { _allMessages pushBackUnique format ["You may not drive this %1", _targetName] };
			case "VP_Gunner": { _allMessages pushBackUnique format ["You may not operate weapons on this %1", _targetName] };
			case "VP_Commander": { _allMessages pushBackUnique format ["You may not command this %1", _targetName] };
			case "VP_Pilot": { _allMessages pushBackUnique format ["You may not fly this %1", _targetName] };
			case "VP_Turret": { _allMessages pushBackUnique format ["You may not operate weapons on this %1", _targetName] };
			case "VP_Cargo": { _allMessages pushBackUnique format ["You may not ride in this %1", _targetName] };
		};
		
		[_permitted, _allMessages]
	};

	private _messages = [];
	{
		_messages = (_x select 1) apply { [_target, _caller, _type] call _x };
		if ({ _x != "" } count _messages == 0) then { _permitted pushBack _x };
		{ _allMessages pushBackUnique _x } forEach (_messages select { _x != "" });
	} forEach _applicable;

	[_permitted, _allMessages]
};

VP_GetIn_Action =
{
	params ["_type", "_target", "_caller", "_index", "_name", "_text"];

	// Allow mission controllers who are controlling an AI to get into any vehicle.  Because I cannot find a way to discover if the GM is
	// controlling an AI, I'm just checking the distance between the GM and the vehicle.  If it's a large distance, then it must
	// be a remote act.
	if (CLIENT_CuratorType == "MC" && { player distance _target > sizeOf typeOf _target }) exitWith { false };

	private _results = [_type, _target, _caller] call VP_CheckPermissions;
	_results params ["_permitted", "_allMessages"];

	if (count _permitted == 0) exitWith
	{
		[_allMessages joinString "<br/>", 1, true] call JB_fnc_showBlackScreenMessage;

		true
	};

	// We're going to let them in, so wait until they're in, then run the permission's onGetIn code
	[_target, _caller, _permitted apply { _x select 2 }] spawn
	{
		params ["_target", "_caller", "_callbacks"];

		if ([{ vehicle _caller == _target }, 5] call JB_fnc_timeoutWaitUntil) then
		{
			{
				[_target, _caller] call _x;
			} forEach _callbacks;
		};
	};

	// Allow the action (don't override)
	false
};

VP_GetIn_Key =
{
	true
};

["GetInDriver", { (["VP_Driver"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["GetInGunner", { (["VP_Gunner"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["GetInCommander", { (["VP_Commander"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["GetInPilot", { (["VP_Pilot"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["GetInTurret", { (["VP_Turret"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["GetInCargo", { (["VP_Cargo"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;

["MoveToDriver", { (["VP_Driver"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["MoveToGunner", { (["VP_Gunner"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["MoveToCommander", { (["VP_Commander"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["MoveToPilot", { (["VP_Pilot"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["MoveToTurret", { (["VP_Turret"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
["MoveToCargo", { (["VP_Cargo"] + _this) call VP_GetIn_Action }, VP_GetIn_Key, VP_GetIn_Key] call CLIENT_OverrideAction;
