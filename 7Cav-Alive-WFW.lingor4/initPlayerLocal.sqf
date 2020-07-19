diag_log "initPlayerLocal start";

// Enable group selection ('U' group menu)
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// Load no fire on base script
player addEventHandler ["Fired", {
	if ((getPos (_this select 0)) inArea headquarters) then {
		deleteVehicle (_this select 6);
		titleText ["PLEASE SAFE YOUR WEAPONS ON BASE!!", "BLACK IN", 15];
	};
}]; 

diag_log "initPlayerLocal end";
