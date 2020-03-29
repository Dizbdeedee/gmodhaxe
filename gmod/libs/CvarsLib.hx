package gmod.libs;


/**
    The cvars library allows you to control what happens when a cvar (console variable) is changed.
**/
@:native("_G.cvars")extern class CvarsLib {
    
    /**
        ***INTERNAL** You are probably looking for cvars. AddChangeCallback.
		
		Called by the engine when a convar value changes.
		
		Name | Description
		--- | ---
		`name` | Convar name
		`oldVal` | The old value of the convar
		`newVal` | The new value of the convar
    **/
    @:deprecated("INTERNAL: You are probably looking for cvars. AddChangeCallback.")
    public static function OnConVarChanged(name:String, oldVal:String, newVal:String):Void;
    
    
    /**
        Retrieves console variable as a boolean.
		
		Name | Description
		--- | ---
		`cvar` | Name of console variable
		`default` | The value to return if the console variable does not exist
		
		
		`**Returns:** Retrieved value
    **/
    
    public static function Bool(cvar:String, ?_default:Bool):Bool;
    
    
    /**
        Adds a callback to be called when the named convar changes.
		
		**Bug:** BUG This does not callback convars in the menu state. Issue Tracker: #1440
		
		**Bug:** BUG This does not callback convars on the client with FCVAR_GAMEDLL and convars on the server without FCVAR_GAMEDLL. Issue Tracker: #3503
		
		**Bug:** BUG This does not callback convars on the client with FCVAR_REPLICATED. Issue Tracker: #3740
		
		Name | Description
		--- | ---
		`name` | The name of the convar to add the change callback to.
		`callback` | The function to be called when the convar changes. The arguments passed are: string convar - The name of the convar. string oldValue - The old value of the convar. string newValue - The new value of the convar.
		`identifier` | If set, you will be able to remove the callback using cvars. RemoveChangeCallback.
		
		
		___
		### Lua Examples
		#### Example 1
		Called when convar changes.
		
		```lua 
		cvars.AddChangeCallback("convar name", function(convar_name, value_old, value_new)
		    print(convar_name, value_old, value_new)
		end)
		```
		**Output:**
		
		"convar name" 2 5
    **/
    
    public static function AddChangeCallback(name:String, callback:Function, ?identifier:String):Void;
    
    
    /**
        Removes a callback for a convar using the the callback's identifier. The identifier should be the third argument specified for cvars.AddChangeCallback.
		
		Name | Description
		--- | ---
		`name` | The name of the convar to remove the callback from.
		`indentifier` | The callback's identifier.
    **/
    
    public static function RemoveChangeCallback(name:String, indentifier:String):Void;
    
    
    /**
        Retrieves console variable as a number.
		
		Name | Description
		--- | ---
		`cvar` | Name of console variable
		`default` | The value to return if the console variable does not exist
		
		
		`**Returns:** Retrieved value
    **/
    
    public static function Number(cvar:String, ?_default:Dynamic):Float;
    
    
    /**
        Retrieves console variable as a string.
		
		Name | Description
		--- | ---
		`cvar` | Name of console variable
		`default` | The value to return if the console variable does not exist
		
		
		`**Returns:** Retrieved value
    **/
    
    public static function String(cvar:String, ?_default:Dynamic):String;
    
    
    /**
        Returns a table of the given ConVars callbacks.
		
		Name | Description
		--- | ---
		`name` | The name of the ConVar.
		`createIfNotFound` | Whether or not to create the internal callback table for given ConVar if there isn't one yet. This argument is internal and should not be used.
		
		
		`**Returns:** A table of the convar's callbacks, or nil if the convar doesn't exist.
    **/
    
    public static function GetConVarCallbacks(name:String, ?createIfNotFound:Bool):AnyTable;
    
    

}



