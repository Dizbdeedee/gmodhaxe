package gmod.panels;
#if client

/**
    A simple rectangular box, commonly used for parenting other elements to. Pretty much all elements are based on this.
**/
extern class DPanel extends Panel {
    /**
        Sets the background color of the panel.
		
		Name | Description
		--- | ---
		`color` | The background color.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates two empty panels with their background colors set to red and blue team colors.
		
		```lua 
		COLOR_TEAM_RED = Color(255, 64, 64, 255)
		COLOR_TEAM_BLUE = Color(153, 204, 255, 255)
		
		BGPanel1 = vgui.Create("DPanel")
		BGPanel1:SetPos(20, 20)
		BGPanel1:SetSize(200, 200)
		BGPanel1:SetBackgroundColor(COLOR_TEAM_RED)
		        
		BGPanel2 = vgui.Create("DPanel")
		BGPanel2:SetPos(220, 20)
		BGPanel2:SetSize(200, 200)
		BGPanel2:SetBackgroundColor(COLOR_TEAM_BLUE)
		```
    **/
    
     
    function SetBackgroundColor(color:AnyTable):Void;
    /**
        ***Deprecated:** You should use DPanel: GetPaintBackground instead.
		
		Returns whether or not the panel background is being drawn. Alias of [DPanel](https://wiki.garrysmod.com/page/Category:DPanel): [GetPaintBackground](https://wiki.garrysmod.com/page/DPanel/GetPaintBackground).
		
		`**Returns:** True if the panel background is drawn, false otherwise.
    **/
    @:deprecated("You should use DPanel: GetPaintBackground instead.")
     
    function GetDrawBackground():Bool;
    /**
        Returns whether or not the panel background is being drawn.
		
		`**Returns:** True if the panel background is drawn, false otherwise.
    **/
    
     
    function GetPaintBackground():Bool;
    /**
        ***Deprecated:** You should use DPanel: SetPaintBackground instead.
		
		Sets whether or not to draw the panel background. Alias of [DPanel](https://wiki.garrysmod.com/page/Category:DPanel): [SetPaintBackground](https://wiki.garrysmod.com/page/DPanel/SetPaintBackground).
		
		Name | Description
		--- | ---
		`draw` | True to show the panel's background, false to hide it.
    **/
    @:deprecated("You should use DPanel: SetPaintBackground instead.")
     
    function SetDrawBackground(draw:Bool):Void;
    /**
        Returns whether or not the panel is disabled.
		
		`**Returns:** True if the panel is disabled (mouse input disabled and background alpha set to 75), false if its enabled (mouse input enabled and background alpha set to 255).
    **/
    
     
    function GetDisabled():Bool;
    /**
        Sets whether or not to disable the panel.
		
		Name | Description
		--- | ---
		`disabled` | True to disable the panel (mouse input disabled and background alpha set to 75), false to enable it (mouse input enabled and background alpha set to 255).
    **/
    
     
    function SetDisabled(disabled:Bool):Void;
    /**
        Sets whether or not to paint/draw the panel background.
		
		Name | Description
		--- | ---
		`paint` | True to show the panel's background, false to hide it.
    **/
    
     
    function SetPaintBackground(paint:Bool):Void;
    /**
        Returns the panel's background color.
		
		**Note:** By default this returns nil even though the default background color is white
		
		`**Returns:** Color of the panel's background.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default panel background color.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 200)
		
		print(BGPanel:GetBackgroundColor())
		```
		**Output:**
		
		nil
    **/
    
     
    function GetBackgroundColor():AnyTable;
    
}



#end