"towerOnlineMarker" setMarkerAlpha 0;
"towerOfflineMarker" setMarkerAlpha 1;
"towerControlledAirspaceMarker" setMarkerAlpha 0;
towerFlagpole setFlagTexture "\A3\Data_F\Flags\Flag_red_CO.paa";
removeAllActions towerFlagpole;
towerFlagpole addAction["<t color='#008000'>Activate Tower</t>","scripts\towerOn.sqf"];