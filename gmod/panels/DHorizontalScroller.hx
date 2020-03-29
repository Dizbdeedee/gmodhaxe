package gmod.panels;
#if client

/**
    A very basic horizontal scrollable panel, similar to DScrollPanel. 
	
	Used internally in DPropertySheet.
**/
extern class DHorizontalScroller extends Panel {
    /**
        Same as DDragBase:SetUseLiveDrag
		
		Name | Description
		--- | ---
		`newState` | 
    **/
    
     
    function SetUseLiveDrag(newState:Bool):Void;
    /**
        
		
		`**Returns:** 
    **/
    
     
    function GetOverlap():Float;
    /**
        
		
		Name | Description
		--- | ---
		`newState` | 
    **/
    
     
    function SetShowDropTargets(newState:Bool):Void;
    /**
        Called when the panel is scrolled.
    **/
    
    @:hook 
    function OnDragModified():Void;
    /**
        Adds a panel to the DHorizontalScroller.
		
		Name | Description
		--- | ---
		`pnl` | The panel to add. It will be automatically parented.
    **/
    
     
    function AddPanel(pnl:Panel):Void;
    /**
        Scrolls the DHorizontalScroller to given child panel.
		
		Name | Description
		--- | ---
		`target` | The target child panel. Must be a child of DHorizontalScroller: GetCanvas
    **/
    
     
    function ScrollToChild(target:Panel):Void;
    /**
        Returns the internal canvas panel where the content of DHorizontalScroller are placed on.
		
		`**Returns:** The DDragBase panel.
    **/
    
     
    function GetCanvas():Panel;
    /**
        Controls the spacing between elements of the horizontal scroller.
		
		Name | Description
		--- | ---
		`overlap` | Overlap in pixels. Positive numbers will make elements overlap each other, negative will add spacing.
    **/
    
     
    function SetOverlap(overlap:Float):Void;
    /**
        Same as DDragBase:MakeDroppable. TODO: Transclude or whatever to here?
		
		Name | Description
		--- | ---
		`name` | 
    **/
    
     
    function MakeDroppable(name:String):Void;
    /**
        Sets the scroll amount, automatically clamping the value.
		
		Name | Description
		--- | ---
		`scroll` | The new scroll amount
    **/
    
     
    function SetScroll(scroll:Float):Void;
    /**
        
		
		`**Returns:** 
    **/
    
     
    function GetShowDropTargets():Bool;
    
}



#end