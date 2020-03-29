package gmod.libs;


/**
    The player_manager library lets you manage players, such as setting their models or creating player classes.
**/
@:native("_G.player_manager")extern class Player_managerLib {
    
    /**
        Assigns view model hands to player model.
		
		Name | Description
		--- | ---
		`name` | Player model name
		`model` | Hands model
		`skin` | Skin to apply to the hands
		`bodygroups` | Bodygroups to apply to the hands
		
		
		___
		### Lua Examples
		#### Example 1
		Adds CS:S hands for hostage playermodels
		
		```lua 
		player_manager.AddValidHands( "hostage01", "models/weapons/c_arms_cstrike.mdl", 0, "10000000" )
		player_manager.AddValidHands( "hostage02", "models/weapons/c_arms_cstrike.mdl", 0, "10000000" )
		player_manager.AddValidHands( "hostage03", "models/weapons/c_arms_cstrike.mdl", 0, "10000000" )
		player_manager.AddValidHands( "hostage04", "models/weapons/c_arms_cstrike.mdl", 0, "10000000" )
		```
    **/
    
    public static function AddValidHands(name:String, model:String, skin:Float, bodygroups:String):Void;
    
    
    /**
        Returns the valid model path for a simplified name.
		
		Name | Description
		--- | ---
		`shortName` | The short name of the model.
		
		
		`**Returns:** The valid model path for the short name.
		
		___
		### Lua Examples
		#### Example 1
		Print the valid model path for "Alyx".
		
		```lua 
		print(player_manager.TranslatePlayerModel("alyx"))
		```
		**Output:**
		
		Console outputs: "models/player/alyx.mdl"
    **/
    
    public static function TranslatePlayerModel(shortName:String):String;
    
    
    /**
        Returns the entire list of valid player models.
		
		___
		### Lua Examples
		#### Example 1
		Store the list of valid player models in a local variable, and print the valid model path for "Alyx"
		
		```lua 
		local models = player_manager.AllValidModels()
		print(models["alyx"])
		```
		**Output:**
		
		Console outputs: "models/player/alyx.mdl"
    **/
    
    public static function AllValidModels():Void;
    
    
    /**
        Register a class metatable to be assigned to players later
		
		Name | Description
		--- | ---
		`name` | Class name
		`table` | Class metatable
		`base` | Base class name
		
		
		___
		### Lua Examples
		#### Example 1
		A quick look at registering a class table
		
		```lua 
		local PLAYER = {}
		
		PLAYER.DisplayName = "Default Class"
		
		...
		
		player_manager.RegisterClass( "player_default", PLAYER, nil )
		```
		
		#### Example 2
		You can retrieve the data you've set when registering the table using baseclass.Get( "<classname>" )
		
		```lua 
		PrintTable(baseclass.Get( "player_default" ))
		```
		**Output:**
		
		Walkspeed = 300 RunSpeed = 500 CalcView = function: 0x00665988 UseVMHands = true etc...
    **/
    
    public static function RegisterClass(name:String, table:AnyTable, base:String):Void;
    
    
    /**
        Clears a player's class association by setting their ClassID to 0
		
		Name | Description
		--- | ---
		`ply` | Player to clear class from
		
		
		___
		### Lua Examples
		#### Example 1
		Source for player_manager.ClearPlayerClass (from lua/includes/modules/player_manager.lua)
		
		```lua 
		function ClearPlayerClass( ply )
		
		    ply:SetClassID( 0 )
		
		end
		```
    **/
    
    public static function ClearPlayerClass(ply:Player):Void;
    
    
    /**
        Associates a simplified name with a path to a valid player model. Only used internally.
		
		Name | Description
		--- | ---
		`name` | Simplified name
		`model` | Valid PlayerModel path
    **/
    
    public static function AddValidModel(name:String, model:String):Void;
    
    
    /**
        Gets a players class
		
		Name | Description
		--- | ---
		`ply` | Player to get class
		
		
		`**Returns:** The players class
    **/
    
    public static function GetPlayerClass(ply:Player):String;
    
    
    /**
        Applies basic class variables when the player spawns. 
		
		Called from GM:PlayerSpawn in the base gamemode.
		
		Name | Description
		--- | ---
		`ply` | Player to setup
    **/
    
    public static function OnPlayerSpawn(ply:Player):Void;
    
    
    /**
        Returns the simplified name for a valid model path of a player model. 
		
		Opposite of player_manager.TranslatePlayerModel.
		
		Name | Description
		--- | ---
		`model` | The model path to a player model
		
		
		`**Returns:** The simplified name for that model
    **/
    
    public static function TranslateToPlayerModelName(model:String):String;
    
    
    /**
        Execute a named function within the player's set class
		
		Name | Description
		--- | ---
		`ply` | Player to execute function on.
		`funcName` | Name of function.
		`arguments` | Optional arguments. Can be of any type.
		
		
		`**Returns:** The values returned by the called function.
		
		___
		### Lua Examples
		#### Example 1
		Run the player's class 'Loadout' function when PlayerLoadout is called
		
		```lua 
		function GM:PlayerLoadout( ply )
		
		    player_manager.RunClass( ply, "Loadout" )
		 
		end
		```
		**Output:**
		
		The player's class 'Loadout' function is executed
		
		#### Example 2
		Call a greeting function within the playerclass system.
		
		```lua 
		local PLAYER = {}
		PLAYER.DisplayName = "Hooman"
		PLAYER.WalkSpeed = 200
		PLAYER.greet = function( tbl ) // create a function named 'greet'
		// the first argument passed is the source table
		// which includes the classID, the player entity, and the function itself
		    local ply = tbl.Player // here we extract the player entity from the table
		    ply:ChatPrint("Hello "..ply:Nick().." !") // tell the player
		end
		
		// link it to the spawn hook, so each time a player (re-)spawns, he will be greeted with a hello
		hook.Add("PlayerSpawn","greet",function(ply)
		    player_manager.RunClass( ply, "greet" )
		end)
		```
		**Output:**
		
		Hello Flowx !
    **/
    
    public static function RunClass(ply:Player, funcName:String, arguments:Rest<Dynamic>):Rest<Dynamic>;
    
    
    /**
        Sets a player's class
		
		Name | Description
		--- | ---
		`ply` | Player to set class
		`classname` | Name of class to set
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the player's class to 'player_default' every time they spawn
		
		```lua 
		function GM:PlayerSpawn( ply )
		 player_manager.SetPlayerClass(ply, "player_default")
		end
		```
    **/
    
    public static function SetPlayerClass(ply:Player, classname:String):Void;
    
    
    /**
        Retrieves correct hands for given player model. By default returns citizen hands.
		
		Name | Description
		--- | ---
		`name` | Player model name
		
		
		`**Returns:** A table with following contents: string model - Model of hands number skin - Skin of hands string body - Bodygroups of hands
    **/
    
    public static function TranslatePlayerHands(name:String):AnyTable;
    
    

}



