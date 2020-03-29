package gmod.panels;
#if client

/**
    An editable DLabel, double click on it to edit. 
	
	This is used in the spawnmenu spawnlist headers.
**/
extern class DLabelEditable extends DLabel {
    /**
        A hook called when the player presses Enter (i.e. the finished editing the label) and the text has changed. 
		
		Allows you to override/modify the text that will be set to display.
		
		Name | Description
		--- | ---
		`txt` | The original user input text
		
		
		`**Returns:** If provided, will override the text that will be applied to the label itself.
    **/
    
    @:hook 
    function OnLabelTextChanged(txt:String):String;
    
}



#end