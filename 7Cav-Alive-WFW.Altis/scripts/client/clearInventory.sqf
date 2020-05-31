/*
This script will remove all weapons and ammo from a given vehicle.

Copy/Paste this into the vehicle init:
this addAction ["<t color='#ff0000' font='EtelkaMonospacePro' size='1.2'>Clear Vehicle Inventory</t>","scripts\client\clearInventory.sqf",[],0,true,true,"","driver  _target == _this",-1];
*/

// addAction parameters
params ["_target"];

// clearXGlobal means to clear X from something, for everyone on the server.
clearBackpackCargoGlobal _target;
clearWeaponCargoGlobal _target;
clearItemCargoGlobal _target;
clearMagazineCargoGlobal _target;

// Remove the addaction so it can't be run by several players.
[_target] remoteExec ["removeAllActions", 0];

// Spawn a sleep and addaction, so that after 10 seconds, the action is readded to the vehicle.
[_target] spawn {
	params ["_target"];
	sleep 1000;
    _this addAction [
        "<t color='#ff0000' font='EtelkaMonospacePro' size='1.2'>Clear Vehicle Inventory</t>",
        "scripts\client\clearInventory.sqf",
        [],
        0,
        true,
        true,
        "",
        "driver  _target == _this",
        -1
    ];
};