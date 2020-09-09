"towerOnlineMarker" setMarkerAlpha 1;
"towerOfflineMarker" setMarkerAlpha 0;
"towerControlledAirspaceMarker" setMarkerAlpha 1;
towerFlagpole setFlagTexture "\A3\Data_F\Flags\Flag_green_CO.paa";
removeAllActions towerFlagpole;
towerFlagpole addAction["<t color='#FF0000'>Deactivate Tower</t>","scripts\towerOff.sqf"];