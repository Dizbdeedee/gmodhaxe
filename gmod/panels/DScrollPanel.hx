package gmod.panels;
#if client

/**
    DScrollPanel is a VGUI Element similar to DPanel however it has a vertical scrollbar docked to the right which can be used to put more content in a smaller area. DScrollPanels are essentially DPanels with the Scroll Bar. 
	
	This can be used to replace the DPanelList with DPanelList:EnableVerticalScrollbar and get similar functionality as well as using a non-deprecated element. 
	
	 If you would like to paint or edit the elements of the scrollbar use GetVBar. If you want to see if the scrollbar is visible then use the VBar.Enabled variable on the scrollbar's VBar.
	
	**Note:** Panel:DockPadding will not have an effect on children of this panel. Use the function on DScrollPanel:GetCanvas instead.
**/
extern class DScrollPanel extends DPanel {
    /**
        Parents the passed panel to the DScrollPanel's canvas.
		
		Name | Description
		--- | ---
		`pnl` | The panel to add.
    **/
    
     
    function AddItem(pnl:Panel):Void;
    /**
        Returns the vertical scroll bar of the panel.
		
		`**Returns:** The DVScrollBar.
		
		___
		### Lua Examples
		#### Example 1
		Example of styling a scrollbar
		
		```lua 
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(500, 500)
		DFrame:Center()
		DFrame:MakePopup()
		DFrame:SetTitle("Scrollbar Example")
		function DFrame:Paint(w, h)
		    draw.RoundedBox(0, 0, 0, w, h, Color(0, 100, 100))
		end
		
		local DScrollPanel = vgui.Create("DScrollPanel", DFrame)
		DScrollPanel:SetSize(400, 250)
		DScrollPanel:Center()
		
		local sbar = DScrollPanel:GetVBar()
		function sbar:Paint(w, h)
		    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
		end
		function sbar.btnUp:Paint(w, h)
		    draw.RoundedBox(0, 0, 0, w, h, Color(200, 100, 0))
		end
		function sbar.btnDown:Paint(w, h)
		    draw.RoundedBox(0, 0, 0, w, h, Color(200, 100, 0))
		end
		function sbar.btnGrip:Paint(w, h)
		    draw.RoundedBox(0, 0, 0, w, h, Color(100, 200, 0))
		end
		
		local str = ""
		for i = 1, 50 do str = str .. "more space!\n" end
		
		local DLabel = vgui.Create("DLabel", DScrollPanel)
		DLabel:SetText(str)
		DLabel:Center()
		DLabel:SizeToContents()
		```
    **/
    
     
    function GetVBar():Panel;
    /**
        Sets the DScrollPanel's padding. This function appears to be unused.
		
		Name | Description
		--- | ---
		`padding` | The padding of the DScrollPanel.
    **/
    
     
    function SetPadding(padding:Float):Void;
    /**
        ***INTERNAL** 
		
		Sets the canvas of the DScrollPanel.
		
		Name | Description
		--- | ---
		`canvas` | The new canvas
    **/
    @:deprecated("INTERNAL")
     
    function SetCanvas(canvas:Panel):Void;
    /**
        Return the width of the DScrollPanel's canvas.
		
		`**Returns:** The width of the DScrollPanel's canvas
    **/
    
     
    function InnerWidth():Float;
    /**
        Gets the DScrollPanels padding
		
		`**Returns:** DScrollPanels padding
    **/
    
     
    function GetPadding():Float;
    /**
        
    **/
    
     
    function Rebuild():Void;
    /**
        Scrolls to the given child
		
		Name | Description
		--- | ---
		`panel` | The panel to scroll to, must be a child of the DScrollPanel.
    **/
    
     
    function ScrollToChild(panel:Panel):Void;
    /**
        Returns the canvas ( The panel all child panels are parented to ) of the DScrollPanel.
		
		`**Returns:** The canvas
    **/
    
     
    function GetCanvas():Panel;
    
}



#end