CLIENT_CMD_HandleCommandDD = 
{
	if (not (CLIENT_CuratorType in ["DD"])) exitWith { systemChat "You must be a developer to use this command." };

	[_this select 0, player, "DD"] remoteExec ['SERVER_CMD_HandleCommand', 2];
};

CLIENT_CMD_HandleCommandMC = 
{
	if (not (CLIENT_CuratorType in ["DD", "MC"])) exitWith { systemChat "You must be a mission controller to use this command." };

	[_this select 0, player, "MC"] remoteExec ['SERVER_CMD_HandleCommand', 2];
};

CLIENT_CMD_HandleCommandMP = 
{
	if (not (CLIENT_CuratorType in ["DD", "MC", "MP"])) exitWith { systemChat "You must be an MP to use this command." };

	[_this select 0, player, "MP"] remoteExec ['SERVER_CMD_HandleCommand', 2];
};

CLIENT_CMD_HandleCommandRG = 
{
	[_this select 0, player, "RG"] remoteExec ['SERVER_CMD_HandleCommand', 2];
};


["dd", CLIENT_CMD_HandleCommandDD, "all"] call CBA_fnc_registerChatCommand;
["mc", CLIENT_CMD_HandleCommandMC, "all"] call CBA_fnc_registerChatCommand;
["mp", CLIENT_CMD_HandleCommandMP, "all"] call CBA_fnc_registerChatCommand;
["cmd", CLIENT_CMD_HandleCommandRG, "all"] call CBA_fnc_registerChatCommand;