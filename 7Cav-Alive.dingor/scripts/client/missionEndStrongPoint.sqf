/* This script will:
 *
 * Define some parameters, log which box was activated, Initialize some variables, remove the initial addaction, 
 * and then perform some user feedback. The user feedback is achieved by animating the box, completing a task,
 * then changing the orbat markers on the map.
 *
 * After the user feedback, we check if all the boxes were activated. If they were, we end the mission. If they
 * weren't, we do nothing.
 *
 */
diag_log "Strongpoint Start.";

// Addaction return values for the boxes, so we can get the global variable
params ["_target", "_caller", "_actionId", "_arguments"];

// Set the local variable equal to the global variable
private _boxNumber = missionNameSpace getVariable "endMissionNumber";
private _term = vehicleVarName _target;
_term = toLower(_term);

// Increase the local variable by 1
_boxNumber = _boxNumber + 1;
//Set the local variable equal to the global variable
private _boxNumber = missionNameSpace getVariable "endMissionNumber";

// The Patton Stopper v1.0
private _enemies = ((getPos _target) nearEntities ["Man", 250]) select { side _x == east || side _x == independent };
if (count _enemies > 0) exitWith { 
      hint parseText "<t color='#FF0000' font='PuristaBold' size=1><img size='5' image='cScripts\Data\Images\7CAV_LOGO_01.paa' align='center'/><br/><br/>There are still<br/>hostiles in the area!</t>";
};

// Remove all the actions on the box
[_target] remoteExec ["removeAllActions", 0]; 

// Animate the box to keyframe 3
[_target,3] remoteExec ["BIS_fnc_DataTerminalAnimate", 0];

// Terminal Diagnostic
if (_term == "") exitWith {diag_log "ERROR: Empty varname."};
if (_term == "term1" ) then {diag_log "term1"};
if (_term == "term2" ) then {diag_log "term2"};
if (_term == "term3" ) then {diag_log "term3"};
if (_term == "term4" ) then {diag_log "term4"};

// Orbat : Switch statement for the different boxes
switch (_term) do {
  case "term1": {
        [missionConfigFile >> "CfgORBAT" >> "air" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true] remoteExec ["BIS_fnc_ORBATAddGroupOverlay", 0];
        ["Deactivate the Airfield!", "SUCCEEDED"] remoteExec ["BIS_fnc_taskSetState", 0];
        [playerSide, "HQ"] sideChat "Allcon be advised, the enemy air commander has been killed. Great work, out.";
        ["Deactivate the Airfield!"] remoteExec ["BIS_fnc_deleteTask", 0];
        diag_log formatText ["%1 executing on %2 by %3. BoxNumber is %4", _term, _target, _caller, _boxNumber];
  };
  case "term2": {
        [missionConfigFile >> "CfgORBAT" >> "armor" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true] remoteExec ["BIS_fnc_ORBATAddGroupOverlay", 0];
        ["Deactivate the Armored Corps!", "SUCCEEDED"] remoteExec ["BIS_fnc_taskSetState", 0];
        [playerSide, "HQ"] sideChat "Allcon be advised, the enemy armor commander has been killed. Great work, out.";
        ["Deactivate the Armored Corps!"] remoteExec ["BIS_fnc_deleteTask", 0];
        diag_log formatText ["%1 executing on %2 by %3. BoxNumber is %4", _term, _target, _caller, _boxNumber];
  };
  case "term3": {
        [missionConfigFile >> "CfgORBAT" >> "mech" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true] remoteExec ["BIS_fnc_ORBATAddGroupOverlay", 0];
        ["Deactivate the Mechanized Corps!", "SUCCEEDED"] remoteExec ["BIS_fnc_taskSetState", 0];
        [playerSide, "HQ"] sideChat "Allcon be advised, the enemy mechanized commander has been killed. Great work, out.";
        ["Deactivate the Mechanized Corps!"] remoteExec ["BIS_fnc_deleteTask", 0];
        diag_log formatText ["%1 executing on %2 by %3. BoxNumber is %4", _term, _target, _caller, _boxNumber];
  };
  case "term4": {
        [missionConfigFile >> "CfgORBAT" >> "specop" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true] remoteExec ["BIS_fnc_ORBATAddGroupOverlay", 0];
        ["Deactivate the Specops headquarters!", "SUCCEEDED"] remoteExec ["BIS_fnc_taskSetState", 0];
        [playerSide, "HQ"] sideChat "Allcon be advised, the enemy special forces commander has been killed. Great work, out.";
        ["Deactivate the Specops headquarters!"] remoteExec ["BIS_fnc_deleteTask", 0];
        diag_log formatText ["%1 executing on %2 by %3. BoxNumber is %4", _term, _target, _caller, _boxNumber];
  };
};

// Set the missionNameSpace variable endMissionNumber equal to boxNumber.
missionNameSpace setVariable ["endMissionNumber", _boxNumber];

// End the mission if _boxNumber is greater than or equal to 3.
if (_boxNumber >= 3) then {"EveryoneWon" remoteExec ["BIS_fnc_endMissionServer", 2]};

diag_log "Strongpoint end.";