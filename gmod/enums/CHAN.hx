package gmod.enums;
/**
    Enumerations used by EmitSound and sound.Add.
**/
@:native("_G")
extern enum abstract CHAN(Int) {
    /**
        Automatic channel
    **/
    var CHAN_AUTO;
    /**
        Stream channel from the static or dynamic area
    **/
    var CHAN_STREAM;
    /**
        Channel for network voice data
    **/
    var CHAN_VOICE_BASE;
    /**
        Channel for NPC voices
    **/
    var CHAN_VOICE;
    /**
        TF2s Announcer dialogue channel
    **/
    var CHAN_VOICE2;
    /**
        Channel for items ( Health kits, etc )
    **/
    var CHAN_ITEM;
    /**
        A constant/background sound that doesn't require any reaction.
    **/
    var CHAN_STATIC;
    /**
        Channel for weapon sounds
    **/
    var CHAN_WEAPON;
    /**
        
    **/
    var CHAN_USER_BASE;
    /**
        Clothing, ragdoll impacts, footsteps, knocking/pounding/punching etc.
    **/
    var CHAN_BODY;
    /**
        Used when playing sounds through console commands.
    **/
    var CHAN_REPLACE;
    
}