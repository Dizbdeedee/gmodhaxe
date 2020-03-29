package gmod.gclass;
#if client

/**
    Object containing parsed markup for later rendering. Created by markup.Parse.
**/
extern class MarkupObject {
    
    /**
        Draws the computed markupobject to the screen.
		
		Name | Description
		--- | ---
		`xOffset` | The X coordinate on the screen.
		`yOffset` | The Y coordinate on the screen.
		`xAlign` | The alignment of the x coordinate using TEXT_ALIGN_ Enums
		`yAlign` | The alignment of the y coordinate using TEXT_ALIGN_ Enums
		`alphaoverride` | Sets the alpha of all drawn objects to this.
    **/
    
    public function Draw(xOffset:Float, yOffset:Float, xAlign:TEXT_ALIGN, yAlign:TEXT_ALIGN, ?alphaoverride:Float):Void;
    
    
    /**
        Gets computed the width of the markupobject.
		
		`**Returns:** The computed width.
    **/
    
    public function GetWidth():Float;
    
    
    /**
        Gets computed the height of the markupobject.
		
		`**Returns:** The computed height.
    **/
    
    public function GetHeight():Float;
    
    
    /**
        Gets computed the width and height of the markupobject.
		
		Name | Description
		--- | ---
		`a` | The computed width.
		`b` | The computed height.
    **/
    
    public function Size():MarkupObjectSizeReturn;
    
    
}


@:multiReturn extern class MarkupObjectSizeReturn {
var a:Float;
var b:Float;

}

#end