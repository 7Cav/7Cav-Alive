class CrewList
{
	idd = -1;
    fadeout = 0;
    fadein = 0;
	duration = 1e30;
	name= "CrewList";
	onLoad = "uiNamespace setVariable ['CrewList', _this select 0]";
	onKeyDown = "systemchat format ['Saw %1', _this]; true";
	
	class controlsBackground
	{
		class CrewListNames : RscStructuredText
		{
			idc = 1000;
			type = CT_STRUCTURED_TEXT;
			size = 0.04;
			x = (SafeZoneX + 0.015);
			y = (SafeZoneY + 0.4);
			w = 0.4;
			h = 0.65;
			colorText[] = {1,1,1,1};
			lineSpacing = 3;
			colorBackground[] = {0,0,0,0};
			text = "";
			font = "PuristaLight";
			shadow = 2;
			class Attributes
			{
				align = "left";
			};
		};

	};
};