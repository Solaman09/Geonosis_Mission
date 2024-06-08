params ["_position", "_VehicleToDrop", "_AddCrewToggle"];

_position= (ASLtoATL _position);

_spawnpos = _position vectorAdd [random [-500, 0, 500], random [-500, 0, 500], 1500];
                    
                     _mainprojectile=createvehicle ["Sh_125mm_APFSDS", _spawnpos, [], 0, "NONE"];
					_mainprojectile setShotParents [player, player];
                    
                    _angle = [(_position vectorFromTo _spawnpos)#0, (_position vectorFromTo _spawnpos)#1, ((_position vectorFromTo _spawnpos)#2)];

					_DirRandom = (random 360);

                    _projectile = createvehicle ["UNSC_Orbital_Crate", [0, 0, 0], [], 0, "NONE"];
					_projectile setdir (_DirRandom);
                    _projectile setPosATL (getPosATL _mainprojectile);
                    [_projectile, _mainprojectile] call BIS_fnc_attachtorelative;
					_projectile enableSimulationGlobal false;
					_projectile setObjectScale 2;
                    _projectile allowdamage false;
                    
                     [_mainprojectile, _position,_projectile] spawn {
                        params ["_mainprojectile", "_position","_projectile"];
                        while {(alive _mainprojectile) && (((getPosATL _mainprojectile) # 2) > 500)} do {
                            _mainprojectile setvelocity ((_position vectorFromTo (getPosATL _mainprojectile)) vectorMultiply -150);
                        };
						while {(alive _mainprojectile)} do {
							_mainprojectile setvelocity ((_position vectorFromTo (getPosATL _mainprojectile)) vectorMultiply -75);
						}
                    };
                    
					[[_projectile], {
                        params ["_projectile"];
                        _FloodLight = "#lightpoint" createvehiclelocal [0, 0, 0];
                        _FloodLight attachto [_projectile, [0, 0, 0]];
                        _FloodLight setLightColor [0,1,0];
                        _FloodLight setLightAmbient [0,1,0];
                        _FloodLight setLightBrightness 3;
                        _FloodLight setLightDayLight true;
                        
                        waitUntil {
                            !alive _projectile
                        };
                        deletevehicle _floodLight;

                    }] remoteExec ["spawn"];

					[_projectile,_mainprojectile] spawn {
						params ["_projectile","_mainprojectile"];
						
						waitUntil { (((getPosATL _projectile) # 2) < 500) };

						_mainprojectile say3D ["Cov_DropPod_Thruster", 2000, random [1, 2, 3]];

						//3.5 default z
						_RayPos1 = _projectile modelToWorld [3.43073,0.0209351,-1.76057];
						_RayPos2 = _projectile modelToWorld [-3.44189,0.0350342,-1.72635];

						[[_projectile,_RayPos1,_RayPos2],{
							params ["_projectile","_RayPos1","_RayPos2"];
							_velocitymybeloved=(velocity _projectile) vectorMultiply 2;
							
							_ray1 = "#particlesource" createVehicleLocal _RayPos1;
							_ray1 setParticleCircle [0, [0, 0, -3]];
							_ray1 setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0, [0, 0, 0, 1], 0, 0];
							_ray1 setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 0.3, [0, 0, 0], _velocitymybeloved, 60, 10, 7.6, 0, [1.5,1.5,1.5,1], [[1,0.46,0, 1],[1,0.46,0, 1]], [0.08], 1, 0, "", "", _ray1]; 
							_ray1 setDropInterval 0.0003;
							_ray1 attachTo [_projectile];
							[_ray1,_projectile] spawn {params ['_ray1','_projectile']; waitUntil {(!alive _projectile) || ((getPosATL _projectile # 2) < 5)}; deleteVehicle _ray1;};

							_ray2 = "#particlesource" createVehicleLocal _RayPos2;
							_ray2 setParticleCircle [0, [0, 0, -3]];
							_ray2 setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0, [0, 0, 0, 1], 0, 0];
							_ray2 setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 0.3, [0, 0, 0], _velocitymybeloved, 60, 10, 7.6, 0, [1.5,1.5,1.5,1], [[1,0.46,0, 1],[1,0.46,0, 1]], [0.08], 1, 0, "", "", _ray2]; 
							_ray2 setDropInterval 0.0003;
							_ray2 attachTo [_projectile];
							[_ray2,_projectile] spawn {params ['_ray2','_projectile']; waitUntil {(!alive _projectile) || ((getPosATL _projectile # 2) < 5)}; deleteVehicle _ray2;};
						}] remoteExec ["spawn"];

					};

                    
                    
                    [_mainprojectile, _position, _projectile, _selection, _VehicleToDrop,_AddCrewToggle,_DirRandom] spawn {
                        params ["_mainprojectile", "_position", "_projectile", "_selection","_VehicleToDrop","_AddCrewToggle","_DirRandom"];
                        
                        _positionATL=_position;
                        waitUntil {
                            if (alive _mainprojectile) then {
                                _positionATL=getPosATL _mainprojectile;
                            };
                            !alive _mainprojectile;
                        };
                        
                        [[_positionATL], {
                            params ['_position'];
                            _positionATL = _position;
                            _positionATL set [2, 2];
                            
                            private _ps1 = "#particlesource" createvehiclelocal _positionATL;
                            _ps1 setParticleParams [
                                "\A3\Data_F\ParticleEffects\Pstone\Pstone", "", "SpaceObject",
                                1, 10, [0, 0, 0], [0, 0, 10], 1, 20, 1, 0.2, [0.1, 1],
                                [[1, 1, 1, 1]],
                            [0, 1], 1, 0, "", "", _ps1];
                            _ps1 setParticleRandom [0, [5, 5, 0], [5, 5, 5], 0, 1.5, [0, 0, 0, 0], 0, 0];
                            _ps1 setParticleCircle [5, [0, 5, 5]];
                            _ps1 setDropInterval 0.01;
                            
                            _ps1 spawn {
                                sleep 1;
                                deletevehicle _this;
                            };
                        }] remoteExec ["spawn"];
                        
						
                        _craterpos = _positionATL;
                        _craterpos set [2, 0];
						_craterposNew = [(_craterpos select 0), (_craterpos select 1),(5 + (_craterpos select 2))];

						deleteVehicle _projectile;

						_Placeholder = createvehicle ["UserTexture1m_F", (_craterposNew), [], 0, "CAN_COLLIDE"];
						_projectile = createvehicle ["UNSC_Orbital_Crate", (_craterposNew), [], 0, "CAN_COLLIDE"];
						_projectile setdir (_DirRandom);
						_projectile setPos getPos _projectile;
                        _projectile setPosATL [(_craterpos select 0), (_craterpos select 1), 3];
						[_projectile, _Placeholder] call BIS_fnc_attachtorelative;
						_projectile enableSimulationGlobal false;
						_projectile allowdamage false;
						_projectile setObjectScale 2;
						
                        _GroundCrack = createvehicle ["Land_RoadCrack_01_4x4_F", _craterpos, [], 0, "CAN_COLLIDE"];
						_GroundCrack setVectorUp surfaceNormal position _GroundCrack;
						_GroundCrack enableSimulationGlobal false;
						_GroundCrack setObjectScale (3+(random 2));

						sleep 5;
						
						_projectile say3D ["DropOpen", 1000, random [1, 2, 3]];

						_StructureToBuild = createvehicle [_VehicleToDrop, _CraterPos, [], 0, "CAN_COLLIDE"];

						if (_AddCrewToggle) then {
							createvehiclecrew _StructureToBuild;
						};

						_StructureToBuild setdir (_DirRandom);
						_StructureToBuild setVectorUp surfaceNormal position _StructureToBuild;
						_StructureToBuild setPosATL [(_craterpos select 0), (_craterpos select 1),0];
						
						{
                            [_x, [[_GroundCrack], false]] remoteExec ["addCuratorEditableObjects", 0];
                            [_x, [[_structuretoBuild], false]] remoteExec ["addCuratorEditableObjects", 0];
                        } forEach allCurators;

                    sleep 1;

						deleteVehicle _projectile;
						deleteVehicle _Placeholder;

						sleep 180;
						deleteVehicle _GroundCrack;
					};