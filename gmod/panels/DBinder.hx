package gmod.panels;
#if client

/**
    Input which can bind a command to a key. Used for binding inputs and outputs of TOOLs.
**/
extern class DBinder extends DButton {
    /**
        Sets the current key bound by the DBinder, and updates the button's text as well as the ConVar.
		
		Name | Description
		--- | ---
		`keyCode` | The key code of the key to bind. See KEY_ Enums.
    **/
    
     
    function SetSelectedNumber(keyCode:KEY):Void;
    /**
        Alias of DBinder:SetSelected.
		
		Name | Description
		--- | ---
		`keyCode` | The key code of the key to bind. See KEY_ Enums.
    **/
    
     
    function SetValue(keyCode:KEY):Void;
    /**
        Called when the player selects a new bind.
		
		Name | Description
		--- | ---
		`iNum` | The new bound key. See input. GetKeyName.
    **/
    
    @:hook 
    function OnChange(iNum:Float):Void;
    /**
        Gets the code of the key currently bound by the DBinder. Same as DBinder:GetSelectedNumber.
		
		`**Returns:** The key code of the bound key. See KEY_ Enums.
    **/
    
     
    function GetValue():KEY;
    /**
        ***INTERNAL** 
		
		Used to set the text of the DBinder to the current key binding, or .
    **/
    @:deprecated("INTERNAL")
     
    function UpdateText():Void;
    /**
        Gets the code of the key currently bound by the DBinder. Same as DBinder:GetValue.
		
		`**Returns:** The key code of the bound key. See KEY_ Enums.
    **/
    
     
    function GetSelectedNumber():KEY;
    
}



#end