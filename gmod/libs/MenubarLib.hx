package gmod.libs;
#if client

/**
    The menubar library.
**/
@:native("_G.menubar")extern class MenubarLib {
    
    /**
        Parents the menubar to the panel and displays the menubar.
		
		Name | Description
		--- | ---
		`pnl` | The panel to parent to
    **/
    
    public static function ParentTo(pnl:Panel):Void;
    
    
    /**
        Checks if the supplied panel is parent to the menubar
		
		Name | Description
		--- | ---
		`pnl` | The panel to check
		
		
		`**Returns:** Is parent or not
    **/
    
    public static function IsParent(pnl:Panel):Bool;
    
    
    /**
        Creates the menu bar ( The bar at the top of the screen when holding C or Q in sandbox ) and docks it to the top of the screen. It will not appear. Calling this multiple times will NOT remove previous panel.
    **/
    
    public static function Init():Void;
    
    

}



#end