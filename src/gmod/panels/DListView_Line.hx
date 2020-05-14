package gmod.panels;
#if client

/**
    A panel used by [DListView](https://wiki.garrysmod.com/page/Category:DListView)  Inherits the following functions from Panel and its parents up to 3 levels deep:
**/
extern class DListView_Line extends Panel {
    /**
        Gets the string held in the specified column of a DListView_Line panel. 
		
		This is the same thing as doing DListView_Line:GetValue( column_number ).
		
		Name | Description
		--- | ---
		`column` | The number of the column to retrieve the text from, starts with 1.
		
		
		`**Returns:** The contents of the specified column.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local dframe = vgui.Create("DFrame")
		dframe:SetSize(450, 350)
		dframe:Center()
		
		local dlist = vgui.Create("DListView", dframe)
		dlist:Dock(FILL)
		dlist:SetMultiSelect(false)
		dlist:AddColumn("Name")
		dlist:AddColumn("SteamID")
		dlist:AddLine("Stalker", "STEAM_0:1:18093014")
		function dlist:DoDoubleClick(linenumber, lineinfo)
		    print(lineinfo:GetColumnText(2))
		end
		```
		**Output:**
		
		Prints "STEAM_0:1:18093014" when the line containing Stalker is double clicked.
    **/
    
     
    function GetColumnText(column:Float):String;
    /**
        Sets the string held in the specified column of a DListView_Line panel.
		
		Name | Description
		--- | ---
		`column` | The number of the column to write the text from, starts with 1.
		`value` | Column text you want to set
    **/
    
     
    function SetColumnText(column:Float, value:String):Void;
    
}



#end