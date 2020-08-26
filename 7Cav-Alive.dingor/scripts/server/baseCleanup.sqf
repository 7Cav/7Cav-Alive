SERVER_BaseCleanup = {
	private _headquartersArea = triggerArea headquarters;
	{ deleteVehicle _x } forEach (allDeadMen inAreaArray headquarters);
	([getPos headquarters] + _headquartersArea) call SERVER_DeleteWeaponHolders;
};

SERVER_DeleteWeaponHolders =
{
    params ["_center", "_a", "_b", "_angle", "_isRectangle", "_c"];

    {
        deleteVehicle _x;
    } forEach (nearestObjects [_center, ["WeaponHolder"], sqrt (_a*_a + _b*_b)]) inAreaArray [_center, _a, _b, _angle, _isRectangle, _c];
}; 

[] spawn {
  while {true} do {
      [] call SERVER_BaseCleanup; 
      sleep 300;
    };
}; 