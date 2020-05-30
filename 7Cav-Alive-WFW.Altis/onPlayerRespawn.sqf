diag_log "onPlayerRespawn start";

// Hide player after x minutes after death
player addEventHandler ["Killed", { [_this select 0] spawn { sleep 300; hideBody (_this select 0) } }];

// Set the players loadout to what they died with
if (not isNil "CLIENT_RespawnLoadout") then { player setUnitLoadout CLIENT_RespawnLoadout };

diag_log "onPlayerRespawn end";
