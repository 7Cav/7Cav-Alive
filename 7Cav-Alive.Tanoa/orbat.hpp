class CfgOrbat 
{
    class Regi
	{
        id = 7;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Regiment"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "HQ"; // Unit type from CfgChainOfCommand >> Types
        commander = "Chance"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "General"; // Rank of unit commander (by default selected based on unit size)
        text = "7th Cavalry %3"; // Custom text and short text, can still use some arguments when defined:
        textShort = "7Cav";
        description= "7th Cavalry Airbase.";
        assets[] = {};
		subordinates[] ={1stBat,2ndBat};
     };
	 class 1stBat
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Battalion"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "HQ"; // Unit type from CfgChainOfCommand >> Types
        commander = "Tharen"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Major"; // Rank of unit commander (by default selected based on unit size)
        text = "1st Battalion"; // Custom text and short text, can still use some arguments when defined:
        textShort = "1-Bat";
        description= "1st Battalion contains all the formations used in ArmA 3.";
        assets[] = {};
		subordinates[] ={ACo,BCo,CCo};
     };
	 class ACo
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Company"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "HQ"; // Unit type from CfgChainOfCommand >> Types
        commander = "Robbi"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Captain"; // Rank of unit commander (by default selected based on unit size)
        text = "Alpha Company"; // Custom text and short text, can still use some arguments when defined:
        textShort = "A-Co";
        description= "Alpha Company specializes in air transport and combat.";
        assets[] = {};
		subordinates[] ={1Pl,2Pl};
     };
	 class 1Pl
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "CombatAviation"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "1st Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "1-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={1Sq3,2Sq3,3Sq3,4Sq3};
     };
	 class 1Sq3
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "CombatAviation"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Buffalo"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Buffalo";
        description= "SIGNALS:<br/><br/>UH-60M 'Blackhawk'<br/>Buffalo-1: B:8 C:1 / 02<br/>Buffalo-2: B:8 C:2 / 02<br/>Buffalo-3: B:8 C:3 / 02<br/>Buffalo-4: B:8 C:4 / 02";
        assets[] = {RHS_UH60M_d};
		subordinates[] ={};
	 };
	 class 2Sq3
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "CombatAviation"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Grizzly"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Grizzly";
        description= "SIGNALS:<br/><br/>CH-47F 'Chinook'<br/>Grizzly-1: B8 C:5 / 02<br/>Grizzly-2: B8 C:6 / 02<br/>Grizzly-3: B8 C:7 / 02";
        assets[] = {RHS_CH_47F_10};
		subordinates[] ={};
	 };
	 class 3Sq3
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "CombatAviation"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Raven"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Raven";
        description= "SIGNALS:<br/><br/>AH-6/MH-6 'Littlebird'<br/>Raven-1: B:8 C:8 / 02<br/>Raven-2: B:8 C:9 / 02<br/>Raven-3: B:8 C:10 / 02<br/>Raven-4: B:8 C:11 / 02";
        assets[] = {RHS_MELB_AH6M,RHS_MELB_MH6M};
		subordinates[] ={};
	 };
	 class 4Sq3
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "CombatAviation"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Raider"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Raider";
        description= "SIGNALS:<br/><br/>AH-64D 'Apache'<br/>Raider-1 B:8 C:12 / 02<br/>Raider-2 B:8 C:13 / 02";
        assets[] = {RHS_AH64D};
		subordinates[] ={};
	 };
	 class 2Pl
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Fighter"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "2nd Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "2-Platoon";
        description= "";
        assets[] = {USAF_F35A_STEALTH,USAF_F22,USAF_A10};
		subordinates[] ={1Sq4,2Sq4,3Sq4};
     };
	 class 1Sq4
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Fighter"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Titan"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Titan";
        description= "SIGNALS:<br/><br/>C-130J 'Hercules'<br/>Titan-1 B:9 C:1 / 02<br/>Titan-2 B:9 C:2 / 02<br/>Titan-3 B:9 C:3 / 02<br/>Titan-4 B:9 C:4 / 02";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 2Sq4
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Fighter"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Eagle"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Eagle";
        description= "SIGNALS:<br/><br/>F-35A 'Lightning II'<br/>Eagle-1 N/A / 02<br/>Eagle-2 N/A / 02<br/>Eagle-3 N/A / 02<br/>Eagle-4 N/A / 02";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 3Sq4
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Fighter"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Hog"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Hog";
        description= "SIGNALS:<br/><br/>A-10C 'Thunderbolt II'<br/>Hog-1 N/A / 02<br/>Hog-2 N/A / 02<br/>Hog-3 N/A / 02";
        assets[] = {};
		subordinates[] ={};
	 };
	 class BCo
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Company"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "HQ"; // Unit type from CfgChainOfCommand >> Types
        commander = "LaCombe"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Captain"; // Rank of unit commander (by default selected based on unit size)
        text = "Bravo Troop"; // Custom text and short text, can still use some arguments when defined:
        textShort = "B-Co";
        description= "Bravo Troop contains the Battalion's Armour platoon, Mechanized Infantry, alongside Medical and Logistics.";
        assets[] = {};
		subordinates[] = {1Pl1,2Pl1,3Pl1};
     };
	 class 1Pl1
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Armored"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "1st Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "1-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={1Sq5};
	 };
	 class 1Sq5
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Section"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Armored"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Sabre"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Sabre";
        description= "SIGNALS:<br/><br/>M1-A2 'Abrams'<br/>Sabre-1 B:7 C:1 / 06 (20)<br/>Sabre-2 B:7 C:2 / 06<br/>Sabre-3 B:7 C:3 / 06<br/>Sabre-4 B:7 C:4 / 06 (20)";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 2Pl1
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "MechanizedInfantry"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "2nd Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "2-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={1Sq2,2Sq2,3Sq2};
	 };
	 class 1Sq2
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Recon"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Viking"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Viking";
        description= "SIGNALS:<br/><br/>Cavalry Scouts<br/>Viking-1 B:5 C:1 / 03 (20)<br/>Viking-2 B:5 C:2 / 03<br/>Viking-3 B:5 C:3 / 03<br/>Viking-4 B:5 C:4 / 03 (20)<br/>Viking-7 B:5 C:1 / 03 (15)";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 2Sq2
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Section"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Infantry"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Lancer"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Lancer";
        description= "SIGNALS:<br/><br/>Mechanized or Motorized Infantry<br/>Lancer-6 B:5 C:5 / 04 (20)<br/>Lancer-5 B:6 C:5 / 04 (20)<br/>Lancer-7 B:6 C:5 / 04 (15)<br/>Lancer-1 B:6 C:1 / 04<br/>Lancer-2 B:6 C:2 / 04<br/>Lancer-3 B:6 C:3 / 04<br/>Lancer-4 B:6 C:4 / 04";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 3Sq2
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Section"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Armored"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Banshee"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Banshee";
        description= "SIGNALS:<br/><br/>Infantry Fighting Vehicle 'IFV'<br/>Banshee-1 B:5 C:6 / 05<br/>Lancer-2 B:5 C:6 / 05<br/>Lancer-3 B:5 C:7 / 05<br/>Lancer-4 B:5 C:7 / 05";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 3Pl1
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Support"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "3rd Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "3-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={1Sq,2Sq};
	 };
	 class 1Sq
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Squad"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Medical"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Mustang"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Mustang";
        description= "SIGNALS:<br/><br/>Mobile Medical Team<br/>Mustang-1 B:1 C:2 / 15<br/>Mustang-2 B:1 C:3 / 15";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 2Sq
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Section"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Maintenance"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Sergeant"; // Rank of unit commander (by default selected based on unit size)
        text = "Apollo"; // Custom text and short text, can still use some arguments when defined:
        textShort = "Apollo";
        description= "SIGNALS:<br/><br/>Mechanized or Motorized Infantry<br/>Lancer-6 B:5 C:5 / 04 (20)<br/>Lancer-5 B:6 C:5 / 04 (20)<br/>Lancer-7 B:6 C:5 / 04 (15)<br/>Lancer-1 B:6 C:1 / 04<br/>Lancer-2 B:6 C:2 / 04<br/>Lancer-3 B:6 C:3 / 04<br/>Lancer-4 B:6 C:4 / 04";
        assets[] = {};
		subordinates[] ={};
	 };
	 class CCo
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Company"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "HQ"; // Unit type from CfgChainOfCommand >> Types
        commander = "Rosefield"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Major"; // Rank of unit commander (by default selected based on unit size)
        text = "Charlie Company"; // Custom text and short text, can still use some arguments when defined:
        textShort = "C-Co";
        description= "Charlie Company comprises of light infantry specializing in air assault, airborne operations, and heavy weapons.";
        assets[] = {};
		subordinates[] ={1Pl2,2Pl2,3Pl2};
     };
	 class 1Pl2
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Airborne"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "1st Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "1-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 2Pl2
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Infantry"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "2nd Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "2-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={};
	 };
	 class 3Pl2
	{
        id = 1;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Platoon"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "Mortar"; // Unit type from CfgChainOfCommand >> Types
        commander = ""; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Lieutenant"; // Rank of unit commander (by default selected based on unit size)
        text = "3rd Platoon"; // Custom text and short text, can still use some arguments when defined:
        textShort = "3-Platoon";
        description= "";
        assets[] = {};
		subordinates[] ={};
	 };
     class 2ndBat
	{
        id = 2;       // Unit ID
        idType = 0;    // Unit ID type
        side = "West"; // Unit side from CfgChainOfCommand >> Sides
        size = "Battalion"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
        type = "HQ"; // Unit type from CfgChainOfCommand >> Types
        commander = "Parsons"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
        commanderRank = "Major"; // Rank of unit commander (by default selected based on unit size)
        text = "2nd Battalion"; // Custom text and short text, can still use some arguments when defined:
        textShort = "2-Bat";
        description= "2nd Battalion contains formations specializing in games other than ArmA 3.";
	};
/*                      RUSSIANS                    */    
	class air
	{
		id = 1;        // Unit ID
		idType = 3;    // Unit ID type
		side = "East"; // Unit side from CfgChainOfCommand >> Sides
		size = "Battalion"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
		type = "Fighter"; // Unit type from CfgChainOfCommand >> Types
		commander = "Visili"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
		commanderRank = "Colonol"; // Rank of unit commander (by default selected based on unit size)
		tags[] = {OPF_air}; // Group tags. When opening ORBAT viewer, user can define what tags will be accepted.
		text = "Russian Air Commander"; // Custom text and short text, can still use some arguments when defined:
		textShort = "Russian %4 %3";
		description= "Armed forces of the Russian Federation"; // A brief description of the group or unit.
		assets[] = {};
    };
	class armor
	{
		id = 1;        // Unit ID
		idType = 3;    // Unit ID type
		side = "East"; // Unit side from CfgChainOfCommand >> Sides
		size = "Battalion"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
		type = "Armored"; // Unit type from CfgChainOfCommand >> Types
		commander = "Ivanov"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
		commanderRank = "Colonol"; // Rank of unit commander (by default selected based on unit size)
		tags[] = {OPF_armor}; // Group tags. When opening ORBAT viewer, user can define what tags will be accepted.
		text = "ARmored Corps Commander"; // Custom text and short text, can still use some arguments when defined:
		textShort = "Russian %4 %3 ";
		description= "Armed forces of the Russian Federation"; // A brief description of the group or unit.
		assets[] = {};
    };
	class mech
	{
		id = 1;        // Unit ID
		idType = 3;    // Unit ID type
		side = "East"; // Unit side from CfgChainOfCommand >> Sides
		size = "Battalion"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
		type = "Cavalry"; // Unit type from CfgChainOfCommand >> Types
		commander = "Alexei"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
		commanderRank = "Colonol"; // Rank of unit commander (by default selected based on unit size)
		tags[] = {OPF_mech}; // Group tags. When opening ORBAT viewer, user can define what tags will be accepted.
		text = "Mechanized Infantry Commander"; // Custom text and short text, can still use some arguments when defined:
		textShort = "Russian %4 %3 ";
		description= "Armed forces of the Russian Federation"; // A brief description of the group or unit.
		assets[] = {};
    };
	class specop
	{
		id = 1;        // Unit ID
		idType = 3;    // Unit ID type
		side = "East"; // Unit side from CfgChainOfCommand >> Sides
		size = "Battalion"; // Unit size from CfgChainOfCommand >> Sizes. Displays relevant icon above the Type icon
		type = "Recon"; // Unit type from CfgChainOfCommand >> Types
		commander = "Anatolii"; // Name of unit commander. Can be either direct name, or class from CfgWorlds >> GenericNames (random name from the list is then selected)
		commanderRank = "Colonol"; // Rank of unit commander (by default selected based on unit size)
		tags[] = {OPF_specop}; // Group tags. When opening ORBAT viewer, user can define what tags will be accepted.
		text = "Special Potato Farmers"; // Custom text and short text, can still use some arguments when defined:
		textShort = "Russian %4 %3 ";
		description= "Russian Potato Farmers Turned Special Forces!"; // A brief description of the group or unit.
		assets[] = {};
    };
};