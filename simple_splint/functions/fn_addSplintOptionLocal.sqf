/*
Name: SimpleSplint
Author: Bojan

Adds the ACE interact option to the given unit.
*/
params ["_unit"];

private _broken_legs = {
	if ((_target getHitPointDamage "HitLegs") < 0.5) exitWith { false };
	true
};

private _broken_arms = {
	if ((_target getHitPointDamage "HitHands") < 0.5) exitWith { false };
	true
};

private _can_splint = {
	//Get CBA settings
	private _medic_requirement = missionNamespace getVariable ["simple_splint_medic_requirement", 0];
	private _require_splint = missionNamespace getVariable ["simple_splint_require_item", true];
	private _consume_splint = missionNamespace getVariable ["simple_splint_consume_item", true];
	private _require_stable = missionNamespace getVariable ["simple_splint_require_stable", true];
	private _require_splint_class = missionNamespace getVariable ["simple_splint_require_item_class", "ACE_personalAidKit"];
	private _consume_splint_class = missionNamespace getVariable ["simple_splint_consume_item_class", "ACE_personalAidKit"];

	// Check for medical privilages
	// If _medic_requirement is 0, this always returns true. 1=medic, 2=doctor
	private _medic = [player, _medic_requirement] call ace_medical_fnc_isMedic;
	if !(_medic) exitWith { false };

	// If patient needs to be stable and they aren't, exit false
	private _stable = true;
	if (_require_stable) then {
		if !(_target call ace_medical_fnc_isInStableCondition) then { _stable = false };
	};
	if !(_stable) exitWith { false };

	// If we require an item, or we consume an item, check to see if we have both of them
	// Set _all_items_available to false if we are missing something
	private _all_items_available = true;
	if (_require_splint && !(_consume_splint)) then {
		_all_items_available = [_player, _target, _require_splint_class] call ace_medical_fnc_hasItem;
	};
	if (_require_splint && _consume_splint) then{
		_all_items_available = [_player, _target, [_require_splint_class, _consume_splint_class]] call ace_medical_fnc_hasItems;
	};
	if !(_all_items_available) exitWith { false };

	// Check if the arms or legs need fixing
	if ((_target getHitPointDamage "HitHands") > 0.5) exitWith { true };
	if ((_target getHitPointDamage "HitLegs") > 0.5) exitWith { true };

	// If the limbs dont need help, then do not allow splints
	false
};

// The selection numbers array refer to ACE medical body parts numbered 1-6
private _splint_legs = {
	["HitLegs", [4,5], _player, _target] call simple_splint_fnc_splintLimb;
};

private _splint_arms = {
	["HitHands", [2,3], _player, _target] call simple_splint_fnc_splintLimb;
};

private _action = ["SplintParent", "Apply SAM Splint", "simple_splint\ui\splint_action.paa", {true}, _can_splint] call ace_interact_menu_fnc_createAction;
[_unit, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
[_unit, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;


_action = ["SplintLeg", "Splint broken leg", "", _splint_legs, _broken_legs] call ace_interact_menu_fnc_createAction;
[_unit, 0, ["ACE_MainActions", "SplintParent"], _action] call ace_interact_menu_fnc_addActionToObject;
if (local _unit) then {
	[_unit, 1, ["ACE_SelfActions", "SplintParent"], _action] call ace_interact_menu_fnc_addActionToObject;
};

 _action = ["SplintArm", "Splint broken arm", "", _splint_arms, _broken_arms] call ace_interact_menu_fnc_createAction;
[_unit, 0, ["ACE_MainActions", "SplintParent"], _action] call ace_interact_menu_fnc_addActionToObject;
if (local _unit) then {
	[_unit, 1, ["ACE_SelfActions", "SplintParent"], _action] call ace_interact_menu_fnc_addActionToObject;
};
