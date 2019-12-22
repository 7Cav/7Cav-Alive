class Tac2 {
	tag = "Tac2";
	class functions {
		file = "Tac2";
		class fortifyPermissionsInitPlayer;
		class treeCutterInitPlayer;
		class ammoBoxSpawner;
		class hasLineOfSight;
	};
	class modules {
		file = "Tac2\modules";
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
		file = "Tac2\modules\impl";
		class chainUnchainUnit;
		class setUndercoverAuto;
		class unsetUndercoverAuto;
		class updateUnitRatings;
	};
};
