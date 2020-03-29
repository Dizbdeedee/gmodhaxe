package gmod.libs;
#if client

/**
    The chat library's purpose is to interface with the default chatbox.
**/
@:native("_G.chat")extern class ChatLib {
    
    /**
        Closes the chat window.
    **/
    
    public static function Close():Void;
    
    
    /**
        Returns the chatbox size.
		
		Name | Description
		--- | ---
		`a` | The width of the chatbox.
		`b` | The height of the chatbox.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the width and the height of the chatbox.
		
		```lua 
		print( chat.GetChatBoxSize() )
		```
    **/
    
    public static function GetChatBoxSize():ChatLibGetChatBoxSizeReturn;
    
    
    /**
        Opens the chat window.
		
		Name | Description
		--- | ---
		`mode` | If equals 1, opens public chat, otherwise opens team chat
    **/
    
    public static function Open(mode:Float):Void;
    
    
    /**
        Plays the chat "tick" sound.
		
		___
		### Lua Examples
		#### Example 1
		Plays an obnoxious tick sound.
		
		```lua 
		chat.PlaySound()
		```
    **/
    
    public static function PlaySound():Void;
    
    
    /**
        Returns the chatbox position.
		
		Name | Description
		--- | ---
		`a` | The X coordinate of the chatbox's position.
		`b` | The Y coordinate of the chatbox's position.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the x and y coordinates of the chatbox.
		
		```lua 
		print( chat.GetChatBoxPos() )
		```
    **/
    
    public static function GetChatBoxPos():ChatLibGetChatBoxPosReturn;
    
    
    /**
        Adds text to the local player's chat box (which only they can read).
		
		Name | Description
		--- | ---
		`arguments` | The arguments. Arguments can be: table - Color structure. Will set the color for all following strings until the next Color argument. string - Text to be added to the chat box. Player - Adds the name of the player in the player's team color to the chat box. any - Any other type, such as Entity will be converted to string and added as text.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's name and current weapon to their chat area.
		
		```lua 
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), ply, ", you are holding ", Color( 100, 255, 100 ), ply:GetActiveWeapon():GetClass() )
		```
    **/
    
    public static function AddText(arguments:Color):Void;
    
    

}


@:multiReturn extern class ChatLibGetChatBoxSizeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class ChatLibGetChatBoxPosReturn {
var a:Float;
var b:Float;

}

#end