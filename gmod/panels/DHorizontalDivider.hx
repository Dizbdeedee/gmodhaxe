package gmod.panels;
#if client

/**
    Creates an invisible vertical divider between two GUI elements.
**/
extern class DHorizontalDivider extends DPanel {
    /**
        Sets the minimum width of the right side
		
		Name | Description
		--- | ---
		`minWidth` | The minimum width of the right side
    **/
    
     
    function SetRightMin(minWidth:Float):Void;
    /**
        Returns the right side content
		
		`**Returns:** The right side content
    **/
    
     
    function GetRight():Panel;
    /**
        Returns whether or not the player is currently dragging the middle divider bar.
		
		`**Returns:** Whether or not the player is currently dragging the middle divider bar.
    **/
    
     
    function GetDragging():Bool;
    /**
        Sets the minimum width of the left side
		
		Name | Description
		--- | ---
		`minWidth` | The minimum width of the left side
    **/
    
     
    function SetLeftMin(minWidth:Float):Void;
    /**
        Returns the middle content, set by DHorizontalDivider:SetMiddle.
		
		`**Returns:** The middle content
    **/
    
     
    function GetMiddle():Panel;
    /**
        Sets the current/starting width of the left side. 
		
		The width of the right side is automatically calculated by subtracting this from the total width of the DHorizontalDivider.
		
		Name | Description
		--- | ---
		`width` | The current/starting width of the left side
    **/
    
     
    function SetLeftWidth(width:Float):Void;
    /**
        ***INTERNAL** 
		
		Sets whether the player is dragging the divider or not
		
		Name | Description
		--- | ---
		`dragonot` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetDragging(dragonot:Bool):Void;
    /**
        ***INTERNAL** 
		
		Sets the local X coordinate of where the player started dragging the thing
		
		Name | Description
		--- | ---
		`x` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetHoldPos(x:Float):Void;
    /**
        Returns the current width of the left side, set by DHorizontalDivider:SetLeftWidth or by the user.
		
		`**Returns:** The current width of the left side
    **/
    
     
    function GetLeftWidth():Float;
    /**
        Returns the width of the horizontal divider bar, set by DHorizontalDivider:SetDividerWidth.
		
		`**Returns:** The width of the horizontal divider bar
    **/
    
     
    function GetDividerWidth():Float;
    /**
        Sets the right side content
		
		Name | Description
		--- | ---
		`pnl` | The right side content
    **/
    
     
    function SetRight(pnl:Panel):Void;
    /**
        Sets the width of the horizontal divider bar.
		
		Name | Description
		--- | ---
		`width` | The width of the horizontal divider bar.
    **/
    
     
    function SetDividerWidth(width:Float):Void;
    /**
        Returns the minimum width of the right side, set by DHorizontalDivider:SetRightMin.
		
		`**Returns:** The minimum width of the right side
    **/
    
     
    function GetRightMin():Float;
    /**
        ***INTERNAL** 
    **/
    @:deprecated("INTERNAL")
     
    function StartGrab():Void;
    /**
        Sets the left side content of the DHorizontalDivider.
		
		Name | Description
		--- | ---
		`pnl` | The panel to set as the left side
    **/
    
     
    function SetLeft(pnl:Panel):Void;
    /**
        Returns the minimum width of the left side, set by DHorizontalDivider:SetLeftMin.
		
		`**Returns:** The minimum width of the left side
    **/
    
     
    function GetLeftMin():Float;
    /**
        ***INTERNAL** 
		
		Returns the local X coordinate of where the player started dragging the thing
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetHoldPos():Float;
    /**
        Sets the middle content, over the draggable divider bar panel.
		
		Name | Description
		--- | ---
		`middle` | The middle content
    **/
    
     
    function SetMiddle(middle:Panel):Void;
    /**
        Returns the left side content of the DHorizontalDivider
		
		`**Returns:** The content on the left side
    **/
    
     
    function GetLeft():Panel;
    
}



#end