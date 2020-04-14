/*-------------------BASE LOADOUTS-------------------*/
class tac2_base : CommonBlufor {
    backpack[] = {"B_AssaultPack_mcamo"};
    goggles[] = {""};
    headgear[] = {"rhsusf_ach_helmet_headset_ess_ocp_alt"};
    uniform[] = {"rhs_uniform_acu_oefcp"};
    vest[] = {"rhsusf_iotv_ocp_Teamleader"};
    primary[] = {"rhs_weap_m4a1_carryhandle_mstock","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","rhsusf_acc_eotech_xps3","rhs_mag_30Rnd_556x45_Mk318_Stanag","rhsusf_acc_rvg_blk"};
    secondary[] = {""};
    launcher[] = {""};
    binoculars[] = {"ACE_Vector"};
    magazines[] = {
        "rhs_mag_30Rnd_556x45_Mk318_Stanag",8,
        "rhs_mag_m67",2,
        "smokeShell",4
         };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EntrenchingTool",1,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1,
        "ACRE_PRC152",1
        };
    compass[] = {"ItemCompass"};
    gps[] = {""};
    map[] = {"ItemMap"};
    nvgs[] = {"rhsusf_ANPVS_14"};
    watch[] = {"itemWatch"};
    insignia[] = {""};
    preLoadout = "[(_this select 0), 'charlie', 0, 0] call cScripts_fnc_setPreInitPlayerSettings;";
    postLoadout = "[(_this select 0),true,true] call cScripts_fnc_setPostInitPlayerSettings;";
};
//LEADERSHIP
class tac2_Leadership : commonBlufor {
    backpack[] = {"B_AssaultPack_mcamo"};
    goggles[] = {""};
    headgear[] = {"rhsusf_ach_helmet_headset_ess_ocp_alt"};
    uniform[] = {"rhs_uniform_acu_oefcp"};
    vest[] = {"rhsusf_iotv_ocp_SquadLeader"};
    primary[] = {"rhs_weap_m4a1_carryhandle_mstock","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","rhsusf_acc_ACOG_RMR","rhs_mag_30Rnd_556x45_Mk318_Stanag","rhsusf_acc_rvg_blk"};
    secondary[] = {""};
    launcher[] = {""};
    binoculars[] = {"ACE_Vector"};
    magazines[] = {
        "rhs_mag_30Rnd_556x45_Mk318_Stanag",8,
        "rhs_mag_m67",2,
        "smokeShell",4,
        "SmokeShellBlue",2,
        "SmokeShellGreen",2
         };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EntrenchingTool",1,
        "ACE_EarPlugs",1,
        "ACE_HuntIR_monitor",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1
        };
    compass[] = {"ItemCompass"};
    gps[] = {""};
    map[] = {"ItemMap"};
    nvgs[] = {"rhsusf_ANPVS_14"};
    watch[] = {"itemWatch"};
    insignia[] = {""};
    preLoadout = "[(_this select 0), 'charlie', 0, 0] call cScripts_fnc_setPreInitPlayerSettings;";
    postLoadout = "[(_this select 0),true,true] call cScripts_fnc_setPostInitPlayerSettings;";
};
//CREWMAN
class tac2_crewman : tac2_base {
    headgear[] = {"rhsusf_cvc_helmet"};
    vest[] = {"rhsusf_spcs_ocp_Crewman"};
    primary[] = {"rhsusf_weap_MP7A2","rhsusf_acc_anpeq15side_bk","rhsusf_acc_mrds","rhs_acc_grip_ffg2"};
    magazines[] = {
        "rhsusf_mag_40Rnd_46x30_AP",2,
        "SmokeShellOrange",4,
        "rhs_mag_m67",2,
        "B_IR_Grenade",2,
        "ACE_IR_STROBE_ITEM",4
    };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1,
        "ACRE_PRC152",2,
        "toolkit",1
    };
    nvgs[] = {""};
};
//HELI PILOT
class tac2_heliPilot : tac2_base {
    headgear[] = {"rhsusf_hgu56p_visor_mask_black"};
    vest[] = {"rhsusf_spcs_ocp_Crewman"};
    primary[] = {"rhsusf_weap_MP7A2","rhsusf_acc_anpeq15side_bk","rhsusf_acc_mrds","rhsusf_spcs_ocp_crewman"};
    magazines[] = {
        "rhsusf_mag_40Rnd_46x30_AP",2,
        "SmokeShellOrange",4,
        "rhs_mag_m67",2,
        "B_IR_Grenade",2,
        "ACE_IR_STROBE_ITEM",4
    };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1,
        "ACRE_PRC152",2,
        "toolkit",1
    };
};
//JET PILOT
class tac2_jetPilot : tac2_base {
    headgear[] = {"H_PilotHelmetFighter_B"};
    uniform[] = {"U_B_PilotCoveralls"};
    vest[] = {""};
    primary[] = {"rhsusf_weap_MP7A2","rhsusf_acc_anpeq15side_bk","rhsusf_acc_mrds"};
    magazines[] = {
        "rhsusf_mag_40Rnd_46x30_AP",2,
        "SmokeShellOrange",4,
        "rhs_mag_m67",2,
        "B_IR_Grenade",2,
        "ACE_IR_STROBE_ITEM",4
    };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EntrenchingTool",1,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1,
        "ACRE_PRC152",2
    };
    nvgs[] = {""};
};

/*-------------------INDIVIDUAL LOADOUTS-------------------*/
//Platoon Leader
class tac2_Platoon_Leader : tac2_Leadership {
    items[] += {
        "ACRE_PRC152",2
     };
};
//Squad Leader
class tac2_Squad_Leader : tac2_Leadership {
    items[] += {
        "ACRE_PRC152",2
     };
};
// Alpha Fireteam Leader
class tac2_AlphaFTL : tac2_Leadership {
    magazines[] +={
        "Chemlight_red",2,
        "ACRE_PRC152",1
    };
};
// Alpha AR
class tac2_alphaAR : tac2_base {
    primary[] = {"rhs_weap_m249_pip","rhsusf_acc_SFMB556","","rhsusf_acc_ACOG_RMR","rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote","rhsusf_acc_saw_bipod"};
    magazines[] = {
        "rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote",4,
        "SmokeShell",2,
        "rhs_mag_m67",1,
        "Chemlight_red",2
    };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1
    };
};
// Alpha Grenadier
class tac2_alphaGren : tac2_base {
    primary[] = {"rhs_weap_m4a1_m320","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","rhsusf_acc_eotech_xps3"};
    magazines[] = {
    "rhs_mag_30Rnd_556x45_Mk318_Stanag",8,
    "rhs_mag_M433_HEDP",10,
    "rhs_mag_M397_HET",4,
    "1Rnd_SmokeRed_Grenade_shell",4,
    "1Rnd_Smoke_Grenade_shell",4,
    "Chemlight_red",2,
    "rhs_mag_m67",1,
    "smokeShell",2
    };
};
// Alpha Rifleman
class tac2_alphaRifle : tac2_base {
    launcher[] = {"rhs_weap_m136"};
    magazines[] += {
        "Chemlight_red",2
    };
};
// bravo Fireteam Leader
class tac2_bravoFTL : tac2_Leadership {
    magazines[] +={
        "Chemlight_red",2,
        "ACRE_PRC152",1
    };
};
// bravo AR
class tac2_bravoAR : tac2_base {
    primary[] = {"rhs_weap_m249_pip","rhsusf_acc_SFMB556","","rhsusf_acc_ACOG_RMR"};
    magazines[] = {
        "rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote",4,
        "SmokeShell",2,
        "rhs_mag_m67",1,
        "smokeShell",2,
        "Chemlight_blue",2
    };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1
    };
};
// bravo Grenadier
class tac2_bravoGren : tac2_base {
    primary[] = {"rhs_weap_m4a1_m320","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","rhsusf_acc_eotech_xps3"};
    magazines[] = {
    "rhs_mag_30Rnd_556x45_Mk318_Stanag",8,
    "rhs_mag_M433_HEDP",10,
    "rhs_mag_M397_HET",4,
    "1Rnd_SmokeRed_Grenade_shell",4,
    "1Rnd_Smoke_Grenade_shell",4,
    "Chemlight_blue",2,
    "rhs_mag_m67",1,
    "smokeShell",2
    };
};
// bravo Rifleman
class tac2_bravoRifle : tac2_base {
    items[] = {
        //standard
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",70,
        "ACE_tourniquet",12,
        "ACE_morphine",8,
        "ACE_epinephrine",8,
        "ACE_Splint",4,
        //radios
        "ACRE_PRC343",1
    };
};
//Mustang
class tac2_Mustang : tac2_base {
    backpack[] = {"B_kitbag_mcamo"};
    primary[] = {"rhs_weap_m4_carryhandle_mstock","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","rhsusf_acc_","rhs_mag_30Rnd_556x45_Mk318_Stanag","rhsusf_acc_rvg_blk"};
    vest[] = {"rhsusf_iotv_ocp_Medic"};
    items[] += {
       "ACE_elasticBandage",60,
       "ACE_morphine",10,
       "ACE_epinephrine",10,
       "ACE_surgicalKit",1,
       "ACE_Splint",4,
       "ACE_tourniquet",8,
       "ACE_salineIV",
       };
    preLoadout = "[(_this select 0), 'medical', 2, 0] call cScripts_fnc_setPreInitPlayerSettings;";
    postLoadout = "[(_this select 0),true,true] call cScripts_fnc_setPostInitPlayerSettings;";
};
//Apollo
class tac2_Apollo : tac2_base {
    backpack[] = {"B_kitbag_mcamo"};
    vest[] = {"rhsusf_iotv_ocp_Repair"};
    items[] += {
        "ACE_Fortify",1,
        "toolkit",1
    };
    preLoadout = "[(_this select 0), 'engineer', 2, 0] call cScripts_fnc_setPreInitPlayerSettings;";
    postLoadout = "[(_this select 0),true,true] call cScripts_fnc_setPostInitPlayerSettings;";
};
//Havoc
class tac2_Havoc : tac2_base {
    backpack[] = {"B_kitbag_mcamo"};
    vest[] = {"rhsusf_iotv_ocp_Repair"};
    items[] += {
        "DemoCharge_Remote_Mag",4,
        "ACE_DefusalKit",1,
        "ACE_clacker",1,
        "ACE_M26_Clacker",1
    };
};
//Longshot
class tac2_longShot : tac2_base {
    headgear[] = {"rhs_Booniehat_ocp"};
    vest[] = {"rhsusf_iotv_ocp_Rifleman"};
    primary[] = {"rhs_weap_XM2010_d","rhsusf_acc_M2010S_d","rhsusf_acc_anpeq15side","rhsusf_acc_LEUPOLDMK4_2_d","rhsusf_5Rnd_300winmag_xm2010","rhsusf_acc_harris_bipod"};
    secondary[] = {"rhsusf_weap_m9","","","",};
    magazines[] = {
        "rhsusf_5Rnd_300winmag_xm2010",30,
        "rhsusf_mag_15Rnd_9x19_FMJ",6,
        "rhs_mag_m67",2,
        "SmokeShell",4
    };
    items[] = {
        //standard items
        "ACE_microDAGR",1,
        "ACE_Maptools",1,
        "ACE_CableTie",2,
        "ACE_EntrenchingTool",1,
        "ACE_EarPlugs",1,
        //standard medical
        "ACE_quikclot",20,
        "ACE_tourniquet",4,
        "ACE_morphine",2,
        "ACE_epinephrine",2,
        "ACE_Splint",2,
        //radios
        "ACRE_PRC343",1,
        "ACRE_PRC152",1,
        //extras
        "ACE_SpottingScope",1,
        "ACE_RangeCard",1,
        "ACE_ATragMX",1,
        "ACE_Kestrel4500",1
    };
};
//Sabre
class tac2_sabre : tac2_crewman {
};
//Banshee
class tac2_banshee : tac2_crewman{
};
//Buffallo
class tac2_buffallo : tac2_heliPilot {
};
//Raider
class tac2_raider : tac2_heliPilot {
};
//Eagle
class tac2_Eagle : tac2_jetPilot {
};
//Zeus
class tac2_Zeus : tac2_Leadership {
    items[] += {
        "ALiVE_Tablet",1
    };
};