package gmod.panels;
#if client

/**
    An element providing navigation controls for a DHTML window.
**/
extern class DHTMLControls extends Panel {
    /**
        Sets the color of the navigation buttons.
		
		Name | Description
		--- | ---
		`clr` | A Color structure
    **/
    
     
    function SetButtonColor(clr:Color):Void;
    /**
        ***INTERNAL** 
		
		Basically adds an URL to the history.
		
		Name | Description
		--- | ---
		`url` | 
    **/
    @:deprecated("INTERNAL")
     
    function UpdateHistory(url:String):Void;
    /**
        ***INTERNAL** 
    **/
    @:deprecated("INTERNAL")
     
    function FinishedLoading():Void;
    /**
        ***INTERNAL** 
    **/
    @:deprecated("INTERNAL")
     
    function UpdateNavButtonStatus():Void;
    /**
        ***INTERNAL** 
    **/
    @:deprecated("INTERNAL")
     
    function StartedLoading():Void;
    /**
        Sets the DHTML element to control with these DHTMLControls.
		
		Name | Description
		--- | ---
		`dhtml` | The HTML panel
    **/
    
     
    function SetHTML(dhtml:Panel):Void;
    
}



#end