package gmod.structs;
/**
    Passed as argument of [GM](https://wiki.garrysmod.com/page/Category:GM_Hooks): [EntityEmitSound](https://wiki.garrysmod.com/page/GM/EntityEmitSound).
**/
typedef EmitSoundInfo = {
    /**
        The entity that played the sound.
    **/
    var Entity : Entity;
    /**
        The original file path or soundscript name. 
		
		Even if the SoundName value is changed, the OriginalSoundName value will remain the same. 
		
		Sounds may be returned as soundscripts (for example, "Weapon_357.Single") instead of the sound's file path. You can use sound.GetProperties to retrieve the actual file path.
    **/
    var OriginalSoundName : String;
    /**
        The sound's attenuation, a number between 0 (low) and 511 (high) 
		
		This determines how fast the sound drops away. A higher value means the sound can be heard farther away. 
		
		See SNDLVL_ Enums. 
		
		Default: 75
    **/
    var ?SoundLevel : SNDLVL;
    /**
        The bit flags of the played sound. See SND_ Enums for available options. 
		
		Default: 0
    **/
    var ?Flags : SND;
    /**
        The pitch of the played sound, a number between 0 (low) and 255 (high), where 100 is the sound's original pitch. 
		
		Default: 100
    **/
    var ?Pitch : Float;
    /**
        The time at which the sound should be played. 
		
		If equal to 0 or CurTime(), the sound is played immediately. If greater than CurTime(), the sound is played with a delay. If less than CurTime(), part of the sound is skipped. 
		
		Default: 0
    **/
    var ?SoundTime : Float;
    /**
        The volume of the played sound, return as a decimal number between 0 (low) and 1 (high).
    **/
    var Volume : Float;
    /**
        The DSP (digital signal processing) preset applied to the sound. 
		
		There are approximately 134 different presets defined by the Source engine between 0 and 133. These presets represent different types of 'rooms' or environments. 
		
		List of DSP's 
		
		Default: 0
    **/
    var ?DSP : Float;
    /**
        The file path of the played sound. 
		
		Sounds prefixed with ) tell the sound engine that it is a spatial sound; this allows the sound to emit from a specific location within the world. 
		
		Sounds prefixed with ^ tell the sound engine that it is a distance based sound. The left channel of the .wav is the 'near' sound that will play when the sound originates close to you, and the right channel is the 'far' sound that will play when the sound originates far from you.
    **/
    var SoundName : String;
    /**
        The origin of the played sound.
    **/
    var Pos : Vector;
    /**
        The sound's channel. See CHAN_ Enums for available options.
    **/
    var Channel : CHAN;
    
}
