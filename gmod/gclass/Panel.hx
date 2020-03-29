package gmod.gclass;
#if client

/**
    This is the base panel for every other VGUI panel. 
	
	It contains all of the basic methods, some of which may only work on certain VGUI elements. As their functionality is provided at the game's C/C++ level rather than by its Lua script extension, they are unfortunately unavailable for most practical purposes, however, they can still be obtained in a way similar to that provided by the baseclass library:
**/
extern class Panel {
    
    /**
        Sets the dimensions of the panel to fill its parent. It will only stretch in directions that aren't nil.
		
		Name | Description
		--- | ---
		`offsetLeft` | The left offset to the parent.
		`offsetTop` | The top offset to the parent.
		`offsetRight` | The right offset to the parent.
		`offsetBottom` | The bottom offset to the parent.
    **/
    
    public function StretchToParent(offsetLeft:Float, offsetTop:Float, offsetRight:Float, offsetBottom:Float):Void;
    
    
    /**
        Returns the Z position of the panel.
		
		`**Returns:** The Z order position of the panel.
    **/
    
    public function GetZPos():Float;
    
    
    /**
        If this panel object has been made a popup with Panel:MakePopup, this method will prevent it from drawing in front of other panels when it receives input focus.
		
		Name | Description
		--- | ---
		`stayAtBack` | If true, the popup panel will not draw in front of others when it gets focus, for example when it is clicked.
    **/
    
    public function SetPopupStayAtBack(stayAtBack:Bool):Void;
    
    
    /**
        Sets width of a panel. An alias of Panel:SetWidth.
		
		Name | Description
		--- | ---
		`width` | Desired width to set
    **/
    
    public function SetWide(width:Float):Void;
    
    
    /**
        Only works for TextEntries. 
		
		Pastes the contents of the clipboard into the TextEntry.
		
		**Warning:** Due to privacy concerns, this function has been disabled
		
		**Note:** Tab characters will be dropped from the pasted text
    **/
    
    public function Paste():Void;
    
    
    /**
        ***INTERNAL** 
		
		Used to run commands within a [DHTML](https://wiki.garrysmod.com/page/Category:DHTML) window.
		
		Name | Description
		--- | ---
		`cmd` | The command to be run.
    **/
    @:deprecated("INTERNAL")
    public function Exec(cmd:String):Void;
    
    
    /**
        Sets the size of the panel. 
		
		Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout). See also Panel:SetWidth and Panel:SetHeight.
		
		**Note:** If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find Panel:Dock useful
		
		Name | Description
		--- | ---
		`width` | The width of the panel.
		`height` | The height of the panel.
    **/
    
    public function SetSize(width:Float, height:Float):Void;
    
    
    /**
        Refreshes the HTML panel's current page.
		
		Name | Description
		--- | ---
		`ignoreCache` | If true, the refresh will ignore cached content similar to "ctrl+f5" in most browsers.
    **/
    
    public function Refresh(?ignoreCache:Bool):Void;
    
    
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
    
    public function InsertFade(sustain:Float, length:Float):Void;
    
    
    /**
        Marks a panel for deletion so it will be deleted on the next frame. 
		
		Will automatically call Panel:InvalidateParent.
    **/
    
    public function Remove():Void;
    
    
    /**
        A think hook for panels using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change. 
		
		This function is best for: text inputs, read-only inputs, dropdown selects 
		
		 For a number alternative, see Panel.ConVarNumberThink. 
		
		 Important: Make sure your Panel has a SetValue function, else you may get errors.
		
		___
		### Lua Examples
		#### Example 1
		How it should be implemented into your input.
		
		```lua 
		function PANEL:Think()
		    self:ConVarStringThink()
		end
		```
		**Output:**
		
		Panel's value is changed when the convar changes.
    **/
    
    public function ConVarStringThink():Void;
    
    
    /**
        Called to inform the dragndrop library that a mouse button is being held down on a panel object.
		
		Name | Description
		--- | ---
		`mouseCode` | The code for the mouse button pressed, passed by, for example, PANEL: OnMousePressed. See the MOUSE_ Enums.
    **/
    
    public function DragMousePress(mouseCode:MOUSE):Void;
    
    
    /**
        This makes it so that when you're hovering over this panel you can `click` on the world. Your viewmodel will aim etc. This is primarily used for the Sandbox context menu.
		
		**Bug:** BUG This function doesn't scale with custom FOV specified by GM:CalcView or WEAPON:TranslateFOV. Issue Tracker: #3467
		
		Name | Description
		--- | ---
		`enabled` | 
    **/
    
    public function SetWorldClicker(enabled:Bool):Void;
    
    
    /**
        ***Deprecated:** This function does nothing.
		
		This function does nothing.
    **/
    @:deprecated("This function does nothing.")
    public function SetPaintFunction():Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel object. This calls [Panel](https://wiki.garrysmod.com/page/Category:Panel): [SetSize](https://wiki.garrysmod.com/page/Panel/SetSize).
		
		Name | Description
		--- | ---
		`size` | A two-membered table containing the width and heights as numbers: number w - The width. number h - The height.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetSize(size:AnyTable):Void;
    
    
    /**
        Restores the last saved state (caret position and the text inside) of a TextEntry. Should act identically to pressing CTRL+Z in a TextEntry. 
		
		See also Panel:SaveUndoState.
    **/
    
    public function Undo():Void;
    
    
    /**
        Causes a SpawnIcon to rebuild its model image.
    **/
    
    public function RebuildSpawnIcon():Void;
    
    
    /**
        Focuses the next panel in the focus queue.
    **/
    
    public function FocusNext():Void;
    
    
    /**
        Returns if the panel is visible.
		
		`**Returns:** isVisible
    **/
    
    public function IsVisible():Bool;
    
    
    /**
        Copies the position of the panel.
		
		Name | Description
		--- | ---
		`base` | Panel to position the width from.
    **/
    
    public function CopyPos(base:Panel):Void;
    
    
    /**
        Paints a ghost copy of the panel at the given position.
		
		Name | Description
		--- | ---
		`posX` | The x coordinate to draw the panel from.
		`posY` | The y coordinate to draw the panel from.
    **/
    
    public function PaintAt(posX:Float, posY:Float):Void;
    
    
    /**
        Resets the panel object's Panel:SetPos method and removes its animation table (Panel.LerpAnim). This effectively undoes the changes made by Panel:LerpPositions. 
		
		In order to use Lerp animation again, you must call Panel:Stop before setting its SetPosReal property to 'nil'. See the example below.
		
		___
		### Lua Examples
		#### Example 1
		Creates a function for changing the Lerp animation speed of a panel.
		
		```lua 
		function ChangeLerpSpeed( pnl, newSpeed, ease )
		    
		    if !ispanel(pnl) or !IsValid(pnl) then return end -- Make sure panel is valid
		    
		    pnl:DisableLerp()
		    pnl:Stop()
		    pnl.SetPosReal = nil
		    
		    pnl:LerpPositions( newSpeed, ease )
		    
		end
		```
    **/
    
    public function DisableLerp():Void;
    
    
    /**
        Gets the value of a cookie stored by the panel object. This can also be done with cookie.GetString, using the panel's cookie name, a fullstop, and then the actual name of the cookie. 
		
		Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with Panel:GetCookieName and Panel:SetCookieName.
		
		Name | Description
		--- | ---
		`cookieName` | The name of the cookie from which to retrieve the value.
		`default` | The default value to return if the cookie does not exist.
		
		
		`**Returns:** The value of the stored cookie, or the default value should the cookie not exist.
    **/
    
    public function GetCookie(cookieName:String, _default:String):String;
    
    
    /**
        Enables the panel object for selection (much like the spawn menu).
		
		Name | Description
		--- | ---
		`selCanvas` | Any value other than nil or false will enable the panel object for selection. It is recommended to pass true.
    **/
    
    public function SetSelectionCanvas(selCanvas:Dynamic):Void;
    
    
    /**
        Returns whether the panel is a descendent of the given panel.
		
		Name | Description
		--- | ---
		`parentPanel` | 
		
		
		`**Returns:** True if the panel is contained within parentPanel.
    **/
    
    public function HasParent(parentPanel:Panel):Bool;
    
    
    /**
        Determines whether or not a text-based panel object, such as a DTextEntry, is in multi-line mode. This is set with Panel:SetMultiline.
		
		`**Returns:** Whether the object is in multi-line mode or not.
    **/
    
    public function IsMultiline():Bool;
    
    
    /**
        Returns true if the panel can receive mouse input.
		
		`**Returns:** mouseInputEnabled
    **/
    
    public function IsMouseInputEnabled():Bool;
    
    
    /**
        Sets the model to be displayed by [SpawnIcon](https://wiki.garrysmod.com/page/Category:SpawnIcon).
		
		**Note:** This must be called after setting size if you wish to use a different size spawnicon
		
		Name | Description
		--- | ---
		`ModelPath` | The path of the model to set
		`skin` | The skin to set
		`bodygroups` | The body groups to set. Each single-digit number in the string represents a separate bodygroup, up to 9 in total.
    **/
    
    public function SetModel(ModelPath:String, ?skin:Float, ?bodygroups:String):Void;
    
    
    /**
        Sets whether the panel object can be selected or not (like icons in the Spawn Menu, holding ⇧ Shift). If enabled, this will affect the function of a DButton whilst ⇧ Shift is pressed. Panel:SetSelected can be used to select/deselect the object.
		
		Name | Description
		--- | ---
		`selectable` | Whether the panel object should be selectable or not.
    **/
    
    public function SetSelectable(selectable:Bool):Void;
    
    
    /**
        Sets the background color of a panel such as a RichText, Label or DColorCube.
		
		**Note:** This doesn't apply to all VGUI elements and its function varies between them
		
		Name | Description
		--- | ---
		`r or color` | The red channel of the color, or a Color structure. If you pass the latter, the following three arguments are ignored.
		`g` | The green channel of the color.
		`b` | The blue channel of the color.
		`a` | The alpha channel of the color.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText panel that mimics a blue screen of death.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(300, 100)
		TextFrame:Center()
		TextFrame:SetTitle("Windows XP Blue Screen")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Sample text
		richtext:SetText("A problem has been detected and Windows has been shut down to prevent damage to your computer.\n\nMOTHERBOARD_FRIED")
		
		-- When the panel is ready for layout, set the background color to blue
		function richtext:PerformLayout()
		    
		    self:SetBGColor(Color(0, 0, 255))
		    
		end
		```
    **/
    
    public function SetBGColor(color:Color, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Sets the visibility of the vertical scrollbar. 
		
		Works for RichText and TextEntry.
		
		Name | Description
		--- | ---
		`display` | True to display the vertical text scroll bar, false to hide it.
    **/
    
    public function SetVerticalScrollbarEnabled(?display:Bool):Void;
    
    
    /**
        Gets the absolute screen position of the position specified relative to the panel. 
		
		See also Panel:ScreenToLocal.
		
		**Warning:** This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass. ie. inaccurate results may be returned if the panel or any of its ancestors have been repositioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
		
		**Note:** If the panel uses Panel:Dock, this function will return 0, 0 when the panel was created. The position will be updated in the next frame.
		
		Name | Description
		--- | ---
		`posX` | The X coordinate of the position on the panel to translate.
		`posY` | The Y coordinate of the position on the panel to translate.
		
		
		Name | Description
		--- | ---
		`a` | The X coordinate relative to the screen.
		`b` | The Y coordinate relative to the screen.
    **/
    
    public function LocalToScreen(posX:Float, posY:Float):PanelLocalToScreenReturn;
    
    
    /**
        ***INTERNAL** 
		
		***Deprecated:** 
		
		Loads controls(positions, etc) from given data. This is what the default options menu uses.
		
		Name | Description
		--- | ---
		`data` | The data to load controls from. Format unknown.
    **/
    @:deprecated("INTERNAL")
    public function LoadControlsFromString(data:String):Void;
    
    
    /**
        Sets the derma skin that the panel object will use, and refreshes all panels with derma.RefreshSkins.
		
		Name | Description
		--- | ---
		`skinName` | The name of the skin to use. The default derma skin is Default.
    **/
    
    public function SetSkin(skinName:String):Void;
    
    
    /**
        Returns the docked margins of the panel. (set by Panel:DockMargin)
		
		Name | Description
		--- | ---
		`a` | Left margin.
		`b` | Top margin.
		`c` | Right margin.
		`d` | Bottom margin.
    **/
    
    public function GetDockMargin():PanelGetDockMarginReturn;
    
    
    /**
        Centers the panel on its parent.
    **/
    
    public function Center():Void;
    
    
    /**
        Slides the panel in from above.
		
		Name | Description
		--- | ---
		`Length` | Time to complete the animation.
    **/
    
    public function SlideDown(Length:Float):Void;
    
    
    /**
        Aligns the panel on the left of its parent with the specified offset.
		
		Name | Description
		--- | ---
		`offset` | The align offset.
    **/
    
    public function AlignLeft(?offset:Float):Void;
    
    
    /**
        Goes to the page in the HTML panel's history at the specified relative offset.
		
		Name | Description
		--- | ---
		`offset` | The offset in the panel's back/forward history, relative to the current page, that you would like to skip to. Because this is relative, 0 = current page while negative goes back and positive goes forward. For example, -2 will go back 2 pages in the history.
    **/
    
    public function GoToHistoryOffset(offset:Float):Void;
    
    
    /**
        Adds the specified object to the panel.
		
		Name | Description
		--- | ---
		`object` | The panel to be added (parented). Can also be: string Class Name - creates panel with the specified name and adds it to the panel. table PANEL table - creates a panel from table and adds it to the panel.
		
		
		`**Returns:** New panel
    **/
    
    public function Add(object:Panel):Panel;
    
    
    /**
        Returns the panel's text (where applicable). 
		
		This method returns a maximum of 1023 bytes, except for DTextEntry.
		
		`**Returns:** The panel's text.
    **/
    
    public function GetText():String;
    
    
    /**
        Resizes the panel so that its width and height fit all of the content inside.
		
		**Warning:** You must call this function AFTER setting text/font, adjusting child panels or otherwise altering the panel.
		
		**Note:** Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.
    **/
    
    public function SizeToContents():Void;
    
    
    /**
        Gets valid receiver slot of currently dragged panel.
		
		Name | Description
		--- | ---
		`a` | The panel this was called on if a valid receiver slot exists, otherwise false.
		`b` | The slot table.
    **/
    
    public function GetValidReceiverSlot():PanelGetValidReceiverSlotReturn;
    
    
    /**
        ***INTERNAL** 
		
		Called to draw the drop target when an object is being dragged across another. See [Panel](https://wiki.garrysmod.com/page/Category:Panel): [SetDropTarget](https://wiki.garrysmod.com/page/Panel/SetDropTarget).
		
		Name | Description
		--- | ---
		`x` | The x coordinate of the top-left corner of the drop area.
		`y` | The y coordinate of the top-left corner of the drop area.
		`width` | The width of the drop area.
		`height` | The height of the drop area.
    **/
    @:deprecated("INTERNAL")
    public function DrawDragHover(x:Float, y:Float, width:Float, height:Float):Void;
    
    
    /**
        ***INTERNAL** 
		
		Sets the background color of the panel.
		
		Name | Description
		--- | ---
		`r` | The red channel of the color.
		`g` | The green channel of the color.
		`b` | The blue channel of the color.
		`a` | The alpha channel of the color.
    **/
    @:deprecated("INTERNAL")
    public function SetBGColorEx(r:Float, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Returns true if the panel can receive keyboard input.
		
		`**Returns:** keyboardInputEnabled
    **/
    
    public function IsKeyboardInputEnabled():Bool;
    
    
    /**
        ***INTERNAL** 
		
		Installs Lua defined functions into the panel.
    **/
    @:deprecated("INTERNAL")
    public function Prepare():Void;
    
    
    /**
        Sets the internal name of the panel.
		
		Name | Description
		--- | ---
		`name` | The new name of the panel.
    **/
    
    public function SetName(name:String):Void;
    
    
    /**
        Returns the width and height of the space between the position of the panel (upper-left corner) and the max bound of the children panels (farthest reaching lower-right corner).
		
		Name | Description
		--- | ---
		`a` | The children size width.
		`b` | The children size height.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a recursively generated box of panels where the size of each panel is determined by the parent panel's children size + 10x10 pixels.Also they flash bluish colors, just for good measure.
		
		```lua 
		-- Parent panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetSize(200, 200)
		BGPanel:Center()
		
		local panel, child_size_w, child_size_h = nil, 0, 0
		
		-- Create increasingly large blocks until children size exceeds the size of the panel
		while(BGPanel:ChildrenSize() < BGPanel:GetSize()) do
		
		    child_w, child_h = BGPanel:ChildrenSize()
		
		    panel = vgui.Create("DPanel", BGPanel)
		    panel:SetPos(0, 0)
		    
		    -- Increase size based on the children size
		    panel:SetSize(child_w+10, child_h+10)
		    
		    -- Random bluish color every frame
		    function panel:PerformLayout()
		        self:InvalidateLayout()    -- Call this again next frame
		        self:SetBackgroundColor(Color(math.random(0, 255), 255, math.random(0, 255)))
		    end
		    
		    -- Move to back so we can see the effect
		    panel:MoveToBack()
		    
		end
		```
    **/
    
    public function ChildrenSize():PanelChildrenSizeReturn;
    
    
    /**
        Sets whether this panel's drawings should be clipped within the parent panel's bounds. 
		
		See also DisableClipping and surface.DisableClipping.
		
		Name | Description
		--- | ---
		`clip` | Whether to clip or not.
    **/
    
    public function NoClipping(clip:Bool):Void;
    
    
    /**
        Sets the minimum dimensions of the panel or object. 
		
		You can restrict either or both values. 
		
		 Calling the function without arguments will remove the minimum size.
		
		Name | Description
		--- | ---
		`minW` | The minimum width of the object.
		`minH` | The minimum height of the object.
		
		
		___
		### Lua Examples
		#### Example 1
		Restricting height but not width
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 800, 600 )
		frame:SetSizable( true )
		frame:SetMinimumSize( nil, 300 )
		frame:MakePopup()
		```
    **/
    
    public function SetMinimumSize(?minW:Float, ?minH:Float):Void;
    
    
    /**
        Sets the alignment of the contents.
		
		Name | Description
		--- | ---
		`alignment` | The direction of the content, based on the number pad. 7: top-left 8: top-center 9: top-right 4: middle-left 5: center 6: middle-right 1: bottom-left 2: bottom-center 3: bottom-right
    **/
    
    public function SetContentAlignment(alignment:Float):Void;
    
    
    /**
        Gets the size of the text within a Label derived panel.
		
		**Bug:** BUG This can return 0 incorrectly. Issue Tracker: #2576
		
		Name | Description
		--- | ---
		`a` | The width of the text in the DLabel.
		`b` | The height of the text in the DLabel.
    **/
    
    public function GetTextSize():PanelGetTextSizeReturn;
    
    
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
    
    public function SetAllowNonAsciiCharacters(allowed:Bool):Void;
    
    
    /**
        Returns the internal name of the panel.
		
		`**Returns:** name
    **/
    
    public function GetName():String;
    
    
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
    
    public function ResetAllFades(hold:Bool, expiredOnly:Bool, newSustain:Float):Void;
    
    
    /**
        Enables or disables the mouse input for the panel.
		
		Name | Description
		--- | ---
		`mouseInput` | Whenever to enable or disable mouse input.
    **/
    
    public function SetMouseInputEnabled(mouseInput:Bool):Void;
    
    
    /**
        Performs the "CONTROL + X" ( delete text and copy it to clipboard buffer ) action on selected text.
    **/
    
    public function CutSelected():Void;
    
    
    /**
        Parents the panel to the HUD. Makes it invisible on the escape-menu and disables controls.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		Panel:ParentToHUD()
		```
    **/
    
    public function ParentToHUD():Void;
    
    
    /**
        Places the panel above the passed panel with the specified offset.
		
		Name | Description
		--- | ---
		`panel` | Panel to position relatively to.
		`offset` | The align offset.
    **/
    
    public function MoveAbove(panel:Panel, ?offset:Float):Void;
    
    
    /**
        Invalidates the layout of the parent of this panel object. This will cause it to re-layout, calling PANEL:PerformLayout.
		
		Name | Description
		--- | ---
		`layoutNow` | If true, the re-layout will occur immediately, otherwise it will be performed in the next frame.
    **/
    
    public function InvalidateParent(?layoutNow:Bool):Void;
    
    
    /**
        Used by AvatarImage panels to load an avatar by its 64-bit Steam ID (community ID).
		
		Name | Description
		--- | ---
		`steamid` | The 64bit SteamID of the player to load avatar of
		`size` | The size of the avatar to use. Acceptable sizes are 32, 64, 184.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a grid of randomly generated Steam avatars which link to their corresponding Steam user pages.
		
		```lua 
		-- Returns a random 64-bit Steam ID between STEAM_0:0:1 and STEAM_0:1:100000000
		function GetRandomSteamID()
		    return "7656119"..tostring(7960265728+math.random(1, 200000000))
		end
		
		-- Create the Steam User Grid
		-- Arg1: the size of each avatar
		-- Arg2: the size to load each avatar (16, 32, 64, 84, 128, 184)
		function CreateSteamUserGrid(av_size, av_res)
		
		    -- Remove this block of code if you do not mind loading thousands of avatars
		    if(av_size < 64) then
		        Error("Avatar size cannot be less than 64 square pixels.\n")
		        return
		    end
		    
		    -- Delete existing grid
		    if(SteamUserGrid) then SteamUserGrid:Remove() end
		    
		    -- The amount of avatars we can fit width-wise and height-wise
		    local w_count = math.floor(ScrW()/av_size)
		    local h_count = math.floor((ScrH()-25)/av_size)    -- 25 = frame header size
		        
		    -- Container panel
		    SteamUserGrid = vgui.Create("DFrame")
		    SteamUserGrid:SetSize(w_count*av_size, (h_count*av_size)+25)
		    SteamUserGrid:Center()
		    SteamUserGrid:SetTitle("Randomly Generated Grid of Steam Users")
		    SteamUserGrid:MakePopup()
		    
		    -- Loop variables
		    local avatar, random_id
		    
		    -- Create enough avatars to fill up screen without overflowing
		    for i = 0, (w_count*h_count)-1 do
		    
		        random_id = GetRandomSteamID()
		        
		        -- Add avatar to container panel
		        avatar = vgui.Create("AvatarImage", SteamUserGrid)
		        
		        -- Layout the avatars in a grid
		        avatar:SetPos((i%w_count)*av_size, 25+math.floor(i/w_count)*av_size)
		        
		        -- Load the avatar image
		        avatar:SetSteamID(random_id, av_res)
		
		        avatar:SetSize(av_size, av_size)
		        
		        -- Open user's Steam page on avatar click
		        avatar.OnMousePressed = function(self)
		            
		            local url = "http://steamcommunity.com/profiles/"..random_id
		            
		            gui.OpenURL(url)
		            
		        end
		        
		    end
		    
		end
		```
		**Output:**
		
		CreateSteamUserGrid(64, 64) The white question mark avatars mean no custom icon used or the user hasn't set up a community profile. The blue question mark avatars mean the user doesn't exist.
    **/
    
    public function SetSteamID(steamid:String, size:Float):Void;
    
    
    /**
        Copies position and size of the panel.
		
		Name | Description
		--- | ---
		`base` | The panel to copy size and position from.
    **/
    
    public function CopyBounds(base:Panel):Void;
    
    
    /**
        Toggles the visibility of a panel and all its children.
    **/
    
    public function ToggleVisible():Void;
    
    
    /**
        Sets the width of the panel. 
		
		Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout). See also Panel:SetSize.
		
		Name | Description
		--- | ---
		`width` | The new width of the panel.
    **/
    
    public function SetWidth(width:Float):Void;
    
    
    /**
        Causes the panel to re-layout in the next frame. During the layout process PANEL:PerformLayout will be called on the target panel. 
		
		You should avoid calling this function every frame.
		
		**Bug:** BUG Using this on a panel after clicking on a docked element will cause docked elements to reorient themselves incorrectly. This can be fixed by assigning a unique Panel.SetZPos to each docked element. Issue Tracker: #2574
		
		Name | Description
		--- | ---
		`layoutNow` | If true the panel will re-layout instantly and not wait for the next frame.
    **/
    
    public function InvalidateLayout(?layoutNow:Bool):Void;
    
    
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
    
    public function InsertClickableTextStart(signalValue:String):Void;
    
    
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
    
    public function GetContentSize():PanelGetContentSizeReturn;
    
    
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
    
    public function SetToFullHeight():Void;
    
    
    /**
        Updates a panel object's associated console variable. This must first be set up with Derma_Install_Convar_Functions, and have a ConVar set using Panel:SetConVar.
		
		Name | Description
		--- | ---
		`newValue` | The new value to set the associated console variable to.
    **/
    
    public function ConVarChanged(newValue:String):Void;
    
    
    /**
        Makes a panel invisible.
    **/
    
    public function Hide():Void;
    
    
    /**
        Makes the panel "lock" the screen until it is removed. It will silently fail if used while cursor is not visible. Call Panel:MakePopup before calling this function.
		
		**Bug:** BUG You can still click in the world even if locked. Issue Tracker: #3457
    **/
    
    public function DoModal():Void;
    
    
    /**
        Stores a string in the named cookie using Panel:GetCookieName as prefix. 
		
		You can also retrieve and modify this cookie by using the cookie library. Cookies are stored in this format: panelCookieName.cookieName
		
		**Warning:** The panel's cookie name MUST be set for this function to work. See Panel:SetCookieName.
		
		Name | Description
		--- | ---
		`cookieName` | The unique name used to retrieve the cookie later.
		`value` | The value to store in the cookie. This can be retrieved later as a string or number.
    **/
    
    public function SetCookie(cookieName:String, value:String):Void;
    
    
    /**
        Sets whenever the panel should be removed if the parent was removed.
		
		Name | Description
		--- | ---
		`autoDelete` | Whenever to delete if the parent was removed or not.
    **/
    
    public function SetAutoDelete(autoDelete:Bool):Void;
    
    
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
    
    public function SetWrap(wrap:Bool):Void;
    
    
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`objectName` | 
		`callbackName` | 
    **/
    @:deprecated("INTERNAL")
    public function NewObjectCallback(objectName:String, callbackName:String):Void;
    
    
    /**
        Finds a panel in its children(and sub children) with the given name.
		
		Name | Description
		--- | ---
		`panelName` | The name of the panel that should be found.
		
		
		`**Returns:** foundPanel
    **/
    
    public function Find(panelName:String):Panel;
    
    
    /**
        Allows the panel to receive mouse input even if the mouse cursor is outside the bounds of the panel.
		
		Name | Description
		--- | ---
		`doCapture` | Set to true to enable, set to false to disable.
    **/
    
    public function MouseCapture(doCapture:Bool):Void;
    
    
    /**
        Sets the left and top text margins of a text-based panel object, such as a DButton or DLabel.
		
		Name | Description
		--- | ---
		`insetX` | The left margin for the text, in pixels. This will only affect centered text if the margin is greater than its x-coordinate.
		`insetY` | The top margin for the text, in pixels.
    **/
    
    public function SetTextInset(insetX:Float, insetY:Float):Void;
    
    
    /**
        Returns the position of the panel relative to its Panel:GetParent. 
		
		If you require the panel's position and size, consider using Panel:GetBounds instead. If you need the position in screen space, see Panel:LocalToScreen.
		
		Name | Description
		--- | ---
		`a` | X coordinate, relative to this panels parents top left corner.
		`b` | Y coordinate, relative to this panels parents top left corner.
    **/
    
    public function GetPos():PanelGetPosReturn;
    
    
    /**
        Enables or disables the multi-line functionality of a text object, such as a DTextEntry.
		
		Name | Description
		--- | ---
		`multiline` | Whether to enable multiline or not.
    **/
    
    public function SetMultiline(multiline:Bool):Void;
    
    
    /**
        Resizes the panel object's height so that its bottom is aligned with the top of the passed panel. An offset greater than zero will reduce the panel's height to leave a gap between it and the passed panel.
		
		Name | Description
		--- | ---
		`tgtPanel` | The panel to align the bottom of this one with.
		`offset` | The gap to leave between this and the passed panel. Negative values will cause the panel's height to increase, forming an overlap.
    **/
    
    public function StretchBottomTo(tgtPanel:Panel, ?offset:Float):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel object. This calls [Panel](https://wiki.garrysmod.com/page/Category:Panel): [Dock](https://wiki.garrysmod.com/page/Panel/Dock).
		
		Name | Description
		--- | ---
		`dockState` | The dock mode to pass to the panel's Dock method. This reads a string and applies the approriate DOCK_ Enums. Right: Dock right. Left: Dock left. Bottom: Dock at the bottom. Top: Dock at the top. Fill: Fill the parent panel.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetDock(dockState:DOCK):Void;
    
    
    /**
        Deletes a cookie value using the panel's cookie name ( Panel:GetCookieName ) and the passed extension.
		
		Name | Description
		--- | ---
		`cookieName` | The unique cookie name to delete.
    **/
    
    public function DeleteCookie(cookieName:String):Void;
    
    
    /**
        Used to draw the magenta highlight colour of a panel object when it is selected. This should be called in the object's PANEL:PaintOver hook. Once this is implemented, the highlight colour will be displayed only when the object is selectable and selected. This is achieved using Panel:SetSelectable and Panel:SetSelected respectively.
    **/
    
    public function DrawSelections():Void;
    
    
    /**
        Goes forward one page in the HTML panel's history if available.
    **/
    
    public function GoForward():Void;
    
    
    /**
        Returns if the panel is going to be deleted in the next frame.
		
		`**Returns:** markedForDeletion
    **/
    
    public function IsMarkedForDeletion():Bool;
    
    
    /**
        Copies the width of the panel.
		
		Name | Description
		--- | ---
		`base` | Panel to copy the width from.
    **/
    
    public function CopyWidth(base:Panel):Void;
    
    
    /**
        Returns the alpha multiplier for this panel.
		
		`**Returns:** alphaMul
    **/
    
    public function GetAlpha():Float;
    
    
    /**
        Returns the size of the panel. 
		
		If you require both the panel's position and size, consider using Panel:GetBounds instead.
		
		Name | Description
		--- | ---
		`a` | width
		`b` | height
    **/
    
    public function GetSize():PanelGetSizeReturn;
    
    
    /**
        Enables the queue for panel animations. If enabled, the next new animation will begin after all current animations have ended. This must be called before Panel:NewAnimation to work, and only applies to the next new animation. If you want to queue many, you must call this before each.
    **/
    
    public function Queue():Void;
    
    
    /**
        Gets the left and top text margins of a text-based panel object, such as a DButton or DLabel. This is set with Panel:SetTextInset.
		
		Name | Description
		--- | ---
		`a` | The left margin of the text, in pixels.
		`b` | The top margin of the text, in pixels.
    **/
    
    public function GetTextInset():PanelGetTextInsetReturn;
    
    
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
    
    public function SetFontInternal(fontName:String):Void;
    
    
    /**
        Returns the height of the panel.
		
		`**Returns:** height
    **/
    
    public function GetTall():Float;
    
    
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
    
    public function InsertColorChange(r:Float, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Runs/Executes a string as JavaScript code in DHTML panel.
		
		**Note:** This function does NOT evaluate expression (i.e. allow you to pass variables from JavaScript (JS) to Lua context). Because a return value is nil/no value (a.k.a. void). If you wish to pass/return values from JS to Lua, you may want to use DHTML.AddFunction function to accomplish that job.
		
		Name | Description
		--- | ---
		`js` | Specify JavaScript code to be executed.
		
		
		___
		### Lua Examples
		#### Example 1
		Shows how to change document.body.innerHTML property by calling this function on DHTML panel.
		
		```lua 
		-- First we create a container, in this case it is a full-screen Derma Frame window.
		local dframe = vgui.Create( 'DFrame' )
		dframe:SetSize( ScrW(), ScrH() )
		dframe:SetTitle( "Garry's Mod Wiki" )
		dframe:Center()
		dframe:MakePopup() -- Enable keyboard and mouse interaction for DFrame panel.
		
		-- Create a new DHTML panel as a child of dframe, and dock-fill it.
		local dhtml = vgui.Create( 'DHTML', dframe )
		dhtml:Dock( FILL )
		-- Navigate to Garry's Mod wikipedia website.
		dhtml:OpenURL( 'https://wiki.garrysmod.com/index.php' )
		-- Run JavaScript code.
		dhtml:RunJavascript( [[document.body.innerHTML = 'HTML changed from Lua using JavaScript!';]] )
		
		-- This does not throw an error/exception, but instead returns nil/no value.
		-- That means you can't pass/return values from JavaScript back to Lua context using this function.
		local number = dhtml:Call( '22;' )
		print( number )
		```
		**Output:**
		
		Inner HTML of document body in DHTML panel is now set to "HTML changed from Lua using JavaScript!".
    **/
    
    public function RunJavascript(js:String):Void;
    
    
    /**
        Returns a table of all children of the panel object that are selected. This is recursive, and the returned table will include tables for any child objects that also have children. This means that not all first-level members in the returned table will be of type Panel.
		
		`**Returns:** A table of any child objects that are selected, including tables for children of the child objects (These tables may also contain table members, as the method is recursive).
    **/
    
    public function GetSelectedChildren():AnyTable;
    
    
    /**
        Sets the target area for dropping when an object is being dragged around this panel using the dragndrop library. 
		
		This draws a target box of the specified size and position, until Panel:DragHoverEnd is called. It uses Panel:DrawDragHover to draw this area.
		
		Name | Description
		--- | ---
		`x` | The x coordinate of the top-left corner of the drop area.
		`y` | The y coordinate of the top-left corner of the drop area.
		`width` | The width of the drop area.
		`height` | The height of the drop area.
    **/
    
    public function SetDropTarget(x:Float, y:Float, width:Float, height:Float):Void;
    
    
    /**
        Returns the name of the font that the panel renders its text with. 
		
		This is the same font name set with Panel:SetFontInternal.
		
		`**Returns:** fontName
    **/
    
    public function GetFont():String;
    
    
    /**
        Sets the panel to be displayed as a tooltip when a player hovers over the panel object with their cursor. Note that it will not override the default DTooltip panel.
		
		**Warning:** Calling this from PANEL:OnCursorEntered is too late! The tooltip will not be displayed or be updated.
		
		**Warning:** Given panel or the previously set one will NOT be automatically removed.
		
		**Note:** Panel:SetTooltip will override this functionality.
		
		Name | Description
		--- | ---
		`tooltipPanel` | The panel to use as the tooltip.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of this function
		
		```lua 
		local pnl = vgui.Create( "DFrame" )
		pnl:SetSize( 500, 500 )
		pnl:Center()
		pnl:MakePopup()
		
		local p = vgui.Create( "Panel" )
		p:SetSize( 100, 100 )
		p:SetVisible( false )
		p.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0 ) ) end
		
		local c = vgui.Create( "DButton", p )
		c:SetText( "test" )
		c:SetSize( 50, 50 )
		c:SetPos( 5, 5 )
		
		local b = pnl:Add( "DButton" )
		b:Dock( TOP )
		--b:SetTooltip( "test" ) -- This will stop SetTooltipPanel from working.
		b:SetTooltipPanel( p )
		```
    **/
    
    public function SetTooltipPanel(?tooltipPanel:Panel):Void;
    
    
    /**
        Moves this panel object in front of the specified sibling (child of the same parent) in the render order, and shuffles up the Z-positions of siblings now behind.
		
		Name | Description
		--- | ---
		`siblingPanel` | The panel to move this one in front of. Must be a child of the same parent panel.
		
		
		`**Returns:** false if the passed panel is not a sibling, otherwise nil.
    **/
    
    public function MoveToAfter(siblingPanel:Panel):Bool;
    
    
    /**
        Begins a box selection, enables mouse capture for the panel object, and sets the start point of the selection box to the mouse cursor's position, relative to this object. For this to work, either the object or its parent must be enabled as a selection canvas. This is set using Panel:SetSelectionCanvas.
    **/
    
    public function StartBoxSelection():Void;
    
    
    /**
        Returns the table for the derma skin currently being used by this panel object.
		
		`**Returns:** The derma skin table currently being used by this object.
    **/
    
    public function GetSkin():AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel object. This calls [Panel](https://wiki.garrysmod.com/page/Category:Panel): [SetContentAlignment](https://wiki.garrysmod.com/page/Panel/SetContentAlignment).
		
		Name | Description
		--- | ---
		`hAlign` | The alignment, as a string, to pass to Panel:SetContentAlignment. Accepts: Right: Align mid-right. Left: Align mid-left. Center: Align mid-center.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetHorizontalAlign(hAlign:String):Void;
    
    
    /**
        Selects all the text in a panel object. Will not select non-text items; for this, use Panel:SelectAll.
    **/
    
    public function SelectAllText():Void;
    
    
    /**
        Aligns the panel on the right of its parent with the specified offset.
		
		Name | Description
		--- | ---
		`offset` | The align offset.
    **/
    
    public function AlignRight(?offset:Float):Void;
    
    
    /**
        Adds a shadow falling to the bottom right corner of the panel's text. This has no effect on panels that do not derive from Label.
		
		Name | Description
		--- | ---
		`distance` | The distance of the shadow from the panel.
		`Color` | The color of the shadow. Uses the Color structure.
    **/
    
    public function SetExpensiveShadow(distance:Float, Color:Color):Void;
    
    
    /**
        Sets the height of the panel. 
		
		Calls PANEL:OnSizeChanged and marks this panel for layout (Panel:InvalidateLayout). See also Panel:SetSize.
		
		Name | Description
		--- | ---
		`height` | The height to be set.
    **/
    
    public function SetHeight(height:Float):Void;
    
    
    /**
        Sets whenever all the default border of the panel should be drawn or not.
		
		Name | Description
		--- | ---
		`paintBorder` | Whenever to draw the border or not.
    **/
    
    public function SetPaintBorderEnabled(paintBorder:Bool):Void;
    
    
    /**
        ***INTERNAL** 
		
		Called to end a drag and hover action. This resets the panel's [PANEL](https://wiki.garrysmod.com/page/Category:PANEL_Hooks): [PaintOver](https://wiki.garrysmod.com/page/PANEL/PaintOver) method, and is primarily used by [dragndrop](https://wiki.garrysmod.com/page/Category:dragndrop). [StopDragging](https://wiki.garrysmod.com/page/dragndrop/StopDragging).
    **/
    @:deprecated("INTERNAL")
    public function DragHoverEnd():Void;
    
    
    /**
        A think hook for Panels using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change. 
		
		This function is best for: checkboxes, sliders, number wangs 
		
		 For a string alternative, see Panel.ConVarStringThink. 
		
		 Important: Make sure your Panel has a SetValue function, else you may get errors.
		
		___
		### Lua Examples
		#### Example 1
		How it should be implemented into your input.
		
		```lua 
		function PANEL:Think()
		    self:ConVarNumberThink()
		end
		```
		**Output:**
		
		Panel's value is changed when the convar changes.
    **/
    
    public function ConVarNumberThink():Void;
    
    
    /**
        Focuses the panel and enables it to receive input. 
		
		This automatically calls Panel:SetMouseInputEnabled and Panel:SetKeyboardInputEnabled and sets them to true.
		
		**Note:** Panels derived from Panel will not work properly with this function. Due to this, any children will not be intractable with keyboard. Derive from EditablePanel instead.
    **/
    
    public function MakePopup():Void;
    
    
    /**
        Resizes the panel to fit the bounds of its children.
		
		**Note:** Your panel must have its layout updated (Panel:InvalidateLayout) for this function to work properly.
		
		**Note:** The sizeW and sizeH parameters are false by default. Therefore, calling this function with no arguments will result in a no-op.
		
		Name | Description
		--- | ---
		`sizeW` | Resize with width of the panel.
		`sizeH` | Resize the height of the panel.
		
		
		___
		### Lua Examples
		#### Example 1
		Using Panel:InvalidateLayout
		
		```lua 
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 300, 400 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetSizable( true )
		
		-- with :InvalidateLayout(true)
		local backgroundPanel = vgui.Create( "DPanel", Frame )
		backgroundPanel:Dock( TOP )
		backgroundPanel:DockPadding( 4, 4, 4, 4 )
		backgroundPanel:DockMargin( 0, 0, 0, 4 )
		
		local button1 = vgui.Create( "DButton", backgroundPanel )
		button1:Dock( TOP )
		button1:DockMargin( 0, 0, 0, 4 )
		button1:SetTall( 60 )
		button1:SetText( "c1" )
		
		local button2 = vgui.Create( "DButton", backgroundPanel )
		button2:Dock( TOP )
		button2:SetTall( 60 )
		button2:SetText( "c2" )
		
		backgroundPanel:InvalidateLayout( true )
		backgroundPanel:SizeToChildren( false, true )
		
		
		-- now w/o :InvalidateLayout
		local backgroundPanel = vgui.Create( "DPanel", Frame )
		backgroundPanel:Dock( TOP )
		backgroundPanel:DockPadding( 4, 4, 4, 4 )
		
		local button1 = vgui.Create( "DButton", backgroundPanel )
		button1:Dock( TOP )
		button1:DockMargin( 0, 0, 0, 4 )
		button1:SetTall( 60 )
		button1:SetText( "c1" )
		
		local button2 = vgui.Create( "DButton", backgroundPanel )
		button2:Dock( TOP )
		button2:SetTall( 60 )
		button2:SetText( "c2" )
		
		backgroundPanel:SizeToChildren( false, true )
		```
    **/
    
    public function SizeToChildren(?sizeW:Bool, ?sizeH:Bool):Void;
    
    
    /**
        Returns the parent of the panel, returns nil if there is no parent.
		
		`**Returns:** The parent of given panel
    **/
    
    public function GetParent():Panel;
    
    
    /**
        Sets the alpha multiplier for the panel
		
		Name | Description
		--- | ---
		`alpha` | The alpha value in the range of 0-255.
    **/
    
    public function SetAlpha(alpha:Float):Void;
    
    
    /**
        Used by AvatarImage to load an avatar for given player.
		
		Name | Description
		--- | ---
		`player` | The player to use avatar of.
		`size` | The size of the avatar to use. Acceptable sizes are 32, 64, 184.
    **/
    
    public function SetPlayer(player:Player, size:Float):Void;
    
    
    /**
        Sets the panels z position which determines the rendering order. 
		
		Panels with lower z positions appear behind panels with higher z positions. 
		
		 This also controls in which order panels docked with Panel:Dock appears.
		
		Name | Description
		--- | ---
		`zIndex` | The z position of the panel. Can't be lower than -32768 or higher than 32767.
    **/
    
    public function SetZPos(zIndex:Float):Void;
    
    
    /**
        Sets the tooltip to be displayed when a player hovers over the panel object with their cursor.
		
		Name | Description
		--- | ---
		`str` | The text to be displayed in the tooltip. Set false to disable it.
		
		
		___
		### Lua Examples
		#### Example 1
		To disable tooltip set first argument to false
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize(96, 96)
		frame:Center()
		frame:MakePopup(true)
		
		local icon = frame:Add("SpawnIcon")
		icon:SetPos(0, 20)
		icon:SetSize(64, 64)
		icon:SetModel("models/props_junk/watermelon01.mdl")
		icon:SetTooltip(false) -- disable tooltip for this panel
		```
    **/
    
    public function SetTooltip(str:String):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel.
		
		Name | Description
		--- | ---
		`txt` | The text to be applied to the panel.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetText(txt:String):Void;
    
    
    /**
        Completes a box selection. If the end point of the selection box is within the selection canvas, mouse capture is disabled for the panel object, and the selected state of each child object within the selection box is toggled.
		
		`**Returns:** Whether the end point of the selection box was within the selection canvas.
    **/
    
    public function EndBoxSelection():Bool;
    
    
    /**
        Forcibly updates the panels' HTML Material, similar to when Paint is called on it. This is only useful if the panel is not normally visible, i.e the panel exists purely for its HTML Material.
		
		**Note:** Only works on with panels that have a HTML Material. See Panel:GetHTMLMaterial for more details.
		
		**Note:** A good place to call this is in the GM:PreRender hook
    **/
    
    public function UpdateHTMLTexture():Void;
    
    
    /**
        Makes the panel render in front of all others, including the spawn menu and main menu. 
		
		Priority is given based on the last call, so of two panels that call this method, the second will draw in front of the first.
		
		**Note:** This only makes the panel draw above other panels. If there's another panel that would have otherwise covered it, users will not be able to interact with it.
		
		Name | Description
		--- | ---
		`drawOnTop` | Whether or not to draw the panel in front of all others.
    **/
    
    public function SetDrawOnTop(?drawOnTop:Bool):Void;
    
    
    /**
        Returns whenever the panel has child panels.
		
		`**Returns:** hasChilds
    **/
    
    public function HasChildren():Bool;
    
    
    /**
        Returns the linear distance from the centre of this panel object and another.
		
		Name | Description
		--- | ---
		`tgtPanel` | The target object with which to compare position.
		
		
		`**Returns:** The linear (straight-line) distance between the centres of the two objects.
    **/
    
    public function Distance(tgtPanel:Panel):Float;
    
    
    /**
        Sets the appearance of the cursor.
		
		Name | Description
		--- | ---
		`cursor` | The cursor to be set. Can be one of the following: arrow beam hourglass waitarrow crosshair up sizenwse sizenesw sizewe sizens sizeall no hand blank Set to anything else to set it to "none", the default fallback. Do note that a value of "none" does not, as one might assume, result in no cursor being drawn - hiding the cursor requires a value of "blank" instead.
    **/
    
    public function SetCursor(cursor:String):Void;
    
    
    /**
        Gets a child object's position relative to this panel object. The number of levels is not relevant; the child may have many parents between itself and the object on which the method is called.
		
		Name | Description
		--- | ---
		`pnl` | The panel to get the position of.
		
		
		Name | Description
		--- | ---
		`a` | The horizontal (x) position of the child relative to this panel object.
		`b` | The vertical (y) position of the child relative to this panel object.
    **/
    
    public function GetChildPosition(pnl:Panel):PanelGetChildPositionReturn;
    
    
    /**
        Returns whether the panel contains the given panel, recursively.
		
		Name | Description
		--- | ---
		`childPanel` | 
		
		
		`**Returns:** True if the panel contains childPanel.
    **/
    
    public function IsOurChild(childPanel:Panel):Bool;
    
    
    /**
        Resizes the panel object's width so that its right edge is aligned with the left of the passed panel. An offset greater than zero will reduce the panel's width to leave a gap between it and the passed panel.
		
		Name | Description
		--- | ---
		`tgtPanel` | The panel to align the right edge of this one with.
		`offset` | The gap to leave between this and the passed panel. Negative values will cause the panel's width to increase, forming an overlap.
    **/
    
    public function StretchRightTo(tgtPanel:Panel, ?offset:Float):Void;
    
    
    /**
        Recursively deselects this panel object and all of its children. This will cascade to all child objects at every level below the parent.
    **/
    
    public function UnselectAll():Void;
    
    
    /**
        ***Deprecated:** Alias of Panel: SetTooltip.
    **/
    @:deprecated("Alias of Panel: SetTooltip.")
    public function SetToolTip():Void;
    
    
    /**
        Returns a table of all visible, selectable children of the panel object that lie at least partially within the specified rectangle.
		
		Name | Description
		--- | ---
		`x` | The horizontal (x) position of the top-left corner of the rectangle, relative to the panel object.
		`y` | The vertical (y) position of the top-left corner of the rectangle, relative to the panel object.
		`w` | The width of the rectangle.
		`h` | The height of the rectangle.
		
		
		`**Returns:** A table of panel objects that lie at least partially within the specified rectangle.
    **/
    
    public function GetChildrenInRect(x:Float, y:Float, w:Float, h:Float):AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Called by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [DragMouseRelease](https://wiki.garrysmod.com/page/Panel/DragMouseRelease) when a user clicks one mouse button whilst dragging with another.
		
		`**Returns:** Always returns true.
    **/
    @:deprecated("INTERNAL")
    public function DragClick():Bool;
    
    
    /**
        Returns the width of the panel.
		
		`**Returns:** width
    **/
    
    public function GetWide():Float;
    
    
    /**
        Aligns the panel on the top of its parent with the specified offset.
		
		Name | Description
		--- | ---
		`offset` | The align offset.
    **/
    
    public function AlignTop(?offset:Float):Void;
    
    
    /**
        Sets the "visibility" of the panel.
		
		Name | Description
		--- | ---
		`visible` | The visibility of the panel.
    **/
    
    public function SetVisible(visible:Bool):Void;
    
    
    /**
        Focuses the previous panel in the focus queue.
    **/
    
    public function FocusPrevious():Void;
    
    
    /**
        Returns if the panel is focused.
		
		`**Returns:** hasFocus
    **/
    
    public function HasFocus():Bool;
    
    
    /**
        Resizes the panel object's width to accommodate all child objects/contents. 
		
		Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented Panel:GetContentSize method.
		
		**Note:** You must call this function AFTER setting text/font or adjusting child panels.
		
		Name | Description
		--- | ---
		`addVal` | The number of extra pixels to add to the width. Can be a negative number, to reduce the width.
    **/
    
    public function SizeToContentsX(?addVal:Float):Void;
    
    
    /**
        Returns the child of this panel object that is closest to the specified point. The point is relative to the object on which the method is called. The distance the child is from this point is also returned.
		
		Name | Description
		--- | ---
		`x` | The horizontal (x) position of the point.
		`y` | The vertical (y) position of the point.
		
		
		Name | Description
		--- | ---
		`a` | The child object that was closest to the specified point.
		`b` | The distance that this child was from the point.
    **/
    
    public function GetClosestChild(x:Float, y:Float):PanelGetClosestChildReturn;
    
    
    /**
        Returns the amount of children of the of panel.
		
		`**Returns:** The amount of children the panel has.
    **/
    
    public function ChildCount():Float;
    
    
    /**
        Attempts to obtain focus for this panel.
    **/
    
    public function RequestFocus():Void;
    
    
    /**
        Sets the enabled state of a disable-able panel object, such as a DButton or DTextEntry. 
		
		See Panel:IsEnabled for a function that retrieves the "enabled" state of a panel.
		
		Name | Description
		--- | ---
		`enable` | Whether to enable or disable the panel object.
    **/
    
    public function SetEnabled(enable:Bool):Void;
    
    
    /**
        Returns the panel object (self) if it has been enabled as a selection canvas. This is achieved using Panel:SetSelectionCanvas.
		
		`**Returns:** The panel object this method was called on if enabled as a selection canvas, otherwise nil.
    **/
    
    public function GetSelectionCanvas():Panel;
    
    
    /**
        Enables or disables animations for the panel object by overriding the PANEL:AnimationThink hook to nil and back.
		
		Name | Description
		--- | ---
		`enable` | Whether to enable or disable animations.
    **/
    
    public function SetAnimationEnabled(enable:Bool):Void;
    
    
    /**
        Gets the name the panel uses to store cookies. This is set with Panel:SetCookieName.
		
		`**Returns:** The name the panel uses when reading or writing cookies. The format used is as follows: panelCookieName.individualCookieName
    **/
    
    public function GetCookieName():String;
    
    
    /**
        Gets a child by its index.
		
		**Note:** This index starts at 0, except when you use this on a DMenu.
		
		Name | Description
		--- | ---
		`childIndex` | The index of the child to get. NOTE This index starts at 0, except when you use this on a DMenu.
    **/
    
    public function GetChild(childIndex:Float):Void;
    
    
    /**
        ***INTERNAL** 
		
		Sets the foreground color of the panel. For labels, this is the color of their text.
		
		Name | Description
		--- | ---
		`r` | The red channel of the color.
		`g` | The green channel of the color.
		`b` | The blue channel of the color.
		`a` | The alpha channel of the color.
    **/
    @:deprecated("INTERNAL")
    public function SetFGColorEx(r:Float, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Returns a table with all the child panels of the panel.
		
		`**Returns:** children
		
		___
		### Lua Examples
		#### Example 1
		Print the classnames of the children on the panel
		
		```lua 
		for i, v in ipairs(panel:GetChildren()) do
		    print(v:GetClassName())
		end
		```
    **/
    
    public function GetChildren():AnyTable;
    
    
    /**
        Returns the cursor position local to the position of the panel (usually the upper-left corner).
		
		Name | Description
		--- | ---
		`a` | The x coordinate
		`b` | The y coordinate
		
		
		___
		### Lua Examples
		#### Example 1
		Create and center a label panel and update its text with the local cursor position.
		
		```lua 
		TestLabel = vgui.Create("DLabel")
		TestLabel:SetSize(100, 20)
		TestLabel:Center()
		TestLabel:SetPaintBackgroundEnabled(true)
		TestLabel:SetColor(Color(255, 0, 0))
		
		local x, y = 0, 0
		
		function TestLabel:PerformLayout()
		
		    x, y = self:LocalCursorPos()
		
		    self:SetText(" X: "..x.." , Y: "..y)
		    
		end
		```
    **/
    
    public function LocalCursorPos():PanelLocalCursorPosReturn;
    
    
    /**
        Returns the position/offset of the caret (or text cursor) in a text-based panel object.
		
		`**Returns:** The caret position/offset from the start of the text. A value of 0 means the caret sits before the first character.
    **/
    
    public function GetCaretPos():Float;
    
    
    /**
        Places the panel below the passed panel with the specified offset.
		
		Name | Description
		--- | ---
		`panel` | Panel to position relatively to.
		`offset` | The align offset.
    **/
    
    public function MoveBelow(panel:Panel, ?offset:Float):Void;
    
    
    /**
        Moves this panel object behind the specified sibling (child of the same parent) in the render order, and shuffles up the Panel:SetZPos of siblings now in front.
		
		Name | Description
		--- | ---
		`siblingPanel` | The panel to move this one behind. Must be a child of the same parent panel.
		
		
		`**Returns:** false if the passed panel is not a sibling, otherwise nil.
    **/
    
    public function MoveToBefore(siblingPanel:Panel):Bool;
    
    
    /**
        When TAB is pressed, the next selectable panel in the number sequence is selected.
		
		Name | Description
		--- | ---
		`position` | 
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a menu to put information in with SetTablePosition application.
		
		```lua 
		local Panel = vgui.Create("DFrame")
		Panel:SetSize(500,250)
		Panel:Center()
		Panel:SetText("My Information")
		Panel:MakePopup()
		
		local FirstName = vgui.Create("DTextEntry", Panel)
		FirstName:SetSize(400,35)
		FirstName:SetPos(50, 50)
		FirstName:SetPlaceholderText("First Name")
		FirstName:SetTabPosition( 1 )
		
		local LastName = vgui.Create("DTextEntry", Panel)
		LastName:SetSize(400,35)
		LastName:SetPos(50, 100)
		LastName:SetPlaceholderText("Last Name")
		LastName:SetTabPosition( 2 )
		
		local FavoriteColor = vgui.Create("DTextEntry", Panel)
		FavoriteColor:SetSize(400,35)
		FavoriteColor:SetPos(50, 150)
		FavoriteColor:SetPlaceholderText("Favorite Color")
		FavoriteColor:SetTabPosition( 3 )
		
		local CompletedButton = vgui.Create("DButton", Panel)
		CompletedButton:SetSize(200,35)
		CompletedButton:SetPos(150, 200)
		CompletedButton:SetText("Done")
		function CompletedButton:DoClick()
		    LocalPlayer():ConCommand("say My name is " .. FirstName:GetText() .. " " .. LastName:GetText() .. " and my favorite color is " .. FavoriteColor:GetText() .. "!")
		    Panel:Remove()
		end
		```
		**Output:**
		
		A Panel with a functional TAB Button.
    **/
    
    public function SetTabPosition(position:Float):Void;
    
    
    /**
        Deselects all items in a panel object. For text-based objects, this will deselect all text.
    **/
    
    public function SelectNone():Void;
    
    
    /**
        Re-renders a spawn icon with customized cam data. 
		
		PositionSpawnIcon can be used to easily calculate the necessary camera parameters.
		
		**Note:** This function does not accept the standard CamData structure.
		
		Name | Description
		--- | ---
		`data` | A four-membered table containing the information needed to re-render: Vector cam_pos - The relative camera position the model is viewed from. Angle cam_ang - The camera angle the model is viewed from. number cam_fov - The camera's field of view (FOV). Entity ent - The entity object of the model. See the example below for how to retrieve these values.
		
		
		___
		### Lua Examples
		#### Example 1
		The RenderIcon method used by IconEditor. SpawnIcon is a SpawnIcon and ModelPanel is a DAdjustableModelPanel.
		
		```lua 
		function PANEL:RenderIcon()
		    
		    local ent = self.ModelPanel:GetEntity()
		    
		    local tab = {}
		    tab.ent        = ent
		    tab.cam_pos = self.ModelPanel:GetCamPos()
		    tab.cam_ang = self.ModelPanel:GetLookAng()
		    tab.cam_fov = self.ModelPanel:GetFOV()
		
		    self.SpawnIcon:RebuildSpawnIconEx( tab )
		end
		```
    **/
    
    public function RebuildSpawnIconEx(data:AnyTable):Void;
    
    
    /**
        Draws a hollow rectangle the size of the panel object this method is called on, with a border width of 1 px. The border colour is set using surface.SetDrawColor. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawOutlinedRect.
    **/
    
    public function DrawOutlinedRect():Void;
    
    
    /**
        Sets a new image to be loaded by a TGAImage.
		
		Name | Description
		--- | ---
		`imageName` | The file path.
		`strPath` | The PATH to search in. See File Search Paths. This isn't used internally.
    **/
    
    public function LoadTGAImage(imageName:String, strPath:String):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel object. This calls [Panel](https://wiki.garrysmod.com/page/Category:Panel): [SetPos](https://wiki.garrysmod.com/page/Panel/SetPos).
		
		Name | Description
		--- | ---
		`pos` | A two-membered table containing the x and y coordinates as numbers: number x - The x coordinate. number y - The y coordinate.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetPosition(pos:AnyTable):Void;
    
    
    /**
        Enables or disables painting of the panel manually with Panel:PaintManual.
		
		Name | Description
		--- | ---
		`paintedManually` | True if the panel should be painted manually.
    **/
    
    public function SetPaintedManually(paintedManually:Bool):Void;
    
    
    /**
        Aligns the panel on the bottom of its parent with the specified offset.
		
		Name | Description
		--- | ---
		`offset` | The align offset.
    **/
    
    public function AlignBottom(?offset:Float):Void;
    
    
    /**
        Appends text to a RichText element. This does not automatically add a new line.
		
		Name | Description
		--- | ---
		`txt` | The text to append (add on).
    **/
    
    public function AppendText(txt:String):Void;
    
    
    /**
        Allows the panel to receive drag and drop events. Can be called multiple times with different names to receive multiple different draggable panel events.
		
		Name | Description
		--- | ---
		`name` | Name of DnD panels to receive. This is set on the drag'n'drop-able panels via Panel: Droppable
		`func` | This function is called whenever a panel with valid name is hovering above and dropped on this panel. It has next arguments: Panel pnl - The receiver panel table tbl - A table of panels dropped onto receiver panel boolean dropped - False if hovering over, true if dropped onto number menuIndex - Index of clicked menu item from third argument of Panel:Receiver number x - Cursor pos, relative to the receiver number y - Cursor pos, relative to the receiver
		`menu` | A table of strings that will act as a menu if drag'n'drop was performed with a right click
		
		
		___
		### Lua Examples
		#### Example 1
		A very simple drag'n'drop example without using DDragBase.
		
		```lua 
		local function DoDrop( self, panels, bDoDrop, Command, x, y )
		    if ( bDoDrop ) then
		        for k, v in pairs( panels ) do
		            self:AddItem( v )
		        end
		    end
		end
		
		concommand.Add( "test2", function()
		
		    local frame = vgui.Create( "DFrame" )
		    frame:SetSize( 500, 300 )
		    frame:SetTitle( "Frame" )
		    frame:MakePopup()
		    frame:Center()
		
		    local left = vgui.Create( "DScrollPanel", frame )
		    left:Dock( LEFT )
		    left:SetWidth( frame:GetWide() / 2 - 7 )
		    left:SetPaintBackground( true )
		    left:DockMargin( 0, 0, 4, 0 )
		    left:Receiver( "myDNDname", DoDrop ) -- Make the panel a receiver for drag and drop events
		
		    local right = vgui.Create( "DScrollPanel", frame )
		    right:Dock( FILL )
		    right:SetPaintBackground( true )
		    right:Receiver( "myDNDname", DoDrop )
		
		    for i = 1, 30 do
		        local but = vgui.Create( "DButton" )
		        but:SetText( i )
		        but:SetSize( 36, 24 )
		        but:Dock( TOP )
		        but:Droppable( "myDNDname" ) -- make the panel be able to be drag'n'dropped onto other panels
		        right:AddItem( but )
		    end
		
		end )
		```
    **/
    
    public function Receiver(name:String, func:Function, menu:AnyTable):Void;
    
    
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
    
    public function GetNumLines():Float;
    
    
    /**
        Saves the current state (caret position and the text inside) of a TextEntry as an undo state. 
		
		See also Panel:Undo.
    **/
    
    public function SaveUndoState():Void;
    
    
    /**
        Remove the focus from the panel.
    **/
    
    public function KillFocus():Void;
    
    
    /**
        Sets the panel that owns this FocusNavGroup to be the root in the focus traversal hierarchy.
		
		Name | Description
		--- | ---
		`state` | 
    **/
    
    public function SetFocusTopLevel(state:Bool):Void;
    
    
    /**
        Returns the distance between the centre of this panel object and a specified point (local to the parent panel).
		
		Name | Description
		--- | ---
		`posX` | The horizontal (x) position in pixels of the point to compare with. Local to the parent panel, or container.
		`posY` | The vertical (y) position in pixels of the point to compare with. Local to the parent panel, or container.
		
		
		`**Returns:** The linear (straight-line) distance between the specified point and the centre of the panel object.
    **/
    
    public function DistanceFrom(posX:Float, posY:Float):Float;
    
    
    /**
        Uses animation to transition the current alpha value of a panel to a new alpha, over a set period of time and after a specified delay.
		
		Name | Description
		--- | ---
		`alpha` | The alpha value (0-255) to approach.
		`duration` | The time in seconds it should take to reach the alpha.
		`delay` | The delay before the animation starts.
		`callback` | The function to be called once the animation finishes. Arguments are: table animData - The AnimationData structure that was used. Panel pnl - The panel object whose alpha was changed.
    **/
    
    public function AlphaTo(alpha:Float, duration:Float, ?delay:Float, callback:AnimationData):Void;
    
    
    /**
        ***INTERNAL** 
		
		Performs the per-frame operations required for panel animations. This is called every frame by PANEL:AnimationThink.
    **/
    @:deprecated("INTERNAL")
    public function AnimationThinkInternal():Void;
    
    
    /**
        Sets the URL of a link-based panel such as [DLabelURL](https://wiki.garrysmod.com/page/Category:DLabelURL).
		
		Name | Description
		--- | ---
		`url` | The URL to set. This must begin with http://.
    **/
    
    public function SetURL(url:String):Void;
    
    
    /**
        Sets the position of the caret (or text cursor) in a text-based panel object.
		
		Name | Description
		--- | ---
		`offset` | Caret position/offset from the start of text. A value of 0 places the caret before the first character.
    **/
    
    public function SetCaretPos(offset:Float):Void;
    
    
    /**
        Creates a new animation for the panel object. 
		
		Methods that use this function:
		
		Name | Description
		--- | ---
		`length` | The length of the animation in seconds.
		`delay` | The delay before the animation starts.
		`ease` | The power/index to use for easing. Positive values greater than 1 will ease in; the higher the number, the sharper the curve's gradient (less linear). A value of 1 removes all easing. Positive values between 0 and 1 ease out; values closer to 0 increase the curve's gradient (less linear). A value of 0 will break the animation and should be avoided. Any value less than zero will ease in/out; the value has no effect on the gradient.
		`callback` | The function to be called when the animation ends. Arguments passed are: table animTable - The AnimationData structure that was used. Panel tgtPanel - The panel object that was animated.
		
		
		`**Returns:** Partially filled AnimationData structure with members: number EndTime - Equal to length and delay arguments added together, plus either the SysTime if there is no other animation queued or the end time of the last animation in the queue. number StartTime - Equal to the delay argument, plus either the SysTime if there is no other animation queued or the end time of the last animation in the queue. number Ease - Equal to the ease argument. function OnEnd - Equal to the callback argument.
		
		___
		### Lua Examples
		#### Example 1
		Example on how to use this function, makes a button go around in a circle in a DFrame.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 500, 500 )
		frame:Center()
		frame:MakePopup()
		
		local butt = frame:Add( "DButton" )
		butt:SetPos( 5, 30 )
		butt:SetSize( 100, 40 )
		
		function butt:doAnim()
		    local anim = self:NewAnimation( 10, 0, 1, function( anim, pnl )
		        self:doAnim()
		    end )
		
		    anim.Think = function( anim, pnl, fraction )
		        local radius = 200
		        pnl:SetPos( 250 + math.sin( Lerp( fraction, -math.pi, math.pi ) ) * radius - pnl:GetWide() / 2,
		                    250 + math.cos( Lerp( fraction, -math.pi, math.pi ) ) * radius - pnl:GetTall() / 2 )
		
		        pnl:SetText( "Frac: " .. fraction .. "\nTime: " .. ( SysTime() - anim.StartTime ) )
		    end
		end
		butt:doAnim()
		```
    **/
    
    public function NewAnimation(length:Float, ?delay:Float, ?ease:Float, ?callback:AnimationData):AnimationData;
    
    
    /**
        Returns the internal Lua table of the panel.
		
		`**Returns:** A table containing all the members of given panel object.
    **/
    
    public function GetTable():AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a [DNumberWang](https://wiki.garrysmod.com/page/Category:DNumberWang), [Slider](https://wiki.garrysmod.com/page/Category:Slider), [DNumSlider](https://wiki.garrysmod.com/page/Category:DNumSlider) or [DNumberScratch](https://wiki.garrysmod.com/page/Category:DNumberScratch). This calls  on one of the previously listed methods.
		
		Name | Description
		--- | ---
		`minValue` | The minimum value the element is to permit.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetMin(minValue:Float):Void;
    
    
    /**
        Returns if the panel object is selected (like icons in the Spawn Menu, holding ⇧ Shift). This can be set in Lua using Panel:SetSelected.
		
		`**Returns:** Whether the panel object is selected or not. Always returns false if the object is not selectable. This can be modified using Panel: SetSelectable.
    **/
    
    public function IsSelected():Bool;
    
    
    /**
        Returns the panel's HTML material. Only works with Awesomium, HTML and DHTML panels that have been fully loaded.
		
		`**Returns:** The HTML material used by the panel. Typically starts with "__vgui_texture_" followed by an incremental number.
		
		___
		### Lua Examples
		#### Example 1
		Defines a new entity which can display a web page on a TV screen.
		
		```lua 
		AddCSLuaFile()
		
		ENT.Type = "anim"
		ENT.Base = "base_entity"
		
		ENT.PrintName = "Web Screen"
		ENT.Author = "Microflash"
		ENT.Spawnable = true
		
		if ( CLIENT ) then
		    ENT.Mat = nil
		    ENT.Panel = nil
		end
		
		function ENT:Initialize()
		
		    if ( SERVER ) then
		        
		        self:SetModel("models/props_phx/rt_screen.mdl")
		        self:SetMoveType(MOVETYPE_VPHYSICS)
		        self:SetSolid(SOLID_VPHYSICS)
		        
		        self:PhysicsInit(SOLID_VPHYSICS)
		        
		        self:Freeze()
		        
		    else
		    
		        -- Reset material and panel and load DHTML panel
		        self.Mat = nil
		        self.Panel = nil
		        self:OpenPage()
		        
		    end
		    
		end
		
		function ENT:Freeze()
		    local phys = self:GetPhysicsObject()
		    if (IsValid(phys)) then phys:EnableMotion(false) end
		end
		
		-- Load the DHTML reference panel
		function ENT:OpenPage()
		
		    -- Iff for some reason a panel is already loaded, delete it
		    if(self.Panel) then
		    
		        self.Panel:Remove()
		        self.Panel = nil
		    
		    end
		
		    -- Create a web page panel and fill the entire screen
		    self.Panel = vgui.Create("DHTML")
		    self.Panel:Dock(FILL)
		    
		    -- Wiki page URL
		    local url = "http://wiki.garrysmod.com/page/Category:Material"
		    
		    -- Load the wiki page
		    self.Panel:OpenURL(url)
		    
		    -- Hide the panel
		    self.Panel:SetAlpha(0)
		    self.Panel:SetMouseInputEnabled(false)
		    
		    -- Disable HTML messages
		    function self.Panel:ConsoleMessage(msg) end
		
		end
		
		function ENT:Draw()
		
		    -- Iff the material has already been grabbed from the panel
		    if(self.Mat) then
		        
		        -- Apply it to the screen/model
		        if(render.MaterialOverrideByIndex) then
		            render.MaterialOverrideByIndex(1, self.Mat)
		        else
		            render.ModelMaterialOverride(self.Mat)
		        end
		        
		    -- Otherwise, check that the panel is valid and the HTML material is finished loading
		    elseif(self.Panel && self.Panel:GetHTMLMaterial()) then
		
		        -- Get the html material
		        local html_mat = self.Panel:GetHTMLMaterial()
		        
		        -- Used to make the material fit the model screen
		        -- May need to be changed iff using a different model
		        -- For the multiplication number it goes in segments of 512
		        -- Based off the players screen resolution
		        local scale_x, scale_y = ScrW()/2048, ScrH()/1024
		        
		        -- Create a new material with the proper scaling and shader
		        local matdata =
		        {
		            ["$basetexture"]=html_mat:GetName(),
		            ["$basetexturetransform"]="center 0 0 scale "..scale_x.." "..scale_y.." rotate 0 translate 0 0",
		            ["$model"]=1
		        }
		        -- Unique ID used for material name
		        local uid = string.Replace(html_mat:GetName(), "__vgui_texture_", "")
		        
		        -- Create the model material
		        self.Mat = CreateMaterial("WebMaterial_"..uid, "VertexLitGeneric", matdata)
		    
		    end
		
		    -- Render the model
		    self:DrawModel()
		    
		    -- Reset the material override or else everything will have a HTML material!
		    render.ModelMaterialOverride(nil)
		
		end
		
		function ENT:OnRemove()
		    -- Make sure the panel is removed too
		    if(self.Panel) then self.Panel:Remove() end
		end
		```
    **/
    
    public function GetHTMLMaterial():IMaterial;
    
    
    /**
        Sets the dock type of the panel.
		
		**Note:** After using this function, if you want to get the correct panel's bounds (position, size), use Panel:InvalidateParent (use true as argument if you need to update immediately)
		
		Name | Description
		--- | ---
		`dockType` | Dock type using DOCK_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Example docking including DockMargin. Provided by Walrus Viking in this Facepunch post.
		
		```lua 
		local f = vgui.Create( "DFrame" )
		f:SetTitle( "Dock Test" )
		f:SetSize( 256, 256 )
		f:Center()
		f:MakePopup()
		
		local p = vgui.Create( "DPanel", f )
		p:Dock( FILL )
		p:DockMargin( 0, 0, 0, 0 )
		
		for i = 0, 10, 1 do
		    local l = vgui.Create( "DLabel", p )
		    l:Dock( TOP )
		    l:DockMargin( 4, 0, 0, 0 ) -- shift to the right
		    l:SetColor( color_black )
		    l:SetText( "Hi! I'm a label!" )
		end
		```
		
		#### Example 2
		Example showing how multiple docked elements behave.
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize(600, 300)
		frame:SetTitle("Docking Demonstration")
		frame:Center()
		frame:MakePopup(true)
		
		local panel = vgui.Create("DPanel", frame) --Create a panel on the left
		panel:SetSize(300, 0) --Height doesn't matter since we're docking it to the left anyways
		panel:Dock(LEFT)
		local fill = vgui.Create("DButton", panel) --Create a button and dock it
		fill:SetText("FILL")
		fill:Dock(FILL)
		local left = vgui.Create("DButton", panel)
		left:SetText("LEFT")
		left:Dock(LEFT)
		local right = vgui.Create("DButton", panel)
		right:SetText("RIGHT")
		right:Dock(RIGHT)
		local top = vgui.Create("DButton", panel)
		top:SetText("TOP")
		top:Dock(TOP)
		local bottom = vgui.Create("DButton", panel)
		bottom:SetText("BOTTOM")
		bottom:Dock(BOTTOM)
		
		local panel = vgui.Create("DPanel", frame) --Do the same thing on the right, but this time with top and bottom before left and right
		panel:SetSize(300, 0)
		panel:Dock(RIGHT)
		local fill = vgui.Create("DButton", panel)
		fill:SetText("FILL")
		fill:Dock(FILL)
		local top = vgui.Create("DButton", panel)
		top:SetText("TOP")
		top:Dock(TOP)
		local bottom = vgui.Create("DButton", panel)
		bottom:SetText("BOTTOM")
		bottom:Dock(BOTTOM)
		local left = vgui.Create("DButton", panel)
		left:SetText("LEFT")
		left:Dock(LEFT)
		local right = vgui.Create("DButton", panel)
		right:SetText("RIGHT")
		right:Dock(RIGHT)
		```
    **/
    
    public function Dock(dockType:DOCK):Void;
    
    
    /**
        Sets whenever the panel should be rendered in the next screenshot.
		
		Name | Description
		--- | ---
		`renderInScreenshot` | Whenever to render or not.
    **/
    
    public function SetRenderInScreenshots(renderInScreenshot:Bool):Void;
    
    
    /**
        Sets the panel's cookie name. Calls PANEL:LoadCookies if defined.
		
		Name | Description
		--- | ---
		`name` | The panel's cookie name. Used as prefix for Panel: SetCookie
    **/
    
    public function SetCookieName(name:String):Void;
    
    
    /**
        Toggles the selected state of a selectable panel object. This functionality is set with Panel:SetSelectable and checked with Panel:IsSelectable. To check whether the object is selected or not, Panel:IsSelected is used.
    **/
    
    public function ToggleSelection():Void;
    
    
    /**
        Goes back one page in the HTML panel's history if available.
    **/
    
    public function GoBack():Void;
    
    
    /**
        Makes a panel visible.
    **/
    
    public function Show():Void;
    
    
    /**
        If called on a text entry, clicking the text entry for the first time will automatically select all of the text ready to be copied by the user.
    **/
    
    public function SelectAllOnFocus():Void;
    
    
    /**
        Makes this panel droppable. This is used with Panel:Receiver to create drag and drop events. 
		
		Can be called multiple times with different names allowing to be dropped onto different receivers.
		
		Name | Description
		--- | ---
		`name` | Name of your droppable panel
		
		
		`**Returns:** Blank table stored on the panel itself under pnl.m_DragSlot[ name ]. Is reset every time this function is called and does not appear to be used or exposed anywhere else.
    **/
    
    public function Droppable(name:String):AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		***Deprecated:** 
		
		Similar to Panel:LoadControlsFromString but loads controls from a file.
		
		Name | Description
		--- | ---
		`path` | The path to load the controls from.
    **/
    @:deprecated("INTERNAL")
    public function LoadControlsFromFile(path:String):Void;
    
    
    /**
        Uses animation to resize the panel to the specified size.
		
		Name | Description
		--- | ---
		`sizeW` | The target width of the panel. Use -1 to retain the current width.
		`sizeH` | The target height of the panel. Use -1 to retain the current height.
		`time` | The time to perform the animation within.
		`delay` | The delay before the animation starts.
		`ease` | Easing of the start and/or end speed of the animation. See Panel: NewAnimation for how this works.
		`callback` | The function to be called once the animation finishes. Arguments are: table animData - The AnimationData structure that was used. Panel pnl - The panel object that was resized.
    **/
    
    public function SizeTo(?sizeW:Float, ?sizeH:Float, time:Float, ?delay:Float, ?ease:Float, callback:AnimationData):Void;
    
    
    /**
        Instructs a HTML control to download and parse a HTML script using the passed URL.     Displays the Garry's Mod wiki page.
		
		Name | Description
		--- | ---
		`URL` | URL to open
		
		
		___
		### Lua Examples
		#### Example 1
		Displays the Garry's Mod wiki page.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "HTML Example" )
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
		frame:Center()
		frame:MakePopup()
		
		local html = vgui.Create( "HTML", frame )
		html:Dock( FILL )
		html:OpenURL( "wiki.garrysmod.com" )
		```
		
		#### Example 2
		Displays the default loading screen from the html folder.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "HTML Example" )
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
		frame:Center()
		frame:MakePopup()
		
		local html = vgui.Create( "HTML", frame )
		html:Dock( FILL )
		html:OpenURL( "asset://garrysmod/html/loading.html" )
		```
    **/
    
    public function OpenURL(URL:String):Void;
    
    
    /**
        Returns if the panel or any of its children(sub children and so on) has the focus.
		
		`**Returns:** hasHierarchicalFocus
    **/
    
    public function HasHierarchicalFocus():Bool;
    
    
    /**
        Determines whether or not a HTML or DHTML element is currently loading a page.
		
		`**Returns:** Whether or not the (D)HTML object is loading.
    **/
    
    public function IsLoading():Bool;
    
    
    /**
        Centers the panel vertically with specified fraction.
		
		Name | Description
		--- | ---
		`fraction` | The center fraction.
    **/
    
    public function CenterVertical(?fraction:Float):Void;
    
    
    /**
        Gets the value of a cookie stored by the panel object, as a number. This can also be done with cookie.GetNumber, using the panel's cookie name, a fullstop, and then the actual name of the cookie. 
		
		Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with Panel:GetCookieName and Panel:SetCookieName.
		
		Name | Description
		--- | ---
		`cookieName` | The name of the cookie from which to retrieve the value.
		`default` | The default value to return if the cookie does not exist.
		
		
		`**Returns:** The number value of the stored cookie, or the default value should the cookie not exist.
    **/
    
    public function GetCookieNumber(cookieName:String, _default:Float):Float;
    
    
    /**
        Resizes the panel object's height to accommodate all child objects/contents. 
		
		Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented Panel:GetContentSize method.
		
		**Note:** You must call this function AFTER setting text/font or adjusting child panels.
		
		Name | Description
		--- | ---
		`addVal` | The number of extra pixels to add to the height.
    **/
    
    public function SizeToContentsY(?addVal:Float):Void;
    
    
    /**
        Moves the panel to the specified position using animation.
		
		Name | Description
		--- | ---
		`posX` | The target x coordinate of the panel.
		`posY` | The target y coordinate of the panel.
		`time` | The time to perform the animation within.
		`delay` | The delay before the animation starts.
		`ease` | The easing of the start and/or end speed of the animation. See Panel: NewAnimation for how this works.
		`callback` | The function to be called once the animation finishes. Arguments are: table animData - The AnimationData structure that was used. Panel pnl - The panel object that was moved.
		
		
		___
		### Lua Examples
		#### Example 1
		Move panel to center
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW() / 4, ScrH() / 4)
		frame:SetPos(ScrW() / 4, ScrH() / 2)
		frame:SetTitle("MoveTo Example")
		
		local btn = vgui.Create("DButton", frame)
		btn:SetSize(frame:GetWide() / 2, frame:GetTall() / 3)
		btn:Center()
		btn:SetText("Move !")
		btn.DoClick = function(self)
		    frame:MoveTo(ScrW() / 2 - frame:GetWide() / 2, ScrH() / 2 - frame:GetTall() / 2, 1, 0, -1, function()
		        self:SetText("Yeah !")
		    end)
		end
		```
    **/
    
    public function MoveTo(posX:Float, posY:Float, time:Float, ?delay:Float, ?ease:Float, callback:AnimationData):Void;
    
    
    /**
        Sets height of a panel. An alias of Panel:SetHeight.
		
		Name | Description
		--- | ---
		`height` | Desired height to set
    **/
    
    public function SetTall(height:Float):Void;
    
    
    /**
        Allows or disallows the panel to receive keyboard focus and input. This is recursively applied to all children.
		
		Name | Description
		--- | ---
		`enable` | Whether keyboard input should be enabled for this panel.
    **/
    
    public function SetKeyboardInputEnabled(enable:Bool):Void;
    
    
    /**
        Returns the SysTime value when all animations for this panel object will end.
		
		`**Returns:** The system time value when all animations will end for this panel.
    **/
    
    public function AnimTail():Float;
    
    
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
    
    public function GotoTextStart():Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a [DNumberWang](https://wiki.garrysmod.com/page/Category:DNumberWang), [Slider](https://wiki.garrysmod.com/page/Category:Slider), [DNumSlider](https://wiki.garrysmod.com/page/Category:DNumSlider) or [DNumberScratch](https://wiki.garrysmod.com/page/Category:DNumberScratch). This calls  on one of the previously listed methods.
		
		Name | Description
		--- | ---
		`maxValue` | The maximum value the element is to permit.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetMax(maxValue:Float):Void;
    
    
    /**
        Allows you to set HTML code within a panel.
		
		Name | Description
		--- | ---
		`HTML code` | The code to set.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local HTML = vgui.Create( "HTML", DPanel )
		HTML:SetHTML( "<p>Put HTML code here</p>" )
		HTML:SetSize( 390, 400 )
		```
    **/
    
    public function SetHTML(code:String):Void;
    
    
    /**
        Moves the panel in front of all other panels on screen. Unless the panel has been made a pop-up using Panel:MakePopup, it will still draw behind any that have.
		
		___
		### Lua Examples
		#### Example 1
		Creates two frame panels where one acts normal and the other acts as a persistent warning window that will move in front of all other panels until it is closed.
		
		```lua 
		-- Regular message
		local popup1 = vgui.Create("DFrame")
		popup1:SetSize(400, 300)
		popup1:Center()
		popup1:MakePopup()
		popup1:SetTitle("This is a normal window.")
		
		-- Warning message
		local popup2 = vgui.Create("DFrame")
		popup2:SetSize(300, 100)
		popup2:Center()
		popup2:MakePopup()
		popup2:SetTitle("Warning!")
		
		-- Warning label
		local warning = vgui.Create("DLabel", popup2)
		warning:SetSize(280, 80)
		warning:Center()
		warning:SetText("The server will be shutting down in 5 minutes!")
		warning:SetFont("GModNotify")
		warning:SetWrap(true)
		
		-- Move the warning message to front constantly
		function popup2:Think()
		    self:MoveToFront()
		end
		```
    **/
    
    public function MoveToFront():Void;
    
    
    /**
        Marks all of the panel's children for deletion.
    **/
    
    public function Clear():Void;
    
    
    /**
        Sets the parent of the panel.
		
		Name | Description
		--- | ---
		`parent` | The new parent of the panel.
    **/
    
    public function SetParent(parent:Panel):Void;
    
    
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
    
    public function InsertClickableTextEnd():Void;
    
    
    /**
        Invalidates the layout of this panel object and all its children. This will cause these objects to re-layout immediately, calling PANEL:PerformLayout. If you want to perform the layout in the next frame, you will have loop manually through all children, and call Panel:InvalidateLayout on each.
		
		Name | Description
		--- | ---
		`recursive` | If true, the method will recursively invalidate the layout of all children. Otherwise, only immediate children are affected.
    **/
    
    public function InvalidateChildren(?recursive:Bool):Void;
    
    
    /**
        Sets whenever all the default background of the panel should be drawn or not.
		
		Name | Description
		--- | ---
		`paintBackground` | Whenever to draw the background or not.
    **/
    
    public function SetPaintBackgroundEnabled(paintBackground:Bool):Void;
    
    
    /**
        ***Deprecated:** Alias of Panel: SetKeyboardInputEnabled
		
		Enables or disables the keyboard input for the panel.
		
		Name | Description
		--- | ---
		`keyboardInput` | Whether to enable or disable keyboard input.
    **/
    @:deprecated("Alias of Panel: SetKeyboardInputEnabled")
    public function SetKeyBoardInputEnabled(keyboardInput:Bool):Void;
    
    
    /**
        Sets the achievement to be displayed by AchievementIcon.
		
		Name | Description
		--- | ---
		`id` | Achievement number ID
    **/
    
    public function SetAchievement(id:Float):Void;
    
    
    /**
        Copies the height of the panel.
		
		Name | Description
		--- | ---
		`base` | Panel to copy the height from.
    **/
    
    public function CopyHeight(base:Panel):Void;
    
    
    /**
        Sets the dock margin of the panel. 
		
		The dock margin is the extra space that will be left around the edge when this element is docked inside its parent element.
		
		Name | Description
		--- | ---
		`marginLeft` | The left margin to the parent.
		`marginTop` | The top margin to the parent.
		`marginRight` | The right margin to the parent.
		`marginBottom` | The bottom margin to the parent.
		
		
		___
		### Lua Examples
		#### Example 1
		Example showing the effects of DockMargin and DockPadding
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize(600, 300)
		frame:SetTitle("Docking Demonstration")
		frame:Center()
		frame:MakePopup(true)
		
		local panel = vgui.Create("DPanel", frame)
		panel:DockMargin(10, 20, 30, 40)
		panel:DockPadding(40, 30, 20, 10)
		panel:Dock(FILL)
		
		local button = vgui.Create("DButton", panel)
		button:SetText("Lopsided proportions!")
		button:Dock(FILL)
		```
    **/
    
    public function DockMargin(marginLeft:Float, marginTop:Float, marginRight:Float, marginBottom:Float):Void;
    
    
    /**
        Performs the "CONTROL + C" key combination effect ( Copy selection to clipboard ) on selected text.
    **/
    
    public function CopySelected():Void;
    
    
    /**
        Removes the panel after given time in seconds.
		
		**Note:** This function will not work if PANEL:AnimationThink is overridden, unless Panel:AnimationThinkInternal is called every frame.
		
		Name | Description
		--- | ---
		`delay` | Delay in seconds after which the panel should be removed.
    **/
    
    public function SetTerm(delay:Float):Void;
    
    
    /**
        Loads controls for the panel from a JSON string.
		
		Name | Description
		--- | ---
		`str` | JSON string containing information about controls to create.
    **/
    
    public function LoadGWENString(str:String):Void;
    
    
    /**
        Determines whether the mouse cursor is hovered over one of this panel object's children. This is a reverse process using vgui.GetHoveredPanel, and looks upward to find the parent.
		
		Name | Description
		--- | ---
		`immediate` | Set to true to check only the immediate children of given panel ( first level )
		
		
		`**Returns:** Whether or not one of this panel object's children is being hovered over.
    **/
    
    public function IsChildHovered(?immediate:Bool):Bool;
    
    
    /**
        Returns the docked padding of the panel. (set by Panel:DockPadding)
		
		Name | Description
		--- | ---
		`a` | Left padding.
		`b` | Top padding.
		`c` | Right padding.
		`d` | Bottom padding.
    **/
    
    public function GetDockPadding():PanelGetDockPaddingReturn;
    
    
    /**
        Fades panels color to specified one. It won't work unless panel has SetColor function.
		
		Name | Description
		--- | ---
		`color` | The color to fade to
		`length` | Length of the animation
		`delay` | Delay before start fading
		`callback` | Function to execute when finished
    **/
    
    public function ColorTo(color:AnyTable, length:Float, delay:Float, callback:Function):Void;
    
    
    /**
        Sets the position of the panel. 
		
		This will trigger PANEL:PerformLayout. You should avoid calling this function in PANEL:PerformLayout to avoid infinite loops.
		
		**Note:** If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find Panel:Dock useful
		
		Name | Description
		--- | ---
		`posX` | The x coordinate of the position.
		`posY` | The y coordinate of the position.
    **/
    
    public function SetPos(posX:Float, posY:Float):Void;
    
    
    /**
        Draws a textured rectangle to fill the panel object this method is called on. The texture is set using surface.SetTexture or surface.SetMaterial. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawTexturedRect.
    **/
    
    public function DrawTexturedRect():Void;
    
    
    /**
        Returns whether this panel is currently being dragged or not.
		
		`**Returns:** Whether this panel is currently being dragged or not.
    **/
    
    public function IsDragging():Bool;
    
    
    /**
        Sends an action command signal to the panel. The response is handled by PANEL:ActionSignal.
		
		Name | Description
		--- | ---
		`command` | The command to send to the panel.
		
		
		___
		### Lua Examples
		#### Example 1
		Defines a function which displays a dialog box that asks the player if they want to leave the server. Clicking the buttons fire panel commands that call the PANEL:ActionSignal which handles what action should be taken.
		
		```lua 
		function DisconnectDialog()
		
		    -- Remove existing dialog box
		    if(DialogBox) then DialogBox:Remove() end
		    
		    -- Font and message
		    local font = "ChatFont"
		    local msg = "Would you like to disconnect?"
		    
		    -- Get the size of the text
		    surface.SetFont(font)
		    local msg_w, msg_h = surface.GetTextSize(msg)
		    
		    -- Padding and button size
		    local padding = 15
		    local btn_w, btn_h = 35, 25
		    
		    -- Calculate dialog box size
		    local dialog_w = msg_w+(padding*2)
		    local dialog_h = msg_h+(padding*3)+btn_h
		    
		    -- Create the dialog box
		    DialogBox = vgui.Create("DPanel")
		    DialogBox:SetSize(dialog_w, dialog_h)
		    DialogBox:Center()
		    DialogBox:SetBackgroundColor(Color(64, 64, 92, 255))
		    
		    -- Message
		    local lbl = vgui.Create("DLabel", DialogBox)
		    lbl:SetPos(padding, padding)
		    lbl:SetSize(msg_w, msg_h)
		    lbl:SetText(msg)
		    lbl:SetFont(font)
		    
		    -- Yes button
		    local yes = vgui.Create("DButton", DialogBox)
		    yes:SetPos((dialog_w/2)-btn_w-20, msg_h+padding*2)
		    yes:SetSize(btn_w, btn_h)
		    yes:SetText("Yes")
		    yes:SetFont(font)
		    yes.DoClick = function() DialogBox:Command("yes") end
		    
		    -- No button
		    local no = vgui.Create("DButton", DialogBox)
		    no:SetPos((dialog_w/2)+20, msg_h+padding*2)
		    no:SetSize(btn_w, btn_h)
		    no:SetText("No")
		    no:SetFont(font)
		    no.DoClick = function() DialogBox:Command("no") end
		    
		    -- Force mouse input
		    DialogBox:MakePopup()
		    
		    -- Hook fired when DialogBox:Command is used
		    function DialogBox:ActionSignal(signalName, signalValue)
		    
		        -- Thank the player and disconnect after 2 seconds
		        if(signalName == "yes") then
		        
		            chat.AddText(Color(192, 192, 224), "Thanks for playing "..LocalPlayer():Nick()..", come back soon!")
		            
		            timer.Simple(2.0, function()
		                RunConsoleCommand("disconnect")
		            end)
		            
		            self:Remove()
		        
		        -- Remove the dialog box
		        elseif(signalName == "no") then
		        
		            self:Remove()
		        
		        end
		    
		    end
		    
		end
		```
    **/
    
    public function Command(command:String):Void;
    
    
    /**
        Returns if a panel allows world clicking set by Panel:SetWorldClicker.
		
		`**Returns:** If the panel allows world clicking.
    **/
    
    public function IsWorldClicker():Bool;
    
    
    /**
        Selects all items within a panel or object. For text-based objects, selects all text.
    **/
    
    public function SelectAll():Void;
    
    
    /**
        ***INTERNAL** 
		
		Called by [dragndrop](https://wiki.garrysmod.com/page/Category:dragndrop). [HoverThink](https://wiki.garrysmod.com/page/dragndrop/HoverThink) to perform actions on an object that is dragged and hovered over another.
		
		Name | Description
		--- | ---
		`HoverTime` | If this time is greater than 0.1, PANEL: DragHoverClick is called, passing it as an argument.
    **/
    @:deprecated("INTERNAL")
    public function DragHover(HoverTime:Float):Void;
    
    
    /**
        Redefines the panel object's Panel:SetPos method to operate using frame-by-frame linear interpolation (Lerp). When the panel's position is changed, it will move to the target position at the speed defined. You can undo this with Panel:DisableLerp. 
		
		Unlike the other panel animation functions, such as Panel:MoveTo, this animation method will not operate whilst the game is paused. This is because it relies on FrameTime.
		
		Name | Description
		--- | ---
		`speed` | The speed at which to move the panel. This is affected by the value of easeOut. Recommended values are: 0.1 - 10 when easeOut is false. 0.1 - 1 when easeOut is true.
		`easeOut` | This causes the panel object to 'jump' at the target, slowing as it approaches. This affects the speed value significantly, see above.
    **/
    
    public function LerpPositions(speed:Float, easeOut:Bool):Void;
    
    
    /**
        Returns the number of children of the panel object that are selected. This is equivalent to calling Panel:IsSelected on all child objects and counting the number of returns that are true.
		
		`**Returns:** The number of child objects that are currently selected. This does not include the parent object you are calling the method from.
    **/
    
    public function NumSelectedChildren():Float;
    
    
    /**
        Returns whether the the panel is enabled or disabled. 
		
		See Panel:SetEnabled for a function that makes the panel enabled or disabled.
		
		`**Returns:** Whether the panel is enabled or disabled.
    **/
    
    public function IsEnabled():Bool;
    
    
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
        Returns whether the mouse cursor is hovering over this panel or not 
		
		Uses vgui.GetHoveredPanel internally. 
		
		 Requires Panel:SetMouseInputEnabled to be set to true.
		
		`**Returns:** true if the panel is hovered
    **/
    
    public function IsHovered():Bool;
    
    
    /**
        Sets the dock padding of the panel. 
		
		The dock padding is the extra space that will be left around the edge when child elements are docked inside this element.
		
		Name | Description
		--- | ---
		`paddingLeft` | The left padding to the parent.
		`paddingTop` | The top padding to the parent.
		`paddingRight` | The right padding to the parent.
		`paddingBottom` | The bottom padding to the parent.
		
		
		___
		### Lua Examples
		#### Example 1
		Example showing the effects of DockMargin and DockPadding
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize(600, 300)
		frame:SetTitle("Docking Demonstration")
		frame:Center()
		frame:MakePopup(true)
		
		local panel = vgui.Create("DPanel", frame)
		panel:DockMargin(10, 20, 30, 40)
		panel:DockPadding(40, 30, 20, 10)
		panel:Dock(FILL)
		
		local button = vgui.Create("DButton", panel)
		button:SetText("Lopsided proportions!")
		button:Dock(FILL)
		```
    **/
    
    public function DockPadding(paddingLeft:Float, paddingTop:Float, paddingRight:Float, paddingBottom:Float):Void;
    
    
    /**
        Moves the panel by the specified coordinates using animation.
		
		Name | Description
		--- | ---
		`moveX` | The number of pixels to move by in the horizontal (x) direction.
		`moveY` | The number of pixels to move by in the vertical (y) direction.
		`time` | The time (in seconds) in which to perform the animation.
		`delay` | The delay (in seconds) before the animation begins.
		`ease` | The easing of the start and/or end speed of the animation. See Panel: NewAnimation for how this works.
		`callback` | The function to be called once the animation is complete. Arguments are: table animData - The AnimationData structure that was used. Panel pnl - The panel object that was moved.
    **/
    
    public function MoveBy(moveX:Float, moveY:Float, time:Float, ?delay:Float, ?ease:Float, ?callback:AnimationData):Void;
    
    
    /**
        Places the panel right to the passed panel with the specified offset.
		
		Name | Description
		--- | ---
		`panel` | Panel to position relatively to.
		`offset` | The align offset.
    **/
    
    public function MoveRightOf(panel:Panel, ?offset:Float):Void;
    
    
    /**
        Used by Panel:LoadGWENFile and Panel:LoadGWENString to apply a GWEN controls table to a panel object. 
		
		You can do this manually using file.Read and util.JSONToTable to import and create a GWEN table structure from a .gwen file. This method can then be called, passing the GWEN table's Controls member.
		
		Name | Description
		--- | ---
		`GWENTable` | The GWEN controls table to apply to the panel.
    **/
    
    public function ApplyGWEN(GWENTable:AnyTable):Void;
    
    
    /**
        ***Deprecated:** Does nothing at all.
		
		Used in Button to call a function when the button is clicked and in Slider when the value changes.
		
		Name | Description
		--- | ---
		`func` | Function to call when the Button is clicked or the Slider value is changed. Arguments given are: Panel self - The panel itself string action - "Command" on button press, "SliderMoved" on slider move. number val - The new value of the Slider. Will always equal 0 for buttons. number zed - Always equals 0.
    **/
    @:deprecated("Does nothing at all.")
    public function SetActionFunction(func:Function):Void;
    
    
    /**
        Moves the panel object behind all other panels on screen. If the panel has been made a pop-up with Panel:MakePopup, it will still draw in front of any panels that haven't.
    **/
    
    public function MoveToBack():Void;
    
    
    /**
        Paints the panel at its current position. To use this you must call Panel:SetPaintedManually(true).
		
		___
		### Lua Examples
		#### Example 1
		Paints a simple panel inside a 3D rendering context.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "PaintManual Test" )
		frame:SetSize( 500, 500 )
		frame:SetPaintedManually( true )
		
		hook.Add( "PostDrawTranslucentRenderables", "PaintManual Test", function()
		    if IsValid(frame) then
		        local eyePos = Entity(1):EyePos()
		        local forward = Entity(1):GetForward()
		        local forwardAngle = forward:Angle()
		
		        cam.Start3D2D(eyePos + (forward * 250), Angle(0, forwardAngle.y - 90, forwardAngle.r + 90), 0.2)
		            frame:PaintManual()
		        cam.End3D2D()
		    end
		end )
		```
		**Output:**
		
		The panel will be drawn facing the player located on the player's crosshair. (click for higher resolution)
    **/
    
    public function PaintManual():Void;
    
    
    /**
        Sets this panel's convar. When the convar changes this panel will update automatically. 
		
		For developer implementation, see Derma_Install_Convar_Functions.
		
		**Warning:** This function does not exist on all panels
		
		Name | Description
		--- | ---
		`convar` | The console variable to check.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes a checkbox linked to the sv_cheats convar.
		
		```lua 
		local checkbox = vgui.Create( "DCheckBoxLabel", myFrame )
		checkbox:SetConVar( "sv_cheats" )
		checkbox:SetText( "Enable cheats?" )
		checkbox:SetPos( 5, 25 )
		checkbox:SizeToContents()
		```
		**Output:**
		
		A checkbox which adapts to the value of the sv_cheats convar value.
    **/
    
    public function SetConVar(convar:String):Void;
    
    
    /**
        Slides the panel out to the top.
		
		Name | Description
		--- | ---
		`Length` | Time to complete the animation.
    **/
    
    public function SlideUp(Length:Float):Void;
    
    
    /**
        Called to inform the dragndrop library that a mouse button has been depressed on a panel object.
		
		Name | Description
		--- | ---
		`mouseCode` | The code for the mouse button pressed, passed by, for example, PANEL: OnMouseReleased. See the MOUSE_ Enums.
		
		
		`**Returns:** true if an object was being dragged, otherwise false.
    **/
    
    public function DragMouseRelease(mouseCode:MOUSE):Bool;
    
    
    /**
        Returns the cursor position relative to the top left of the panel. 
		
		This is equivalent to calling gui.MousePos and then Panel:ScreenToLocal.
		
		**Warning:** This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass. ie. inaccurate results may be returned if the panel or any of its ancestors have been repositioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
		
		Name | Description
		--- | ---
		`a` | X coordinate of the cursor, relative to the top left of the panel.
		`b` | Y coordinate of the cursor, relative to the top left of the panel.
    **/
    
    public function CursorPos():PanelCursorPosReturn;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel. This calls [Panel](https://wiki.garrysmod.com/page/Category:Panel): [SetName](https://wiki.garrysmod.com/page/Panel/SetName).
		
		Name | Description
		--- | ---
		`name` | The new name to apply to the panel.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetControlName(name:String):Void;
    
    
    /**
        Translates global screen coordinate to coordinates relative to the panel. 
		
		See also Panel:LocalToScreen.
		
		**Warning:** This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass. ie. inaccurate results may be returned if the panel or any of its ancestors have been repositioned outside of PANEL:Think or PANEL:PerformLayout within the last frame.
		
		Name | Description
		--- | ---
		`screenX` | The x coordinate of the screen position to be translated.
		`screenY` | The y coordinate of the screed position be to translated.
		
		
		Name | Description
		--- | ---
		`a` | Relativeposition X
		`b` | Relativeposition Y
    **/
    
    public function ScreenToLocal(screenX:Float, screenY:Float):PanelScreenToLocalReturn;
    
    
    /**
        Returns a dock enum for the panel's current docking type.
		
		`**Returns:** The dock enum for the panel. See DOCK_ Enums.
    **/
    
    public function GetDock():DOCK;
    
    
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
    
    public function DrawTextEntryText(textCol:AnyTable, highlightCol:AnyTable, cursorCol:AnyTable):Void;
    
    
    /**
        ***Deprecated:** Use Panel: IsValid instead.
		
		Returns if a given panel is valid or not.
		
		`**Returns:** Whether the panel is valid or not, true being it is, false being it isn't.
    **/
    @:deprecated("Use Panel: IsValid instead.")
    public function Valid():Bool;
    
    
    /**
        Returns the position and size of the panel. 
		
		This is equivalent to calling Panel:GetPos and Panel:GetSize together.
		
		Name | Description
		--- | ---
		`a` | The x coordinate of the panel, relative to its parent's top left.
		`b` | The y coordinate of the panel, relative to its parent's top left.
		`c` | The width of the panel.
		`d` | The height of the panel.
    **/
    
    public function GetBounds():PanelGetBoundsReturn;
    
    
    /**
        Sets the drag parent. 
		
		Drag parent means that when we start to drag this panel, we'll really start dragging the defined parent.
		
		Name | Description
		--- | ---
		`parent` | The panel to set as drag parent.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage.
		
		```lua 
		local function DoDrop( self, panels, bDoDrop, Command, x, y )
		    if ( bDoDrop ) then
		        for k, v in pairs( panels ) do
		            self:AddItem( v )
		        end
		    end
		end
		
		concommand.Add( "test2", function()
		
		    local frame = vgui.Create( "DFrame" )
		    frame:SetSize( 500, 300 )
		    frame:SetTitle( "Frame" )
		    frame:MakePopup()
		    frame:Center()
		
		    local left = vgui.Create( "DScrollPanel", frame )
		    left:Dock( LEFT )
		    left:SetWidth( frame:GetWide() / 2 - 7 )
		    left:SetPaintBackground( true )
		    left:DockMargin( 0, 0, 4, 0 )
		    left:Receiver( "myDNDname", DoDrop ) -- Make the panel a receiver for drag and drop events
		
		    local right = vgui.Create( "DScrollPanel", frame )
		    right:Dock( FILL )
		    right:SetPaintBackground( true )
		    right:Receiver( "myDNDname", DoDrop )
		
		    for i = 1, 30 do
		        local but = vgui.Create( "DButton" )
		        but:SetText( "button text " .. i )
		        but:SetSize( 36, 24 )
		        but:Dock( TOP )
		        but:Droppable( "myDNDname" ) -- make the panel be able to be drag'n'dropped onto other panels
		        right:AddItem( but )
		        
		        local mdl = vgui.Create( "DModelPanel", but ) -- Put another panel over the draggable button
		        mdl:Dock( FILL )
		        mdl:SetModel( "models/alyx.mdl" )
		        mdl:SetDragParent( but ) -- The magic bit. Without it, you would not be able to drag the button at all
		    end
		
		end )
		```
    **/
    
    public function SetDragParent(parent:Panel):Void;
    
    
    /**
        Sets the selected state of a selectable panel object. This functionality is set with Panel:SetSelectable and checked with Panel:IsSelectable.
		
		Name | Description
		--- | ---
		`selected` | Whether the object should be selected or deselected. Panel: IsSelected can be used to determine the selected state of the object.
    **/
    
    public function SetSelected(?selected:Bool):Void;
    
    
    /**
        Sets the action signal command that's fired when a Button is clicked. The hook PANEL:ActionSignal is called as the click response. 
		
		This has no effect on buttons unless it has had its AddActionSignalTarget method called (an internal function not available by default in Garry's Mod LUA). 
		
		 A better alternative is calling Panel:Command when a DButton is clicked.
		
		___
		### Lua Examples
		#### Example 1
		Creates an engine-based Frame panel and changes the command that's fired when you click the white close button (by default the command is set to "Close").
		
		```lua 
		-- Create a regular Frame panel
		TestFrame = vgui.Create("Frame")
		TestFrame:SetSize(200, 200)
		TestFrame:Center()
		TestFrame:MakePopup()
		TestFrame:SetVisible(true)
		
		local lbl = vgui.Create("DLabel", TestFrame)
		lbl:Dock(FILL)
		lbl:DockMargin(10, 10, 10, 10)
		lbl:SetText("Click the white button in the upper right corner of this window.")
		lbl:SetFont("ChatFont")
		lbl:SetWrap(true)
		
		-- Create a background panel so we can see the Frame's internal buttons
		local bg = vgui.Create("DPanel", TestFrame)
		bg:Dock(FILL)
		bg:SetBackgroundColor(Color(64, 64, 64, 192))
		bg:MoveToBack()
		
		-- Loop through Frame's internal components
		for _, child in pairs(TestFrame:GetChildren()) do
		
		    -- Disable frame sizing
		    if(string.find(child:GetName(), "Grip")) then
		    
		        child:SetMouseInputEnabled(false)
		        
		    -- Fire the "Testing" command when we click the white button
		    elseif(child:GetName() == "frame_close") then
		    
		        child:SetCommand("Testing")
		        
		    end
		    
		end
		
		function TestFrame:ActionSignal(signalName, signalValue)
		    
		    -- Show the signal name
		    lbl:SetText("Received command: \""..signalName.."\"")
		
		end
		```
    **/
    
    public function SetCommand():Void;
    
    
    /**
        Returns the value the panel holds. 
		
		In engine is only implemented for CheckButton, Label and TextEntry as a string and for those elements has a hard coded limit of 8092 characters.
		
		`**Returns:** The value the panel holds.
		
		___
		### Lua Examples
		#### Example 1
		Returns the string typed in a TextEntry.
		
		```lua 
		local TextEntry = vgui.Create( "TextEntry" )
		TextEntry:SetText( "Hello world!" )
		print( TextEntry:GetValue() )
		```
		**Output:**
		
		"Hello world!"
    **/
    
    public function GetValue():Dynamic;
    
    
    /**
        Loads a .gwen file (created by GWEN Designer) and calls Panel:LoadGWENString with the contents of the loaded file. 
		
		Used to load panel controls from a file.
		
		Name | Description
		--- | ---
		`filename` | The file to open. The path is relative to garrysmod/garrysmod/.
		`path` | The path used to look up the file. "GAME" Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons "DATA" Data folder (garrysmod/data) "MOD" Strictly the game folder (garrysmod/), ignores mounting.
    **/
    
    public function LoadGWENFile(filename:String, ?path:String):Void;
    
    
    /**
        Gets the size, position and dock state of the passed panel object, and applies it to this one.
		
		Name | Description
		--- | ---
		`srcPanel` | The panel to copy the boundary and dock settings from.
    **/
    
    public function CopyBase(srcPanel:Panel):Void;
    
    
    /**
        Determines if the panel object is a selection canvas or not. This is set with Panel:SetSelectionCanvas.
		
		`**Returns:** The value (if any) set by Panel: SetSelectionCanvas.
    **/
    
    public function IsSelectionCanvas():Dynamic;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a [DCheckBoxLabel](https://wiki.garrysmod.com/page/Category:DCheckBoxLabel). This does exactly the same as [Panel](https://wiki.garrysmod.com/page/Category:Panel): [GWEN_SetText](https://wiki.garrysmod.com/page/Panel/GWEN_SetText), but exists to cater for the seperate GWEN properties.
		
		Name | Description
		--- | ---
		`txt` | The text to be applied to the DCheckBoxLabel.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetCheckboxText(txt:String):Void;
    
    
    /**
        Sets the visibility of the language selection box in a TextEntry when typing in non-English mode. 
		
		See Panel:SetDrawLanguageIDAtLeft for a function that changes the position of the language selection box.
		
		Name | Description
		--- | ---
		`visible` | true to make it visible, false to hide it.
    **/
    
    public function SetDrawLanguageID(visible:Bool):Void;
    
    
    /**
        Places the panel left to the passed panel with the specified offset.
		
		Name | Description
		--- | ---
		`panel` | Panel to position relatively to.
		`offset` | The align offset.
    **/
    
    public function MoveLeftOf(panel:Panel, ?offset:Float):Void;
    
    
    /**
        Centers the panel horizontally with specified fraction.
		
		Name | Description
		--- | ---
		`fraction` | The center fraction.
    **/
    
    public function CenterHorizontal(?fraction:Float):Void;
    
    
    /**
        Returns the class name of the panel.
		
		`**Returns:** className
    **/
    
    public function GetClassName():String;
    
    
    /**
        Returns whether this panel is draggable ( if user is able to drag it ) or not.
		
		`**Returns:** Whether this panel is draggable ( if user is able to drag it ) or not.
    **/
    
    public function IsDraggable():Bool;
    
    
    /**
        Draws a coloured rectangle to fill the panel object this method is called on. The colour is set using surface.SetDrawColor. This should only be called within the object's PANEL:Paint or PANEL:PaintOver hooks, as a shortcut for surface.DrawRect.
    **/
    
    public function DrawFilledRect():Void;
    
    
    /**
        Sets the foreground color of a panel. 
		
		For a Label or RichText, this is the color of its text. 
		
		 This function calls Panel:SetFGColorEx internally.
		
		**Note:** This doesn't apply to all VGUI elements (such as DLabel) and its function varies between them
		
		Name | Description
		--- | ---
		`r or color` | The red channel of the color, or a Color structure. If you pass the latter, the following three arguments are ignored.
		`g` | The green channel of the color.
		`b` | The blue channel of the color.
		`a` | The alpha channel of the color.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a Label and sets its text color to white.
		
		```lua 
		local label = vgui.Create( "Label" )
		
		label:SetFGColor( Color( 255, 255, 255, 255 ) )
		```
		
		#### Example 2
		Sets the foreground color of a RichText to match the chat box format.
		
		```lua 
		-- Create a window frame
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(200, 50)
		TextFrame:Center()
		TextFrame:SetTitle("This is a color test")
		TextFrame:MakePopup()
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Sample text
		richtext:SetText("Here is some light green text.")
		
		-- When the panel is ready for layout, make the text light green
		function richtext:PerformLayout()
		    self:SetFGColor(Color(153, 255, 153))
		end
		```
    **/
    
    public function SetFGColor(color:Color, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Returns if the panel is valid and not marked for deletion.
		
		`**Returns:** True if the object is valid.
    **/
    
    public function IsValid():Bool;
    
    
    /**
        ***Deprecated:** Only used in deprecated Derma controls.
		
		Sends a command to the panel.
		
		Name | Description
		--- | ---
		`messageName` | The name of the message.
		`valueType` | The type of the variable to post.
		`value` | The value to post.
    **/
    @:deprecated("Only used in deprecated Derma controls.")
    public function PostMessage(messageName:String, valueType:String, value:String):Void;
    
    
    /**
        Determines if the panel object is selectable (like icons in the Spawn Menu, holding ⇧ Shift). This is set with Panel:SetSelectable.
		
		`**Returns:** Whether the panel is selectable or not.
    **/
    
    public function IsSelectable():Bool;
    
    
    /**
        Sets the .png image to be displayed on a [SpawnIcon](https://wiki.garrysmod.com/page/Category:SpawnIcon) or the panel it is based on [ModelImage](https://wiki.garrysmod.com/page/Category:ModelImage). Only .png images can be used with this function.
		
		Name | Description
		--- | ---
		`icon` | A path to the .png material, for example one of the Silkicons shipped with the game.
    **/
    
    public function SetSpawnIcon(icon:String):Void;
    
    
    /**
        ***Deprecated:** Alias of Panel: SetTooltipPanel.
    **/
    @:deprecated("Alias of Panel: SetTooltipPanel.")
    public function SetToolTipPanel():Void;
    
    
    /**
        ***Deprecated:** Does nothing
		
		This function does nothing.
    **/
    @:deprecated("Does nothing")
    public function AddText():Void;
    
    
    /**
        Sets the width and position of a DLabel and places the passed panel object directly to the right of it. Returns the y value of the bottom of the tallest object. The panel on which this method is run is not relevant; only the passed objects are affected.
		
		Name | Description
		--- | ---
		`lblWidth` | The width to set the label to.
		`x` | The horizontal (x) position at which to place the label.
		`y` | The vertical (y) position at which to place the label.
		`lbl` | The label to resize and position.
		`panelObj` | The panel object to place to the right of the label.
		
		
		`**Returns:** The distance from the top of the parent panel to the bottom of the tallest object (the y position plus the height of the label or passed panel, depending on which is tallest).
    **/
    
    public function PositionLabel(lblWidth:Float, x:Float, y:Float, lbl:Panel, panelObj:Panel):Float;
    
    
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`objectName` | 
    **/
    @:deprecated("INTERNAL")
    public function NewObject(objectName:String):Void;
    
    
    /**
        Sets where to draw the language selection box. 
		
		See Panel:SetDrawLanguageID for a function that hides or shows the language selection box.
		
		Name | Description
		--- | ---
		`left` | true = left, false = right
    **/
    
    public function SetDrawLanguageIDAtLeft(left:Bool):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [ApplyGWEN](https://wiki.garrysmod.com/page/Panel/ApplyGWEN) to apply the  property to a panel object. This calls [Panel](https://wiki.garrysmod.com/page/Category:Panel): [DockMargin](https://wiki.garrysmod.com/page/Panel/DockMargin).
		
		Name | Description
		--- | ---
		`margins` | A four-membered table containing the margins as numbers: number left - The left margin. number top - The top margin. number right - The right margin. number bottom - The bottom margin.
    **/
    @:deprecated("INTERNAL")
    public function GWEN_SetMargin(margins:AnyTable):Void;
    
    
    /**
        Stops all panel animations by clearing its animation list. This also clears all delayed animations.
    **/
    
    public function Stop():Void;
    
    
    /**
        Causes a RichText element to scroll to the bottom of its text.
    **/
    
    public function GotoTextEnd():Void;
	

    
    /**
        Only works on elements defined with derma.DefineControl and only if the panel has AllowAutoRefresh set to true. 
		
		Called when derma.DefineControl is called with this panel's class name before applying changes to this panel. 
		
		 See also PANEL:PostAutoRefresh
    **/
    
    @:hook
    public function PreAutoRefresh():Void;
    
    
    /**
        Called whenever the cursor was moved with the panels bounds.
		
		Name | Description
		--- | ---
		`cursorX` | The new x position of the cursor relative to the panels origin.
		`cursorY` | The new y position of the cursor relative to the panels origin.
		
		
		`**Returns:** Return true to suppress default action.
    **/
    
    @:hook
    public function OnCursorMoved(cursorX:Float, cursorY:Float):Bool;
    
    
    /**
        Called whenever the panel should apply its scheme(style).
    **/
    
    @:hook
    public function ApplySchemeSettings():Void;
    
    
    /**
        Called by HTML panels when the page attempts to open a new child view (such as a popup or new tab).
		
		Name | Description
		--- | ---
		`sourceURL` | The URL of the page requesting to create a child.
		`targetURL` | The URL of the requested child.
		`isPopup` | True if the requested view is a popup.
    **/
    
    @:hook
    public function OnChildViewCreated(sourceURL:String, targetURL:String, isPopup:Bool):Void;
    
    
    /**
        Called whenever the panel and all its children were drawn, return true to override the default drawing.
		
		Name | Description
		--- | ---
		`width` | The panels current width.
		`height` | The panels current height.
		
		
		`**Returns:** Should we disable default PaintOver rendering? This is useful in case with Derma panels that use Derma hooks.
    **/
    
    @:hook
    public function PaintOver(width:Float, height:Float):Bool;
    
    
    /**
        ***INTERNAL** 
		
		Called by [dragndrop](https://wiki.garrysmod.com/page/Category:dragndrop). [StartDragging](https://wiki.garrysmod.com/page/dragndrop/StartDragging) when the panel starts being dragged.
    **/
    @:deprecated("INTERNAL")
    @:hook
    public function OnStartDragging():Void;
    
    
    /**
        Called whenever the panel gained or lost focus.
		
		**Note:** Panel:HasFocus will only be updated on the next frame and will return the "old" value at the time this hook is run. Same goes for vgui.GetKeyboardFocus.
		
		Name | Description
		--- | ---
		`gained` | Is the focus was gained ( true ) or lost ( false )
    **/
    
    @:hook
    public function OnFocusChanged(gained:Bool):Void;
    
    
    /**
        Called by HTML panels when the panel's DOM has been set up. You can run JavaScript in here.
		
		Name | Description
		--- | ---
		`url` | The URL of the current page.
    **/
    
    @:hook
    public function OnDocumentReady(url:String):Void;
    
    
    /**
        Called by HTML panels when the title of the loaded page has been changed.
		
		Name | Description
		--- | ---
		`newTitle` | The new title of the page.
    **/
    
    @:hook
    public function OnChangeTitle(newTitle:String):Void;
    
    
    /**
        Called whenever the cursor left the panels bounds.
    **/
    
    @:hook
    public function OnCursorExited():Void;
    
    
    /**
        Called whenever a keyboard key was pressed while the panel is focused.
		
		**Bug:** BUG This is not run for ESC/"cancelselect" binding. Issue Tracker: #2886
		
		Name | Description
		--- | ---
		`keyCode` | The key code of the pressed key, see KEY_ Enums.
		
		
		`**Returns:** Return true to suppress default action.
    **/
    
    @:hook
    public function OnKeyCodePressed(keyCode:KEY):Bool;
    
    
    /**
        Called whenever the panels layout was invalidated. This means all child panels must be re-positioned to fit the possibly new size of this panel.
		
		**Warning:** Do NOT call this function directly. Use Panel:InvalidateLayout instead!
		
		Name | Description
		--- | ---
		`width` | The panels current width.
		`height` | The panels current height.
    **/
    
    @:hook
    public function PerformLayout(width:Float, height:Float):Void;
    
    
    /**
        ***INTERNAL** 
		
		Called by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [DragMouseRelease](https://wiki.garrysmod.com/page/Panel/DragMouseRelease) when the panel object is released after being dragged.
    **/
    @:deprecated("INTERNAL")
    @:hook
    public function OnStopDragging():Void;
    
    
    /**
        Called just after the panel size changes. 
		
		All size functions will return the new values when this hook is called.
		
		**Warning:** Changing the panel size in this hook will cause an infinite loop!
		
		Name | Description
		--- | ---
		`newWidth` | The new width of the panel
		`newHeight` | The new height of the panel
    **/
    
    @:hook
    public function OnSizeChanged(newWidth:Float, newHeight:Float):Void;
    
    
    /**
        Called whenever the panel should be drawn. 
		
		You can create panels with a customized appearance by overriding their Paint() function, which will prevent the default appearance from being drawn.
		
		**Note:** Render operations from the surface library (and consequentially the draw library) are always offset by the global position of this panel, as seen in the example below
		
		**Note:** This hook will not run if the panel is completely off the screen. The hook will still run however if any parts of the panel are still on screen.
		
		Name | Description
		--- | ---
		`width` | The panel's width.
		`height` | The panel's height.
		
		
		`**Returns:** Returning true prevents the background from being drawn.
		
		___
		### Lua Examples
		#### Example 1
		Creates a DPanel and overrides its Paint() function to draw a 100x100 pixel black rounded box in the center of the screen.
		
		```lua 
		local panel = vgui.Create( "DPanel" )
		panel:SetSize( 100, 100 )
		panel:SetPos( ScrW() / 2 - 50, ScrH() / 2 - 50 )
		
		function panel:Paint( w, h )
		    draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 0 ) )
		end
		```
    **/
    
    @:hook
    public function Paint(width:Float, height:Float):Bool;
    
    
    /**
        Called by HTML panels when the target URL of the frame has changed, this happens when you hover over a link.
		
		Name | Description
		--- | ---
		`targetURL` | New target URL.
    **/
    
    @:hook
    public function OnChangeTargetURL(targetURL:String):Void;
    
    
    /**
        Called whenever a mouse key was pressed while the panel is focused.
		
		Name | Description
		--- | ---
		`keyCode` | They key code of the key pressed, see MOUSE_ Enums.
		
		
		`**Returns:** Return true to suppress default action such as right click opening edit menu for DTextEntry.
    **/
    
    @:hook
    public function OnMousePressed(keyCode:MOUSE):Bool;
    
    
    /**
        Called when an object is dragged and hovered over this panel for 0.1 seconds. 
		
		This is used by DPropertySheet and DTree, for example to open a tab or expand a node when an object is hovered over it.
		
		Name | Description
		--- | ---
		`hoverTime` | The time the object was hovered over this panel.
    **/
    
    @:hook
    public function DragHoverClick(hoverTime:Float):Void;
    
    
    /**
        Called when the panel is about to be removed.
    **/
    
    @:hook
    public function OnRemove():Void;
    
    
    /**
        Called when the player's screen resolution of the game changes. 
		
		ScrW and ScrH will return the new values when this hook is called.
		
		Name | Description
		--- | ---
		`oldWidth` | The previous width of the game's window
		`oldHeight` | The previous height of the game's window
    **/
    
    @:hook
    public function OnScreenSizeChanged(oldWidth:Float, oldHeight:Float):Void;
    
    
    /**
        Called when this panel is dropped onto another panel. 
		
		Only works for panels derived from DDragBase.
		
		Name | Description
		--- | ---
		`pnl` | The panel we are dropped onto
    **/
    
    @:hook
    public function DroppedOn(pnl:Panel):Void;
    
    
    /**
        Called when the panel should generate example use case / example code to use for this panel. Used in the panel opened by derma_controls console command.
		
		Name | Description
		--- | ---
		`class` | The classname of the panel to generate example for. This will be the class name of your panel.
		`dpropertysheet` | A DPropertySheet to add your example to. See examples below.
		`width` | Width of the property sheet?
		`height` | Width of the property sheet?
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of this hook from DButton's code.
		
		```lua 
		function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )
		
		    local ctrl = vgui.Create( ClassName )
		    ctrl:SetText( "Example Button" )
		    ctrl:SetWide( 200 )
		
		    PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )
		
		end
		
		derma.DefineControl( "DButton", "A standard Button", PANEL, "DLabel" )
		```
		**Output:**
		
		A tab named "DButton" will appear in derma_controls menu.
    **/
    
    @:hook
    public function GenerateExample(_class:String, dpropertysheet:Panel, width:Float, height:Float):Void;
    
    
    /**
        Called after Panel:SetCookieName is called on this panel to apply the just loaded cookie values for this panel.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		function PANEL:LoadCookies()
		
		    local value = self:GetCookieNumber( "SavedCookieName", 0 )
		    print( value )
		
		    -- Do your stuff with the loaded value
		
		end
		```
    **/
    
    @:hook
    public function LoadCookies():Void;
    
    
    /**
        Called whenever a keyboard key was released while the panel is focused.
		
		**Bug:** BUG This is not run for TILDE/"toggleconsole" binding. Issue Tracker: #2886
		
		Name | Description
		--- | ---
		`keyCode` | The key code of the released key, see KEY_ Enums.
		
		
		`**Returns:** Return true to suppress default action.
    **/
    
    @:hook
    public function OnKeyCodeReleased(keyCode:KEY):Bool;
    
    
    /**
        Only works on elements defined with derma.DefineControl and only if the panel has AllowAutoRefresh set to true. 
		
		Called after derma.DefineControl is called with panel's class name. 
		
		 See also PANEL:PreAutoRefresh
    **/
    
    @:hook
    public function PostAutoRefresh():Void;
    
    
    /**
        ***INTERNAL** 
		
		Called when we are activated during level load. Used by the loading screen panel.
    **/
    @:deprecated("INTERNAL")
    @:hook
    public function OnActivate():Void;
    
    
    /**
        Called every frame while Panel:IsVisible is true.
    **/
    
    @:hook
    public function Think():Void;
    
    
    /**
        Called when the panel is created. This is called for each base type that the panel has.
		
		___
		### Lua Examples
		#### Example 1
		Shows how this method is called recursively for each base type a panel has.
		
		```lua 
		local BASE = {}
		function BASE:Init()
		    print("Base Init Called")
		end
		
		
		local PANEL = {}
		function PANEL:Init()
		    print("Panel Init Called")
		end
		
		
		vgui.Register("MyBase", BASE, "DFrame")
		vgui.Register("MyPanel", PANEL, "MyBase")
		
		local panel = vgui.Create("MyPanel")
		```
		**Output:**
		
		Base Init Called Panel Init Called
    **/
    
    @:hook
    public function Init():Void;
    
    
    /**
        Called whenever a mouse key was released while the panel is focused.
		
		Name | Description
		--- | ---
		`keyCode` | They key code of the key released, see MOUSE_ Enums.
		
		
		`**Returns:** Return true to suppress default action.
    **/
    
    @:hook
    public function OnMouseReleased(keyCode:MOUSE):Bool;
    
    
    /**
        Called whenever the mouse wheel was used.
		
		Name | Description
		--- | ---
		`scrollDelta` | The scroll delta, indicating how much the user turned the mouse wheel.
		
		
		`**Returns:** Return true to suppress default action.
    **/
    
    @:hook
    public function OnMouseWheeled(scrollDelta:Float):Bool;
    
    
    /**
        ***INTERNAL** 
		
		Called when we are deactivated during level load. Used by the loading screen panel.
    **/
    @:deprecated("INTERNAL")
    @:hook
    public function OnDeactivate():Void;
    
    
    /**
        Called whenever a child of the panel is about to removed.
		
		Name | Description
		--- | ---
		`child` | The child which is about to be removed.
    **/
    
    @:hook
    public function OnChildRemoved(child:Panel):Void;
    
    
    /**
        We're being dropped on something We can create a new panel here and return it, so that instead of dropping us - it drops the new panel instead! We remain where we are! 
		
		Only works for panels derived from DDragBase.
		
		`**Returns:** The panel to drop instead of us. By default you should return self.
    **/
    
    @:hook
    public function OnDrop():Panel;
    
    
    /**
        Called whenever the cursor entered the panels bounds.
    **/
    
    @:hook
    public function OnCursorEntered():Void;
    
    
    /**
        Called whenever a panel receives a command signal from one of its children. 
		
		This hook is called when using Panel:Command, when clicking a Button with Panel:SetCommand set, and when clicking text within a RichText panel that is marked as click-able.
		
		Name | Description
		--- | ---
		`signalName` | The name of the signal, usually the sender of the signal or the command name.
		`signalValue` | The value of the signal, usually a command argument.
    **/
    
    @:hook
    public function ActionSignal(signalName:String, signalValue:String):Void;
    
    
    /**
        Called whenever a child was parented to the panel.
		
		**Bug:** BUG This is called before the panel's metatable is set. Issue Tracker: #2759
		
		Name | Description
		--- | ---
		`child` | The child which was added.
    **/
    
    @:hook
    public function OnChildAdded(child:Panel):Void;
    
    
    /**
        Called every frame unless Panel:IsVisible is set to false. Similar to PANEL:Think, but can be disabled by Panel:SetAnimationEnabled as explained below. 
		
		If you are overriding this, you must call Panel:AnimationThinkInternal every frame, else animations will cease to work. 
		
		 If you want to "disable" this hook with Panel:SetAnimationEnabled, you must call it after defining this hook. Once disabled, a custom hook will not be re-enabled by Panel:SetAnimationEnabled again - the hook will have to be re-defined.
    **/
    
    @:hook
    public function AnimationThink():Void;
    
    
}


@:multiReturn extern class PanelScreenToLocalReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelLocalToScreenReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelLocalCursorPosReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetValidReceiverSlotReturn {
var a:Panel;
var b:AnyTable;

}
@:multiReturn extern class PanelGetTextSizeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetTextInsetReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetSizeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetPosReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetDockPaddingReturn {
var a:Float;
var b:Float;
var c:Float;
var d:Float;

}
@:multiReturn extern class PanelGetDockMarginReturn {
var a:Float;
var b:Float;
var c:Float;
var d:Float;

}
@:multiReturn extern class PanelGetContentSizeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetClosestChildReturn {
var a:Panel;
var b:Float;

}
@:multiReturn extern class PanelGetChildPositionReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelGetBoundsReturn {
var a:Float;
var b:Float;
var c:Float;
var d:Float;

}
@:multiReturn extern class PanelCursorPosReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PanelChildrenSizeReturn {
var a:Float;
var b:Float;

}

#end