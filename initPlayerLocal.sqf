diag_log "initPlayerLocal start";

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

// TODO-RENABLE: Keep a NATO flag on vehicles with players in it
// player addEventHandler ["GetInMan", { if ([typeOf (_this select 2), CLIENT_FlagVehicleFilter] call JB_fnc_passesTypeFilter) then { (_this select 2) forceFlagTexture "\A3\Data_F\Flags\Flag_NATO_CO.paa" } }];
// player addEventHandler ["GetOutMan", { if ({ isPlayer _x } count crew (_this select 2) == 0) then { (_this select 2) forceFlagTexture "" } }];

// Disable faction changes due to team killing, vehicle destruction, etc.
player addEventHandler ["HandleRating", { 0 }];

[] execVM "ASL_AdvancedSlingLoading\overrideStandardSlingLoading.sqf";

// TODO-RENABLE: [] call JB_fnc_increasedFuelConsumption;

[] call tac2_fnc_fortifyPermissionsInitPlayer;

[] execVM "scripts\misc\diary.sqf";

// ["init"] call compile preProcessFile format ["scripts\class\%1.sqf", typeOf player];

// CLIENT_CommandChatHandler =
// {
// 	params ["_channel", "_text"];

// 	if (_text find "gm " == 0 || _text find "mc " == 0 || _text find "mp " == 0) then
// 	{
// 		[_text] remoteExec ["SERVER_ExecuteCommand", 2];
// 	};
// };

// [CLIENT_CommandChatHandler] call JB_fnc_chatAddEventHandler;

diag_log "initPlayerLocal end";
