package gmod.libs;


/**
    The game library provides functions to access various features in the game's engine, most of it's functions are related to controlling the map.
**/
@:native("_G.game")extern class GameLib {
    
    /**
        Returns the ammo bullet force that is applied when an entity is hit by a bullet of given ammo type.
		
		Name | Description
		--- | ---
		`id` | Ammo ID to retrieve the force of. Starts from 1.
		
		
		`**Returns:** 
    **/
    
    public static function GetAmmoForce(id:Float):Float;
    
    
    /**
        Registers a new decal.
		
		**Warning:** There's a rather low limit of around 256 for decals that may be registered and they are not cleared on map load.
		
		Name | Description
		--- | ---
		`decalName` | The name of the decal.
		`materialName` | The material to be used for the decal. May also be a list of material names, in which case a random material from that list will be chosen every time the decal is placed.
    **/
    
    public static function AddDecal(decalName:String, materialName:String):Void;
    
    
    /**
        Returns the VBSP version of the current map.
		
		`**Returns:** mapVersion
    **/
    
    public static function GetMapVersion():Float;
    
    
    /**
        ***INTERNAL** Consider using game. GetAmmoTypes and game. GetAmmoData instead.
		
		Called by the engine to retrieve the ammo types.
		
		`**Returns:** All ammo types registered via game. AddAmmoType, sorted by its name value.
    **/
    @:deprecated("INTERNAL: Consider using game. GetAmmoTypes and game. GetAmmoData instead.")
    public static function BuildAmmoTypes():AnyTable;
    
    
    /**
        Returns the public IP address and port of the current server. This will return the IP/port that you are connecting through when ran clientside.
		
		**Note:** Returns "0.0.0.0:0" in singleplayer.
		
		**Bug:** BUG Returns "0.0.0.0:port" on the server when called too early, including in GM:Initialize and GM:InitPostEntity. This bug seems to only happen the first time a server is launched, and will return the correct value after switching maps. Issue Tracker: #3001
		
		`**Returns:** The IP address and port in the format "x.x.x.x:x"
    **/
    
    public static function GetIPAddress():String;
    
    
    /**
        Adds a new ammo type to the game. 
		
		You can find a list of default ammo types here.
		
		**Warning:** This function must be called shared or you will have unexpected problems.
		
		**Note:** This function must be called in GM:Initialize.
		
		**Note:** There is a limit of 128 ammo types, including the default ones.
		
		**Bug:** BUG This will have unpredictable results when registering ammo types with the same name but different capitalisation. Pull Request: #1487
		
		Name | Description
		--- | ---
		`ammoData` | The attributes of the ammo. See the AmmoData structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Add an ammo type
		
		```lua 
		game.AddAmmoType({
		    name = "ammo_9mm_max",
		    dmgtype = DMG_BULLET,
		    tracer = TRACER_LINE,
		    plydmg = 0,
		    npcdmg = 0,
		    force = 2000,
		    minsplash = 10,
		    maxsplash = 5
		})
		```
    **/
    
    public static function AddAmmoType(ammoData:AmmoData):Void;
    
    #if server
    /**
        Returns whether a Global State is off, active or dead ( inactive ) 
		
		See Global States for more information.
		
		Name | Description
		--- | ---
		`name` | The name of the Global State to retrieve the state of. If the Global State by that name does not exist, GLOBAL_DEAD will be returned. See Global States for a list of default global states.
		
		
		`**Returns:** The state of the Global State. See GLOBAL_ Enums
    **/
    
    public static function GetGlobalState(name:String):GLOBAL;
    #end
    
    /**
        Returns whenever the current session is a single player game.
		
		`**Returns:** isSinglePlayer
    **/
    
    public static function SinglePlayer():Bool;
    
    
    /**
        Returns the worldspawn entity.
		
		`**Returns:** The world
    **/
    
    public static function GetWorld():Entity;
    
    
    /**
        Returns the damage type of given ammo type.
		
		Name | Description
		--- | ---
		`id` | Ammo ID to retrieve the damage type of. Starts from 1.
		
		
		`**Returns:** See DMG_ Enums
    **/
    
    public static function GetAmmoDamageType(id:Float):DMG;
    
    #if server
    /**
        Returns the next map that would be loaded according to the file that is set by the mapcyclefile convar.
		
		`**Returns:** nextMap
    **/
    
    public static function GetMapNext():String;
    #end
    #if server
    /**
        Sets the difficulty level of the game, can be retrieved with game.GetSkillLevel. 
		
		This will automatically change whenever the "skill" convar is modified serverside.
		
		**Bug:** BUG This function will not work if the skill convar doesn't match the targeted value. To work around this, you must use RunConsoleCommand("skill", num) alongside this function. Issue Tracker: #3491
		
		Name | Description
		--- | ---
		`level` | The difficulty level, Easy( 1 ), Normal( 2 ), Hard( 3 ).
    **/
    
    public static function SetSkillLevel(level:Float):Void;
    #end
    
    /**
        Returns the ammo name for given ammo type ID. 
		
		See game.GetAmmoID for reverse.
		
		Name | Description
		--- | ---
		`id` | Ammo ID to retrieve the name of. Starts from 1.
		
		
		`**Returns:** The name of given ammo type ID or nil if ammo type ID is invalid.
    **/
    
    public static function GetAmmoName(id:Float):String;
    
    #if server
    /**
        Sets the time scale of the game. 
		
		This function is supposed to remove the need of using the host_timescale convar, which is cheat protected. 
		
		 To slow down or speed up the movement of a specific player, use Player:SetLaggedMovementValue instead.
		
		**Note:** Like host_timescale, this method does not affect sounds, if you wish to change that, look into GM:EntityEmitSound.
		
		Name | Description
		--- | ---
		`timeScale` | The new timescale, minimum value is 0.001 and maximum is 5.
    **/
    
    public static function SetTimeScale(timeScale:Float):Void;
    #end
    
    /**
        Returns the real maximum amount of ammo of given ammo ID.
		
		**Note:** Currently all ammo types have overridden maximum value of reserve ammo set to 9999.
		
		Name | Description
		--- | ---
		`id` | Ammo type ID
		
		
		`**Returns:** The maximum amount of reserve ammo a player can hold of this ammo type.
    **/
    
    public static function GetAmmoMax(id:Float):Float;
    
    #if server
    /**
        Loads the next map according to the nextlevel convar, or from the current mapcycle file set by the respective convar.
    **/
    
    public static function LoadNextMap():Void;
    #end
    
    /**
        Returns the ammo type ID for given ammo type name. 
		
		See game.GetAmmoName for reverse.
		
		Name | Description
		--- | ---
		`name` | Name of the ammo type to look up ID of
		
		
		`**Returns:** The ammo type ID of given ammo type name, or -1 if not found
    **/
    
    public static function GetAmmoID(name:String):Float;
    
    
    /**
        Removes all the clientside ragdolls.
		
		___
		### Lua Examples
		#### Example 1
		This will remove all the client ragdolls every 3 secconds.
		
		```lua 
		timer.Create( "removeRagdolls", 3, 0, function() game.RemoveRagdolls() end )
		```
    **/
    
    public static function RemoveRagdolls():Void;
    
    
    /**
        Returns the name of the current map, without a file extension. On the menu state, returns "menu".
		
		`**Returns:** The name of the current map, without a file extension.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		print(game.GetMap())
		```
		**Output:**
		
		gm_flatgrass
    **/
    
    public static function GetMap():String;
    
    #if server
    /**
        Kicks a player from the server. This can be ran before the player has spawned.
		
		Name | Description
		--- | ---
		`id` | UserID or SteamID of the player to kick.
		`reason` | Reason to display to the player. This can span across multiple lines.
    **/
    
    public static function KickID(id:String, ?reason:String):Void;
    #end
    #if server
    /**
        Sets the counter of a Global State. 
		
		See Global States for more information.
		
		Name | Description
		--- | ---
		`name` | The name of the Global State to set. If the Global State by that name does not exist, it will be created. See Global States for a list of default global states.
		`count` | The value to set for that Global State.
    **/
    
    public static function SetGlobalCounter(name:String, count:Float):Void;
    #end
    
    /**
        Loads a particle file.
		
		**Note:** You will still need to call this function clientside regardless if you create the particle effects serverside.
		
		Name | Description
		--- | ---
		`particleFileName` | The path of the file to add. Must be (file).pcf.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function. Precaches "ExplosionCore_wall" particle from "particles/explosion.pcf", a Team Fortress 2 particle file.You can find a list of particles inside a .pcf file using the Particle Editor Tool
		
		```lua 
		game.AddParticles( "particles/explosion.pcf" )
		PrecacheParticleSystem( "ExplosionCore_wall" )
		
		if ( SERVER ) then
		    -- A test console command to see if the particle works, spawns the particle where the player is looking at. 
		    concommand.Add( "particleitup", function( ply, cmd, args )
		        ParticleEffect( "ExplosionCore_wall", ply:GetEyeTrace().HitPos, Angle( 0, 0, 0 ) )
		    end )
		end
		```
    **/
    
    public static function AddParticles(particleFileName:String):Void;
    
    #if server
    /**
        Sets whether a Global State is off, active or dead ( inactive ) 
		
		See Global States for more information.
		
		Name | Description
		--- | ---
		`name` | The name of the Global State to set. If the Global State by that name does not exist, it will be created. See Global States for a list of default global states.
		`state` | The state of the Global State. See GLOBAL_ Enums
    **/
    
    public static function SetGlobalState(name:String, state:GLOBAL):Void;
    #end
    
    /**
        Returns the damage given ammo type should do to NPCs.
		
		Name | Description
		--- | ---
		`id` | Ammo ID to retrieve the damage info of. Starts from 1.
		
		
		`**Returns:** 
    **/
    
    public static function GetAmmoNPCDamage(id:Float):Float;
    
    #if server
    /**
        Runs a console command. Make sure to add a newline ("\n") at the end of the command.
		
		**Warning:** If you use data that were received from a client, you should avoid using this function because newline and semicolon (at least) allow the client to run arbitrary commands! For safety, you are urged to prefer using RunConsoleCommand in this case.
		
		Name | Description
		--- | ---
		`stringCommand` | String containing the command and arguments to be ran.
		
		
		___
		### Lua Examples
		#### Example 1
		Changes the gravity to 400 (default 600).
		
		```lua 
		game.ConsoleCommand("sv_gravity 400\n")
		```
    **/
    
    public static function ConsoleCommand(stringCommand:String):Void;
    #end
    
    /**
        Returns true if the server is a dedicated server, false if it is a Listen server or a singleplayer game.
		
		**Bug:** BUG This always returns false on the client. Issue Tracker: #1495
		
		`**Returns:** Is the server dedicated or not.
    **/
    
    public static function IsDedicated():Bool;
    
    
    /**
        Returns position the player should start from, this is not the same thing as spawn points, it is used to properly transit the player between maps.
		
		`**Returns:** startSpot
    **/
    
    public static function StartSpot():Vector;
    
    #if server
    /**
        Returns the counter of a Global State. 
		
		See Global States for more information.
		
		Name | Description
		--- | ---
		`name` | The name of the Global State to set. If the Global State by that name does not exist, it will be created. See Global States for a list of default global states.
		
		
		`**Returns:** The value of the given Global State, 0 if the global state doesn't exist.
    **/
    
    public static function GetGlobalCounter(name:String):Float;
    #end
    #if server
    /**
        Returns the map load type of the current map. 
		
		After changing the map with the console command changelevel, "newgame" is returned. With changelevel2 (single player only), "transition" is returned.
		
		`**Returns:** The load type. Possible values are: "newgame", "loadgame", "transition", "background".
    **/
    
    public static function MapLoadType():String;
    #end
    
    /**
        Returns the AmmoData structure for given ID.
		
		Name | Description
		--- | ---
		`id` | ID of the ammo type to look up the data for
		
		
		`**Returns:** The AmmoData structure containing all ammo data
    **/
    
    public static function GetAmmoData(id:Float):AmmoData;
    
    
    /**
        Returns the difficulty level of the game. 
		
		TIP: You can use this function in your scripted NPCs or Nextbots to make them harder, however, it is a good idea to lock powerful attacks behind the highest difficulty instead of just increasing the health.
		
		**Note:** Internally this is tied to the gamerules entity, so you'll have to wait to wait until GM:InitPostEntity is called to return the skill level
		
		`**Returns:** The difficulty level, Easy( 1 ), Normal( 2 ), Hard( 3 ).
    **/
    
    public static function GetSkillLevel():Float;
    
    
    /**
        Mounts a GMA addon from the disk. Any error models currently loaded that the mounted addon provides will be reloaded. 
		
		Can be used with steamworks.Download
		
		Name | Description
		--- | ---
		`path` | Location of the GMA file to mount, relative to the garrysmod directory
		
		
		Name | Description
		--- | ---
		`a` | success
		`b` | If successful, a table of files that have been mounted
		
		
		___
		### Lua Examples
		#### Example 1
		Downloads the Playable Piano addon and mounts the content.
		
		```lua 
		steamworks.FileInfo( 104548572, function( result )
		    steamworks.Download( result.fileid, true, function( name )
		        game.MountGMA( name )
		    end) 
		end)
		```
    **/
    
    public static function MountGMA(path:String):GameLibMountGMAReturn;
    
    
    /**
        If called serverside it will remove ALL entities which were not created by the map(not players or weapons held by players). 
		
		On the client it will remove decals, sounds, gibs, dead NPCs, and entities created via ents.CreateClientProp. 
		
		 This function calls GM:PreCleanupMap before cleaning up the map and GM:PostCleanupMap after cleaning up the map.
		
		**Bug:** BUG Calling this in a ENTITY:StartTouch or ENTITY:Touch hook will crash the game. Issue Tracker: #1142
		
		**Bug:** BUG Calling this destroys all BASS streams. Issue Tracker: #2874
		
		**Bug:** BUG This can crash when removing _firesmoke entities. Issue Tracker: #3637
		
		Name | Description
		--- | ---
		`dontSendToClients` | If set to true, don't run this functions on all clients.
		`ExtraFilters` | Entity classes not to reset during cleanup.
    **/
    
    public static function CleanUpMap(?dontSendToClients:Bool, ?ExtraFilters:AnyTable):Void;
    
    
    /**
        Returns the maximum amount of players (including bots) that the server can have.
		
		`**Returns:** The maximum amount of players
    **/
    
    public static function MaxPlayers():Float;
    
    
    /**
        Returns the time scale of the game
		
		`**Returns:** The time scale
    **/
    
    public static function GetTimeScale():Float;
    
    
    /**
        Returns a list of all ammo types currently registered.
		
		`**Returns:** A table containing all ammo types. The keys are ammo IDs, the values are the names associated with those IDs.
    **/
    
    public static function GetAmmoTypes():AnyTable;
    
    
    /**
        Returns the damage given ammo type should do to players.
		
		Name | Description
		--- | ---
		`id` | Ammo ID to retrieve the damage info of. Starts from 1.
		
		
		`**Returns:** 
    **/
    
    public static function GetAmmoPlayerDamage(id:Float):Float;
    
    

}


@:multiReturn extern class GameLibMountGMAReturn {
var a:Bool;
var b:AnyTable;

}

