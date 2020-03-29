package gmod.panels;
#if client

/**
    Simply a DIconLayout which automatically displays all of the Silkicons. Used as a way to get the user to select an icon.
**/
extern class DIconBrowser extends DScrollPanel {
    /**
        Returns whether or not the browser should fill itself with icons.
		
		`**Returns:** 
    **/
    
     
    function GetManual():Bool;
    /**
        ***INTERNAL** 
		
		Set the currently selected file path. Do not use. Use DIconBrowser:SelectIcon instead.
		
		Name | Description
		--- | ---
		`str` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetSelectedIcon(str:String):Void;
    /**
        ***INTERNAL** 
		
		Automatically called to fill the browser with icons. Will not work if DIconBrowser:SetManual is set to true.
    **/
    @:deprecated("INTERNAL")
     
    function Fill():Void;
    /**
        Selects an icon from file path
		
		Name | Description
		--- | ---
		`icon` | The file path of the icon to select. Do not include the "materials/" part.
    **/
    
     
    function SelectIcon(icon:String):Void;
    /**
        Called when the selected icon was changed. Use DIconBrowser:GetSelectedIcon to get the selected icon's filepath.
    **/
    
    @:hook 
    function OnChange():Void;
    /**
        Scrolls the browser to the selected icon
    **/
    
     
    function ScrollToSelected():Void;
    /**
        A simple unused search feature, hides all icons that do not contain given text in their file path.
		
		Name | Description
		--- | ---
		`text` | The text to search for
    **/
    
     
    function FilterByText(text:String):Void;
    /**
        Sets whether or not the browser should automatically fill itself with icons.
		
		Name | Description
		--- | ---
		`manual` | 
    **/
    
     
    function SetManual(manual:Bool):Void;
    /**
        Returns the currently selected icon's file path.
		
		`**Returns:** The currently selected icon's file path.
    **/
    
     
    function GetSelectedIcon():String;
    /**
        ***INTERNAL** 
		
		Use DIconBrowser:OnChange instead
    **/
    @:deprecated("INTERNAL")
     
    function OnChangeInternal():Void;
    
}



#end