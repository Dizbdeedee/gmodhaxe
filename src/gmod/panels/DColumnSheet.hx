package gmod.panels;
#if client

/**
    Similar to DPropertySheet, but with tabs on the left.
**/
extern class DColumnSheet extends Panel {
    /**
        ***INTERNAL** 
		
		Makes a button an active button for this DColumnSheet.
		
		Name | Description
		--- | ---
		`active` | The button to make active button
    **/
    @:deprecated("INTERNAL")
     
    function SetActiveButton(active:Panel):Void;
    /**
        Makes the tabs/buttons show only the image and no text.
    **/
    
     
    function UseButtonOnlyStyle():Void;
    /**
        Adds a new column/tab.
		
		Name | Description
		--- | ---
		`name` | Name of the column/tab
		`pnl` | Panel to be used as contents of the tab. This normally would be a DPanel
		`icon` | Icon for the tab. This will ideally be a silkicon, but any material name can be used.
		
		
		`**Returns:** A table containing the following keys: Panel Button - The created tab button that will switch to the given panel Panel Panel - The given panel to switch to when the button is pressed
    **/
    
     
    function AddSheet(name:String, pnl:Panel, ?icon:String):AnyTable;
    /**
        Returns the active button of this DColumnSheet.
		
		`**Returns:** The active button
    **/
    
     
    function GetActiveButton():Panel;
    
}



#end