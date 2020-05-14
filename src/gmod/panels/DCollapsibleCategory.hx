package gmod.panels;
#if client

/**
    The collapsible category allows you to create numerous sections of controls, and have the ability to contract/expand them. 
	
	Consider using DCategoryList if you plan on using more than 1 of these.
**/
extern class DCollapsibleCategory extends Panel {
    /**
        ***INTERNAL** 
		
		Used internally to update the "AltLine" property on all "child" panels.
    **/
    @:deprecated("INTERNAL")
     
    function UpdateAltLines():Void;
    /**
        
		
		Name | Description
		--- | ---
		`height` | 
    **/
    
     
    function SetStartHeight(height:Float):Void;
    /**
        Adds a new text button to the collapsible category, like the tool menu in Spawnmenu.
		
		Name | Description
		--- | ---
		`name` | The name of the button
		
		
		`**Returns:** The DButton
    **/
    
     
    function Add(name:String):Panel;
    /**
        Sets the name of the DCollapsibleCategory.
		
		Name | Description
		--- | ---
		`label` | The label/name of the DCollapsibleCategory.
    **/
    
     
    function SetLabel(label:String):Void;
    /**
        Returns whether the DCollapsibleCategory is expanded or not.
		
		`**Returns:** If expanded it will return true.
    **/
    
     
    function GetExpanded():Bool;
    /**
        Doesn't actually do anything.
		
		Name | Description
		--- | ---
		`padding` | 
    **/
    
     
    function SetPadding(padding:Float):Void;
    /**
        
		
		Name | Description
		--- | ---
		`pnl` | 
    **/
    
     
    function SetList(pnl:Panel):Void;
    /**
        Returns whether or not the background should be painted.
		
		`**Returns:** If the background is painted or not
    **/
    
     
    function GetPaintBackground():Bool;
    /**
        Sets the time in seconds it takes to expand the DCollapsibleCategory
		
		Name | Description
		--- | ---
		`time` | The time in seconds it takes to expand
    **/
    
     
    function SetAnimTime(time:Float):Void;
    /**
        
    **/
    
     
    function UnselectAll():Void;
    /**
        Returns the expand/collapse animation time set by DCollapsibleCategory:SetAnimTime.
		
		`**Returns:** The animation time in seconds
    **/
    
     
    function GetAnimTime():Float;
    /**
        Doesn't actually do anything. 
		
		Returns the number set by DCollapsibleCategory:SetPadding.
		
		`**Returns:** 
    **/
    
     
    function GetPadding():Float;
    /**
        Forces the category to open or collapse
		
		Name | Description
		--- | ---
		`expand` | True to open, false to collapse
    **/
    
     
    function DoExpansion(expand:Bool):Void;
    /**
        Sets whether the DCollapsibleCategory is expanded or not upon opening the container. 
		
		You should use DCollapsibleCategory:Toggle or DCollapsibleCategory:DoExpansion instead.
		
		Name | Description
		--- | ---
		`expanded` | Whether it shall be expanded or not by default
    **/
    
     
    function SetExpanded(?expanded:Bool):Void;
    /**
        Sets whether or not the background should be painted.
		
		Name | Description
		--- | ---
		`paint` | 
    **/
    
     
    function SetPaintBackground(paint:Bool):Void;
    /**
        Called by DCollapsibleCategory:Toggle.
    **/
    
     
    function OnToggle():Void;
    /**
        
		
		`**Returns:** 
    **/
    
     
    function GetStartHeight():Float;
    /**
        
		
		`**Returns:** 
    **/
    
     
    function GetList():Panel;
    /**
        Toggles the expanded state of the DCollapsibleCategory.
    **/
    
     
    function Toggle():Void;
    /**
        Sets the contents of the DCollapsibleCategory.
		
		Name | Description
		--- | ---
		`pnl` | The panel, containing the contents for the DCollapsibleCategory, mostly an DScrollPanel
    **/
    
     
    function SetContents(pnl:Panel):Void;
    /**
        ***INTERNAL** 
		
		Internal function that handles the open/close animations.
		
		Name | Description
		--- | ---
		`anim` | 
		`delta` | 
		`data` | 
    **/
    @:deprecated("INTERNAL")
     
    function AnimSlide(anim:AnyTable, delta:Float, data:AnyTable):Void;
    
}



#end