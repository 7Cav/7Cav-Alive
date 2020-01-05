/*
	Authors: Much of this code is written by, or inspired by JB rewritten by Bojan
	Valid _roles/positions in vehicle are "VP_driver", "VP_gunner", "VP_cargo"
*/

[] execVM "scripts\client\vehiclePermissionsList.sqf";
[] execVM "scripts\client\vehiclePermissionConditions.sqf";

CLIENT_InvalidPermissionMessage = 
{
	params ["_vehicle", "_role"];

	private _messages = [];
	private _vehicleName = [typeOf _vehicle, "CfgVehicles"] call utils_fnc_displayName;
	switch (_role) do
	{
		case "VP_Driver": { _messages pushBackUnique format ["You may not drive this %1", _vehicleName] };
		case "VP_Gunner": { _messages pushBackUnique format ["You may not operate weapons on this %1", _vehicleName] };
		case "VP_Commander": { _messages pushBackUnique format ["You may not command this %1", _vehicleName] };
		case "VP_Pilot": { _messages pushBackUnique format ["You may not fly this %1", _vehicleName] };
		case "VP_Turret": { _messages pushBackUnique format ["You may not operate weapons on this %1", _vehicleName] };
		case "VP_Cargo": { _messages pushBackUnique format ["You may not ride in this %1", _vehicleName] };
	};

	_messages
};

CLIENT_SetInfantryVehiclePermissions =
{
	params ["_player"];

	private _permissions = [];

	_permissions = [];
	_permissions pushBack [TypeFilter_All, [], {}];
	_permissions pushBack [TypeFilter_LogisticsVehicles, [], {}];
	_player setVariable ["VP_Cargo", _permissions];

	_permissions = [];
	_permissions pushBack [TypeFilter_InfantryVehicles, [], {}];
	_player setVariable ["VP_Driver", _permissions];

	_permissions = [];
	_permissions pushBack [TypeFilter_InfantryVehicles, [], {}];
	_permissions pushBack [TypeFilter_LogisticsVehicles, [], {}];
	_permissions pushBack [TypeFilter_All, [], {}];
	_player setVariable ["VP_Gunner", _permissions];

	_permissions = [];
	_permissions pushBack [TypeFilter_InfantryVehicles, [], {}];
	_permissions pushBack [TypeFilter_LogisticsVehicles, [], {}];
	_permissions pushBack [TypeFilter_All, [VPC_UnlessTurretArmed], {}];
	_player setVariable ["VP_Commander", _permissions];

	_permissions = [];
	_permissions pushBack [TypeFilter_LogisticsVehicles, [], {}];
	_permissions pushBack [TypeFilter_InfantryVehicles, [], {}];
	_permissions pushBack [TypeFilter_TransportRotory, [], { if (player in [(_this select 0) turretUnit [0]]) then { (_this select 0) enableCopilot false } }];
	_permissions pushBack [TypeFilter_All, [VPC_UnlessTurretArmed], { if (player in [(_this select 0) turretUnit [0]]) then { (_this select 0) enableCopilot false } }];
	_player setVariable ["VP_Turret", _permissions];

	_player setVariable ["VP_Pilot", []];

	[TypeFilter_ArmoredVehicles] call utils_fnc_manualDriveInitPlayer;
};

CLIENT_SetArmorCrewVehiclePermissions =
{
	params ["_player"];

	[_player] call CLIENT_SetInfantryVehiclePermissions;

	// Add to the infantry permissions
	{
		player setVariable [_x, [[TypeFilter_ArmoredVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver", "VP_Gunner", "VP_Commander", "VP_Turret"];
};

/*
	Get permission for a particular user in a particular vehicle for a particular role.
	Return a list of permissions that allow a player to use a vehicle, as well as error messages (if any)
*/
CLIENT_VP_CheckPermissions =
{
	params ["_role", "_vehicle", "_player"];

	private _permissions = _player getVariable [_role, []];
	private _applicable = _permissions select { [typeOf _vehicle, _x select 0] call utils_fnc_passesTypeFilter };

	// No relevent TypeFilters, auto deny
	if (count _applicable == 0) exitWith { 
		[[], [ _vehicle, _role] call CLIENT_InvalidPermissionMessage];
	};

	// Relevent TypeFilters found
	private _messages = [];
	private _nonEmptyMessages = [];
	private _permitted = [];
	{
		// Each _x is of the type `[TypeFilter_All, [VPC_UnlessTurretArmed], {}]`
		// Get the vehicle permission condition and apply it
		_messages = (_x select 1) apply { [_vehicle, _player, _role] call _x };

		// If there are no messages (ie we didnt fail to pass a VPC), add this permission to permitted
		if ({ _x != "" } count _messages == 0) then { _permitted pushBack _x };

		// Add each non-empty message to _nonEmptyMessages
		{ _nonEmptyMessages pushBackUnique _x } forEach (_messages select { _x != "" });
	} forEach _applicable;

	[_permitted, _nonEmptyMessages]

};

CLIENT_VP_GetIn_Action =
{
	params ["_role", "_vehicle", "_player", "_index", "_name", "_text"];

	// Allow mission controllers who are controlling an AI to get into any vehicle.  Because I cannot find a way to discover if the GM is
	// controlling an AI, I'm just checking the distance between the GM and the vehicle.  If it's a large distance, then it must
	// be a remote act.
	if (CLIENT_CuratorType == "MC" && { player distance _vehicle > sizeOf typeOf _vehicle }) exitWith { false };

	private _results = [_role, _vehicle, _player] call CLIENT_VP_CheckPermissions;
	_results params ["_permitted", "_allMessages"];

	// Player not permitted to enter vehicle
	if (count _permitted == 0) exitWith
	{
		[_allMessages joinString "<br/>", 1, true] call utils_fnc_showBlackScreenMessage;
		true
	};

	// We're going to let them in, so wait until they're in, then run the permission's onGetIn code
	[_vehicle, _player, _permitted apply { _x select 2 }] spawn
	{
		params ["_vehicle", "_player", "_callbacks"];

		if ([{ vehicle _player == _vehicle }, 5] call utils_fnc_timeoutWaitUntil) then
		{
			{
				[_vehicle, _player] call _x;
			} forEach _callbacks;
		};
	};

	// Allow the action (don't override)
	false
};

CLIENT_VP_GetIn_Key =
{
	true
};

["GetInDriver", { (["VP_Driver"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["GetInGunner", { (["VP_Gunner"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["GetInCommander", { (["VP_Commander"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["GetInPilot", { (["VP_Pilot"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["GetInTurret", { (["VP_Turret"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["GetInCargo", { (["VP_Cargo"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;

["MoveToDriver", { (["VP_Driver"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["MoveToGunner", { (["VP_Gunner"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["MoveToCommander", { (["VP_Commander"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["MoveToPilot", { (["VP_Pilot"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["MoveToTurret", { (["VP_Turret"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
["MoveToCargo", { (["VP_Cargo"] + _this) call CLIENT_VP_GetIn_Action }, CLIENT_VP_GetIn_Action, CLIENT_VP_GetIn_Action] call CLIENT_OverrideAction;
