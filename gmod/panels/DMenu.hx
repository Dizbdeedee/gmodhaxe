package gmod.panels;
#if client

/**
    A simple menu with sub menu, icon and convar support.
**/
extern class DMenu extends DScrollPanel {
    /**
        Called when a option has been selected
		
		Name | Description
		--- | ---
		`option` | The DMenuOption that was selected
		`optionText` | The options text
    **/
    
    @:hook 
    function OptionSelected(option:Panel, optionText:String):Void;
    /**
        Returns the maximum height of the DMenu.
		
		`**Returns:** The maximum height in pixels
    **/
    
     
    function GetMaxHeight():Float;
    /**
        ***Deprecated:** 
		
		Does nothing.
		
		Name | Description
		--- | ---
		`bool` | 
    **/
    @:deprecated("")
     
    function SetDrawBorder(bool:Bool):Void;
    /**
        ***Deprecated:** 
		
		Highlights selected item in the DMenu by setting the item's key "Highlight" to true. 
		
		Doesn't appear to be working or used.
		
		Name | Description
		--- | ---
		`item` | The item to highlight.
    **/
    @:deprecated("")
     
    function HighlightItem(item:Panel):Void;
    /**
        Used to safely hide (not remove) the menu. This will also hide any opened submenues recursively.
    **/
    
     
    function Hide():Void;
    /**
        Opens the DMenu at the current mouse position
		
		Name | Description
		--- | ---
		`x` | Position (X coordinate) to open the menu at.
		`y` | Position (Y coordinate) to open the menu at.
		`skipanimation` | This argument does nothing.
		`ownerpanel` | 
    **/
    
     
    function Open(?x:Float, ?y:Float, skipanimation:Dynamic, ownerpanel:Panel):Void;
    /**
        ***INTERNAL** 
		
		Used internally to store the open submenu by DMenu:Hide, DMenu:OpenSubMenu, DMenu:CloseSubMenu
		
		Name | Description
		--- | ---
		`item` | The menu to store
    **/
    @:deprecated("INTERNAL")
     
    function SetOpenSubMenu(item:Panel):Void;
    /**
        Sets whether the DMenu should draw the icon column with a different color.
		
		Name | Description
		--- | ---
		`draw` | Whether to draw the column or not
    **/
    
     
    function SetDrawColumn(draw:Bool):Void;
    /**
        Returns the minimum width of the DMenu in pixels
		
		`**Returns:** the minimum width of the DMenu
    **/
    
     
    function GetMinimumWidth():Float;
    /**
        ***INTERNAL** 
		
		Used internally by DMenu:OpenSubMenu.
		
		Name | Description
		--- | ---
		`menu` | The menu to close
    **/
    @:deprecated("INTERNAL")
     
    function CloseSubMenu(menu:Panel):Void;
    /**
        Returns the number of child elements of DMenu's DScrollPanel:GetCanvas.
		
		`**Returns:** The number of child elements
    **/
    
     
    function ChildCount():Float;
    /**
        Gets a child by its index.
		
		**Note:** Unlike Panel:GetChild, this index starts at 1.
		
		Name | Description
		--- | ---
		`childIndex` | The index of the child to get. NOTE Unlike Panel:GetChild, this index starts at 1.
    **/
    
     
    function GetChild(childIndex:Float):Void;
    /**
        Add an option to the DMenu
		
		Name | Description
		--- | ---
		`name` | Name of the option.
		`func` | Function to execute when this option is clicked.
		
		
		`**Returns:** Returns the created DMenuOption panel.
		
		___
		### Lua Examples
		#### Example 1
		Creates a DMenu with 2 options: One that kills yourself; One that does nothing.
		
		```lua 
		local m = DermaMenu()
		
		m:AddOption( "Suicide", function() RunConsoleCommand("kill") end )
		m:AddOption( "It does nothing" )
		
		m:Open()
		```
    **/
    
     
    function AddOption(name:String, ?func:Function):Panel;
    /**
        Creates a DMenuOptionCVar and adds it as an option into the menu. Checking and unchecking the option will alter the given console variable's value.
		
		Name | Description
		--- | ---
		`strText` | The text of the button
		`convar` | The console variable to change
		`on` | The value of the console variable to set when the option is checked
		`off` | The value of the console variable to set when the option is unchecked
		`funcFunction` | If set, the function will be called every time the option is pressed/clicked/selected. It will have only one argument: Panel pnl - The created DMenuOptionCVar.
		
		
		`**Returns:** The created DMenuOptionCVar
    **/
    
     
    function AddCVar(strText:String, convar:String, on:String, off:String, ?funcFunction:Function):Panel;
    /**
        ***INTERNAL** 
		
		Called by DMenuOption. Calls DMenu:OptionSelected.
		
		Name | Description
		--- | ---
		`option` | The DMenuOption that called this function
    **/
    @:deprecated("INTERNAL")
     
    function OptionSelectedInternal(option:Panel):Void;
    /**
        ***Deprecated:** 
		
		Set by DMenu:SetDeleteSelf
		
		`**Returns:** 
    **/
    @:deprecated("")
     
    function GetDeleteSelf():Bool;
    /**
        ***Deprecated:** 
		
		Clears all highlights made by DMenu:HighlightItem. 
		
		Doesn't appear to be used or do anything.
    **/
    @:deprecated("")
     
    function ClearHighlights():Void;
    /**
        ***INTERNAL** 
		
		Returns the currently opened submenu. 
		
		Used internally to store the open submenu by DMenu:Hide, DMenu:OpenSubMenu.
		
		`**Returns:** The currently opened submenu, if any.
    **/
    @:deprecated("INTERNAL")
     
    function GetOpenSubMenu():Panel;
    /**
        Adds a panel to the DMenu as if it were an option. 
		
		This invokes DScrollPanel:AddItem and will not create a new panel if a class name is passed, unlike Panel:Add.
		
		Name | Description
		--- | ---
		`pnl` | The panel that you want to add.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DMenu with some options and places a red DPanel between them.
		
		```lua 
		local m = DermaMenu()
		
		m:AddOption( "Kill yourself", function() RunConsoleCommand( "kill" ) end ) -- Add first option
		m:AddSpacer()
		
		-- Create a red DPanel
		local panel = vgui.Create( "DPanel", m )
		panel:SetSize( 50, 100 )
		panel:SetBackgroundColor( Color( 255, 0, 0 ) )
		
		m:AddPanel( panel ) -- Add the panel
		
		m:AddSpacer()
		m:AddOption( "Say hi", function() RunConsoleCommand( "say", "Hi!" ) end ) -- Add second option
		
		m:Open() -- Show our menu
		```
    **/
    
     
    function AddPanel(pnl:Panel):Void;
    /**
        Returns whether the DMenu should draw the icon column with a different color or not. 
		
		See DMenu:SetDrawColumn
		
		`**Returns:** Whether to draw the column or not
    **/
    
     
    function GetDrawColumn():Bool;
    /**
        Sets the maximum height the DMenu can have. If the height of all menu items exceed this value, a scroll bar will be automatically added.
		
		Name | Description
		--- | ---
		`maxHeight` | The maximum height of the DMenu to set, in pixels
    **/
    
     
    function SetMaxHeight(maxHeight:Float):Void;
    /**
        Closes any active sub menus, and opens a new one.
		
		Name | Description
		--- | ---
		`item` | The DMenuOption to open the submenu at
		`menu` | The submenu to open. If set to nil, the function just closes existing submenus.
    **/
    
     
    function OpenSubMenu(item:Panel, ?menu:Panel):Void;
    /**
        Sets the minimum width of the DMenu. The menu will be stretched to match the given value.
		
		Name | Description
		--- | ---
		`minWidth` | The minimum width of the DMenu in pixels
    **/
    
     
    function SetMinimumWidth(minWidth:Float):Void;
    /**
        ***Deprecated:** 
		
		Returns the value set by DMenu:SetDrawBorder.
		
		`**Returns:** 
    **/
    @:deprecated("")
     
    function GetDrawBorder():Bool;
    /**
        Adds a horizontal line spacer.
		
		___
		### Lua Examples
		#### Example 1
		Creates a DMenu with 3 options and adds a spacer before the third.
		
		```lua 
		local m = DermaMenu()
		
		m:AddOption( "Kill yourself", function() RunConsoleCommand( "kill" ) end ) -- Add first option
		m:AddOption( "Disconnect", function() RunConsoleCommand( "disconnect" ) end ) -- Add second option
		
		m:AddSpacer() -- Add a spacer
		
		m:AddOption( "Say hi", function() RunConsoleCommand( "say", "Hi!" ) end ) -- Add third option
		
		m:Open() -- Show our menu
		```
    **/
    
     
    function AddSpacer():Void;
    /**
        Add a sub menu to the DMenu
		
		Name | Description
		--- | ---
		`Name` | Name of the sub menu.
		`func` | Function to execute when this sub menu is clicked.
		
		
		Name | Description
		--- | ---
		`a` | The created sub DMenu
		`b` | The created DMenuOption
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a menu with one option "Do you want to die?", which has two sub-options "Yes" and "No".
		
		```lua 
		local parentMenu = DermaMenu()
		
		local subMenu, parentMenuOption = parentMenu:AddSubMenu("Do you want to die?")
		parentMenuOption:SetIcon("icon16/user_red.png")
		
		local yesOption = subMenu:AddOption("Yes", function() LocalPlayer():ConCommand("kill") end)
		yesOption:SetIcon("icon16/accept.png")
		
		local noOption = subMenu:AddOption("No", function() print("You chose to live another day") end)
		noOption:SetIcon("icon16/cross.png")
		
		parentMenu:Open()
		```
    **/
    
     
    function AddSubMenu(Name:String, ?func:Function):DMenuAddSubMenuReturn;
    /**
        Set to true by default. IF set to true, the menu will be deleted when it is closed, not simply hidden. 
		
		This is used by DMenuBar
		
		Name | Description
		--- | ---
		`newState` | true to delete menu on close, false to simply hide.
    **/
    
     
    function SetDeleteSelf(newState:Bool):Void;
    
}


@:multiReturn extern class DMenuAddSubMenuReturn {
var a:Panel;
var b:Panel;

}

#end