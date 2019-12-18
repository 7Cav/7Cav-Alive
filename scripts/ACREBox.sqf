if (!isServer) exitWith {};

_crate = _this select 0;

while {true} do {

	clearweaponcargoGlobal _crate;
	clearmagazinecargoGlobal _crate;
	clearitemcargoGlobal _crate;
	clearbackpackcargoGlobal _crate;
	
	_crate addItemCargoGlobal ["ACRE_PRC117F",100];
	_crate addItemCargoGlobal ["ACRE_PRC148",100];
	_crate addItemCargoGlobal ["ACRE_PRC152",100];
	_crate addItemCargoGlobal ["ACRE_PRC343",100];
	_crate addItemCargoGlobal ["ACRE_PRC77",100];
	
	sleep 600;
	
};
