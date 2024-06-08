       itemsDelivered = 0; [color="#B22222"]//--- global variable checking how many mags I have dropped.[/color]

       player addeventhandler ["Put",{
	_player = _this select 0; [color="#B22222"]//--- player who dropped something[/color]
	_object = _this select 1;[color="#B22222"] //--- physical location of the dropped object[/color]
	_type = _this select 2;  [color="#B22222"] //--- item classname[/color]

	if ((_object distance theGuy) > 5) exitwith {}; 
	if (_type == "OPTRE_Fury_Backpack_Nuke") then {itemsDelivered = itemsDelivered + 1;};
}];
[color="#B22222"]
//--- now checking when enough mags have been dropped near him.[/color]
[] spawn {
waituntil {itemsDelivered == 1};
hint "Nuke delivered";
};