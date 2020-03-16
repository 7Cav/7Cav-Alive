diag_log "init start";
//TEST
//Server AI Skill
if (isMultiplayer) then {
    switch (cScripts_Settings_setAiSystemDifficulty) do {
        // Day
        case (0): {
            #ifdef DEBUG_MODE
                ["Applying DAY AI to units."] call FUNC(logInfo);
            #endif
            {
                _x setSkill ["aimingspeed",     0.420];
                _x setSkill ["aimingaccuracy",  1.000];
                _x setSkill ["aimingshake",     0.360];
                _x setSkill ["spottime",        1.000];
                _x setSkill ["spotdistance",    1.000];
                _x setSkill ["commanding",      1.0];
                _x setSkill ["general",         1.0];
            } forEach allUnits;
        };
        // Night / Jungle
        case (1): {
            #ifdef DEBUG_MODE
                ["Applying NIGHT/JUNGLE AI to units."] call FUNC(logInfo);
            #endif
            {
                _x setSkill ["aimingspeed",     0.015];
                _x setSkill ["aimingaccuracy",  1.000];
                _x setSkill ["aimingshake",     0.280];
                _x setSkill ["spottime",        0.015];
                _x setSkill ["spotdistance",    0.015];
                _x setSkill ["commanding",      0.2];
                _x setSkill ["general",         1.0];
            } forEach allUnits;
        };
    };
} else {
    ["Mission is running on singelplayer enviroment. Some systems may differ of have been turned off."] call FUNC(logWarning);
};
diag_log "init end";