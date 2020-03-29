package gmod.enums;
/**
    Enumerations used by IGModAudioChannel:GetState. Clientside only.
**/
@:native("_G")
extern enum abstract GMOD_CHANNEL(Int) {
    /**
        The channel is paused
    **/
    var GMOD_CHANNEL_PAUSED;
    /**
        The channel is stopped
    **/
    var GMOD_CHANNEL_STOPPED;
    /**
        The channel is buffering
    **/
    var GMOD_CHANNEL_STALLED;
    /**
        The channel is playing
    **/
    var GMOD_CHANNEL_PLAYING;
    
}