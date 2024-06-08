// Define the ACE self-interaction action
	// Open the map for the player

openMap [true, false];	// opens map normally
	// Wait for the player to select a position on the map
	waitUntil {mapIsOpen};
	// Get the selected position from the map
	_position = getMarkerPos "BIS_mapGrid";
	// Close the map
	player reveal map false;
	// Check if a position was selected
	if (!isNil "_position") then {
		// Call the Archer missile strike function with the selected position
		[_position] call PHAN_SCIFISUPPORTPLUS_fnc_OPTRE_ArcherMissile;
	};

