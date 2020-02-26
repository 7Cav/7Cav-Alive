class init
{
	tag = "init";
	class functions
	{
		file = "init";
		class serverPreInit { preInit = 1; };
		class clientPreInit { preInit = 1; };
		class bothPreInit { preInit = 1; };
		class serverPostInit { postInit = 1; };
		class clientPostInit { postInit = 1; };
		class bothPostInit { postInit = 1; };
	};
};