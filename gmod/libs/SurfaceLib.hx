package gmod.libs;
#if client

/**
    The surface library allows you to draw text and shapes on the screen. Primarily used for making HUDs & custom GUI panels.
**/
@:native("_G.surface")extern class SurfaceLib {
    
    /**
        Returns the texture id of the material with the given name/path.
		
		**Note:** This function will not work with .png or .jpg images. For that, see Material
		
		Name | Description
		--- | ---
		`name/path` | Name or path of the texture.
		
		
		`**Returns:** The texture ID
    **/
    
    public static function GetTextureID(path:String):Float;
    
    
    /**
        Returns the current color affecting text draw operations.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		`**Returns:** The color that text drawing operations will use as a Color structure.
    **/
    
    public static function GetTextColor():Color;
    
    
    /**
        Draw the specified text on the screen, using the previously set position, font and color.
		
		**Note:** This function does not handle newlines properly
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`text` | The text to be rendered.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws 'Hello World' on the screen. All functions in this example must be called for the draw to work flawlessly.
		
		```lua 
		hook.Add( "HUDPaint", "drawsometext", function()
		    surface.SetFont( "Default" )
		    surface.SetTextColor( 255, 255, 255 )
		    surface.SetTextPos( 128, 128 ) 
		    surface.DrawText( "Hello World" )
		end )
		```
    **/
    
    public static function DrawText(text:String):Void;
    
    
    /**
        Returns the width and height (in pixels) of the given text, but only if the font has been set with surface.SetFont.
		
		Name | Description
		--- | ---
		`text` | The string to check the size of.
		
		
		Name | Description
		--- | ---
		`a` | Width of the provided text
		`b` | Height of the provided text
		
		
		___
		### Lua Examples
		#### Example 1
		Prints out the size of "Hello World" in the Trebuchet24 font.
		
		```lua 
		surface.SetFont("Trebuchet24")
		
		local message = "Hello World"
		local width, height = surface.GetTextSize(message)
		
		print("Text width: " .. width .. ", text height: " .. height)
		```
		**Output:**
		
		Text width: 100, text height: 24
		
		#### Example 2
		Get text height very quickly. No tables or spare variables used.
		
		```lua 
		local message = "Hello World"
		
		surface.SetFont("Trebuchet24")
		local height = select(2, surface.GetTextSize(message))
		
		print(height)
		```
		**Output:**
		
		24
    **/
    
    public static function GetTextSize(text:String):SurfaceLibGetTextSizeReturn;
    
    
    /**
        Enables or disables the clipping used by the VGUI that limits the drawing operations to a panels bounds. 
		
		See also DisableClipping and Panel:NoClipping.
		
		Name | Description
		--- | ---
		`disable` | True to disable, false to enable the clipping
    **/
    
    public static function DisableClipping(disable:Bool):Void;
    
    
    /**
        Returns the current alpha multiplier affecting drawing operations.
		
		`**Returns:** The multiplier ranging from 0 to 1.
    **/
    
    public static function GetAlphaMultiplier():Float;
    
    
    /**
        Sets the material to be used in all upcoming draw operations using the surface library. 
		
		Not to be confused with render.SetMaterial. 
		
		 See also surface.SetTexture.
		
		**Warning:** Material function calls are expensive to be done inside this function or inside rendering context, you should be caching the results of Material calls
		
		Name | Description
		--- | ---
		`material` | The material to be used.
    **/
    
    public static function SetMaterial(material:IMaterial):Void;
    
    
    /**
        Returns the current color affecting draw operations.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		`**Returns:** The color that drawing operations will use as a Color structure.
    **/
    
    public static function GetDrawColor():Color;
    
    
    /**
        Play a sound file directly on the client (such as UI sounds, etc).
		
		Name | Description
		--- | ---
		`soundfile` | The path to the sound file, which must be relative to the sound/ folder.
		
		
		___
		### Lua Examples
		#### Example 1
		Plays a sound with a given name. The game will look for the file in following places in that order:garrysmod/addons/myaddon/sound/mysound.wav garrysmod/gamemodes/mygamemode/content/sound/mysound.wav garrysmod/sound/mysound.wav
		
		```lua 
		surface.PlaySound( "mysound.wav" )
		```
    **/
    
    public static function PlaySound(soundfile:String):Void;
    
    
    /**
        Draws a textured rectangle with a repeated or partial texture. 
		
		u and v refer to texture coordinates.
		
		**Note:** If you are using a .png image, you need supply the "noclamp" flag as second parameter for Material if you intend to use tiling.
		
		**Note:** If you find that surface.DrawTexturedRectUV is getting your texture coordinates (u0, v0), (u1, v1) wrong and you're rendering with a material created with CreateMaterial, try adjusting them with the following code: local du = 0.5 / 32 -- half pixel anticorrection
		
		local dv = 0.5 / 32 -- half pixel anticorrection
		
		local u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv)
		
		local u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv)
		
		 Explanation: surface.DrawTexturedRectUV tries to correct the texture coordinates by half a pixel (something to do with sampling) and computes the correction using IMaterial::GetMappingWidth()/GetMappingHeight(). If the material was created without a $basetexture, then GetMappingWidth()/GetMappingHeight() uses the width and height of the error material (which is 32x32).
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		**Bug:** BUG The UV offsets might require (sub-)pixel correction for accurate tiling results. Issue Tracker: #3173
		
		Name | Description
		--- | ---
		`x` | The X integer coordinate.
		`y` | The Y integer coordinate.
		`width` | The integer width of the rectangle.
		`height` | The integer height of the rectangle.
		`startU` | The U texture mapping of the rectangle origin.
		`startV` | The V texture mapping of the rectangle origin.
		`endU` | The U texture mapping of the rectangle end.
		`endV` | The V texture mapping of the rectangle end.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the function usage.
		
		```lua 
		local mat = Material( "gui/tool.png" )
		hook.Add( "HUDPaint", "DrawTexturedRectUV_example1", function()
		    surface.SetDrawColor( color_white )
		    surface.SetMaterial( mat )
		
		    surface.DrawTexturedRect( 25, 25, 100, 100 )
		    surface.DrawTexturedRectUV( 25, 130, 100, 100, 0, 0, 1, 1 ) -- Exactly same as above line
		
		    -- Draws right half of the texture
		    -- Note that we also change the width of the rectangle to avoid stetcing of the texture
		    -- This is for demonstration purposes, you can do whatever it is you need
		    surface.DrawTexturedRectUV( 130, 130, 50, 100, 0.5, 0, 1, 1 )
		end )
		```
		
		#### Example 2
		Paints repeated texture over a panel
		
		```lua 
		function PANEL:Paint( w, h )
		    -- Size of your texture, texW - width, texH - height
		    local texW = 16
		    local texH = 16
		
		    surface.SetMaterial( Material( "icon16/box.png", "noclamp" ) )
		    surface.SetDrawColor( color_white )
		    surface.DrawTexturedRectUV( 0, 0, w, h, 0, 0, w / texW, h / texH )
		end
		```
    **/
    
    public static function DrawTexturedRectUV(x:Float, y:Float, width:Float, height:Float, startU:Float, startV:Float, endU:Float, endV:Float):Void;
    
    
    /**
        Set the color of any future shapes to be drawn, can be set by either using r, g, b, a as separate values or by a Color structure. Using a color structure is not recommended to be created procedurally.
		
		Name | Description
		--- | ---
		`r` | The red value of color, or a Color structure.
		`g` | The green value of color. Unused if a Color structure was given.
		`b` | The blue value of color. Unused if a Color structure was given.
		`a` | The alpha value of color. Unused if a Color structure was given.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a 512x512 textured rectangle with the wireframe material
		
		```lua 
		local ourMat = Material( "models/wireframe" ) -- Calling Material() every frame is quite expensive
		
		hook.Add( "HUDPaint", "example_hook", function()
		    surface.SetDrawColor( 255, 0, 0, 255 ) -- Set the color to red
		    surface.SetMaterial( ourMat ) -- If you use Material, cache it!
		    surface.DrawTexturedRect( 0, 0, 512, 512 )
		end )
		```
    **/
	
	@:overload(function(r:Color):Void {})
    public static function SetDrawColor(r:Int, g:Int, b:Int, ?a:Int):Void;
    
    
    /**
        Draws a hollow box with a border width of 1 px.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`x` | The start x integer coordinate.
		`y` | The start y integer coordinate.
		`w` | The integer width.
		`h` | The integer height.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a 100x100 outlined rectangle in top left corner.
		
		```lua 
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect( 0, 0, 100, 100 )
		```
		
		#### Example 2
		A convenience function to draw an outlined rect with given color and thickness
		
		```lua 
		function draw.OutlinedBox( x, y, w, h, thickness, clr )
		    surface.SetDrawColor( clr )
		    for i=0, thickness - 1 do
		        surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
		    end
		end
		
		// Usage
		hook.Add( "HUDPaint", "OutlinedRectExample", function()
		    draw.OutlinedBox( 0, 0, 100, 100, 2, Color( 255, 255, 255 ) )
		end )
		```
    **/
    
    public static function DrawOutlinedRect(x:Float, y:Float, w:Float, h:Float):Void;
    
    
    /**
        Set the top-left position to draw any future text at.
		
		Name | Description
		--- | ---
		`x` | The X integer co-ordinate.
		`y` | The Y integer co-ordinate.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws 'Hello World' on the screen, around top-left of the screen.
		
		```lua 
		hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
		    surface.SetDrawColor( 0, 0, 0, 128 ) -- Set color for background
		    surface.DrawRect( 100, 100, 128, 20 ) -- Draw background
		
		    surface.SetTextColor( 255, 255, 255 ) -- Set text color
		    surface.SetTextPos( 136, 104 ) -- Set text position, top left corner
		    surface.SetFont( "Default" ) -- Set the font
		    surface.DrawText( "Hello World" ) -- Draw the text
		end )
		```
    **/
    
    public static function SetTextPos(x:Float, y:Float):Void;
    
    
    /**
        ***Deprecated:** You should use ScrH instead.
		
		Returns the height of the current client's screen.
		
		`**Returns:** screenHeight
		
		___
		### Lua Examples
		#### Example 1
		Prints out the current height of the screen.
		
		```lua 
		MsgN("Screen height: " .. surface.ScreenHeight())
		```
		**Output:**
		
		Screen height: 1080
    **/
    @:deprecated("You should use ScrH instead.")
    public static function ScreenHeight():Float;
    
    
    /**
        Creates a new font. 
		
		To prevent the font from displaying incorrectly when using the "outline" setting, set "antialias" to false. This will ensure the text properly fills out the entire outline. 
		
		 Be sure to check the List of Default Fonts first! Those fonts can be used without using this function.
		
		**Warning:** Due to the static nature of fonts, do NOT create the font more than once. You should only be creating them once, it is recommended to create them at the top of your script. Do not use this function within GM:HUDPaint!
		
		Name | Description
		--- | ---
		`fontName` | The new font name.
		`fontData` | The font properties. See the FontData structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a font with all the defaults showing (any of the fields could be left out for an equivalent font)
		
		```lua 
		surface.CreateFont( "TheDefaultSettings", {
		    font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		    extended = false,
		    size = 13,
		    weight = 500,
		    blursize = 0,
		    scanlines = 0,
		    antialias = true,
		    underline = false,
		    italic = false,
		    strikeout = false,
		    symbol = false,
		    rotary = false,
		    shadow = false,
		    additive = false,
		    outline = false,
		})
		
		hook.Add( "HUDPaint", "HelloThere", function()
		    draw.SimpleText( "Hello there!", "TheDefaultSettings", ScrW() * 0.5, ScrH() * 0.25, color_white, TEXT_ALIGN_CENTER )
		end )
		```
    **/
    
    public static function CreateFont(fontName:String, fontData:FontData):Void;
    
    
    /**
        Set the color of any future text to be drawn, can be set by either using r, g, b, a as separate values or by a Color structure. Using a color structure is not recommended to be created procedurally.
		
		Name | Description
		--- | ---
		`r` | The red value of color, or a Color structure.
		`g` | The green value of color
		`b` | The blue value of color
		`a` | The alpha value of color
		
		
		___
		### Lua Examples
		#### Example 1
		Draws 'Hello World', in white, near the top left of the screen.
		
		```lua 
		hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
		    surface.SetDrawColor( 0, 0, 0, 128 ) -- Set color for background
		    surface.DrawRect( 100, 100, 128, 20 ) -- Draw background
		
		    surface.SetTextColor( 255, 255, 255 ) -- Set text color
		    surface.SetTextPos( 136, 104 ) -- Set text position, top left corner
		    surface.SetFont( "Default" ) -- Set the font
		    surface.DrawText( "Hello World" ) -- Draw the text
		end )
		```
    **/
    @:overload(function(col:Color):Void {})
    public static function SetTextColor(r:Float, g:Float, b:Float, ?a:Float):Void;
    
    
    /**
        Draw a textured rotated rectangle with the given position and dimensions and angle on the screen, using the current active texture.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`x` | The X integer co-ordinate, representing the center of the rectangle.
		`y` | The Y integer co-ordinate, representing the center of the rectangle.
		`width` | The integer width of the rectangle.
		`height` | The integer height of the rectangle.
		`rotation` | The rotation of the rectangle, in degrees.
		
		
		___
		### Lua Examples
		#### Example 1
		A function that allows you to override the origin of rotation.x0 and y0 are relative to the center of the rectangle.
		
		```lua 
		function surface.DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )
		    
		    local c = math.cos( math.rad( rot ) )
		    local s = math.sin( math.rad( rot ) )
		    
		    local newx = y0 * s - x0 * c
		    local newy = y0 * c + x0 * s
		    
		    surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )
		    
		end
		```
		
		#### Example 2
		Draws a simple red forever rotating box.
		
		```lua 
		function draw.RotatedBox( x, y, w, h, ang, color )
		    draw.NoTexture()
		    surface.SetDrawColor( color or color_white )
		    surface.DrawTexturedRectRotated( x, y, w, h, ang )
		end
		
		hook.Add( "HUDPaint", "my_rotated_box", function()
		    draw.RotatedBox( 100, 100, 100, 100, CurTime() % 360, Color( 255, 0, 0) )
		end )
		```
    **/
    
    public static function DrawTexturedRectRotated(x:Float, y:Float, width:Float, height:Float, rotation:Float):Void;
    
    
    /**
        Draws a textured polygon (secretly a triangle fan) with a maximum of 256 vertices. Only works properly with convex polygons. You may try to render concave polygons, but there is no guarantee that things wont get messed up. 
		
		Unlike most surface library functions, non-integer coordinates are not rounded.
		
		**Warning:** You must reset the drawing color and texture before calling the function to ensure consistent results. See examples below.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`vertices` | A table containing integer vertices. See the PolygonVertex structure. The vertices must be in clockwise order.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a red triangle in the top left corner of the screen.
		
		```lua 
		local triangle = {
		    { x = 100, y = 200 },
		    { x = 150, y = 100 },
		    { x = 200, y = 200 }
		}
		
		hook.Add("HUDPaint", "PolygonTest", function()
		    
		    surface.SetDrawColor( 255, 0, 0, 255 )
		    draw.NoTexture()
		    surface.DrawPoly( triangle )
		
		end )
		```
		
		#### Example 2
		A helper function to draw a circle using surface.DrawPoly.
		
		```lua 
		function draw.Circle( x, y, radius, seg )
		    local cir = {}
		
		    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
		    for i = 0, seg do
		        local a = math.rad( ( i / seg ) * -360 )
		        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
		    end
		
		    local a = math.rad( 0 ) -- This is needed for non absolute segment counts
		    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
		
		    surface.DrawPoly( cir )
		end
		
		hook.Add("HUDPaint", "PolygonCircleTest", function()
		    
		    surface.SetDrawColor( 0, 0, 0, 200)
		    draw.NoTexture()
		    draw.Circle( ScrW() / 2, ScrH() / 2, 200, math.sin( CurTime() ) * 20 + 25 )
		
		    --Usage:
		    --draw.Circle( x, y, radius, segments )
		
		end )
		```
    **/
    
    public static function DrawPoly(vertices:PolygonVertex):Void;
    
    
    /**
        Gets the HUD texture with the specified name.
		
		Name | Description
		--- | ---
		`name` | The name of the texture.
		
		
		`**Returns:** text
    **/
    
    public static function GetHUDTexture(name:String):ITexture;
    
    
    /**
        Draws a hollow circle, made of dots. For a filled circle, see examples for surface.DrawPoly.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`originX` | The center x integer coordinate.
		`originY` | The center y integer coordinate.
		`radius` | The radius of the circle.
		`r` | The red value of the color to draw the circle with, or a Color structure.
		`g` | The green value of the color to draw the circle with. Unused if a Color structure was given.
		`b` | The blue value of the color to draw the circle with. Unused if a Color structure was given.
		`a` | The alpha value of the color to draw the circle with. Unused if a Color structure was given.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage. Draws an orange circle at position 500, 500 with a varying/animated radius of 50 to 150.
		
		```lua 
		hook.Add( "HUDPaint", "DrawCircleExample", function()
		
		    surface.DrawCircle( 500, 500, 100 + math.sin( CurTime() ) * 50, Color( 255, 120, 0 ) )
		
		end )
		```
    **/
    
    public static function DrawCircle(originX:Float, originY:Float, radius:Float, r:Color, g:Color, b:Color, ?a:Color):Void;
    
    
    /**
        Set the current font to be used for text operations later. 
		
		The fonts must first be created with surface.CreateFont or be one of the Default Fonts.
		
		Name | Description
		--- | ---
		`fontName` | The name of the font to use.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws 'Hello World' on the screen, with the 'Default' font.
		
		```lua 
		hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
		    surface.SetDrawColor( 0, 0, 0, 128 ) -- Set color for background
		    surface.DrawRect( 100, 100, 128, 20 ) -- Draw background
		
		    surface.SetTextColor( 255, 255, 255 ) -- Set text color
		    surface.SetTextPos( 136, 104 ) -- Set text position, top left corner
		    surface.SetFont( "Default" ) -- Set the font
		    surface.DrawText( "Hello World" ) -- Draw the text
		end )
		```
    **/
    
    public static function SetFont(fontName:String):Void;
    
    
    /**
        Draws a line from one point to another.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`startX` | The start x integer coordinate.
		`startY` | The start y integer coordinate.
		`endX` | The end x integer coordinate.
		`endY` | The end y integer coordinate.
		
		
		___
		### Lua Examples
		#### Example 1
		This example will draw a pixel perfect circle in the middle of your screen.
		
		```lua 
		hook.Add( "HUDPaint", "Circle", function()
		    local center = Vector( ScrW() / 2, ScrH() / 2, 0 )
		    local scale = Vector( 100, 100, 0 )
		    local segmentdist = 360 / ( 2 * math.pi * math.max( scale.x, scale.y ) / 2 )
		    surface.SetDrawColor( 255, 0, 0, 255 )
		 
		    for a = 0, 360 - segmentdist, segmentdist do
		        surface.DrawLine( center.x + math.cos( math.rad( a ) ) * scale.x, center.y - math.sin( math.rad( a ) ) * scale.y, center.x + math.cos( math.rad( a + segmentdist ) ) * scale.x, center.y - math.sin( math.rad( a + segmentdist ) ) * scale.y )
		    end
		end )
		```
    **/
    
    public static function DrawLine(startX:Float, startY:Float, endX:Float, endY:Float):Void;
    
    
    /**
        Draws a solid rectangle on the screen.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`x` | The X integer co-ordinate.
		`y` | The Y integer co-ordinate.
		`width` | The integer width of the rectangle.
		`height` | The integer height of the rectangle.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a white 100 by 100 rectangle, 25 pixels from the top left of the screen.
		
		```lua 
		hook.Add("HUDPaint", "MyRect", function()
		    surface.SetDrawColor(255,255,255,255)
		    surface.DrawRect(25, 25, 100, 100)
		end)
		```
    **/
    
    public static function DrawRect(x:Float, y:Float, width:Float, height:Float):Void;
    
    
    /**
        Sets the texture to be used in all upcoming draw operations using the surface library. 
		
		See also surface.SetMaterial for an IMaterial alternative.
		
		Name | Description
		--- | ---
		`textureID` | The ID of the texture to draw with returned by surface. GetTextureID.
    **/
    
    public static function SetTexture(textureID:Float):Void;
    
    
    /**
        Sets the alpha multiplier that will influence all upcoming drawing operations.
		
		Name | Description
		--- | ---
		`multiplier` | The multiplier ranging from 0 to 1.
    **/
    
    public static function SetAlphaMultiplier(multiplier:Float):Void;
    
    
    /**
        Draw a textured rectangle with the given position and dimensions on the screen, using the current active texture set with surface.SetMaterial. It is also affected by surface.SetDrawColor. 
		
		See also render.SetMaterial and render.DrawScreenQuadEx. See also surface.DrawTexturedRectUV.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`x` | The X integer co-ordinate.
		`y` | The Y integer co-ordinate.
		`width` | The integer width of the rectangle.
		`height` | The integer height of the rectangle.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a 512x512 textured rectangle with the wireframe texture.
		
		```lua 
		local ourMat = Material( "models/wireframe" ) -- Calling Material() every frame is quite expensive
		
		hook.Add( "HUDPaint", "example_hook", function()
		    surface.SetDrawColor( 255, 255, 255, 255 )
		    surface.SetMaterial( ourMat  ) -- If you use Material, cache it!
		    surface.DrawTexturedRect( 0, 0, 512, 512 )
		end )
		```
    **/
    
    public static function DrawTexturedRect(x:Float, y:Float, width:Float, height:Float):Void;
    
    
    /**
        Returns the size of the texture with the associated texture ID.
		
		Name | Description
		--- | ---
		`textureID` | The texture ID, returned by surface. GetTextureID.
		
		
		Name | Description
		--- | ---
		`a` | The texture width.
		`b` | The texture height.
    **/
    
    public static function GetTextureSize(textureID:Float):SurfaceLibGetTextureSizeReturn;
    
    
    /**
        ***Deprecated:** You should use ScrW instead.
		
		Returns the width of the current client's screen.
		
		`**Returns:** screenWidth
		
		___
		### Lua Examples
		#### Example 1
		Prints out the current width of the screen.
		
		```lua 
		MsgN("Screen width: " .. surface.ScreenWidth())
		```
		**Output:**
		
		Screen width: 1920
    **/
    @:deprecated("You should use ScrW instead.")
    public static function ScreenWidth():Float;
    
    

}


@:multiReturn extern class SurfaceLibGetTextureSizeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class SurfaceLibGetTextSizeReturn {
var a:Float;
var b:Float;

}

#end