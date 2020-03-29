package gmod.structs;
/**
    Used for [draw](https://wiki.garrysmod.com/page/Category:draw). [Text](https://wiki.garrysmod.com/page/draw/Text).
**/
typedef TextData = {
    /**
        Text to be drawn.
    **/
    var text : String;
    /**
        The alignment of the Y position. See TEXT_ALIGN_ Enums 
		
		Default: TEXT_ALIGN_TOP
    **/
    var ?yalign : TEXT_ALIGN;
    /**
        The text color 
		
		Default: color_white
    **/
    var ?color : AnyTable;
    /**
        This holds the X and Y coordinates. Key value 1 is x, key value 2 is y.
    **/
    var pos : AnyTable;
    /**
        The font to draw with. List of default fonts can be found here. 
		
		Default: "DermaDefault"
    **/
    var ?font : String;
    /**
        The alignment of the X position. See TEXT_ALIGN_ Enums 
		
		Default: TEXT_ALIGN_LEFT
    **/
    var ?xalign : TEXT_ALIGN;
    
}
