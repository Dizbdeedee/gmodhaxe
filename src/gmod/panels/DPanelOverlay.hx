package gmod.panels;
#if client

/**
    Adds curved corners.
**/
extern class DPanelOverlay extends DPanel {
    /**
        Sets the type of the DPanelOverlay.
		
		Name | Description
		--- | ---
		`type` | The type to set. Possible value are: 1 - 8px corners of given color 2 - 4px corners of given type 3 - 2 top? corners of hardcoded color, 2 other corners of given color
    **/
    
     
    function SetType(type:Float):Void;
    /**
        Returns the type of the DPanelOverlay set by DPanelOverlay:SetType.
		
		`**Returns:** The set type.
    **/
    
     
    function GetType():Float;
    /**
        ***INTERNAL** 
		
		Used internally by the panel for types 1 and 2.
		
		Name | Description
		--- | ---
		`size` | 
    **/
    @:deprecated("INTERNAL")
     
    function PaintInnerCorners(size:Float):Void;
    /**
        Returns the border color of the DPanelOverlay set by DPanelOverlay:SetColor.
		
		`**Returns:** The set color. Uses the Color structure.
    **/
    
     
    function GetColor():Color;
    /**
        ***INTERNAL** 
		
		Used internally by the panel for type 3.
		
		Name | Description
		--- | ---
		`cola` | 
		`colb` | 
		`colc` | 
		`cold` | 
		`size` | 
    **/
    @:deprecated("INTERNAL")
     
    function PaintDifferentColours(cola:AnyTable, colb:AnyTable, colc:AnyTable, cold:AnyTable, size:Float):Void;
    /**
        Sets the border color of the DPanelOverlay.
		
		Name | Description
		--- | ---
		`color` | The color to set. Uses the Color structure.
    **/
    
     
    function SetColor(color:Color):Void;
    
}



#end