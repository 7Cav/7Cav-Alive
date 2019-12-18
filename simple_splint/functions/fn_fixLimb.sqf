/*
Name: SimpleSplint
Author: Bojan

Given a hitPoint like HitArms or HitHands, sets the hitPoint to 0.
*/
params ["_args"];
_args params ["_hitPoint", "_selectionNumbers", "_player", "_target"];

// Fix limbs
[_target, _hitPoint,0,false] call ace_medical_fnc_setHitPointDamage;

// Remove injuries from body parts
_bodyPartStatus = _target getVariable "ace_medical_bodyPartStatus";
{
    _bodyPartStatus set [_x, 0];
} forEach _selectionNumbers;
_bodyPartStatus = _target setVariable ["ace_medical_bodyPartStatus", _bodyPartStatus, true];


// Target should be fixed by now
// Remove item if enabled
private _consume_splint = missionNamespace getVariable ["simple_splint_consume_item",true];

if (_consume_splint) then {
  private _splint_item = missionNamespace getVariable ["simple_splint_consume_item_class", "ACE_personalAidKit"];
  [_player, _target, _splint_item] call ace_medical_fnc_useItem;
};

// Write to medical log
[_target, "activity", "%1 applied splint to %2", [[_player, false, true] call ace_common_fnc_getName, [_target, false, true] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;
[_target, "activity_view", "%1 applied splint to %2", [[_player, false, true] call ace_common_fnc_getName, [_target, false, true] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;

// Don't do animations in vehicle
if (_player == vehicle _player) then { 
  _player switchMove "AmovPknlMstpSrasWrflDnon"
  };
