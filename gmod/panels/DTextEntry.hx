package gmod.panels;
#if client

/**
    A form which may be used to display text the player is meant to select and copy or alternately allow them to enter some text of their own . Do note that at least one of your DTextEntry's parents must either be an EditablePanel or derived from it (like a DFrame, for example), else it won't be able to focus and thus be unselectable. You must also call Panel:MakePopup on said panel or the DTextEntry will not work.
	
	**Bug:** This does not clear out previously-pasted text properly. Issue Tracker: #1588
**/
extern class DTextEntry extends TextEntry {
    /**
        Sets whether pressing the Enter key will cause the DTextEntry to lose focus or not, provided it is not multiline. This is true by default.
		
		Name | Description
		--- | ---
		`allowEnter` | If set to false, pressing Enter will not cause the panel to lose focus and will never call DTextEntry: OnEnter.
    **/
    
     
    function SetEnterAllowed(allowEnter:Bool):Void;
    /**
        Called whenever enter is pressed on a DTextEntry.
		
		**Note:** DTextEntry:IsEditing will still return true in this callback!
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local TextEntry = vgui.Create( "DTextEntry" )
		TextEntry:SetTextColor( Color( 255, 0, 0, 255 ) )
		
		TextEntry.OnEnter = function()
		    TextEntry:SetTextColor( Color( 0, 0, 255, 255 ) )
		end
		```
		**Output:**
		
		Changes the text color when enter is pressed.
    **/
    
    @:hook 
    function OnEnter():Void;
    /**
        Returns the text color of a DTextEntry.
		
		`**Returns:** The color of the text as a Color structure.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local TextEntry = vgui.Create( "DTextEntry" )
		TextEntry:SetTextColor( Color( 255, 0, 0, 255 ))
		PrintTable( TextEntry:GetTextColor() )
		```
		**Output:**
		
		Prints the R, G, B and A of the text color.
    **/
    
     
    function GetTextColor():Color;
    /**
        Called by the DTextEntry when a list of autocompletion options is requested. Meant to be overridden.
		
		Name | Description
		--- | ---
		`inputText` | Player's current input.
		
		
		`**Returns:** If a table is returned, the values of the table will show up as autocomplete suggestions for the user.
		
		___
		### Lua Examples
		#### Example 1
		Shows a list of players to choose from.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 300, 300 )
		frame:SetTitle( "Autocompletion Example" )
		frame:Center()
		frame:MakePopup()
		
		local label = vgui.Create( "DLabel", frame )
		label:SetText( "Type a player..." )
		label:Dock( TOP )
		
		local textentry = vgui.Create( "DTextEntry", frame )
		textentry:Dock( TOP )
		function textentry:GetAutoComplete( text )
		    local suggestions = {}
		
		    for k,v in pairs( player.GetAll() ) do -- For every player,
		        if string.StartWith( v:Nick(), text ) then -- if the player's name starts with it...
		            table.insert( suggestions, v:Nick() ) -- ...insert it into the list.
		        end
		    end
		
		    return suggestions
		end
		```
    **/
    
    @:hook 
    function GetAutoComplete(inputText:String):AnyTable;
    /**
        Returns the contents of the DTextEntry as a number.
		
		`**Returns:** Text of the DTextEntry as a float, or nil if it cannot be converted to a number using tonumber.
    **/
    
     
    function GetFloat():Float;
    /**
        ***INTERNAL** You really should be using DTextEntry: GetAutoComplete instead.
		
		Builds a DMenu for the DTextEntry based on the input table.
		
		Name | Description
		--- | ---
		`tab` | Table containing results from DTextEntry: GetAutoComplete.
    **/
    @:deprecated("INTERNAL: You really should be using DTextEntry: GetAutoComplete instead.")
     
    function OpenAutoComplete(tab:AnyTable):Void;
    /**
        Returns whether this DTextEntry is being edited or not. (i.e. has focus)
		
		`**Returns:** Whether this DTextEntry is being edited or not
    **/
    
     
    function IsEditing():Bool;
    /**
        Similar to DTextEntry:GetFloat, but rounds the value to the nearest integer.
		
		`**Returns:** Text of the DTextEntry as a round number, or nil if it cannot be converted to a number.
    **/
    
     
    function GetInt():Float;
    /**
        Allow you to add a hint.
		
		Name | Description
		--- | ---
		`text` | 
    **/
    
     
    function SetPlaceholderText(?text:String):Void;
    /**
        ***INTERNAL** 
		
		Called internally when the text inside the DTextEntry changes. You should not override this function. Use DTextEntry:OnValueChange instead.
		
		Name | Description
		--- | ---
		`noMenuRemoval` | Determines whether to remove the autocomplete menu (false) or not (true).
    **/
    @:deprecated("INTERNAL")
     
    function OnTextChanged(noMenuRemoval:Bool):Void;
    /**
        Returns whether pressing Enter can cause the panel to lose focus. Note that a multiline DTextEntry cannot be escaped using the Enter key even when this function returns true.
		
		`**Returns:** Whether pressing the Enter key can cause the panel to lose focus.
    **/
    
     
    function GetEnterAllowed():Bool;
    /**
        Called whenever the DTextEntry gains focus.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local dTextEntry = vgui.Create("DTextEntry")
		dTextEntry:SetText("Enter text here")
		
		dTextEntry.OnGetFocus = function()
		    self:SetText("") -- Clear the text box for user input
		end
		```
		**Output:**
		
		Text entry clears when user clicks it to begin typing
    **/
    
    @:hook 
    function OnGetFocus():Void;
    /**
        Sets the cursor's color in DTextEntry (the blinking line).
		
		Name | Description
		--- | ---
		`color` | The color to set the cursor to.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a panel and a DTextEntry, and then sets the cursor color. (As seen on https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index9051.html)
		
		```lua 
		local ParentPanel = vgui.Create("DFrame")
		    ParentPanel:SetSize(ScrW()/7, ScrH()/12)
		    ParentPanel:Center()
		    ParentPanel:SetTitle("Cursor Color Test")
		    ParentPanel:SetDeleteOnClose(true)
		    ParentPanel:MakePopup()
		 
		local TextEntry = vgui.Create( "DTextEntry", ParentPanel )
		    TextEntry:SetSize(ScrW()/9, ScrH()/30)
		    TextEntry:SetValue("Cursor Color Test ")
		    TextEntry:SetPos(ParentPanel:GetWide()/2-TextEntry:GetWide()/2,
		    ParentPanel:GetTall()/2-TextEntry:GetTall()/5)
		    TextEntry:SetEnterAllowed(false)
		 
		    -- Uses Simple RGBA (Red, Green, Blue, Alpha) Colors. --
		    TextEntry:SetCursorColor(Color(255,0,0,255))
		 
		    TextEntry:RequestFocus()
		```
		**Output:**
		
		Makes the text entry's cursor color red.
    **/
    
     
    function SetCursorColor(color:AnyTable):Void;
    /**
        Sets the text of the DTextEntry and calls DTextEntry:OnValueChange.
		
		Name | Description
		--- | ---
		`text` | The value to set.
    **/
    
     
    function SetValue(text:String):Void;
    /**
        Sets whether or not to decline non-numeric characters as input. 
		
		Numeric characters are 1234567890.-
		
		Name | Description
		--- | ---
		`numericOnly` | Whether to accept only numeric characters.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local TextEntry = vgui.Create( "DTextEntry" )
		TextEntry:SetNumeric(true)
		```
		**Output:**
		
		Only allow numeric characters.
    **/
    
     
    function SetNumeric(numericOnly:Bool):Void;
    /**
        Returns whether a string is numeric or not. Always returns false if the DTextEntry:SetNumeric is set to false.
		
		Name | Description
		--- | ---
		`strValue` | The string to check.
		
		
		`**Returns:** Whether the string is numeric or not.
    **/
    
     
    function CheckNumeric(strValue:String):Bool;
    /**
        Disables Input on a DTextEntry. This differs from DTextEntry:SetDisabled - SetEditable will not affect the appearance of the textbox.
		
		Name | Description
		--- | ---
		`enabled` | Whether the DTextEntry should be editable
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local TextEntry = vgui.Create( "DTextEntry", frame ) -- create the form as a child of frame
		TextEntry:SetPos( 25, 50 )
		TextEntry:SetSize( 75, 85 )
		TextEntry:SetText( "Sample String" )
		TextEntry:SetEditable ( false)
		```
    **/
    
     
    function SetEditable(enabled:Bool):Void;
    /**
        Sets the text color of the DTextEntry.
		
		Name | Description
		--- | ---
		`color` | The text color. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Changes the text color inside the DTextEntry to the color red.
		
		```lua 
		local Frame = vgui.Create("DFrame")
		Frame:SetSize(200,200)
		Frame:Center()
		Frame:MakePopup()
		
		local TextEntry = vgui.Create("DTextEntry", Frame)
		TextEntry:SetSize(180,20)
		TextEntry:SetPos(10,80)
		TextEntry:SetTextColor(Color(255,20,20))
		TextEntry:SetValue("Basic Text")
		```
    **/
    
     
    function SetTextColor(color:Color):Void;
    /**
        Called whenever the value of the panel has been updated (whether by user input or otherwise). 
		
		It allows you to determine whether a user can modify the TextEntry's text. 
		
		 By default, this only checks whether the panel disallows numeric characters, preventing it from being edited if the value contains any. 
		
		 This is actually an engine hook that only works on TextEntry derived elements.
		
		Name | Description
		--- | ---
		`char` | The last character entered into the panel.
		
		
		`**Returns:** Return true to prevent the value from changing, false to allow it.
		
		___
		### Lua Examples
		#### Example 1
		Prevents the user from editing the text entirely.
		
		```lua 
		local TextEntry = vgui.Create( "DTextEntry" )
		TextEntry.AllowInput = function( self, stringValue )
		    return true
		end
		```
		**Output:**
		
		The panel does not allow any alterations.
    **/
    
     
    function AllowInput(char:String):Bool;
    /**
        Sets whether we should fire DTextEntry:OnValueChange every time we type or delete a character or only when Enter is pressed.
		
		Name | Description
		--- | ---
		`updateOnType` | 
    **/
    
     
    function SetUpdateOnType(updateOnType:Bool):Void;
    /**
        Called internally when the text changes of the DTextEntry are applied. (And set to the attached console variable, if one is given) 
		
		See also DTextEntry:OnChange for a function that is called on every text change, even if the console variable is not updated. 
		
		 You should override this function to define custom behavior when the text changes. 
		
		 This method is called:
		
		Name | Description
		--- | ---
		`value` | The DTextEntry text.
    **/
    
     
    function OnValueChange(value:String):Void;
    /**
        Returns whether the DTextEntry is set to run DTextEntry:OnValueChange every time a character is typed or deleted or only when Enter is pressed.
		
		`**Returns:** 
    **/
    
     
    function GetUpdateOnType():Bool;
    /**
        Changes the font of the DTextEntry.
		
		Name | Description
		--- | ---
		`font` | The name of the font to be changed to.
		
		
		___
		### Lua Examples
		#### Example 1
		Restores the original font the the DTextEntry.
		
		```lua 
		local textentry = vgui.Create("DTextEntry")
		textentry:SetFont("DermaDefault")
		```
    **/
    
     
    function SetFont(font:String):Void;
    /**
        ***Deprecated:** Use Panel: SetEnabled instead.
		
		Disables input on a DTextEntry and greys it out visually. This differs from DTextEntry:SetEditable which doesn't visually change the textbox.
		
		Name | Description
		--- | ---
		`disabled` | Whether the textbox should be disabled
    **/
    @:deprecated("Use Panel: SetEnabled instead.")
     
    function SetDisabled(disabled:Bool):Void;
    /**
        Return current color of panel placeholder
		
		`**Returns:** Current placeholder color
    **/
    
     
    function GetPlaceholderColor():AnyTable;
    /**
        Returns whether only numeric characters (123456789.-) can be entered into the DTextEntry.
		
		`**Returns:** Whether the DTextEntry is numeric or not.
    **/
    
     
    function GetNumeric():Bool;
    /**
        Called internally by DTextEntry:OnTextChanged when the user modifies the text in the DTextEntry. 
		
		You should override this function to define custom behavior when the DTextEntry text changes.
    **/
    
    @:hook 
    function OnChange():Void;
    /**
        Returns the cursor color of a DTextEntry.
		
		`**Returns:** The color of the cursor as a Color structure.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local TextEntry = vgui.Create( "DTextEntry" )
		TextEntry:SetCursorColor( Color( 255, 0, 0, 255 ))
		PrintTable( TextEntry:GetCursorColor() )
		```
		**Output:**
		
		Prints the R, G, B and A of the cursor color.
    **/
    
     
    function GetCursorColor():Color;
    /**
        Allow you to set placeholder color.
		
		Name | Description
		--- | ---
		`color` | The color of the placeholder.
    **/
    
     
    function SetPlaceholderColor(?color:AnyTable):Void;
    /**
        Called whenever a valid character is typed while the text entry is focused.
		
		**Note:** This hook only works on panels derived from TextEntry, such as DTextEntry.
		
		Name | Description
		--- | ---
		`keyCode` | They key code of the key pressed, see KEY_ Enums.
		
		
		`**Returns:** Whether you've handled the key press. Returning true prevents the default text entry behavior from occurring.
    **/
    
    @:hook 
    function OnKeyCodeTyped(keyCode:KEY):Bool;
    
}



#end