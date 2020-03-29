package gmod.panels;
#if client

/**
    A simple Derma Drawer
**/
extern class DDrawer extends Panel {
    /**
        Closes the DDrawer.
    **/
    
     
    function Close():Void;
    /**
        Set the height of DDrawer
		
		Name | Description
		--- | ---
		`Value` | Height of DDrawer. Default is 100.
    **/
    
     
    function SetOpenSize(Value:Float):Void;
    /**
        Opens the DDrawer.
    **/
    
     
    function Open():Void;
    /**
        Set the time (in seconds) for DDrawer to open.
		
		Name | Description
		--- | ---
		`value` | Length in seconds. Default is 0.3
    **/
    
     
    function SetOpenTime(value:Float):Void;
    /**
        Return the Open Time of DDrawer.
		
		`**Returns:** Time in seconds.
    **/
    
     
    function GetOpenTime():Float;
    /**
        Toggles the DDrawer.
    **/
    
     
    function Toggle():Void;
    /**
        Return the Open Size of DDrawer.
		
		`**Returns:** Open size.
    **/
    
     
    function GetOpenSize():Float;
    
}



#end