package gmod.panels;
#if client

/**
    A standard Derma button. 
	
	By default, a DButton is 22px tall.
**/
extern class DButton extends DLabel {
    /**
        A hook called from within DLabel's PANEL:ApplySchemeSettings to determine the color of the text on display.
		
		Name | Description
		--- | ---
		`skin` | A table supposed to contain the color values listed above.
    **/
    
     
    function UpdateColours(skin:AnyTable):Void;
    /**
        ***Deprecated:** 
		
		Does absolutely nothing at all. Default value is automatically set to true.
		
		Name | Description
		--- | ---
		`draw` | Does nothing.
    **/
    @:deprecated("")
     
    function SetDrawBorder(draw:Bool):Void;
    /**
        Sets an image to be displayed as the button's background. Alias of DButton:SetImage
		
		Name | Description
		--- | ---
		`img` | The image file to use, relative to /materials. If this is nil, the image background is removed.
    **/
    
     
    function SetIcon(?img:String):Void;
    /**
        Returns the current font of the DLabel. This is set with [DLabel](https://wiki.garrysmod.com/page/Category:DLabel): [SetFont](https://wiki.garrysmod.com/page/DLabel/SetFont).
		
		`**Returns:** The name of the font in use.
    **/
    
     
    function GetFont():String;
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
        Sets a console command to be called when the button is clicked. 
		
		This overrides the button's DoClick method.
		
		Name | Description
		--- | ---
		`command` | The console command to be called.
		`args` | The arguments for the command.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a button that makes the player say their name.
		
		```lua 
		local button = vgui.Create( "DButton" )
		button:SetSize( 100, 35 )
		button:SetText( "Say your nickname" )
		button:Center()
		button:MakePopup()
		button:SetConsoleCommand( "say", LocalPlayer():Nick() )
		```
    **/
    
     
    function SetConsoleCommand(command:String, args:String):Void;
    /**
        Called when the label is middle mouse (Mouse wheel, also known as mouse 3) clicked (on key release) by the player. 
		
		This will be called after DLabel:OnDepressed and DLabel:OnReleased. 
		
		 See also DLabel:DoClick, DLabel:DoRightClick and DLabel:DoDoubleClick.
    **/
    
    @:hook 
    function DoMiddleClick():Void;
    /**
        Returns true if the DButton is currently depressed (a user is clicking on it).
		
		`**Returns:** Whether or not the button is depressed.
    **/
    
     
    function IsDown():Bool;
    /**
        Sets the font of the label.
		
		Name | Description
		--- | ---
		`fontName` | The name of the font. See here for a list of existing fonts. Alternatively, use surface. CreateFont to create your own custom font.
    **/
    
     
    function SetFont(fontName:String):Void;
    /**
        ***Deprecated:** Use Panel: SetEnabled instead.
		
		Sets whether or not the DButton is disabled. When disabled, the button is greyed out and cannot be clicked.
		
		Name | Description
		--- | ---
		`disable` | true Enable the button false Disable the button
    **/
    @:deprecated("Use Panel: SetEnabled instead.")
     
    function SetDisabled(disable:Bool):Void;
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
        ***Deprecated:** 
		
		Returns value set by DButton:SetDrawBorder. See that page for more info.
		
		`**Returns:** value set by DButton: SetDrawBorder.
    **/
    @:deprecated("")
     
    function GetDrawBorder():Bool;
    /**
        Sets an image to be displayed as the button's background. 
		
		Also see: DImageButton
		
		Name | Description
		--- | ---
		`img` | The image file to use, relative to /materials. If this is nil, the image background is removed.
    **/
    
     
    function SetImage(?img:String):Void;
    
}



#end