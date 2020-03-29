package gmod.libs;


/**
    The string type is a sequence of characters. 
	
	The string library is a standard Lua library which provides functions for the manipulation of strings.[1] 
	
	 In Garry's Mod there are several extra useful functions and features added to this library. Most notably all strings will access this library through the string metatable index function.[2] 
	
	 This means all strings are treated like table objects and the string library as its Meta Table
	
	**Warning:** Making changes to the string metatable is not a good idea unless you know what you are doing. Use the string library instead.
**/
@:native("_G.string")extern class StringLib {
    
    /**
        Inserts commas for every third digit.
		
		Name | Description
		--- | ---
		`InputNumber` | The input number to commafy
		
		
		`**Returns:** Prettystring
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.Comma
		
		```lua 
		MsgN(string.Comma(123456789))
		```
		**Output:**
		
		123,456,789
    **/
    
    public static function Comma(InputNumber:Float):String;
    
    
    /**
        Reverses a string.
		
		Name | Description
		--- | ---
		`str` | The string to be reversed.
		
		
		`**Returns:** reversed string
		
		___
		### Lua Examples
		#### Example 1
		Reverse "abcdef".
		
		```lua 
		print( string.reverse( "abcdef" ) )
		```
		**Output:**
		
		fedcba
    **/
    
    public static function reverse(str:String):String;
    
    
    /**
        Returns everything left of supplied place of that string.
		
		Name | Description
		--- | ---
		`str` | The string to extract from.
		`num` | Amount of chars relative to the beginning (starting from 1).
		
		
		`**Returns:** Returns a string containing a specified number of characters from the left side of a string.
		
		___
		### Lua Examples
		#### Example 1
		Extracts "garry" from "garrys mod" string.
		
		```lua 
		local text = "garrys mod"
		print(string.Left(text, 5))
		```
		**Output:**
		
		garry
    **/
    
    public static function Left(str:String, num:Float):String;
    
    
    /**
        Finds a Pattern in a string.
		
		Name | Description
		--- | ---
		`string` | String which should be searched in for matches.
		`pattern` | The pattern that defines what should be matched.
		`startPosition` | The start index to start the matching from, can be negative to start the match from a position relative to the end.
		
		
		`**Returns:** Matched text(s)
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local toMatch = "this is a sample text"
		print( string.match( toMatch, "sample" ) )
		-- regex works
		print( string.match( toMatch, "^[a-z]" ) )
		print( string.match( toMatch, "^this" ) )
		print( string.match( toMatch, "^..is" ) )
		print( string.match( toMatch, "text$" ) )
		-- entire string
		print( string.match( toMatch, "^.*$" ) )
		-- nil
		print( string.match( toMatch, "this$" ) )
		print( string.match( toMatch, "nil" ) )
		```
    **/
    
    public static function match(string:String, pattern:String, ?startPosition:Float):Rest<Dynamic>;
    
    
    /**
        Returns the given string's characters in their numeric ASCII representation.
		
		Name | Description
		--- | ---
		`string` | The string to get the chars from.
		`startPos` | The first character of the string to get the byte of.
		`endPos` | The last character of the string to get the byte of.
		
		
		`**Returns:** Numerical bytes
		
		___
		### Lua Examples
		#### Example 1
		Prints the first 4 numerical bytes from the string "Hello, World!"
		
		```lua 
		print(string.byte("Hello, World!", 1, 4))
		```
		**Output:**
		
		72 101 108 108
    **/
    
    public static function byte(string:String, ?startPos:Float, ?endPos:Float):Rest<Dynamic>;
    
    
    /**
        Escapes special characters for JavaScript in a string, making the string safe for inclusion in to JavaScript strings.
		
		Name | Description
		--- | ---
		`str` | The string that should be escaped.
		
		
		`**Returns:** The escaped string.
		
		___
		### Lua Examples
		#### Example 1
		Executes JavaScript on a panel using user input safely.
		
		```lua 
		local user_input = "The user's input lives in this variable"
		
		local Panel = vgui.Create( "DHTML" )
		Panel:SetURL( "example.com/something.html" )
		Panel:Center()
		Panel:SetSize( 100, 100 )
		Panel:RunJavascript( "MyJavaScriptFunction('" .. string.JavascriptSafe( user_input ) .. "')" )
		```
    **/
    
    public static function JavascriptSafe(str:String):String;
    
    
    /**
        ***Deprecated:** Use either string.sub(str, index, index) or str[index].
		
		Returns char value from the specified index in the supplied string.         Looks index in the supplied string and returns value of that index.
		
		Name | Description
		--- | ---
		`str` | The string that you will be searching with the supplied index.
		`index` | The index's value of the string to be returned.
		
		
		`**Returns:** str
		
		___
		### Lua Examples
		#### Example 1
		Looks index in the supplied string and returns value of that index.
		
		```lua 
		local char = "ABC"
		print(string.GetChar(char, 2))
		```
		**Output:**
		
		B
    **/
    @:deprecated("Use either string.sub(str, index, index) or str[index].")
    public static function GetChar(str:String, index:Float):String;
    
    
    /**
        Returns the binary bytecode of the given function.
		
		**Note:** This does not work with functions created in C/C++. An error will be thrown if it is
		
		Name | Description
		--- | ---
		`func` | The function to get the bytecode of
		`stripDebugInfo` | True to strip the debug data, false to keep it
		
		
		`**Returns:** Bytecode
    **/
    
    public static function dump(func:Function, ?stripDebugInfo:Bool):String;
    
    
    /**
        Splits the string into a table of strings, separated by the second argument.
		
		Name | Description
		--- | ---
		`Inputstring` | String to split
		`Separator` | Character(s) to split with.
		
		
		`**Returns:** Split table
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local mystring = "This is some text"
		PrintTable( string.Split( mystring, " " ) )
		```
    **/
    
    public static function Split(Inputstring:String, Separator:String):AnyTable;
    
    
    /**
        Returns the path only from a file's path.
		
		Name | Description
		--- | ---
		`Inputstring` | String to get path from.
		
		
		`**Returns:** Path
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.GetPathFromFilename
		
		```lua 
		MsgN(string.GetPathFromFilename("garrysmod/lua/modules/string.lua"))
		```
		**Output:**
		
		"garrysmod/lua/modules/"
    **/
    
    public static function GetPathFromFilename(Inputstring:String):String;
    
    
    /**
        Returns given time in "MM:SS:MS" format.
		
		Name | Description
		--- | ---
		`time` | Time in seconds
		
		
		`**Returns:** Formatted time
		
		___
		### Lua Examples
		#### Example 1
		Example of using this function
		
		```lua 
		print( string.ToMinutesSecondsMilliseconds( 61.128 ) )
		```
		**Output:**
		
		01:01:13
    **/
    
    public static function ToMinutesSecondsMilliseconds(time:Float):String;
    
    
    /**
        Attempts to find the specified substring in a string, uses Patterns by default.
		
		Name | Description
		--- | ---
		`haystack` | The string to search in.
		`needle` | The string to find, can contain patterns if enabled.
		`startPos` | The position to start the search from, can be negative start position will be relative to the end position.
		`noPatterns` | Disable patterns.
		
		
		Name | Description
		--- | ---
		`a` | Starting position of the found text, or nil if the text wasn't found
		`b` | Ending position of found text, or nil if the text wasn't found
		`c` | Matched text for each group if patterns are enabled and used, or nil if the text wasn't found
		
		
		___
		### Lua Examples
		#### Example 1
		Change the word "heck" to "****" in chat messages
		
		```lua 
		hook.Add( "PlayerSay", "NoHeckHere", function( ply, text )
		    local heckStart, heckEnd = string.find( text:lower(), "heck" )
		    if heckStart then
		        local civilText = string.sub( text, 1, heckStart - 1 ) .. "****" .. string.sub( text, heckEnd + 1 )
		        return civilText
		    end
		end )
		```
    **/
    
    public static function find(haystack:String, needle:String, ?startPos:Float, ?noPatterns:Bool):StringLibFindReturn;
    
    
    /**
        This functions main purpose is to replace certain character sequences in a string using Patterns.
		
		Name | Description
		--- | ---
		`string` | String which should be modified.
		`pattern` | The pattern that defines what should be matched and eventually be replaced.
		`replacement` | In case of a string the matches sequence will be replaced with it. In case of a table, the matched sequence will be used as key and the table will tested for the key, if a value exists it will be used as replacement. In case of a function all matches will be passed as parameters to the function, the return value(s) of the function will then be used as replacement.
		`maxReplaces` | Maximum number of replacements to be made.
		
		
		Name | Description
		--- | ---
		`a` | replaceResult
		`b` | replaceCount
		
		
		___
		### Lua Examples
		#### Example 1
		Replaces "hello" with "hi" in the string "hello there!"
		
		```lua 
		string.gsub("hello there!", "hello", "hi")
		```
		**Output:**
		
		hi there!
    **/
    
    public static function gsub(string:String, pattern:String, replacement:String, ?maxReplaces:Float):StringLibGsubReturn;
    
    
    /**
        Removes leading and trailing matches of a string.
		
		Name | Description
		--- | ---
		`Inputstring` | The string to trim.
		`Char` | String to match.
		
		
		`**Returns:** Modified string
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.Trim without second argument.
		
		```lua 
		MsgN(string.Trim(" hi whatsup "))
		```
		**Output:**
		
		"hi whatsup"
    **/
    
    public static function Trim(Inputstring:String, ?Char:String):String;
    
    
    /**
        Returns a sub-string, starting from the character at position StartPos of the string (inclusive), and optionally ending at the character at position EndPos of the string (also inclusive). If EndPos is not given, the rest of the string is returned.
		
		Name | Description
		--- | ---
		`string` | The string you'll take a sub-string out of.
		`StartPos` | The position of the first character that will be included in the sub-string.
		`EndPos` | The position of the last character to be included in the sub-string. It can be negative to count from the end.
		
		
		`**Returns:** The substring.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local mystring = "Some random text"
		print(string.sub(mystring, 1, 4))
		```
		**Output:**
		
		Some
    **/
    
    public static function sub(string:String, StartPos:Float, ?EndPos:Float):String;
    
    
    /**
        Removes the extension of a path.
		
		Name | Description
		--- | ---
		`Inputstring` | The path to change.
		
		
		`**Returns:** Modifiedstring
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.StripExtension
		
		```lua 
		MsgN(string.StripExtension("garrysmod/lua/modules/string.lua"))
		```
		**Output:**
		
		"garrysmod/lua/modules/string"
    **/
    
    public static function StripExtension(Inputstring:String):String;
    
    
    /**
        Fetches a Color type from a string.
		
		Name | Description
		--- | ---
		`Inputstring` | The string to convert from.
		
		
		`**Returns:** The output Color structure
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.ToColor
		
		```lua 
		PrintTable( string.ToColor( "255 0 255 125" ) )
		```
    **/
    
    public static function ToColor(Inputstring:String):Color;
    
    
    /**
        Returns the last n-th characters of the string.
		
		Name | Description
		--- | ---
		`str` | The string to extract from.
		`num` | Amount of chars relative to the end (starting from 1).
		
		
		`**Returns:** Returns a string containing a specified number of characters from the right side of a string.
		
		___
		### Lua Examples
		#### Example 1
		Extracts "mod" from "garrys mod" string.
		
		```lua 
		local text = "garrys mod"
		print( string.Right( text, 3 ) )
		```
		**Output:**
		
		mod
    **/
    
    public static function Right(str:String, num:Float):String;
    
    
    /**
        Returns extension of the file.
		
		Name | Description
		--- | ---
		`file` | String eg. file-path to get the file extensions from.
		
		
		`**Returns:** fileExtension
		
		___
		### Lua Examples
		#### Example 1
		Prints the extension of the file.
		
		```lua 
		print(string.GetExtensionFromFilename("garrysmod/lua/modules/string.lua"))
		```
		**Output:**
		
		lua
    **/
    
    public static function GetExtensionFromFilename(file:String):String;
    
    
    /**
        Replaces all occurrences of the supplied second string.
		
		Name | Description
		--- | ---
		`str` | The string we are seeking to replace an occurrence(s).
		`find` | What we are seeking to replace.
		`replace` | What to replace find with.
		
		
		`**Returns:** string
		
		___
		### Lua Examples
		#### Example 1
		Replaces the word "Garrys" by "Hers".
		
		```lua 
		local text = "Garrys Mod"
		print(string.Replace(text, "Garrys", "Hers"))
		```
		**Output:**
		
		Hers Mod
    **/
    
    public static function Replace(str:String, find:String, replace:String):String;
    
    
    /**
        Removes leading spaces/characters from a string.
		
		Name | Description
		--- | ---
		`str` | String to trim
		`char` | Custom character to remove
		
		
		`**Returns:** Trimmed string
    **/
    
    public static function TrimLeft(str:String, ?char:String):String;
    
    
    /**
        Returns given time in "MM:SS" format.
		
		Name | Description
		--- | ---
		`time` | Time in seconds
		
		
		`**Returns:** Formatted time
		
		___
		### Lua Examples
		#### Example 1
		Example of using this function
		
		```lua 
		print( string.ToMinutesSeconds( 61 ) )
		```
		**Output:**
		
		01:01
    **/
    
    public static function ToMinutesSeconds(time:Float):String;
    
    
    /**
        ***Deprecated:** You really should just use table. concat.
		
		Joins the values of a table together to form a string. 
		
		This is the reverse of string.Explode and is functionally identical to table.concat, but with less features.
		
		Name | Description
		--- | ---
		`separator` | The separator to insert between each piece.
		`pieces` | The table of pieces to concatenate. The keys for these must be numeric and sequential.
		
		
		`**Returns:** Imploded pieces
		
		___
		### Lua Examples
		#### Example 1
		Joins all values of a table with a space
		
		```lua 
		local tab = { "one", "two", "three" }
		
		print( string.Implode( " ", tab ) )
		```
		**Output:**
		
		one two three
    **/
    @:deprecated("You really should just use table. concat.")
    public static function Implode(?separator:String, pieces:AnyTable):String;
    
    
    /**
        Changes any upper-case letters in a string to lower-case letters.
		
		Name | Description
		--- | ---
		`str` | The string to convert.
		
		
		`**Returns:** The original string, with all uppercase letters replaced with their lowercase variants.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( string.lower( "ABCDEFG" ) )
		print( string.lower( "AbCdefG" ) )
		print( string.lower( "abcdefg" ) )
		print( string.lower( "1234567890" ) )
		```
		**Output:**
		
		abcdefg abcdefg abcdefg 1234567890
		
		#### Example 2
		Demonstrates a common use for string.lower - case-insensitive user input.
		
		```lua 
		-- All keys in this table must be lowercase:
		local products = {}
		products.apple = "Buy an apple!"
		products.banana = "Buy a bunch of bananas!"
		products.tomato = "There's also tomatoes."
		
		-- This function is case-insensitive, meaning "APPLE", "apple", and "APPle" are all the same.
		function GetProduct(userinput)
		    return userinput, products[string.lower(userinput)]
		end
		
		-- Demonstration:
		print(GetProduct("apple"))
		print(GetProduct("Apple"))
		print(GetProduct("APPLE"))
		print()
		print(GetProduct("banana"))
		print(GetProduct("BaNaNa"))
		```
    **/
    
    public static function lower(str:String):String;
    
    
    /**
        Returns file name and extension.
		
		Name | Description
		--- | ---
		`pathString` | The string eg. file-path to get the file-name from.
		
		
		`**Returns:** The file name
		
		___
		### Lua Examples
		#### Example 1
		Returns the file name.
		
		```lua 
		print( string.GetFileFromFilename( "garrysmod/lua/modules/string.lua" ) )
		```
		**Output:**
		
		string.lua
    **/
    
    public static function GetFileFromFilename(pathString:String):String;
    
    
    /**
        Splits the string into characters and creates a sequential table of characters.
		
		**Warning:** As a result of the UTF-8 encoding, non-ASCII characters will be split into more than one character in the output table. Each character value in the output table will always be 1 byte.
		
		Name | Description
		--- | ---
		`str` | The string you'll turn into a table.
		
		
		`**Returns:** A sequential table where each value is a character from the given string
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local mystring = "text"
		PrintTable(string.ToTable(mystring))
		```
		
		#### Example 2
		Demonstrates how this function behaves with non-ASCII characters - in this case, Greek letters.
		
		```lua 
		for k,v in ipairs(string.ToTable("abcd αβγδ")) do
		    print(k, bit.tohex(string.byte(v)), v)
		end
		```
    **/
    
    public static function ToTable(str:String):AnyTable;
    
    
    /**
        Removes trailing spaces/passed character from a string.
		
		Name | Description
		--- | ---
		`str` | String to remove from
		`char` | Custom character to remove, default is a space
		
		
		`**Returns:** Trimmed string
    **/
    
    public static function TrimRight(str:String, ?char:String):String;
    
    
    /**
        Escapes all special characters within a string, making the string safe for inclusion in a Lua pattern.
		
		Name | Description
		--- | ---
		`str` | The string to be sanitized
		
		
		`**Returns:** The string that has been sanitized for inclusion in Lua patterns
		
		___
		### Lua Examples
		#### Example 1
		Replaces all occurrences of "100%" in a string with "0%" and prints it.We call string.PatternSafe here as '%' is a special character when used in Lua patterns.
		
		```lua 
		local result = string.gsub( "You scored 100%!", 
		                            string.PatternSafe( "100%" ), 
		                            string.PatternSafe( "0%" ) )
		
		print( result )
		```
		**Output:**
		
		You scored 0%!
    **/
    
    public static function PatternSafe(str:String):String;
    
    
    /**
        Counts the number of characters in the string (length). This is equivalent to using the length operator (#).
		
		Name | Description
		--- | ---
		`str` | The string to find the length of.
		
		
		`**Returns:** Length of the string
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( string.len( "hi" ) )
		print( string.len( "drakehawke" ) )
		print( string.len( "" ) )
		print( string.len( "test" ) == #"test" )
		```
		**Output:**
		
		2 10 0 true
    **/
    
    public static function len(str:String):Float;
    
    
    /**
        Formats the specified values into the string given.
		
		Name | Description
		--- | ---
		`format` | The string to be formatted. Follows this format: http://www.cplusplus.com/reference/cstdio/printf/
		`formatParameters` | Values to be formatted into the string.
		
		
		`**Returns:** The formatted string
		
		___
		### Lua Examples
		#### Example 1
		Example showing the different types of format codes.
		
		```lua 
		local s = "Hello, world!"
		 
		// string
		print(string.format("here's a string: %s", s))
		 
		// string with quotes
		print(string.format("here's a quoted string: %q", s))
		 
		// characters from numeric values
		print(string.format("%c%c%c", 65, 66, 67))
		 
		// number with an exponent
		print(string.format("%e, %E", math.pi, math.pi))
		 
		// float and compact float
		print(string.format("%f, %G", math.pi, math.pi))
		 
		// signed, signed, and unsigned int
		print(string.format("%d, %i, %u", -100, -100, -100))
		 
		// octal, hex, and uppercase hex
		print(string.format("%o, %x, %X", -100, -100, -100))
		```
    **/
    
    public static function format(format:String, formatParameters:Rest<Dynamic>):String;
    
    
    /**
        Changes any lower-case letters in a string to upper-case letters.
		
		Name | Description
		--- | ---
		`str` | The string to convert.
		
		
		`**Returns:** A string representing the value of a string converted to upper-case.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( string.upper( "ABCDEFG" ) )
		print( string.upper( "AbCdefG" ) )
		print( string.upper( "abcdefg" ) )
		print( string.upper( "1234567890" ) )
		```
		**Output:**
		
		ABCDEFG ABCDEFG ABCDEFG 1234567890
    **/
    
    public static function upper(str:String):String;
    
    
    /**
        Returns whether or not the first string starts with the second.
		
		Name | Description
		--- | ---
		`inputStr` | String to check.
		`start` | String to check with.
		
		
		`**Returns:** Whether the first string starts with the second.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.StartWith
		
		```lua 
		print(string.StartWith("hello there", "hell"))
		```
		**Output:**
		
		true
    **/
    
    public static function StartWith(inputStr:String, start:String):Bool;
    
    
    /**
        Returns whether or not the second passed string matches the end of the first.
		
		Name | Description
		--- | ---
		`str` | The string whose end is to be checked.
		`end` | The string to be matched with the end of the first.
		
		
		`**Returns:** true if the first string ends with the second, or the second is empty, otherwise false.
		
		___
		### Lua Examples
		#### Example 1
		Looks for arguments at the end of a string.
		
		```lua 
		local endswith = string.EndsWith("Supercalifragilisticexpialidocious", "docious")
		if endswith then
		    print("Marry Poppins")
		end
		```
		**Output:**
		
		Marry Poppins
    **/
    
    public static function EndsWith(str:String, end:String):Bool;
    
    
    /**
        ***Deprecated:** This function is removed in Lua versions later than what GMod is currently using. Use string. gmatch instead.
		
		Returns an iterator function that is called for every complete match of the pattern, all sub matches will be passed as to the loop.         Example usage of the function
		
		Name | Description
		--- | ---
		`data` | The string to search in
		`pattern` | The pattern to search for
		
		
		`**Returns:** The iterator function that can be used in a for-in loop
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function
		
		```lua 
		local s = "my awesome stuff 12"
		for w in string.gfind(s, "(%a)") do
		    Msg(w)
		end
		```
		**Output:**
		
		In your console: myawesomestuff
    **/
    @:deprecated("This function is removed in Lua versions later than what GMod is currently using. Use string. gmatch instead.")
    public static function gfind(data:String, pattern:String):Function;
    
    
    /**
        Takes the given numerical bytes and converts them to a string.
		
		Name | Description
		--- | ---
		`bytes` | The bytes to create the string from.
		
		
		`**Returns:** String built from given bytes
		
		___
		### Lua Examples
		#### Example 1
		Prints a string consisting of the bytes 72, 101, 108, 108, 111
		
		```lua 
		print( string.char( 72, 101, 108, 108, 111 ) )
		```
		
		#### Example 2
		Helper function to create a random string.
		
		```lua 
		function string.Random( length )
		
		    local length = tonumber( length )
		
		    if length < 1 then return end
		
		    local result = "" -- The empty string we start with
		
		    for i = 1, length do
		
		        result = result .. string.char( math.random(32, 126) )
		
		    end
		
		    return result
		
		end
		
		print( string.Random( 10 ) )
		```
    **/
    
    public static function char(bytes:Rest<Dynamic>):String;
    
    
    /**
        Returns the time as a formatted string or as a table if no format is given.
		
		Name | Description
		--- | ---
		`float` | The time in seconds to format.
		`format` | An optional formatting to use. If no format it specified, a table will be returned instead.
		
		
		`**Returns:** Returns the time as a formatted string only if a format was specified. Returns a table only if no format was specified. The table will contain these fields: number ms - milliseconds number s - seconds number m - minutes number h - hours
		
		___
		### Lua Examples
		#### Example 1
		Formats the time in seconds
		
		```lua 
		local time = string.FormattedTime( 90, "%02i:%02i:%02i" )
		print( time )
		```
		**Output:**
		
		01:30:00
		
		#### Example 2
		Returns a table with the time separated by units.
		
		```lua 
		local time = string.FormattedTime( 90 )
		PrintTable( time )
		```
		**Output:**
		
		ms = 0 m = 1 s = 30 h = 0
    **/
    
    public static function FormattedTime(float:Float, ?format:String):String;
    
    
    /**
        Using Patterns, returns an iterator which will return either one value if no capture groups are defined, or any capture group matches.
		
		Name | Description
		--- | ---
		`data` | The string to search in
		`pattern` | The pattern to search for
		
		
		`**Returns:** The iterator function that can be used in a for-in loop
		
		___
		### Lua Examples
		#### Example 1
		Explodes the string for each space and comma in the string
		
		```lua 
		str = "qwe,a cde"
		for s in string.gmatch(str, "[^%s,]+") do
		    print(s)
		end
		```
    **/
    
    public static function gmatch(data:String, pattern:String):Function;
    
    
    /**
        Converts a digital filesize to human-readable text.
		
		Name | Description
		--- | ---
		`bytes` | The filesize in bytes.
		
		
		`**Returns:** The human-readable filesize, in Bytes/KB/MB/GB (whichever is appropriate).
		
		___
		### Lua Examples
		#### Example 1
		Example output of this function.
		
		```lua 
		print(string.NiceSize(64512))
		```
		**Output:**
		
		63 KB
    **/
    
    public static function NiceSize(bytes:Float):String;
    
    
    /**
        Splits a string up wherever it finds the given separator. 
		
		This is the reverse of string.Implode.
		
		Name | Description
		--- | ---
		`separator` | The string will be separated wherever this sequence is found.
		`str` | The string to split up.
		`use_patterns` | Set this to true if your separator is a pattern.
		
		
		`**Returns:** Exploded string as a numerical sequential table.
		
		___
		### Lua Examples
		#### Example 1
		Splits a sentence into a table of the words in it.
		
		```lua 
		local sentence = "hello there my name is Player1"
		local words = string.Explode( " ", sentence )
		PrintTable( words )
		```
		
		#### Example 2
		Uses Explode to sort through words that a player says.
		
		```lua 
		hook.Add( "PlayerSay", "GiveHealth", function( ply, text )
		    local playerInput = string.Explode( " ", text )
		
		    if ( playerInput[1] == "!givehealth" ) then 
		
		        if ( tonumber( playerInput[2] ) ) then
		
		            ply:SetHealth( tonumber( playerInput[2] ) )
		
		            print( ply:Nick() .. " set their health to " .. playerInput[2] )
		
		        end
		
		    end
		
		end)
		```
    **/
    
    public static function Explode(separator:String, str:String, use_patterns:Bool):AnyTable;
    
    
    /**
        Formats the supplied number (in seconds) to the highest possible time unit.
		
		Name | Description
		--- | ---
		`num` | The number to format, in seconds.
		
		
		`**Returns:** A nicely formatted time string.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		print(string.NiceTime(600))
		print(string.NiceTime(630))
		print(string.NiceTime(660))
		print(string.NiceTime(4356))
		print(string.NiceTime(43545456))
		```
    **/
    
    public static function NiceTime(num:Float):String;
    
    
    /**
        Sets the character at the specific index of the string.
		
		Name | Description
		--- | ---
		`InputString` | The input string
		`Index` | The character index, 1 is the first from left.
		`ReplacementChar` | String to replace with.
		
		
		`**Returns:** ModifiedString
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of SetChar
		
		```lua 
		local str = "Apples"
		MsgN(string.SetChar(str, 3, "g"))
		```
		**Output:**
		
		"Apgles"
    **/
    
    public static function SetChar(InputString:String, Index:Float, ReplacementChar:String):String;
    
    
    /**
        Creates a string from a Color variable.
		
		Name | Description
		--- | ---
		`color` | The color to put in the string.
		
		
		`**Returns:** Output
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of string.FromColor
		
		```lua 
		MsgN(string.FromColor(Color(255, 0, 255, 125)))
		```
		**Output:**
		
		"255 0 255 125"
    **/
    
    public static function FromColor(color:AnyTable):String;
    
    
    /**
        Repeats a string by the provided number, with an optional separator.
		
		Name | Description
		--- | ---
		`str` | The string to convert.
		`repetitions` | Timer to repeat, this values gets rounded internally.
		`separator` | String that will separate the repeated piece. Notice that it doesn't add this string to the start or the end of the result, only between the repeated parts.
		
		
		`**Returns:** Repeated string.
		
		___
		### Lua Examples
		#### Example 1
		Repeating "abc" 5 times.
		
		```lua 
		print(string.rep("abc", 5))
		```
		**Output:**
		
		abcabcabcabcabc
		
		#### Example 2
		Repeating "hello world" 3 times, with the separator " " (space).
		
		```lua 
		print(string.rep("hello world", 3, " "))
		```
		**Output:**
		
		hello world hello world hello world
    **/
    
    public static function rep(str:String, repetitions:Float, ?separator:String):String;
    
    

}


@:multiReturn extern class StringLibGsubReturn {
var a:String;
var b:Float;

}
@:multiReturn extern class StringLibFindReturn {
var a:Float;
var b:Float;
var c:String;

}

