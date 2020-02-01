/*
Author: Bojan

Allows players to "cut down" nearby trees
*/

#define CUTTING_TIME 10

private _cutDownTree = {
	[
		CUTTING_TIME, 
		[], 
		{
			// Action
			private _nearestTree = (nearestTerrainObjects [player,["tree", "bush"],20] select 0);
			[_nearestTree, true] remoteExec ["hideObjectGlobal", 2];
		}, 
		{
			// On failure
		}, 
		"Cutting Down Tree"
	] call ace_common_fnc_progressBar;
};

private _treeNearby = {
	private _nearestTree = (nearestTerrainObjects [player,["tree", "bush"],20] select 0);
	if(not isNull _nearestTree) exitWith { not isObjectHidden _nearestTree; };
	false
};

private _action = ["TreeCutterParent", "Remove Closest Tree/Bush", "", _cutDownTree, _treeNearby] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

