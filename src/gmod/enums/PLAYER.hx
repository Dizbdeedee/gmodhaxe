package gmod.enums;
/**
    Enumerations used by Entity:SetAnimation
**/
@:native("_G")
extern enum abstract PLAYER(Int) {
    /**
        Player reload according to current hold type, used in SWEPs
    **/
    var PLAYER_RELOAD;
    /**
        
    **/
    var PLAYER_SUPERJUMP;
    /**
        
    **/
    var PLAYER_DIE;
    /**
        
    **/
    var PLAYER_JUMP;
    /**
        
    **/
    var PLAYER_IN_VEHICLE;
    /**
        Player attack according to current hold type, used in SWEPs
    **/
    var PLAYER_ATTACK1;
    /**
        
    **/
    var PLAYER_LEAVE_AIMING;
    /**
        
    **/
    var PLAYER_WALK;
    /**
        
    **/
    var PLAYER_START_AIMING;
    /**
        
    **/
    var PLAYER_IDLE;
    
}