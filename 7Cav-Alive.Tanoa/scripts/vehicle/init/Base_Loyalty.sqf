_this select 0 addAction [ 
 "<t color=""#EBC729"">" + ("Loyalty Vehicle Selector") + "</t>", 
 { 
  [] call LOYALTY_fnc_OpenSpawnUI; 
 }, 
 "", 
 10, 
 false, 
 false 
];

_this select 0 enableSimulation false;