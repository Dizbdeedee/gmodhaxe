package gmod.structs;
/**
    Used for [draw](https://wiki.garrysmod.com/page/Category:draw). [TexturedQuad](https://wiki.garrysmod.com/page/draw/TexturedQuad).
**/
typedef TextureData = {
    /**
        The texture color. See Color structure. 
		
		Default: color_white
    **/
    var ?color : Color;
    /**
        surface.GetTextureID number of the texture to be drawn.
    **/
    var texture : Float;
    /**
        The height of the texture.
    **/
    var h : Float;
    /**
        The x Coordinate.
    **/
    var x : Float;
    /**
        The y Coordinate.
    **/
    var y : Float;
    /**
        The width of the texture.
    **/
    var w : Float;
    
}
