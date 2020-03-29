package gmod.libs;


/**
    The scripted_ents library allows you to access information about any scripted entities loaded into the game, as well as register your own entities.
**/
@:native("_G.scripted_ents")extern class Scripted_entsLib {
    
    /**
        Checks if name is based on base
		
		Name | Description
		--- | ---
		`name` | Entity's class name to be checked
		`base` | Base class name to be checked
		
		
		`**Returns:** Returns true if class name is based on base, else false.
		
		___
		### Lua Examples
		#### Example 1
		See if gmod_hands is based on base_anim.
		
		```lua 
		print(scripted_ents.IsBasedOn("gmod_hands", "base_anim"))
		```
		**Output:**
		
		true
    **/
    
    public static function IsBasedOn(name:String, base:String):Bool;
    
    
    /**
        Returns a list of all ENT tables which contain either ENT.Spawnable or ENT.AdminSpawnable
		
		`**Returns:** A table of ENT structures
    **/
    
    public static function GetSpawnable():ENT;
    
    
    /**
        Returns a copy of the ENT table for a class, including functions defined by the base class
		
		Name | Description
		--- | ---
		`classname` | The classname of the ENT table to return, can be an alias
		
		
		`**Returns:** entTable
		
		___
		### Lua Examples
		#### Example 1
		Use of PrintTable function to print the contents of base_entity SENT table.
		
		```lua 
		PrintTable(scripted_ents.Get("base_entity"))
		```
    **/
    
    public static function Get(classname:String):AnyTable;
    
    
    /**
        Returns the 'type' of a class, this will one of the following: 'anim', 'ai', 'brush', 'point'.
		
		Name | Description
		--- | ---
		`classname` | The classname to check
		
		
		`**Returns:** type
    **/
    
    public static function GetType(classname:String):String;
    
    
    /**
        Retrieves a member of entity's table.
		
		Name | Description
		--- | ---
		`class` | Entity's class name
		`name` | Name of member to retrieve
		
		
		`**Returns:** The member or nil if failed
    **/
    
    public static function GetMember(_class:String, name:String):Dynamic;
    
    
    /**
        ***INTERNAL** 
		
		Called after all ENTS have been loaded and runs baseclass.Set on each one. 
		
		You can retrieve all the currently registered ENTS with scripted_ents.GetList.
		
		**Note:** This is not called after an ENT auto refresh, and thus the inherited baseclass functions retrieved with baseclass.Get will not be updated
    **/
    @:deprecated("INTERNAL")
    public static function OnLoaded():Void;
    
    
    /**
        Defines an alias string that can be used to refer to another classname
		
		Name | Description
		--- | ---
		`alias` | A new string which can be used to refer to another classname
		`classname` | The classname the alias should refer to
    **/
    
    public static function Alias(alias:String, classname:String):Void;
    
    
    /**
        Returns a copy of the list of all ENT tables registered
		
		`**Returns:** A table of all entities in the following format: (table keys are the classnames) table t - The ENT structure associated with the entity boolean isBaseType - Always true string Base - The entity base (note capital B in the key name) string type - The entity type
    **/
    
    public static function GetList():ENT;
    
    
    /**
        Registers an ENT table with a classname. Reregistering an existing classname will automatically update the functions of all existing entities of that class.
		
		**Bug:** BUG Sub-tables provided in the first argument will not carry over their metatable, and will receive a BaseClass key if the table was merged with the base's. Userdata references, which includes Vectors, Angles, Entities, etc. will not be copied. Pull Request: #1300
		
		Name | Description
		--- | ---
		`ENT` | The ENT table to register
		`classname` | The classname to register
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local ENT = scripted_ents.Get("gmod_button")
		local oldUse = ENT.Use
		function ENT:Use( activator, caller, type, value )
		 print( tostring( self.Entity ).." just got pressed!" )
		 oldUse( self,activator, caller, type, value )
		end
		scripted_ents.Register(ENT,"gmod_button")
		```
    **/
    
    public static function Register(ENT:AnyTable, classname:String):Void;
    
    
    /**
        Returns the actual ENT table for a class. Modifying functions/variables in this table will change newly spawned entities
		
		Name | Description
		--- | ---
		`classname` | The classname of the ENT table to return
		
		
		`**Returns:** entTable
		
		___
		### Lua Examples
		#### Example 1
		Modifies all newly spawned gmod_button's to print a message on use
		
		```lua 
		local ENT = scripted_ents.GetStored("gmod_button").t
		local oldUse = ENT.Use
		function ENT:Use(activator, caller, type, value)
		 print(tostring(self.Entity).." just got pressed!")
		 oldUse(self,activator, caller, type, value)
		end
		```
    **/
    
    public static function GetStored(classname:String):AnyTable;
    
    

}



