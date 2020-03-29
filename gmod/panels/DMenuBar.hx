package gmod.panels;
#if client

/**
    A simple Derma MenuBar
**/
extern class DMenuBar extends DPanel {
    /**
        Sets the background color
		
		Name | Description
		--- | ---
		`color` | See Color structure
    **/
    
     
    function SetBackgroundColor(color:Color):Void;
    /**
        Sets whether or not the panel is a menu. Used for closing menus when another panel is selected.
		
		Name | Description
		--- | ---
		`isMenu` | Is this a menu
    **/
    
     
    function SetIsMenu(isMenu:Bool):Void;
    /**
        If a menu is visible/opened, then the menu is returned.
		
		`**Returns:** Returns the visible/open menu or nil.
    **/
    
     
    function GetOpenMenu():Panel;
    /**
        ***Deprecated:** Use DMenuBar: GetPaintBackground instead.
		
		Returns whether or not the background should be painted. Is the same as DMenuBar:GetPaintBackground
		
		`**Returns:** Should the background be painted
    **/
    @:deprecated("Use DMenuBar: GetPaintBackground instead.")
     
    function GetDrawBackground():Bool;
    /**
        Returns whether or not the background should be painted. Is the same as DMenuBar:GetDrawBackground
		
		`**Returns:** Should the background be painted
    **/
    
     
    function GetPaintBackground():Bool;
    /**
        ***Deprecated:** Use DMenuBar: SetPaintBackground
		
		Sets whether or not the background should be painted. Is the same as DMenuBar:SetPaintBackground
		
		Name | Description
		--- | ---
		`shouldPaint` | Should the background be painted
    **/
    @:deprecated("Use DMenuBar: SetPaintBackground")
     
    function SetDrawBackground(shouldPaint:Bool):Void;
    /**
        Returns whether or not the DMenuBar is disabled
		
		`**Returns:** Is disabled
    **/
    
     
    function GetDisabled():Bool;
    /**
        Retrieves a DMenu object from the menu bar. If one with the given label doesn't exist, a new one is created. 
		
		To add a DMenu without checking, use DMenuBar:AddMenu.
		
		Name | Description
		--- | ---
		`label` | The name (label) of the derma menu to get or create.
		
		
		`**Returns:** The DMenu with the given label.
    **/
    
     
    function AddOrGetMenu(label:String):Panel;
    /**
        Sets whether or not the panel is disabled
		
		Name | Description
		--- | ---
		`disable` | Should be disabled or not
    **/
    
     
    function SetDisabled(disable:Bool):Void;
    /**
        Sets whether or not the background should be painted. Is the same as DMenuBar:SetDrawBackground
		
		Name | Description
		--- | ---
		`shouldPaint` | Should the background be painted
    **/
    
     
    function SetPaintBackground(shouldPaint:Bool):Void;
    /**
        Creates a new DMenu object tied to a DButton with the given label on the menu bar. 
		
		This will create a new menu regardless of whether or not one with the same label exists. To add or get a menu, use DMenuBar:AddOrGetMenu.
		
		Name | Description
		--- | ---
		`label` | The name (label) of the derma menu to create.
		
		
		`**Returns:** The new DMenu which will be opened when the button is clicked.
    **/
    
     
    function AddMenu(label:String):Panel;
    /**
        Returns the DMenuBar's background color
		
		`**Returns:** The background's color. See Color structure
    **/
    
     
    function GetBackgroundColor():Color;
    /**
        Returns whether or not the panel is a menu. Used for closing menus when another panel is selected.
		
		`**Returns:** Is a menu
    **/
    
     
    function GetIsMenu():Bool;
    
}



#end