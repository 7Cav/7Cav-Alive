[{
  params ["_unit", "_side", "_object"];
  _apollo_units = ["rhsusf_army_ocp_jfo"];
  _return = true;

  // Check if Apollo
  if(!(player getVariable ["TAC2_canFortify", false])) then {
    _return = false;
    ["You must be an Apollo unit to fortify.", 3] call utils_fnc_showBlackScreenMessage;
  };

  // Check if in base
  if(player inArea headquarters) then {
    _return = false;
    ["You may not fortify on base.", 3] call utils_fnc_showBlackScreenMessage;
  };

  _return;
}] call acex_fortify_fnc_addDeployHandler;


['acex_fortify_objectPlaced', {
  params ["_unit", "_side", "_object"];

    if (typeof _object == "Land_PortableServer_01_olive_F") then {
    fobRadio = _object;
    publicVariable "fobRadio";
    [_object, true, [0, 2, 0], 0] remoteExec ["ace_dragging_fnc_setCarryable",2];
    fobRadio addAction ["Set Up FOB Radio", {
      [fobRadio] remoteExec ["acre_api_fnc_initVehicleRacks", 0];  
      [fobRadio, ["ACRE_VRC110", "FOB Radio", "ERadio", false, ["external"], [], "ACRE_PRC152", [], []],false, {true}] remoteExec ["acre_api_fnc_addRackToVehicle", 0];
    }];
  };

  if (typeof _object == "MASH") then {
    _object setVariable ["ace_medical_isMedicalFacility", true, true];
  };

  if (typeof _object != "CargoPlaftorm_01_jungle_F") exitWith {true};

  [_object] spawn {
    params ["_object"];
    sleep 1.5;
    _object animate ['panel_1_hide', 1];
    _object animate ['panel_2_hide', 1];
    _object animate ['panel_3_hide', 1];
    _object animate ['panel_4_hide', 1];
    
    private _nearPlatforms = nearestObjects [_object, ['CargoPlaftorm_01_jungle_F'], 15];
    if (count _nearPlatforms > 1) then {
      private _nearestPlatform = _nearPlatforms select 1;

      private _dir1 = (_nearestPlatform getPos [6, getDir _nearestPlatform]);
      private _dir2 = (_nearestPlatform getPos [6, (getDir _nearestPlatform) + 90]);
      private _dir3 = (_nearestPlatform getPos [6, (getDir _nearestPlatform) + 180]);
      private _dir4 = (_nearestPlatform getPos [6, (getDir _nearestPlatform) + 270]);

      private _d1 = _object distance _dir1;
      private _d2 = _object distance _dir2;
      private _d3 = _object distance _dir3;
      private _d4 = _object distance _dir4;

      private _posXY = nil;
      if (_d1 < _d2 && _d1 < _d3 && _d1 < _d4) then { _posXY = _dir1 };
      if (_d2 < _d1 && _d2 < _d3 && _d2 < _d4) then { _posXY = _dir2 };
      if (_d3 < _d2 && _d3 < _d1 && _d3 < _d4) then { _posXY = _dir3 };
      if (_d4 < _d2 && _d4 < _d3 && _d4 < _d1) then { _posXY = _dir4 };

      _object setPosASL (getPosASL _nearestPlatform);
      _object setDir (getDir _nearestPlatform);

      private _posZ = (getPosASL _nearestPlatform) select 2; 
      _object setPosASL [_posXY select 0, _posXY select 1, _posZ]; 
      _object setDir (getDir _nearestPlatform);

    } else {
      _object setPosASL ((getposasl _object) vectorAdd [0, 0, -7]);
    }; 
  }
}] call CBA_fnc_addEventHandler; 