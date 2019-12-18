diag_log "initPlayerLocal start";

waitUntil { not isNull player };
waitUntil { getPlayerUID player != "" };

[] call SPM_fnc_clientInit;

[] execVM ("scripts\configure" + worldName + "Client.sqf");			// Island-specific modifications

player setVariable ["CLIENT_Owner", clientOwner, true];

// Headless client treatment
if (not hasInterface) exitWith
{
	private _hostColor = [CLIENT_HostColors, vehicleVarName player] call BIS_fnc_getFromPairs;
	if (isNil "_hostColor") then { _hostColor = "colorblack" };
	player setVariable ["OP_HostColor", _hostColor, true];

	CLIENT_InitPlayerLocalComplete = true;

	diag_log "initPlayerLocal end";
};

enableSaving [false, false];

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// [[code, whatever], [code, whatever], ...]
CLIENT_PlayerDisconnectedHandlers = [];

// Handle the case of a player being carried or dragged by another player.  If spotted, detach
// the player from the disconnecting player and pose them incapacitated.
CLIENT_PlayerDisconnectedHandlers pushBack
	[
		{
			params ["_unit"];

			if (attachedTo player == _unit) then
			{
				detach player;
				if (lifeState player == "INCAPACITATED") then
				{
					player switchMove "unconsciousrevivedefault";
				};
			};
		}
	];

// Called by the server when a player disconnects
CLIENT_PlayerDisconnected =
{
	params ["_unit"];

	{
		[_unit, _x] call (_x select 0);
	} forEach CLIENT_PlayerDisconnectedHandlers;
};

inGameUISetEventHandler ["Action", "_this call CLIENT_ActionMenuActionHandler"];
inGameUISetEventHandler ["NextAction", "_this call CLIENT_ActionMenuNextHandler"];
inGameUISetEventHandler ["PrevAction", "_this call CLIENT_ActionMenuPrevHandler"];

// Lets keep doing this every few seconds to make sure permissions are always set
[] spawn
{
 while { true } do
 {
	inGameUISetEventHandler ["Action", "_this call CLIENT_ActionMenuActionHandler"];
	inGameUISetEventHandler ["NextAction", "_this call CLIENT_ActionMenuNextHandler"];
	inGameUISetEventHandler ["PrevAction", "_this call CLIENT_ActionMenuPrevHandler"];
	sleep 2;
 };
};

player setVariable ["CLIENT_PlayerPosition", [getPosASL player, getDir player]];

// Have player exit vehicle with weapon that he entered
PLAYER_WeaponGetIn = "";
player addEventHandler ["GetInMan", { if (not (vehicle player isKindOf "ParachuteBase")) then { PLAYER_WeaponGetIn = currentWeapon player } }];
player addEventHandler ["GetOutMan", { if (PLAYER_WeaponGetIn == "" || (getPosATL player) select 2 > 100) then { player action ["SwitchWeapon", player, player, -1]; [player, "amovpercmstpsnonwnondnon"] remoteExec ["switchMove"] } }];

CLIENT_FlagVehicleFilter =
[
	["StaticWeapon", false],
	["LandVehicle", true],
	["All", false]
];

// Keep a NATO flag on vehicles with players in it
player addEventHandler ["GetInMan", { if ([typeOf (_this select 2), CLIENT_FlagVehicleFilter] call JB_fnc_passesTypeFilter) then { (_this select 2) forceFlagTexture "\A3\Data_F\Flags\Flag_NATO_CO.paa" } }];
player addEventHandler ["GetOutMan", { if ({ isPlayer _x } count crew (_this select 2) == 0) then { (_this select 2) forceFlagTexture "" } }];

// Disable faction changes due to team killing, vehicle destruction, etc.
player addEventHandler ["HandleRating", { 0 }];

[] execVM "scripts\vehicle\crew\CrewList.sqf";
[] execVM "scripts\vehicle\paradrop\Paradrop.sqf";

[] execVM "ASL_AdvancedSlingLoading\overrideStandardSlingLoading.sqf";
[] execVM "scripts\vehiclePermissionsInit.sqf";

[] call CLIENT_fnc_monitorGearInitPlayer;

[] call JB_fnc_increasedFuelConsumption;
[] call CLIENT_InitForceDryFire;
[] call CLIENT_MonitorEnemyControlledAreas;
[] call Tac2_fnc_fortifyPermissionsInitPlayer;

[] execVM "scripts\misc\diary.sqf";

["init"] call compile preProcessFile format ["scripts\class\%1.sqf", typeOf player];

CLIENT_CommandChatHandler =
{
	params ["_channel", "_text"];

	if (_text find "gm " == 0 || _text find "mc " == 0 || _text find "mp " == 0) then
	{
		[_text] remoteExec ["SERVER_ExecuteCommand", 2];
	};
};

[CLIENT_CommandChatHandler] call JB_fnc_chatAddEventHandler;

[] spawn
{
	waitUntil { time > 0 };
	enableEnvironment [false, true];
	if (not isNil "CLIENT_RoleLink") then { processDiaryLink CLIENT_RoleLink };
};

CLIENT_InitPlayerLocalComplete = true;

diag_log "initPlayerLocal end";
