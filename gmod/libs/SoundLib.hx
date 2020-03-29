package gmod.libs;


/**
    Used primarily for adding new soundscript entries.
**/
@:native("_G.sound")extern class SoundLib {
    
    /**
        Overrides sounds defined inside of a txt file; typically used for adding map-specific sounds.
		
		Name | Description
		--- | ---
		`filepath` | Path to the script file to load.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds and overrides all sounds defined in scripts/override_test.txt
		
		```lua 
		sound.AddSoundOverrides("scripts/override_test.txt")
		```
		**Output:**
		
		SoundEmitter: adding map sound overrides from scripts/override_test.txt [1 total, 1 replacements, 0 duplicated replacements] (Displayed in the console)
    **/
    
    public static function AddSoundOverrides(filepath:String):Void;
    
    
    /**
        Creates a sound script. It can also override sounds, which seems to only work when set on the server.
		
		Name | Description
		--- | ---
		`soundData` | The sounds properties. See SoundData structure
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a sound script. It will automatically vary in pitch and be played in a given audio channel to better control which sounds mix with which sounds and how.In this example, the file location could be: ( Choose one )garrysmod/sound/vehicles/enzo/idle.wav garrysmod/gamemodes/MyCoolGameMode/content/sound/vehicles/enzo/idle.wav garrysmod/addons/myCoolAddon/sound/vehicles/enzo/idle.wav garrysmod/addons/myCoolAddon/gamemodes/MyCoolGameMode/content/sound/vehicles/enzo/idle.wav
		
		```lua 
		sound.Add( {
		    name = "enzo_engine_idle",
		    channel = CHAN_STATIC,
		    volume = 1.0,
		    level = 80,
		    pitch = {95, 110},
		    sound = "vehicles/enzo/idle.wav"
		} )
		```
		**Output:**
		
		You can now play your custom sound script with Entity: EmitSound like so: Entity( 1 ):EmitSound( "enzo_engine_idle" )
    **/
    
    public static function Add(soundData:SoundData):Void;
    
    
    /**
        Plays a sound from the specified position in the world. If you want to play a sound without a position, such as a UI sound, use surface.PlaySound instead.
		
		Name | Description
		--- | ---
		`Name` | A string path to the sound.
		`Pos` | A vector describing where the sound should play.
		`Level` | Sound level in decibels. 75 is normal. Ranges from 20 to 180, where 180 is super loud. This affects how far away the sound will be heard.
		`Pitch` | An integer describing the sound pitch. Range is from 0 to 255. 100 is normal pitch.
		`Volume` | A float ranging from 0-1 describing the output volume of the sound.
		
		
		___
		### Lua Examples
		#### Example 1
		Plays an explosion sound at the (0, 0, 0) map coordinates.
		
		```lua 
		sound.Play( "ambient/explosions/exp1.wav", Vector(0, 0, 0) )
		```
    **/
    
    public static function Play(Name:String, Pos:Vector, Level:Float, Pitch:Float, Volume:Float):Void;
    
    #if client
    /**
        Plays a file from GMod directory. You can find a list of all error codes here 
		
		For external file/stream playback, see sound.PlayURL.
		
		**Bug:** BUG This fails for looping .wav files in 3D mode. Issue Tracker: #1752
		
		**Bug:** BUG This fails with unicode file names. Issue Tracker: #2304
		
		Name | Description
		--- | ---
		`path` | The path to the file to play. Unlike other sound functions and structures, the path is relative to garrysmod/ instead of garrysmod/sound/
		`flags` | Flags for the sound. Can be one or more of following, separated by a space (" "): 3d - Makes the sound 3D, so you can set its position mono - Forces the sound to have only one channel noplay - Forces the sound not to play as soon as this function is called noblock - Disables streaming in blocks. It is more resource-intensive, but it is required for IGModAudioChannel:SetTime. If you don't want to use any of the above, you can just leave it as "".
		`callback` | Callback function that is called as soon as the the stream is loaded. It has next arguments: IGModAudioChannel soundchannel - The sound channel. Will be nil if an error occured. number errorID - ID of an error if an error has occured. Will be nil, otherwise. string errorName - Name of an error if an error has occured. Will be nil, otherwise.
		
		
		___
		### Lua Examples
		#### Example 1
		Plays a piece of music from Half-Life 2.
		
		```lua 
		sound.PlayFile( "sound/music/hl2_song12_long.mp3", "noplay", function( station, errCode, errStr )
		    if ( IsValid( station ) ) then
		        station:Play()
		    else
		        print( "Error playing sound!", errCode, errStr )
		    end
		end )
		```
    **/
    
    public static function PlayFile(path:String, flags:String, callback:Function):Void;
    #end
    
    /**
        Returns a list of all registered sound scripts.
		
		`**Returns:** The list/array of all registered sound scripts ( No other information is provided )
		
		___
		### Lua Examples
		#### Example 1
		Writes all the sound scripts to a file in the data folder for easy searching.
		
		```lua 
		file.Write("soundscripts.txt",table.concat(sound.GetTable(),"\n"))
		```
		**Output:**
		
		data/soundscripts.txt: ...
		Event.HostageKilled
		PhxMetal.ImpactHard
		PhxMetal.ImpactSoft
		EpicMetal.ImpactHard
		EpicMetal.ImpactSoft
		EpicMetal_Heavy.ImpactHard
		EpicMetal_Heavy.ImpactSoft
		Egg.Crack
		Phx.HoverLight
		Phx.HoverStandard
		Phx.HoverHeavy
		Phx.Afterburner1
		Phx.Afterburner2
		Phx.Afterburner3
		Phx.Afterburner4
		Phx.Afterburner5
		Phx.Turbine
		Phx.Alien1
		Phx.Alien2
		Phx.Jet1
		Phx.Jet2
		Phx.Jet3
		Phx.Jet4
		Phx_Rubber_Tire.Strain
		Explo.ww2bomb
		AI_BaseNPC.BodyDrop_Heavy
		AI_BaseNPC.BodyDrop_Light
		AI_BaseNPC.SwishSound
		AI_BaseNPC.SentenceStop
		BaseCombatCharacter.CorpseGib
		BaseCombatCharacter.StopWeaponSounds
		BaseCombatCharacter.AmmoPickup
		...
    **/
    
    public static function GetTable():AnyTable;
    
    
    /**
        Returns properties of the soundscript.
		
		Name | Description
		--- | ---
		`name` | The name of the sound script
		
		
		`**Returns:** The properties of the soundscript. See SoundData structure
    **/
    
    public static function GetProperties(name:String):SoundData;
    
    #if client
    /**
        Creates a sound from a function.
		
		**Bug:** BUG This function cannot generate sounds that have a duration of less than 1 second. Issue Tracker: #3360
		
		Name | Description
		--- | ---
		`indentifier` | An unique identified for the sound. You cannot override already existing ones.
		`samplerate` | The sample rate of the sound. Must be 11025, 22050 or 44100.
		`length` | The length in seconds of the sound to generate.
		`callback` | A function which will be called to generate every sample on the sound. This function gets the current sample number passed as the first argument. The return value must be between -1.0 and 1.0. Other values will wrap back to the -1 to 1 range and basically clip. There are 65535 possible quantifiable values between -1 and 1.
		
		
		___
		### Lua Examples
		#### Example 1
		Plays a 2000 Hz sine wave at maximum volume
		
		```lua 
		local frequency = 2000 -- Hz
		local samplerate = 44100
		
		local function data(t)
		    return math.sin( t * math.pi * 2 / samplerate * frequency )
		end
		
		test_sound_id = test_sound_id and test_sound_id + 1 or 10
		
		sound.Generate   ("testgen" .. test_sound_id, samplerate, 2, data)
		surface.PlaySound("testgen" .. test_sound_id)
		```
    **/
    
    public static function Generate(indentifier:String, samplerate:Float, length:Float, callback:Function):Void;
    #end
    #if client
    /**
        Allows you to play external sound files, as well as online radio streams. You can find a list of all error codes here 
		
		For offline file playback, see sound.PlayFile.
		
		**Bug:** BUG Due to a bug with BASS, AAC codec streams cannot be played in 3D mode. Issue Tracker: #2296
		
		Name | Description
		--- | ---
		`url` | The URL of the sound to play
		`flags` | Flags for the sound. Can be one or more of following, separated by a space (" "): 3d - Makes the sound 3D, so you can set its position mono - Forces the sound to have only one channel noplay - Forces the sound not to play as soon as this function is called noblock - Disables streaming in blocks. It is more resource-intensive, but it is required for IGModAudioChannel:SetTime. If you don't want to use any of the above, you can just leave it as "".
		`callback` | Callback function that is called as soon as the the stream is loaded. It has next arguments: IGModAudioChannel soundchannel - The sound channel number errorID - ID of an error, if an error has occured string errorName - Name of an error, if an error has occured
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function.
		
		```lua 
		sound.PlayURL ( "URL", "3d", function( station )
		    if ( IsValid( station ) ) then
		
		        station:SetPos( LocalPlayer():GetPos() )
		    
		        station:Play()
		
		    else
		
		        LocalPlayer():ChatPrint( "Invalid URL!" )
		
		    end
		end )
		```
    **/
    
    public static function PlayURL(url:String, flags:String, callback:Function):Void;
    #end
    

}



