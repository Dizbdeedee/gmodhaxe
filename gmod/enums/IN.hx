package gmod.enums;
/**
    Unlike BUTTON_CODE_ Enums, these enums are abstracted to allow the user to bind actions to any key they might prefer. 
	
	Keybinds using these actions work with two console commands, one starting with a plus and one with a minus symbol. A key press or release will call either the plus or minus command, adding or removing the corresponding enum in the current CUserCmd. 
	
	 Enumerations used by:
**/
@:native("_G")
extern enum abstract IN(Int) {
    /**
        +speed bound key ( Default: Shift )
    **/
    var IN_SPEED;
    /**
        +jump bound key ( Default: Space )
    **/
    var IN_JUMP;
    /**
        +back bound key ( Default: S )
    **/
    var IN_BACK;
    /**
        +alt2 bound key
    **/
    var IN_ALT2;
    /**
        
    **/
    var IN_BULLRUSH;
    /**
        +attack bound key ( Default: Left Mouse Button )
    **/
    var IN_ATTACK;
    /**
        
    **/
    var IN_RUN;
    /**
        +right bound key ( Look right )
    **/
    var IN_RIGHT;
    /**
        +alt1 bound key
    **/
    var IN_ALT1;
    /**
        +reload bound key ( Default: R )
    **/
    var IN_RELOAD;
    /**
        
    **/
    var IN_CANCEL;
    /**
        +grenade2 bound key
    **/
    var IN_GRENADE2;
    /**
        +left bound key ( Look left )
    **/
    var IN_LEFT;
    /**
        +walk bound key ( Slow walk )
    **/
    var IN_WALK;
    /**
        +use bound key ( Default: E )
    **/
    var IN_USE;
    /**
        +moveright bound key ( Default: D )
    **/
    var IN_MOVERIGHT;
    /**
        +showscores bound key ( Default: Tab )
    **/
    var IN_SCORE;
    /**
        +zoom bound key ( Suit Zoom )
    **/
    var IN_ZOOM;
    /**
        +attack2 bound key ( Default: Right Mouse Button )
    **/
    var IN_ATTACK2;
    /**
        +grenade1 bound key
    **/
    var IN_GRENADE1;
    /**
        For use in weapons. Set in the physgun when scrolling an object away from you.
    **/
    var IN_WEAPON1;
    /**
        +forward bound key ( Default: W )
    **/
    var IN_FORWARD;
    /**
        +moveleft bound key ( Default: A )
    **/
    var IN_MOVELEFT;
    /**
        +duck bound key ( Default: CTRL )
    **/
    var IN_DUCK;
    /**
        For use in weapons. Set in the physgun when scrolling an object towards you.
    **/
    var IN_WEAPON2;
    
}