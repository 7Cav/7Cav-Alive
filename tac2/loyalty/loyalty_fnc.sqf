[] call compile preprocessFileLineNumbers "Tac2\secure\encryptedProfile.sqf";
[] call compile preprocessFileLineNumbers "Tac2\loyalty\loyalty_values.sqf";


LOYALTY_fnc_OpenSpawnUI = 
{	
	createDialog "RscTUTVehDialog";
	
	_serverTitleCbo = ((findDisplay 1601) displayCtrl (10));
	_title = "7Cav Loyalty Rewards";
	_serverTitleCbo ctrlSetStructuredText parseText format ["<t align='left' size='1.3'>%1</t>",_title];

	_serverTitleCbo = ((findDisplay 1601) displayCtrl (12));
	_serverTitleCbo ctrlSetStructuredText parseText format [
"
<t align='left' size='0.9' font='EtelkaMonospacePro'>
Current points: %1<br/>
Current level: %2<br/>
CavBucks: %3
</t>
<br/>
<br/>
<t align='left' size='0.9'>Players recieve 10 points every 15 minutes they are active. CavBucks are awarded to players who take
leadership positions, and can be used on vehicles regardless of level.</t>
"
		, call LOYALTY_fnc_getPointsLocal, call LOYALTY_fnc_getLevelLocal, call LOYALTY_fnc_getCavBucksLocal
	];

	[] call LOYALTY_fnc_loadVehicle;

	_spawnButton = (findDisplay 1601) displayCtrl 6;
	_spawnButtonCavBucks = (findDisplay 1601) displayCtrl 14;

	_spawnButton ctrlShow false;
	_spawnButton ctrlEnable false;	

	_spawnButtonCavBucks ctrlShow false;
	_spawnButtonCavBucks ctrlEnable false;

	_dropDown = ((findDisplay 1601) displayCtrl (13));
	_dropDown ctrlShow false;

	_spawnLocationDropDown =  ((findDisplay 1601) displayCtrl (15));
	_spawnLocationDropDown ctrlShow false;
};


LOYALTY_fnc_loadVehicle = 
{
	_cbo = ((findDisplay 1601) displayCtrl (7));
	lbCLear _cbo;
	{
		_vehicleClass = _x select 0;
		_vehiclePoints = _x select 1;

		_vIndex = _cbo lbAdd(getText(configFile >> "cfgVehicles" >> _vehicleClass >> "displayName"));
		_cbo lbSetData[_vIndex, str _forEachIndex];

		_cbo lbSetValue [_vIndex,  _vehiclePoints];

		_picture = (getText(configFile >> "cfgVehicles" >> _vehicleClass >> "picture"));
		_cbo lbSetPicture[_vIndex,_picture];
	} foreach LoyaltyVehicles;

	lbSortByValue _cbo
};


LOYALTY_fnc_vehicleInfo = 
{
	disableSerialization;

	_vehicleIndex = parseNumber (lbData [7, lbCurSel 7]);
	_vehicle = LoyaltyVehicles select _vehicleIndex;
	_vehicle params ["_vehicleClass", "_levelCost", "_cavBuckCost", "_cooldownCost", "_maxVehicles", "_message", "_defaultSpawn", "_condition", "_callBack"];


	_dropDown = ((findDisplay 1601) displayCtrl (13));
	lbCLear _dropDown;
	{
		_textureIndex = _dropDown lbAdd format ["%1", getText (_x >> "displayName")];
		_dropDown lbSetData [_textureIndex, str getArray (_x >> "textures")];
	} foreach ("true" configClasses (configfile >> "CfgVehicles" >>_vehicleClass >> "textureSources"));
	_dropDown ctrlShow true;


	_spawnLocationDropDown = ((findDisplay 1601) displayCtrl (15));
	lbCLear _spawnLocationDropDown;

	_landIndex = -1;
	_airIndex = -1;
	if (!isNull loyaltySpawn) then { 
		_landIndex = _spawnLocationDropDown lbAdd "Land Vehicle Spawn";
		_spawnLocationDropDown lbSetData [_landIndex, "land"];
	};
	if (!isNull loyaltyAirSpawn) then { 
		_airIndex = _spawnLocationDropDown lbAdd "Air Vehicle Spawn";
		_spawnLocationDropDown lbSetData [_airIndex, "air"];
	};
	if (_defaultSpawn == "land") then { _spawnLocationDropDown lbSetCurSel _landIndex; }; 
	if (_defaultSpawn == "air") then { _spawnLocationDropDown lbSetCurSel _airIndex; }; 

	_spawnLocationDropDown ctrlShow true;


	_textCbo = ((findDisplay 1601) displayCtrl (8));	
	_textCbo ctrlSetStructuredText parseText format 
	[
		"
		<t align='left'>Name: %1</t><br/>
		<t align='left'>Level: %2 (%3 points)</t><br/>
		<t align='left'>Cooldown: %4 minutes</t><br/>
		<t align='left' size='0.7'>%5</t>",
		getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName"),
		_levelCost,
		[_levelCost] call LOYALTY_fnc_getPointsForLevel,
		_cooldownCost,
		_message
	];


	[_vehicle] call LOYALTY_fnc_showSpawnButton;
};


LOYALTY_fnc_showSpawnButton =
{
	_this select 0 params ["_vehicleClass", "_levelCost", "_cavBuckCost", "_cooldownCost", "_maxVehicles", "_message", "_defaultSpawn", "_condition", "_callBack"];

	_spawnButton = (findDisplay 1601) displayCtrl 6;
	_spawnButtonCavBucks = (findDisplay 1601) displayCtrl 14;
	_spawnButton ctrlShow true;

	_lastSpawnTime = missionNamespace getVariable [getPlayerUID player + "Tac2Loyalty_LastSpawnTime", 0];
	_lastCooldownLength = call LOYALTY_fnc_getCooldownLocal;
	_playerLevel = call LOYALTY_fnc_getLevelLocal;
	_playerCavBucks = call LOYALTY_fnc_getCavBucksLocal;

	_allowRegularSpawn = true;
	_allowCavBucksSpawn = true;
	_reason = "";

	if (_lastSpawnTime + _lastCooldownLength > serverTime) then {
		_allowRegularSpawn = false;
		_allowCavBucksSpawn = false;
		_reason = format ["Cooldown for another %1 minutes", round (((_lastSpawnTime + _lastCooldownLength) - serverTime) / 60)];
	};

	if (_playerCavBucks < _cavBuckCost) then {
		_allowCavBucksSpawn = false;
	};

	if (_playerLevel < _levelCost) then {
		_allowRegularSpawn = false;
		_reason = format ["Unlocked at level %1", _levelCost];
	};

	_vehicleInstances = 0;
	{
		if ((_x isKindOf _vehicleClass) && (alive _x)) then {
			_vehicleInstances = _vehicleInstances + 1
		};
	} forEach vehicles;

	if (_maxVehicles != -1 && _vehicleInstances >= _maxVehicles) then {
		_allowRegularSpawn = false;
		_allowCavBucksSpawn = false;
		_reason = format ["Maximum number reached (%1)", _maxVehicles];
	};

	if (!([] call _condition)) then {
		_allowRegularSpawn = false;
		_allowCavBucksSpawn = false;
		_reason = "Unavailable";
	};
	
	if (_allowRegularSpawn) then {
		_spawnButton ctrlEnable true;
		_spawnButton ctrlSetText "Spawn";
	} else {
		_spawnButton ctrlEnable false;
		_spawnButton ctrlSetText _reason;
	};

	if (_allowCavBucksSpawn) then {
		_spawnButtonCavBucks ctrlEnable true;
		_spawnButtonCavBucks ctrlShow true;		
		_spawnButtonCavBucks ctrlSetText format ["Spend %1 CavBucks", _cavBuckCost];
	} else {
		_spawnButtonCavBucks ctrlEnable false;
		_spawnButtonCavBucks ctrlShow false;		
	};
};


LOYALTY_fnc_vehicleCreate = 
{
	params [["_spawnCurrency", "points"]];
	_vehicleIndex = parseNumber (lbData [7, lbCurSel 7]);
	_vehicle = LoyaltyVehicles select _vehicleIndex;
	_vehicle params ["_vehicleClass", "_levelCost", "_cavBuckCost", "_cooldownCost", "_maxVehicles", "_message", "_condition", "_callBack"];


	_spawnLocation = lbData [15, lbCurSel 15];
	_emptyPos = (getPos player) findEmptyPosition [5, 50, (_vehicleClass)];
	if (!isNull loyaltySpawn && _spawnLocation == "land") then { 
		_emptyPos = (getPos loyaltySpawn) findEmptyPosition [5, 50, (_vehicleClass)];
	};
	if (!isNull loyaltySpawn && _spawnLocation == "air") then { 
		_emptyPos = (getPos loyaltyAirSpawn) findEmptyPosition [5, 50, (_vehicleClass)];
	};


	if (count _emptyPos == 0) then { hint "Vehicle cannot be spawned here"; }
	else
	{	
		_veh = createVehicle [(_vehicleClass), _emptyPos, [], 0,""];
		if ((lbData [13, lbCurSel 13]) != "") then {
			_vehicleTextures = parseSimpleArray (lbData [13, lbCurSel 13]);
			{_veh setObjectTextureGlobal [ _forEachIndex, _x ] } forEach _vehicleTextures;
		};

		[_cooldownCost * 60] call LOYALTY_fnc_setCooldownLocal;
		missionNamespace setVariable [getPlayerUID player + "Tac2Loyalty_LastSpawnTime", serverTime];
		
		if (_spawnCurrency == "CavBucks") then {
			[_cavBuckCost] call LOYALTY_fnc_spendCavBucksLocal;
		};

		[_veh] call _callBack;
		player setPos (getPos _veh vectorAdd (boundingBoxReal _veh select 0));	
	};
	closeDialog 1601;	
};

LOYALTY_fnc_getPointsForLevel =
{
	params ["_level"];
	LoyaltyLevels select {_x select 0 == _level} select 0 select 1
};

LOYALTY_fnc_getLevelLocal = 
{
	_playerPoints = call LOYALTY_fnc_getPointsLocal;

	_level = 0;
	{
		if (_playerPoints < _x select 1) exitWith {_level};
		_level = _x select 0;
	} forEach LoyaltyLevels;
	_level
};

LOYALTY_fnc_showHUD = 
{
	params [["_message",""]];

	100 cutRsc ["LoyaltyHUD","PLAIN"];
	_messageCtrl = ((uiNamespace getVariable "loyaltyHUD") displayCtrl 5);
	_levelCtrl = ((uiNamespace getVariable "loyaltyHUD") displayCtrl 1);
	_pointsCtrl = ((uiNamespace getVariable "loyaltyHUD") displayCtrl 4);
	_progressCtrl = ((uiNamespace getVariable "loyaltyHUD") displayCtrl 3);

	if (count _message > 0) then {
		_messageCtrl ctrlSetStructuredText parseText _message;
	};

	_numerator = (call LOYALTY_fnc_getPointsLocal) - ([call LOYALTY_fnc_getLevelLocal] call LOYALTY_fnc_getPointsForLevel);
	_denom = ([call LOYALTY_fnc_getLevelLocal +1] call LOYALTY_fnc_getPointsForLevel) - ([call LOYALTY_fnc_getLevelLocal] call LOYALTY_fnc_getPointsForLevel);
	_percentage = _numerator/_denom;

	_levelCtrl ctrlSetText (str call LOYALTY_fnc_getLevelLocal);
	_pointsCtrl ctrlSetText (str call LOYALTY_fnc_getPointsLocal) + "/" + str([call LOYALTY_fnc_getLevelLocal +1] call LOYALTY_fnc_getPointsForLevel);
	_progressCtrl progressSetPosition (_percentage);
};

LOYALTY_fnc_addPointsLocal =
{
	params ["_points", ["_reason", ""]];
	_playerPoints = call LOYALTY_fnc_getPointsLocal;
	["Tac2Loyalty_PlayerPoints", _playerPoints + _points] call SECURE_setProfileVariable;
	[format ['Awarded <t color="#14871c">+%1</t> loyalty points %2', _points, _reason]] call LOYALTY_fnc_showHUD;
};

LOYALTY_fnc_getPointsLocal =
{
	parseNumber (["Tac2Loyalty_PlayerPoints", "0"] call SECURE_getProfileVariable);
};

LOYALTY_fnc_getCooldownLocal =
{
	missionNamespace getVariable [getPlayerUID player + "Tac2Loyalty_Cooldown", 0];
};

LOYALTY_fnc_setCooldownLocal =
{
	params ["_cooldownLength"];
	missionNamespace setVariable [getPlayerUID player + "Tac2Loyalty_Cooldown", _cooldownLength];
};

LOYALTY_fnc_addCavBucksLocal =
{
	params ["_cavBucks", ["_reason", ""]];
	_playerCavBucks = call LOYALTY_fnc_getCavBucksLocal;
	["Tac2Loyalty_PlayerCavBucks", _playerCavBucks + _cavBucks] call SECURE_setProfileVariable;
	titleText [format ['Awarded +%1 CavBucks %2', _cavBucks, _reason], "plain"]; 
};

LOYALTY_fnc_spendCavBucksLocal =
{
	params ["_cost"];
	_playerCavBucks = call LOYALTY_fnc_getCavBucksLocal;
	["Tac2Loyalty_PlayerCavBucks", _playerCavBucks - _cost] call SECURE_setProfileVariable;
};

LOYALTY_fnc_getCavBucksLocal =
{
	parseNumber (["Tac2Loyalty_PlayerCavBucks", "0"] call SECURE_getProfileVariable);
};