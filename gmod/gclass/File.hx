package gmod.gclass;


/**
    This is the file object. It used used primarily to read or write binary data from files. 
	
	The object is returned by file.Open.
**/
extern class File {
    
    /**
        Dumps the file changes to disk and closes the file handle which makes the handle useless.
    **/
    
    public function Close():Void;
    
    
    /**
        Reads 8 bytes from the file converts them to a double and returns them.
		
		`**Returns:** value
    **/
    
    public function ReadDouble():Float;
    
    
    /**
        Writes a 4byte float to the file.
		
		Name | Description
		--- | ---
		`float` | The float to be written to the file.
    **/
    
    public function WriteFloat(float:Float):Void;
    
    
    /**
        Reads one unsigned 8-bit integer from the file.
		
		`**Returns:** The unsigned 8-bit integer from the file.
    **/
    
    public function ReadByte():Float;
    
    
    /**
        Writes a 16-bit signed integer to the file.
		
		Name | Description
		--- | ---
		`int16` | The 16-bit signed integer to be written to the file.
    **/
    
    public function WriteShort(int16:Float):Void;
    
    
    /**
        Writes an unsigned 16-bit integer to the file.
		
		Name | Description
		--- | ---
		`uint16` | The unsigned 16-bit integer to the file.
    **/
    
    public function WriteUShort(uint16:Float):Void;
    
    
    /**
        Reads a signed 32-bit integer from the file.
		
		`**Returns:** A signed 32-bit integer
    **/
    
    public function ReadLong():Float;
    
    
    /**
        Dumps the file changes to disk and saves the file.
    **/
    
    public function Flush():Void;
    
    
    /**
        Moves the file pointer by the specified amount of chars.
		
		Name | Description
		--- | ---
		`amount` | The amount of chars to skip, can be negative to skip backwards.
		
		
		`**Returns:** amount
    **/
    
    public function Skip(amount:Float):Float;
    
    
    /**
        Writes an unsigned 32-bit integer to the file.
		
		Name | Description
		--- | ---
		`uint32` | The unsigned 32-bit integer to be written to the file.
    **/
    
    public function WriteULong(uint32:Float):Void;
    
    
    /**
        Returns the current position of the file pointer.
		
		`**Returns:** pos
    **/
    
    public function Tell():Float;
    
    
    /**
        Write an 8-bit unsigned integer to the file.
		
		Name | Description
		--- | ---
		`uint8` | The 8-bit unsigned integer to be written to the file.
    **/
    
    public function WriteByte(uint8:Float):Void;
    
    
    /**
        Writes a 32-bit signed integer to the file.
		
		Name | Description
		--- | ---
		`int32` | The 32-bit signed integer to be written to the file.
    **/
    
    public function WriteLong(int32:Float):Void;
    
    
    /**
        Writes a boolean value to the file as one byte.
		
		Name | Description
		--- | ---
		`bool` | The bool to be written to the file.
    **/
    
    public function WriteBool(bool:Bool):Void;
    
    
    /**
        Reads a unsigned 32-bit integer from the file.
		
		`**Returns:** An unsigned 32-bit integer
    **/
    
    public function ReadULong():Float;
    
    
    /**
        Reads 4 bytes from the file converts them to a float and returns them.
		
		`**Returns:** The read value
    **/
    
    public function ReadFloat():Float;
    
    
    /**
        Reads a unsigned 16-bit integer from the file.
		
		`**Returns:** The 16-bit integer
    **/
    
    public function ReadUShort():Float;
    
    
    /**
        Reads one byte of the file and returns whether that byte was not 0.
		
		`**Returns:** val
    **/
    
    public function ReadBool():Bool;
    
    
    /**
        Reads a signed 16-bit integer from the file.
		
		`**Returns:** int16
    **/
    
    public function ReadShort():Float;
    
    
    /**
        Writes the given string into the file.
		
		Name | Description
		--- | ---
		`data` | Binary data to write to the file.
    **/
    
    public function Write(data:String):Void;
    
    
    /**
        Writes a 8byte floating point double to the file.
		
		Name | Description
		--- | ---
		`double` | The double to be written to the file.
    **/
    
    public function WriteDouble(double:Float):Void;
    
    
    /**
        Sets the file pointer to the specified position.
		
		Name | Description
		--- | ---
		`pos` | Pointer position.
    **/
    
    public function Seek(pos:Float):Void;
    
    
    /**
        Returns the contents of the file from the current position up until the end of the current line.
		
		**Note:** This function will look specifically for Line Feed characters \n and will completely ignore Carriage Return characters \r .
		
		**Note:** This function will not return more than 8192 characters.
		
		`**Returns:** The string of data from the read line.
		
		___
		### Lua Examples
		#### Example 1
		Open a file in read only mode, reads a line, tells where the current file pointer is at and then closes the file handle.
		
		```lua 
		local f = file.Open( "cfg/mapcycle.txt", "r", "MOD" )
		print( f:ReadLine() )
		print( f:ReadLine() )
		print( f:Tell() )
		f:Close()
		```
    **/
    
    public function ReadLine():String;
    
    
    /**
        Returns the size of the file in bytes.
		
		`**Returns:** size
    **/
    
    public function Size():Float;
    
    
    /**
        Reads the specified amount of chars and returns them as a binary string.
		
		Name | Description
		--- | ---
		`length` | Reads the specified amount of chars.
		
		
		`**Returns:** data
		
		___
		### Lua Examples
		#### Example 1
		Adapted from extensions/file.lua
		
		```lua 
		function file.Read( filename, path )
		    if ( path == true ) then path = "GAME" end
		    if ( path == nil or path == false ) then path = "DATA" end
		
		    local f = file.Open( filename, "r", path )
		    if ( !f ) then return end
		    local str = f:Read( f:Size() )
		    f:Close()
		    return str or ""
		end
		```
    **/
    
    public function Read(length:Float):String;
    
    
}



