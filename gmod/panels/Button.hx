package gmod.panels;
#if client

/**
    ***Deprecated:**   Only exists for backwards compatibility with Panel: SetActionFunction. Use DButton instead.
	
	Creates a button that players can click on.  Inherits the following functions from DLabel and its parents up to 3 levels deep:
**/
extern class Button extends DLabel {
    /**
        ***Deprecated:** Does nothing at all.
		
		Used in Button to call a function when the button is clicked and in Slider when the value changes.
		
		Name | Description
		--- | ---
		`func` | Function to call when the Button is clicked or the Slider value is changed. Arguments given are: Panel self - The panel itself string action - "Command" on button press, "SliderMoved" on slider move. number val - The new value of the Slider. Will always equal 0 for buttons. number zed - Always equals 0.
    **/
    @:deprecated("Does nothing at all.")
     
    function SetActionFunction(func:Function):Void;
    
}



#end