package gmod.enums;
/**
    Enumerations used in GM:PlayerStepSoundTime hook.
**/
@:native("_G")
extern enum abstract STEPSOUNDTIME(Int) {
    /**
        Normal step
    **/
    var STEPSOUNDTIME_NORMAL;
    /**
        Step on ladder
    **/
    var STEPSOUNDTIME_ON_LADDER;
    /**
        Step in water, with water reaching knee
    **/
    var STEPSOUNDTIME_WATER_KNEE;
    /**
        Step in water, with water reaching foot
    **/
    var STEPSOUNDTIME_WATER_FOOT;
    
}