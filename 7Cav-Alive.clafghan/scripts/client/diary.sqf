if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiaryRecord ["diary", ["Unit callsigns",
"
<br/><font face=PuristaSemiBold' size='12'>Personnel</font>
<br/>
<font face='EtelkaMonospacePro' size='10'>
<br/>JTAC                           Infidel
<br/>Logistics/FOB Ops              ATLAS-4
<br/>Field Medical                  ATLAS-1/2
<br/>Air traffic control            Telos Tower
<br/></font>
<br/><font face=PuristaSemiBold' size='12'>Transport Aircraft</font>
<br/>
<font face='EtelkaMonospacePro' size='10'>
<br/>UH-60 Blackhawk                Buffalo 1/2
<br/>MH-6 Little Bird               Raven
<br/>CH-47 Chinook                  Grizzly
<br/>V-44X Blackfish (transport)    Titan
</font>
<br/>
<br/><font face=PuristaSemiBold' size='12'>Attack Aircraft</font>
<br/>
<font face='EtelkaMonospacePro' size='10'>
<br/>A-10 Thunderbolt               Hog
<br/>F-16 Fighting Falcon           Eagle
<br/>V-44X Blackfish (armed)        Spectre
<br/>AH-6 Attack Little Bird        Sparrow
<br/>AH-64 Apache                   Raider
</font>
<br/>
<br/>
<br/><font face=PuristaSemiBold' size='12'>Armor</font>
<br/>
<font face='EtelkaMonospacePro' size='10'>
<br/>M1 Abramms                     Sabre 1/2
<br/>Armored personnel carriers     Banshee 1/2/3/4
</font>
<br/>
"
]];

player createDiaryRecord ["diary", ["Radio Channels",
"
<font face='EtelkaMonospacePro' size='10'><br/>01 - Gunslinger Platoon Net</font>
<br/>            Used to communicate between infantry squads in field
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>02 - Aviation</font>
<br/>            Used for air to air communications and CTAF/Air Traffic Control
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>03 thru 09 - Other Platoon Nets</font>
<br/>            Used whenever there is an MCC or multiple platoons, also utilized if a Platoon comes in for a Platoon FTX
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>10 / 11 - IDF-1 and IDF-2</font>
<br/>            Used to conduct indirect fire missions from artillery or mortars
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>12 / 13 - CAS-1 and CAS-2</font>
<br/>            Used to call in fixed-wing or attack rotary close air support
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>14 - Ground-To-Air</font>
<br/>            Used to conduct pick-up requests from logistical aviation units 
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>15 - Logistics</font>
<br/>            Used by ATLAS personnel to dispatch where needed. 
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>16 - FARP Requests</font>
<br/>            Used to communicate with ATLAS personnel when you are inbound to a FARP as to what you need using the FARM acronym. FOXTROT - FUEL (state current fuel state if requesting FOXTROT) / ALPHA - AMMUNITION / ROMEO - REPAIRS / MIKE - MEDICAL (use triage category for multiple casualties) 
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>17 - Convoy</font>
<br/>            Used when conducting a convoy 
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>18 - Zeus</font>
<br/>            Used to communicate with a Zeus if required 
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>19 - CAG</font>
<br/>            Classified 
<br/>
<font face='EtelkaMonospacePro' size='10'><br/>20 - Command</font>
<br/>            Used to coordinate across different platoons or other big picture items 
<br/>
"
]];

if (not (player diarySubjectExists "teamspeak")) then { player createDiarySubject ["teamspeak", "Teamspeak"] };

player createDiaryRecord ["teamspeak", ["Teamspeak server",
"
<br/>Address: ts3.7cav.us
<br/>Password: 7thCavalry
<br/>
<br/>The password is case-sensitive. The first time you connect to the Teamspeak server you must wait for your security level to reach 30 before
you will be able to enter any Teamspeak channels.
<br/>
<br/>Visitors and guests are welcome.
"
]];

player createDiaryRecord ["diary", ["Rules of conduct",
"
<br/>1. No fratricide.
<br/>2. No destruction of friendly equipment.
<br/>3. Players using character slots labelled TEAMSPEAK must be on Teamspeak
<br/>4. Combat Air Patrol and Combat Support must abide by specific rules of engagement
<br/>5. Weapons safe on base
<br/>6. No offensive language, sexual references, drug references, or racism of any kind will be tolerated
<br/>7. No vehicles allowed on runways or landing pads unless it is a support vehicle being used for that purpose
<br/>
<br/>If you see a player in violation of any of the above, contact a moderator or administrator (TeamSpeak).  For more information on these rules, see the billboards at base.
"
]];


player createDiaryRecord ["diary", ["FOB Building",
"
<br/><font face='EtelkaMonospacePro' size='10'>Overview</font>
<br/>Building a FOB involves several modules, which all work together to allow players to build complex and useful FOBs around the map.
<br/><br/>
<br/><font face='EtelkaMonospacePro' size='10'>Fortify Truck</font>
<br/>The basic FOB tool is the Fortify Truck, which is an empty flatbed utility vehicle that permits players to place down fortifications using the fortify tool in a radius around it.
In order to place down fortify objects, you must have a fortify tool (looks like a hammer) and be near the Fortify Truck. Proximity to this truck is required for other modules to be activated.
<br/><br/>
<br/><font face='EtelkaMonospacePro' size='10'>Ammo Module</font>
<br/>The Ammo Module, a Huron Rearm Pod, allows ATLAS-4 to purchase ammunication crates, similar to the ammo crate spawner at base.
<br/><br/>
<br/><font face='EtelkaMonospacePro' size='10'>Vehicle Module</font>
<br/>The Vehicle Module, a Huron Repair Pod, allows ATLAS-4 to purchase limited vehicles for players spawning at the FOB.
<br/><br/>
<br/><font face='EtelkaMonospacePro' size='10'>Personnel Module</font>
<br/>The Personnel Module, a Huron Medical Pod, allows ATLAS-4 to enable a mobile spawn, provided enemies are not within 500m of the module. If enemies approach the module, it will disable
and will require manual intervation to renable. Each teleport consumes points, and may be disabled by ATLAS-4 if they are low on supplies.
<br/><br/>
<br/><font face='EtelkaMonospacePro' size='10'>Supply Module and Points</font>
<br/>The Supply Module, when activated, adds points to the supply budget. The supply budget is shared by all modules, as well as the fortify items.
<br/><br/>
<br/><font face='EtelkaMonospacePro' size='10'>Transporting Modules</font>
<br/>Each crate module can be loaded onto flatbed vehicles, sling loaded by a helicopter, or loaded into certain transport fixed-wing aircraft. They cannot be loaded in the Blackfish.
"
]];


//Add a new thing called How-To-ALiVE
player createDiarySubject ["ALiVE","How-To-ALiVE"];

//Alive How-To
player createDiaryRecord ["ALiVE", ["Introduction to ALiVE",
"<font face=PuristaSemiBold' color='#ffc61a' size='26'>This Server is Using ALiVE!</t>
<br/><br/><font face=PuristaSemiBold' color='#ffffff' size='20'>HELP US IMPROVE!!</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>If you would like a new feature to be added, or if you would like to report an issue with our missions, please use this link: https://bit.ly/2HOWGUJ</t>
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--How ALiVE Spawns Units--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>ALiVE creates groups in 'Virtual Space'. These units are not spawned in until you are within
1 Kilometer. When you are within 1 Kilometer of a profiled unit ALiVE will spawn that profiled unit onto the map.
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--What Happens When A Unit/Group Is Spawned In--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>When units are spawned onto the map, VCOM AI takes over AI calculations. VCOM AI allows for units inside AI groups to communicate with eachother. Nearby groups can 
communicate with eachother as well. So when ALiVE spawns a group, they might begin
moving toward your direction. This isn't because they know where you are, it's because
they were told about your position by another enemy AI group. Moreover, VCOM AI can steal
vehicles and deploy crew served weapons. 
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--Grid Squares and Enemy Activity--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>ALiVe will color individual grid squares. The darker the color, the more enemies are in that
area. Simply put, these squares indicate areas of enemy activity. Whenever a group
moves to another grid square, that grid square will also light up red.
<br/>
<br/>When BLUFOR move into a red grid square, the grid square will turn blue. When there are no OPFOR AI in that grid same grid square, it will
turn green. If there are more OPFOR in that grid square than BLUFOR, it will turn
purple. If there are more BLUFOR than OPFOR, it will turn a lighter shade of purple.</t>
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--Persistence--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>ALiVE has the possibility of maintaining persistence between server restarts. By default, the
missions in standard rotation are not persistent. However, COIN and warfare wednesday
variants of missions are persistent. This means that, if you take a town and setup a
forward base, when the mission restarts, that town will remain cleared and the base 
that was setup will remain there.</t>
<br/>
<br/>
"
]];
//Mission Objectives
player createDiaryRecord ["ALiVE", ["Mission Objectives",
"<font face=PuristaSemiBold' color='#ffc61a' size='26'>This Server is Using ALiVE!</t>
<br/><br/><font face=PuristaSemiBold' color='#ffffff' size='20'>HELP US IMPROVE!!</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>If you would like a new feature to be added, or if you would like to report an issue with our missions, please use this link: https://bit.ly/2HOWGUJ</t>
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--Basic Mission Objectives--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>1. Move to and clear enemy held towns and military compounds.
<br/>2. Secure and hold enemy towns and military compounds.
<br/>3. Deactivate enemy strongpoints.
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--Where should I attack?--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>ALiVE puts enemies everywhere on the map, they're just not spawned in immediately.
when the mission is first loaded. When you move towards a given area, enemies will begin spawning in. This essentially means that,
no matter where you go, there will be enemies to fight. The main goal of the mission is to take over the entire island by means of force. In COIN or Warfare Wednesday missions, the mission critera changes. Make sure to speak with leadership whenever you log onto the server, as Warfare Wednesday might be taking placeor a COIN mission might be loaded.
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--Counter Insurgency (COIN)--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>Simply put, counter insurgency mission files are setup in such a way, as to allow a very realistic and engaging asymetrical/unconventional warfare environment. You can expect to encounter Improvised Explosive Devices (IEDs), Vehicle Bourne Explosive Devices (VBEDs), and hostile civilains. Many times, civilains may wish to take up arms against your faction. One minute a civilian might be friendly. Ten minutes later, when he comes out of his shack, he could be wearing a suicide vest or weild an AK.
<br/>
<br/>As you might tell from reading this, Civilian interaction is incredibly important to COIN. As such, these missions are only available when a ZEUS or ADMIN is online, so he/she can switch the map to these game-modes. These game-modes are also persistant, which means that, between server restarts, you won't lose progress on the mission. This allows you to setup FOBs, take towns, etc, without losing progress between play sessions. Think of it as CO-OP multiplayer, but without any of the hassle."
]];
//Apollo and FOBs
player createDiaryRecord ["ALiVE", ["Logistics",
"<font face=PuristaSemiBold' color='#ffc61a' size='26'>This Server is Using ALiVE!</t>
<br/><br/><font face=PuristaSemiBold' color='#ffffff' size='20'>HELP US IMPROVE!!</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>If you would like a new feature to be added, or if you would like to report an issue with our missions, please use this link: https://bit.ly/2HOWGUJ</t>
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--The Role of Logistical Support--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>ATLAS-4 is the callsign we use for the server's logistical support assets. ATLAS-4 is in charge of creating Forward Operating Bases, Combat Outposts, and Forward Rearm and Repair Points. This is more important now than ever before, because fights can last hours. Without resupply or a fallback point, squads and vehicles who are in combat run the risk of running out of ammunition or fuel. Perhaps more important, vehicles such as Saber and Buffallo may need repairs, but might not be able to make it all the way back to base. Having a forward rearm point enables the possibility of long, sustained combat actions.
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--FOBs and Persistance--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>In standard rotation missions, persistance isn't enabled by default. This means that, between server restarts, FOBs and progress will not be maintained. On other map variants, such as COIN or Warfare Wednesday, persistance is enabled. This means that, if you build a FOB during Warfare Wednesday, that FOb will remain there after the next server restart. This is the same for COIN operations as well.
"
]];
//View Distance
player createDiaryRecord ["ALiVE", ["View Distance Settings",
"<font face=PuristaSemiBold' color='#ffc61a' size='26'>This Server is Using ALiVE!</t>
<br/><br/><font face=PuristaSemiBold' color='#ffffff' size='20'>HELP US IMPROVE!!</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>If you would like a new feature to be added, or if you would like to report an issue with our missions, please use this link: https://bit.ly/2HOWGUJ</t>
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--ACE View Distance Limiter--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>Escape -> Configure -> Addon Options -> Ace View Distasnce Limiter
<br/>
<br/>The settings are pretty self explanatory with the exception of Dynamic Object View
Distance. When set to between 'Low' to 'Very High', this represents the percentage
(between 0-100) of your view distance that objects will be rendered. 'FOV Based'
means that, when you scope in, the object view distance will increase.
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--ALiVE Player Options--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>App Menu Button -> Player Options -> View Settings -> View Settings / Terrain Grid
<br/>
<br/>The 'App Menu Button' is the button between the R.CTRL and R.Win button. Using this
method immmediately overrides ACE View Distance Limiter, but is set on a per-respawn or
per-mission basis. This means that it resets every time you log into the server and every
time the mission file changes.
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--How To Rebind ALiVE Options Menu--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>Configure -> Controls -> Configure Addons -> Open Menu (Requires Restart)
<br/>
<br/>The 'App Menu Button' is the button between the R.CTRL and R.Win button. I reccomend changing to something like CTRL + Home or something weird that you'll never use.
"
]];
//ZEUS
player createDiaryRecord ["ALiVE", ["How to Zeus with ALiVE",
"<font face=PuristaSemiBold' color='#ffc61a' size='26'>This Server is Using ALiVE!</t>
<br/><br/><font face=PuristaSemiBold' color='#ffffff' size='20'>HELP US IMPROVE!!</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>If you would like a new feature to be added, or if you would like to report an issue with our missions, please use this link: https://bit.ly/2HOWGUJ</t>
<br/>
<br/><font face=PuristaSemiBold' color='#ffffff' size='16'>#--Working With Profiled Units--#</t>
<br/><font face='PuristaMedium' color='#ffffff' size='13'>Units that are spawned by ALiVE are most always profiled. The only exception to this 
are the CQB AI which are procedurally generated. To delete units from an area, for example
if you wanted to run an MCC, you can simply press 'END' on your keyboard. This will Kill
the unit. When the unit is killed, you can either delete the unit like you normally would
or you can move the dead unit to a corner of the map where ALiVE will automatically
despawn it on its own.
"
]];