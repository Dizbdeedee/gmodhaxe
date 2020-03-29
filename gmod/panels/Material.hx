package gmod.panels;
#if client

/**
    Material is a VGUI element that renders a VMT material.
**/
extern class Material extends Button {
    /**
        Sets the material used by the panel.
		
		**Note:** If the material is not showing up as the correct size, try setting the Material panel's AutoSize variable to false
		
		Name | Description
		--- | ---
		`matname` | The file path of the material to set (relative to "garrysmod/materials/").
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a Material panel and sets the material to a screen space effect.
		
		```lua 
		-- Black background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetSize(200, 200)
		BGPanel:Center()
		BGPanel:SetBackgroundColor(Color(0, 0, 0, 255))
		        
		local mat = vgui.Create("Material", BGPanel)
		mat:SetPos(5, 5)
		mat:SetSize(190, 190)
		
		-- It's not really good to use a models material for VGUI drawing
		-- But it looks good enough for a quick demo
		mat:SetMaterial("models/screenspace")
		
		-- Stretch to fit
		mat.AutoSize = false
		```
    **/
    
     
    function SetMaterial(matname:String):Void;
    /**
        Sets the alpha value of the Material panel.
		
		Name | Description
		--- | ---
		`alpha` | The alpha value, from 0 to 255.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a transparent SWEP icon in the middle of the screen.
		
		```lua 
		local mat = vgui.Create("Material")
		mat:SetSize(200, 200)
		mat:Center()
		mat:SetMaterial("weapons/swep")
		    
		mat:SetAlpha(128)
		```
    **/
    
     
    function SetAlpha(alpha:Float):Void;
    
}



#end