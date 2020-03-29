package gmod.libs;
#if client

/**
    The input library allows you to gather information about the clients input devices (mouse & keyboard), such as the cursor position and whether a key is pressed or not.
**/
@:native("_G.input")extern class InputLib {
    
    /**
        Returns whether key trapping is activate and the next key press will be captured.
		
		`**Returns:** Whether key trapping active or not
    **/
    
    public static function IsKeyTrapping():Bool;
    
    
    /**
        Gets the button code from a button name. This is opposite of input.GetKeyName.
		
		Name | Description
		--- | ---
		`button` | The internal button name, such as "e" or "shift".
		
		
		`**Returns:** The button code, see BUTTON_CODE_ Enums.
    **/
    
    public static function GetKeyCode(button:String):BUTTON_CODE;
    
    
    /**
        Gets whether a shift key is being pressed
		
		`**Returns:** isDown
    **/
    
    public static function IsShiftDown():Bool;
    
    
    /**
        Begins waiting for a key to be pressed so we can save it for input.CheckKeyTrapping. Used by the DBinder.
    **/
    
    public static function StartKeyTrapping():Void;
    
    
    /**
        Returns the cursor's position on the screen
		
		Name | Description
		--- | ---
		`a` | The cursors position on the X axis
		`b` | The cursors position on the Y axis
    **/
    
    public static function GetCursorPos():InputLibGetCursorPosReturn;
    
    
    /**
        Returns whether a mouse key was released in the same frame this function was called. 
		
		This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.
		
		Name | Description
		--- | ---
		`key` | The key to test, see MOUSE_ Enums
		
		
		`**Returns:** True if the mouse key was released the same frame that this function was called, false otherwise.
    **/
    
    public static function WasMouseReleased(key:MOUSE):Bool;
    
    
    /**
        Returns whether a mouse key was initially pressed in the same frame this function was called. If input.WasMouseDoublePressed returns true, this function will return false. 
		
		This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.
		
		Name | Description
		--- | ---
		`key` | The key, see MOUSE_ Enums
		
		
		`**Returns:** True if the mouse key was initially pressed the same frame that this function was called, false otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		hook.Add( "CreateMove", "fafawefafwf", function()
		    if ( input.WasMousePressed( MOUSE_LEFT ) ) then print( "Left mouse button was pressed" ) end
		end )
		```
    **/
    
    public static function WasMousePressed(key:MOUSE):Bool;
    
    
    /**
        Returns whether a key was released in the same frame this function was called. 
		
		This function only works in Move hooks, and will detect key releases even in main menu or when a typing in a text field.
		
		Name | Description
		--- | ---
		`key` | The key, see KEY_ Enums.
		
		
		`**Returns:** True if the key was released the same frame that this function was called, false otherwise.
    **/
    
    public static function WasKeyReleased(key:KEY):Bool;
    
    
    /**
        Sets the cursor's position on the screen, relative to the topleft corner of the window
		
		Name | Description
		--- | ---
		`mouseX` | X coordinate for mouse position
		`mouseY` | Y coordinate for mouse position
		
		
		___
		### Lua Examples
		#### Example 1
		Makes the user's cursor circle their screen
		
		```lua 
		hook.Add( 'HUDPaint', 'CircleScreen', function()
		    input.SetCursorPos( ScrW()/2+math.sin(CurTime())*ScrW()/2, ScrH()/2+math.cos(CurTime())*ScrH()/2 )
		end)
		```
    **/
    
    public static function SetCursorPos(mouseX:Float, mouseY:Float):Void;
    
    
    /**
        Gets whether a mouse button is down
		
		Name | Description
		--- | ---
		`mouseKey` | The key, see MOUSE_ Enums
		
		
		`**Returns:** Is the key down
    **/
    
    public static function IsMouseDown(mouseKey:MOUSE):Bool;
    
    
    /**
        Gets whether a key is down
		
		Name | Description
		--- | ---
		`key` | The key, see KEY_ Enums.
		
		
		`**Returns:** Is the key down
		
		___
		### Lua Examples
		#### Example 1
		Show cursor if you press alt.
		
		```lua 
		hook.Add("Think", "BM_Clients_Key", function()
		   gui.EnableScreenClicker( input.IsKeyDown( KEY_LALT ) )
		end)
		// Note this may prevent the cursor from naturally appearing without alt
		```
    **/
    
    public static function IsKeyDown(key:KEY):Bool;
    
    
    /**
        Returns whether a control key is being pressed
		
		`**Returns:** Is Ctrl key down or not
    **/
    
    public static function IsControlDown():Bool;
    
    
    /**
        Returns the bind string that the given key is bound to.
		
		Name | Description
		--- | ---
		`key` | Key from BUTTON_CODE_ Enums
		
		
		`**Returns:** The bind string of the given key.
    **/
    
    public static function LookupKeyBinding(key:BUTTON_CODE):String;
    
    
    /**
        Gets whether the specified button code is down. 
		
		Unlike input.IsKeyDown this can also detect joystick presses from JOYSTICK_ Enums
		
		Name | Description
		--- | ---
		`button` | The button, valid values are in the range of BUTTON_CODE_ Enums.
		
		
		`**Returns:** Is the button down
    **/
    
    public static function IsButtonDown(button:BUTTON_CODE):Bool;
    
    
    /**
        Gets the button name from a numeric button code. The name needs to be translated with language.GetPhrase before being displayed.
		
		**Note:** Despite the name of the function, this also works for the full range of keys in BUTTON_CODE_ Enums.
		
		Name | Description
		--- | ---
		`button` | The button, see BUTTON_CODE_ Enums.
		
		
		`**Returns:** Button name.
    **/
    
    public static function GetKeyName(button:BUTTON_CODE):String;
    
    
    /**
        Returns whether the key is being held down or not. 
		
		This function only works in Move hooks, and will detect key events even in main menu or when a typing in a text field.
		
		Name | Description
		--- | ---
		`key` | The key to test, see KEY_ Enums
		
		
		`**Returns:** Whether the key is being held down or not.
    **/
    
    public static function WasKeyTyped(key:KEY):Bool;
    
    
    /**
        Returns whether a mouse key was double pressed in the same frame this function was called. If this function returns true, input.WasMousePressed will return false. 
		
		This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.
		
		Name | Description
		--- | ---
		`button` | The mouse button to test, see MOUSE_ Enums
		
		
		`**Returns:** Whether the mouse key was double pressed or not.
    **/
    
    public static function WasMouseDoublePressed(button:MOUSE):Bool;
    
    
    /**
        Gets the match uppercase key for the specified binding.
		
		Name | Description
		--- | ---
		`binding` | The binding name
		`exact` | True if the binding should match exactly
		
		
		`**Returns:** The first key found with that binding or no value if no key with given binding was found. See also input. GetKeyCode.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates usage of this function and its arguments.
		
		```lua 
		print( input.LookupBinding( "+use" ) )
		print( input.LookupBinding( "use" ) )
		print( input.LookupBinding( "+use", true ) )
		print( input.LookupBinding( "use", true ) )
		```
    **/
    
    public static function LookupBinding(binding:String, ?exact:Bool):String;
    
    
    /**
        Returns the last key captured by key trapping.
		
		`**Returns:** The key, see KEY_ Enums
    **/
    
    public static function CheckKeyTrapping():KEY;
    
    
    /**
        Switches to the provided weapon on the next CUserCmd generation/CreateMove call. Direct binding to CInput::MakeWeaponSelection.
		
		Name | Description
		--- | ---
		`weapon` | The weapon entity to switch to.
    **/
    
    public static function SelectWeapon(weapon:Weapon):Void;
    
    
    /**
        Returns whether a key was initially pressed in the same frame this function was called. 
		
		This function only works in Move hooks, and will detect key presses even in main menu or when a typing in a text field.
		
		Name | Description
		--- | ---
		`key` | The key, see KEY_ Enums.
		
		
		`**Returns:** True if the key was initially pressed the same frame that this function was called, false otherwise.
    **/
    
    public static function WasKeyPressed(key:KEY):Bool;
    
    

}


@:multiReturn extern class InputLibGetCursorPosReturn {
var a:Float;
var b:Float;

}

#end