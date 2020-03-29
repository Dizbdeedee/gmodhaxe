package gmod.panels;
#if client

/**
    A bar to select the opacity (alpha level) of a color.
**/
extern class DAlphaBar extends DPanel {
    /**
        Returns the base color of the alpha bar. This is the color for which the alpha channel is being modified.
		
		`**Returns:** The current base color.
    **/
    
     
    function GetBarColor():AnyTable;
    /**
        Sets the alpha value or the alpha bar.
		
		Name | Description
		--- | ---
		`alpha` | The new alpha value to set
    **/
    
     
    function SetValue(alpha:Float):Void;
    /**
        Sets the base color of the alpha bar. This is the color for which the alpha channel is being modified.
		
		Name | Description
		--- | ---
		`clr` | The new Color structure to set. See Color.
    **/
    
     
    function SetBarColor(clr:Color):Void;
    /**
        Called when user changes the desired alpha value with the control.
		
		Name | Description
		--- | ---
		`alpha` | The new alpha value
    **/
    
    @:hook 
    function OnChange(alpha:Float):Void;
    /**
        Returns the alpha value of the alpha bar.
		
		`**Returns:** The current alpha value.
    **/
    
     
    function GetValue():Float;
    
}



#end