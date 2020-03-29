package gmod.libs;
#if client

/**
    Used to display notifications on the screen (mid-right).
**/
@:native("_G.notification")extern class NotificationLib {
    
    /**
        Removes the notification after 0.8 seconds.
		
		Name | Description
		--- | ---
		`uid` | The unique ID of the notification
    **/
    
    public static function Kill(uid:Dynamic):Void;
    
    
    /**
        Adds a notification with an animated progress bar.
		
		Name | Description
		--- | ---
		`id` | Can be any type. It's used as an index.
		`strText` | The text to show
		
		
		___
		### Lua Examples
		#### Example 1
		Add a notification that says "Downloading file...", and remove after three seconds.
		
		```lua 
		notification.AddProgress("FileDownload", "Downloading file...")
		timer.Simple(3, function()
		    notification.Kill("FileDownload")
		end)
		```
    **/
    
    public static function AddProgress(id:Dynamic, strText:String):Void;
    
    
    /**
        Adds a standard notification to your screen.
		
		Name | Description
		--- | ---
		`text` | The text to display.
		`type` | Determines the notification method (e.g. icon) for displaying the notification. See the NOTIFY_ Enums.
		`length` | The number of seconds to display the notification for.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds a prop undo notification to the screen, like in Sandbox.
		
		```lua 
		notification.AddLegacy( "Undone Prop", NOTIFY_UNDO, 2 )
		surface.PlaySound( "buttons/button15.wav" )
		Msg( "Prop undone\n" )
		```
		**Output:**
		
		Adds a notice that says "Undone Prop", plays the undo sound, and adds a message to the console.
    **/
    
    public static function AddLegacy(text:String, type:NOTIFY, length:Float):Void;
    
    

}



#end