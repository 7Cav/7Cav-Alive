private _state = param [0, "", [""]];

if (_state == "init") then
{	
	[player] call CLIENT_SetInfantryVehiclePermissions;
};

if (_state == "respawn") then
{

};