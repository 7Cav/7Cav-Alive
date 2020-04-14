CLIENT_CuratorType = "";

CLIENT_DisableZeusWatermark =
{
	[] spawn
	{
		scriptName "CLIENT_DisableZeusWatermark";

		disableSerialization;

		private _display = displayNull;
		private _ctrl = controlNull;

		while {true} do
		{
			waitUntil { sleep 1; !isNull (findDisplay 312) };
			_display = (findDisplay 312);
			_ctrl = _display displayCtrl 15717;
			_ctrl ctrlSetText "";
			_ctrl ctrlCommit 0;
			waitUntil { sleep 1; isNull (findDisplay 312) };
		};
	};
};

CLIENT_SetCuratorType =
{
	params ["_curatorType"];

	CLIENT_CuratorType = _curatorType;

	switch (_curatorType) do
	{
		case "MC":
		{
			[] call CLIENT_DisableZeusWatermark;
		};

		case "MP":
		{
			[] call CLIENT_DisableZeusWatermark;
		};

		case "CO":
		{
			[] call CLIENT_DisableZeusWatermark;
		};
	};
};

// Boot out players who do not meet requirements for a slot
// Uses custom debrief screen defined in description.ext
CLIENT_DoesNotMeetRequirements =
{
	params ["_requirements"];

	endMission "RestrictedRole";
};

CLIENT_AnnounceCurator =
{
	params ["_curator", "_curatorType"];

	switch (_curatorType) do
	{
		case "MC":
		{
			systemchat format ["%1 has been assigned curator abilities (Mission Controller)", name _curator];
		};

		case "MP":
		{
			systemchat format ["%1 has been assigned curator abilities (Military Police)", name _curator];
		};

		case "CO":
		{
			systemchat format ["%1 has been assigned curator abilities (Camera Operator)", name _curator];
		};
	};
};