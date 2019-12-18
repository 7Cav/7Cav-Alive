#define CBA_SETTINGS_CAT "Simple Splint"

// Who can splint?
[
  "simple_splint_medic_requirement",
  "LIST",
  ["Skill level", "What level of medical training is required to apply. ACE facility/vehicle boost will affect this, if it is enabled."],
  CBA_SETTINGS_CAT,
  [[0, 1, 2], ["Anybody", "Medic", "Doctor"], 0],
  true
] call cba_settings_fnc_init;

// Require patient to be stable?
[
	"simple_splint_require_stable"
	,"CHECKBOX"
	,["Require patient to be stable", "Whether or not the patient needs to be stable (all blue)."]
	,CBA_SETTINGS_CAT
	,[true]
	,true
] call CBA_Settings_fnc_init;

// Is an item required?
[
	"simple_splint_require_item"
	,"CHECKBOX"
	,["Require item in inventory", "Whether or not an item is required in either the medic, or the patient's inventory."]
	,CBA_SETTINGS_CAT
	,[true]
	,true
] call CBA_Settings_fnc_init;

// What item is required?
[
  "simple_splint_require_item_class",
  "LIST",
  ["Item required", "What item is required, if the above checkbox is true."],
  CBA_SETTINGS_CAT,
  [["ACE_surgicalKit", "ACE_personalAidKit"], ["ACE Surgical Kit", "ACE PAK"], 1],
  true
] call cba_settings_fnc_init;


// Is an item consumed?
[
	"simple_splint_consume_item"
	,"CHECKBOX"
	,["Consume item after splint", "Whether or not an item is consumed after splinting."]
	,CBA_SETTINGS_CAT
	,[true]
	,true
] call CBA_Settings_fnc_init;

// What item is consumed?
[
  "simple_splint_consume_item_class",
  "LIST",
  ["Item consumed", "What item is consumed, if the above checkbox is true."],
  CBA_SETTINGS_CAT,
  [["ACE_surgicalKit", "ACE_personalAidKit"], ["ACE Surgical Kit", "ACE PAK"], 1],
  true
] call cba_settings_fnc_init;

// Splint time
[
	"simple_splint_time"
	,"SLIDER"
	,"Splint time (seconds)"
	,CBA_SETTINGS_CAT
	,[0,60,20,0]
	,true
] call CBA_Settings_fnc_init;


nil
