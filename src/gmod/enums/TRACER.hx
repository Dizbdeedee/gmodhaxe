package gmod.enums;
/**
    Enumerations used by AmmoData structure.
**/
@:native("_G")
extern enum abstract TRACER(Int) {
    /**
        Generates tracer effects
    **/
    var TRACER_LINE;
    /**
        Generates tracer and makes whizzing noises if the bullet flies past the player being shot at
    **/
    var TRACER_LINE_AND_WHIZ;
    /**
        Generates no tracer effects
    **/
    var TRACER_NONE;
    /**
        Unused.
    **/
    var TRACER_BEAM;
    /**
        Unused.
    **/
    var TRACER_RAIL;
    
}