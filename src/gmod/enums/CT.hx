package gmod.enums;
/**
    Citizen type, a KeyValue for npc_citizen( citizentype ), serverside only.
**/
@:native("_G")
extern enum abstract CT(Int) {
    /**
        Odessa?
    **/
    var CT_UNIQUE;
    /**
        Rebel
    **/
    var CT_REBEL;
    /**
        Default citizen
    **/
    var CT_DEFAULT;
    /**
        
    **/
    var CT_DOWNTRODDEN;
    /**
        Refugee
    **/
    var CT_REFUGEE;
    
}