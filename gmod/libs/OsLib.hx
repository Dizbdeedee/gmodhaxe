package gmod.libs;


/**
    The os library is a standard Lua library originally intended to allow Lua access to various features of the Operating System it's running on, however many of the features and functions have been removed in Garry's Mod due to security issues. It's only used in Garry's Mod for date & time operations.
**/
@:native("_G.os")extern class OsLib {
    
    /**
        Returns the system time in seconds past the unix epoch. If a table is supplied, the function attempts to build a system time with the specified table members.
		
		Name | Description
		--- | ---
		`dateData` | Table to generate the time from. This table's data is interpreted as being in the local timezone. See DateData structure
		
		
		`**Returns:** Seconds passed since Unix epoch
		
		___
		### Lua Examples
		#### Example 1
		Prints out the current time, in seconds past the unix epoch.
		
		```lua 
		print( os.time() )
		```
		**Output:**
		
		1574269694
    **/
    
    public static function time(?dateData:DateData):Float;
    
    
    /**
        Returns the date/time as a formatted string or in a table.
		
		**Note:** This will be a DateData structure if the first argument equals to '*t' or '!*t'
		
		**Bug:** BUG Not all flags are available on all operating systems and the result of using an invalid flag is undefined. This currently crashes the game on Windows. Most or all flags are available on OS X and Linux but considerably fewer are available on Windows. See http://msdn.microsoft.com/en-us/library/fe06s4ak.aspx for a list of available flags on Windows. Note that the # flags also crashes the game on Windows. Issue Tracker: #329
		
		Name | Description
		--- | ---
		`format` | The format string. If this is equal to '*t' or '!*t' then this function will return a DateData structure, otherwise it will return a string. If this starts with an '!', the returned data will use the UTC timezone rather than the local timezone. See http://www.mkssoftware.com/docs/man3/strftime.3.asp for available format flags. BUG Not all flags are available on all operating systems and the result of using an invalid flag is undefined. This currently crashes the game on Windows. Most or all flags are available on OS X and Linux but considerably fewer are available on Windows. See http://msdn.microsoft.com/en-us/library/fe06s4ak.aspx for a list of available flags on Windows. Note that the # flags also crashes the game on Windows. Issue Tracker: #329
		`time` | Time to use for the format.
		
		
		`**Returns:** Formatted date NOTE This will be a DateData structure if the first argument equals to '*t' or '!*t'
		
		___
		### Lua Examples
		#### Example 1
		This will use the os.time() function, and return it in a friendly way. os.time() is useful for storing as a date stamp but needs this to make it readable.
		
		```lua 
		local Timestamp = os.time()
		local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
		print( "Timestamp:", Timestamp )
		print( "TimeString:", TimeString )
		```
    **/
    
    public static function date(format:DateData, time:Float):DateData;
    
    
    /**
        Returns the approximate cpu time the application ran.
		
		**Note:** This function has different precision on Linux (1/100).
		
		`**Returns:** runtime
		
		___
		### Lua Examples
		#### Example 1
		Prints the amount of time since Garry's Mod has been open to the console.
		
		```lua 
		print(os.clock())
		```
		**Output:**
		
		runtime
    **/
    
    public static function clock():Float;
    
    
    /**
        Subtracts the second of the first value and rounds the result.
		
		Name | Description
		--- | ---
		`timeA` | The first value.
		`timeB` | The value to subtract.
		
		
		`**Returns:** diffTime
    **/
    
    public static function difftime(timeA:Float, timeB:Float):Float;
    
    

}



