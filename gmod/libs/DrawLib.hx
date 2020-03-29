package gmod.libs;
#if client

/**
    The draw library's purpose is to simplify the usage of the surface library.
**/
@:native("_G.draw")extern class DrawLib {
    
    /**
        Creates a simple line of text that is outlined.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`Text` | The text to draw.
		`font` | The font name to draw with. See surface. CreateFont to create your own, or here for a list of default fonts.
		`x` | The X Coordinate.
		`y` | The Y Coordinate.
		`color` | The color of the text. Uses the Color structure.
		`xAlign` | The alignment of the X Coordinate using TEXT_ALIGN_ Enums.
		`yAlign` | The alignment of the Y Coordinate using TEXT_ALIGN_ Enums.
		`outlinewidth` | Width of the outline.
		`outlinecolor` | Color of the outline. Uses the Color structure.
		
		
		Name | Description
		--- | ---
		`a` | The width of the text. Same value as if you were calling surface. GetTextSize.
		`b` | The height of the text. Same value as if you were calling surface. GetTextSize.
    **/
    
    public static function SimpleTextOutlined(Text:String, ?font:String, ?x:Float, ?y:Float, ?color:Color, ?xAlign:TEXT_ALIGN, ?yAlign:TEXT_ALIGN, outlinewidth:Float, ?outlinecolor:Color):DrawLibSimpleTextOutlinedReturn;
    
    
    /**
        Simple draw text at position, but this will expand newlines and tabs.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`text` | Text to be drawn.
		`font` | Name of font to draw the text in. See surface. CreateFont to create your own, or Default Fonts for a list of default fonts.
		`x` | The X Coordinate.
		`y` | The Y Coordinate.
		`color` | Color to draw the text in. Uses the Color structure.
		`xAlign` | Where to align the text horizontally. Uses the TEXT_ALIGN_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes a message saying "Hello there!" pop up in the center of your screen.
		
		```lua 
		hook.Add("HUDPaint", "HelloThere", function() 
		    draw.DrawText("Hello there!", "TargetID", ScrW() * 0.5, ScrH() * 0.25, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		end)
		```
		**Output:**
		
		Hello there!
    **/
    
    public static function DrawText(text:String, ?font:String, ?x:Float, ?y:Float, ?color:Color, ?xAlign:TEXT_ALIGN):Void;
    
    
    /**
        Draws text on the screen.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`text` | The text to be drawn.
		`font` | The font. See surface. CreateFont to create your own, or see Default Fonts for a list of default fonts.
		`x` | The X Coordinate.
		`y` | The Y Coordinate.
		`color` | The color of the text. Uses the Color structure.
		`xAlign` | The alignment of the X coordinate using TEXT_ALIGN_ Enums.
		`yAlign` | The alignment of the Y coordinate using TEXT_ALIGN_ Enums.
		
		
		Name | Description
		--- | ---
		`a` | The width of the text. Same value as if you were calling surface. GetTextSize.
		`b` | The height of the text. Same value as if you were calling surface. GetTextSize.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		hook.Add( "HUDPaint", "HelloThere", function()
		    draw.SimpleText( "Hello there!", "DermaDefault", 50, 50, color_white )
		end )
		```
    **/
    
    public static function SimpleText(text:String, ?font:String, ?x:Float, ?y:Float, ?color:Color, ?xAlign:TEXT_ALIGN, ?yAlign:TEXT_ALIGN):DrawLibSimpleTextReturn;
    
    
    /**
        Returns the height of the specified font in pixels.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`font` | Name of the font to get the height of.
		
		
		`**Returns:** The font height
    **/
    
    public static function GetFontHeight(font:String):Float;
    
    
    /**
        Draws a rounded box with text in it.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`bordersize` | Size of border, should be multiple of 2. Ideally this will be 8 or 16.
		`x` | The X Coordinate.
		`y` | The Y Coordinate.
		`text` | Text to draw.
		`font` | Font to draw in. See surface. CreateFont to create your own, or here for a list of default fonts.
		`boxcolor` | The box color. Uses the Color structure.
		`textcolor` | The text color. Uses the Color structure.
		
		
		Name | Description
		--- | ---
		`a` | The width of the word box.
		`b` | The height of the word box.
    **/
    
    public static function WordBox(bordersize:Float, x:Float, y:Float, text:String, font:String, boxcolor:Color, textcolor:Color):DrawLibWordBoxReturn;
    
    
    /**
        Sets drawing texture to a default white texture (vgui/white) via surface.SetMaterial. Useful for resetting the drawing texture.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
    **/
    
    public static function NoTexture():Void;
    
    
    /**
        Draws a rounded rectangle.
		
		**Note:** If you intend to draw a non-rounded rectangle, then it's more efficient to use surface.DrawRect.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`cornerRadius` | Radius of the rounded corners, works best with a multiple of 2.
		`x` | The x coordinate of the top left of the rectangle.
		`y` | The y coordinate of the top left of the rectangle.
		`width` | The width of the rectangle.
		`height` | The height of the rectangle.
		`color` | The color to fill the rectangle with. Uses the Color structure.
    **/
    
    public static function RoundedBox(cornerRadius:Float, x:Float, y:Float, width:Float, height:Float, color:Color):Void;
    
    
    /**
        Draws a rounded rectangle. This function also lets you specify which corners are drawn rounded.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`cornerRadius` | Radius of the rounded corners, works best with a power of 2 number.
		`x` | The x coordinate of the top left of the rectangle.
		`y` | The y coordinate of the top left of the rectangle.
		`width` | The width of the rectangle.
		`height` | The height of the rectangle.
		`color` | The color to fill the rectangle with. Uses the Color structure.
		`roundTopLeft` | Whether the top left corner should be rounded.
		`roundTopRight` | Whether the top right corner should be rounded.
		`roundBottomLeft` | Whether the bottom left corner should be rounded.
		`roundBottomRight` | Whether the bottom right corner should be rounded.
    **/
    
    public static function RoundedBoxEx(cornerRadius:Float, x:Float, y:Float, width:Float, height:Float, color:Color, ?roundTopLeft:Bool, ?roundTopRight:Bool, ?roundBottomLeft:Bool, ?roundBottomRight:Bool):Void;
    
    
    /**
        Works like draw.Text, but draws the text as a shadow.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`textdata` | The text properties. See TextData structure
		`distance` | How far away the shadow appears.
		`alpha` | How visible the shadow is (0-255).
    **/
    
    public static function TextShadow(textdata:TextData, distance:Float, ?alpha:Float):Void;
    
    
    /**
        Works like draw.SimpleText but uses a table structure instead.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`textdata` | The text properties. See the TextData structure
		
		
		Name | Description
		--- | ---
		`a` | Width of drawn text
		`b` | Height of drawn text
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		hook.Add( "HUDPaint", "drawTextExample", function()
		    draw.Text( {
		        text = "test",
		        pos = { 50, 50 }
		    } )
		end )
		```
    **/
    
    public static function Text(textdata:TextData):DrawLibTextReturn;
    
    
    /**
        Draws a texture with a table structure.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`texturedata` | The texture properties. See TextureData structure
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		local TexturedQuadStructure = {
		    texture = surface.GetTextureID( 'phoenix_storms/amraam' ),
		    color   = Color( 255, 0, 255, 255 ),
		    x     = 0,
		    y     = 0,
		    w     = 512,
		    h     = 512
		}
		draw.TexturedQuad( TexturedQuadStructure )
		```
		**Output:**
		
		Renders the texture.
    **/
    
    public static function TexturedQuad(texturedata:TextureData):Void;
    
    

}


@:multiReturn extern class DrawLibWordBoxReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class DrawLibTextReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class DrawLibSimpleTextOutlinedReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class DrawLibSimpleTextReturn {
var a:Float;
var b:Float;

}

#end