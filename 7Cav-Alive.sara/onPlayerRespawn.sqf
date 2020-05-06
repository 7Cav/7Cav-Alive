diag_log "onPlayerRespawn start";

waitUntil { not isNull player };
waitUntil { not isNil "CLIENT_InitPlayerLocalComplete" };

/*
 * Set position and direction
 * private _respawn = player getVariable ["CLIENT_PlayerPosition", []];
 * player setPosASL (_respawn select 0);
 * player setDir (_respawn select 1);
 *
 */

// Initialize Zeus for player
[player] remoteExec ["SERVER_CuratePlayer", 2];

// [player, [Headquarters, Carrier], []] execVM "scripts\greenZoneInit.sqf"; // No-combat zones

// Hide player after x minutes after death
player addEventHandler ["Killed", { [_this select 0] spawn { sleep 300; hideBody (_this select 0) } }];

// Disable player voices
[player, "novoice"] remoteExec ["setSpeaker", 0, true]; //JIP

// Set the players loadout to what they died with
if (not isNil "CLIENT_RespawnLoadout") then { player setUnitLoadout CLIENT_RespawnLoadout };

// player addAction ["Clear vehicle inventory", CLIENT_ClearVehicleInventory, [], 0, false, true, "", "[] call CLIENT_ClearVehicleInventoryCondition"];
// player addAction ["Unflip Vehicle", { [cursorObject] call JB_fnc_flipVehicle }, [], 0, true, true, "", "vehicle player == player && { getCursorObjectParams select 2 <= 2 } && { [cursorObject] call JB_fnc_flipVehicleCondition }"];

// Run class specific respawn functions
["respawn"] call compile preProcessFile format ["scripts\class\%1.sqf", typeOf player];

diag_log "onPlayerRespawn end";
