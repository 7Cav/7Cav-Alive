/*
Authors: JB
*/

CLIENT_DisableActionMenuLevel = 0;

CLIENT_DisableActionMenu = {
	CLIENT_DisableActionMenuLevel = CLIENT_DisableActionMenuLevel + 1;
};

CLIENT_EnableActionMenu = {
	CLIENT_DisableActionMenuLevel = CLIENT_DisableActionMenuLevel - 1;
};

CLIENT_ActionMenuNextHandler = {
	CLIENT_DisableActionMenuLevel > 0
};

CLIENT_ActionMenuPrevHandler = {
	CLIENT_DisableActionMenuLevel > 0
};

CLIENT_ActionMenuActionHandlers = [];

CLIENT_ActionMenuActionHandler = {
	if (CLIENT_DisableActionMenuLevel > 0) exitWith { true };

	private _override = false;

	{
		_override = _override || (_this call _x);
	} forEach CLIENT_ActionMenuActionHandlers;

	_override
};

CLIENT_OverriddenActions = [];
CLIENT_OverrideActionHandler = {
	private _name = _this select 3;
	private _index = CLIENT_OverriddenActions findIf { _x select 0 == _name };

	if (_index == -1) exitWith { false };

	_this call (CLIENT_OverriddenActions select _index select 1)
};

CLIENT_ActionMenuActionHandlers pushBack CLIENT_OverrideActionHandler;

[] spawn {
	waitUntil { not isNull (findDisplay 46) };

	(findDisplay 46) displayAddEventHandler ["KeyDown",
		{
			private _index = CLIENT_OverriddenActions findIf { inputAction (_x select 0) > 0 };
			if (_index == -1) exitWith { false };

			_this call (CLIENT_OverriddenActions select _index select 2)
		}];

	(findDisplay 46) displayAddEventHandler ["MouseButtonDown",
		{
			private _index = CLIENT_OverriddenActions findIf { inputAction (_x select 0) > 0 };
			if (_index == -1) exitWith { false };

			_this call (CLIENT_OverriddenActions select _index select 3)
		}];
};

CLIENT_OverrideAction =
{
	params [["_name", "", [""]], ["_menuHandler", {true}, [{}]], ["_keyHandler", {true}, [{}]], ["_mouseHandler", {true}, [{}]]];

	CLIENT_OverriddenActions pushBack _this;
};

// Lets keep doing this every few seconds to make sure permissions are always set
// ACE and ACEX like to fiddle with these settings as well, so we need to make sure we reset
// them after
[] spawn {
 while { true } do
 {
	inGameUISetEventHandler ["Action", "_this call CLIENT_ActionMenuActionHandler"];
	inGameUISetEventHandler ["NextAction", "_this call CLIENT_ActionMenuNextHandler"];
	inGameUISetEventHandler ["PrevAction", "_this call CLIENT_ActionMenuPrevHandler"];
	sleep 2;
 };
};
