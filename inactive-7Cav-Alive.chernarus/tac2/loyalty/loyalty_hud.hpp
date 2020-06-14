#define true 1
#define false 0
#define cavYellow {0.922,0.78,0.161,1}
#define cavYellowHex "#EBC729"
#define cavGrey {0.631,0.631,0.631,1}
#define cavGreyHex "#A1A1A1"
#define black {0,0,0,1}
#define white {1,1,1,1}
#define wr *3/4
#define hr *1

class LoyaltyHUD
{    
	idd = 1602;
	duration = 5;
	onLoad = "uiNamespace setVariable ['loyaltyHUD',_this select 0]";
	class controls
	{
		class CurrentLevel: RscStructuredText
		{    
			idc = 1;
			x = safezoneW + safezoneX - 0.30wr;
			y = safezoneH + safezoneY - 0.09hr;
			w = 0.2wr;
			h = 0.2hr;
			font = "EtelkaNarrowMediumPro";
			colorText[] = cavYellow;
			color[] = cavYellow;
			text = "";
			class Attributes
			{
				font = "PuristaMedium";
				color = cavYellowHex;
				align = "left";
				shadow = 1;
			};
		}; 

		class PointsBar: RscProgress
        {
            idc = 3;
			x = safezoneW + safezoneX - 0.24wr;
			y = safezoneH + safezoneY - 0.08hr;
			w = 0.2wr;
			h = 0.026hr;
			colorBar[] = {0.922,0.78,0.161,0.6};
			colorFrame[] = cavGrey;
        }; 

		class PointCount: RscStructuredText
		{    
			idc = 4;
			x = safezoneW + safezoneX - 0.2wr;
			y = safezoneH + safezoneY - 0.085hr;
			w = 0.2wr;
			h = 0.2hr;
			font = "EtelkaNarrowMediumPro";
			colorText[] = cavYellow;
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			text = "";
		};

		class PointMessage: RscStructuredText
		{    
			idc = 5;
			x = safezoneW + safezoneX - 0.84wr;
			y = safezoneH + safezoneY - 0.115hr;
			w = 0.8wr;
			h = 0.2hr;
			font = "EtelkaNarrowMediumPro";
			colorText[] = cavYellow;
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			text = "";
			 class Attributes {
				align = "right";
			};
		};  
	};	
};

