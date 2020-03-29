package gmod.libs;
#if client

/**
    GWEN is a system that allows you to load a spritesheet and generate a skin out of it.
**/
@:native("_G.GWEN")extern class GWENLib {
    
    /**
        Used in derma skins to create a rectangle drawing function from an image. The rectangle will not be scaled, but instead it will be drawn in the center of the box. The texture is taken from SKIN.GwenTexture
		
		Name | Description
		--- | ---
		`x` | The X coordinate on the texture
		`y` | The Y coordinate on the texture
		`w` | Width of the area on texture
		`h` | Height of the area on texture
		
		
		`**Returns:** The drawing function. Arguments are: number x - X coordinate for the box number y - Y coordinate for the box number w - Width of the box number h - Height of the box table clr - Optional color, default is white. Uses the Color structure
		
		___
		### Lua Examples
		#### Example 1
		Draws a box in the top left corner of the screen using current skins texture.
		
		```lua 
		local paintBox = GWEN.CreateTextureCentered( 384, 32, 32, 32 )
		hook.Add( "HUDPaint", "PaintStuff", function()
		    paintBox( 0, 0, 100, 100 )
		end )
		```
		**Output:**
		
		If using default skin, it will be 32x32 transparent blue box centered inside the 100x100 box.
    **/
    
    public static function CreateTextureCentered(x:Float, y:Float, w:Float, h:Float):(x:Float,y:Float,w:Float,h:Float,?clr:Color) -> Void;
    
    
    /**
        Used in derma skins to create a rectangle drawing function from an image. The texture of the rectangle will be scaled. The texture is taken from SKIN.GwenTexture
		
		Name | Description
		--- | ---
		`x` | The X coordinate on the texture
		`y` | The Y coordinate on the texture
		`w` | Width of the area on texture
		`h` | Height of the area on texture
		
		
		`**Returns:** The drawing function. Arguments are: number x - X coordinate for the box number y - Y coordinate for the box number w - Width of the box number h - Height of the box table clr - Optional color, default is white. Uses the Color structure
		
		___
		### Lua Examples
		#### Example 1
		Draws a huge checked checkbox in the top left corner of the screen using current skins texture.
		
		```lua 
		local paintBox = GWEN.CreateTextureNormal( 448, 32, 15, 15 )
		hook.Add( "HUDPaint", "PaintStuff", function()
		    paintBox( 0, 0, 100, 100 )
		end )
		```
		**Output:**
		
		If using default skin, it will be a 100x100px checked checkbox in top left corner of the screen.
    **/
    
    public static function CreateTextureNormal(x:Float, y:Float, w:Float, h:Float):(x:Float,y:Float,w:Float,h:Float,?clr:Color) -> Void;
    
    
    /**
        When used in a material skin, it returns a color value from a point in the skin image.
		
		Name | Description
		--- | ---
		`x` | X position of the pixel to get the color from.
		`y` | Y position of the pixel to get the color from.
		
		
		`**Returns:** The color of the point on the skin as a Color structure.
    **/
    
    public static function TextureColor(x:Float, y:Float):Color;
    
    
    /**
        Used in derma skins to create a bordered rectangle drawing function from an image. The texture is taken either from last argument or from SKIN.GwenTexture
		
		Name | Description
		--- | ---
		`x` | The X coordinate on the texture
		`y` | The Y coordinate on the texture
		`w` | Width of the area on texture
		`h` | Height of the area on texture
		`left` | Left width of border
		`top` | Top width of border
		`right` | Right width of border
		`bottom` | Bottom width of border
		`source` | Texture of source image to create a bordered rectangle from. Uses SKIN.GwenTexture if not set.
		
		
		`**Returns:** The drawing function. Arguments are: number x - X coordinate for the box number y - Y coordinate for the box number w - Width of the box number h - Height of the box table clr - Optional color, default is white. Uses the Color structure
		
		___
		### Lua Examples
		#### Example 1
		Draws a bordered box in the top left corner of the screen using current skins texture.
		
		```lua 
		local paintBox = GWEN.CreateTextureBorder( 384, 32, 31, 31, 4, 4, 4, 4 )
		hook.Add( "HUDPaint", "PaintStuff", function()
		    paintBox( 0, 0, 100, 100 )
		end )
		```
		**Output:**
		
		If using default skin, it will be a 100x100px transparent blue box in top left corner with solid blue borders.
    **/
    
    public static function CreateTextureBorder(x:Float, y:Float, w:Float, h:Float, left:Float, top:Float, right:Float, bottom:Float, ?source:IMaterial):(x:Float,y:Float,w:Float,h:Float,?clr:Color) -> Void;
    
    

}



#end