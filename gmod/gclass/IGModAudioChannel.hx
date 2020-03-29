package gmod.gclass;
#if client

/**
    A sound channel returned by a callback of sound.PlayURL and sound.PlayFile.
**/
extern class IGModAudioChannel {
    
    /**
        Returns if the sound channel is streamed from the Internet or not.
		
		`**Returns:** Is online or not.
    **/
    
    public function IsOnline():Bool;
    
    
    /**
        Retrieves the number of bits per sample of the sound channel. 
		
		Doesn't work for mp3 and ogg files.
		
		`**Returns:** Number of bits per sample, or 0 if unknown.
    **/
    
    public function GetBitsPerSample():Float;
    
    
    /**
        Sets the playback rate of the sound channel. May not work with high values for radio streams.
		
		Name | Description
		--- | ---
		`rate` | Playback rate to set to. 1 is normal speed, 0.5 is half the normal speed, etc.
    **/
    
    public function SetPlaybackRate(rate:Float):Void;
    
    
    /**
        Returns position of the sound channel
		
		`**Returns:** The position of the sound channel, previously set by IGModAudioChannel: SetPos
    **/
    
    public function GetPos():Vector;
    
    
    /**
        Pauses the stream. It can be started again using IGModAudioChannel:Play
    **/
    
    public function Pause():Void;
    
    
    /**
        Starts playing the stream.
    **/
    
    public function Play():Void;
    
    
    /**
        Returns the playback rate of the sound channel.
		
		`**Returns:** The current playback rate of the sound channel
    **/
    
    public function GetPlaybackRate():Float;
    
    
    /**
        Returns whether the audio stream is block streamed or not.
		
		`**Returns:** Is the audio stream block streamed or not.
    **/
    
    public function IsBlockStreamed():Bool;
    
    
    /**
        Returns if the sound channel is in 3D mode or not.
		
		`**Returns:** Is 3D or not.
    **/
    
    public function Is3D():Bool;
    
    
    /**
        Sets the sound channel to specified time ( Rewind to that position of the song ). Does not work on online radio streams. 
		
		Streamed sounds must have "noblock" parameter for this to work.
		
		Name | Description
		--- | ---
		`secs` | The time to set the stream to, in seconds.
    **/
    
    public function SetTime(secs:Float):Void;
    
    
    /**
        Returns the length of sound played by the sound channel.
		
		`**Returns:** The length of the sound. This value seems to be less then 0 for continuous radio streams.
    **/
    
    public function GetLength():Float;
    
    
    /**
        Returns the sample rate for currently playing sound.
		
		`**Returns:** The sample rate in Hz. This should always be 44100.
    **/
    
    public function GetSamplingRate():Float;
    
    
    /**
        Sets 3D cone of the sound channel.
		
		Name | Description
		--- | ---
		`innerAngle` | The angle of the inside projection cone in degrees. Range is from 0 (no cone) to 360 (sphere), -1 = leave current.
		`outerAngle` | The angle of the outside projection cone in degrees. Range is from 0 (no cone) to 360 (sphere), -1 = leave current.
		`outerVolume` | The delta-volume outside the outer projection cone. Range is from 0 (silent) to 1 (same as inside the cone), less than 0 = leave current.
		
		
		___
		### Lua Examples
		#### Example 1
		The default values
		
		```lua 
		Channel:Set3DCone( 360, 360, 0 )
		```
    **/
    
    public function Set3DCone(innerAngle:Float, outerAngle:Float, outerVolume:Float):Void;
    
    
    /**
        Returns 3D fade distances of a sound channel.
		
		Name | Description
		--- | ---
		`a` | The minimum distance. The channel's volume is at maximum when the listener is within this distance
		`b` | The maximum distance. The channel's volume stops decreasing when the listener is beyond this distance
    **/
    
    public function Get3DFadeDistance():IGModAudioChannelGet3DFadeDistanceReturn;
    
    
    /**
        Sets 3D fade distances of a sound channel.
		
		Name | Description
		--- | ---
		`min` | The minimum distance. The channel's volume is at maximum when the listener is within this distance. 0 or less = leave current.
		`max` | The maximum distance. The channel's volume stops decreasing when the listener is beyond this distance. 0 or less = leave current.
		
		
		___
		### Lua Examples
		#### Example 1
		The default values.
		
		```lua 
		Channel:Set3DFadeDistance( 200, 1000000000 )
		```
    **/
    
    public function Set3DFadeDistance(min:Float, max:Float):Void;
    
    
    /**
        Computes the DFT (discrete Fourier transform) of the sound channel. 
		
		The size parameter specifies the number of consecutive audio samples to use as the input to the DFT and is restricted to a power of two. A Hann window is applied to the input data. 
		
		 The computed DFT has the same number of frequency bins as the number of samples. Only half of this DFT is returned, since the DFT magnitudes are symmetric for real input data. The magnitudes of the DFT (values from 0 to 1) are used to fill the output table, starting at index 1. 
		
		 Visualization protip: For a size N DFT, bin k (1-indexed) corresponds to a frequency of (k - 1) / N * sampleRate. 
		
		 Visualization protip: Sound energy is proportional to the square of the magnitudes. Adding magnitudes together makes no sense physically, but adding energies does. 
		
		 Visualization protip: The human ear works on a logarithmic amplitude scale. You can convert to decibels by taking 20 log10 of frequency magnitudes, or 10 log10 of energy. The decibel values will range from -infinity to 0.
		
		Name | Description
		--- | ---
		`tbl` | The table to output the DFT magnitudes (numbers between 0 and 1) into. Indices start from 1.
		`size` | The number of samples to use. See FFT_ Enums
		
		
		`**Returns:** The number of frequency bins that have been filled in the output table.
    **/
    
    public function FFT(tbl:AnyTable, size:FFT):Float;
    
    
    /**
        Sets position of sound channel in case the sound channel has a 3d option set.
		
		Name | Description
		--- | ---
		`pos` | The position to put the sound into
		`dir` | The direction of the sound
    **/
    
    public function SetPos(pos:Vector, ?dir:Vector):Void;
    
    
    /**
        Returns the current time of the sound channel
		
		`**Returns:** The current time of the stream
    **/
    
    public function GetTime():Float;
    
    
    /**
        Returns 3D cone of the sound channel. See IGModAudioChannel:Set3DCone.
		
		Name | Description
		--- | ---
		`a` | The angle of the inside projection cone in degrees.
		`b` | The angle of the outside projection cone in degrees.
		`c` | The delta-volume outside the outer projection cone.
    **/
    
    public function Get3DCone():IGModAudioChannelGet3DConeReturn;
    
    
    /**
        Enables or disables looping of audio channel, requires noblock flag.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable looping of this audio channel.
    **/
    
    public function EnableLooping(enable:Bool):Void;
    
    
    /**
        Returns the average bit rate of the sound channel.
		
		`**Returns:** The average bit rate of the sound channel.
    **/
    
    public function GetAverageBitRate():Float;
    
    
    /**
        Sets the volume of a sound channel
		
		Name | Description
		--- | ---
		`volume` | Volume to set. 1 meaning 100% volume, 0.5 is 50% and 3 is 300%, etc.
		
		
		___
		### Lua Examples
		#### Example 1
		Plays the a Half-Life 1 sound track at 300% volume
		
		```lua 
		sound.PlayFile( "sound/music/hl1_song20.mp3", "", function( channel )
		    if ( IsValid( channel ) ) then
		        channel:Play()
		        channel:SetVolume( 3 )
		    end
		end )
		```
    **/
    
    public function SetVolume(volume:Float):Void;
    
    
    /**
        Returns the filename for the sound channel.
		
		`**Returns:** The file name. This will not be always what you have put into the sound. PlayURL as first argument.
    **/
    
    public function GetFileName():String;
    
    
    /**
        Returns volume of a sound channel
		
		`**Returns:** The volume of the sound channel
    **/
    
    public function GetVolume():Float;
    
    
    /**
        Returns if the sound channel is looping or not.
		
		`**Returns:** Is looping or not.
    **/
    
    public function IsLooping():Bool;
    
    
    /**
        Returns the state of a sound channel
		
		`**Returns:** The state of the sound channel, see GMOD_CHANNEL_ Enums
    **/
    
    public function GetState():GMOD_CHANNEL;
    
    
    /**
        Returns if the sound channel is valid or not.
		
		`**Returns:** Is the sound channel valid or not
    **/
    
    public function IsValid():Bool;
    
    
    /**
        Returns the right and left levels of sound played by the sound channel.
		
		Name | Description
		--- | ---
		`a` | The left sound level. The value is between 0 and 1.
		`b` | The right sound level. The value is between 0 and 1.
    **/
    
    public function GetLevel():IGModAudioChannelGetLevelReturn;
    
    
    /**
        Stop the stream. It can be started again using IGModAudioChannel:Play.
		
		**Bug:** BUG Calling this invalidates the IGModAudioChannel object rendering it unusable for further functions. Issue Tracker: #1497
    **/
    
    public function Stop():Void;
    
    
}


@:multiReturn extern class IGModAudioChannelGetLevelReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class IGModAudioChannelGet3DFadeDistanceReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class IGModAudioChannelGet3DConeReturn {
var a:Float;
var b:Float;
var c:Float;

}

#end