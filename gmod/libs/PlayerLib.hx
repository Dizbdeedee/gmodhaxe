package gmod.libs;


/**
    The player library is used to get the Lua objects that represent players in-game.
**/
@:native("_G.player")extern class PlayerLib {
    
    /**
        Gets all the current players in the server (not including connecting clients).
		
		**Note:** This function returns bots as well as human players. See player.GetBots and player.GetHumans.
		
		`**Returns:** All Players currently in the server.
		
		___
		### Lua Examples
		#### Example 1
		Prints all the players currently in the server.
		
		```lua 
		PrintTable( player.GetAll() )
		```
		
		#### Example 2
		Prints the number of players in the server. The same output can be achieved more efficiently with player.GetCount.
		
		```lua 
		print(#player.GetAll())
		```
    **/
    
    public static function GetAll():Table<Int,Player>;
    
    #if server
    /**
        Similar to the serverside command "bot", this function creates a new Player bot with the given name. This bot will not obey to the usual "bot_*" commands, and it's the same bot base used in TF2 and CS:S. 
		
		The best way to control the behaviour of a Player bot right now is to use the GM:StartCommand hook and modify its input serverside.
		
		**Note:** Despite this Player being fake, it has to be removed from the server by using Player:Kick and NOT Entity:Remove. Also keep in mind that these bots still use player slots, so you won't be able to spawn them in singleplayer!
		
		**Note:** Any Bot created using this method will be considered UnAuthed by Garry's Mod
		
		Name | Description
		--- | ---
		`botName` | The name of the bot, using an already existing name will append brackets at the end of it with a number pertaining it. Example: "Bot name test", "Bot name test(1)".
		
		
		`**Returns:** The newly created Player bot. Returns NULL if there's no Player slots available to host it.
		
		___
		### Lua Examples
		#### Example 1
		Create a bot if that is possible.
		
		```lua 
		local listBots = {}
		
		function CreateBot()
		
		    if ( !game.SinglePlayer() && player.GetCount() < game.MaxPlayers() ) then 
		
		        local num = #listBots
		
		        listBots[ num ] = player.CreateNextBot("Bot_" .. ( num + 1 ) )
		
		        return listBots[ num ]
		
		    else
		
		        print( "Can't create bot!" )
		
		    end
		
		end
		```
    **/
    
    public static function CreateNextBot(botName:String):Null<Player>;
    #end
    
    /**
        Gets the player with the specified SteamID64.
		
		Name | Description
		--- | ---
		`steamID64` | The Player: SteamID64 to find the player by. Also accepts numbers.
		
		
		`**Returns:** Player if one is found, false otherwise.
    **/
    
    public static function GetBySteamID64(steamID64:String):Null<Player>;
    
    
    /**
        Gets the player with the specified connection ID. 
		
		Connection ID can be retrieved via gameevent.Listen events. 
		
		 For a function that returns a player based on their Entity:EntIndex, see Entity. For a function that returns a player based on their Player:UserID, see Player.
		
		Name | Description
		--- | ---
		`connectionID` | The connection ID to find the player by.
		
		
		`**Returns:** Player if one is found, nil otherwise
    **/
    
    public static function GetByID(connectionID:Int):Null<Player>;
    
    
    /**
        Returns a table of all bots on the server.
		
		`**Returns:** A table only containing bots ( AI / non human players )
    **/
    
    public static function GetBots():Table<Int,Player>;
    
    
    /**
        Gives you the player count. Similar to #player.GetAll but with much better performance.
		
		`**Returns:** Number of players
    **/
    
    public static function GetCount():Int;
    
    
    /**
        Gets the player with the specified AccountID.
		
		Name | Description
		--- | ---
		`accountID` | The Player: AccountID to find the player by.
		
		
		`**Returns:** Player if one is found, false otherwise.
    **/
    
    public static function GetByAccountID(accountID:String):EitherType<Player,Bool>;
    
    
    /**
        Returns a table of all human ( non bot/AI ) players. 
		
		Unlike player.GetAll, this does not include bots.
		
		`**Returns:** A table of all human ( non bot/AI ) players.
    **/
    
    public static function GetHumans():Table<Int,Player>;
    
    
    /**
        Gets the player with the specified SteamID.
		
		Name | Description
		--- | ---
		`steamID` | The Player: SteamID to find the player by.
		
		
		`**Returns:** Player if one is found, false otherwise.
    **/
    
    public static function GetBySteamID(steamID:String):EitherType<Player,Bool>;
    
    
    /**
        Gets the player with the specified uniqueID (not recommended way to identify players).
		
		**Warning:** It is highly recommended to use player.GetByAccountID, player.GetBySteamID or player.GetBySteamID64 instead as this function can have collisions ( be same for different people ) while SteamID is guaranteed to unique to each player.
		
		Name | Description
		--- | ---
		`uniqueID` | The Player: UniqueID to find the player by.
		
		
		`**Returns:** Player if one is found, false otherwise.
    **/
    
    public static function GetByUniqueID(uniqueID:String):EitherType<Player,Bool>;
    
    

}



