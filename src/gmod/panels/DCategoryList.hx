package gmod.panels;
#if client

/**
    A host for multiple DCollapsibleCategory panels. As the name suggests, each one of them can be collapsed or expanded on demand by the user.
**/
extern class DCategoryList extends DScrollPanel {
    /**
        Adds a DCollapsibleCategory to the list.
		
		Name | Description
		--- | ---
		`categoryName` | The name of the category to add.
		
		
		`**Returns:** The created DCollapsibleCategory
    **/
    
     
    function Add(categoryName:String):Panel;
    /**
        Adds an element to the list.
		
		Name | Description
		--- | ---
		`element` | VGUI element to add to the list.
    **/
    
     
    function AddItem(element:Panel):Void;
    /**
        Calls Panel:UnselectAll on all child elements, if they have it.
    **/
    
     
    function UnselectAll():Void;
    
}



#end