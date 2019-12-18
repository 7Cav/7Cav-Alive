private _rotateYawPitchRoll =
{
	params ["_object", "_yaw", "_pitch", "_roll"];
	_object setVectorDirAndUp [ [ sin _yaw * cos _pitch,cos _yaw * cos _pitch,sin _pitch], [ [ sin _roll,-sin _pitch,cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D ];
};

private _icons =
[
	["Weapon", "\a3\ui_f\data\IGUI\cfg\Actions\Obsolete\ui_action_gear_ca.paa"],
	["Cargo1", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no1_ca.paa"],
	["Cargo2", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no2_ca.paa"],
	["Cargo3", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no3_ca.paa"],
	["Cargo4", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no4_ca.paa"],
	["Cargo5", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no4_ca.paa"],
	["Cargo6", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no4_ca.paa"],
	["Cargo7", "\a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no4_ca.paa"],
	["Number1", "\a3\air_f\data\1_ca.paa"],
	["Number2", "\a3\air_f\data\2_ca.paa"],
	["Number3", "\a3\air_f\data\3_ca.paa"],
	["Number4", "\a3\air_f\data\4_ca.paa"],
	["Parachute", "\a3\ui_f\data\Map\VehicleIcons\iconParachute_ca.paa"],
	["LetterA", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\a_ca.paa"],
	["LetterB", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\b_ca.paa"],
	["LetterC", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\c_ca.paa"],
	["LetterD", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\d_ca.paa"],
	["LetterE", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\e_ca.paa"],
	["LetterF", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\f_ca.paa"],
	["LetterG", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\g_ca.paa"],
	["LetterH", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\h_ca.paa"],
	["LetterI", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\i_ca.paa"],
	["LetterJ", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\j_ca.paa"],
	["LetterK", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\k_ca.paa"],
	["LetterL", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\l_ca.paa"],
	["LetterM", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\m_ca.paa"],
	["LetterN", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\n_ca.paa"],
	["LetterO", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\o_ca.paa"],
	["LetterP", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\p_ca.paa"],
	["LetterQ", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\q_ca.paa"],
	["LetterR", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\r_ca.paa"],
	["LetterS", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\s_ca.paa"],
	["LetterT", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\t_ca.paa"],
	["LetterU", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\u_ca.paa"],
	["LetterV", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\v_ca.paa"],
	["LetterW", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\w_ca.paa"],
	["LetterX", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\x_ca.paa"],
	["LetterY", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\y_ca.paa"],
	["LetterZ", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\z_ca.paa"],
	["Talk1", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\talk1_ca.paa"]
];

// Numbers: \a3\air_f\data\anim\1_ca.paa, \a3\structures_f\mil\cargo\data\Cargo_Tower_v1_no1_ca.paa


private _decalMarkers = allMapMarkers select { _x find "DECAL_" == 0 };

private _position = [];
private _direction = 0;
private _type = "";
private _decal = objNull;

// A decal marker is named DECAL_identifier_name_size
//
// identifier is used to allow unique names and is otherwise ignored
// name is either the name of the texture in "_icons" above or the texture path itself.  Note that textures with underscores need to be in the "_icons" table.
// size is either 1 or 10, indicating the size of the texture object to be used.  The size can be unspecified, which defaults to 1

SERVER_Decals = [];

{
	(_x splitString "_") params ["_prefix", "_identifier", "_name", ["_size", "1", [""]]];

	_position = markerPos _x;
	_direction = markerDir _x;

	_type = format ["UserTexture%1m_F", _size];

	_decal = createVehicle [_type, _position, [], 0, "can_collide"];
	_decal allowDamage false;
	[_decal, _direction, -90, 0] call _rotateYawPitchRoll;

	_index = _icons findIf { _x select 0 == _name };
	if (_index >= 0) then { _name = _icons select _index select 1 };

	_decal setObjectTextureGlobal [0, _name];

	SERVER_Decals pushBack [_position, _direction, parseNumber _size, _name];
} forEach _decalMarkers;

[[SERVER_Decals], { CLIENT_Decals = (_this select 0) }] remoteExec ["call", 0, true];