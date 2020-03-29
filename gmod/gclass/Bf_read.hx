package gmod.gclass;
#if client

/**
    This is the object passed to usermessage.Hook when a message is received. It contains each value stored in the message in sequential order. You should read values from it in the order you wrote them.
**/
extern class Bf_read {
    
    /**
        Reads a signed char and returns a number from -127 to 127 representing the ascii value of that char.
		
		`**Returns:** asciiVal
    **/
    
    public function ReadChar():Float;
    
    
    /**
        Reads a special encoded vector from the bitstream and returns it, this function is not suitable to send normals.
		
		`**Returns:** vec
    **/
    
    public function ReadVector():Vector;
    
    
    /**
        Reads a short representing an entity index and returns the matching entity handle.
		
		`**Returns:** ent
    **/
    
    public function ReadEntity():Entity;
    
    
    /**
        Reads a 4 byte long from the bitstream and returns it.
		
		`**Returns:** int
    **/
    
    public function ReadLong():Float;
    
    
    /**
        Reads a null terminated string from the bitstream.
		
		`**Returns:** str
    **/
    
    public function ReadString():String;
    
    
    /**
        Reads an returns an angle object from the bitstream.
		
		`**Returns:** The read angle
    **/
    
    public function ReadAngle():Angle;
    
    
    /**
        Reads a special encoded vector normal from the bitstream and returns it, this function is not suitable to send vectors that represent a position.
		
		`**Returns:** normal
    **/
    
    public function ReadVectorNormal():Vector;
    
    
    /**
        Rewinds the bitstream so it can be read again.
    **/
    
    public function Reset():Void;
    
    
    /**
        Reads a 4 byte float from the bitstream and returns it.
		
		`**Returns:** float
    **/
    
    public function ReadFloat():Float;
    
    
    /**
        Reads 1 bit an returns a bool representing the bit.
		
		`**Returns:** bit
    **/
    
    public function ReadBool():Bool;
    
    
    /**
        Reads a 2 byte short from the bitstream and returns it.
		
		`**Returns:** short
    **/
    
    public function ReadShort():Float;
    
    
}



#end