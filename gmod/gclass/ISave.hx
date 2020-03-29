package gmod.gclass;


/**
    The object used in the saverestore library, mainly in saverestore.AddSaveHook. 
	
	It allows you to write blocks directly into the save game files used by Half-Life 2 save system when such save is being saved.
**/
extern class ISave {
    
    /**
        Writes a floating point number to the save object.
		
		Name | Description
		--- | ---
		`float` | The floating point number to write.
    **/
    
    public function WriteFloat(float:Float):Void;
    
    
    /**
        Writes a string to the save object.
		
		Name | Description
		--- | ---
		`str` | The string to write. Maximum length is 1024.
    **/
    
    public function WriteString(str:String):Void;
    
    
    /**
        Writes an Angle to the save object.
		
		Name | Description
		--- | ---
		`ang` | The angle to write.
    **/
    
    public function WriteAngle(ang:Angle):Void;
    
    
    /**
        Writes a boolean to the save object.
		
		Name | Description
		--- | ---
		`bool` | The boolean to write.
    **/
    
    public function WriteBool(bool:Bool):Void;
    
    
    /**
        Writes a Vector to the save object.
		
		Name | Description
		--- | ---
		`vec` | The vector to write.
    **/
    
    public function WriteVector(vec:Vector):Void;
    
    
    /**
        Writes an integer number to the save object.
		
		Name | Description
		--- | ---
		`int` | The integer number to write.
    **/
    
    public function WriteInt(int:Float):Void;
    
    
    /**
        Ends current data block started with ISave:StartBlock and returns to the parent block. 
		
		To avoid all sorts of errors, you must end all blocks you start.
    **/
    
    public function EndBlock():Void;
    
    
    /**
        Writes an Entity to the save object.
		
		Name | Description
		--- | ---
		`ent` | The entity to write.
    **/
    
    public function WriteEntity(ent:Entity):Void;
    
    
    /**
        Starts a new block of data that you can write to inside current block. Blocks must be ended with ISave:EndBlock.
		
		Name | Description
		--- | ---
		`name` | Name of the new block. Used for determining which block is which, returned by IRestore: StartBlock during game load.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		saverestore.AddSaveHook( "HookNameHere", function( save )
		    save:StartBlock( "Test" )
		        save:WriteString( "myawesomestring" )
		    save:EndBlock()
		end )
		```
    **/
    
    public function StartBlock(name:String):Void;
    
    
}



