package gmod.libs;


/**
    The engine library provides functions to access various features in the game's engine, most are related to the demo and save systems.
**/
@:native("_G.engine")extern class EngineLib {
    #if client
    /**
        Returns video recording settings set by video.Record. Used by Demo-To-Video feature.
		
		`**Returns:** The video recording settings, see VideoData structure.
    **/
    
    public static function VideoSettings():VideoData;
    #end
    
    /**
        Returns the number of ticks since the game server started.
		
		`**Returns:** Number of ticks since the game server started.
    **/
    
    public static function TickCount():Float;
    
    #if client
    /**
        Returns total amount of ticks of currently loaded demo. 
		
		If not playing a demo, returns 0 or the value of last played demo.
		
		`**Returns:** Total amount of ticks of currently loaded demo.
    **/
    
    public static function GetDemoPlaybackTotalTicks():Float;
    #end
    #if server
    /**
        Closes the server and completely exits. 
		
		This is only functional when running in server test mode (launch option -systemtest). Server test mode is used internally at Facepunch as part of the build process to make sure that the dedicated servers aren't crashing on startup.
    **/
    
    public static function CloseServer():Void;
    #end
    
    /**
        Sets the mounting options for mountable content.
		
		Name | Description
		--- | ---
		`depotID` | The depot id of the game to mount.
		`doMount` | The mount state, true to mount, false to unmount
    **/
    
    public static function SetMounted(depotID:String, doMount:Bool):Void;
    
    #if client
    /**
        Returns time scale of demo playback. 
		
		If not during demo playback, returns 1.
		
		`**Returns:** The time scale of demo playback, value of demo_timescale console variable.
    **/
    
    public static function GetDemoPlaybackTimeScale():Float;
    #end
    #if client
    /**
        Returns true if the game is currently recording a demo file (.dem) using gm_demo
		
		`**Returns:** Whether the game is currently recording a demo or not.
    **/
    
    public static function IsRecordingDemo():Bool;
    #end
    #if client
    /**
        Loads a duplication from the local filesystem.
		
		Name | Description
		--- | ---
		`dupeName` | Name of the file. e.g, engine.OpenDupe("dupes/8b809dd7a1a9a375e75be01cdc12e61f.dupe")
		
		
		`**Returns:** Compressed dupeData. Use util.JSONToTable to make it into a format useable by the duplicator tool.
    **/
    
    public static function OpenDupe(dupeName:String):String;
    #end
    #if client
    /**
        Returns true if we're currently playing a demo. 
		
		You will notice that there's no server-side version of this. That's because there is no server when playing a demo. Demos are both recorded and played back purely clientside.
		
		`**Returns:** Whether the game is currently playing a demo or not.
    **/
    
    public static function IsPlayingDemo():Bool;
    #end
    
    /**
        ***Deprecated:** Used internally for in-game menus, may be merged in the future into engine. GetAddons.
		
		Returns the UGC (demos, saves and dupes) the player have subscribed to on the workshop.
		
		`**Returns:** Returns a table with 6 keys (title, type, tags, wsid, timeadded)
    **/
    @:deprecated("Used internally for in-game menus, may be merged in the future into engine. GetAddons.")
    public static function GetUserContent():AnyTable;
    
    
    /**
        Returns a list of addons the player have subscribed to on the workshop. This list will also include "Floating" .gma addons that are mounted by the game.
		
		`**Returns:** A table with 6 keys (downloaded, models, title, file, mounted, wsid)
		
		___
		### Lua Examples
		#### Example 1
		Will return a list of all the workshop addons you have downloaded / are downloading.
		
		```lua 
		PrintTable(engine.GetAddons())
		```
		**Output:**
		
		1:
				downloaded	=	true 
				models		=	0 
				title		=	Title of Addon 
				file		=	addons/title_of_addon_123456789.gma 
				mounted		=	true
				wsid		=	123456789
    **/
    
    public static function GetAddons():AnyTable;
    
    #if server
    /**
        This is a direct binding to the function “engine->LightStyle”. This function allows you to change the default light style of the map - so you can make lighting lighter or darker. You’ll need to call render.RedownloadAllLightmaps clientside to refresh the lightmaps to this new color.
		
		**Bug:** BUG Calling this function with arguments 0 and "a" will cause dynamic lights such as those produced by the Light tool to stop working. Issue Tracker: #3626
		
		Name | Description
		--- | ---
		`lightstyle` | The lightstyle to edit. 0 to 63. If you want to edit map lighting, you want to set this to 0.
		`pattern` | The pattern to change the lightstyle to. "a" is the darkest, "z" is the brightest. You can use stuff like "abcxyz" to make flashing patterns. The normal brightness for a map is "m". Values over "z" are allowed, "~" for instance.
    **/
    
    public static function LightStyle(lightstyle:Float, pattern:String):Void;
    #end
    
    /**
        Returns the name of the currently running gamemode.
		
		**Bug:** BUG This will return the incorrect gamemode name on the client if used too early. Issue Tracker: #1988
		
		`**Returns:** The active gamemode's name. This is the name of the gamemode's folder.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the name of the active gamemode.
		
		```lua 
		print( engine.ActiveGamemode() )
		```
    **/
    
    public static function ActiveGamemode():String;
    
    
    /**
        Returns a table containing info for all installed gamemodes
		
		`**Returns:** gamemodes
		
		___
		### Lua Examples
		#### Example 1
		Prints out a list of gamemodes and various info
		
		```lua 
		PrintTable( engine.GetGamemodes() )
		```
		**Output:**
		
		1:
		 title = Base
		 workshopid = 
		 menusystem = false
		 maps = 
		 name = base
		2:
		 title = Sandbox
		 workshopid = 
		 menusystem = true
		 maps = ^gm_| ^gmod_
		 name = sandbox
    **/
    
    public static function GetGamemodes():AnyTable;
    
    #if client
    /**
        Stores savedata into the game (can be loaded using the LoadGame menu)
		
		Name | Description
		--- | ---
		`saveData` | Data generated by gmsave.SaveMap
		`name` | Name the save will have.
		`time` | When the save was saved during the game (Put CurTime here)
		`map` | The map the save is used for.
    **/
    
    public static function WriteSave(saveData:String, name:String, time:Float, map:String):Void;
    #end
    
    /**
        Returns the number of seconds between each gametick.
		
		`**Returns:** Number of seconds between each gametick.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		print(1 / engine.TickInterval())
		```
		**Output:**
		
		66.666668156783 (servertick is 66)
    **/
    
    public static function TickInterval():Float;
    
    #if client
    /**
        When starting playing a demo, engine.GetDemoPlaybackTick will be reset and its old value will be added to this functions return value.
		
		`**Returns:** 
    **/
    
    public static function GetDemoPlaybackStartTick():Float;
    #end
    #if client
    /**
        Current tick of currently loaded demo. 
		
		If not playing a demo, it will return amount of ticks since last demo playback.
		
		`**Returns:** The amount of ticks of currently loaded demo.
    **/
    
    public static function GetDemoPlaybackTick():Float;
    #end
    
    /**
        Returns an array of tables corresponding to all games from which Garry's Mod supports mounting content.
		
		`**Returns:** A table of tables containing all mountable games
		
		___
		### Lua Examples
		#### Example 1
		Prints out a list of games, their Steam AppIds, titles and status (owned, installed, mounted).
		
		```lua 
		PrintTable( engine.GetGames() )
		```
		**Output:**
		
		1:
		 depot = 220
		 title = Half-Life 2
		 owned = true
		 folder = hl2
		 mounted = true
		 installed = true
		2:
		 depot = 240
		 title = Counter-Strike
		 owned = false
		 folder = cstrike
		 mounted = false
		 installed = false
		3:
		 depot = 300
		 title = Day of Defeat
		 owned = false
		 folder = dod
		 mounted = false
		 installed = false
		4:
		 depot = 440
		 title = Team Fortress 2
		 owned = true
		 folder = tf
		 mounted = true
		 installed = true
    **/
    
    public static function GetGames():AnyTable;
    
    #if client
    /**
        Saves a duplication as a file.
		
		Name | Description
		--- | ---
		`dupe` | Dupe table, encoded by util. TableToJSON and compressed by util. Compress
		`jpeg` | The dupe icon, created by render. Capture
    **/
    
    public static function WriteDupe(dupe:String, jpeg:String):Void;
    #end
    #if client
    /**
        Returns an estimate of the server's performance. Equivalent to calling FrameTime from the server, according to source code.
		
		Name | Description
		--- | ---
		`a` | Frame time
		`b` | Server Framerate Std Deviation
		
		
		___
		### Lua Examples
		#### Example 1
		Get the servers tickrate. Can be used to indicate lag
		
		```lua 
		print("Server Tick: "..(1/engine.ServerFrameTime()))
		```
		**Output:**
		
		Server Tick: 66.666668156783
    **/
    
    public static function ServerFrameTime():EngineLibServerFrameTimeReturn;
    #end
    

}


@:multiReturn extern class EngineLibServerFrameTimeReturn {
var a:Float;
var b:Float;

}

