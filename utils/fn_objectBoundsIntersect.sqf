/*
	objectBoundsIntersect determines if the bounds of two world objects intersect.  This is accomplished by
	sampling the surface of the smaller object at regular intervals and determining if any of those samples lie inside
	the limits of the other object's bounding box.  Best performance is for objects that are nowhere near each other.
	Next best is objects that intersect.  Worst is objects that are near but which do not intersect.

	The precision value determines how widely spaced the samples are on the smaller object, which are checked against
	the bounds of the other object.  The default precision is 3 meters, and the dimensions of the bounding box do
	not have to evenly divide by the precision value.  For example, if a bounding box is 2x2x6 meters and a precision
	value of 10 is supplied, the box's corners will be sampled.

	Returns true if the object bounds intersect
*/

params ["_object1", "_object2", ["_precision", 1, [0]]];

private _box1 = boundingBoxReal _object1;
private _box2 = boundingBoxReal _object2;

private _smallestDimension =
{
	params ["_box"];
	private _dimensions = [0, 1, 2] apply { (_box select 1 select _x) - (_box select 1 select _x) };
	(_dimensions select 0) min (_dimensions select 1) min (_dimensions select 2)
};

if (([_box2] call _smallestDimension) < ([_box1] call _smallestDimension)) then
{
	private _temp = 0;

	_temp = _object1;
	_object1 = _object2;
	_object2 = _temp;

	_box1 = boundingBoxReal _object1;
	_box2 = boundingBoxReal _object2;
};

private _min1 = _box1 select 0;
private _max1 = _box1 select 1;

private _min2 = _box2 select 0;
private _max2 = _box2 select 1;

private _size1 = (vectorMagnitude _min1) max (vectorMagnitude _max1);
private _size2 = (vectorMagnitude _min2) max (vectorMagnitude _max2);

if (_object1 distance _object2 > _size1 + _size2) exitWith { false };

private _dimensions = [0, 1, 2] apply { (_max1 select _x) - (_min1 select _x) };
private _stepSizes = _dimensions apply { _x / (round (_x / _precision) max 1) };
private _steps = [0, 1, 2] apply { round ((_dimensions select _x) / (_stepSizes select _x)) };

private _positions = [];

private _xLimits = [0, _steps select 0];
private _yLimits = [0, _steps select 1];
private _zLimits = [0, _steps select 2];
private _xAtLimit = 0;
private _yAtLimit = 0;
private _zAtLimit = 0;
private _xPos = [];
private _yPos = [];
private _zPos = [];

for "_xIndex" from 0 to (_steps select 0) do
{
	_xAtLimit = _xIndex in _xLimits;

	for "_yIndex" from 0 to (_steps select 1) do
	{
		_yAtLimit = _yIndex in _yLimits;

		for "_zIndex" from 0 to (_steps select 2) do
		{
			_zAtLimit = _zIndex in _zLimits;

			if (_xAtLimit || _yAtLimit || _zAtLimit) then
			{
				_xPos = (_min1 select 0) + (_stepSizes select 0) * _xIndex;
				_yPos = (_min1 select 1) + (_stepSizes select 1) * _yIndex;
				_zPos = (_min1 select 2) + (_stepSizes select 2) * _zIndex;
				_positions pushBack (_object1 modelToWorld [_xPos, _yPos, _zPos]);
			};
		};
	};
};


private _index = _positions findIf
{
	_position = _object2 worldToModel _x;
	({ _position select _x >= _min2 select _x && { _position select _x <= _max2 select _x } } count [0, 1, 2]) == 3;
};

_index >= 0