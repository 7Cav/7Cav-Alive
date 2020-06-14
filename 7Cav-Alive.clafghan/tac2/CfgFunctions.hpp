class tac2 {
	tag = "Tac2";
	class functions {
		file = "tac2";
		class fortifyPermissionsInitPlayer;
		class treeCutterInitPlayer;
		class ammoBoxSpawner;
		class hasLineOfSight;
	};
	class modules {
		file = "tac2\modules";
		class initAresModules;
		class modAddGResistance;
		class modAddVehiclePermissions;
		class modAddFortify;
		class modChainUnit;
		class modDefineCivilians;
		class modSetUndercoverAuto;
		class modSetUndercoverManual;
		class modUnchainUnit;
		class modUnsetUndercover;
		class modHideObjects;
		class modCopyTerrainObject;
		class modSetRelHeight;
	};
	class modules_impl {
		file = "tac2\modules\impl";
		class chainUnchainUnit;
		class setUndercoverAuto;
		class unsetUndercoverAuto;
		class updateUnitRatings;
	};
};
