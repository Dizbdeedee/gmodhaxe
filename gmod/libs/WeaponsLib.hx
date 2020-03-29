package gmod.libs;


/**
    The weapons library allows you to access information about any scripted weapons loaded into the game, as well as register your own weapons.
**/
@:native("_G.weapons")extern class WeaponsLib {
    
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
		See if gmod_tool is based on weapon_base, and whether weapon_base is based on itself.
		
		```lua 
		print(weapons.IsBasedOn("gmod_tool", "weapon_base"), weapons.IsBasedOn("weapon_base", "weapon_base"))
		```
		**Output:**
		
		true false
    **/
    
    public static function IsBasedOn(name:String, base:String):Bool;
    
    
    /**
        Get a copy of weapon table by name. This function also inherits fields from the weapon's base class, unlike weapons.GetStored.
		
		Name | Description
		--- | ---
		`classname` | Class name of weapon to retrieve
		
		
		`**Returns:** The retrieved table or nil
    **/
    
    public static function Get(classname:String):AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Called after all SWEPS have been loaded and runs baseclass.Set on each one. 
		
		You can retrieve all the currently registered SWEPS with weapons.GetList.
		
		**Note:** This is not called after a SWEP auto refresh, and thus the inherited baseclass functions retrieved with baseclass.Get will not be updated
    **/
    @:deprecated("INTERNAL")
    public static function OnLoaded():Void;
    
    
    /**
        Get a list of all the registered SWEPs. This does not include weapons added to spawnmenu manually.
		
		`**Returns:** List of all the registered SWEPs
		
		___
		### Lua Examples
		#### Example 1
		Example structure.
		
		```lua 
		PrintTable( weapons.GetList() )
		```
		**Output:**
		
		1:
			Folder = weapons/weapon_myweapon
			ClassName = weapon_myweapon
			-- The rest of the SWEP table
		2:
			Folder = weapons/weapon_myweapon2
			ClassName = weapon_myweapon2
			-- The rest of the SWEP table
    **/
    
    public static function GetList():AnyTable;
    
    
    /**
        Used to register your SWEP with the engine.
		
		**Bug:** BUG Sub-tables provided in the first argument will not carry over their metatable, and will receive a BaseClass key if the table was merged with the base's. Userdata references, which includes Vectors, Angles, Entities, etc. will not be copied. Pull Request: #1300
		
		Name | Description
		--- | ---
		`swep_table` | The SWEP table
		`classname` | Classname to assign to that swep
    **/
    
    public static function Register(swep_table:AnyTable, classname:String):Void;
    
    
    /**
        Gets the REAL weapon table, not a copy. The produced table does not inherit fields from the weapon's base class, unlike weapons.Get.
		
		**Warning:** Modifying this table will modify what is stored by the weapons library. Take a copy or use weapons.Get to avoid this.
		
		Name | Description
		--- | ---
		`weapon_class` | Weapon class to retrieve weapon table of
		
		
		`**Returns:** The weapon table
    **/
    
    public static function GetStored(weapon_class:String):AnyTable;
    
    

}



