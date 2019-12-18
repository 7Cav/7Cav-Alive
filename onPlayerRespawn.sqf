diag_log "onPlayerRespawn start";

waitUntil { not isNull player };
waitUntil { not isNil "CLIENT_InitPlayerLocalComplete" };

private _respawn = player getVariable ["CLIENT_PlayerPosition", []];
player setPosASL (_respawn select 0);
player setDir (_respawn select 1);

[player] remoteExec ["SERVER_CuratePlayer", 2];

[player, [Headquarters, Carrier], []] execVM "scripts\greenZoneInit.sqf"; // No-combat zones

player addEventHandler ["Killed", { [_this select 0] spawn { sleep 300; hideBody (_this select 0) } }];

[player, "novoice"] remoteExec ["setSpeaker", 0, true]; //JIP

if (not isNil "CLIENT_RespawnLoadout") then { player setUnitLoadout CLIENT_RespawnLoadout };

// Set camera view from the profile, and update the profile if the camera view changes
private _cameraView = profileNamespace getVariable "CLIENT_RespawnCamera";
if (not isNil "_cameraView" && { _cameraView in ["EXTERNAL", "INTERNAL"] }) then { player switchCamera _cameraView };
[] spawn
{
	scriptName "OnPlayerRespawn-CameraView";

	private _player = player;
	private _cameraView = "";
	while { alive _player } do
	{
		sleep 10;
		_cameraView = profileNamespace getVariable ["CLIENT_RespawnCamera", "INTERNAL"];
		if (_cameraView != cameraView) then
		{
			profileNamespace setVariable ["CLIENT_RespawnCamera", cameraView];
			saveProfileNamespace;
		};
	};
};

[] call CLIENT_EC_PlayerInit;

player addAction ["Clear vehicle inventory", CLIENT_ClearVehicleInventory, [], 0, false, true, "", "[] call CLIENT_ClearVehicleInventoryCondition"];
player addAction ["Unflip Vehicle", { [cursorObject] call JB_fnc_flipVehicle }, [], 0, true, true, "", "vehicle player == player && { getCursorObjectParams select 2 <= 2 } && { [cursorObject] call JB_fnc_flipVehicleCondition }"];

["respawn"] call compile preProcessFile format ["scripts\class\%1.sqf", typeOf player];

diag_log "onPlayerRespawn end";
