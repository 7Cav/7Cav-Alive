/*
	Author: JB
*/
_this spawn
{
	params ["_message", "_duration", ["_structuredText", false, [true]]];

	titleText [_message, "black out", 0.1, true, _structuredText];

	switch (typeName _duration) do
	{
		case typeName 0: { sleep (0.1 + _duration) };

		case typeName []: // [wait-code, parameters]
		{
			waitUntil { sleep 0.1; (_duration select 1) call (_duration select 0) };
		};
	};
	
	titleText [_message, "black in", 0.5, true, _structuredText];
};

true