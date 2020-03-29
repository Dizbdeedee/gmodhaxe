package gmod.panels;
#if client

/**
    A tab oriented control where you can create multiple tabs with items within. Used mainly for organization.
**/
extern class DPropertySheet extends DPanel {
    /**
        ***Deprecated:** 
		
		Does nothing.
		
		Name | Description
		--- | ---
		`show` | 
    **/
    @:deprecated("")
     
    function SetShowIcons(show:Bool):Void;
    /**
        Creates a close button on the right side of the DPropertySheet that will run the given callback function when pressed.
		
		Name | Description
		--- | ---
		`func` | Callback function to be called when the close button is pressed.
    **/
    
     
    function SetupCloseButton(func:Function):Void;
    /**
        Switches the active tab to a tab with given name.
		
		Name | Description
		--- | ---
		`name` | Case sensitive name of the tab.
    **/
    
     
    function SwitchToName(name:String):Void;
    /**
        Returns the amount of time (in seconds) it takes to fade between tabs. 
		
		Set by DPropertySheet:SetFadeTime
		
		`**Returns:** The amount of time (in seconds) it takes to fade between tabs.
    **/
    
     
    function GetFadeTime():Float;
    /**
        Sets the padding from parent panel to children panel.
		
		Name | Description
		--- | ---
		`padding` | Amount of padding
    **/
    
     
    function SetPadding(?padding:Float):Void;
    /**
        Returns a list of all tabs of this DPropertySheet.
		
		`**Returns:** A table of tables. Each table contains 3 key-value pairs: string Name - The name of the tab. Panel Tab - The DTab associated with the tab Panel Panel - The Panel associated with the tab
    **/
    
     
    function GetItems():AnyTable;
    /**
        Returns the active DTab of this DPropertySheet.
		
		`**Returns:** The DTab
    **/
    
     
    function GetActiveTab():Panel;
    /**
        Adds a new tab.
		
		Name | Description
		--- | ---
		`name` | Name of the tab
		`pnl` | Panel to be used as contents of the tab. This normally should be a DPanel
		`icon` | Icon for the tab. This will ideally be a silkicon, but any material name can be used.
		`noStretchX` | Should DPropertySheet try to fill itself with given panel horizontally.
		`noStretchY` | Should DPropertySheet try to fill itself with given panel vertically.
		`tooltip` | Tooltip for the tab when user hovers over it with his cursor
		
		
		`**Returns:** A table containing the following keys: Panel Tab - The created DTab. string Name - Name of the created tab Panel Panel - The contents panel of the tab
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize( ScrW() / 2, ScrH() / 2 )
		frame:SetTitle( "Test Frame" )
		frame:MakePopup()
		frame:Center()
		
		local tabs = vgui.Create( "DPropertySheet", frame )
		tabs:Dock( FILL )
		
		local tab1panel = vgui.Create( "DPanel" )
		
		local SheetItem = vgui.Create( "DButton", tab1panel )
		SheetItem:SetText( "Suicide" )
		SheetItem:SetConsoleCommand( "kill" )
		 
		tabs:AddSheet( "Tab 1", tab1panel, "icon16/user.png", false, false, "Description of first tab")
		```
    **/
    
     
    function AddSheet(name:String, pnl:Panel, ?icon:String, ?noStretchX:Bool, ?noStretchY:Bool, ?tooltip:String):AnyTable;
    /**
        Called when a player switches the tabs
		
		Name | Description
		--- | ---
		`old` | The previously active DTab
		`new` | The newly active DTab
    **/
    
    @:hook 
    function OnActiveTabChanged(old:Panel, _new:Panel):Void;
    /**
        ***Deprecated:** 
		
		Returns whatever value was set by DPropertySheet:SetShowIcons.
		
		`**Returns:** 
    **/
    @:deprecated("")
     
    function GetShowIcons():Bool;
    /**
        Sets the amount of time (in seconds) it takes to fade between tabs.
		
		Name | Description
		--- | ---
		`time` | The amount of time it takes (in seconds) to fade between tabs.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the fade time to 0.5 seconds (500 milliseconds)
		
		```lua 
		DPropertySheet.SetFadeTime(0.5)
		```
		
		#### Example 2
		Sets the fade time to 2 seconds (2000 milliseconds)
		
		```lua 
		DPropertySheet.SetFadeTime(2)
		```
    **/
    
     
    function SetFadeTime(?time:Float):Void;
    /**
        Gets the padding from the parent panel to child panels.
		
		`**Returns:** Padding
    **/
    
     
    function GetPadding():Float;
    /**
        Sets the width of the DPropertySheet to fit the contents of all of the tabs.
    **/
    
     
    function SizeToContentWidth():Void;
    /**
        Sets the active tab of the DPropertySheet.
		
		Name | Description
		--- | ---
		`tab` | The DTab to set active. See DPropertySheet: GetItems
		
		
		___
		### Lua Examples
		#### Example 1
		Example of how you'd create and use this panel and set active tab.
		
		```lua 
		local MainFrame = vgui.Create( "DFrame" )
		MainFrame:SetSize( 500, 300 )
		MainFrame:Center()
		MainFrame:MakePopup()
		
		local MainSheet = vgui.Create( "DPropertySheet", MainFrame )
		MainSheet:Dock( FILL )
		
		local First_Panel = vgui.Create( "DPanel", MainSheet )
		First_Panel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 128, 255, self:GetAlpha() ) ) end
		MainSheet:AddSheet( "test", First_Panel, "icon16/cross.png" )
		
		local Second_Panel = vgui.Create( "DPanel", MainSheet )
		Second_Panel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 128, 0, self:GetAlpha() ) ) end
		MainSheet:AddSheet( "test 2", Second_Panel, "icon16/tick.png" )
		
		MainSheet:SetActiveTab( MainSheet:GetItems()[2].Tab ) --2 is a representation of the second sheet
		```
    **/
    
     
    function SetActiveTab(tab:Panel):Void;
    /**
        ***INTERNAL** 
		
		Internal function that handles the cross fade animation when the player switches tabs.
		
		Name | Description
		--- | ---
		`anim` | 
		`delta` | 
		`data` | 
    **/
    @:deprecated("INTERNAL")
     
    function CrossFade(anim:AnyTable, delta:Float, data:AnyTable):Void;
    /**
        Removes tab and/or panel from the parent DPropertySheet.
		
		Name | Description
		--- | ---
		`tab` | The DTab of the sheet from DPropertySheet. See DPropertySheet: GetItems.
		`removePanel` | Set to true to remove the associated panel object as well.
		
		
		`**Returns:** The panel of the tab.
		
		___
		### Lua Examples
		#### Example 1
		Example of how you'd create and use this panel and close unnecessary sheets.
		
		```lua 
		local MainFrame = vgui.Create( "DFrame" )
		MainFrame:SetSize( 500, 300 )
		MainFrame:Center()
		MainFrame:MakePopup()
		
		local MainSheet = vgui.Create( "DPropertySheet", MainFrame )
		MainSheet:Dock( FILL )
		
		local First_Panel = vgui.Create( "DPanel", MainSheet )
		First_Panel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 128, 0, self:GetAlpha() ) ) end
		MainSheet:AddSheet( "Users Page", First_Panel, "icon16/user.png" )
		
		local Second_Panel = vgui.Create( "DPanel", MainSheet )
		Second_Panel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 128, 255, self:GetAlpha() ) ) end
		MainSheet:AddSheet( "Admins Page", Second_Panel, "icon16/lightning.png" )
		
		if LocalPlayer():IsAdmin() then
		    MainSheet:CloseTab( MainSheet:GetItems()[1].Tab ) --1 is a representation of the first sheet
		else
		    MainSheet:CloseTab( MainSheet:GetItems()[2].Tab ) --2 is a representation of the second sheet
		end
		```
    **/
    
     
    function CloseTab(tab:Panel, removePanel:Bool):Panel;
    
}



#end