package gmod.panels;
#if client

/**
    A derivative of the DModelPanel in which the user may modify the perspective of the model with their mouse and keyboard by clicking and dragging. 
	
	The keyboard keys W S A D ↑ ↓ ← → Space and Ctrl can be used when the right mouse is held down, with ⇧ Shift acting as a speed multiplier. When the left mouse is used, the Shift key holds the current y angle steady. 
	
	 This is used by IconEditor for modifying spawn icons.
**/
extern class DAdjustableModelPanel extends DModelPanel {
    /**
        Gets whether mouse and keyboard-based adjustment of the perspective has been enabled. See DAdjustableModelPanel:SetFirstPerson for more information.
		
		`**Returns:** Whether first person controls are enabled. See DAdjustableModelPanel: FirstPersonControls.
    **/
    
     
    function GetFirstPerson():Bool;
    /**
        ***INTERNAL** 
		
		Used by the panel to perform mouse capture operations when adjusting the model.
    **/
    @:deprecated("INTERNAL")
     
    function CaptureMouse():Void;
    /**
        ***INTERNAL** 
		
		Used to adjust the perspective in the model panel via the keyboard, when the right mouse button is used.
    **/
    @:deprecated("INTERNAL")
     
    function FirstPersonControls():Void;
    /**
        Enables mouse and keyboard-based adjustment of the perspective. 
		
		This is set to true automatically each time mouse capture is enabled, and hence doesn't serve as a usable setting, other than to disable this functionality after the PANEL:OnMousePressed event.
		
		Name | Description
		--- | ---
		`enable` | Whether to enable/disable first person controls. See DAdjustableModelPanel: FirstPersonControls.
    **/
    
     
    function SetFirstPerson(enable:Bool):Void;
    
}



#end