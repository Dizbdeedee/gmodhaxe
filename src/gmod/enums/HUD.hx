package gmod.enums;
/**
    Enumerations used by Player:PrintMessage and PrintMessage.
**/
@:native("_G")
extern enum abstract HUD(Int) {
    /**
        Center of the screen
    **/
    var HUD_PRINTCENTER;
    /**
        Chat, also prints to console
    **/
    var HUD_PRINTTALK;
    /**
        No longer works; now same as HUD_PRINTCONSOLE
    **/
    var HUD_PRINTNOTIFY;
    /**
        Console
    **/
    var HUD_PRINTCONSOLE;
    
}