private _state = param [0, "", [""]];

if (_state == "init") then
{
	{
		player setVariable [_x, [[TypeFilter_LogisticsVehicles, [], {}]] + (player getVariable _x)];
	} forEach ["VP_Driver"];

	player setVariable ["SPM_BranchOfService", "support"];
};

if (_state == "respawn") then
{

};