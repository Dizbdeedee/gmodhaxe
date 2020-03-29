package gmod.libs;


/**
    Used to store permanent variables/settings on clients that will persist between servers. They are stored in the cl.db SQLite database located in the root Garry's Mod folder.
**/
@:native("_G.cookie")extern class CookieLib {
    
    /**
        Sets the value of a cookie, which is saved automatically by the sql library. 
		
		These are stored in the *.db files - cl.db for clients, mn.db for menu state and sv.db for servers.
		
		Name | Description
		--- | ---
		`key` | The name of the cookie that you want to set.
		`value` | Value to store in the cookie.
    **/
    
    public static function Set(key:String, value:String):Void;
    
    
    /**
        Gets the value of a cookie on the client as a string.
		
		Name | Description
		--- | ---
		`name` | The name of the cookie that you want to get.
		`default` | Value to return if the cookie does not exist.
		
		
		`**Returns:** The cookie value
    **/
    
    public static function GetString(name:String, ?_default:Dynamic):String;
    
    
    /**
        Deletes a cookie on the client.
		
		Name | Description
		--- | ---
		`name` | The name of the cookie that you want to delete.
    **/
    
    public static function Delete(name:String):Void;
    
    
    /**
        Gets the value of a cookie on the client as a number.
		
		Name | Description
		--- | ---
		`name` | The name of the cookie that you want to get.
		`default` | Value to return if the cookie does not exist.
		
		
		`**Returns:** The cookie value
    **/
    
    public static function GetNumber(name:String, ?_default:Dynamic):Float;
    
    

}



