package gmod.structs;
/**
    Used for [serverlist](https://wiki.garrysmod.com/page/Category:serverlist). [Query](https://wiki.garrysmod.com/page/serverlist/Query).
**/
typedef ServerQueryData = {
    /**
        Steam application ID to get the servers for 
		
		Default: 4000
    **/
    var ?AppID : Float;
    /**
        Type of servers to retrieve. Valid values are:
    **/
    var Type : String;
    /**
        The game directory to get the servers for 
		
		Default: garrysmod
    **/
    var ?GameDir : String;
    /**
        Called when the query is finished. No arguments
    **/
    var Finished : Function;
    /**
        Called when a new server is found and queried. Arguments: number ping - Latency to the server. string name - Name of the server string desc - "Nice" gamemode name string map - Current map number players - Total player number ( bot + human ) number maxplayers - Maximum reported amount of players number botplayers - Amount of bots on the server boolean pass - Whether this server has password or not number lastplayed - Time when you last played on this server, as UNIX timestamp or 0 string address - IP Address of the server string gamemode - Gamemode folder name number workshopid - Gamemode Steam Workshop ID Return false to stop the query.
    **/
    var Callback : Function;
    
}
