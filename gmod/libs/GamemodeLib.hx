package gmod.libs;


/**
    The gamemode library provides functions relating to the gamemode system in Garry's Mod.
**/
@:native("_G.gamemode")extern class GamemodeLib {
    
    /**
        ***INTERNAL** 
		
		This returns the internally stored gamemode table.
		
		Name | Description
		--- | ---
		`name` | The name of the gamemode you want to get
		
		
		`**Returns:** The gamemode's table
    **/
    @:deprecated("INTERNAL")
    public static function Get(name:String):AnyTable;
    
    
    /**
        Called by the engine to call a hook within the loaded gamemode. 
		
		The supplied event 'name' must be defined in the active gamemode. Otherwise, nothing will happen - not even hooks added with hook.Add will be called. 
		
		 This is similar to hook.Run and hook.Call, except the hook library will call hooks created with hook.Add even if there is no corresponding gamemode function.
		
		Name | Description
		--- | ---
		`name` | The name of the hook to call.
		`args` | The arguments
		
		
		`**Returns:** The result of the hook function - can be up to 6 values. Returns false if the gamemode function doesn't exist (i.e. nothing happened), but remember - a hook can also return false.
		
		___
		### Lua Examples
		#### Example 1
		Shows a suicide death notice in Sandbox.
		
		```lua 
		local ply = Entity(1)
		gamemode.Call( "AddDeathNotice", ply:GetName(), ply:Team(), nil, ply:GetName(), ply:Team() )
		```
    **/
    
    public static function Call(name:String, args:Rest<Dynamic>):Dynamic;
    
    
    /**
        ***INTERNAL** 
		
		Called by the engine when a gamemode is being loaded.
		
		Name | Description
		--- | ---
		`gm` | Your GM table
		`name` | Name of your gamemode, lowercase, no spaces.
		`derived` | The gamemode name that your gamemode is derived from
    **/
    @:deprecated("INTERNAL")
    public static function Register(gm:AnyTable, name:String, derived:String):Void;
    
    

}



