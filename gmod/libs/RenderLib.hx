package gmod.libs;
#if client

/**
    The render library is a powerful set of functions that let you control how the world and its contents are rendered. It can also be used to draw some 3D clientside effects such as beams, boxes and spheres.
**/
@:native("_G.render")extern class RenderLib {
    
    /**
        Sets lighting mode when rendering something.
		
		**Note:** Do not forget to restore the default value to avoid unexpected behavior, like the world and the HUD/UI being affected
		
		Name | Description
		--- | ---
		`Mode` | Lighting render mode Possible values are: 0 - Default 1 - Total fullbright, similar to mat_fullbright 1 but excluding some weapon view models 2 - Increased brightness(?), models look fullbright
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a fullbright quad on 2D skybox
		
		```lua 
		local MATERIAL = Material("skybox/trainup")
		
		hook.Add("PostDraw2DSkyBox", "Quaddrawer", function()
		    render.OverrideDepthEnable( true, false )
		    render.SetLightingMode(2)
		
		    cam.Start3D(Vector(0, 0, 0), EyeAngles())
		        render.SetMaterial(MATERIAL)
		        render.DrawQuadEasy(Vector(200,0,0), Vector(-1,0,0), 64, 64, Color(255,255,255), 180)
		    cam.End3D()
		
		    render.OverrideDepthEnable( false, false )
		    render.SetLightingMode(0)
		end)
		```
		
		#### Example 2
		Display everything the same way as when you set mat_fullbright to 1.
		
		```lua 
		local LightingModeChanged = false
		hook.Add( "PreRender", "fullbright", function()
		    render.SetLightingMode( 1 )
		    LightingModeChanged = true
		end )
		
		local function EndOfLightingMod()
		    if LightingModeChanged then
		        render.SetLightingMode( 0 )
		        LightingModeChanged = false
		    end
		end
		hook.Add( "PostRender", "fullbright", EndOfLightingMod )
		hook.Add( "PreDrawHUD", "fullbright", EndOfLightingMod )
		```
    **/
    
    public static function SetLightingMode(Mode:Float):Void;
    
    
    /**
        Start a new beam draw operation.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`segmentCount` | Amount of beam segments that are about to be drawn.
    **/
    
    public static function StartBeam(segmentCount:Float):Void;
    
    
    /**
        Swaps the frame buffers/cycles the frame. In other words, this updates the screen. 
		
		If you take a really long time during a single frame render, it is a good idea to use this and let the user know that the game isn't stuck.
		
		___
		### Lua Examples
		#### Example 1
		Code from Super DOF; Push the current progress of rendering onto the screen and display a percentage of completion near the bottom right.
		
		```lua 
		-- Restore RT
		render.SetRenderTarget( OldRT )
		
		-- Render our result buffer to the screen
		matFSB:SetFloat( "$alpha", 1 )
		matFSB:SetTexture( "$basetexture", texFSB )
		
		render.SetMaterial( matFSB )
		render.DrawScreenQuad()
		
		cam.Start2D()
		    local add = ( i / ( math.pi*2 ) ) * ( 1 / passes )
		    local percent = string.format( "%.1f", ( mul - ( 1 / passes ) + add ) * 100 )
		    draw.DrawText( percent .. "%", "GModWorldtip", view.w - 100, view.h - 100, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
		    draw.DrawText( percent .. "%", "GModWorldtip", view.w - 101, view.h - 101, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		cam.End2D()
		
		render.Spin()
		```
    **/
    
    public static function Spin():Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetBloomTex1():ITexture;
    
    
    /**
        Sets the render material override for all next calls of Entity:DrawModel. Also overrides render.MaterialOverrideByIndex.
		
		Name | Description
		--- | ---
		`material` | The material to use as override, use nil to disable.
    **/
    
    public static function MaterialOverride(material:IMaterial):Void;
    
    
    /**
        Reads the color of the specified pixel from the RenderTarget sent by render.CapturePixels
		
		Name | Description
		--- | ---
		`x` | The x coordinate.
		`y` | The y coordinate.
		
		
		Name | Description
		--- | ---
		`a` | r
		`b` | g
		`c` | b
    **/
    
    public static function ReadPixel(x:Float, y:Float):RenderLibReadPixelReturn;
    
    
    /**
        Sets the maximum shadow projection range.
		
		Name | Description
		--- | ---
		`shadowDistance` | The new maximum shadow distance.
    **/
    
    public static function SetShadowDistance(shadowDistance:Float):Void;
    
    
    /**
        Sets the operation to be performed on the stencil buffer values if the stencil test is passed but the depth buffer test fails.
		
		Name | Description
		--- | ---
		`zFailOperation` | Z fail operation function, see STENCILOPERATION_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		This shows how to reveal hidden sections of entities, wallhack style
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    render.SetStencilFailOperation( STENCIL_KEEP )
		    -- render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Always draw everything
		    render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    -- If something would draw to the screen but is behind something, set the pixels it draws to 1
		    render.SetStencilZFailOperation( STENCIL_REPLACE )
		
		    -- Draw our entities. They will draw as normal
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- Now, only draw things that have their pixels set to 1. This is the hidden parts of the stencil tests.
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    -- Flush the screen. This will draw teal over all hidden sections of the stencil tests
		    render.ClearBuffersObeyStencil(0, 148, 133, 255, false);
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function SetStencilZFailOperation(zFailOperation:STENCILOPERATION):Void;
    
    
    /**
        Returns the maximum available directX version.
		
		`**Returns:** dxLevel
    **/
    
    public static function GetDXLevel():Float;
    
    
    /**
        Returns a floating point texture the same resolution as the screen.
		
		**Note:** The gmodscreenspace shader doesn't behave as expected when drawing a floating-point texture to an integer texture (e.g. the default render target). Use an UnlitGeneric material instead
		
		`**Returns:** Render target named "__rt_supertexture2"
    **/
    
    public static function GetSuperFPTex2():ITexture;
    
    
    /**
        Gets the light exposure on the specified position.
		
		Name | Description
		--- | ---
		`position` | The position of the surface to get the light from.
		
		
		`**Returns:** lightColor
    **/
    
    public static function GetLightColor(position:Vector):Vector;
    
    
    /**
        Sets the texture to be used as the lightmap in upcoming rendering operations. This is required when rendering meshes using a material with a lightmapped shader such as LightmappedGeneric.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`tex` | The texture to be used as the lightmap.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a mesh with LightmappedGeneric material on it
		
		```lua 
		-- LightmappedGeneric material that we'll use for our mesh
		local meshMat = Material( "concrete/concretefloor001a" )
		
		-- Mesh vertices (notice that it's not MeshVertex structure format, just something similar)
		-- Notice that we have 2 UV coordinates channels, one for texture, one for lightmap
		local meshVertices = {
		
		    { pos = Vector( 0, 0, 0 ), u0 = 0, v0 = 0, u1 = 0, v1 = 0, n = Vector( 1, 0, 0 ) },
		    { pos = Vector( 0, 100, 0 ), u0 = 1, v0 = 0, u1 = 3, v1 = 0, n = Vector( 1, 0, 0 ) },
		    { pos = Vector( 0, 100, -100 ), u0 = 1, v0 = 1, u1 = 3, v1 = 3, n = Vector( 1, 0, 0 ) },
		    { pos = Vector( 0, 0, -100 ), u0 = 0, v0 = 1, u1 = 0, v1 = 3, n = Vector( 1, 0, 0 ) },
		}
		
		-- Run this command while ingame to create the mesh at map origin
		concommand.Add( "meshtest", function()
		
		    -- Creating a render target to be used as lightmap texture
		    meshLightmap = GetRenderTarget( "test_mesh_lightmap", 128, 128, false )
		
		    -- Filling the lightmap texture with some stuff for visualization
		    render.PushRenderTarget( meshLightmap )
		
		        cam.Start2D()
		
		            -- Resetting lightmap to be monotone gray
		            render.Clear( 128, 128, 128, 255 )
		
		            -- Drawing a dark rectangle
		            render.SetColorMaterial()
		            surface.SetDrawColor( 80, 80, 80, 255 )
		            surface.DrawRect( 32, 32, 64, 64 )
		
		            -- And some color text, why not! Lightmaps support RGB color
		            draw.SimpleText( "This is lightmap", "DermaDefault", 64, 64, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		        cam.End2D()
		
		    render.PopRenderTarget()
		
		    -- Creating the mesh. Don't forget to pass the material you're gonna use with it!
		    -- Shader of the material defines some features of the mesh, vertex structure
		    -- specifically (LightmappedGeneric requires each vertex to store 2 UV channels,
		    -- for instance. This is important in this case)
		    myTestMesh = Mesh( meshMat )
		
		    -- Creating the mesh
		    mesh.Begin( myTestMesh, MATERIAL_QUADS, 1 )
		
		        for i, vertex in pairs( meshVertices ) do
		
		            mesh.Position( vertex.pos )
		
		            -- Texture coordinates go to channel 0
		            mesh.TexCoord( 0, vertex.u0, vertex.v0 )
		
		            -- Lightmap texture coordinates go to channel 1
		            mesh.TexCoord( 1, vertex.u1, vertex.v1 )
		
		            mesh.Normal( vertex.n )
		            mesh.AdvanceVertex()
		        end
		
		    mesh.End()
		end )
		
		hook.Add( "PostDrawOpaqueRenderables", "LightmappedMeshTest", function()
		
		    if myTestMesh and myTestMesh ~= NULL then
		
		        render.SetMaterial( meshMat )
		        render.SetLightmapTexture( meshLightmap )
		
		        myTestMesh:Draw()
		    end
		end )
		```
    **/
    
    public static function SetLightmapTexture(tex:ITexture):Void;
    
    
    /**
        Sets the lighting origin.
		
		**Bug:** BUG This does not work for prop_physics. Issue Tracker: #2804
		
		Name | Description
		--- | ---
		`lightingOrigin` | The position from which the light should be "emitted".
    **/
    
    public static function SetLightingOrigin(lightingOrigin:Vector):Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetMorphTex1():ITexture;
    
    
    /**
        Sets a material to override a model's default material. Similar to Entity:SetMaterial except it uses an IMaterial argument and it can be used to change materials on models which are part of the world geometry.
		
		Name | Description
		--- | ---
		`material` | The material override.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the material of all opaque models to the red flashing "ERROR" texture.
		
		```lua 
		local error_mat = Material("models/error/new light1")
		
		function GM:PreDrawOpaqueRenderables(bDrawingDepth, bDrawingSkybox)
		
		    render.ModelMaterialOverride(error_mat)
		    
		end
		```
    **/
    
    public static function ModelMaterialOverride(material:IMaterial):Void;
    
    
    /**
        Sets the current drawing material to "color". 
		
		The material is defined as:
		
		___
		### Lua Examples
		#### Example 1
		Equivalent of this function
		
		```lua 
		render.SetMaterial( Material( "color" ) )
		```
    **/
    
    public static function SetColorMaterial():Void;
    
    
    /**
        Captures a part of the current render target and returns the data as a binary string in the given format. 
		
		Since the pixel buffer clears itself every frame, this will return a black screen outside of render hooks. To capture the user's final view, use GM:PostRender. This will not capture the Steam overlay or third-party injections (such as the Discord overlay, Overwolf, and advanced cheats) on the user's screen.
		
		**Bug:** BUG This sets the alpha channel incorrectly in PNG mode, causing the foreground to be rendered almost completely transparent. Issue Tracker: #2571
		
		Name | Description
		--- | ---
		`captureData` | Parameters of the capture. See RenderCaptureData structure.
		
		
		`**Returns:** binaryData
		
		___
		### Lua Examples
		#### Example 1
		How you could use this to save a picture of your screen.
		
		```lua 
		local ScreenshotRequested = false
		function RequestAScreenshot()
		    ScreenshotRequested = true
		end
		
		-- For the sake of this example, we use a console command to request a screenshot
		concommand.Add( "make_screenshot", RequestAScreenshot )
		
		hook.Add( "PostRender", "example_screenshot", function()
		    if ( !ScreenshotRequested ) then return end
		    ScreenshotRequested = false
		
		    local data = render.Capture( {
		        format = "jpeg",
		        quality = 70, //100 is max quality, but 70 is good enough.
		        h = ScrH(),
		        w = ScrW(),
		        x = 0,
		        y = 0,
		    } )
		    local f = file.Open( "Image.jpg", "wb", "DATA" )
		    f:Write( data )
		    f:Close()
		end )
		```
		**Output:**
		
		You should now have Image.jpg in your garrysmod/garrysmod/data folder, containing a screenshot.
    **/
    
    public static function Capture(captureData:RenderCaptureData):String;
    
    
    /**
        Resets the HDR tone multiplier to the specified value. 
		
		This will only work on HDR maps, and the value will automatically fade to what it was ( or whatever render.SetGoalToneMappingScale is ) if called only once.
		
		Name | Description
		--- | ---
		`scale` | The value which should be used as multiplier.
    **/
    
    public static function ResetToneMappingScale(scale:Float):Void;
    
    
    /**
        Renders the scene with the specified viewData to the current active render target.
		
		**Bug:** BUG Static props and LODs are rendered improperly due to incorrectly perceived distance. Issue Tracker: #1330
		
		Name | Description
		--- | ---
		`view` | The view data to be used in the rendering. See ViewData structure. Any missing value is assumed to be that of the current view. Similarly, you can make a normal render by simply not passing this table at all.
		
		
		___
		### Lua Examples
		#### Example 1
		How you could use this to draw the view on a derma panel.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( ScrW() - 100, ScrH() - 100 )
		frame:Center()
		frame:MakePopup()
		
		function frame:Paint( w, h )
		
		    local x, y = self:GetPos()
		
		    render.RenderView( {
		        origin = Vector( 0, 0, 0 ),
		        angles = Angle( 0, 0, 0 ),
		        x = x, y = y,
		        w = w, h = h
		    } )
		
		end
		```
    **/
    
    public static function RenderView(?view:ViewData):Void;
    
    
    /**
        Draws a sphere in 3D space. The material previously set with render.SetMaterial will be applied the sphere's surface. 
		
		See also render.DrawWireframeSphere for a wireframe equivalent.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`position` | Position of the sphere.
		`radius` | Radius of the sphere. Negative radius will make the sphere render inwards rather than outwards.
		`longitudeSteps` | The number of longitude steps. This controls the quality of the sphere. Higher quality will lower performance significantly. 50 is a good number to start with.
		`latitudeSteps` | The number of latitude steps. This controls the quality of the sphere. Higher quality will lower performance significantly. 50 is a good number to start with.
		`color` | The color of the sphere. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		This will draw a blue, half-translucent sphere (force field) at the position local player is looking.
		
		```lua 
		hook.Add( "PostDrawTranslucentRenderables", "test", function()
		
		    --[[
		        when you draw a sphere, you have to specify what material the sphere is
		        going to have before rendering it, render.SetColorMaterial()
		        just sets it to a white material so we can recolor it easily.
		    ]]
		    render.SetColorMaterial()
		
		    -- The position to render the sphere at, in this case, the looking position of the local player
		    local pos = LocalPlayer():GetEyeTrace().HitPos
		
		    -- Draw the sphere!
		    render.DrawSphere( pos, 50, 30, 30, Color( 0, 175, 175, 100 ) )
		
		end )
		```
    **/
    
    public static function DrawSphere(position:Vector, radius:Float, longitudeSteps:Float, latitudeSteps:Float, ?color:Color):Void;
    
    
    /**
        Alias of render.GetPowerOfTwoTexture.
		
		`**Returns:** 
    **/
    
    public static function GetRefractTexture():ITexture;
    
    
    /**
        Overrides the write behaviour of all next rendering operations towards the depth buffer.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the override.
		`shouldWrite` | If the previous argument is true, sets whether the next rendering operations should write to the depth buffer or not. Has no effect if the previous argument is false.
    **/
    
    public static function OverrideDepthEnable(enable:Bool, shouldWrite:Bool):Void;
    
    
    /**
        Updates the power of two texture.
		
		`**Returns:** Returns render. GetPowerOfTwoTexture.
    **/
    
    public static function UpdatePowerOfTwoTexture():ITexture;
    
    
    /**
        Copies the contents of one texture to another. Only works with rendertargets.
		
		Name | Description
		--- | ---
		`texture_from` | 
		`texture_to` | 
    **/
    
    public static function CopyTexture(texture_from:ITexture, texture_to:ITexture):Void;
    
    
    /**
        Returns the fog start and end distance.
		
		Name | Description
		--- | ---
		`a` | Fog start distance set by render. FogStart
		`b` | For end distance set by render. FogEnd
		`c` | Fog Z distance set by render. SetFogZ
    **/
    
    public static function GetFogDistances():RenderLibGetFogDistancesReturn;
    
    
    /**
        Sets the material to be used in any upcoming render operation using the render library. 
		
		Not to be confused with surface.SetMaterial.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`mat` | The material to be used.
    **/
    
    public static function SetMaterial(mat:IMaterial):Void;
    
    
    /**
        Sets up the ambient lighting for any upcoming render operation. Ambient lighting can be seen as a cube enclosing the object to be drawn, each of its faces representing a directional light source that shines towards the object. Thus, there is a total of six different light sources that can be configured separately. 
		
		Light color components are not restricted to a specific range (i.e. 0-255), instead, higher values will result in a brighter light.
		
		Name | Description
		--- | ---
		`lightDirection` | The light source to edit, see BOX_ Enums.
		`red` | The red component of the light color.
		`green` | The green component of the light color.
		`blue` | The blue component of the light color.
    **/
    
    public static function SetModelLighting(lightDirection:BOX, red:Float, green:Float, blue:Float):Void;
    
    
    /**
        
		
		**Warning:** This function is broken and does absolutely nothing
		
		Name | Description
		--- | ---
		`mat` | 
    **/
    
    public static function BrushMaterialOverride(?mat:IMaterial):Void;
    
    
    /**
        Returns if the current settings and the system allow the usage of pixel shaders 2.0.
		
		`**Returns:** Whether Pixel Shaders 2.0 are supported or not.
    **/
    
    public static function SupportsPixelShaders_2_0():Bool;
    
    
    /**
        ***Deprecated:** Use render. OverrideBlend instead.
		
		Overrides the internal graphical functions used to determine the final color and alpha of a rendered texture. 
		
		See also render.OverrideAlphaWriteEnable.
		
		**Note:** Doing surface library draw calls with alpha set to 0 is a no-op and will never have any effect.
		
		Name | Description
		--- | ---
		`enabled` | true to enable, false to disable. No other arguments are required when disabling.
		`srcBlend` | The source color blend function BLEND_ Enums. Determines how a rendered texture's final color should be calculated.
		`destBlend` | 
		`srcBlendAlpha` | The source alpha blend function BLEND_ Enums. Determines how a rendered texture's final alpha should be calculated.
		`destBlendAlpha` | 
		
		
		___
		### Lua Examples
		#### Example 1
		In this example we draw a lightning bolt over our player's head.We shouldn't really draw the lightning in the PreDrawTranslucentRenderables hook as this causes issues rendering transparent objects behind the lightning, but it's a quick example of how the function works. Normally it should be drawn in a custom lua effect's EFFECT:Render.
		
		```lua 
		-- Our sprite texture to render. Rendering this texture without
		-- render.OverrideBlendFunc will result in black borders around the lightning beam.
		local lightningMaterial = Material("sprites/lgtning")
		
		function GM:PreDrawTranslucentRenderables(isDrawingDepth, isDrawingSkybox)
		
		    if isDrawingDepth or isDrawSkybox then return end
		
		    local ply = Entity(1)
		
		    if !IsValid(ply) then return end
		
		    -- Calculate a random UV to use for the lightning to give it some movement
		    local uv = math.Rand(0, 1)
		
		    -- Enable blend override to interpret the color and alpha from the texture.
		    render.OverrideBlendFunc( true, BLEND_SRC_COLOR, BLEND_SRC_ALPHA, BLEND_ONE, BLEND_ZERO)
		
		    render.SetMaterial(lightningMaterial)
		
		    -- Render a lightning beam along points randomly offset from a line above the player.
		    render.StartBeam(5)
		    render.AddBeam(ply:GetPos() + Vector(0,0,035), 20, uv, Color(255,255,255,255))
		    render.AddBeam(ply:GetPos() + Vector(0,0,135) + Vector(math.Rand(-20,20),math.Rand(-20,20),0), 20, uv*2, Color(255,255,255,255))
		    render.AddBeam(ply:GetPos() + Vector(0,0,235) + Vector(math.Rand(-20,20),math.Rand(-20,20),0), 20, uv*3, Color(255,255,255,255))
		    render.AddBeam(ply:GetPos() + Vector(0,0,335) + Vector(math.Rand(-20,20),math.Rand(-20,20),0), 20, uv*4, Color(255,255,255,255))
		    render.AddBeam(ply:GetPos() + Vector(0,0,435) + Vector(math.Rand(-20,20),math.Rand(-20,20),0), 20, uv*5, Color(255,255,255,255))
		    render.EndBeam()
		
		     -- Disable blend override
		    render.OverrideBlendFunc( false )
		
		end
		```
    **/
    @:deprecated("Use render. OverrideBlend instead.")
    public static function OverrideBlendFunc(enabled:Bool, srcBlend:BLEND, destBlend:Float, ?srcBlendAlpha:BLEND, ?destBlendAlpha:Float):Void;
    
    
    /**
        Draws the the current material set by render.SetMaterial to the area specified. Color cannot be customized. 
		
		See also render.DrawScreenQuad.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`startX` | X start position of the rect.
		`startY` | Y start position of the rect.
		`width` | Width of the rect.
		`height` | Height of the rect.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage, draws a 256x256 rectangle with the wireframe material.
		
		```lua 
		local ourMat = Material( "models/wireframe" )
		hook.Add( "HUDPaint", "example_hook", function()
		    render.SetMaterial( ourMat )
		    render.DrawScreenQuadEx( 100, 100, 256, 256 )
		end )
		```
    **/
    
    public static function DrawScreenQuadEx(startX:Float, startY:Float, width:Float, height:Float):Void;
    
    
    /**
        Draws a sprite in 3D space.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`position` | Position of the sprite.
		`width` | Width of the sprite.
		`height` | Height of the sprite.
		`color` | Color of the sprite. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Draw a sprite at the center of the map
		
		```lua 
		local pos,material,white = Vector(0,0,0), Material( "sprites/splodesprite" ),Color(255,255,255,255) --Define this sort of stuff outside of loops to make more efficient code.
		hook.Add( "HUDPaint", "paintsprites", function()
		    cam.Start3D() -- Start the 3D function so we can draw onto the screen.
		        render.SetMaterial( material ) -- Tell render what material we want, in this case the flash from the gravgun
		        render.DrawSprite( pos, 16, 16, white) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
		    cam.End3D()
		end )
		```
		**Output:**
		
		An orange star appears at 0,0,0 on the map.
		
		#### Example 2
		Function that displays a sprite at the given position, without the need of a specific rendering contextdraw.VectorSprite(Vector position, number size, Color structure color, boolean constantSize)
		
		```lua 
		local toDraw3d = {}
		local sprites3d = 0
		
		local toDraw2d = {}
		local sprites2d = 0
		
		local material = Material("sprites/light_ignorez")
		
		function draw.VectorSprite(position, size, color, constantSize)
		    if (not isvector(position)) then
		        error("bad argument #1 to draw.DrawVectorSprite (Vector expected, got " .. type(position) .. ")")
		    end
		
		    if (not isnumber(size)) then
		        error("bad argument #2 to draw.DrawVectorSprite (number expected, got " .. type(size) .. ")")
		    end
		
		    if (not IsColor(color)) then
		        error("bad argument #3 to draw.DrawVectorSprite (Color expected, got " .. type(color) .. ")")
		    end
		
		    local tbl = {position, size, color}
		
		    if (constantSize) then
		        sprites2d = sprites2d + 1
		        toDraw2d[sprites2d] = tbl
		    else
		        sprites3d = sprites3d + 1
		        toDraw3d[sprites3d] = tbl
		    end
		end
		
		local render_SetMaterial = render.SetMaterial
		local render_DrawSprite = render.DrawSprite
		hook.Add("PreDrawEffects", "draw.VectorSprite", function()
		    if (sprites3d ~= 0) then
		        render_SetMaterial(material)
		
		        for i = 1, sprites3d do
		            local info = toDraw3d[i]
		            toDraw3d[i] = nil -- Clear the table every frame
		
		            render_DrawSprite(info[1], info[2], info[2], info[3])
		        end
		
		        sprites3d = 0
		    end
		end)
		
		local surface_SetMaterial = surface.SetMaterial
		local surface_SetDrawColor = surface.SetDrawColor
		local surface_DrawTexturedRect = surface.DrawTexturedRect
		hook.Add("DrawOverlay", "draw.VectorSprite", function()
		    if (sprites2d ~= 0) then
		        surface_SetMaterial(material)
		
		        for i = 1, sprites2d do
		            local info = toDraw2d[i]
		            toDraw2d[i] = nil
		
		            local pos2d = info[1]:ToScreen()
		
		            if pos2d.visible then
		                surface_SetDrawColor(info[3])
		                surface_DrawTexturedRect(pos2d.x, pos2d.y, info[2], info[2])
		            end
		        end
		
		        sprites2d = 0
		    end
		end)
		```
    **/
    
    public static function DrawSprite(position:Vector, width:Float, height:Float, ?color:Color):Void;
    
    
    /**
        Enables HDR tone mapping which influences the brightness.
    **/
    
    public static function TurnOnToneMapping():Void;
    
    
    /**
        Sets up the local lighting for any upcoming render operation. Up to 4 local lights can be defined, with one of three different types (point, directional, spot). 
		
		Disables all local lights if called with no arguments.
		
		Name | Description
		--- | ---
		`lights` | A table containing up to 4 tables for each light source that should be set up. Each of these tables should contain the properties of its associated light source, see LocalLight structure.
    **/
    
    public static function SetLocalModelLights(?lights:LocalLight):Void;
    
    
    /**
        Draws a wireframe sphere in 3d space.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`position` | Position of the sphere.
		`radius` | The size of the sphere.
		`longitudeSteps` | The amount of longitude steps. The larger this number is, the smoother the sphere is.
		`latitudeSteps` | The amount of latitude steps. The larger this number is, the smoother the sphere is.
		`color` | The color of the wireframe. Uses the Color structure.
		`writeZ` | Whether or not to consider the Z buffer. If false, the wireframe will be drawn over everything currently drawn. If true, it will be drawn with depth considered, as if it were a regular object in 3D space.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a wireframe sphere over a normal sphere for an artistic effect.
		
		```lua 
		hook.Add( "PostDrawTranslucentRenderables", "test", function()
		
		    -- Set the draw material to solid white
		    render.SetColorMaterial()
		
		    -- The position to render the sphere at, in this case, the looking position of the local player
		    local pos = LocalPlayer():GetEyeTrace().HitPos
		
		    local radius = 50
		    local wideSteps = 10
		    local tallSteps = 10
		
		    -- Draw the sphere!
		    render.DrawSphere( pos, radius, wideSteps, tallSteps, Color( 0, 175, 175, 100 ) )
		
		    -- Draw the wireframe sphere!
		    render.DrawWireframeSphere( pos, radius, wideSteps, tallSteps, Color( 255, 255, 255, 255 ) )
		
		end )
		```
    **/
    
    public static function DrawWireframeSphere(position:Vector, radius:Float, longitudeSteps:Float, latitudeSteps:Float, ?color:Color, ?writeZ:Bool):Void;
    
    
    /**
        Returns the ambient color of the map.
		
		`**Returns:** color
    **/
    
    public static function GetAmbientLightColor():Vector;
    
    
    /**
        Returns a vector representing linear tone mapping scale.
		
		`**Returns:** The vector representing linear tone mapping scale.
    **/
    
    public static function GetToneMappingScaleLinear():Vector;
    
    
    /**
        Sets the shadow projection direction.
		
		Name | Description
		--- | ---
		`shadowDirections` | The new shadow direction.
    **/
    
    public static function SetShadowDirection(shadowDirections:Vector):Void;
    
    
    /**
        Copies the entire screen to the screen effect texture, which can be acquired via render.GetScreenEffectTexture. This function is mainly intended to be used in GM:RenderScreenspaceEffects
    **/
    
    public static function UpdateScreenEffectTexture():Void;
    
    
    /**
        
		
		`**Returns:** The bloom texture
    **/
    
    public static function GetBloomTex0():ITexture;
    
    
    /**
        Sets the reference value which will be used for all stencil operations. This is an unsigned integer.
		
		Name | Description
		--- | ---
		`referenceValue` | Reference value.
    **/
    
    public static function SetStencilReferenceValue(referenceValue:Float):Void;
    
    
    /**
        Draws a wireframe box in 3D space.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`position` | Position of the box.
		`angle` | Angles of the box.
		`mins` | The lowest corner of the box.
		`maxs` | The highest corner of the box.
		`color` | The color of the box. Uses the Color structure.
		`writeZ` | Sets whenever to write to the zBuffer.
    **/
    
    public static function DrawWireframeBox(position:Vector, angle:Angle, mins:Vector, maxs:Vector, ?color:Color, ?writeZ:Bool):Void;
    
    
    /**
        Sets the goal HDR tone mapping scale. 
		
		Use this in a rendering/think hook as it is reset every frame.
		
		Name | Description
		--- | ---
		`scale` | The target scale.
    **/
    
    public static function SetGoalToneMappingScale(scale:Float):Void;
    
    
    /**
        Sets the alpha blending for every upcoming render operation.
		
		**Bug:** BUG This does not affect non-model render.Draw* functions. Issue Tracker: #3166
		
		Name | Description
		--- | ---
		`blending` | Blending value from 0-1.
    **/
    
    public static function SetBlend(blending:Float):Void;
    
    
    /**
        Pops the current texture magnification filter from the filter stack. 
		
		See render.PushFilterMag
    **/
    
    public static function PopFilterMag():Void;
    
    
    /**
        Returns the maximum texture width the renderer can handle.
		
		`**Returns:** maxTextureWidth
    **/
    
    public static function MaxTextureWidth():Float;
    
    
    /**
        Draws 2 connected triangles. Expects material to be set by render.SetMaterial.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`vert1` | First vertex.
		`vert2` | The second vertex.
		`vert3` | The third vertex.
		`vert4` | The fourth vertex.
		`color` | The color of the quad. See Color
		
		
		___
		### Lua Examples
		#### Example 1
		Draw a red half transparent quad facing upwards 150 units below the 0,0,0 of gm_construct.
		
		```lua 
		local ourMat = Material( "vgui/white" ) -- Calling Material() every frame is quite expensive
		hook.Add( "PostDrawTranslucentRenderables", "DrawQuad_Example", function()
		
		    render.SetMaterial( ourMat ) -- If you use Material, cache it!
		    render.DrawQuad( Vector( 0, 0, -150 ), Vector( 0, 100, -150 ),Vector( 100, 100, -150 ), Vector( 100, 0, -150 ), Color( 255, 0, 0, 128 ) )
		
		end)
		```
    **/
    
    public static function DrawQuad(vert1:Vector, vert2:Vector, vert3:Vector, vert4:Vector, ?color:AnyTable):Void;
    
    
    /**
        Returns the current alpha blending.
		
		`**Returns:** blend
    **/
    
    public static function GetBlend():Float;
    
    
    /**
        Sets the ambient lighting for any upcoming render operation.
		
		Name | Description
		--- | ---
		`r` | The red part of the color, 0-1.
		`g` | The green part of the color, 0-1.
		`b` | The blue part of the color, 0-1.
    **/
    
    public static function SetAmbientLight(r:Float, g:Float, b:Float):Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetMoBlurTex0():ITexture;
    
    
    /**
        Sets the distance at which the fog starts showing up.
		
		**Note:** If used in GM:SetupSkyboxFog, this value must be scaled by the first argument of the hook
		
		Name | Description
		--- | ---
		`fogStart` | The distance at which the fog starts showing up. NOTE If used in GM:SetupSkyboxFog, this value must be scaled by the first argument of the hook
    **/
    
    public static function FogStart(fogStart:Float):Void;
    
    
    /**
        Resets the model lighting to the specified color. 
		
		Calls render.SetModelLighting for every direction with given color.
		
		Name | Description
		--- | ---
		`r` | The red part of the color, 0-1
		`g` | The green part of the color, 0-1
		`b` | The blue part of the color, 0-1
    **/
    
    public static function ResetModelLighting(r:Float, g:Float, b:Float):Void;
    
    
    /**
        Sets the render target with the specified index to the specified rt.
		
		Name | Description
		--- | ---
		`rtIndex` | The index of the rt to set.
		`texture` | The new render target to be used.
    **/
    
    public static function SetRenderTargetEx(rtIndex:Float, texture:ITexture):Void;
    
    
    /**
        Sets the maximum density of the fog.
		
		Name | Description
		--- | ---
		`maxDensity` | The maximum density of the fog, 0-1.
    **/
    
    public static function FogMaxDensity(maxDensity:Float):Void;
    
    
    /**
        Returns if the current settings and the system allow the usage of vertex shaders 2.0.
		
		`**Returns:** Whether Vertex Shaders 2.0 are supported or not.
    **/
    
    public static function SupportsVertexShaders_2_0():Bool;
    
    
    /**
        Pushes a texture filter onto the minification texture filter stack.
		
		Name | Description
		--- | ---
		`texFilterType` | The texture filter type, see TEXFILTER_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		Anisotropic Filtering (This is not antialiasing)
		
		```lua 
		render.PushFilterMag( TEXFILTER.ANISOTROPIC )
		render.PushFilterMin( TEXFILTER.ANISOTROPIC )
		
		-- Render stuff here
		
		render.PopFilterMag()
		render.PopFilterMin()
		```
    **/
    
    public static function PushFilterMin(texFilterType:TEXFILTER):Void;
    
    
    /**
        Sets the render target to the specified rt.
		
		Name | Description
		--- | ---
		`texture` | The new render target to be used.
    **/
    
    public static function SetRenderTarget(texture:ITexture):Void;
    
    
    /**
        Obtain an ITexture of the screen. You must call render.UpdateScreenEffectTexture in order to update this texture with the currently rendered scene. 
		
		This texture is mainly used within GM:RenderScreenspaceEffects
		
		Name | Description
		--- | ---
		`textureIndex` | Max index is 3, but engine only creates the first two for you.
		
		
		`**Returns:** 
		
		___
		### Lua Examples
		#### Example 1
		Print the texture name of the returned textures.
		
		```lua 
		print(render.GetScreenEffectTexture(0):GetName())
		print(render.GetScreenEffectTexture(1):GetName())
		```
		**Output:**
		
		_rt_fullframefb _rt_fullframefb1
    **/
    
    public static function GetScreenEffectTexture(?textureIndex:Float):ITexture;
    
    
    /**
        Sets a scissoring rect which limits the drawing area.
		
		Name | Description
		--- | ---
		`startX` | X start coordinate of the scissor rect.
		`startY` | Y start coordinate of the scissor rect.
		`endX` | X end coordinate of the scissor rect.
		`endY` | Y end coordinate of the scissor rect.
		`enable` | Enable or disable the scissor rect.
		
		
		___
		### Lua Examples
		#### Example 1
		Shows how to use this function. This will cut the white rectangle from full screen to 512x512 box in top left corner
		
		```lua 
		render.SetScissorRect( 0, 0, 512, 512, true ) -- Enable the rect
		    draw.RoundedBox( 4, 0, 0, ScrW(), ScrH(), color_white ) -- Draw a white rectangle over the whole screen
		render.SetScissorRect( 0, 0, 0, 0, false ) -- Disable after you are done
		```
    **/
    
    public static function SetScissorRect(startX:Float, startY:Float, endX:Float, endY:Float, enable:Bool):Void;
    
    
    /**
        If the fog mode is set to MATERIAL_FOG_LINEAR_BELOW_FOG_Z, the fog will only be rendered below the specified height.
		
		Name | Description
		--- | ---
		`fogZ` | The fog Z.
    **/
    
    public static function SetFogZ(fogZ:Float):Void;
    
    
    /**
        Sets the shadow color.
		
		Name | Description
		--- | ---
		`red` | The red channel of the shadow color.
		`green` | The green channel of the shadow color.
		`blue` | The blue channel of the shadow color.
    **/
    
    public static function SetShadowColor(red:Float, green:Float, blue:Float):Void;
    
    
    /**
        Returns the _rt_ResolvedFullFrameDepth texture for SSAO depth.
		
		`**Returns:** 
    **/
    
    public static function GetResolvedFullFrameDepth():ITexture;
    
    
    /**
        Creates a new ClientsideModel, renders it at the specified pos/ang, and removes it. Can also be given an existing CSEnt to reuse instead.
		
		**Note:** This function is only meant to be used in a single render pass kind of scenario, if you need to render a model continuously, use a cached ClientsideModel and provide it as a second argument.
		
		**Bug:** BUG Using this with a map model (game.GetWorld():GetModel()) crashes the game. Issue Tracker: #3307
		
		Name | Description
		--- | ---
		`settings` | Requires: string model - The model to draw Vector pos - The position to draw the model at Angle angle - The angles to draw the model at
		`ent` | If provided, this entity will be reused instead of creating a new one with ClientsideModel. Note that the ent's model, position and angles will be changed, and Entity: SetNoDraw will be set to true.
    **/
    
    public static function Model(settings:AnyTable, ?ent:CSEnt):Void;
    
    
    /**
        Ends the beam mesh of a beam started with render.StartBeam.
    **/
    
    public static function EndBeam():Void;
    
    
    /**
        Pushes the current render target and viewport to the RT stack then sets a new current render target and viewport. If the viewport is not specified, the dimensions of the render target are used instead. 
		
		This is similar to a call to render.SetRenderTarget and render.SetViewPort where the current render target and viewport have been saved beforehand, except the viewport isn't clipped to screen bounds. 
		
		 See also render.PopRenderTarget.
		
		**Note:** If you want to render to the render target in 2d mode and it is not the same size as the screen, use cam.Start2D and cam.End2D.
		
		**Note:** If the render target is bigger than the screen, rendering done with the surface library will be clipped to the screen bounds unless you call surface.DisableClipping
		
		Name | Description
		--- | ---
		`texture` | The new render target to be used.
		`x` | X origin of the viewport.
		`y` | Y origin of the viewport.
		`w` | Width of the viewport.
		`h` | Height of the viewport
		
		
		___
		### Lua Examples
		#### Example 1
		Shows how to create a material which uses a custom created Render Target texture.
		
		```lua 
		-- Create render target
		local exampleRT = GetRenderTarget( "example_rt", 1024, 1024 )
		
		-- Draw to the render target
		render.PushRenderTarget( exampleRT )
		    cam.Start2D()
		        -- Draw background
		        surface.SetDrawColor( 0, 0, 0, 255 )
		        surface.DrawRect( 0, 0, 1024, 1024 )
		
		        -- Draw some foreground stuff
		        surface.SetDrawColor( 255, 0, 0, 255 )
		        surface.DrawRect( 0, 0, 256, 256 )
		    cam.End2D()
		render.PopRenderTarget()
		
		local customMaterial = CreateMaterial( "example_rt_mat", "UnlitGeneric", {
		    ["$basetexture"] = exampleRT:GetName(), -- You can use "example_rt" as well
		    ["$translucent"] = 1,
		    ["$vertexcolor"] = 1
		} )
		
		hook.Add( "HUDPaint", "ExampleDraw", function()
		    surface.SetDrawColor( 255, 255, 255, 255 )
		    surface.SetMaterial( customMaterial )
		    surface.DrawTexturedRect( 0, 0, customMaterial:GetTexture( "$basetexture" ):Width(), customMaterial:GetTexture( "$basetexture" ):Height() )
		end )
		```
		**Output:**
		
		A black 1024x1024 render target with a 256x256 red square in top left corner drawn in your top left corner.
		
		#### Example 2
		Shows how you can use alpha channel with render targets.
		
		```lua 
		render.PushRenderTarget( texture )
		render.OverrideAlphaWriteEnable( true, true )
		
		render.ClearDepth()
		render.Clear( 0, 0, 0, 0 )
		
		-- Draw stuff here
		
		render.OverrideAlphaWriteEnable( false )
		render.PopRenderTarget()
		```
    **/
    
    public static function PushRenderTarget(texture:ITexture, ?x:Float, ?y:Float, ?w:Float, ?h:Float):Void;
    
    
    /**
        Returns the current color modulation values as normals.
		
		`**Returns:** r
    **/
    
    public static function GetColorModulation():Float;
    
    
    /**
        Pushes a texture filter onto the magnification texture filter stack.
		
		Name | Description
		--- | ---
		`texFilterType` | The texture filter type, see TEXFILTER_ Enums
    **/
    
    public static function PushFilterMag(texFilterType:TEXFILTER):Void;
    
    
    /**
        Sets the status of the clip renderer, returning previous state.
		
		**Warning:** To prevent unintended rendering behavior of other mods/the game, you must reset the clipping state to its previous value.
		
		**Bug:** BUG Reloading the map does not reset the previous value of this function. Issue Tracker: #3105
		
		Name | Description
		--- | ---
		`state` | New clipping state.
		
		
		`**Returns:** Previous clipping state.
		
		___
		### Lua Examples
		#### Example 1
		Properly using the function.
		
		```lua 
		-- Inside some rendering hook
		
		local oldclip = render.EnableClipping( true )
		
		-- Your code here
		
		render.EnableClipping( oldclip )
		```
		
		#### Example 2
		Clips the lower half of your custom entity
		
		```lua 
		function ENT:Draw()
		    local normal = self:GetUp() -- Everything "behind" this normal will be clipped
		    local position = normal:Dot( self:GetPos() ) -- self:GetPos() is the origin of the clipping plane
		
		    local oldEC = render.EnableClipping( true )
		    render.PushCustomClipPlane( normal, position )
		
		    self:DrawModel()
		
		    render.PopCustomClipPlane()
		    render.EnableClipping( oldEC )
		end
		```
    **/
    
    public static function EnableClipping(state:Bool):Bool;
    
    
    /**
        Pops the current flashlight mode from the flashlight mode stack.
    **/
    
    public static function PopFlashlightMode():Void;
    
    
    /**
        Changes the view port position and size. The values will be clamped to the game's screen resolution. 
		
		If you are looking to render something to a texture (render target), you should use render.PushRenderTarget.
		
		**Note:** This function will override values of ScrW and ScrH with the ones you set.
		
		Name | Description
		--- | ---
		`x` | X origin of the view port.
		`y` | Y origin of the view port.
		`w` | Width of the view port.
		`h` | Height of the view port.
		
		
		___
		### Lua Examples
		#### Example 1
		Renders a screen with a dimension of 32 X 32 and resets the render system to normal.
		
		```lua 
		local oldW, oldH = ScrW(), ScrH()
		local oldRT = render.GetRenderTarget()
		
		render.SetRenderTarget(RTName)
		render.Clear(0,0,0,255)
		render.SetViewPort(0,0,32,32)
		    render.RenderView(CamData)
		render.SetRenderTarget(oldRT)
		render.SetViewPort(0,0,oldW,oldH)
		```
    **/
    
    public static function SetViewPort(x:Float, y:Float, w:Float, h:Float):Void;
    
    
    /**
        Draws the the current material set by render.SetMaterial to the whole screen. The color cannot be customized. 
		
		See also render.DrawScreenQuadEx.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		___
		### Lua Examples
		#### Example 1
		Example usage, draws a wireframe texture onto the entire screen.
		
		```lua 
		local ourMat = Material( "models/wireframe" )
		
		hook.Add( "HUDPaint", "example_hook", function()
		    render.SetMaterial( ourMat )
		    render.DrawScreenQuad()
		end )
		```
    **/
    
    public static function DrawScreenQuad():Void;
    
    
    /**
        Clears the current rendertarget for obeying the current stencil buffer conditions.
		
		Name | Description
		--- | ---
		`r` | Value of the red channel to clear the current rt with.
		`g` | Value of the green channel to clear the current rt with.
		`b` | Value of the blue channel to clear the current rt with.
		`a` | Value of the alpha channel to clear the current rt with.
		`depth` | Clear the depth buffer.
		
		
		___
		### Lua Examples
		#### Example 1
		Clearing a section of the screen via the stencil buffer
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Refuse to write things to the screen unless that pixel's value is 1
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    -- Write a 1 to the centre third of the screen. Because we cleared it earlier, everything is currently 0
		    local w, h = ScrW() / 3, ScrH() / 3
		    local x_start, y_start = w, h
		    local x_end, y_end = x_start + w, y_start + h
		    render.ClearStencilBufferRectangle( x_start, y_start, x_end, y_end, 1 )
		
		    -- Tell the render library to clear the screen, but obeying the stencil test function.
		    -- This means it will only clear the centre third.
		    render.ClearBuffersObeyStencil(0, 148, 133, 255, false);
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function ClearBuffersObeyStencil(r:Float, g:Float, b:Float, a:Float, depth:Bool):Void;
    
    
    /**
        Sets the compare function of the stencil. 
		
		Pixels which fail the stencil comparison function are not written to the render target. The operation to be performed on the stencil buffer values for these pixels can be set using render.SetStencilFailOperation. 
		
		 Pixels which pass the stencil comparison function are written to the render target unless they fail the depth buffer test (where applicable). The operation to perform on the stencil buffer values for these pixels can be set using render.SetStencilPassOperation and render.SetStencilZFailOperation.
		
		Name | Description
		--- | ---
		`compareFunction` | Compare function, see STENCILCOMPARISONFUNCTION_ Enums, and STENCIL_ Enums for short.
    **/
    
    public static function SetStencilCompareFunction(compareFunction:STENCILCOMPARISONFUNCTION):Void;
    
    
    /**
        Sets the color modulation.
		
		Name | Description
		--- | ---
		`r` | The red channel multiplier normal ranging from 0-1.
		`g` | The green channel multiplier normal ranging from 0-1.
		`b` | The blue channel multiplier normal ranging from 0-1.
    **/
    
    public static function SetColorModulation(r:Float, g:Float, b:Float):Void;
    
    
    /**
        Dumps the current render target and allows the pixels to be accessed by render.ReadPixel.
    **/
    
    public static function CapturePixels():Void;
    
    
    /**
        Pushes a new clipping plane of the clip plane stack and sets it as active.
		
		**Note:** A max of 2 clip planes are supported on Linux/POSIX, and 6 on Windows.
		
		Name | Description
		--- | ---
		`normal` | The normal of the clipping plane.
		`distance` | The distance of the plane from the world origin. You can use Vector: Dot between the normal and any point on the plane to find this, see Example 1.
		
		
		___
		### Lua Examples
		#### Example 1
		Clips the lower half of your custom entity
		
		```lua 
		function ENT:Draw()
		    local normal = self:GetUp() -- Everything "behind" this normal will be clipped
		    local position = normal:Dot( self:GetPos() ) -- self:GetPos() is the origin of the clipping plane
		
		    local oldEC = render.EnableClipping( true )
		    render.PushCustomClipPlane( normal, position )
		
		    self:DrawModel()
		
		    render.PopCustomClipPlane()
		    render.EnableClipping( oldEC )
		end
		```
    **/
    
    public static function PushCustomClipPlane(normal:Vector, distance:Float):Void;
    
    
    /**
        Draws a textured rectangle.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`tex` | The texture to draw
		`x` | The x coordinate of the rectangle to draw.
		`y` | The y coordinate of the rectangle to draw.
		`width` | The width of the rectangle to draw.
		`height` | The height of the rectangle to draw.
    **/
    
    public static function DrawTextureToScreenRect(tex:ITexture, x:Float, y:Float, width:Float, height:Float):Void;
    
    
    /**
        Resets the depth buffer.
		
		**Bug:** BUG This function also clears the stencil buffer. Use render.Clear in the meantime. Issue Tracker: #3317
    **/
    
    public static function ClearDepth():Void;
    
    
    /**
        Sets the operation to be performed on the stencil buffer values if the compare function was successful.
		
		Name | Description
		--- | ---
		`passOperation` | Pass operation function, see STENCILOPERATION_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		This uses the pass operation to blank out everything but what we just drew
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    -- render.SetStencilPassOperation( STENCIL_KEEP )
		    render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Only draw things if their pixels are NOT 1. Currently this is everything.
		    render.SetStencilCompareFunction( STENCIL_NOTEQUAL )
		    -- If something draws to the screen, set the pixels it draws to 1
		    render.SetStencilPassOperation( STENCIL_REPLACE )
		
		    -- Draw our entities. They will draw as normal
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- At this point, we cannot draw on top of anything that we have already drawn.
		    -- So, if we flush the screen, our entities will still be there.
		    render.ClearBuffersObeyStencil(0, 148, 133, 255, false);
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function SetStencilPassOperation(passOperation:STENCILOPERATION):Void;
    
    
    /**
        Sets whether stencil tests are carried out for each rendered pixel. 
		
		Only pixels passing the stencil test are written to the render target.
		
		Name | Description
		--- | ---
		`newState` | The new state.
		
		
		___
		### Lua Examples
		#### Example 1
		A basic stencil operation that limits rendering to the centre of the screen
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Refuse to write things to the screen unless that pixel's value is 1
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    -- Write a 1 to the centre third of the screen. Because we cleared it earlier, everything is currently 0
		    local w, h = ScrW() / 3, ScrH() / 3
		    local x_start, y_start = w, h
		    local x_end, y_end = x_start + w, y_start + h
		    render.ClearStencilBufferRectangle( x_start, y_start, x_end, y_end, 1 )
		
		    -- Draw our entities. They will only draw in the area cleared above
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function SetStencilEnable(newState:Bool):Void;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`vec` | 
    **/
    
    public static function SetToneMappingScaleLinear(vec:Vector):Void;
    
    
    /**
        Returns if the current settings and the system allow the usage of pixel shaders 1.4.
		
		`**Returns:** Whether Pixel Shaders 1.4 are supported or not.
    **/
    
    public static function SupportsPixelShaders_1_4():Bool;
    
    
    /**
        Draws a box in 3D space.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`position` | Origin of the box.
		`angles` | Orientation of the box.
		`mins` | Start position of the box, relative to origin.
		`maxs` | End position of the box, relative to origin.
		`color` | The color of the box. Uses the Color structure.
    **/
    
    public static function DrawBox(position:Vector, angles:Angle, mins:Vector, maxs:Vector, ?color:Color):Void;
    
    
    /**
        This applies the changes made to map lighting using engine.LightStyle.
		
		Name | Description
		--- | ---
		`DoStaticProps` | When true, this will also apply lighting changes to static props. This is really slow on large maps.
    **/
    
    public static function RedownloadAllLightmaps(?DoStaticProps:Bool):Void;
    
    
    /**
        Draws textured beam.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`startPos` | Beam start position.
		`endPos` | Beam end position.
		`width` | The width of the beam.
		`textureStart` | The start coordinate of the texture used.
		`textureEnd` | The end coordinate of the texture used.
		`color` | The color to be used. Uses the Color structure.
    **/
    
    public static function DrawBeam(startPos:Vector, endPos:Vector, width:Float, textureStart:Float, textureEnd:Float, ?color:Color):Void;
    
    
    /**
        Pops the current texture minification filter from the filter stack. 
		
		See render.PushFilterMin
    **/
    
    public static function PopFilterMin():Void;
    
    
    /**
        Sets the at which the fog reaches its max density.
		
		**Note:** If used in GM:SetupSkyboxFog, this value must be scaled by the first argument of the hook
		
		Name | Description
		--- | ---
		`distance` | The distance at which the fog reaches its max density. NOTE If used in GM:SetupSkyboxFog, this value must be scaled by the first argument of the hook
    **/
    
    public static function FogEnd(distance:Float):Void;
    
    
    /**
        Overrides the write behaviour of all next rendering operations towards the alpha channel of the current render target. 
		
		See also render.OverrideBlend.
		
		**Note:** Doing surface library draw calls with alpha set to 0 is a no-op and will never have any effect.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the override.
		`shouldWrite` | If the previous argument is true, sets whether the next rendering operations should write to the alpha channel or not. Has no effect if the previous argument is false.
		
		
		___
		### Lua Examples
		#### Example 1
		Shows how you can use alpha channel with render targets.
		
		```lua 
		render.PushRenderTarget( texture )
		render.OverrideAlphaWriteEnable( true, true )
		
		render.ClearDepth()
		render.Clear( 0, 0, 0, 0 )
		
		render.OverrideAlphaWriteEnable( false )
		render.PopRenderTarget()
		```
    **/
    
    public static function OverrideAlphaWriteEnable(enable:Bool, shouldWrite:Bool):Void;
    
    
    /**
        Removes the current active clipping plane from the clip plane stack.
    **/
    
    public static function PopCustomClipPlane():Void;
    
    
    /**
        Sets the operation to be performed on the stencil buffer values if the compare function was not successful. Note that this takes place before depth testing.
		
		Name | Description
		--- | ---
		`failOperation` | Fail operation function, see STENCILOPERATION_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		This is one of the most useful things stencils can do - not render something to the screen and then allow you to draw with the shape it would have been if it had rendered.You can see in the output screenshot that a partially obscured entity will still write its entire shape to the stencil buffer.
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    -- render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Only draw things if their pixels are currently 1. Currently this is nothing.
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    -- If something fails to draw to the screen, set the pixels it would have drawn to 1
		    -- This includes if it's behind something.
		    render.SetStencilFailOperation( STENCIL_REPLACE )
		
		    -- Draw our entities. They will not draw, because everything is 0
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- If we were to re-draw our entities, we'd see them, but otherwise they're invisible.
		    -- If we flush the screen, we can show the "holes" they've left in the stencil buffer
		    render.ClearBuffersObeyStencil(0, 148, 133, 255, false);
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function SetStencilFailOperation(failOperation:STENCILOPERATION):Void;
    
    
    /**
        Blurs the render target ( or a given texture )
		
		Name | Description
		--- | ---
		`rendertarget` | The texture to blur
		`blurx` | Horizontal amount of blur
		`blury` | Vertical amount of blur
		`passes` | Amount of passes to go through
    **/
    
    public static function BlurRenderTarget(rendertarget:ITexture, blurx:Float, blury:Float, passes:Float):Void;
    
    
    /**
        Changes the cull mode.
		
		Name | Description
		--- | ---
		`cullMode` | Cullmode, see MATERIAL_CULLMODE_ Enums
    **/
    
    public static function CullMode(cullMode:MATERIAL_CULLMODE):Void;
    
    
    /**
        Set's the depth range of the upcoming render.
		
		Name | Description
		--- | ---
		`depthmin` | The minimum depth of the upcoming render. 0.0 = render normally; 1.0 = render nothing
		`depthmax` | The maximum depth of the upcoming render. 0.0 = render everything (through walls); 1.0 = render normally
		
		
		___
		### Lua Examples
		#### Example 1
		Perform a downward screen wipe effect on all opaque objects once the client connects.
		
		```lua 
		local depthmin = 1.0
		
		function GM:PreDrawOpaqueRenderables(bDrawingDepth, bDrawingSkybox)
		
		    render.DepthRange(depthmin, 1.0)
		    
		    if(depthmin > 0.0) then
		        depthmin = depthmin - 0.001
		    end
		    
		end
		```
		
		#### Example 2
		Same effect as above but with a dark shadow skin present where the model is being drawn.
		
		```lua 
		local depthmin = 1.0
		local spawn_copies = {}    -- The shadow copies
		
		function GM:PreDrawOpaqueRenderables(bDrawingDepth, bDrawingSkybox)
		
		    render.DepthRange(depthmin, 1.0)
		    
		    if(!spawn_copies) then return false end
		    
		    if(depthmin > 0.0) then
		        depthmin = depthmin - 0.001
		    else
		    
		        local alpha = 0
		        local valid_copies = 0
		        
		        -- Fade out the shadow copies and remove them
		        for _, spawncopy in pairs(spawn_copies) do
		            if(IsValid(spawncopy)) then
		                alpha = spawncopy:GetColor().a
		                if(alpha > 0) then
		                    spawncopy:SetColor(Color(255, 255, 255, alpha-1))
		                else
		                    spawncopy:Remove()
		                end
		                valid_copies = valid_copies + 1
		            end
		        end
		        
		        -- Nullify table since we aren't using it any more
		        if(valid_copies == 0) then
		            spawn_copies = nil
		        end
		            
		    end
		    
		end
		
		function GM:OnEntityCreated(ent)
		
		    if(!spawn_copies) then return end
		    
		    -- Prevents infinite loop and other errors
		    if(ent:GetClass() != "class C_BaseFlex" &&
		        ent:GetRenderGroup() == RENDERGROUP_OPAQUE &&
		        ent:GetClass() != "gmod_hands") then
		    
		        local mdl = ent:GetModel()
		        
		        -- Check that the entity is a model and not a brush
		        if(mdl && string.find(mdl, ".mdl")) then
		        
		            local spawncopy = ClientsideModel(mdl)
		            
		            -- A material with $ignorez set to 1 works best here
		            spawncopy:SetMaterial("models/overlay_rendertarget")
		            spawncopy:AddEffects(EF_BONEMERGE)
		            spawncopy:SetParent(ent)
		            spawncopy:SetRenderMode(RENDERMODE_TRANSALPHA)
		            spawncopy:SetColor(Color(255, 255, 255, 92))
		            table.insert(spawn_copies, spawncopy)
		            
		        end
		        
		    end
		    
		end
		```
		**Output:**
		
		File:DepthRange example.webm
    **/
    
    public static function DepthRange(depthmin:Float, depthmax:Float):Void;
    
    
    /**
        Returns the fog mode.
		
		`**Returns:** Fog mode, see MATERIAL_FOG_ Enums
    **/
    
    public static function GetFogMode():MATERIAL_FOG;
    
    
    /**
        Sets the mode of fog.
		
		Name | Description
		--- | ---
		`fogMode` | Fog mode, see MATERIAL_FOG_ Enums.
    **/
    
    public static function FogMode(fogMode:MATERIAL_FOG):Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetMorphTex0():ITexture;
    
    
    /**
        Returns the _rt_FullFrameDepth texture. Alias of _rt_PowerOfTwoFB
		
		`**Returns:** 
    **/
    
    public static function GetFullScreenDepthTexture():ITexture;
    
    
    /**
        Overrides the write behaviour of all next rendering operations towards the color channel of the current render target.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the override.
		`shouldWrite` | If the previous argument is true, sets whether the next rendering operations should write to the color channel or not. Has no effect if the previous argument is false.
    **/
    
    public static function OverrideColorWriteEnable(enable:Bool, shouldWrite:Bool):Void;
    
    
    /**
        Resets all values in the stencil buffer to zero.
		
		___
		### Lua Examples
		#### Example 1
		A silly example that shows that nothing will render if you clear the stencil buffer. (From Lex's Stencil Tutorial)
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Refuse to write things to the screen unless that pixel's value is 1
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    -- Set the entire screen to 0
		    render.ClearStencil()
		
		    -- Attempt to draw our entities. Nothing will draw, because nothing in the buffer is 1.
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function ClearStencil():Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetSmallTex1():ITexture;
    
    
    /**
        Copies the currently active Render Target to the specified texture.
		
		Name | Description
		--- | ---
		`Target` | The texture to copy to
		
		
		___
		### Lua Examples
		#### Example 1
		This is how it's used in render.CopyTexture
		
		```lua 
		function render.CopyTexture( from, to )
		
		    local OldRT = render.GetRenderTarget()
		
		        render.SetRenderTarget( from )
		        render.CopyRenderTargetToTexture( to )
		
		    render.SetRenderTarget( OldRT )
		
		end
		```
    **/
    
    public static function CopyRenderTargetToTexture(Target:ITexture):Void;
    
    
    /**
        Draws a quad.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`position` | Origin of the sprite.
		`normal` | The face direction of the quad.
		`width` | The width of the quad.
		`height` | The height of the quad.
		`color` | The color of the quad. Uses the Color structure.
		`rotation` | The rotation of the quad counter-clockwise in degrees around the normal axis. In other words, the quad will always face the same way but this will rotate its corners.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of this function.
		
		```lua 
		local mat = Material( "sprites/sent_ball" )
		local mat2 = Material( "models/wireframe" )
		hook.Add("PostDrawTranslucentRenderables", "DrawQuadEasyExample", function()
		
		    -- Draw a rotating circle under local player
		    render.SetMaterial( mat )
		    local pos = LocalPlayer():GetPos()
		    render.DrawQuadEasy( pos + Vector( 0, 0, 1 ), Vector( 0, 0, 1 ), 64, 64, Color( 255, 255, 255, 200 ), ( CurTime() * 50 ) % 360 )
		
		    -- Draw 3 rotating wireframe quads where local player is looking at
		    render.SetMaterial( mat2 )
		    local tr = LocalPlayer():GetEyeTrace()
		    render.DrawQuadEasy( tr.HitPos + tr.HitNormal, tr.HitNormal, 64, 64, Color( 255, 255, 255 ), ( CurTime() * 50 ) % 360 )
		
		    local dir = tr.HitNormal:Angle()
		    dir:RotateAroundAxis( tr.HitNormal, ( CurTime() * 50 ) % 360 )
		    dir = dir:Up()
		
		    -- We need to call this function twice, once for each side
		    render.DrawQuadEasy( tr.HitPos + tr.HitNormal * 32, dir, 64, 64, Color( 255, 255, 255 ), 0 )
		    render.DrawQuadEasy( tr.HitPos + tr.HitNormal * 32, -dir, 64, 64, Color( 255, 255, 255 ), 0 )
		end )
		```
    **/
    
    public static function DrawQuadEasy(position:Vector, normal:Vector, width:Float, height:Float, color:Color, ?rotation:Float):Void;
    
    
    /**
        Returns the maximum texture height the renderer can handle.
		
		`**Returns:** maxTextureHeight
    **/
    
    public static function MaxTextureHeight():Float;
    
    
    /**
        Clears the current render target and the specified buffers.
		
		**Bug:** BUG This sets the alpha incorrectly for surface library draw calls for render targets. Issue Tracker: #2085
		
		Name | Description
		--- | ---
		`r` | Red component to clear to.
		`g` | Green component to clear to.
		`b` | Blue component to clear to.
		`a` | Alpha component to clear to.
		`clearDepth` | Clear the depth.
		`clearStencil` | Clear the stencil.
    **/
    
    public static function Clear(r:Float, g:Float, b:Float, a:Float, ?clearDepth:Bool, ?clearStencil:Bool):Void;
    
    
    /**
        Draws a line in 3D space.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		**Bug:** BUG Enabling this option will cause the line to ignore the color's alpha. Issue Tracker: #1086
		
		Name | Description
		--- | ---
		`startPos` | Line start position in world coordinates.
		`endPos` | Line end position in world coordinates.
		`color` | The color to be used. Uses the Color structure.
		`writeZ` | Whether or not to consider the Z buffer. If false, the line will be drawn over everything currently drawn, if true, the line will be drawn with depth considered, as if it were a regular object in 3D space. BUG Enabling this option will cause the line to ignore the color's alpha. Issue Tracker: #1086
    **/
    
    public static function DrawLine(startPos:Vector, endPos:Vector, ?color:Color, ?writeZ:Bool):Void;
    
    
    /**
        Calculates the light color of a certain surface.
		
		Name | Description
		--- | ---
		`position` | The position of the surface to get the light from.
		`normal` | The normal of the surface to get the light from.
		
		
		`**Returns:** A vector representing the light at that point.
    **/
    
    public static function ComputeLighting(position:Vector, normal:Vector):Vector;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`enable` | 
    **/
    
    public static function SetWriteDepthToDestAlpha(enable:Bool):Void;
    
    
    /**
        Suppresses or enables any engine lighting for any upcoming render operation.
		
		**Bug:** BUG This does not affect IMeshes. Issue Tracker: #4070
		
		Name | Description
		--- | ---
		`suppressLighting` | True to suppress false to enable.
    **/
    
    public static function SuppressEngineLighting(suppressLighting:Bool):Void;
    
    
    /**
        Sets whether any future render operations will ignore shadow drawing.
		
		Name | Description
		--- | ---
		`newState` | 
    **/
    
    public static function SetShadowsDisabled(newState:Bool):Void;
    
    
    /**
        Returns the currently active render target. 
		
		Instead of saving the current render target using this function and restoring to it later, it is generally better practice to use render.PushRenderTarget and render.PopRenderTarget.
		
		`**Returns:** The currently active Render Target
		
		___
		### Lua Examples
		#### Example 1
		Render something to a different render target, then restore the old render target
		
		```lua 
		local w, h = ScrW(), ScrH()
		local customRt = GetRenderTarget( "some_unique_render_target_nameeeee", w, h, true )
		
		render.PushRenderTarget( customRt )
		    render.Clear( 0, 0, 255, 255, true ) -- fill the background with blue!
		
		    -- draw all props on the blue background!
		    for key, prop in pairs(ents.FindByClass( "prop_physics" )) do
		        prop:DrawModel()
		    end
		
		    -- save the picture to the garrysmod/data folder.  ~format="jpg" will not work.
		    local data = render.Capture({ format = "jpeg", quality = 70, x = 0, y = 0, h = h, w = w })    
		    local pictureFile = file.Open( "RenderTargetsAreAwesome.jpg", "wb", "DATA" )    
		    pictureFile:Write( data )
		    pictureFile:Close()
		render.PopRenderTarget()
		```
    **/
    
    public static function GetRenderTarget():ITexture;
    
    
    /**
        Sets the unsigned 8-bit write bitflag mask to be used for any writes to the stencil buffer.
		
		Name | Description
		--- | ---
		`mask` | The mask bitflag.
		
		
		___
		### Lua Examples
		#### Example 1
		A brief demonstration of masks
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		    --[[
		        To understand this tutorial you need to already understand the basics
		         of binary and bitwise operations.
		
		        It would also help to understand hexadecimal notation, since Lua
		         doesn't have a bitmask input, but I will include binary notation in
		         comments to help.
		    --]]
		
		    -- Reset everything to known good
		    -- render.SetStencilWriteMask( 0xFF )
		    -- render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    -- render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Force everything to fail
		    render.SetStencilCompareFunction( STENCIL_NEVER )
		    -- Save all the things we don't draw
		    render.SetStencilFailOperation( STENCIL_REPLACE )
		
		    -- Set the reference value to 00011100
		    render.SetStencilReferenceValue( 0x1C )
		    -- Set the write mask to 01010101
		    -- Any writes to the stencil buffer will be bitwise ANDed with this mask.
		    -- With our current reference value, the result will be 00010100.
		    render.SetStencilWriteMask( 0x55 )
		
		    -- Fail to draw our entities.
		    for _, ent in ipairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- Set the test mask to 11110011.
		    -- Any time a pixel is read out of the stencil buffer it will be bitwise ANDed with this mask.
		    render.SetStencilTestMask( 0xF3 )
		    -- Set the reference value to 00011100 & 01010101 & 11110011
		    render.SetStencilReferenceValue( 0x10 )
		    -- Pass if the masked buffer value matches the unmasked reference value
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		
		    -- Draw our entities
		    render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
		
		#### Example 2
		A somewhat more complicated mask example
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		    --[[
		        To understand this tutorial you need to already understand the basics
		         of binary and bitwise operations.
		
		        It would also help to understand hexadecimal notation, since Lua
		         doesn't have a bitmask input, but I will include binary notation in
		         comments to help.
		    --]]
		
		    -- Reset everything to known good
		    -- render.SetStencilWriteMask( 0xFF )
		    -- render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    -- render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		
		    -- Only write to the upper 4 bits of the stencil buffer
		    render.SetStencilWriteMask( 0xF0 )
		    -- Wipe the stencil buffer to be 0001111. This is not affected by the write mask.
		    render.ClearStencilBufferRectangle( 0, 0, ScrW(), ScrH(), 0x0F )
		
		    -- Always fail
		    render.SetStencilCompareFunction( STENCIL_NEVER )
		    -- Don't read any bits from the stencil buffer
		    render.SetStencilTestMask( 0x00 )
		    -- When an operation fails, read the current value from the stencil buffer, add
		    --  one to it and then write it back to the buffer
		    -- This is not affected by the test mask, but it is affected by the write mask
		    -- This means we will read 00001111, then write 00010000.
		    -- However, due to the write mask, this won't affect the last four bits already
		    --  in the buffer, resulting in 00011111.
		    render.SetStencilFailOperation( STENCIL_INCR )
		
		    -- Add something interesting to the stencil buffer
		    for _, ent in ipairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		
		    -- Go back to reading the full value from the stencil buffer
		    render.SetStencilTestMask( 0xFF )
		    -- Set the reference value to 00011111
		    render.SetStencilReferenceValue( 0x1F )
		    -- Render the result
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function SetStencilWriteMask(mask:Float):Void;
    
    
    /**
        Sets the color of the fog.
		
		Name | Description
		--- | ---
		`red` | Red channel of the fog color, 0 - 255.
		`green` | Green channel of the fog color, 0 - 255.
		`blue` | Blue channel of the fog color, 0 - 255.
    **/
    
    public static function FogColor(red:Float, green:Float, blue:Float):Void;
    
    
    /**
        Draws a texture over the whole screen.
		
		**Note:** This is a rendering function that requires a 2D rendering context. This means that it will only work in hooks with a 2D rendering context.
		
		Name | Description
		--- | ---
		`tex` | The texture to draw
    **/
    
    public static function DrawTextureToScreen(tex:ITexture):Void;
    
    
    /**
        Returns the render target's power of two texture.
		
		`**Returns:** The power of two texture, which is _rt_poweroftwofb by default.
    **/
    
    public static function GetPowerOfTwoTexture():ITexture;
    
    
    /**
        Updates the texture returned by render.GetFullScreenDepthTexture. 
		
		Silently fails if render.SupportsPixelShaders_2_0 returns false.
    **/
    
    public static function UpdateFullScreenDepthTexture():Void;
    
    
    /**
        Pretty much alias of render.UpdatePowerOfTwoTexture but does not return the texture.
    **/
    
    public static function UpdateRefractTexture():Void;
    
    
    /**
        Sets the unsigned 8-bit test bitflag mask to be used for any stencil testing.
		
		Name | Description
		--- | ---
		`mask` | The mask bitflag.
		
		
		___
		### Lua Examples
		#### Example 1
		A brief demonstration of masks
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		    --[[
		        To understand this tutorial you need to already understand the basics
		         of binary and bitwise operations.
		
		        It would also help to understand hexadecimal notation, since Lua
		         doesn't have a bitmask input, but I will include binary notation in
		         comments to help.
		    --]]
		
		    -- Reset everything to known good
		    -- render.SetStencilWriteMask( 0xFF )
		    -- render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    -- render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Force everything to fail
		    render.SetStencilCompareFunction( STENCIL_NEVER )
		    -- Save all the things we don't draw
		    render.SetStencilFailOperation( STENCIL_REPLACE )
		
		    -- Set the reference value to 00011100
		    render.SetStencilReferenceValue( 0x1C )
		    -- Set the write mask to 01010101
		    -- Any writes to the stencil buffer will be bitwise ANDed with this mask.
		    -- With our current reference value, the result will be 00010100.
		    render.SetStencilWriteMask( 0x55 )
		
		    -- Fail to draw our entities.
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- Set the test mask to 11110011.
		    -- Any time a pixel is read out of the stencil buffer it will be bitwise ANDed with this mask.
		    render.SetStencilTestMask( 0xF3 )
		    -- Set the reference value to 00011100 & 01010101 & 11110011
		    render.SetStencilReferenceValue( 0x10 )
		    -- Pass if the masked buffer value matches the unmasked reference value
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		
		    -- Draw our entities
		    render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
		
		#### Example 2
		A somewhat more complicated mask example
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		    --[[
		        To understand this tutorial you need to already understand the basics
		         of binary and bitwise operations.
		
		        It would also help to understand hexadecimal notation, since Lua
		         doesn't have a bitmask input, but I will include binary notation in
		         comments to help.
		    --]]
		
		    -- Reset everything to known good
		    -- render.SetStencilWriteMask( 0xFF )
		    -- render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    -- render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    -- render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		
		    -- Only write to the upper 4 bits of the stencil buffer
		    render.SetStencilWriteMask( 0xF0 )
		    -- Wipe the stencil buffer to be 0001111. This is not affected by the write mask.
		    render.ClearStencilBufferRectangle( 0, 0, ScrW(), ScrH(), 0x0F )
		
		    -- Always fail
		    render.SetStencilCompareFunction( STENCIL_NEVER )
		    -- Don't read any bits from the stencil buffer
		    render.SetStencilTestMask( 0x00 )
		    -- When an operation fails, read the current value from the stencil buffer, add
		    --  one to it and then write it back to the buffer
		    -- This is not affected by the test mask, but it is affected by the write mask
		    -- This means we will read 00001111, then write 00010000.
		    -- However, due to the write mask, this won't affect the last four bits already
		    --  in the buffer, resulting in 00011111.
		    render.SetStencilFailOperation( STENCIL_INCR )
		
		    -- Add something interesting to the stencil buffer
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		
		    -- Go back to reading the full value from the stencil buffer
		    render.SetStencilTestMask( 0xFF )
		    -- Set the reference value to 00011111
		    render.SetStencilReferenceValue( 0x1F )
		    -- Render the result
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    render.ClearBuffersObeyStencil( 0, 148, 133, 255, false );
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function SetStencilTestMask(mask:Float):Void;
    
    
    /**
        Enables the flashlight projection for the upcoming rendering.
		
		**Bug:** BUG This will leave models lit under specific conditions. Issue Tracker: #3029
		
		Name | Description
		--- | ---
		`enable` | Whether the flashlight mode should be enabled or disabled.
    **/
    
    public static function PushFlashlightMode(?enable:Bool):Void;
    
    
    /**
        Overrides the internal graphical functions used to determine the final color and alpha of a rendered texture. 
		
		See also render.OverrideAlphaWriteEnable.
		
		**Note:** Doing surface library draw calls with alpha set to 0 is a no-op and won't have an effect.
		
		Name | Description
		--- | ---
		`enabled` | true to enable, false to disable. No other arguments are required when disabling.
		`srcBlend` | The source color blend function BLEND_ Enums. Determines how a rendered texture's final color should be calculated.
		`destBlend` | The destination color blend function BLEND_ Enums.
		`blendFunc` | The blend mode used for drawing the color layer BLENDFUNC_ Enums.
		`srcBlendAlpha` | The source alpha blend function BLEND_ Enums. Determines how a rendered texture's final alpha should be calculated.
		`destBlendAlpha` | The destination alpha blend function BLEND_ Enums.
		`blendFuncAlpha` | The blend mode used for drawing the alpha layer BLENDFUNC_ Enums.
    **/
    
    public static function OverrideBlend(enabled:Bool, srcBlend:BLEND, destBlend:BLEND, blendFunc:BLENDFUNC, ?srcBlendAlpha:BLEND, ?destBlendAlpha:BLEND, ?blendFuncAlpha:BLENDFUNC):Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetMoBlurTex1():ITexture;
    
    
    /**
        Similar to render.MaterialOverride, but overrides the materials per index. 
		
		render.MaterialOverride overrides effects of this function.
		
		Name | Description
		--- | ---
		`index` | Starts with 0, the index of the material to override
		`material` | The material to override with
    **/
    
    public static function MaterialOverrideByIndex(index:Float, material:IMaterial):Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public static function GetSmallTex0():ITexture;
    
    
    /**
        Sets the current drawing material to "color_ignorez". 
		
		The material is defined as:
		
		___
		### Lua Examples
		#### Example 1
		Equivalent of this function
		
		```lua 
		render.SetMaterial( Material( "color_ignorez" ) )
		```
    **/
    
    public static function SetColorMaterialIgnoreZ():Void;
    
    
    /**
        Returns the current fog color.
		
		Name | Description
		--- | ---
		`a` | Red part of the color.
		`b` | Green part of the color
		`c` | Blue part of the color
    **/
    
    public static function GetFogColor():RenderLibGetFogColorReturn;
    
    
    /**
        Returns a floating point texture the same resolution as the screen.
		
		**Note:** The gmodscreenspace shader doesn't behave as expected when drawing a floating-point texture to an integer texture (e.g. the default render target). Use an UnlitGeneric material instead
		
		`**Returns:** Render target named "__rt_supertexture1"
    **/
    
    public static function GetSuperFPTex():ITexture;
    
    
    /**
        Sets the stencil value in a specified rect. 
		
		This is not affected by render.SetStencilWriteMask
		
		Name | Description
		--- | ---
		`originX` | X origin of the rectangle.
		`originY` | Y origin of the rectangle.
		`endX` | The end X coordinate of the rectangle.
		`endY` | The end Y coordinate of the rectangle.
		`stencilValue` | Value to set cleared stencil buffer to.
		
		
		___
		### Lua Examples
		#### Example 1
		A basic stencil operation that limits rendering to the centre of the screen
		
		```lua 
		hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()
		
		    -- Reset everything to known good
		    render.SetStencilWriteMask( 0xFF )
		    render.SetStencilTestMask( 0xFF )
		    render.SetStencilReferenceValue( 0 )
		    render.SetStencilCompareFunction( STENCIL_ALWAYS )
		    render.SetStencilPassOperation( STENCIL_KEEP )
		    render.SetStencilFailOperation( STENCIL_KEEP )
		    render.SetStencilZFailOperation( STENCIL_KEEP )
		    render.ClearStencil()
		
		    -- Enable stencils
		    render.SetStencilEnable( true )
		    -- Set the reference value to 1. This is what the compare function tests against
		    render.SetStencilReferenceValue( 1 )
		    -- Refuse to write things to the screen unless that pixel's value is 1
		    render.SetStencilCompareFunction( STENCIL_EQUAL )
		    -- Write a 1 to the centre third of the screen. Because we cleared it earlier, everything is currently 0
		    local w, h = ScrW() / 3, ScrH() / 3
		    local x_start, y_start = w, h
		    local x_end, y_end = x_start + w, y_start + h
		    render.ClearStencilBufferRectangle( x_start, y_start, x_end, y_end, 1 )
		
		    -- Draw our entities. They will only draw in the area cleared above
		    for _, ent in pairs( ents.FindByClass( "sent_stencil_test" ) ) do
		        ent:DrawModel()
		    end
		
		    -- Let everything render normally again
		    render.SetStencilEnable( false )
		end )
		```
    **/
    
    public static function ClearStencilBufferRectangle(originX:Float, originY:Float, endX:Float, endY:Float, stencilValue:Float):Void;
    
    
    /**
        Clears a render target 
		
		It uses render.Clear then render.SetRenderTarget on the modified render target.
		
		Name | Description
		--- | ---
		`texture` | 
		`color` | The color, see Color structure
    **/
    
    public static function ClearRenderTarget(texture:ITexture, color:Color):Void;
    
    
    /**
        Returns whether the game supports HDR, i.e. if the DirectX level is higher than or equal to 8.
		
		`**Returns:** supportsHDR
    **/
    
    public static function SupportsHDR():Bool;
    
    
    /**
        Calculates the lighting caused by dynamic lights for the specified surface.
		
		Name | Description
		--- | ---
		`position` | The position to sample from.
		`normal` | The normal of the surface.
		
		
		`**Returns:** A vector representing the light at that point.
    **/
    
    public static function ComputeDynamicLighting(position:Vector, normal:Vector):Vector;
    
    
    /**
        Pops the last render target and viewport from the RT stack and sets them as the current render target and viewport. 
		
		This is should be called to restore the previous render target and viewport after a call to render.PushRenderTarget.
    **/
    
    public static function PopRenderTarget():Void;
    
    
    /**
        Performs a render trace and returns the color of the surface hit, this uses a low res version of the texture.
		
		Name | Description
		--- | ---
		`startPos` | The start position to trace from.
		`endPos` | The end position of the trace.
		
		
		`**Returns:** color
    **/
    
    public static function GetSurfaceColor(startPos:Vector, endPos:Vector):Vector;
    
    
    /**
        Renders the HUD on the screen.
		
		Name | Description
		--- | ---
		`x` | X position for the HUD draw origin.
		`y` | Y position for the HUD draw origin.
		`w` | Width of the HUD draw.
		`h` | Height of the HUD draw.
    **/
    
    public static function RenderHUD(x:Float, y:Float, w:Float, h:Float):Void;
    
    
    /**
        Adds a beam segment to the beam started by render.StartBeam.
		
		Name | Description
		--- | ---
		`startPos` | Beam start position.
		`width` | The width of the beam.
		`textureEnd` | The end coordinate of the texture used.
		`color` | The color to be used. Uses the Color structure.
    **/
    
    public static function AddBeam(startPos:Vector, width:Float, textureEnd:Float, color:Color):Void;
    
    
    /**
        
    **/
    
    public static function PerformFullScreenStencilOperation():Void;
    
    

}


@:multiReturn extern class RenderLibReadPixelReturn {
var a:Float;
var b:Float;
var c:Float;

}
@:multiReturn extern class RenderLibGetFogDistancesReturn {
var a:Float;
var b:Float;
var c:Float;

}
@:multiReturn extern class RenderLibGetFogColorReturn {
var a:Float;
var b:Float;
var c:Float;

}

#end