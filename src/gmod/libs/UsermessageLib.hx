package gmod.libs;


/**
    ***Deprecated:**   You should be using the net library instead
	
	The usermessage library is used to receive user messages from the server on the client.
	
	**Warning:** Usermessages have a limit of only 256 bytes!
**/
@:native("_G.usermessage")extern class UsermessageLib {
    
    /**
        ***INTERNAL** 
		
		Called by the engine when a usermessage arrives, this method calls the hook function specified by usermessage.Hook if any.
		
		Name | Description
		--- | ---
		`name` | The message name.
		`msg` | The message.
    **/
    @:deprecated("INTERNAL")
    static function IncomingMessage(name:String #if client , msg:Bf_read #end):Void;
    
    
    /**
        ***Deprecated:** You should be using net library instead
		
		Sets a hook for the specified to be called when a usermessage with the specified name arrives.
		
		**Warning:** Usermessages have a limit of only 256 bytes!
		
		Name | Description
		--- | ---
		`name` | The message name to hook to.
		`callback` | The function to be called if the specified message was received. Parameters (Optional): bf_read msg vararg preArgs
		`preArgs` | Arguments that are passed to the callback function when the hook is called. *ring ring*
    **/
    @:deprecated("You should be using net library instead")
    static function Hook(name:String, callback:Function, preArgs:Rest<Dynamic>):Void;
    
    
    /**
        Returns a table of every usermessage hook
		
		`**Returns:** hooks
    **/
    
    static function GetTable():AnyTable;
    
    

}



