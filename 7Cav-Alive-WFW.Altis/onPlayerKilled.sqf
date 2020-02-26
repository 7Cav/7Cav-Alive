params ["_oldPlayer"];

CLIENT_RespawnLoadout = getUnitLoadout _oldPlayer;

if (vehicle _oldPlayer != _oldPlayer) then { [_oldPlayer, true] remoteExec ["hideObjectGlobal", 2] };