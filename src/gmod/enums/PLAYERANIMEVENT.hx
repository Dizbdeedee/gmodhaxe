package gmod.enums;
/**
    Used by GM:DoAnimationEvent and Player:DoCustomAnimEvent.
**/
@:native("_G")
extern enum abstract PLAYERANIMEVENT(Int) {
    /**
        Play sequence in gesture slot
    **/
    var PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE;
    /**
        
    **/
    var PLAYERANIMEVENT_FLINCH_LEFTARM;
    /**
        Spawn
    **/
    var PLAYERANIMEVENT_SPAWN;
    /**
        Reload
    **/
    var PLAYERANIMEVENT_RELOAD;
    /**
        Swim
    **/
    var PLAYERANIMEVENT_SWIM;
    /**
        
    **/
    var PLAYERANIMEVENT_FLINCH_RIGHTARM;
    /**
        Looping reload (single-reload shotguns)
    **/
    var PLAYERANIMEVENT_RELOAD_LOOP;
    /**
        
    **/
    var PLAYERANIMEVENT_SNAP_YAW;
    /**
        Cancel reload animation
    **/
    var PLAYERANIMEVENT_CANCEL_RELOAD;
    /**
        Jump
    **/
    var PLAYERANIMEVENT_JUMP;
    /**
        Die
    **/
    var PLAYERANIMEVENT_DIE;
    /**
        
    **/
    var PLAYERANIMEVENT_CANCEL;
    /**
        
    **/
    var PLAYERANIMEVENT_DOUBLEJUMP;
    /**
        
    **/
    var PLAYERANIMEVENT_FLINCH_HEAD;
    /**
        Grenade throw
    **/
    var PLAYERANIMEVENT_ATTACK_GRENADE;
    /**
        
    **/
    var PLAYERANIMEVENT_FLINCH_RIGHTLEG;
    /**
        
    **/
    var PLAYERANIMEVENT_FLINCH_CHEST;
    /**
        
    **/
    var PLAYERANIMEVENT_FLINCH_LEFTLEG;
    /**
        Play activity in gesture slot
    **/
    var PLAYERANIMEVENT_CUSTOM_GESTURE;
    /**
        Play sequence
    **/
    var PLAYERANIMEVENT_CUSTOM_SEQUENCE;
    /**
        Custom activity
    **/
    var PLAYERANIMEVENT_CUSTOM;
    /**
        Secondary attack
    **/
    var PLAYERANIMEVENT_ATTACK_SECONDARY;
    /**
        Primary attack
    **/
    var PLAYERANIMEVENT_ATTACK_PRIMARY;
    /**
        Looping reload end
    **/
    var PLAYERANIMEVENT_RELOAD_END;
    
}