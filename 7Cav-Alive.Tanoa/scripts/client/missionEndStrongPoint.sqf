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

//Addaction return values for the boxes, so we can get the global variable
params ["_target", "_caller", "_actionId", "_arguments"];

//Set the local variable equal to the global variable
private _boxNumber = missionNameSpace getVariable "endMissionNumber";
private _term = str _target;

//Increase the local variable by 1
_boxNumber = _boxNumber + 1;
 
//Remove all the actions on the box
removeAllActions _target;

//Animate the box to keyframe 3
[_target,3] call BIS_fnc_DataTerminalAnimate;

//Succeed the task 
["Defend The Satellite!", "SUCCEEDED"] call BIS_fnc_taskSetState;

//Orbat : Switch statement for the different boxes
switch (_term) do {
  case "Term1": {[ missionConfigFile >> "CfgORBAT" >> "air" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true ] call BIS_fnc_ORBATAddGroupOverlay};
  case "Term2": {[ missionConfigFile >> "CfgORBAT" >> "armor" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true ] call BIS_fnc_ORBATAddGroupOverlay};
  case "Term3": {[ missionConfigFile >> "CfgORBAT" >> "mech" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true ] call BIS_fnc_ORBATAddGroupOverlay};
  case "Term4": {[ missionConfigFile >> "CfgORBAT" >> "specop" , "mil_destroy", [1,0.1,0.1,1], 1, 1, 0, "Killed", true ] call BIS_fnc_ORBATAddGroupOverlay};
};

//set the missionNameSpace variable endMissionNumber equal to boxNumber.
missionNameSpace setVariable ["endMissionNumber", _boxNumber]; 

// End the mission if _boxNumber is greater than or equal to 3.
if (_boxNumber >= 3) then {"EveryoneWon" call BIS_fnc_endMissionServer};