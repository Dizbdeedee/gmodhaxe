package gmod.panels;
#if client

/**
    A preset manager, found at the top of almost every default tool's C-menu. 
	
	This control only exists in Sandbox derived gamemodes.
**/
extern class ControlPresets extends Panel {
    /**
        Set the name label text.
		
		Name | Description
		--- | ---
		`name` | The text to put in the label
    **/
    
     
    function SetLabel(name:String):Void;
    /**
        Adds a convar to be managed by this control.
		
		Name | Description
		--- | ---
		`convar` | The convar to add.
    **/
    
     
    function AddConVar(convar:String):Void;
    /**
        Get a list of all Console Variables being managed by this panel.
		
		`**Returns:** numbered table of convars
    **/
    
     
    function GetConVars():AnyTable;
    
}



#end