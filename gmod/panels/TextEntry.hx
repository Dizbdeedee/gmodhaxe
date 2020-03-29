package gmod.panels;
#if client

/**
    Basic text input field.
**/
extern class TextEntry extends Panel {
    /**
        Only works for TextEntries. 
		
		Pastes the contents of the clipboard into the TextEntry.
		
		**Warning:** Due to privacy concerns, this function has been disabled
		
		**Note:** Tab characters will be dropped from the pasted text
    **/
    
     
    function Paste():Void;
    /**
        Restores the last saved state (caret position and the text inside) of a TextEntry. Should act identically to pressing CTRL+Z in a TextEntry. 
		
		See also Panel:SaveUndoState.
    **/
    
     
    function Undo():Void;
    /**
        Determines whether or not a text-based panel object, such as a DTextEntry, is in multi-line mode. This is set with Panel:SetMultiline.
		
		`**Returns:** Whether the object is in multi-line mode or not.
    **/
    
     
    function IsMultiline():Bool;
    /**
        Sets the visibility of the vertical scrollbar. 
		
		Works for RichText and TextEntry.
		
		Name | Description
		--- | ---
		`display` | True to display the vertical text scroll bar, false to hide it.
    **/
    
     
    function SetVerticalScrollbarEnabled(?display:Bool):Void;
    /**
        Configures a text input to allow user to type characters that are not included in the US-ASCII (7-bit ASCII) character set. 
		
		Characters not included in US-ASCII are multi-byte characters in UTF-8. They can be accented characters, non-Latin characters and special characters.
		
		Name | Description
		--- | ---
		`allowed` | Set to true in order not to restrict input characters.
		
		
		___
		### Lua Examples
		#### Example 1
		Replaces the default vgui.Create() function to always allow non US-ASCII characters for text inputs.
		
		```lua 
		if vgui.CreateStdRestrict == nil then
		    vgui.CreateStdRestrict = vgui.Create
		end
		function vgui.Create( classname, parent, name )
		    local vgui_elt = vgui.CreateStdRestrict(classname, parent, name)
		    if classname == "DTextEntry" or classname == "RichText" or classname == "TextEntry" then
		        vgui_elt:SetAllowNonAsciiCharacters(true)
		    end
		    return vgui_elt
		end
		```
    **/
    
     
    function SetAllowNonAsciiCharacters(allowed:Bool):Void;
    /**
        Performs the "CONTROL + X" ( delete text and copy it to clipboard buffer ) action on selected text.
    **/
    
     
    function CutSelected():Void;
    /**
        Enables or disables the multi-line functionality of a text object, such as a DTextEntry.
		
		Name | Description
		--- | ---
		`multiline` | Whether to enable multiline or not.
    **/
    
     
    function SetMultiline(multiline:Bool):Void;
    /**
        Sets the font used to render this panel's text. 
		
		To retrieve the font used by a panel, call Panel:GetFont.
		
		Name | Description
		--- | ---
		`fontName` | The name of the font. See here for a list of existing fonts. Alternatively, use surface. CreateFont to create your own custom font.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the font of a RichText element to match the chat box font.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(200, 100)
		TextFrame:Center()
		TextFrame:SetTitle("This is a font test")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Sample text
		richtext:SetText("This is a sample of text using the chat box font.")
		
		-- Ensure font and text color changes are applied
		function richtext:PerformLayout()
		
		    self:SetFontInternal("ChatFont")
		    self:SetFGColor(Color(255, 255, 255))
		    
		end
		```
    **/
    
     
    function SetFontInternal(fontName:String):Void;
    /**
        Selects all the text in a panel object. Will not select non-text items; for this, use Panel:SelectAll.
    **/
    
     
    function SelectAllText():Void;
    /**
        Returns the position/offset of the caret (or text cursor) in a text-based panel object.
		
		`**Returns:** The caret position/offset from the start of the text. A value of 0 means the caret sits before the first character.
    **/
    
     
    function GetCaretPos():Float;
    /**
        Deselects all items in a panel object. For text-based objects, this will deselect all text.
    **/
    
     
    function SelectNone():Void;
    /**
        Saves the current state (caret position and the text inside) of a TextEntry as an undo state. 
		
		See also Panel:Undo.
    **/
    
     
    function SaveUndoState():Void;
    /**
        Sets the position of the caret (or text cursor) in a text-based panel object.
		
		Name | Description
		--- | ---
		`offset` | Caret position/offset from the start of text. A value of 0 places the caret before the first character.
    **/
    
     
    function SetCaretPos(offset:Float):Void;
    /**
        If called on a text entry, clicking the text entry for the first time will automatically select all of the text ready to be copied by the user.
    **/
    
     
    function SelectAllOnFocus():Void;
    /**
        Performs the "CONTROL + C" key combination effect ( Copy selection to clipboard ) on selected text.
    **/
    
     
    function CopySelected():Void;
    /**
        Selects all items within a panel or object. For text-based objects, selects all text.
    **/
    
     
    function SelectAll():Void;
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
        Used to draw the text in a DTextEntry within a derma skin. This should be called within the SKIN:PaintTextEntry skin hook.
		
		Name | Description
		--- | ---
		`textCol` | The colour of the main text.
		`highlightCol` | The colour of the selection highlight (when selecting text).
		`cursorCol` | The colour of the text cursor (or caret).
		
		
		___
		### Lua Examples
		#### Example 1
		The paint function used in the default derma skin.
		
		```lua 
		function SKIN:PaintTextEntry( panel, w, h )
		
		    if ( panel.m_bBackground ) then
		    
		        if ( panel:GetDisabled() ) then
		            self.tex.TextBox_Disabled( 0, 0, w, h )
		        elseif ( panel:HasFocus() ) then
		            self.tex.TextBox_Focus( 0, 0, w, h )
		        else
		            self.tex.TextBox( 0, 0, w, h )
		        end
		    
		    end
		    
		    panel:DrawTextEntryText( panel.m_colText, panel.m_colHighlight, panel.m_colCursor )
		    
		end
		```
    **/
    
     
    function DrawTextEntryText(textCol:AnyTable, highlightCol:AnyTable, cursorCol:AnyTable):Void;
    /**
        Sets the visibility of the language selection box in a TextEntry when typing in non-English mode. 
		
		See Panel:SetDrawLanguageIDAtLeft for a function that changes the position of the language selection box.
		
		Name | Description
		--- | ---
		`visible` | true to make it visible, false to hide it.
    **/
    
     
    function SetDrawLanguageID(visible:Bool):Void;
    /**
        Sets where to draw the language selection box. 
		
		See Panel:SetDrawLanguageID for a function that hides or shows the language selection box.
		
		Name | Description
		--- | ---
		`left` | true = left, false = right
    **/
    
     
    function SetDrawLanguageIDAtLeft(left:Bool):Void;
    
}



#end