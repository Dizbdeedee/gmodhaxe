package gmod.libs;
#if client

/**
    Retrieves the control panel for a given stool in the Q menu.
**/
@:native("_G.controlpanel")extern class ControlpanelLib {
    
    /**
        Returns (or creates if not exists) a controlpanel.
		
		Name | Description
		--- | ---
		`name` | The name of the panel.
		
		
		`**Returns:** ControlPanel
		
		___
		### Lua Examples
		#### Example 1
		Get the Contextmenus panel for the weld tool.
		
		```lua 
		local ControlPanel = controlpanel.Get( "Weld" )
		```
    **/
    
    public static function Get(name:String):Panel;
    
    
    /**
        Clears ALL the control panels ( for tools )
    **/
    
    public static function Clear():Void;
    
    

}



#end