
    _unit = player;
    diag_log "addActionsace.sqf loaded";
    // Function to check if the player has the "JFO" variable set to true
    _condition = {
        _unit getVariable ["JFO", false];
    };

    // Function to call the OPTRE_fnc_CS_PelicanDropSupplys script
    _statement = {
        [_unit getPos [50, 20], "OPTRE_M12_LRV"] call OPTRE_fnc_CS_PelicanDropSupplys;
    };

    // Create an action for calling in a warthog
    _action = ["Call in Warthog", "Warthog Pelican drop", "", _statement, _condition] call ace_interact_menu_fnc_createAction;
    [(typeOf _unit), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

    orbitalVehicleDropActivated = false;

    // Function to check if the player has the "JFO" variable set to true and if the orbital vehicle drop is not activated
    _condition = {
        _unit getVariable ["JFO", false] && !isNil "orbitalVehicleDropActivated" && !orbitalVehicleDropActivated;
    };

    // Function to execute the warthogtroop.sqf script and activate the orbital vehicle drop
    _statement = {
        [] execVM "scripts\warthogtroop.sqf";
        orbitalVehicleDropActivated = true;
    };

    // Create an action for the orbital drop
    _action = ["Orbital Drop", "Orbital drop", "", _statement, _condition] call ace_interact_menu_fnc_createAction;
    [(typeOf _unit), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

    _unit setVariable ["lastActivationTime", -30]; // Initialize lastActivationTime
    _unit setVariable ["activationCount", 0]; // Initialize activationCount

    // Function to check if the player has the "JFO" variable set to true, activation count is less than 2, and enough time has passed since the last activation
    _condition = {
        _unit getVariable ["JFO", false] && 
        ((_unit getVariable ["activationCount", 0]) < 2) && 
        (time - (_unit getVariable ["lastActivationTime", 0]) >= 30);
    };

    // Function to execute the OrbitalSupplyDrop.sqf script, increment the activation count, and update the last activation time
    _statement = {
        [] execVM "scripts\rbitalSupplyDrop.sqf";
        _unit setVariable ["activationCount", (_unit getVariable ["activationCount", 0]) + 1];
        _unit setVariable ["lastActivationTime", time];
    };

    // Create an action for the orbital supply drop
    _action = ["Orbital Supply Drop", "Orbital Supply Drop", "", _statement, _condition] call ace_interact_menu_fnc_createAction;
    [(typeOf _unit), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

    _position = screenToWorld [0.5, 0.5];

    _unit setVariable ["archerActivationTime", -3]; // Initialize archerActivationTime
    _unit setVariable ["archerActivationCount", 0]; // Initialize archerActivationCount

    // Function to check if the player has the "JFO" variable set to true, activation count is less than 1, and enough time has passed since the last activation
    _condition = {
        _unit getVariable ["JFO", false] && 
        ((_unit getVariable ["archerActivationCount", 0]) < 1) && 
        (time - (_unit getVariable ["archerActivationTime", 0]) >= 3);
    };

    // Function to call the PHAN_SCIFISUPPORTPLUS_fnc_OPTRE_ArcherMissile function
    _statement = {
        [screenToWorld [0.5, 0.5]] call PHAN_SCIFISUPPORTPLUS_fnc_OPTRE_ArcherMissile;
        _unit setVariable ["archerActivationCount", (_unit getVariable ["archerActivationCount", 0]) + 1];
        _unit setVariable ["archerActivationTime", time];
    };

    // Create an action for the Archer strike
    _action = ["Archer Strike", "Archer strike", "", _statement, _condition] call ace_interact_menu_fnc_createAction;
    [(typeOf _unit), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;


    // Wait for 5 seconds and then execute the action
    [CBA_fnc_addActionToClass, [(typeOf _unit), 1, ["ACE_SelfActions"], _action], 5] call CBA_fnc_waitAndExecute;
