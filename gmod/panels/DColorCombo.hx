package gmod.panels;
#if client

/**
    The DColorCombo allows the user to choose color, without alpha, using DColorMixer or DColorPalette in a tabbed view.
**/
extern class DColorCombo extends DPropertySheet {
    /**
        ***INTERNAL** 
		
		Called internally to create panels necessary for this panel to work.
    **/
    @:deprecated("INTERNAL")
     
    function BuildControls():Void;
    /**
        Called when the value (color) of this panel was changed.
		
		Name | Description
		--- | ---
		`newcol` | 
    **/
    
    @:hook 
    function OnValueChanged(newcol:AnyTable):Void;
    /**
        Returns true if the panel is currently being edited 
		
		More of a internal method, it technically should only ever work (i.e. return true) inside DColorCombo:OnValueChanged.
		
		`**Returns:** 
    **/
    
     
    function IsEditing():Bool;
    /**
        Returns the color of the DColorCombo.
		
		`**Returns:** A Color structure
    **/
    
     
    function GetColor():Color;
    /**
        Sets the color of this panel.
		
		Name | Description
		--- | ---
		`clr` | A Color structure.
    **/
    
     
    function SetColor(clr:Color):Void;
    
}



#end