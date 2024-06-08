[] call compileFinal preprocessFileLineNumbers "scripts\rolearsenal.sqf";
radioJammer = [[jammer1, jammer2, jammer3], 1000, 30, False] execVM "scripts\TFARjamRadios.sqf";

KARMA_ARSENAL_CRATES = [];
Arsenal_typename = "Dmns_UNSC_Crate_Single";

[Arsenal_typename, "init",
{
    private _box = (_this select 0);
    private _player = player;

    diag_log format ["ROLE ARSENAL EH Role: %1", roleDescription _player];	

    /*
        // Loop through every box just to be safe.
        {
            [_box, _player] call roleArsenal;          
        } forEach KARMA_ARSENAL_CRATES;
    */
    
    KARMA_ARSENAL_CRATES pushback _box;
    [roleArsenal, [_box, _player], 5] call CBA_fnc_waitAndExecute;
},
true,
[],
true
] call CBA_fnc_addClassEventHandler;

   // player = player;
    _position = screenToWorld [0.5, 0.5];


    diag_log "addActionsace.sqf loaded";
    // Function to check if the player has the "JFO" variable set to true
    _condition1 = {
        player getVariable ["JFO", false];
    };

    // Function to call the OPTRE_fnc_CS_PelicanDropSupplys script
    _statement1 = {
        [player getPos [50, 20], "OPTRE_M12_LRV"] call OPTRE_fnc_CS_PelicanDropSupplys;
    };

    // Create an action for calling in a warthog
    _action = ["Call in Warthog", "Warthog Pelican drop", "", _statement1, _condition1] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

    orbitalVehicleDropActivated = false;

    // Function to check if the player has the "JFO" variable set to true and if the orbital vehicle drop is not activated
    _condition2 = {
        player getVariable ["JFO", false] && !isNil "orbitalVehicleDropActivated" && !orbitalVehicleDropActivated;
    };

    // Function to execute the warthogtroop.sqf script and activate the orbital vehicle drop
    _statement2 = {
        [] execVM "scripts\warthogtroop.sqf";
        orbitalVehicleDropActivated = true;
    };

    // Create an action for the orbital drop
    _action = ["Orbital Drop", "Orbital drop", "", _statement2, _condition2] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

    player setVariable ["lastActivationTime", -30]; // Initialize lastActivationTime
    player setVariable ["activationCount", 0]; // Initialize activationCount

    // Function to check if the player has the "JFO" variable set to true, activation count is less than 2, and enough time has passed since the last activation
    _condition3 = {
        player getVariable ["JFO", false] && 
        ((player getVariable ["activationCount", 0]) < 2) && 
        (time - (player getVariable ["lastActivationTime", 0]) >= 30);
    };

    // Function to execute the OrbitalSupplyDrop.sqf script, increment the activation count, and update the last activation time
    _statement3 = {
        [] execVM "scripts\OrbitalSupplyDrop.sqf";
        player setVariable ["activationCount", (player getVariable ["activationCount", 0]) + 1];
        player setVariable ["lastActivationTime", time];
    };

    // Create an action for the orbital supply drop
    _action = ["Orbital Supply Drop", "Orbital Supply Drop", "", _statement3, _condition3] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;



    player setVariable ["archerActivationTime", -3]; // Initialize archerActivationTime
    player setVariable ["archerActivationCount", 0]; // Initialize archerActivationCount

    // Function to check if the player has the "JFO" variable set to true, activation count is less than 1, and enough time has passed since the last activation
    _condition4 = {
        player getVariable ["JFO", false] && 
        ((player getVariable ["archerActivationCount", 0]) < 1) && 
        (time - (player getVariable ["archerActivationTime", 0]) >= 3);
    };

    // Function to call the PHAN_SCIFISUPPORTPLUS_fnc_OPTRE_ArcherMissile function
    _statement4 = {
        [screenToWorld [0.5, 0.5]] call PHAN_SCIFISUPPORTPLUS_fnc_OPTRE_ArcherMissile;
        player setVariable ["archerActivationCount", (player getVariable ["archerActivationCount", 0]) + 1];
        player setVariable ["archerActivationTime", time];
    };

    // Create an action for the Archer strike
    _action = ["Archer Strike", "Archer strike", "", _statement4, _condition4] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
