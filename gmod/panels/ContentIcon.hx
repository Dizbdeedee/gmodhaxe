package gmod.panels;
#if client

/**
    The spawn icon used for SWEPs and other SENTs, commonly featured as part of the spawn menu. Do note that at least one of your ContentIcon's parents must either be an EditablePanel or derived from it (like a DFrame, for example), else it won't be able to focus and thus be unclickable. 
	
	This control only exists in Sandbox derived gamemodes.
**/
extern class ContentIcon extends DButton {
    /**
        Sets the tool tip and the "nice" name to be displayed by the content icon.
		
		Name | Description
		--- | ---
		`name` | "Nice" name to display.
    **/
    
     
    function SetName(name:String):Void;
    /**
        Sets the internal "name" for the content icon, usually a class name for an entity.
		
		Name | Description
		--- | ---
		`name` | Internal "name" to be used when user left clicks the icon.
    **/
    
     
    function SetSpawnName(name:String):Void;
    /**
        Sets whether the content item is admin only. This makes the icon to display a admin icon in the top left corner of the icon.
		
		Name | Description
		--- | ---
		`adminOnly` | Whether this content should be admin only or not
    **/
    
     
    function SetAdminOnly(adminOnly:Bool):Void;
    /**
        Sets the material to be displayed as the content icon.
		
		Name | Description
		--- | ---
		`path` | Path to the icon to use.
    **/
    
     
    function SetMaterial(path:String):Void;
    /**
        Returns the internal "name" for the content icon, usually a class name for an entity.
		
		`**Returns:** Internal "name" to be used when user left clicks the icon.
    **/
    
     
    function GetSpawnName():String;
    /**
        Returns the content type used to save and restore the content icon in a spawnlist.
		
		`**Returns:** The content type, for example "entity" or "weapon".
    **/
    
     
    function GetContentType():String;
    /**
        Returns a table of weapon classes for the content icon with "NPC" content type to be randomly chosen from when user tries to spawn the NPC.
		
		`**Returns:** A table of weapon classes to be chosen from when user tries to spawn the NPC.
    **/
    
     
    function GetNPCWeapon():AnyTable;
    /**
        Sets a table of weapon classes for the content icon with "NPC" content type to be randomly chosen from when user tries to spawn the NPC.
		
		Name | Description
		--- | ---
		`weapons` | A table of weapon classes to be chosen from when user tries to spawn the NPC.
    **/
    
     
    function SetNPCWeapon(weapons:AnyTable):Void;
    /**
        Sets the content type used to save and restore the content icon in a spawnlist.
		
		Name | Description
		--- | ---
		`type` | The content type, for example "entity" or "weapon"
    **/
    
     
    function SetContentType(type:String):Void;
    /**
        A hook for override, by default does nothing. Called when user right clicks on the content icon, you are supposed to open a DermaMenu here with additional options.
    **/
    
     
    function OpenMenu():Void;
    /**
        Returns the color set by ContentIcon:SetColor
		
		`**Returns:** See Color structure
    **/
    
     
    function GetColor():Color;
    /**
        Sets the color for the content icon. Currently is not used by the content icon panel.
		
		Name | Description
		--- | ---
		`clr` | The color to set. See Color structure
    **/
    
     
    function SetColor(clr:Color):Void;
    
}



#end