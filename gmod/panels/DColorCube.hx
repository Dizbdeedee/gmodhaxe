package gmod.panels;
#if client

/**
    The DColorCube allows a user to select saturation and value but not hue. Uses HSV colors
**/
extern class DColorCube extends DSlider {
    /**
        ***Deprecated:** 
		
		Appears to do nothing and unused.
		
		Name | Description
		--- | ---
		`hue` | 
    **/
    @:deprecated("")
     
    function SetHue(hue:Float):Void;
    /**
        ***INTERNAL** 
		
		Updates the color cube RGB based on the given x and y position. Similar to DColorCube:TranslateValues.
		
		Name | Description
		--- | ---
		`x` | The x position to set color to/the percentage of saturation to remove from the color (ranges from 0.0 to 1.0).
		`y` | The y position to set color to/the percentage of brightness or value to remove from the color (ranges from 0.0 to 1.0).
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a yellow color cube and updates/prints out the color at the (0.1, 0.6) position.
		
		```lua 
		local color_cube = vgui.Create("DColorCube")
		color_cube:SetSize(200, 200)
		color_cube:Center()
		
		-- Set base color to yellow
		color_cube:SetColor(Color(255, 255, 0))
		
		-- 10% less saturation, 60% darker
		color_cube:UpdateColor(0.1, 0.6)
		
		-- Get new color
		local new_color = color_cube:GetRGB()
		
		-- Print new color
		print("Color( "..new_color.r..", "..new_color.g..", "..new_color.b..", "..new_color.a.." )")
		```
    **/
    @:deprecated("INTERNAL")
     
    function UpdateColor(?x:Float, ?y:Float):Void;
    /**
        Returns the color cube's current set color.
		
		`**Returns:** The set color, uses Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Creates a color cube, sets the color to cyan, adjusts the saturation and value to 50% each, and prints out the final color.
		
		```lua 
		local color_cube = vgui.Create("DColorCube")
		color_cube:SetSize(200, 200)
		color_cube:Center()
		
		-- Set color to cyan
		color_cube:SetColor(Color(0, 255, 255))
		
		-- 50% saturated, 50% valued
		color_cube:TranslateValues(0.5, 0.5)
		
		-- Print set color
		PrintTable(color_cube:GetRGB())
		```
		**Output:**
		
		r	=	63
		b	=	127
		a	=	255
		g	=	127
    **/
    
     
    function GetRGB():Color;
    /**
        ***INTERNAL** 
		
		Updates the color cube RGB based on the given x and y position and returns its arguments. Similar to DColorCube:UpdateColor.
		
		Name | Description
		--- | ---
		`x` | The x position to sample color from/the percentage of saturation to remove from the color (ranges from 0.0 to 1.0).
		`y` | The y position to sample color from/the percentage of brightness or value to remove from the color (ranges from 0.0 to 1.0).
		
		
		Name | Description
		--- | ---
		`a` | The given x position.
		`b` | The given y position.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a green color cube and prints out the color at the (0.2, 0.4) position.
		
		```lua 
		local color_cube = vgui.Create("DColorCube")
		color_cube:SetSize(200, 200)
		color_cube:Center()
		
		-- Set base color to green
		color_cube:SetColor(Color(0, 255, 0))
		
		-- 20% desaturated, 40% darker
		color_cube:TranslateValues(0.2, 0.4)
		
		-- Get new color
		local new_color = color_cube:GetRGB()
		
		-- Update slider position
		color_cube:SetColor(new_color)
		
		-- Print out new color
		print("Color( "..new_color.r..", "..new_color.g..", "..new_color.b..", "..new_color.a.." )")
		```
		**Output:**
		
		Color( 30, 153, 30, 255 )
    **/
    @:deprecated("INTERNAL")
     
    function TranslateValues(x:Float, y:Float):DColorCubeTranslateValuesReturn;
    /**
        Sets the base color and the color used to draw the color cube panel itself.
		
		**Note:** Calling this when using a color that isn't 100% saturated and valued (HSVToColor with saturation and value set to 1) causes the color cube to look inaccurate compared to the color that's returned by methods like DColorCube:GetRGB and DColorCube:OnUserChanged. You should use DColorCube:SetColor instead
		
		Name | Description
		--- | ---
		`color` | The base color to set, uses Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a background panel and color cube that controls the background color. Demonstrates how setting the base RGB explicitly can cause a disconnect between the color represented by the cube and the color output.
		
		```lua 
		-- Background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetSize(200, 200)
		BGPanel:Center()
		
		-- Color cube
		local color_cube = vgui.Create("DColorCube", BGPanel)
		color_cube:SetSize(180, 180)
		color_cube:Center()
		
		-- Base color set to white
		color_cube:SetBaseRGB(Color(255, 255, 255))
		
		-- Called when the color is changed by user input
		function color_cube:OnUserChanged(col)
		
		    -- Update background panel color
		    BGPanel:SetBackgroundColor(col)
		    
		end
		```
		**Output:**
		
		Notice how the output/background color doesn't match the color where the slider is positioned.
    **/
    
     
    function SetBaseRGB(color:Color):Void;
    /**
        Function which is called when the color cube slider is moved (through user input). Meant to be overridden.
		
		Name | Description
		--- | ---
		`color` | The new color, uses Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a color cube which controls the blue saturation and value of a ball image.
		
		```lua 
		-- Frame
		MainFrame = vgui.Create("DFrame")
		MainFrame:SetSize(320, 200)
		MainFrame:Center()
		MainFrame:SetTitle("Choose the saturation and value")
		
		-- Image of a ball
		local ball_img = vgui.Create("DImage", MainFrame)
		ball_img:SetPos(20, 45)
		ball_img:SetSize(128, 128)
		
		ball_img:SetImage("sprites/sent_ball")
		
		-- Color cube
		local color_cube = vgui.Create("DColorCube", MainFrame)
		color_cube:SetPos(160, 40)
		color_cube:SetSize(150, 150)
		
		-- Set color to blue
		color_cube:SetColor(Color(0, 0, 255))
		
		-- Called when slider is moved by user
		function color_cube:OnUserChanged(col)
		    
		    -- Update ball color
		    ball_img:SetImageColor(col)
		
		end
		```
    **/
    
    @:hook 
    function OnUserChanged(color:Color):Void;
    /**
        ***INTERNAL** 
		
		Used internally to set the real "output" color of the panel.
		
		Name | Description
		--- | ---
		`clr` | A Color structure
    **/
    @:deprecated("INTERNAL")
     
    function SetRGB(clr:Color):Void;
    /**
        Returns the base Color set by DColorCube:SetBaseRGB.
		
		`**Returns:** A Color structure
    **/
    
     
    function GetBaseRGB():Color;
    /**
        ***Deprecated:** 
		
		Returns the value set by DColorCube:SetHue.
		
		`**Returns:** 
    **/
    @:deprecated("")
     
    function GetHue():Float;
    /**
        Sets the base color of the color cube and updates the slider position.
		
		Name | Description
		--- | ---
		`color` | The color to set, uses Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Picks the color at the center screen pixel and applies it to the base color of a color cube and its background panel.
		
		```lua 
		-- Get the color of the pixel at the center of the screen
		render.CapturePixels()
		local p_r, p_g, p_b = render.ReadPixel(ScrW()/2, ScrH()/2)
		
		-- Background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos((ScrW()/2)-50, ScrH()/2-100)
		BGPanel:SetSize(100, 100)
		
		-- Color cube
		local color_cube = vgui.Create("DColorCube", BGPanel)
		color_cube:SetSize(75, 75)
		color_cube:Center()
		
		-- Set the color to the center pixel color
		color_cube:SetColor(Color(p_r, p_g, p_b))
		
		-- Change background color too
		BGPanel:SetBackgroundColor(Color(p_r, p_g, p_b))
		```
    **/
    
     
    function SetColor(color:Color):Void;
    
}


@:multiReturn extern class DColorCubeTranslateValuesReturn {
var a:Float;
var b:Float;

}

#end