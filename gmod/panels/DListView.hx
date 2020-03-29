package gmod.panels;
#if client

/**
    A data view with rows and columns.
**/
extern class DListView extends DPanel {
    /**
        Sorts the list based on given columns. 
		
		All arguments are optional
		
		Name | Description
		--- | ---
		`column1` | 
		`descrending1` | 
		`column2` | 
		`descrending2` | 
		`column3` | 
		`descrending3` | 
		`column4` | 
		`descrending4` | 
    **/
    
     
    function SortByColumns(?column1:Float, ?descrending1:Bool, ?column2:Float, ?descrending2:Bool, ?column3:Float, ?descrending3:Bool, ?column4:Float, ?descrending4:Bool):Void;
    /**
        Removes a line from the list view.
		
		Name | Description
		--- | ---
		`line` | Removes the given row, by row id (same number as DListView: GetLine).
    **/
    
     
    function RemoveLine(line:Float):Void;
    /**
        ***INTERNAL** Use DListView: OnRowSelected instead!
		
		Called whenever a line is clicked.
		
		Name | Description
		--- | ---
		`line` | The selected line.
		`isSelected` | Boolean indicating whether the line is selected.
    **/
    @:deprecated("INTERNAL: Use DListView: OnRowSelected instead!")
    @:hook 
    function OnClickLine(line:Panel, isSelected:Bool):Void;
    /**
        Gets all of the lines added to the DListView.
		
		`**Returns:** The lines added to the DListView.
		
		___
		### Lua Examples
		#### Example 1
		Loops through all of the lines of a DListView and prints their first value.
		
		```lua 
		local list = vgui.Create( "DListView" )
		list:AddColumn( "Fruit" )
		
		local lines = { "Apple", "Orange", "Banana" }
		
		for _, line in pairs( lines ) do
		    list:AddLine( line )
		end
		
		for k, line in pairs( list:GetLines() ) do
		    print( k, line:GetValue( 1 ) )
		end
		```
		**Output:**
		
		1 Apple
		2 Orange
		3 Banana
    **/
    
     
    function GetLines():AnyTable;
    /**
        Called when a line in the DListView is double clicked.
		
		Name | Description
		--- | ---
		`lineID` | The line number of the double clicked line.
		`line` | The double clicked DListView_Line.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local DList = vgui.Create("DListView")
		DList:SetPos(5,50)
		DList:SetSize(150, 245)
		DList:AddColumn("Player Names")
		
		for k, v in pairs( player.GetAll() ) do
		    DList:AddLine(v:Name())
		end
		
		function DList:DoDoubleClick( lineID, line )
		    MsgN( "Line " .. lineID .. " was double clicked!" )
		end
		```
		**Output:**
		
		The double clicked line number is printed, e.g. Line 6 was double clicked!
    **/
    
     
    function DoDoubleClick(lineID:Float, line:Panel):Void;
    /**
        Gets all of the lines that are currently selected.
		
		`**Returns:** A table of DListView_Lines.
    **/
    
     
    function GetSelected():AnyTable;
    /**
        Creates the lines and gets the height of the contents, in a DListView.
		
		`**Returns:** The height of the contents
    **/
    
     
    function DataLayout():Float;
    /**
        Resizes the panel so that its width and height fit all of the content inside.
		
		**Warning:** You must call this function AFTER setting text/font, adjusting child panels or otherwise altering the panel.
		
		**Note:** Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.
    **/
    
     
    function SizeToContents():Void;
    /**
        Adds a line to the list view.
		
		Name | Description
		--- | ---
		`text` | Values for a new row in the DListView, If several arguments are supplied, each argument will correspond to a respective column in the DListView.
		
		
		`**Returns:** The newly created DListView_Line.
    **/
    
     
    function AddLine(text:Rest<Dynamic>):Panel;
    /**
        Returns whether the header line should be visible on not.
		
		`**Returns:** Whether the header line should be visible on not.
    **/
    
     
    function GetHideHeaders():Bool;
    /**
        Called when a row is right-clicked
		
		Name | Description
		--- | ---
		`lineID` | The line ID of the right clicked line
		`line` | The line panel itself, a DListView_Line.
    **/
    
    @:hook 
    function OnRowRightClick(lineID:Float, line:Panel):Void;
    /**
        Clears the current selection in the DListView.
    **/
    
     
    function ClearSelection():Void;
    /**
        Sets the height of the header line of the DListView. 
		
		See also DListView:SetDataHeight.
		
		Name | Description
		--- | ---
		`height` | The new height to set. Default value is 16.
    **/
    
     
    function SetHeaderHeight(height:Float):Void;
    /**
        Returns the height of the header of the DListView. 
		
		See also DListView:SetHeaderHeight.
		
		`**Returns:** The height of the header of the DListView.
    **/
    
     
    function GetHeaderHeight():Float;
    /**
        Adds a column to the listview.
		
		Name | Description
		--- | ---
		`column` | The name of the column to add.
		`position` | Sets the ordering of this column compared to other columns.
		
		
		`**Returns:** The newly created DListView_Column.
    **/
    
     
    function AddColumn(column:String, position:Float):Panel;
    /**
        ***INTERNAL** 
		
		Internal helper function called from the PANEL:PerformLayout of DListView.
    **/
    @:deprecated("INTERNAL")
     
    function FixColumnsLayout():Void;
    /**
        Selects the line at the first index of the DListView if one has been added.
    **/
    
     
    function SelectFirstItem():Void;
    /**
        Sets whether the header line should be visible on not.
		
		Name | Description
		--- | ---
		`hide` | Whether the header line should be visible on not.
    **/
    
     
    function SetHideHeaders(hide:Bool):Void;
    /**
        ***INTERNAL** 
		
		Converts LineID to SortedID
		
		Name | Description
		--- | ---
		`lineId` | The DListView_Line: GetID of a line to look up
		
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetSortedID(lineId:Float):Float;
    /**
        ***INTERNAL** 
		
		Called from DListView_Column.
		
		Name | Description
		--- | ---
		`column` | The column which initialized the resize
		`size` | 
    **/
    @:deprecated("INTERNAL")
     
    function OnRequestResize(column:Panel, size:Float):Void;
    /**
        Gets the width of a column.
		
		Name | Description
		--- | ---
		`column` | The column to get the width of.
		
		
		`**Returns:** Width of the column.
    **/
    
     
    function ColumnWidth(column:Float):Float;
    /**
        Sets the height of all lines of the DListView except for the header line. 
		
		See also DListView:SetHeaderHeight.
		
		Name | Description
		--- | ---
		`height` | The new height to set. Default value is 17.
    **/
    
     
    function SetDataHeight(height:Float):Void;
    /**
        Returns whether multiple lines can be selected or not. 
		
		See DListView:SetMultiSelect.
		
		`**Returns:** Whether multiple lines can be selected or not.
    **/
    
     
    function GetMultiSelect():Bool;
    /**
        Enables/disables the sorting of columns by clicking.
		
		Name | Description
		--- | ---
		`isSortable` | Whether sorting columns with clicking is allowed or not.
    **/
    
     
    function SetSortable(isSortable:Bool):Void;
    /**
        Returns the height of the data of the DListView. 
		
		See also DListView:SetDataHeight.
		
		`**Returns:** The height of the data of the DListView.
    **/
    
     
    function GetDataHeight():Float;
    /**
        Gets the currently selected DListView_Line index. 
		
		If DListView:SetMultiSelect is set to true, only the first line of all selected lines will be returned. Use DListView:GetSelected instead to get all of the selected lines.
		
		Name | Description
		--- | ---
		`a` | The index of the currently selected line.
		`b` | The currently selected DListView_Line. Next Update Change This feature is only available in the next update. Next Update Change This feature is only available in the next update.
    **/
    
     
    function GetSelectedLine():DListViewGetSelectedLineReturn;
    /**
        Sets whether multiple lines can be selected by the user by using the Ctrl or ⇧ Shift keys. When set to false, only one line can be selected.
		
		Name | Description
		--- | ---
		`allowMultiSelect` | Whether multiple lines can be selected or not
    **/
    
     
    function SetMultiSelect(allowMultiSelect:Bool):Void;
    /**
        Called internally by DListView:OnClickLine when a line is selected. This is the function you should override to define the behavior when a line is selected.
		
		Name | Description
		--- | ---
		`rowIndex` | The index of the row/line that the user clicked on.
		`row` | The DListView_Line that the user clicked on.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the first two column values of the row that was clicked. In this example it's the nickname and kills of the player selected in the list
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 300, 300 )
		frame:MakePopup()
		
		local listView = frame:Add( "DListView" )
		listView:Dock( FILL )
		
		listView:AddColumn( "Nick" )
		listView:AddColumn( "Frags" )
		
		for _, v in pairs( player.GetAll() ) do
		    listView:AddLine( v:Nick(), v:Frags() )
		end
		listView.OnRowSelected = function( panel, rowIndex, row )
		    print( row:GetValue( 1 ) )
		    print( row:GetValue( 2 ) )
		end
		```
    **/
    
    @:hook 
    function OnRowSelected(rowIndex:Float, row:Panel):Void;
    /**
        Sorts the items in the specified column.
		
		Name | Description
		--- | ---
		`columnIndex` | The index of the column that should be sorted.
		`descending` | Whether the items should be sorted in descending order or not.
    **/
    
     
    function SortByColumn(columnIndex:Float, ?descending:Bool):Void;
    /**
        Removes the scrollbar.
    **/
    
     
    function DisableScrollbar():Void;
    /**
        Returns the height of DListView:GetCanvas. 
		
		Intended to represent the height of all data lines.
		
		`**Returns:** The height of DListView: GetCanvas.
    **/
    
     
    function GetInnerTall():Float;
    /**
        Removes all lines that have been added to the DListView.
    **/
    
     
    function Clear():Void;
    /**
        Gets the canvas.
		
		`**Returns:** The canvas.
    **/
    
     
    function GetCanvas():Panel;
    /**
        Returns whether sorting of columns by clicking their headers is allowed or not. 
		
		See also DListView:SetSortable.
		
		`**Returns:** Whether sorting of columns by clicking their headers is allowed or not
    **/
    
     
    function GetSortable():Bool;
    /**
        Gets the DListView_Line at the given index.
		
		Name | Description
		--- | ---
		`id` | The index of the line to get.
		
		
		`**Returns:** The DListView_Line at the given index.
		
		___
		### Lua Examples
		#### Example 1
		An example of how to retrieve a DListView_Line from a DListView.
		
		```lua 
		local list = vgui.Create( "DListView" )
		list:AddColumn( "Name" )
		list:AddLine( "Garry :D" )
		
		print( list:GetLine( 1 ) )
		```
		**Output:**
		
		Panel: [name:DListView_Line][class:Panel][0,0,64,24]
    **/
    
     
    function GetLine(id:Float):Panel;
    /**
        Selects a line in the listview.
		
		Name | Description
		--- | ---
		`Line` | The line to select.
    **/
    
     
    function SelectItem(Line:Panel):Void;
    /**
        ***INTERNAL** 
		
		See DListView:SetDirty.
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetDirty():Bool;
    /**
        ***INTERNAL** 
		
		Used internally to signify if the DListView needs a rebuild.
		
		Name | Description
		--- | ---
		`isDirty` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetDirty(isDirty:Bool):Void;
    
}


@:multiReturn extern class DListViewGetSelectedLineReturn {
var a:Float;
var b:Panel;

}

#end