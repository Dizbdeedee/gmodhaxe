package gmod.libs;


/**
    The list library allows you add and retrieve values to and from lists. The list library is basically a fancy wrapper for a table, but with much more limited functionality.
**/
@:native("_G.list")extern class ListLib {
    
    /**
        Returns true if the list contains the value. (as a value - not a key) 
		
		For a function that looks for a key and not a value see list.HasEntry.
		
		Name | Description
		--- | ---
		`list` | List to search through
		`value` | The value to test
		
		
		`**Returns:** Returns true if the list contains the value, false otherwise
    **/
    
    public static function Contains(list:String, value:Dynamic):Bool;
    
    
    /**
        Returns the actual table of the list stored at identifier. Modifying this will affect the stored list
		
		Name | Description
		--- | ---
		`identifier` | The list identifier
		
		
		`**Returns:** The actual list
    **/
    
    public static function GetForEdit(identifier:String):AnyTable;
    
    
    /**
        Returns a copy of the list stored at identifier
		
		Name | Description
		--- | ---
		`identifier` | The list identifier
		
		
		`**Returns:** The copy of the list
		
		___
		### Lua Examples
		#### Example 1
		Get every available NPC from the client:
		
		```lua 
		PrintTable( list.Get( "NPC" ) )
		```
    **/
    
    public static function Get(identifier:String):AnyTable;
    
    
    /**
        Adds an item to a named list
		
		Name | Description
		--- | ---
		`identifier` | The list identifier
		`item` | The item to add to the list
		
		
		___
		### Lua Examples
		#### Example 1
		From weapons/gmod_tool/stools/paint.lua
		
		```lua 
		list.Add( "PaintMaterials", "Eye" )
		list.Add( "PaintMaterials", "Smile" )
		list.Add( "PaintMaterials", "Light" )
		```
    **/
    
    public static function Add(identifier:String, item:Dynamic):Void;
    
    
    /**
        Sets a specific position in the named list to a value.
		
		Name | Description
		--- | ---
		`identifier` | The list identifier
		`key` | The key in the list to set
		`item` | The item to set to the list as key
		
		
		___
		### Lua Examples
		#### Example 1
		Adds an NPC to the spawnmenu NPC list with the name "Fisherman", classname of "npc_fisherman" and the default weapon of "weapon_oldmanharpoon"
		
		```lua 
		-- Lost Coast
		list.Set("NPC", "npc_fisherman", {
		    Name = "Fisherman",
		    Class = "npc_fisherman",
		    Weapons = { "weapon_oldmanharpoon" },
		    Category = Category
		})
		```
		
		#### Example 2
		Adds a new "Desktop Widget" to the Context Menu (C Menu). (This is how Player Model selection is added)
		
		```lua 
		list.Set( "DesktopWindows", "My Custom Context Menu Icon", {
		    title = "Context Menu Icon",
		    icon = "icon64/icon.png",
		    init = function( icon, window )
		        --Your code here
		    end
		} )
		```
    **/
    
    public static function Set(identifier:String, key:Dynamic, item:Dynamic):Void;
    
    
    /**
        Returns true if the list contains the given key. 
		
		For a function that looks for values and not keys see list.Contains.
		
		Name | Description
		--- | ---
		`list` | List to search through
		`key` | The key to test
		
		
		`**Returns:** Returns true if the list contains the key, false otherwise
    **/
    
    public static function HasEntry(list:String, key:Dynamic):Bool;
    
    

}



