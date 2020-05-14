package gmod.enums;
/**
    Enumerations used by Player:ScreenFade.
**/
@:native("_G.SCREENFADE")
extern enum abstract SCREENFADE(Int) {
    /**
        Fade out after the hold time has passed
    **/
    var IN;
    /**
        Fade in, hold time passes, disappear
    **/
    var OUT;
    /**
        Appear, Disappear, no effects
    **/
    var PURGE;
    /**
        With white color, turns the screen black
    **/
    var MODULATE;
    /**
        No effects, never disappear
    **/
    var STAYOUT;
    
}