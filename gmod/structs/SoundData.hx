package gmod.structs;
/**
    Table used in [sound](https://wiki.garrysmod.com/page/Category:sound). [Add](https://wiki.garrysmod.com/page/sound/Add) and [sound](https://wiki.garrysmod.com/page/Category:sound). [GetProperties](https://wiki.garrysmod.com/page/sound/GetProperties).
**/
typedef SoundData = {
    /**
        The name of the sound.
    **/
    var name : String;
    /**
        The pitch of the sound. Can be a table of two numbers, a minimum and a maximum value. 
		
		Default: 100
    **/
    var ?pitch : Float;
    /**
        The sound file to be used in this sound effect. Can be a table of sound files. Relative to "sound" directory (must be in a subfolder, so sound/test.wav will not work).
    **/
    var sound : String;
    /**
        The pitch end. Deprecated, use pitch.
    **/
    var pitchend : Float;
    /**
        The soundlevel of the sound in dB. See SNDLVL_ Enums.
    **/
    var level : SNDLVL;
    /**
        The volume of the sound as a decimal between 0 and 1. Can be a table of two numbers, a minimum and a maximum value. 
		
		Default: 1.0
    **/
    var ?volume : Float;
    /**
        The initial pitch. Deprecated, use pitch.
    **/
    var pitchstart : Float;
    /**
        The sound channel to play in. See CHAN_ Enums
    **/
    var channel : CHAN;
    
}
