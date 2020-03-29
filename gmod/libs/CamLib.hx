package gmod.libs;
#if client

/**
    This directs all drawing to be done to a certain 2D or 3D plane or position, until the corresponding "End" function is called. 
	
	The matrix functions exist, but are mostly unusable unless you're familiar with the source engine's layout for each aspect.
**/
@:native("_G.cam")extern class CamLib {
    
    /**
        Switches the renderer back to the previous drawing mode from a 3D orthographic rendering context.
    **/
    
    public static function EndOrthoView():Void;
    
    
    /**
        Switches the renderer back to the previous drawing mode from a 3D context.
		
		**Bug:** BUG This will crash the game if there is no context to end. Issue Tracker: #1091
    **/
    
    public static function End3D():Void;
    
    
    /**
        Sets up a new 3D rendering context. Must be finished by cam.End3D. 
		
		For more advanced settings such as an orthographic view, use cam.Start instead.
		
		**Note:** This is a function that starts a 3D rendering context. This means that the only rendering functions will work after it are functions with a 3D rendering context.
		
		**Bug:** BUG Negative x/y values won't work. Issue Tracker: #1995
		
		**Bug:** BUG This will not update current view properties. Issue Tracker: #2682
		
		Name | Description
		--- | ---
		`pos` | Render cam position.
		`angles` | Render cam angles.
		`fov` | Field of view.
		`x` | X coordinate of where to start the new view port.
		`y` | Y coordinate of where to start the new view port.
		`w` | Width of the new viewport.
		`h` | Height of the new viewport.
		`zNear` | Distance to near clipping plane.
		`zFar` | Distance to far clipping plane.
		
		
		___
		### Lua Examples
		#### Example 1
		Set up a 3D rendering environment in a 2D rendering hook to render models on HUD.
		
		```lua 
		hook.Add( "HUDPaint", "3d_camera_example", function()
		    cam.Start3D()
		        for id, ply in pairs( player.GetAll() ) do
		            ply:DrawModel()
		        end
		    cam.End3D()
		end )
		```
		**Output:**
		
		All players can be seen through walls.
    **/
    
    public static function Start3D(?pos:Vector, ?angles:Angle, ?fov:Float, ?x:Float, ?y:Float, ?w:Float, ?h:Float, ?zNear:Float, ?zFar:Float):Void;
    
    
    /**
        Pops the current active rendering matrix from the stack and reinstates the previous one.
    **/
    
    public static function PopModelMatrix():Void;
    
    
    /**
        Sets up a new rendering context. This is an extended version of cam.Start3D and cam.Start2D. Must be finished by cam.End3D or cam.End2D.
		
		**Bug:** BUG This will not update current view properties for 3D contexts. Issue Tracker: #2682
		
		Name | Description
		--- | ---
		`dataTbl` | Render context config. See RenderCamData structure
    **/
    
    public static function Start(dataTbl:RenderCamData):Void;
    
    
    /**
        Sets up a new 2D rendering context. Must be finished by cam.End3D2D.
		
		**Note:** This is a function that starts a 2D rendering context. This means that the only rendering functions will work after it are functions with a 2D rendering context.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		Name | Description
		--- | ---
		`pos` | Origin of the 3D2D context, ie. the top left corner, (0, 0).
		`angles` | Angles of the 3D2D context. +x in the 2d context corresponds to +x of the angle (its forward direction). +y in the 2d context corresponds to -y of the angle (its right direction). If (dx, dy) are your desired (+x, +y) unit vectors, the angle you want is dx:AngleEx(dx:Cross(-dy)).
		`scale` | The scale of the render context. If scale is 1 then 1 pixel in 2D context will equal to 1 unit in 3D context.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		hook.Add("PostDrawOpaqueRenderables", "example", function()
		    local trace = LocalPlayer():GetEyeTrace()
		    local angle = trace.HitNormal:Angle()
		        
		    render.DrawLine( trace.HitPos, trace.HitPos + 8 * angle:Forward(), Color( 255, 0, 0 ), true )
		    render.DrawLine( trace.HitPos, trace.HitPos + 8 * -angle:Right(), Color( 0, 255, 0 ), true )
		    render.DrawLine( trace.HitPos, trace.HitPos + 8 * angle:Up(), Color( 0, 0, 255 ), true )
		        
		    cam.Start3D2D( trace.HitPos, angle, 1 )
		        surface.SetDrawColor( 255, 165, 0, 255 )
		        surface.DrawRect( 0, 0, 8, 8 )
		        render.DrawLine( Vector( 0, 0, 0 ), Vector( 8, 8, 8 ), Color( 100, 149, 237, 255 ), true )
		    cam.End3D2D()
		end )
		```
    **/
    
    public static function Start3D2D(pos:Vector, angles:Angle, scale:Float):Void;
    
    
    /**
        Tells the renderer to ignore the depth buffer and draw any upcoming operation "ontop" of everything that was drawn yet.
		
		Name | Description
		--- | ---
		`ignoreZ` | Determines whenever to ignore the depth buffer or not.
    **/
    
    public static function IgnoreZ(ignoreZ:Bool):Void;
    
    
    /**
        Switches the renderer back to the previous drawing mode from a 3D context. 
		
		This function is an alias of cam.End3D.
		
		**Bug:** BUG This will crash the game if there is no context to end. Issue Tracker: #1091
    **/
    
    public static function End():Void;
    
    
    /**
        Switches the renderer back to the previous drawing mode from a 2D context.
		
		**Bug:** BUG This will crash the game if there is no context to end. Issue Tracker: #1091
    **/
    
    public static function End2D():Void;
    
    
    /**
        Pushes the specified matrix onto the render matrix stack. Unlike opengl, this will replace the current model matrix.
		
		**Bug:** BUG This does not work with cam.Start3D2D in certain hooks. Issue Tracker: #1663
		
		Name | Description
		--- | ---
		`matrix` | The matrix to push.
		
		
		___
		### Lua Examples
		#### Example 1
		Rotates and scales text in the center of the screen.
		
		```lua 
		hook.Add("HUDPaint", "2d rotation test", function()
		    local w, h = ScrW(), ScrH()
		    local t = RealTime()*50
		    
		    local mat = Matrix()
		
		    mat:Translate(Vector(w/2, h/2))
		    mat:Rotate(Angle(0,t,0))
		    mat:Scale(Vector(1,1,1) * math.sin(t/100) *10)
		    mat:Translate(-Vector(w/2, h/2))
		
		    cam.PushModelMatrix(mat)
		        surface.SetFont("DermaDefault")
		        surface.SetTextColor(255, 255, 255, 255)
		        surface.SetTextPos(w/2, h/2)
		        surface.DrawText("LOLLOLOLOL")
		    cam.PopModelMatrix()    
		end)
		```
		
		#### Example 2
		Simple function to draw rotated text
		
		```lua 
		function draw.TextRotated(text, x, y, color, font, ang)
		    render.PushFilterMag(TEXFILTER.ANISOTROPIC)
		    render.PushFilterMin(TEXFILTER.ANISOTROPIC)
		    surface.SetFont(font)
		    surface.SetTextColor(color)
		    surface.SetTextPos(0, 0)
		    local textWidth, textHeight = surface.GetTextSize( text )
		    local rad = -math.rad( ang )
		    x = x - ( math.cos( rad ) * textWidth / 2 + math.sin( rad ) * textHeight / 2 )
		    y = y + ( math.sin( rad ) * textWidth / 2 + math.cos( rad ) * textHeight / 2 )
		    local m = Matrix()
		    m:SetAngles(Angle(0, ang, 0))
		    m:SetTranslation(Vector(x, y, 0))
		    cam.PushModelMatrix(m)
		        surface.DrawText(text)
		    cam.PopModelMatrix()
		    render.PopFilterMag()
		    render.PopFilterMin()
		end
		```
    **/
    
    public static function PushModelMatrix(matrix:VMatrix):Void;
    
    
    /**
        Sets up a new 3d context using orthographic projection.
		
		Name | Description
		--- | ---
		`leftOffset` | The left plane offset.
		`topOffset` | The top plane offset.
		`rightOffset` | The right plane offset.
		`bottomOffset` | The bottom plane offset.
    **/
    
    public static function StartOrthoView(leftOffset:Float, topOffset:Float, rightOffset:Float, bottomOffset:Float):Void;
    
    
    /**
        Shakes the screen at a certain position.
		
		Name | Description
		--- | ---
		`pos` | Origin of the shake.
		`angles` | Angles of the shake.
		`factor` | The shake factor.
    **/
    
    public static function ApplyShake(pos:Vector, angles:Angle, factor:Float):Void;
    
    
    /**
        Switches the renderer back to the previous drawing mode from a 3D2D context.
		
		**Bug:** BUG This will crash the game if there is no context to end. Issue Tracker: #1091
    **/
    
    public static function End3D2D():Void;
    
    
    /**
        Sets up a new 2D rendering context. Must be finished by cam.End2D. 
		
		This is almost always used with a render target from the render library. To set its position use render.SetViewPort with a target already stored.
		
		**Note:** This will put an identity matrix at the top of the model matrix stack. If you are trying to use cam.PushModelMatrix, call it after this function and not before.
		
		**Note:** This is a function that starts a 2D rendering context. This means that the only rendering functions will work after it are functions with a 2D rendering context.
		
		___
		### Lua Examples
		#### Example 1
		Sets the viewport then draws on the view with 2d methods
		
		```lua 
		local oldW, oldH = ScrW(), ScrH()
		render.SetViewPort( 0, 100, 50, 50 )
		cam.Start2D()
		    surface.SetDrawColor( 255, 255, 255 )
		    surface.DrawLine( 10, 10, 100, 100 )
		cam.End2D()
		render.SetViewPort( 0, 0, oldW, oldH )
		```
    **/
    
    public static function Start2D():Void;
    
    

}



#end