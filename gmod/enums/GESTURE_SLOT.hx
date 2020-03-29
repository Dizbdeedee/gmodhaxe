package gmod.enums;
/**
    Enumerations used by Player:AnimResetGestureSlot and Player:AnimRestartGesture.
**/
@:native("_G")
extern enum abstract GESTURE_SLOT(Int) {
    /**
        Slot for weapon gestures
    **/
    var GESTURE_SLOT_ATTACK_AND_RELOAD;
    /**
        Slot for flinching gestures
    **/
    var GESTURE_SLOT_FLINCH;
    /**
        Slot for swimming gestures
    **/
    var GESTURE_SLOT_SWIM;
    /**
        Slot for jump gestures
    **/
    var GESTURE_SLOT_JUMP;
    /**
        
    **/
    var GESTURE_SLOT_VCD;
    /**
        
    **/
    var GESTURE_SLOT_GRENADE;
    /**
        Slot for custom gestures
    **/
    var GESTURE_SLOT_CUSTOM;
    
}