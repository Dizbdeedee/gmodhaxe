package gmod.enums;
/**
    Sound flags used by EmitSound and Entity:EmitSound.
**/
@:native("_G")
extern enum abstract SND(Int) {
    /**
        Sound has an initial delay
    **/
    var SND_DELAY;
    /**
        To keep the compiler happy
    **/
    var SND_NOFLAGS;
    /**
        Change sound pitch
    **/
    var SND_CHANGE_PITCH;
    /**
        Stop the sound
    **/
    var SND_STOP;
    /**
        
    **/
    var SND_IGNORE_PHONEMES;
    /**
        Change sound vol
    **/
    var SND_CHANGE_VOL;
    /**
        Used to change all sounds emitted by an entity, regardless of scriptname
    **/
    var SND_IGNORE_NAME;
    /**
        We're spawning, used in some cases for ambients. Not sent over net, only a param between dll and server.
    **/
    var SND_SPAWNING;
    /**
        This sound should be paused if the game is paused
    **/
    var SND_SHOULDPAUSE;
    /**
        
    **/
    var SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL;
    /**
        Stop all looping sounds on the entity.
    **/
    var SND_STOP_LOOPING;
    
}