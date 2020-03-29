package gmod.enums;

@:native("_G")
/**
    Enumerations used by Entity:SetUseType. Affects when ENTITY:Use is triggered.

    Not to be confused with USE_ Enums used for ENTITY:Use and others.
**/
extern enum abstract USETYPE(Int) {
    /**
        Fire a USE_ON signal every tick as long as the player holds their use key and aims at the target.
    **/
    var CONTINUOUS_USE;
    /**
        Fires a USE_ON signal when starting to use an entity, and a USE_OFF signal when letting go. 
        
        **Warning:** There is no guarantee to receive both ON and OFF signals. A signal will only be sent when pushing or letting go of the use key while actually aiming at the entity, so an ON signal might not be followed by an OFF signal if the player is aiming somewhere else when releasing the key, and similarly, an OFF signal may not be preceded by an ON signal if the player started aiming at the entity only after pressing the key.

        Therefore, this method of input is unreliable and should not be used. 
    **/
    var ONOFF_USE;
    /**
        Like a wheel turning. 
    **/
    var DIRECTIONAL_USE;
    /**
        Fire a USE_ON signal only once when player presses their use key while aiming at the target. 
    **/
    var SIMPLE_USE;
}