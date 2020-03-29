package gmod.panels;
#if client

/**
    A very versatile text display element that's used to power the default chat and console. 
	
	Rich Text panels allows multicolored, highlight-able, and interactive text using individual text segment markup (segments are defined by the Panel:AppendText method).
**/
extern class RichText extends Panel {
    /**
        Begins a text fade for a RichText element where the last appended text segment is fully faded out after a specific amount of time, at a specific speed. 
		
		The alpha of the text at any given time is determined by the text's base alpha * ((sustain - CurTime) / length) where CurTime is added to sustain when this method is called.
		
		Name | Description
		--- | ---
		`sustain` | The number of seconds the text remains visible.
		`length` | The number of seconds it takes the text to fade out. If set lower than sustain, the text will not begin fading out until (sustain - length) seconds have passed. If set higher than sustain, the text will begin fading out immediately at a fraction of the base alpha. If set to -1, the text doesn't fade out.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a Rich Text panel that sustains visibility for 6 seconds with a 2 second long fade-out.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(200, 200)
		TextFrame:Center()
		TextFrame:SetTitle("Fading Text")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Sample text
		richtext:SetText("This is an example of a Rich Text panel using a fade-out with:\n\n6 seconds of sustain\n\n2 second fade-out length")
		    
		-- When the panel is ready for layout, begin the fade
		function richtext:PerformLayout()
		    
		    self:SetFontInternal("Trebuchet18")
		    self:SetBGColor(Color(64, 64, 92))
		    
		    -- Wait 6 seconds, then fade out in 2 seconds
		    self:InsertFade(6, 2)
		    
		end
		```
		**Output:**
		
		Some identical example outputs are shown below, only with different length values swapped in.
		
		#### Example 2
		Create a Rich Text panel where Dr. Kleiner reads a fading message in sync with text.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(350, 100)
		TextFrame:Center()
		TextFrame:SetTitle("Kleiner says:")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)    
		
		-- Red text
		richtext:InsertColorChange(200, 60, 32, 255)
		richtext:SetVerticalScrollbarEnabled(false)
		    
		local words = {"There's", "only", "one", "hedy..."}
		local delay = 0
		
		-- Display each word in half second interval
		for w, txt in pairs(words) do
		
		    if(w == 1) then delay = 0.2
		    else delay = (w-1)*0.45 end
		
		    timer.Simple(delay, function()
		    
		        richtext:AppendText(txt.." ")
		        richtext:InsertFade(2, 1)    -- Sustain for 2 seconds while fading out after 1 second
		        
		        richtext:SetBGColor(Color(0, 0, 0))
		        richtext:SetFontInternal("DermaLarge")
		    
		    end)
		
		end
		
		-- Kleiner read along
		LocalPlayer():EmitSound("vo/k_lab2/kl_onehedy.wav")
		```
    **/
    
     
    function InsertFade(sustain:Float, length:Float):Void;
    /**
        Sets the visibility of the vertical scrollbar. 
		
		Works for RichText and TextEntry.
		
		Name | Description
		--- | ---
		`display` | True to display the vertical text scroll bar, false to hide it.
    **/
    
     
    function SetVerticalScrollbarEnabled(?display:Bool):Void;
    /**
        Resets all text fades in a RichText element made with Panel:InsertFade.
		
		Name | Description
		--- | ---
		`hold` | True to reset fades, false otherwise.
		`expiredOnly` | Any value equating to true will reset fades only on text segments that are completely faded out.
		`newSustain` | The new sustain value of each faded text segment. Set to -1 to keep the old sustain value.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText panel where two text segments slowly fade out and get reset to full alpha 5 seconds after being created.
		
		```lua 
		-- Window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(200, 100)
		TextFrame:Center()
		TextFrame:SetTitle("ResetAllFades")
		TextFrame:MakePopup()
		
		-- Rich Text panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Append text and start fading a few frames after creation (won't work otherwise)
		timer.Simple(0.05, function()
		
		    richtext:SetBGColor(Color(32, 32, 32))
		    richtext:SetFontInternal("GModNotify")
		
		    richtext:AppendText("This is ")
		    richtext:InsertFade(5, 2)
		    
		    richtext:AppendText("a test...")
		    richtext:InsertFade(5, 1)
		    
		end)
		
		-- 5 seconds after creation, reset all the fades
		timer.Simple(5, function()
		
		    richtext:ResetAllFades(true, false, -1)
		
		end)
		```
    **/
    
     
    function ResetAllFades(hold:Bool, expiredOnly:Bool, newSustain:Float):Void;
    /**
        Starts the insertion of clickable text for a RichText element. Any text appended with Panel:AppendText between this call and Panel:InsertClickableTextEnd will become clickable text. 
		
		The hook PANEL:ActionSignal is called when the text is clicked, with "TextClicked" as the signal name and signalValue as the signal value.
		
		**Note:** The clickable text is a separate Derma panel which will not inherit the current font from the RichText.
		
		Name | Description
		--- | ---
		`signalValue` | The text passed as the action signal's value.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a panel with some information on Rich Text panels along with a click-able link to the RichText page.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(250, 150)
		TextFrame:Center()
		TextFrame:SetTitle("RichText")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- First segment
		richtext:InsertColorChange(255, 255, 255, 255)
		richtext:AppendText("This is a Rich Text panel — a panel used in Source MP's default chat box and developer console.\n\nSee the ")
		
		-- Second segment
		richtext:InsertColorChange(192, 192, 255, 255)
		richtext:InsertClickableTextStart("OpenWiki")    -- Make incoming text fire the "OpenWiki" value when clicked
		richtext:AppendText("Garry's Mod Wiki")
		richtext:InsertClickableTextEnd()    -- End clickable text here
		
		-- Third segment
		richtext:InsertColorChange(255, 255, 255, 255)
		richtext:AppendText(" for information on how to use a Rich Text panel.")
		
		-- Background color
		function richtext:PerformLayout() self:SetBGColor(Color(32, 32, 46)) end
		
		-- Handle any commands we get from the panel
		function richtext:ActionSignal(signalName, signalValue)
		
		    -- Some clickable text was clicked
		    if (signalName == "TextClicked") then
		    
		        -- Open the wiki
		        if (signalValue == "OpenWiki") then
		        
		            gui.OpenURL("http://wiki.garrysmod.com/page/Category:RichText")
		        
		        end
		    
		    end
		
		end
		```
    **/
    
     
    function InsertClickableTextStart(signalValue:String):Void;
    /**
        Sets the height of a RichText element to accommodate the text inside.
		
		**Note:** This function internally relies on Panel:GetNumLines, so it should be called at least a couple frames after modifying the text using Panel:AppendText
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText panel with no set height. The proper height is applied 2 seconds after being created in order to show the difference.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(250, 210)
		TextFrame:Center()
		TextFrame:SetTitle("No set height")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:SetPos(10, 30)
		richtext:SetWidth(230)
		
		-- Block of text
		richtext:AppendText("#ServerBrowser_ServerWarning_MaxPlayers")
		
		function richtext:PerformLayout() self:SetBGColor(Color(0, 0, 0)) end
		
		-- Set to full height after 2 seconds
		timer.Simple(2, function()
		
		    richtext:SetToFullHeight()
		    
		    TextFrame:SetTitle("Full set height")
		    
		end)
		```
    **/
    
     
    function SetToFullHeight():Void;
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
        Inserts a color change in a RichText element, which affects the color of all text added with Panel:AppendText until another color change is applied.
		
		Name | Description
		--- | ---
		`r` | The red value (0 - 255).
		`g` | The green value (0 - 255).
		`b` | The blue value (0 - 255).
		`a` | The alpha value (0 - 255).
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText panel with color coding on certain segments of text.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(200, 200)
		TextFrame:Center()
		TextFrame:SetTitle("Colored text")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		richtext:SetVerticalScrollbarEnabled(false)
		
		-- Text blocks
		richtext:InsertColorChange(255, 255, 192, 255)
		richtext:AppendText("This is an example of ")
		
		richtext:InsertColorChange(0, 255, 0, 255)
		richtext:AppendText("color coding ")
		
		richtext:InsertColorChange(255, 255, 192, 255)
		richtext:AppendText("different segments of text throughout a ")
		
		richtext:InsertColorChange(255, 200, 0, 255)
		richtext:AppendText("Rich Text panel.\n\n")
		
		richtext:InsertColorChange(64, 0, 255, 255)
		richtext:AppendText("Here is another line of text shown in the color ")
		
		richtext:InsertColorChange(128, 0, 255, 255)
		richtext:AppendText("purple.")
		
		-- When the panel is ready for layout, apply font and background color
		function richtext:PerformLayout()
		    
		    self:SetFontInternal("Trebuchet18")
		    self:SetBGColor(Color(0, 16, 32))
		    
		end
		```
		
		#### Example 2
		Word by word coloring using string.Explode and random colors.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(300, 200)
		TextFrame:Center()
		TextFrame:SetTitle("Randomly Colored Words")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		richtext:SetVerticalScrollbarEnabled(false)
		
		local txt = "Here's a fun example involving word by word text coloring. "..
		"Each word is separated by a space, colored, and appended to the Rich Text panel individually. "..
		"The colors are randomly generated shades of red, orange, yellow, and pink."
		
		local txt_tbl = string.Explode(" ", txt, false)
		
		for _, word in pairs(txt_tbl) do
		
		    richtext:InsertColorChange(255, math.random(0, 255), math.random(0, 255), 255)
		    richtext:AppendText(word.." ")
		
		end
		
		function richtext:PerformLayout()
		    
		    self:SetFontInternal("GModNotify")
		    self:SetBGColor(Color(32, 16, 0))
		    
		end
		```
    **/
    
     
    function InsertColorChange(r:Float, g:Float, b:Float, a:Float):Void;
    /**
        Appends text to a RichText element. This does not automatically add a new line.
		
		Name | Description
		--- | ---
		`txt` | The text to append (add on).
    **/
    
     
    function AppendText(txt:String):Void;
    /**
        Returns the number of lines in a RichText. You must wait a couple frames before calling this after using Panel:AppendText or Panel:SetText, otherwise it will return the number of text lines before the text change.
		
		**Note:** Even though this function can be called on any panel, it will only work with RichText
		
		`**Returns:** The number of lines.
		
		___
		### Lua Examples
		#### Example 1
		Creates a rich text panel with a block of text and prints out the number of text lines before and after PerformLayout is called.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(200, 224)
		TextFrame:Center()
		TextFrame:SetTitle("Generic Frame")
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Throw some text in the panel
		richtext:SetText("This is a block of text demonstrating how line wrapping and panel size relates to the number of lines shown inside of a RichText panel.")
		
		-- Keep track of PerformLayout calls
		richtext.layoutCount = 0
		
		-- Custom function for this example
		function richtext:NumLinesExample()
		    print("PerformLayout called "..self.layoutCount.." times: "..richtext:GetNumLines().." line(s) returned")    
		end
		
		-- Print # of lines before any layouts
		richtext:NumLinesExample()
		
		-- Render update
		function richtext:PerformLayout()
		
		    self.layoutCount = self.layoutCount + 1
		    self:NumLinesExample()    -- Print current # of lines
		
		end
		```
		**Output:**
		
		The panel shows 5 lines of text, but the number 5 isn't returned until PerformLayout has been called 2 times. PerformLayout called 0 times: 1 line(s) returned
		PerformLayout called 1 times: 1 line(s) returned
		PerformLayout called 2 times: 5 line(s) returned
    **/
    
     
    function GetNumLines():Float;
    /**
        Causes a RichText element to scroll to the top of its text.
		
		**Bug:** BUG This does not work on the same frame as Panel:SetText. Issue Tracker: #2239
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText panel with a "Back to Top" button which scrolls the text to the start.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(250, 200)
		TextFrame:Center()
		TextFrame:SetTitle("#ServerBrowser_ServerWarningTitle")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Yellow colored localized text about player capacity
		richtext:InsertColorChange(255, 255, 192, 255)
		richtext:AppendText("#ServerBrowser_ServerWarning_MaxPlayers")
		
		-- Create a button that moves the text back to the start
		local topbutton = vgui.Create("DButton", richtext)
		topbutton:SetSize(60, 20)
		topbutton:SetPos(160, 146)
		topbutton:SetText("Back to Top")
		
		-- When clicked, go to the start of the text
		topbutton.DoClick = function() richtext:GotoTextStart()    end
		
		-- Apply background color and font
		function richtext:PerformLayout()
		    
		    self:SetFontInternal("Trebuchet18")
		    self:SetBGColor(Color(64, 64, 84))
		    
		end
		```
    **/
    
     
    function GotoTextStart():Void;
    /**
        Marks the end of a clickable text segment in a RichText element, started with Panel:InsertClickableTextStart.
		
		___
		### Lua Examples
		#### Example 1
		Creates a panel with some information on RichText panels along with a click-able link to the RichText page.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(250, 150)
		TextFrame:Center()
		TextFrame:SetTitle("RichText")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- First segment
		richtext:InsertColorChange(255, 255, 255, 255)
		richtext:AppendText("This is a Rich Text panel — a panel used in Source MP's default chat box and developer console.\n\nSee the ")
		
		-- Second segment
		richtext:InsertColorChange(192, 192, 255, 255)
		richtext:InsertClickableTextStart("OpenWiki")    -- Make incoming text fire the "OpenWiki" value when clicked
		richtext:AppendText("Garry's Mod Wiki")
		richtext:InsertClickableTextEnd()    -- End clickable text here
		
		-- Third segment
		richtext:InsertColorChange(255, 255, 255, 255)
		richtext:AppendText(" for information on how to use a Rich Text panel.")
		
		-- Background color
		function richtext:PerformLayout() self:SetBGColor(Color(32, 32, 46)) end
		
		-- Handle any commands we get from the panel
		function richtext:ActionSignal(signalName, signalValue)
		
		    -- Some clickable text was clicked
		    if(signalName == "TextClicked") then
		    
		        -- Open the wiki
		        if(signalValue == "OpenWiki") then
		        
		            gui.OpenURL("http://wiki.garrysmod.com/page/Category:RichText")
		        
		        end
		    
		    end
		
		end
		```
    **/
    
     
    function InsertClickableTextEnd():Void;
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
        Causes a RichText element to scroll to the bottom of its text.
    **/
    
     
    function GotoTextEnd():Void;
    
}



#end