package gmod.libs;


/**
    The concommand library is used to create console commands which can be used to network (basic) information & events between the client and the server.
**/
@:native("_G.concommand")extern class ConcommandLib {
    
    /**
        Removes a console command.
		
		**Bug:** BUG This will not always remove the command from auto-complete. Issue Tracker: #1183
		
		**Bug:** BUG concommand.Add will fail if the concommand was previously removed with this function in a different realm (creating a command on the client that was removed from the server and vice-versa). Issue Tracker: #1183
		
		Name | Description
		--- | ---
		`name` | The name of the command to be removed.
		
		
		___
		### Lua Examples
		#### Example 1
		Removes the built-in concommand "gmod_camera" which would normally quickly select the camera swep
		
		```lua 
		concommand.Remove("gmod_camera")
		```
    **/
    
    public static function Remove(name:String):Void;
    
    
    /**
        Creates a console command that runs a function in lua with optional autocompletion function and help text.
		
		**Bug:** BUG This will fail if the concommand was previously removed with concommand.Remove in a different realm (creating a command on the client that was removed from the server and vice-versa). Issue Tracker: #1183
		
		Name | Description
		--- | ---
		`name` | The command name to be used in console. This cannot be a name of existing console command or console variable. It will silently fail if it is.
		`callback` | The function to run when the concommand is executed. Arguments passed are: Player ply - The player that ran the concommand. NULL entity if command was entered with the dedicated server console. string cmd - The concommand string (if one callback is used for several concommands). table args - A table of all string arguments. string argStr - The arguments as a string.
		`autoComplete` | The function to call which should return a table of options for autocompletion. (Autocompletion Tutorial) This only properly works on the client since it is not networked. Arguments passed are: string cmd - The concommand this autocompletion is for. string args - The arguments typed so far.
		`helpText` | The text to display should a user run 'help cmdName'.
		`flags` | Concommand modifier flags. See FCVAR_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds a concommand killyourself which will kill the user.
		
		```lua 
		concommand.Add("killyourself",function( ply, cmd, args )
		    ply:Kill()
		    print("You killed yourself!")
		end)
		```
		
		#### Example 2
		A concommand that prints the SteamID and nickname of every player on the server.
		
		```lua 
		concommand.Add( "retrieveplayers", function()  
		    for _, ply in ipairs( player.GetAll() ) do
		        print( ply:Nick() .. ", " .. ply:SteamID() .. "\n" )
		    end
		end)
		```
    **/
    
    public static function Add(name:String, callback:Function, ?autoComplete:Function, ?helpText:String, ?flags:FCVAR):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by the engine to call the autocomplete function for a console command, and retrieve returned options.
		
		Name | Description
		--- | ---
		`command` | Name of command
		`arguments` | Arguments given to the command
		
		
		`**Returns:** Possibilities for auto-completion. This is the return value of the auto-complete callback.
    **/
    @:deprecated("INTERNAL")
    public static function AutoComplete(command:String, arguments:String):AnyTable;
    
    
    /**
        Returns the tables of all console command callbacks, and autocomplete functions, that were added to the game with concommand.Add.
		
		Name | Description
		--- | ---
		`a` | Table of command callback functions.
		`b` | Table of command autocomplete functions.
    **/
    
    public static function GetTable():ConcommandLibGetTableReturn;
    
    
    /**
        ***INTERNAL** You might be looking for RunConsoleCommand or Player: ConCommand.
		
		Used by the engine to run a console command's callback function. This will only be called for commands that were added with AddConsoleCommand, which concommand.Add calls internally. An error is sent to the player's chat if no callback is found. 
		
		This will still be called for concommands removed with concommand.Remove but will return false.
		
		Name | Description
		--- | ---
		`ply` | Player to run concommand on
		`cmd` | Command name
		`args` | Command arguments. Can be table or string
		`argumentString` | string of all arguments sent to the command
		
		
		`**Returns:** true if the console command with the given name exists, and false if it doesn't.
    **/
    @:deprecated("INTERNAL: You might be looking for RunConsoleCommand or Player: ConCommand.")
    public static function Run(ply:Player, cmd:String, args:Dynamic, argumentString:String):Bool;
    
    

}


@:multiReturn extern class ConcommandLibGetTableReturn {
var a:AnyTable;
var b:AnyTable;

}

