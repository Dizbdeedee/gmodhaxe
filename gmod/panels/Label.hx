package gmod.panels;
#if client

/**
    A basic label or "single line text area" that is non-editable.
**/
extern class Label extends Panel {
    /**
        Sets the alignment of the contents.
		
		Name | Description
		--- | ---
		`alignment` | The direction of the content, based on the number pad. 7: top-left 8: top-center 9: top-right 4: middle-left 5: center 6: middle-right 1: bottom-left 2: bottom-center 3: bottom-right
    **/
    
     
    function SetContentAlignment(alignment:Float):Void;
    /**
        Gets the size of the text within a Label derived panel.
		
		**Bug:** BUG This can return 0 incorrectly. Issue Tracker: #2576
		
		Name | Description
		--- | ---
		`a` | The width of the text in the DLabel.
		`b` | The height of the text in the DLabel.
    **/
    
     
    function GetTextSize():LabelGetTextSizeReturn;
    /**
        Gets the size of the content/children within a panel object. 
		
		Only works with Label derived panels by default such as DLabel. Will also work on any panel that manually implements this method.
		
		Name | Description
		--- | ---
		`a` | The content width of the object.
		`b` | The content height of the object.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates how to implement this function in your own panel.
		
		```lua 
		local PANEL = {}
		
		function PANEL:GetContentSize()
		    surface.SetFont( self:GetFont() )
		    return surface.GetTextSize( self:GetText() )
		end
		
		vgui.Register( "DTextEntry_Edit", PANEL, "DTextEntry" )
		
		-- Somewhere else, to test the newly created panel
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 500, 200 )
		frame:Center()
		frame:MakePopup()
		
		local txt = vgui.Create( "DTextEntry_Edit", frame )
		txt:SetPos( 5, 25 )
		txt:SetSize( 100, 10 )
		txt:SetText( "Really long string that is bigger than 100 pixels" )
		txt:SizeToContentsX( 5 ) -- Must be called after setting the text
		txt:SizeToContentsY( 5 ) -- These two functions will not have effect on a normal DTextEntry
		```
    **/
    
     
    function GetContentSize():LabelGetContentSizeReturn;
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
        Sets the left and top text margins of a text-based panel object, such as a DButton or DLabel.
		
		Name | Description
		--- | ---
		`insetX` | The left margin for the text, in pixels. This will only affect centered text if the margin is greater than its x-coordinate.
		`insetY` | The top margin for the text, in pixels.
    **/
    
     
    function SetTextInset(insetX:Float, insetY:Float):Void;
    /**
        Gets the left and top text margins of a text-based panel object, such as a DButton or DLabel. This is set with Panel:SetTextInset.
		
		Name | Description
		--- | ---
		`a` | The left margin of the text, in pixels.
		`b` | The top margin of the text, in pixels.
    **/
    
     
    function GetTextInset():LabelGetTextInsetReturn;
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
        Adds a shadow falling to the bottom right corner of the panel's text. This has no effect on panels that do not derive from Label.
		
		Name | Description
		--- | ---
		`distance` | The distance of the shadow from the panel.
		`Color` | The color of the shadow. Uses the Color structure.
    **/
    
     
    function SetExpensiveShadow(distance:Float, Color:Color):Void;
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
    
}


@:multiReturn extern class LabelGetTextSizeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class LabelGetTextInsetReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class LabelGetContentSizeReturn {
var a:Float;
var b:Float;

}

#end