[] call compile preprocessFileLineNumbers "Tac2\secure\oo_cipher.sqf";

SECURE_setProfileVariable = {
	params ["_variable", "_value"];
	private _cipher = "new" call OO_CIPHER;

	if (typeName _value == "SCALAR") then { _value = str _value };
	_valueWithSalt = (getPlayerUID player) + (_value);

	_encryptedData = ["cipher",[LOYALTY_CIPHER, _valueWithSalt]] call _cipher;
	profileNamespace setVariable [_variable, _encryptedData];	
};

SECURE_getProfileVariable = {
	params ["_variable", "_defaultValue"];
	private _cipher = "new" call OO_CIPHER;

	_encryptedData = profileNamespace getVariable [_variable, "-1"];
	if (_encryptedData == "-1") exitWith { _defaultValue };

	_unencryptedData = ["uncipher",[LOYALTY_CIPHER, _encryptedData]] call _cipher;
	if (count _unencryptedData <= count (getPlayerUID player)) exitWith { _defaultValue };

	_unencryptedDataWithoutSalt = (_unencryptedData select [count (getPlayerUID player)]);
	_unencryptedDataWithoutSalt;
};
