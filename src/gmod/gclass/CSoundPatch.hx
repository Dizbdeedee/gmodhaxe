package gmod.gclass;


/**
    CSoundPatch class. 
	
	Created with CreateSound
**/
extern class CSoundPatch {
    
    /**
        Fades out the volume of the sound from the current volume to 0 in the given amount of seconds.
		
		Name | Description
		--- | ---
		`seconds` | Fade time.
    **/
    
    function FadeOut(seconds:Float):Void;
    
    
    /**
        Starts to play the sound.
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		local mysound = CreateSound( "test.wav" )
		mysound:Play()
		```
    **/
    
    function Play():Void;
    
    
    /**
        Returns the DSP ( Digital Signal Processor ) effect for the sound.
		
		`**Returns:** The DSP effects of the sound List of DSP's are Pick from the here.
    **/
    
    function GetDSP():Float;
    
    
    /**
        Adjusts the volume of the sound played. Appears to only work while the sound is being played.
		
		Name | Description
		--- | ---
		`volume` | The volume ranges from 0 to 1.
		`deltaTime` | Time to fade the volume from previous to new value from.
    **/
    
    function ChangeVolume(volume:Float, ?deltaTime:Float):Void;
    
    
    /**
        Returns the current pitch.
		
		`**Returns:** The current pitch, can range from 0-255.
    **/
    
    function GetPitch():Float;
    
    
    /**
        Adjust the pitch, alias the speed at which the sound is being played. 
		
		This invokes the GM:EntityEmitSound.
		
		Name | Description
		--- | ---
		`pitch` | The pitch can range from 0-255.
		`deltaTime` | The time to fade from previous to the new pitch.
    **/
    
    function ChangePitch(pitch:Float, ?deltaTime:Float):Void;
    
    
    /**
        Returns the current sound level.
		
		`**Returns:** The current sound level, see SNDLVL_ Enums.
    **/
    
    function GetSoundLevel():SNDLVL;
    
    
    /**
        Same as CSoundPatch:Play but with 2 extra arguments allowing to set volume and pitch directly.
		
		Name | Description
		--- | ---
		`volume` | The volume ranges from 0 to 1.
		`pitch` | The pitch can range from 0-255.
    **/
    
    function PlayEx(volume:Float, pitch:Float):Void;
    
    
    /**
        Returns whenever the sound is being played.
		
		`**Returns:** Is playing or not
    **/
    
    function IsPlaying():Bool;
    
    
    /**
        Returns the current volume.
		
		`**Returns:** The current volume, ranging from 0 to 1.
    **/
    
    function GetVolume():Float;
    
    
    /**
        Sets the sound level in decibel.
		
		Name | Description
		--- | ---
		`level` | The sound level in decibel. See SNDLVL_ Enums
    **/
    
    function SetSoundLevel(level:SNDLVL):Void;
    
    
    /**
        Sets the DSP ( Digital Signal Processor ) effect for the sound. Similar to Player:SetDSP
		
		Name | Description
		--- | ---
		`dsp` | The DSP effect to set. Pick from the list of DSP's
    **/
    
    function SetDSP(dsp:Float):Void;
    
    
    /**
        Stops the sound from being played.
		
		**Bug:** BUG This will not work if the entity attached to this sound patch (specified by CreateSound) is invalid. Issue Tracker: #3260
    **/
    
    function Stop():Void;
    
    
}



