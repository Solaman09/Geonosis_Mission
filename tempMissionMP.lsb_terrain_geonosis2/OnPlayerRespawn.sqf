{
    private _box = _x;
    if (!isNull _box) then 
    {
        //KARMA_ARSENAL_CRATES deleteAt (KARMA_ARSENAL_CRATES find _x);
        [_box, player] call roleArsenal;
    };
} forEach KARMA_ARSENAL_CRATES;