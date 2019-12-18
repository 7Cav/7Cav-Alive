_this spawn
{
	params ["_nominalAimCoefficient"];

	scriptName "JB_fnc_weaponSwayInit";

	private _lastWeapon = "";
	private _player = player;

	while { alive _player } do
	{
		sleep 1;

		if (currentWeapon _player != _lastWeapon) then
		{
			_lastWeapon = currentWeapon _player;
			if (_lastWeapon != "") then
			{
				private _mass = getNumber (configFile >> "CfgWeapons" >> _lastWeapon >> "WeaponSlotsInfo" >> "mass");
				private _multiplier = 1.0 + ((_mass - 340) * 0.5 / 340);
				_player setCustomAimCoef (_nominalAimCoefficient * _multiplier);
			};
		};
	};
};
