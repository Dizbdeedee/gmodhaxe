package gmod.libs;
#if client

/**
    The gui library is similar to the input library but features functions that are more focused on the mouse's interaction with GUI panels.
**/
@:native("_G.gui")extern class GuiLib {
    
    /**
        Returns x component of the mouse position.
		
		`**Returns:** mouseX
    **/
    
    public static function MouseX():Float;
    
    
    /**
        Opens the game menu overlay.
    **/
    
    public static function ActivateGameUI():Void;
    
    
    /**
        Simulates an ASCII symbol writing. Use to write text in the chat or in VGUI. Doesn't work while the main menu is open!
		
		Name | Description
		--- | ---
		`code` | ASCII code of symbol, see http://www.mikroe.com/img/publication/spa/pic-books/programming-in-basic/chapter/04/fig4-24.gif
		
		
		___
		### Lua Examples
		#### Example 1
		Writes "Hello" every think.
		
		```lua 
		hook.Add("Think","Example",function()
		    gui.InternalKeyTyped(72)
		    gui.InternalKeyTyped(101)
		    gui.InternalKeyTyped(108)
		    gui.InternalKeyTyped(108)
		    gui.InternalKeyTyped(111)
		end)
		```
    **/
    
    public static function InternalKeyTyped(code:Float):Void;
    
    
    /**
        Simulates a mouse move with the given deltas.
		
		Name | Description
		--- | ---
		`deltaX` | The movement delta on the x axis.
		`deltaY` | The movement delta on the y axis.
    **/
    
    public static function InternalCursorMoved(deltaX:Float, deltaY:Float):Void;
    
    
    /**
        Converts the specified screen position to a direction vector local to the player's view. A related function is Vector:ToScreen, which translates a 3D position to a screen coordinate. 
		
		util.AimVector is a more generic version of this, using a custom view instead of the player's current view.
		
		Name | Description
		--- | ---
		`x` | X coordinate on the screen.
		`y` | Y coordinate on the screen.
		
		
		`**Returns:** Direction
		
		___
		### Lua Examples
		#### Example 1
		This will do a trace from the mouse position to the world
		
		```lua 
		local tr = util.QuickTrace(LocalPlayer():GetShootPos(), gui.ScreenToVector(gui.MousePos()),LocalPlayer())
		print(tr.HitPos)
		```
		**Output:**
		
		The worldpos the cursor is pointing at will be printed
		
		#### Example 2
		Replacement for Player:GetAimVector
		
		```lua 
		print(gui.ScreenToVector(ScrW()/2, ScrH()/2))
		```
		**Output:**
		
		The player's current aimvector will be printed
    **/
    
    public static function ScreenToVector(x:Float, y:Float):Vector;
    
    
    /**
        Simulates a mouse wheel scroll with the given delta.
		
		Name | Description
		--- | ---
		`delta` | The amount of scrolling to simulate.
    **/
    
    public static function InternalMouseWheeled(delta:Float):Void;
    
    
    /**
        Returns whether the console is visible or not.
		
		`**Returns:** Whether the console is visible or not.
    **/
    
    public static function IsConsoleVisible():Bool;
    
    
    /**
        Simulates a mouse key release for the given mouse key.
		
		Name | Description
		--- | ---
		`key` | The key, see MOUSE_ Enums.
    **/
    
    public static function InternalMouseReleased(key:MOUSE):Void;
    
    
    /**
        Simulates a mouse key press for the given mouse key.
		
		Name | Description
		--- | ---
		`key` | The key, see MOUSE_ Enums.
    **/
    
    public static function InternalMousePressed(key:MOUSE):Void;
    
    
    /**
        ***Deprecated:** Use input. SetCursorPos instead.
		
		Sets the cursor's position on the screen, relative to the topleft corner of the window
		
		Name | Description
		--- | ---
		`mouseX` | The X coordinate to move the cursor to.
		`mouseY` | The Y coordinate to move the cursor to.
    **/
    @:deprecated("Use input. SetCursorPos instead.")
    public static function SetMousePos(mouseX:Float, mouseY:Float):Void;
    
    
    /**
        Simulates a key release for the given key.
		
		Name | Description
		--- | ---
		`key` | The key, see KEY_ Enums.
    **/
    
    public static function InternalKeyCodeReleased(key:KEY):Void;
    
    
    /**
        Returns y component of the mouse position.
		
		`**Returns:** mouseY
    **/
    
    public static function MouseY():Float;
    
    
    /**
        Hides the game menu overlay.
    **/
    
    public static function HideGameUI():Void;
    
    
    /**
        Simulates a key press for the given key.
		
		Name | Description
		--- | ---
		`key` | The key, see KEY_ Enums.
    **/
    
    public static function InternalKeyCodePressed(key:KEY):Void;
    
    
    /**
        Simulates a double mouse key press for the given mouse key.
		
		Name | Description
		--- | ---
		`key` | The key, see MOUSE_ Enums.
    **/
    
    public static function InternalMouseDoublePressed(key:MOUSE):Void;
    
    
    /**
        Opens specified URL in the steam overlay browser. The URL has to start with either http:// or https://
		
		**Note:** User will be asked for confirmation before the website will open.
		
		**Bug:** BUG You can't click the confirmation if a modal panel has focus. Issue Tracker: #3383
		
		Name | Description
		--- | ---
		`url` | URL to open
		
		
		___
		### Lua Examples
		#### Example 1
		Opens a page when a button is clicked.
		
		```lua 
		local button = vgui.Create( "DButton" )
		button:SetSize( 125, 90 )
		button:Center() 
		button:SetText( "Join our Steam Group!" )
		button.DoClick = function()
		    gui.OpenURL( "http://steamcommunity.com/groups/glua" )
		end
		```
    **/
    
    public static function OpenURL(url:String):Void;
    
    
    /**
        Returns whenever the game menu overlay ( main menu ) is open or not.
		
		`**Returns:** Whenever the game menu overlay ( main menu ) is open or not
    **/
    
    public static function IsGameUIVisible():Bool;
    
    
    /**
        ***Deprecated:** Use input. GetCursorPos instead.
		
		Returns the cursor's position on the screen, or 0, 0 if cursor is not visible.
		
		Name | Description
		--- | ---
		`a` | mouseX
		`b` | mouseY
    **/
    @:deprecated("Use input. GetCursorPos instead.")
    public static function MousePos():GuiLibMousePosReturn;
    
    
    /**
        Simulates a key type typing to the specified key.
		
		Name | Description
		--- | ---
		`key` | The key, see KEY_ Enums.
    **/
    
    public static function InternalKeyCodeTyped(key:KEY):Void;
    
    
    /**
        Enables the mouse cursor without restricting player movement, like using Sandbox's context menu.
		
		**Bug:** BUG Some CUserCmd functions to return incorrect values will return incorrect values when this function is active. Issue Tracker: #982
		
		Name | Description
		--- | ---
		`enabled` | Whether the cursor should be enabled or not. (true = enable, false = disable)
    **/
    
    public static function EnableScreenClicker(enabled:Bool):Void;
    
    
    /**
        Shows console in the game UI.
		
		___
		### Lua Examples
		#### Example 1
		Example from garrysmod\lua\menu\mainmenu.lua that initializes the game UI and shows console if activated.
		
		```lua 
		function PANEL:Init()
		
		    self:Dock( FILL )
		    self:SetKeyboardInputEnabled( true )
		    self:SetMouseInputEnabled( true )
		
		    self.HTML = vgui.Create( "DHTML", self )
		
		    JS_Language( self.HTML )
		    JS_Utility( self.HTML )
		    JS_Workshop( self.HTML )
		
		    self.HTML:Dock( FILL )
		    self.HTML:OpenURL( "asset://garrysmod/html/menu.html" )
		    self.HTML:SetKeyboardInputEnabled( true )
		    self.HTML:SetMouseInputEnabled( true )
		    self.HTML:SetAllowLua( true )
		    self.HTML:RequestFocus()
		
		    ws_save.HTML = self.HTML
		    addon.HTML = self.HTML
		    demo.HTML = self.HTML
		
		    self:MakePopup()
		    self:SetPopupStayAtBack( true )
		    
		    -- If the console is already open, we've got in its way.
		    if ( gui.IsConsoleVisible() ) then
		        gui.ShowConsole()
		    end
		
		end
		```
    **/
    
    public static function ShowConsole():Void;
    
    

}


@:multiReturn extern class GuiLibMousePosReturn {
var a:Float;
var b:Float;

}

#end