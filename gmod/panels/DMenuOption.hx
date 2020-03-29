package gmod.panels;
#if client

/**
    Internal subpanel that represents an option used by DMenu.
**/
extern class DMenuOption extends DButton {
    /**
        Sets the checked state of the DMenuOption. Does not invoke DMenuOption:OnChecked.
		
		Name | Description
		--- | ---
		`checked` | 
    **/
    
     
    function SetChecked(checked:Bool):Void;
    /**
        Returns the checked state of DMenuOption.
		
		`**Returns:** Are we checked or not
    **/
    
     
    function GetChecked():Bool;
    /**
        Toggles the checked state of DMenuOption. Does not respect DMenuOption:GetIsCheckable.
    **/
    
     
    function ToggleCheck():Void;
    /**
        
		
		`**Returns:** A DMenu
    **/
    
     
    function GetMenu():Panel;
    /**
        Sets whether the DMenuOption is a checkbox option or a normal button option.
		
		Name | Description
		--- | ---
		`checkable` | 
    **/
    
     
    function SetIsCheckable(checkable:Bool):Void;
    /**
        Returns whether the DMenuOption is a checkbox option or a normal button option.
		
		`**Returns:** 
    **/
    
     
    function GetIsCheckable():Bool;
    /**
        Called whenever the DMenuOption's checked state changes.
		
		Name | Description
		--- | ---
		`checked` | The new checked state
    **/
    
    @:hook 
    function OnChecked(checked:Bool):Void;
    /**
        
		
		Name | Description
		--- | ---
		`pnl` | 
    **/
    
     
    function SetMenu(pnl:Panel):Void;
    /**
        ***INTERNAL** 
		
		Used internally by DMenuOption:AddSubMenu to create the submenu arrow and assign the created submenu to be opened this this option is hovered.
		
		Name | Description
		--- | ---
		`menu` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetSubMenu(menu:Panel):Void;
    /**
        Creates a sub DMenu and returns it. Has no duplicate call protection.
		
		`**Returns:** The created DMenu to add options to.
    **/
    
     
    function AddSubMenu():Panel;
    
}



#end