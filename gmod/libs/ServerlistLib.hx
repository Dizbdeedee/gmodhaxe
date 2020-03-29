package gmod.libs;


/**
    Menu state library to query the master server list.
**/
@:native("_G.serverlist")extern class ServerlistLib {
    
    /**
        ***INTERNAL** 
		
		Adds current server the player is on to their favorites.
    **/
    @:deprecated("INTERNAL")
    public static function AddCurrentServerToFavorites():Void;
    
    
    /**
        Queries a server for its player list.
		
		Name | Description
		--- | ---
		`ip` | The IP address of the server, including the port.
		`callback` | The function to be called if and when the request finishes. Function has one argument, a table containing tables with player info. Each table with player info has next fields: number time - The amount of time the player is playing on the server, in seconds string name - The player name number score - The players score
    **/
    
    public static function PlayerList(ip:String, callback:Function):Void;
    
    
    /**
        Queries the master server for server list.
		
		Name | Description
		--- | ---
		`data` | The information about what kind of servers we want. See ServerQueryData structure.
    **/
    
    public static function Query(data:ServerQueryData):Void;
    
    

}



