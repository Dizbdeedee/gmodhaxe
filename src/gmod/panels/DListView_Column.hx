package gmod.panels;
#if client

/**
    A single column, used by [DListView](https://wiki.garrysmod.com/page/Category:DListView).  Inherits the following functions from DPanel and its parents up to 3 levels deep:
**/
extern class DListView_Column extends DPanel {
    /**
        Sets the width of the panel.
		
		Name | Description
		--- | ---
		`width` | The number value which will determine panel width.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DListView and populates it with two columns and two items, only one of which can be selected at a time.The first column width is 15. The second column width is 350.
		
		```lua 
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 500, 500 )
		Frame:Center()
		Frame:MakePopup()
		
		local SimpleList = vgui.Create( "DListView", Frame )
		SimpleList:Dock( FILL )
		SimpleList:SetMultiSelect( false )
		
		SimpleList:AddColumn( "Column 1" ):SetWidth(15)
		SimpleList:AddColumn( "Column 2" ):SetWidth(350)
		
		SimpleList:AddLine( "First", "Column" )
		SimpleList:AddLine( "Second", "Column" )
		```
    **/
    
     
    function SetWidth(width:Float):Void;
    /**
        Sets the fixed width of the column.
		
		Name | Description
		--- | ---
		`width` | The number value which will determine a fixed width.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DListView and populates it with two columns and two items, only one of which can be selected at a time.The first column will be longer than the second column.
		
		```lua 
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 500, 500 )
		Frame:Center()
		Frame:MakePopup()
		
		local SimpleList = vgui.Create( "DListView", Frame )
		SimpleList:Dock( FILL )
		SimpleList:SetMultiSelect( false )
		
		SimpleList:AddColumn( "Column 1" )
		SimpleList:AddColumn( "Column 2" ):SetFixedWidth(125)
		
		SimpleList:AddLine( "First", "Column" )
		SimpleList:AddLine( "Second", "Column" )
		```
    **/
    
     
    function SetFixedWidth(width:Float):Void;
    /**
        Sets the minimum width of a column.
		
		Name | Description
		--- | ---
		`width` | The number value which will determine a minimum width.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DListView and populates it with two columns and two items, only one of which can be selected at a time.The second column can't be smaller than the argument value.
		
		```lua 
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 500, 500 )
		Frame:Center()
		Frame:MakePopup()
		
		local SimpleList = vgui.Create( "DListView", Frame )
		SimpleList:Dock( FILL )
		SimpleList:SetMultiSelect( false )
		
		SimpleList:AddColumn( "Column 1" )
		SimpleList:AddColumn( "Column 2" ):SetMinWidth(125)
		
		SimpleList:AddLine( "First", "Column" )
		SimpleList:AddLine( "Second", "Column" )
		```
    **/
    
     
    function SetMinWidth(width:Float):Void;
    /**
        Sets the maximum width of a column.
		
		Name | Description
		--- | ---
		`width` | The number value which will determine a maximum width.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DListView and populates it with two columns and two items, only one of which can be selected at a time.The second column can't be bigger than the argument value.
		
		```lua 
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 500, 500 )
		Frame:Center()
		Frame:MakePopup()
		
		local SimpleList = vgui.Create( "DListView", Frame )
		SimpleList:Dock( FILL )
		SimpleList:SetMultiSelect( false )
		
		SimpleList:AddColumn( "Column 1" )
		SimpleList:AddColumn( "Column 2" ):SetMaxWidth(225)
		
		SimpleList:AddLine( "First", "Column" )
		SimpleList:AddLine( "Second", "Column" )
		```
    **/
    
     
    function SetMaxWidth(width:Float):Void;
    /**
        Sets the text alignment for the column
		
		Name | Description
		--- | ---
		`alignment` | The direction of the content, based on the number pad. 7: top-left 8: top-center 9: top-right 4: middle-left 5: center 6: middle-right 1: bottom-left 2: bottom-center 3: bottom-right
    **/
    
     
    function SetTextAlign(alignment:Float):Void;
    
}



#end