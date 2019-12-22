[{
  params ["_unit", "_side", "_object"];
  _apollo_units = ["rhsusf_army_ocp_jfo"];
  _return = true;

  // Check if Apollo
  if(!(player getVariable ["TAC2_canFortify", false])) then {
    _return = false;
    ["You must be an Apollo unit to fortify.", 3] call JB_fnc_showBlackScreenMessage;
  };

  // Check if in base
  if(player inArea headquarters) then {
    _return = false;
    ["You may not fortify on base.", 3] call JB_fnc_showBlackScreenMessage;
  };

  _return;
}] call acex_fortify_fnc_addDeployHandler;
