package gmod.panels;
#if client

/**
    DRGBPicker is an interactive panel which can be used to select a color hue. 
	
	See DColorCube for a color picker which controls brightness and saturation. 
	
	 See DColorMixer for a color picker that allows control over hue, saturation, and brightness at once.
**/
extern class DRGBPicker extends DPanel {
    /**
        Returns the color currently set on the color picker.
		
		`**Returns:** The color set on the color picker, see Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default set color.
		
		```lua 
		local color_picker = vgui.Create("DRGBPicker")
		color_picker:SetSize(25, 150)
		color_picker:Center()
		
		print(color_picker:GetRGB())
		```
		**Output:**
		
		255 255 255 255
    **/
    
     
    function GetRGB():Color;
    /**
        ***INTERNAL** 
		
		Returns the color at given position on the internal texture.
		
		Name | Description
		--- | ---
		`x` | The X coordinate on the texture to get the color from
		`y` | The Y coordinate on the texture to get the color from
		
		
		Name | Description
		--- | ---
		`a` | Color structure
		`b` | The X-coordinate clamped to the texture's width.
		`c` | The Y-coordinate clamped to the texture's height.
    **/
    @:deprecated("INTERNAL")
     
    function GetPosColor(x:Float, y:Float):DRGBPickerGetPosColorReturn;
    /**
        Sets the color stored in the color picker.
		
		**Note:** This function is meant to be called internally and will not update the position of the color picker line or call DRGBPicker:OnChange
		
		Name | Description
		--- | ---
		`color` | The color to set, see Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Defines a new function SetColor which will allow proper modification of the color picker directly.
		
		```lua 
		-- Background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetSize(100, 200)
		BGPanel:Center()
		
		-- Color picker
		local color_picker = vgui.Create("DRGBPicker", BGPanel)
		color_picker:SetSize(30, 150)
		color_picker:Center()
		
		-- Custom function that sets color picker position and updates color
		function color_picker:SetColor(col)
		
		    -- Get hue
		    local h = ColorToHSV(col)
		    
		    -- Maximize saturation and vibrance
		    col = HSVToColor(h, 1, 1)
		
		    -- Set color var
		    self:SetRGB(col)
		    
		    -- Calculate position of color picker line
		    local _, height = self:GetSize()
		    self.LastY = height*(1-(h/360))
		    
		    -- Register that a change has occured
		    self:OnChange(self:GetRGB())
		
		end
		
		-- Update background color
		function color_picker:OnChange(col)
		
		    BGPanel:SetBackgroundColor(col)
		
		end
		
		-- Set to random color every second for 10 seconds
		timer.Create("RandomizeColorPicker", 1, 10, function ()
		
		    color_picker:SetColor(Color(math.random(0, 255), math.random(0, 255), math.random(0, 255), 255))
		    
		end)
		```
    **/
    
     
    function SetRGB(color:Color):Void;
    /**
        Function which is called when the cursor is clicked and/or moved on the color picker. Meant to be overridden.
		
		Name | Description
		--- | ---
		`col` | The color that is selected on the color picker ( Color structure form).
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a color picker which controls the color of a ball image.
		
		```lua 
		-- Frame
		MainFrame = vgui.Create("DFrame")
		MainFrame:SetSize(200, 200)
		MainFrame:Center()
		MainFrame:SetTitle("Pick a color")
		
		-- Image of a ball
		local ball_img = vgui.Create("DImage", MainFrame)
		ball_img:SetPos(20, 45)
		ball_img:SetSize(128, 128)
		
		ball_img:SetImage("sprites/sent_ball")
		
		-- Vertical color picker
		local color_picker = vgui.Create("DRGBPicker", MainFrame)
		color_picker:SetPos(165, 30)
		color_picker:SetSize(25, 150)
		
		function color_picker:OnChange(col)
		
		    ball_img:SetImageColor(col)
		    
		end
		```
    **/
    
    @:hook 
    function OnChange(col:Color):Void;
    
}


@:multiReturn extern class DRGBPickerGetPosColorReturn {
var a:Color;
var b:Float;
var c:Float;

}

#end