package gmod.enums;
/**
    Enumerations used in ENTITY:UpdateTransmitState hook.
**/
@:native("_G")
extern enum abstract TRANSMIT(Int) {
    /**
        Always transmit the entity
    **/
    var TRANSMIT_ALWAYS;
    /**
        Transmit when entity is in players view
    **/
    var TRANSMIT_PVS;
    /**
        Never transmit the entity, default for point entities
    **/
    var TRANSMIT_NEVER;
    
}