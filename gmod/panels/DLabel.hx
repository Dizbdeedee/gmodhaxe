package gmod.panels;
#if client

/**
    A standard Derma text label. A lot of this panels functionality is a base for button elements, such as DButton
**/
extern class DLabel extends Label {
    /**
        ***Deprecated:** You really should use DLabel: SetTextColor.
		
		Sets the color of the text to the bright text color defined in the skin. 
		
		See also DLabel:SetDark and DLabel:SetHighlight. 
		
		 You should only consider using this if you are using background elements that are not manually painted and are using the skin colors.
		
		Name | Description
		--- | ---
		`bright` | Whenever to set the text to bright or not.
    **/
    @:deprecated("You really should use DLabel: SetTextColor.")
     
    function SetBright(bright:Bool):Void;
    /**
        Called when the label is double clicked by the player with left clicks. 
		
		DLabel:SetDoubleClickingEnabled must be set to true for this hook to work, which it is by default. 
		
		 This will be called after DLabel:OnDepressed and DLabel:OnReleased and DLabel:DoClick. 
		
		 See also DLabel:DoRightClick and DLabel:DoMiddleClick.
		
		___
		### Lua Examples
		#### Example 1
		Opens a URL in Steam Overlay by double clicking the text "Click ME"!
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "Double Click Example" )
		frame:SetSize( 250, 100 )
		frame:Center()
		frame:MakePopup()
		
		local frame_label = vgui.Create( "DLabel", frame )
		frame_label:SetPos( 10, 30 )
		frame_label:SetTextColor( Color( 255, 255, 255 ) )
		frame_label:SetText( "Double click me!" )
		frame_label:SizeToContents()
		frame_label:SetMouseInputEnabled( true )
		frame_label.DoDoubleClick = function()
		    gui.OpenURL("https://wiki.garrysmod.com/")
		end
		
		-- Uncommentiing this will disable double clicking
		-- frame_label:SetDoubleClickingEnabled( false )
		```
    **/
    
    @:hook 
    function DoDoubleClick():Void;
    /**
        Returns the "override" text color, set by DLabel:SetTextColor.
		
		`**Returns:** The color of the text, or nil.
    **/
    
     
    function GetTextColor():AnyTable;
    /**
        A hook called from within DLabel:ApplySchemeSettings to determine the color of the text on display.
		
		Name | Description
		--- | ---
		`skin` | A table supposed to contain the color values listed above.
    **/
    
     
    function UpdateColours(skin:AnyTable):Void;
    /**
        Sets the alignment of the contents.
		
		Name | Description
		--- | ---
		`alignment` | The direction of the content, based on the number pad. 7: top-left 8: top-center 9: top-right 4: middle-left 5: center 6: middle-right 1: bottom-left 2: bottom-center 3: bottom-right
    **/
    
     
    function SetContentAlignment(alignment:Float):Void;
    /**
        Returns whether the DLabel should set its text color to the current skin's highlighted text color. 
		
		See DLabel:SetHighlight.
		
		`**Returns:** 
    **/
    
     
    function GetHighlight():Bool;
    /**
        Called when the player releases any mouse button on the label. This is always called after DLabel:OnDepressed. 
		
		This works as an alternative to PANEL:OnMouseReleased as that hook is used heavily by DLabel and overriding it will break functionality. 
		
		 See also DLabel:DoClick, DLabel:DoMiddleClick, DLabel:DoRightClick and DLabel:DoDoubleClick.
		
		___
		### Lua Examples
		#### Example 1
		Changes the text of the label when the hook is called.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "OnDepressed/Released Example" )
		frame:SetSize( 300, 100 )
		frame:Center()
		frame:MakePopup()
		
		local frame_label = vgui.Create( "DLabel", frame )
		frame_label:SetPos( 10, 30 )
		frame_label:SetTextColor( Color( 255, 255, 255 ) )
		frame_label:SetText( "Click me!" )
		frame_label:SizeToContents()
		frame_label:SetMouseInputEnabled( true )
		frame_label.OnDepressed = function( s )
		    s:SetText( "OnDepressed" )
		    frame_label:SizeToContents()
		end
		frame_label.OnReleased = function( s )
		    s:SetText( "OnReleased" )
		    frame_label:SizeToContents()
		end
		```
    **/
    
    @:hook 
    function OnReleased():Void;
    /**
        Returns whether the DLabel should set its text color to the current skin's bright text color. 
		
		See DLabel:SetBright.
		
		`**Returns:** 
    **/
    
     
    function GetBright():Bool;
    /**
        ***INTERNAL** Use DLabel: SetTextColor instead!
		
		Used by DLabel:SetDark, DLabel:SetBright and DLabel:SetHighlight to set the text color without affecting DLabel:SetTextColor calls.
		
		Name | Description
		--- | ---
		`color` | The text color. Uses the Color structure.
    **/
    @:deprecated("INTERNAL: Use DLabel: SetTextColor instead!")
     
    function SetTextStyleColor(color:Color):Void;
    /**
        Sets whether text wrapping should be enabled or disabled on Label and DLabel panels. Use DLabel:SetAutoStretchVertical to automatically correct vertical size; Panel:SizeToContents will not set the correct height.
		
		Name | Description
		--- | ---
		`wrap` | True to enable text wrapping, false otherwise.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates two labels in a panel and sets the text wrapping to false and true respectively.
		
		```lua 
		-- Background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetSize(300, 130)
		BGPanel:Center()
		BGPanel:SetBackgroundColor(Color(0, 0, 0))
		        
		-- Label with no text wrapping
		local lbl_nowrap = vgui.Create("DLabel", BGPanel)
		lbl_nowrap:SetPos(10, 10)
		lbl_nowrap:SetSize(280, 50)        
		lbl_nowrap:SetFont("GModNotify")
		lbl_nowrap:SetText("This is a label that has text wrapping disabled.")
		
		lbl_nowrap:SetWrap(false)
		
		-- Label with text wrapping
		local lbl_wrap = vgui.Create("DLabel", BGPanel)
		lbl_wrap:SetPos(10, 70)
		lbl_wrap:SetSize(280, 50)
		lbl_wrap:SetFont("GModNotify")
		lbl_wrap:SetText("This is a label that has text wrapping enabled.")
		
		lbl_wrap:SetWrap(true)
		```
    **/
    
     
    function SetWrap(wrap:Bool):Void;
    /**
        Returns whether the DLabel should set its text color to the current skin's dark text color. 
		
		See DLabel:SetDark.
		
		`**Returns:** 
    **/
    
     
    function GetDark():Bool;
    /**
        ***INTERNAL** 
		
		Called internally to update the color of the text.
    **/
    @:deprecated("INTERNAL")
     
    function UpdateFGColor():Void;
    /**
        ***Deprecated:** You really should use DLabel: SetTextColor.
		
		Sets the color of the text to the highlight text color defined in the skin. 
		
		For the default Derma skin this makes the label red. 
		
		 See also DLabel:SetBright and DLabel:SetDark. 
		
		 You should only consider using this if you are using background elements that are not manually painted and are using the skin colors.
		
		Name | Description
		--- | ---
		`highlight` | true to set the label's color to skins's text highlight color, false otherwise.
    **/
    @:deprecated("You really should use DLabel: SetTextColor.")
     
    function SetHighlight(highlight:Bool):Void;
    /**
        Returns the current font of the DLabel. This is set with [DLabel](https://wiki.garrysmod.com/page/Category:DLabel): [SetFont](https://wiki.garrysmod.com/page/DLabel/SetFont).
		
		`**Returns:** The name of the font in use.
    **/
    
     
    function GetFont():String;
    /**
        Sets whether or not double clicking should call DLabel:DoDoubleClick. 
		
		This is enabled by default.
		
		Name | Description
		--- | ---
		`enable` | true to enable, false to disable
    **/
    
     
    function SetDoubleClickingEnabled(enable:Bool):Void;
    /**
        Called just before DLabel:DoDoubleClick. In DLabel does nothing and is safe to override.
    **/
    
     
    function DoDoubleClickInternal():Void;
    /**
        Called just before DLabel:DoClick. 
		
		In DLabel does nothing and is safe to override. Used by DMenuOption and DCollapsibleCategory's tabs.
    **/
    
     
    function DoClickInternal():Void;
    /**
        Called when the label is left clicked (on key release) by the player. 
		
		This will be called after DLabel:OnDepressed and DLabel:OnReleased. 
		
		 This can be overridden; by default, it calls DLabel:Toggle. 
		
		 See also DLabel:DoRightClick, DLabel:DoMiddleClick and DLabel:DoDoubleClick.
		
		___
		### Lua Examples
		#### Example 1
		Creates a label in the center of the screen, that prints I was clicked! to the console and disappears when clicked.
		
		```lua 
		local lbl = vgui.Create( "DLabel" ) -- Creates our label
		lbl:SetFont( "DermaLarge" )
		lbl:SetText( "Click me!" )
		lbl:SizeToContents()
		lbl:Center()
		lbl:SetMouseInputEnabled( true ) -- We must accept mouse input
		function lbl:DoClick() -- Defines what should happen when the label is clicked
		    print("I was clicked!")
		    self:Remove()
		end
		```
		**Output:**
		
		I was clicked! When the label is clicked.
    **/
    
    @:hook 
    function DoClick():Void;
    /**
        ***Deprecated:** Use Panel: IsEnabled instead.
		
		Gets the disabled state of the DLabel. This is set with DLabel:SetDisabled.
		
		`**Returns:** The disabled state of the label.
    **/
    @:deprecated("Use Panel: IsEnabled instead.")
     
    function GetDisabled():Bool;
    /**
        Returns whether the toggle functionality is enabled for a label. Set with DLabel:SetIsToggle.
		
		`**Returns:** Whether or not toggle functionality is enabled.
    **/
    
     
    function GetIsToggle():Bool;
    /**
        Called when the label is middle mouse (Mouse wheel, also known as mouse 3) clicked (on key release) by the player. 
		
		This will be called after DLabel:OnDepressed and DLabel:OnReleased. 
		
		 See also DLabel:DoClick, DLabel:DoRightClick and DLabel:DoDoubleClick.
    **/
    
    @:hook 
    function DoMiddleClick():Void;
    /**
        Sets the text color of the DLabel. This will take precedence over DLabel:SetTextStyleColor.
		
		Name | Description
		--- | ---
		`color` | The text color. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Changes the text color to red.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "Text Color Example" )
		frame:SetSize( 300, 100 )
		frame:Center()
		frame:MakePopup()
		
		local frame_label = vgui.Create( "DLabel", frame )
		frame_label:SetPos( 10, 30 )
		frame_label:SetTextColor( Color( 255, 0, 0) )
		```
    **/
    
     
    function SetTextColor(color:Color):Void;
    /**
        ***Deprecated:** You really should use DLabel: SetTextColor.
		
		Sets the color of the text to the dark text color defined in the skin. 
		
		See also DLabel:SetBright and DLabel:SetHighlight. 
		
		 You should only consider using this if you are using background elements that are not manually painted and are using the skin colors.
		
		Name | Description
		--- | ---
		`dark` | Whenever to set the text to dark or not.
    **/
    @:deprecated("You really should use DLabel: SetTextColor.")
     
    function SetDark(dark:Bool):Void;
    /**
        Sets the font of the label.
		
		Name | Description
		--- | ---
		`fontName` | The name of the font. See here for a list of existing fonts. Alternatively, use surface. CreateFont to create your own custom font.
    **/
    
     
    function SetFont(fontName:String):Void;
    /**
        Returns whether or not double clicking will call DLabel:DoDoubleClick. 
		
		See DLabel:SetDoubleClickingEnabled.
		
		`**Returns:** true = enabled, false means disabled
    **/
    
     
    function GetDoubleClickingEnabled():Bool;
    /**
        ***Deprecated:** Use Panel: SetEnabled instead.
		
		Sets the disabled state of the DLabel. 
		
		When disabled, the label does not respond to click, toggle or drag & drop actions.
		
		Name | Description
		--- | ---
		`disable` | true to disable the DLabel, false to enable it.
    **/
    @:deprecated("Use Panel: SetEnabled instead.")
     
    function SetDisabled(disable:Bool):Void;
    /**
        Returns the current toggle state of the label. This can be set with DLabel:SetToggle and toggled with DLabel:Toggle. 
		
		In order to use toggle functionality, you must first call DLabel:SetIsToggle with true, as it is disabled by default.
		
		`**Returns:** The current toggle state.
    **/
    
     
    function GetToggle():Bool;
    /**
        Called when the player presses the label with any mouse button. 
		
		This works as an alternative to PANEL:OnMousePressed as that hook is used heavily by DLabel and overriding it will break functionality. 
		
		 See also DLabel:DoClick, DLabel:DoMiddleClick, DLabel:DoRightClick, DLabel:OnReleased and DLabel:DoDoubleClick.
		
		___
		### Lua Examples
		#### Example 1
		Changes the text of the label when the hook is called.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "OnDepressed/Released Example" )
		frame:SetSize( 300, 100 )
		frame:Center()
		frame:MakePopup()
		
		local frame_label = vgui.Create( "DLabel", frame )
		frame_label:SetPos( 10, 30 )
		frame_label:SetTextColor( Color( 255, 255, 255 ) )
		frame_label:SetText( "Click me!" )
		frame_label:SizeToContents()
		frame_label:SetMouseInputEnabled( true )
		frame_label.OnDepressed = function( s )
		    s:SetText( "OnDepressed" )
		    frame_label:SizeToContents()
		end
		frame_label.OnReleased = function( s )
		    s:SetText( "OnReleased" )
		    frame_label:SizeToContents()
		end
		```
    **/
    
    @:hook 
    function OnDepressed():Void;
    /**
        Automatically adjusts the height of the label dependent of the height of the text inside of it.
		
		Name | Description
		--- | ---
		`stretch` | Whenever to stretch the label vertically or not.
    **/
    
     
    function SetAutoStretchVertical(stretch:Bool):Void;
    /**
        Enables or disables toggle functionality for a label. Retrieved with DLabel:GetIsToggle. 
		
		You must call this before using DLabel:SetToggle, DLabel:GetToggle or DLabel:Toggle.
		
		Name | Description
		--- | ---
		`allowToggle` | Whether or not to enable toggle functionality.
    **/
    
     
    function SetIsToggle(allowToggle:Bool):Void;
    /**
        Called when the label is right clicked (on key release) by the player. 
		
		This will be called after DLabel:OnDepressed and DLabel:OnReleased. 
		
		 See also DLabel:DoClick, DLabel:DoMiddleClick and DLabel:DoDoubleClick.
		
		___
		### Lua Examples
		#### Example 1
		Creates a label in the center of the screen, that prints I was right clicked! to the console and disappears when right clicked.
		
		```lua 
		local lbl = vgui.Create( "DLabel" )
		lbl:SetFont( "DermaLarge" )
		lbl:SetText( "Click me!" )
		lbl:SizeToContents()
		lbl:Center()
		lbl:SetMouseInputEnabled( true )
		function lbl:DoRightClick()
		    print("I was right clicked!")
		    self:Remove()
		end
		```
		**Output:**
		
		I was clicked! When the label is right clicked.
    **/
    
     
    function DoRightClick():Void;
    /**
        Sets the text value of a panel object containing text, such as a Label, TextEntry or RichText and their derivatives, such as DLabel, DTextEntry or DButton.
		
		**Warning:** When used on a Label or its derivatives ( DLabel and DButton ), it will automatically call Panel:InvalidateLayout, meaning that you should avoid running this function every frame on these panels to avoid unnecessary performance loss.
		
		Name | Description
		--- | ---
		`text` | The text value to set.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText element and sets the text to a localized string; the default VAC rejection message.
		
		```lua 
		-- Window frame for the RichText
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(250, 150)
		TextFrame:Center()
		TextFrame:SetTitle("#VAC_ConnectionRefusedTitle") -- Results in "Connection Refused - VAC"
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Set the text to the message you get when VAC banned
		richtext:SetText("#VAC_ConnectionRefusedDetail")
		```
    **/
    
     
    function SetText(text:String):Void;
    /**
        Returns the actual color of the text. 
		
		See also DLabel:GetTextColor and DLabel:GetTextStyleColor.
		
		`**Returns:** The the actual color of the text.
    **/
    
     
    function GetColor():AnyTable;
    /**
        Sets the toggle state of the label. This can be retrieved with DLabel:GetToggle and toggled with DLabel:Toggle. 
		
		In order to use toggle functionality, you must first call DLabel:SetIsToggle with true, as it is disabled by default.
		
		Name | Description
		--- | ---
		`toggleState` | The toggle state to be set.
    **/
    
     
    function SetToggle(toggleState:Bool):Void;
    /**
        Toggles the label's state. This can be set and retrieved with DLabel:SetToggle and DLabel:GetToggle. 
		
		In order to use toggle functionality, you must first call DLabel:SetIsToggle with true, as it is disabled by default.
    **/
    
     
    function Toggle():Void;
    /**
        Called when the toggle state of the label is changed by DLabel:Toggle. 
		
		In order to use toggle functionality, you must first call DLabel:SetIsToggle with true, as it is disabled by default.
		
		Name | Description
		--- | ---
		`toggleState` | The new toggle state.
    **/
    
    @:hook 
    function OnToggled(toggleState:Bool):Void;
    /**
        ***INTERNAL** 
		
		Returns the "internal" or fallback color of the text. 
		
		See also DLabel:GetTextColor and DLabel:SetTextStyleColor.
		
		`**Returns:** The "internal" color of the text
    **/
    @:deprecated("INTERNAL")
     
    function GetTextStyleColor():AnyTable;
    /**
        Returns whether the label stretches vertically or not. 
		
		Set by DLabel:SetAutoStretchVertical.
		
		`**Returns:** Whether the label stretches vertically or not.
    **/
    
     
    function GetAutoStretchVertical():Bool;
    /**
        Changes color of label. Alias of DLabel:SetTextColor.
		
		Name | Description
		--- | ---
		`color` | The color to set. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a label and changes it color to red.
		
		```lua 
		local DLabel = vgui.Create( "DLabel" )
		DLabel:SetPos( 90, 50 )
		DLabel:SetColor(Color(255, 0, 0))
		DLabel:SetText( "Hello world." )
		DLabel:SizeToContents()
		```
    **/
    
     
    function SetColor(color:AnyTable):Void;
    
}



#end