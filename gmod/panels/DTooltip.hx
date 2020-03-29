package gmod.panels;
#if client

/**
    The panel used internally for tool tips. See Panel:SetTooltip.
**/
extern class DTooltip extends DLabel {
    /**
        Sets up the tooltip for display for given panel and starts the timer.
		
		Name | Description
		--- | ---
		`pnl` | 
    **/
    
     
    function OpenForPanel(pnl:Panel):Void;
    /**
        Forces the tooltip to close. This will remove the panel.
    **/
    
     
    function Close():Void;
    /**
        Used to draw a triangle beneath the DTooltip
		
		**Note:** Requires DTooltip:SetContents, without this it will error
		
		Name | Description
		--- | ---
		`x` | arrow location on the x axis
		`y` | arrow location on the y axis
    **/
    
     
    function DrawArrow(x:Float, y:Float):Void;
    /**
        ***INTERNAL** 
		
		Positions the DTooltip so it doesn't stay in the same draw position.
    **/
    @:deprecated("INTERNAL")
     
    function PositionTooltip():Void;
    /**
        What Panel you want put inside of the DTooltip
		
		**Note:** You can only have one Panel at a time; use Parenting to add more
		
		Name | Description
		--- | ---
		`panel` | Contents
		`bDelete` | If set to true, the panel in the first argument will be automatically removed when DTooltip is closed via DTooltip: Close.
    **/
    
     
    function SetContents(panel:Panel, ?bDelete:Bool):Void;
    
}



#end