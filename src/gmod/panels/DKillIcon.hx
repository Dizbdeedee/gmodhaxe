package gmod.panels;
#if client

/**
    Uses the killicon library to persistently draw a killicon.
**/
extern class DKillIcon extends Panel {
    /**
        Sets the killicon to be displayed. You should call DKillIcon:SizeToContents following this. 
		
		Killicons can be added with killicon.Add and killicon.AddFont.
		
		Name | Description
		--- | ---
		`iconName` | The name of the killicon to be displayed.
    **/
    
     
    function SetName(iconName:String):Void;
    /**
        Gets the killicon being shown.
		
		`**Returns:** The name of the killicon currently being displayed.
    **/
    
     
    function GetName():String;
    
}



#end