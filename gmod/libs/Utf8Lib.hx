package gmod.libs;


/**
    The utf8 library provides basic support for UTF-8 encoding. This library does not provide any support for Unicode other than the handling of the encoding. Any operation that needs the meaning of a character, such as character classification, is outside its scope. 
	
	Unless stated otherwise, all functions that expect a byte position as a parameter assume that the given position is either the start of a byte sequence or one plus the length of the subject string. As in the string library, negative indices count from the end of the string.
**/
@:native("_G.utf8")extern class Utf8Lib {
    
    /**
        Returns the codepoints (as numbers) from all characters in the given string that start between byte position startPos and endPos. It raises an error if it meets any invalid byte sequence. This functions similarly to string.byte.
		
		Name | Description
		--- | ---
		`string` | The string that you will get the code(s) from.
		`startPos` | The starting byte of the string to get the codepoint of.
		`endPos` | The ending byte of the string to get the codepoint of.
		
		
		`**Returns:** The codepoint number(s).
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates usage of the function.
		
		```lua 
		print( utf8.codepoint( "Мёнём", 1, -1 ) )
		```
		**Output:**
		
		1052 1105 1085 1105 1084
    **/
    
    public static function codepoint(string:String, ?startPos:Float, ?endPos:Float):Rest<Dynamic>;
    
    
    /**
        Returns the byte-index of the n'th UTF-8-character after the given startPos (nil if none). startPos defaults to 1 when n is positive and -1 when n is negative. If n is zero, this function instead returns the byte-index of the UTF-8-character startPos lies within.
		
		Name | Description
		--- | ---
		`string` | The string that you will get the byte position from.
		`n` | The position to get the beginning byte position from.
		`startPos` | The offset for n.
		
		
		`**Returns:** Starting byte-index of the given position.
		
		___
		### Lua Examples
		#### Example 1
		Returns the byte-index where the character at the 5th byte begins.
		
		```lua 
		print(utf8.offset("( ͡° ͜ʖ ͡°)", 5))
		```
		**Output:**
		
		7
    **/
    
    public static function offset(string:String, n:Float, ?startPos:Float):Float;
    
    
    /**
        Returns an iterator (like string.gmatch) which returns both the position and codepoint of each utf8 character in the string. It raises an error if it meets any invalid byte sequence.
		
		Name | Description
		--- | ---
		`string` | The string that you will get the codes from.
		
		
		`**Returns:** The iterator (to be used in a for loop).
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates usage of the function.
		
		```lua 
		for p, c in utf8.codes("( ͡° ͜ʖ ͡°)") do
		    print(p,c)
		end
		```
		**Output:**
		
		1    40    
		2    32    
		3    865    
		5    176    
		7    32    
		8    860    
		10    662    
		12    32    
		13    865    
		15    176    
		17    41
    **/
    
    public static function codes(string:String):Function;
    
    
    /**
        Returns the number of UTF-8 sequences in the given string between positions startPos and endPos (both inclusive). If it finds any invalid UTF-8 byte sequence, returns false as well as the position of the first invalid byte.
		
		Name | Description
		--- | ---
		`string` | The string to calculate the length of.
		`startPos` | The starting position to get the length from.
		`endPos` | The ending position to get the length from.
		
		
		Name | Description
		--- | ---
		`a` | The number of UTF-8 characters in the string. If there are invalid bytes, this will be false.
		`b` | The position of the first invalid byte. If there were no invalid bytes, this will be nil.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates output of this function compared to string.len when given a string that contains Russian text.
		
		```lua 
		print( string.len( "Мёнём" ) )
		print( utf8.len( "Мёнём" ) )
		```
		**Output:**
		
		11 5
    **/
    
    public static function len(string:String, ?startPos:Float, ?endPos:Float):Utf8LibLenReturn;
    
    
    /**
        Forces a string to contain only valid UTF-8 data. Invalid sequences are replaced with U+FFFD (the Unicode replacement character). 
		
		This is a lazy way for users to ensure a string contains only valid UTF-8 data.
		
		Name | Description
		--- | ---
		`string` | The string that will become a valid UTF-8 string.
		
		
		`**Returns:** The UTF-8 string.
    **/
    
    public static function force(string:String):String;
    
    
    /**
        Receives zero or more integers, converts each one to its corresponding UTF-8 byte sequence and returns a string with the concatenation of all these sequences.
		
		Name | Description
		--- | ---
		`codepoints` | Unicode code points to be converted in to a UTF-8 string.
		
		
		`**Returns:** UTF-8 string generated from given arguments.
    **/
    
    public static function char(codepoints:Rest<Dynamic>):String;
    
    

}


@:multiReturn extern class Utf8LibLenReturn {
var a:Float;
var b:Float;

}

