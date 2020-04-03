package gmod.enums;
/**
    Enumerations used by input.IsButtonDown. 
	
	It's also part of the BUTTON_CODE_ Enums.
**/
@:native("_G")
extern enum abstract JOYSTICK(Int) {
    /**
        Joystick POV buttons are in this range, but don't have individual enum names.
    **/
    var JOYSTICK_FIRST_POV_BUTTON;
    /**
        
    **/
    var JOYSTICK_FIRST;
    /**
        
    **/
    var JOYSTICK_LAST_BUTTON;
    /**
        Joystick axis buttons are in this range, but don't have individual enum names.
    **/
    var JOYSTICK_FIRST_AXIS_BUTTON;
    /**
        
    **/
    var JOYSTICK_LAST;
    /**
        
    **/
    var JOYSTICK_LAST_POV_BUTTON;
    /**
        Joystick buttons are in this range, but don't have individual enum names.
    **/
    var JOYSTICK_FIRST_BUTTON;
    /**
        
    **/
    var JOYSTICK_LAST_AXIS_BUTTON;
    
}