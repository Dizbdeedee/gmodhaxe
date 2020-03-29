package gmod.libs;


/**
    The bitwise library contains useful functions for bitwise operations. Make sure you're familiar with Bitwise Operators
**/
@:native("_G.bit")extern class BitLib {
    
    /**
        Returns the bitwise not of the value.
		
		Name | Description
		--- | ---
		`value` | The value to be inverted.
		
		
		`**Returns:** bitwiseNot
    **/
    
    public static function bnot(value:Int):Int;
    
    
    /**
        Swaps the byte order.
		
		Name | Description
		--- | ---
		`value` | The value to be byte swapped.
		
		
		`**Returns:** swapped
    **/
    
    public static function bswap(value:Int):Int;
    
    
    /**
        Returns the bitwise xor of all values specified.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`otherValues` | Values bit xor with. Optional.
		
		
		`**Returns:** bitwiseXOr
    **/
    
    public static function bxor(value:Int, ?otherValues:Int):Int;
    
    
    /**
        Returns the right shifted value.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`shiftCount` | Amounts of bits to shift right by.
		
		
		`**Returns:** shiftedValue
    **/
    
    public static function rshift(value:Int, shiftCount:Int):Int;
    
    
    /**
        Normalizes the specified value and clamps it in the range of a signed 32bit integer.
		
		Name | Description
		--- | ---
		`value` | The value to be normalized.
		
		
		`**Returns:** swapped
    **/
    
    public static function tobit(value:Int):Int;
    
    
    /**
        Returns the arithmetically shifted value.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`shiftCount` | Amounts of bits to shift.
		
		
		`**Returns:** shiftedValue
    **/
    
    public static function arshift(value:Int, shiftCount:Int):Int;
    
    
    /**
        Returns the left shifted value.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`shiftCount` | Amounts of bits to shift left by.
		
		
		`**Returns:** shiftedValue
    **/
    
    public static function lshift(value:Int, shiftCount:Int):Int;
    
    
    /**
        Returns the left rotated value.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`shiftCount` | Amounts of bits to rotate left by.
		
		
		`**Returns:** shiftedValue
    **/
    
    public static function rol(value:Int, shiftCount:Int):Int;
    
    
    /**
        Returns the hexadecimal representation of the number with the specified digits.
		
		Name | Description
		--- | ---
		`value` | The value to be normalized.
		`digits` | The number of digits. Optional
		
		
		`**Returns:** hexString
    **/
    
    public static function tohex(value:Int, ?digits:Int):String;
    
    
    /**
        Returns the right rotated value.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`shiftCount` | Amounts of bits to rotate right by.
		
		
		`**Returns:** shiftedValue
    **/
    
    public static function ror(value:Int, shiftCount:Int):Int;
    
    
    /**
        Performs the bitwise "and" for all values specified.
		
		Name | Description
		--- | ---
		`value` | The value to be manipulated.
		`otherValues` | Values bit to perform bitwise "and" with. Optional.
		
		
		`**Returns:** Result of bitwise "and" operation.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local a = 170    -- 10101010 in binary form
		local b = 146    -- 10010010 in binary form
		print( bit.band( a, b ) )
		```
		**Output:**
		
		130 (10000010 in binary form)
    **/
    
    public static function band(value:Int, ?otherValues:Int):Int;
    
    
    /**
        Returns the bitwise OR of all values specified.
		
		Name | Description
		--- | ---
		`value1` | The first value.
		`...` | Extra values to be evaluated. (must all be numbers)
		
		
		`**Returns:** The bitwise OR result between all numbers.
		
		___
		### Lua Examples
		#### Example 1
		Performs the bitwise OR operation between three values
		
		```lua 
		local a = math.BinToInt("1000")
		local b = math.BinToInt("0100")
		local c = math.BinToInt("0001")
		
		local result = bit.bor(a, b, c)
		
		print(math.IntToBin(result))
		print(result)
		```
		
		#### Example 2
		Adding multiple capabilities to an NPC.
		
		```lua 
		NPC:CapabilitiesAdd( bit.bor( CAP_MOVE_GROUND, CAP_ANIMATEDFACE, CAP_TURN_HEAD ) )
		```
    **/
    
    public static function bor(value1:Int, vargs:Rest<Dynamic>):Int;
    
    

}



