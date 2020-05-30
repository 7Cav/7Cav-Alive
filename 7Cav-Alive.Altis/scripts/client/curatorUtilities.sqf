/*
Copyright (c) 2017-2019, John Buehler

Permission is hereby granted, free of charge, to any person obtaining a copy of this software (the "Software"), to deal in the Software, including the rights to use, copy, modify, merge, publish and/or distribute copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

CuratorUtilities_LightOn = false;
CuratorUtilities_LightLight = objNull;

CuratorUtilities_Light =
{
	if (isNull CuratorUtilities_LightLight) then {
		CuratorUtilities_LightLight = "#lightpoint" createvehiclelocal [0,0,0];
		CuratorUtilities_LightLight setLightDayLight true;
		CuratorUtilities_LightLight setLightBrightness 0;
		CuratorUtilities_LightLight setLightAmbient [0.0, 0.0, 0.0];
		CuratorUtilities_LightLight setLightColor [1.0, 1.0, 1.0];
		CuratorUtilities_LightLight setLightAttenuation [5000, 2, 1, 1];

		addMissionEventHandler ["EachFrame",
			{
				private _cameraPosition = getPos curatorCamera;

				if (CuratorUtilities_LightOn && (_cameraPosition select 0) != 0) then
				{
					_cameraPosition set [2, 400];

					CuratorUtilities_LightLight setLightBrightness 0.6;
					CuratorUtilities_LightLight setPos _cameraPosition;
				}
				else
				{
					CuratorUtilities_LightLight setLightBrightness 0;
				};
			}];
	};

	CuratorUtilities_LightOn = not CuratorUtilities_LightOn;
};

private _lightAction = ["zeusNightLight", "Toggle Zeus Light", '', { call CuratorUtilities_Light }, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _lightAction] call ace_interact_menu_fnc_addActionToZeus;