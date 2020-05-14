package gmod.panels;
#if client

/**
    ***Deprecated:**   DPanelList was succeeded in version 13 by more specialised layout elements, such as a combination of DIconLayout, DListLayout and DScrollPanel.
	
	Displays elements in a horizontal or vertical list. A scrollbar is automatically shown if necessary. Use is not recommended due to deprecation.
**/
extern class DPanelList extends DPanel {
    /**
        Sets distance between list items
		
		Name | Description
		--- | ---
		`Distance` | Distance between panels
    **/
    
     
    function SetSpacing(Distance:Float):Void;
    /**
        Adds a existing panel to the end of DPanelList.
		
		Name | Description
		--- | ---
		`pnl` | Panel to be used as element of list
		`state` | If set to "ownline", the item will take its own entire line.
    **/
    
     
    function AddItem(pnl:Panel, ?state:String):Void;
    /**
        Sets the offset of the lists items from the panel borders
		
		Name | Description
		--- | ---
		`Offset` | Offset from panel borders
    **/
    
     
    function SetPadding(Offset:Float):Void;
    /**
        
		
		Name | Description
		--- | ---
		`insert` | The panel to insert
		`strLineState` | If set to "ownline", no other panels will be placed to the left or right of the panel we are inserting
    **/
    
     
    function InsertAtTop(insert:Panel, strLineState:String):Void;
    /**
        Returns all panels has added by DPanelList:AddItem
		
		`**Returns:** A table of panels used as items of DPanelList.
    **/
    
     
    function GetItems():AnyTable;
    /**
        Returns distance between list items set by DPanelList:SetSpacing
		
		`**Returns:** Distance between panels
    **/
    
     
    function GetSpacing():Float;
    /**
        Returns offset of list items from the panel borders set by DPanelList:SetPadding
		
		`**Returns:** Offset from panel borders
    **/
    
     
    function GetPadding():Float;
    /**
        Enables/creates the vertical scroll bar so that the panel list can be scrolled through.
    **/
    
     
    function EnableVerticalScrollbar():Void;
    /**
        Removes all items.
    **/
    
     
    function CleanList():Void;
    
}



#end