package gmod.panels;
#if client

/**
    A transparent gray speech bubble panel made up of a rounded box and point coming from the bottom.
**/
extern class DBubbleContainer extends DPanel {
    /**
        Sets the speech bubble position and size along with the dialog point position.
		
		Name | Description
		--- | ---
		`x` | The x position of the dialog point. If this is set to a value greater than half of the set width, the entire bubble container will be moved in addition to the dialog point.
		`y` | The y position of the bubble container. Has no effect unless set to a value greater than the set height + 64 pixels.
		`w` | The width of the bubble container.
		`h` | The height of the bubble container.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a bubble container that properly fits a 200x200 background panel.
		
		```lua 
		-- Length and width of background panel
		local size = 200
		        
		-- Background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetSize(size, size)
		BGPanel:Center()
		
		
		local bubble1 = vgui.Create("DBubbleContainer", BGPanel)
		
		-- x = 100 (Set pointer in the middle of the speech bubble)
		-- y = 0 (Don't adjust height)
		-- w = 180 (20 pixel right margin)
		-- h = 184 (16 pixel bottom margin)
		bubble1:OpenForPos(size/2, 0, size-20, size-16)
		```
    **/
    
     
    function OpenForPos(x:Float, y:Float, w:Float, h:Float):Void;
    
}



#end