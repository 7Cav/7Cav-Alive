private _hookCargo =
{
	if ([vehicle player] call ASL_Can_Operate_Flight_Controls) then
	{
		switch (true) do
		{
			case ([vehicle player, player] call JBTPI_AttachPodCondition): { [vehicle player, player] call JBTPI_AttachPod; };

			case ([] call ASL_Deploy_Ropes_Action_Check): { [] call ASL_Deploy_Ropes_Action; };
		};
	};

	true
};

["HookCargo", _hookCargo, _hookCargo, _hookCargo] call CLIENT_OverrideAction;

private _heliRopeAction =
{
	if (not (typeOf (vehicle player) isKindOf "Air")) exitWith { false };
		
	if ([vehicle player] call ASL_Can_Operate_Flight_Controls) then
	{
		switch (true) do
		{
			case ([vehicle player, player] call JBTPI_ReleasePodCondition): { [vehicle player] call JBTPI_ReleasePod; };

			case ([] call ASL_Release_Cargo_Action_Check): { [] call ASL_Release_Cargo_Action; };

			case ([vehicle player, player] call JBTPI_AttachPodCondition): { [vehicle player, player] call JBTPI_AttachPod; };

			case ([] call ASL_Deploy_Ropes_Action_Check): { [] call ASL_Deploy_Ropes_Action; };
		};
	};

	true;
};

["HeliRopeAction", _heliRopeAction, _heliRopeAction, _heliRopeAction] call CLIENT_OverrideAction;
