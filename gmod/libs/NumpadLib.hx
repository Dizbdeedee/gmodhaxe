package gmod.libs;
#if server

/**
    The numpad module allows you to execute functions on a key press or release.
**/
@:native("_G.numpad")extern class NumpadLib {
    
    /**
        Removes a function added by either numpad.OnUp or numpad.OnDown
		
		Name | Description
		--- | ---
		`ID` | The impulse ID returned by numpad. OnUp or numpad. OnDown
    **/
    
    public static function Remove(ID:Float):Void;
    
    
    /**
        Deactivates numpad key owned by the player
		
		Name | Description
		--- | ---
		`ply` | The player whose numpad should be simulated
		`key` | The key to press, corresponding to KEY_ Enums
		`isButton` | Should this keypress pretend to be a from a gmod_button? (causes numpad. FromButton to return true)
    **/
    
    public static function Deactivate(ply:Player, key:KEY, isButton:Bool):Void;
    
    
    /**
        Activates numpad key owned by the player
		
		Name | Description
		--- | ---
		`ply` | The player whose numpad should be simulated
		`key` | The key to press, see KEY_ Enums
		`isButton` | Should this keypress pretend to be a from a gmod_button? (causes numpad. FromButton to return true)
    **/
    
    public static function Activate(ply:Player, key:KEY, isButton:Bool):Void;
    
    
    /**
        Returns true during a function added with numpad.Register when the third argument to numpad.Activate is true. 
		
		This is caused when a numpad function is triggered by a button SENT being used.
		
		`**Returns:** wasButton
    **/
    
    public static function FromButton():Bool;
    
    
    /**
        Calls a function registered with numpad.Register when a player releases specified key. 
		
		See for key pressed action: numpad.OnDown
		
		Name | Description
		--- | ---
		`ply` | The player whose numpad should be watched
		`key` | The key, corresponding to KEY_ Enums
		`name` | The name of the function to run, corresponding with the one used in numpad. Register
		`...` | Arguments to pass to the function passed to numpad. Register.
		
		
		`**Returns:** The impulse ID
    **/
    
    public static function OnUp(ply:Player, key:KEY, name:String, vargs:Rest<Dynamic>):Float;
    
    
    /**
        Calls a function registered with numpad.Register when a player presses specified key. 
		
		See for key released action: numpad.OnUp
		
		Name | Description
		--- | ---
		`ply` | The player whose numpad should be watched
		`key` | The key, corresponding to KEY_ Enums
		`name` | The name of the function to run, corresponding with the one used in numpad. Register
		`...` | Arguments to pass to the function passed to numpad. Register.
		
		
		`**Returns:** The impulse ID
    **/
    
    public static function OnDown(ply:Player, key:KEY, name:String, vargs:Rest<Dynamic>):Float;
    
    
    /**
        Either runs numpad.Activate or numpad.Deactivate depending on the key's current state
		
		Name | Description
		--- | ---
		`ply` | The player whose numpad should be simulated
		`key` | The key to press, corresponding to KEY_ Enums
    **/
    
    public static function Toggle(ply:Player, key:KEY):Void;
    
    
    /**
        Registers a numpad library action for use with numpad.OnDown and numpad.OnUp
		
		Name | Description
		--- | ---
		`id` | The unique id of your action.
		`func` | The function to be executed. Arguments are: Player ply - The player who pressed the button vararg ... - The 4th and all subsequent arguments passed from numpad.OnDown and/or numpad.OnUp Returning false in this function will remove the listener which triggered this function (example: return false if one of your varargs is an entity which is no longer valid)
    **/
    
    public static function Register(id:String, func:Function):Void;
    
    

}



#end