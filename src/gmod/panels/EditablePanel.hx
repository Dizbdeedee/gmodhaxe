package gmod.panels;
#if client

/**
    Base panel used by DFrame, this panel is needed so that elements such as the TextEntry can obtain focus.
**/
extern class EditablePanel {
    /**
        ***INTERNAL** 
		
		***Deprecated:** 
		
		Loads controls(positions, etc) from given data. This is what the default options menu uses.
		
		Name | Description
		--- | ---
		`data` | The data to load controls from. Format unknown.
    **/
    @:deprecated("INTERNAL")
     
    function LoadControlsFromString(data:String):Void;
    /**
        Sets the panel that owns this FocusNavGroup to be the root in the focus traversal hierarchy.
		
		Name | Description
		--- | ---
		`state` | 
    **/
    
     
    function SetFocusTopLevel(state:Bool):Void;
    /**
        ***INTERNAL** 
		
		***Deprecated:** 
		
		Similar to Panel:LoadControlsFromString but loads controls from a file.
		
		Name | Description
		--- | ---
		`path` | The path to load the controls from.
    **/
    @:deprecated("INTERNAL")
     
    function LoadControlsFromFile(path:String):Void;
    
}



#end