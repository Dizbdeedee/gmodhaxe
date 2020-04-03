package gmod.panels;
#if client

/**
    Colorful buttons. Used internally by DColorPalette.
**/
extern class DColorButton extends DLabel {
    /**
        Returns whether the DColorButton is currently being pressed (the user is holding it down).
		
		`**Returns:** 
    **/
    
     
    function IsDown():Bool;
    /**
        Used internally by DColorPalette to detect which button is which.
		
		Name | Description
		--- | ---
		`id` | A unique ID to give this button
    **/
    
     
    function SetID(id:Float):Void;
    /**
        Returns the unique ID set by DColorButton:SetID. 
		
		Used internally by DColorPalette
		
		`**Returns:** The unique ID of the button
    **/
    
     
    function GetID():Float;
    /**
        Returns the color of the button
		
		`**Returns:** The Color structure of the button
    **/
    
     
    function GetColor():Color;
    /**
        Sets the color of the DColorButton.
		
		Name | Description
		--- | ---
		`color` | A Color structure to set the color as
		`noTooltip` | If true, the tooltip will not be reset to display the selected color.
    **/
    
     
    function SetColor(color:Color, ?noTooltip:Bool):Void;
    
}



#end