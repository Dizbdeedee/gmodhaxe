package gmod.gclass;


/**
    The object used in the saverestore library, mainly in saverestore.AddRestoreHook. 
	
	It allows you to read blocks directly from the save game files used by Half-Life 2 save system when such save is loaded.
**/
extern class IRestore {
    
    /**
        Reads next bytes from the restore object as an integer number.
		
		`**Returns:** The read integer number.
    **/
    
    function ReadInt():Float;
    
    
    /**
        Reads next bytes from the restore object as a Vector.
		
		`**Returns:** The read vector.
    **/
    
    function ReadVector():Vector;
    
    
    /**
        Reads next bytes from the restore object as an Entity.
		
		`**Returns:** The entity that has been read.
    **/
    
    function ReadEntity():Entity;
    
    
    /**
        Reads next bytes from the restore object as a string.
		
		`**Returns:** The read string. Maximum length is 1024.
    **/
    
    function ReadString():String;
    
    
    /**
        Reads next bytes from the restore object as an Angle.
		
		`**Returns:** The angle that has been read
    **/
    
    function ReadAngle():Angle;
    
    
    /**
        Reads next bytes from the restore object as a floating point number.
		
		`**Returns:** The read floating point number.
    **/
    
    function ReadFloat():Float;
    
    
    /**
        Reads next bytes from the restore object as a boolean.
		
		`**Returns:** The boolean that has been read
    **/
    
    function ReadBool():Bool;
    
    
    /**
        Ends current data block started with IRestore:StartBlock and returns to the parent block. 
		
		To avoid all sorts of errors, you must end all blocks you start.
    **/
    
    function EndBlock():Void;
    
    
    /**
        Loads next block of data to be read inside current block. Blocks must be ended with IRestore:EndBlock.
		
		`**Returns:** The name of the next data block to be read.
		
		___
		### Lua Examples
		#### Example 1
		Example usage.
		
		```lua 
		saverestore.AddRestoreHook( "HookNameHere", function( save )
		    local name = save:StartBlock()
		    local myval = save:ReadString()
		    save:EndBlock()
		
		    print( name, myval )
		end )
		```
		**Output:**
		
		With example from ISave: StartBlock Test myawesomestring
    **/
    
    function StartBlock():String;
    
    
}



