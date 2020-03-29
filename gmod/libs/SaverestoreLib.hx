package gmod.libs;


/**
    The saverestore library contains functions relating to the singleplayer save system built into the game.
**/
@:native("_G.saverestore")extern class SaverestoreLib {
    
    /**
        ***INTERNAL** 
		
		Called by the engine just before saverestore.LoadGlobal is.
    **/
    @:deprecated("INTERNAL")
    public static function PreRestore():Void;
    
    
    /**
        Loads a variable from the save game file that is being loaded. 
		
		Variables will be read in the save order you have saved them.
		
		Name | Description
		--- | ---
		`save` | The restore object to read variables from.
		
		
		`**Returns:** The variable that was read, if any.
    **/
    
    public static function ReadVar(save:IRestore):Dynamic;
    
    
    /**
        ***INTERNAL** 
		
		Called by the engine just before saverestore.SaveGlobal is.
    **/
    @:deprecated("INTERNAL")
    public static function PreSave():Void;
    
    
    /**
        Write a table to a save game file that is being saved.
		
		Name | Description
		--- | ---
		`table` | The table to write
		`save` | The save object to write the table to.
    **/
    
    public static function WriteTable(table:AnyTable, save:ISave):Void;
    
    
    /**
        Reads a table from the save game file that is being loaded.
		
		Name | Description
		--- | ---
		`save` | The restore object to read the table from.
		
		
		`**Returns:** The table that has been read, if any
    **/
    
    public static function ReadTable(save:IRestore):AnyTable;
    
    
    /**
        Writes a variable to the save game file that is being saved.
		
		Name | Description
		--- | ---
		`value` | The value to save. It can be one of the following types: number, boolean, string, Entity, Angle, Vector or table.
		`save` | The save object to write the variable to.
    **/
    
    public static function WriteVar(value:Dynamic, save:ISave):Void;
    
    
    /**
        Loads Entity:GetTable from the save game file that is being loaded and merges it with the given entitys Entity:GetTable.
		
		Name | Description
		--- | ---
		`ent` | The entity which will receive the loaded values from the save.
		`save` | The restore object to read the Entity: GetTable from.
    **/
    
    public static function LoadEntity(ent:Entity, save:IRestore):Void;
    
    
    /**
        Saves entitys Entity:GetTable to the save game file that is being saved.
		
		Name | Description
		--- | ---
		`ent` | The entity to save Entity: GetTable of.
		`save` | The save object to save Entity: GetTable to.
    **/
    
    public static function SaveEntity(ent:Entity, save:ISave):Void;
    
    
    /**
        Adds a restore/load hook for the Half-Life 2 save system.
		
		Name | Description
		--- | ---
		`identifier` | The unique identifier for this hook.
		`callback` | The function to be called when an engine save is being loaded. It has one argument: IRestore save - The restore object to be used to read data from save file that is being loaded You can also use those functions to read data: saverestore.ReadVar saverestore.ReadTable saverestore.LoadEntity
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage.
		
		```lua 
		saverestore.AddRestoreHook( "HookNameHere", function( save )
		    PrintTable( saverestore.ReadTable( save ) )
		end )
		```
		**Output:**
		
		If you used example from saverestore. AddSaveHook 1 = Test
    **/
    
    public static function AddRestoreHook(identifier:String, callback:Function):Void;
    
    
    /**
        ***INTERNAL** 
		
		Called by engine when a save is being saved. 
		
		This handles saving gamemode and calls all of the hooks added with saverestore.AddSaveHook.
		
		Name | Description
		--- | ---
		`save` | The save object to write data into the save file.
    **/
    @:deprecated("INTERNAL")
    public static function SaveGlobal(save:ISave):Void;
    
    
    /**
        Adds a save hook for the Half-Life 2 save system. You can this to carry data through level transitions in Half-Life 2.
		
		Name | Description
		--- | ---
		`identifier` | The unique identifier for this hook.
		`callback` | The function to be called when an engine save is being saved. It has one argument: ISave save - The save object to be used to write data to the save file that is being saved You can also use those functions to save data: saverestore.WriteVar saverestore.WriteTable saverestore.SaveEntity
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage.
		
		```lua 
		saverestore.AddSaveHook( "HookNameHere", function( save )
		    saverestore.WriteTable( { "test" }, save )
		end )
		```
    **/
    
    public static function AddSaveHook(identifier:String, callback:Function):Void;
    
    
    /**
        Returns how many writable keys are in the given table.
		
		Name | Description
		--- | ---
		`table` | The table to test.
		
		
		`**Returns:** The number of keys that can be written with saverestore. WriteTable.
    **/
    
    public static function WritableKeysInTable(table:AnyTable):Float;
    
    
    /**
        ***INTERNAL** 
		
		Called by engine when a save is being loaded. 
		
		This handles loading gamemode and calls all of the hooks added with saverestore.AddRestoreHook.
		
		Name | Description
		--- | ---
		`save` | The restore object to read data from the save file with.
    **/
    @:deprecated("INTERNAL")
    public static function LoadGlobal(save:IRestore):Void;
    
    

}



