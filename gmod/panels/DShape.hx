package gmod.panels;
#if client

/**
    Draw a shape on a derma panel. Only one kind of shape, a rectangle, is available for use.
**/
extern class DShape extends DPanel {
    /**
        Sets the shape to be drawn.
		
		Name | Description
		--- | ---
		`type` | The render type of the DShape. Only rectangles ( Rect) work currently. If you don't define a type immediately, the PANEL: Paint method will generate errors until you do.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DShape and sets the render type.
		
		```lua 
		local Shape = vgui.Create( "DShape" )
		Shape:SetType( "Rect" )
		Shape:SetSize(500,500)
		Shape:SetPos(10, 10)
		```
    **/
    
     
    function SetType(type:String):Void;
    /**
        Sets the border color of the shape. 
		
		Currently does nothing.
		
		Name | Description
		--- | ---
		`clr` | The desired border color. See Color structure
    **/
    
     
    function SetBorderColor(clr:Color):Void;
    /**
        Returns the current type of shape this panel is set to display. 
		
		See DShape:SetType.
		
		`**Returns:** 
    **/
    
     
    function GetType():String;
    /**
        Returns the current type of shape this panel is set to display. 
		
		See DShape:SetBorderColor.
		
		`**Returns:** The border color See Color structure
    **/
    
     
    function GetBorderColor():Color;
    /**
        Returns the color set to display the shape with.
		
		`**Returns:** The Color structure
    **/
    
     
    function GetColor():Color;
    /**
        Sets the color to display the shape with.
		
		Name | Description
		--- | ---
		`clr` | The Color structure
    **/
    
     
    function SetColor(clr:Color):Void;
    
}



#end