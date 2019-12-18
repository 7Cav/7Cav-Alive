CREW_Line =
{
	params ["_icon", "_name", "_color"];

	format ["<img size='1.0' color='#aa%3' image='a3\ui_f\data\IGUI\Cfg\Actions\getin%1_ca.paa'/> <t size='0.80' color='#aa%3'>%2</t><br/>", _icon, _name, _color];
};

#define NUMBER_VISIBLE_SEATS 12
#define DISPLAY_UPDATE_INTERVAL 1

CREW_UpdateCrewDisplay =
{
	params ["_vehicle"];

	disableSerialization;

	if (vehicle player != _vehicle || not (lifeState player in ["HEALTHY", "INJURED"])) exitWith
	{
		("CREW_Layer" call BIS_fnc_rscLayer) cutText ["", "plain", 0, false];
	};

	("CREW_Layer" call BIS_fnc_rscLayer) cutRsc ["CrewList", "plain", 0, false];
	private _crewList = (uiNameSpace getVariable "CrewList") displayCtrl 1000;

	private _playerColor = "f0e68c";
	private _otherColor = "ffffff";
	private _incapacitatedColor = "ed2744";
	private _aiColor = "aaaaaa";

	private _driverLines = [];
	private _commanderLines = [];
	private _gunnerLines = [];
	private _cargoLines = [];

	{
		private _name = if (not alive (_x select 0)) then { "" } else { ((name (_x select 0)) splitString "&") joinString "&amp;" };
		private _color = switch (true) do
		{
			case (_x select 0 == player): { _playerColor };
			case (not isPlayer (_x select 0)): { _aiColor };
			case (lifeState (_x select 0) == "INCAPACITATED"): { _incapacitatedColor };
			default { _otherColor };
		};
		
		switch (_x select 1) do
		{
			case "driver":
			{
				_driverLines pushBack (["driver", _name, _color]);
			};

			case "gunner":
			{
				_gunnerLines pushBack (["gunner", _name, _color]);
			};

			case "commander":
			{
				_commanderLines pushBack (["commander", _name, _color]);
			};

			case default
			{
				if (count (_x select 3) > 0 && not (_x select 4)) then
				{
					_gunnerLines pushBack (["gunner", _name, _color]);
				}
				else
				{
					_cargoLines pushBack (["cargo", _name, _color]);
				};
			};
		};
	} forEach fullCrew [_vehicle, "", true];

	private _remainingSpace = NUMBER_VISIBLE_SEATS;

	private _text = "";
	{
		_text = _text + (_x call CREW_Line);
		_remainingSpace = _remainingSpace - 1;
	} forEach _driverLines;
	{
		_text = _text + (_x call CREW_Line);
		_remainingSpace = _remainingSpace - 1;
	} forEach _commanderLines;
	{
		_text = _text + (_x call CREW_Line);
		_remainingSpace = _remainingSpace - 1;
	} forEach _gunnerLines;

	if (count _cargoLines <= _remainingSpace) then
	{
		{
			_text = _text + (_x call CREW_Line);
		} forEach _cargoLines;
	}
	else
	{
		private _visibleCargoSeats = _remainingSpace;
		private _occupiedCargoSeats = 0;
		{
			if (_x select 1 != "") then
			{
				_occupiedCargoSeats = _occupiedCargoSeats + 1;

				if (_remainingSpace > 0) then
				{
					_text = _text + (_x call CREW_Line);
					_remainingSpace = _remainingSpace - 1;
				};
			};
		} forEach _cargoLines;

		for "_i" from 1 to _remainingSpace do
		{
			_text = _text + (["cargo", "", _otherColor] call CREW_Line);
		};

		private _filledSeatsNotShown = _occupiedCargoSeats - _visibleCargoSeats;
		private _filledSeatsNotShownText = if (_filledSeatsNotShown <= 0) then { "" } else { format ["plus %1", _filledSeatsNotShown] };

		private _emptySeatsNotShown = ((count _cargoLines) - _occupiedCargoSeats) - _remainingSpace;
		private _emptySeatsNotShownText = if (_emptySeatsNotShown <= 0) then { "" } else { format ["(%1 additional seats)", _emptySeatsNotShown] };

		private _separator = if (_filledSeatsNotShownText != "" && _emptySeatsNotShownText != "") then { ", " } else { "" };

		_text = _text + format ["<t size='0.7' color='#aa%4'>%1%2%3</t>", _filledSeatsNotShownText, _separator, _emptySeatsNotShownText, _otherColor];
	};

	_crewList ctrlSetStructuredText parseText _text;
};

CREW_StartCrewDisplay =
{
	if (!canSuspend) then
	{
		_this spawn CREW_StartCrewDisplay;
	}
	else
	{
		private _updateTime = 0;
		private _vehicle = vehicle player;

		if (_vehicle isKindOf "ParachuteBase") exitWith {};

		// Keep track of the comings and goings of other players
		private _getInHandler = _vehicle addEventHandler ["GetIn", { [_this select 0] call CREW_UpdateCrewDisplay }];
		private _getOutHandler = _vehicle addEventHandler ["GetOut", { [_this select 0] call CREW_UpdateCrewDisplay }];

		private _player = player;

		while { vehicle _player == _vehicle && (lifeState _player in ["HEALTHY", "INJURED"]) } do
		{
			if (_updateTime < diag_tickTime) then
			{
				[_vehicle] call CREW_UpdateCrewDisplay;
				_updateTime = diag_tickTime + DISPLAY_UPDATE_INTERVAL;
			};

			sleep 0.2;
		};

		[_vehicle] call CREW_UpdateCrewDisplay;

		private _getOutHandler = _vehicle removeEventHandler ["GetOut", _getOutHandler];
		private _getInHandler = _vehicle removeEventHandler ["GetIn", _getInHandler];
	};
};

player addEventHandler ["GetInMan", CREW_StartCrewDisplay];