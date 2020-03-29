package gmod.libs;
#if server

/**
    ***Deprecated:**   You should be using the net library instead
	
	The umsg (user message) library was previously the most common way of sending information from the server to the client.
	
	**Warning:** Usermessages have a limit of only 256 bytes!
**/
@:native("_G.umsg")extern class UmsgLib {
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes an entity object to the usermessage.
		
		Name | Description
		--- | ---
		`entity` | The entity to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Entity(entity:Entity):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a vector normal to the usermessage.
		
		Name | Description
		--- | ---
		`normal` | The vector normal to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function VectorNormal(normal:Vector):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a Vector to the usermessage.
		
		Name | Description
		--- | ---
		`vector` | The vector to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Vector(vector:Vector):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a bool to the usermessage.
		
		Name | Description
		--- | ---
		`bool` | The bool to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Bool(bool:Bool):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a signed char to the usermessage.
		
		Name | Description
		--- | ---
		`char` | The char to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Char(char:Float):Void;
    
    
    /**
        ***Deprecated:** You should be using net library instead
		
		Starts a new usermessage.
		
		**Warning:** Usermessages have a limit of only 256 bytes!
		
		Name | Description
		--- | ---
		`name` | The name of the message to be sent.
		`filter` | If passed a player object, it will only be sent to the player, if passed a CRecipientFilter of players, it will be sent to all specified players, if passed nil (or another invalid value), the message will be sent to all players.
    **/
    @:deprecated("You should be using net library instead")
    public static function Start(name:String, filter:Player):Void;
    
    
    /**
        ***Deprecated:** Inferior version of util. AddNetworkString
		
		The string specified will be networked to the client and receive a identifying number, which will be sent instead of the string to optimize networking.
		
		Name | Description
		--- | ---
		`string` | The string to be pooled.
    **/
    @:deprecated("Inferior version of util. AddNetworkString")
    public static function PoolString(string:String):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a signed int (32 bit) to the usermessage.
		
		Name | Description
		--- | ---
		`int` | The int to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Long(int:Float):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Dispatches the usermessage to the client(s).
    **/
    @:deprecated("You should be using the net library instead")
    public static function End():Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a float to the usermessage.
		
		Name | Description
		--- | ---
		`float` | The float to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Float(float:Float):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes an angle to the usermessage.
		
		Name | Description
		--- | ---
		`angle` | The angle to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Angle(angle:Angle):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a signed short (16 bit) to the usermessage.
		
		Name | Description
		--- | ---
		`short` | The short to be sent.
    **/
    @:deprecated("You should be using the net library instead")
    public static function Short(short:Float):Void;
    
    
    /**
        ***Deprecated:** You should be using the net library instead
		
		Writes a null terminated string to the usermessage.
		
		Name | Description
		--- | ---
		`string` | The string to be sent.
		
		
		___
		### Lua Examples
		#### Example 1
		An easy way to send any string to the client or clients
		
		```lua 
		umsg.Start("Example_SendString") -- With umsg.Start("Example_SendString",pl) Must get pl value the player entity.
		    umsg.String("Custom Text")
		umsg.End()
		```
    **/
    @:deprecated("You should be using the net library instead")
    public static function String(string:String):Void;
    
    

}



#end