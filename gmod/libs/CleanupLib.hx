package gmod.libs;


/**
    The cleanup library allows you to control what happens to custom entities when the clean-up buttons are pressed in the Utilities tab of the Spawn menu (default Q).
**/
@:native("_G.cleanup")extern class CleanupLib {
    #if server
    /**
        Adds an entity to a player's cleanup list.
		
		Name | Description
		--- | ---
		`pl` | Who's cleanup list to add the entity to.
		`type` | The type of cleanup.
		`ent` | The entity to add to the player's cleanup list.
    **/
    
    public static function Add(pl:Player, type:String, ent:Entity):Void;
    #end
    
    /**
        Gets the table of cleanup types.
		
		`**Returns:** cleanup_types
    **/
    
    public static function GetTable():AnyTable;
    
    #if server
    /**
        Replaces one entity in the cleanup module with another
		
		Name | Description
		--- | ---
		`from` | Old entity
		`to` | New entity
		
		
		`**Returns:** Whether any action was taken.
    **/
    
    public static function ReplaceEntity(from:Entity, to:Entity):Bool;
    #end
    #if server
    /**
        ***INTERNAL** 
		
		Called by the  console command. Allows players to cleanup their own props.
		
		Name | Description
		--- | ---
		`pl` | The player that called the console command.
		`command` | The console command that called this function.
		`args` | First and only arg is the cleanup type.
    **/
    @:deprecated("INTERNAL")
    public static function CC_Cleanup(pl:Player, command:String, args:AnyTable):Void;
    #end
    #if server
    /**
        ***INTERNAL** 
		
		Called by the  console command. Allows admins to clean up the server.
		
		Name | Description
		--- | ---
		`pl` | The player that called the console command.
		`command` | The console command that called this function.
		`args` | First and only arg is the cleanup type.
    **/
    @:deprecated("INTERNAL")
    public static function CC_AdminCleanup(pl:Player, command:String, args:AnyTable):Void;
    #end
    #if client
    /**
        Repopulates the clients cleanup menu
    **/
    
    public static function UpdateUI():Void;
    #end
    #if server
    /**
        Gets the cleanup list.
    **/
    
    public static function GetList():Void;
    #end
    
    /**
        Registers a new cleanup type.
		
		Name | Description
		--- | ---
		`type` | Name of type.
    **/
    
    public static function Register(type:String):Void;
    
    

}



