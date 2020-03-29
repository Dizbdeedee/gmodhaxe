package gmod.libs;
#if client

/**
    The presets library lets you add and modify the pre-set options for scripted tools (selected via the white bar at the top of each tools control panel).
**/
@:native("_G.presets")extern class PresetsLib {
    
    /**
        Removes a preset entry from a preset group.
		
		Name | Description
		--- | ---
		`groupname` | Preset group to remove from
		`name` | Name of preset to remove
    **/
    
    public static function Remove(groupname:String, name:String):Void;
    
    
    /**
        Adds preset to a preset group.
		
		Name | Description
		--- | ---
		`groupname` | The preset group name, usually it's tool class name.
		`name` | Preset name, must be unique.
		`values` | A table of preset console commands.
		
		
		___
		### Lua Examples
		#### Example 1
		A simple faceposer preset.
		
		```lua 
		presets.Add( "face", "Open Eyes", {
		    faceposer_flex0    = "1",
		    faceposer_flex1    = "1",
		    faceposer_flex2    = "0",
		    faceposer_flex3    = "0",
		    faceposer_flex4    = "0",
		    faceposer_flex5    = "0",
		    faceposer_flex6    = "0",
		    faceposer_flex7    = "0",
		    faceposer_flex8    = "0",
		    faceposer_flex9    = "0"
		} )
		```
    **/
    
    public static function Add(groupname:String, name:String, values:AnyTable):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used internally to ask the player if they want to override an already existing preset.
		
		Name | Description
		--- | ---
		`callback` | 
    **/
    @:deprecated("INTERNAL")
    public static function OverwritePresetPrompt(callback:Function):Void;
    
    
    /**
        ***INTERNAL** 
		
		Used internally to tell the player that the name they tried to use in their preset is not acceptable.
    **/
    @:deprecated("INTERNAL")
    public static function BadNameAlert():Void;
    
    
    /**
        Returns a table with preset names and values from a single preset group.
		
		Name | Description
		--- | ---
		`groupname` | Preset group name.
		
		
		`**Returns:** All presets in specified group.
    **/
    
    public static function GetTable(groupname:String):AnyTable;
    
    
    /**
        Returns whether a preset with given name exists or not
		
		Name | Description
		--- | ---
		`type` | The preset group name, usually it's tool class name.
		`name` | Name of the preset to test
		
		
		`**Returns:** true if the preset does exist
    **/
    
    public static function Exists(type:String, name:String):Bool;
    
    
    /**
        Renames preset.
		
		Name | Description
		--- | ---
		`groupname` | Preset group name
		`oldname` | Old preset name
		`newname` | New preset name
    **/
    
    public static function Rename(groupname:String, oldname:String, newname:String):Void;
    
    

}



#end