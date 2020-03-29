package gmod.libs;


/**
    The table type is an object that can store multiple values. 
	
	The table library is a standard Lua library which provides functions to manipulate tables. In Garry's Mod there are several extra useful functions added to this library. 
	
	 This category lists the functions available in the table library.
**/
@:native("_G.table")extern class TableLib {
    
    /**
        Returns a key of the supplied table with the highest number value.
		
		Name | Description
		--- | ---
		`inputTable` | The table to search in.
		
		
		`**Returns:** winningKey
		
		___
		### Lua Examples
		#### Example 1
		Code that looks up the most favourite fruit from a table where the fruit's name is the key, and it's number value determines how much favourite it is (the higher value, the better).
		
		```lua 
		favouriteFruit = { banana = 4, strawberry = 4, blueberry = 2, apple = 6 }
		print(table.GetWinningKey(favouriteFruit))
		```
		**Output:**
		
		apple
		
		#### Example 2
		A code that demonstrates a situation where there are two keys with the same value in the supplied table. String keys in the table represent the fruit name, and their number values determine how favourite it is (the higher value, the better).
		
		```lua 
		favouriteFruit = { apple = 1, banana = 7, strawberry = 3, blueberry = 7 }
		print(table.GetWinningKey(favouriteFruit))
		```
		**Output:**
		
		banana
    **/
    
    public static function GetWinningKey(inputTable:AnyTable):Dynamic;
    
    
    /**
        Inserts a value in to the given table even if the table is non-existent
		
		Name | Description
		--- | ---
		`tab` | Table to insert value in to
		`value` | Value to insert
		
		
		`**Returns:** The supplied or created table
    **/
    
    public static function ForceInsert(?tab:AnyTable, value:Dynamic):AnyTable;
    
    
    /**
        Converts a table that has been sanitised with table.Sanitise back to its original form
		
		Name | Description
		--- | ---
		`tbl` | Table to be de-sanitised
		
		
		`**Returns:** De-sanitised table
    **/
    
    public static function DeSanitise(tbl:AnyTable):AnyTable;
    
    
    /**
        ***Deprecated:** Instead, index the table with a key of 1. Non-numerically indexed tables are not ordered and do not have a first key.
		
		Returns the first value found in the given table
		
		Name | Description
		--- | ---
		`tab` | Table to retrieve value from
		
		
		`**Returns:** Value
    **/
    @:deprecated("Instead, index the table with a key of 1. Non-numerically indexed tables are not ordered and do not have a first key.")
    public static function GetFirstValue(tab:AnyTable):Dynamic;
    
    
    /**
        Sorts a table in reverse order from table.sort
		
		Name | Description
		--- | ---
		`tbl` | The table to sort in descending order.
		
		
		`**Returns:** sorted
    **/
    
    public static function SortDesc(tbl:AnyTable):AnyTable;
    
    
    /**
        Returns a copy of the input table with all string keys converted to be lowercase recursively
		
		Name | Description
		--- | ---
		`tbl` | Table to convert
		
		
		`**Returns:** New table
    **/
    
    public static function LowerKeyNames(tbl:AnyTable):AnyTable;
    
    
    /**
        Adds the contents from one table into another. The target table will be modified. 
		
		See also table.Inherit and table.Merge.
		
		Name | Description
		--- | ---
		`target` | The table to insert the new values into.
		`source` | The table to retrieve the values from.
		
		
		`**Returns:** The target table.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function. Note that duplicate values will be added.
		
		```lua 
		local Test1 = {"One","Two","Three", "Four"}
		local Test2 = {"Four", "Five", "Six"}
		table.Add( Test1, Test2 )
		print( table.concat(Test1, " ") )
		```
		**Output:**
		
		One Two Three Four Four Five Six
    **/
    
    public static function Add(target:AnyTable, source:AnyTable):AnyTable;
    
    
    /**
        Checks if a table has a value.
		
		**Warning:** This function is very inefficient for large tables (O(n)) and should probably not be called in things that run each frame. Instead, consider a table structure such as example 2 below.
		
		**Note:** For optimization, functions that look for a value by sorting the table should never be needed if you work on a table that you built yourself.
		
		Name | Description
		--- | ---
		`tbl` | Table to check
		`value` | Value to search for
		
		
		`**Returns:** Returns true if the table has that value, false otherwise
		
		___
		### Lua Examples
		#### Example 1
		Creates a table with values "123" and "test" and checks to see it the table holds value "apple"
		
		```lua 
		local mytable = {"123", "test"}
		print(table.HasValue(mytable, "apple"), table.HasValue(mytable, "test"))
		```
		**Output:**
		
		false true
		
		#### Example 2
		Example usage of O(1) associative array structure
		
		```lua 
		local mytable = { ["123"] = true, test = true }
		print(mytable["apple"], mytable["test"])
		```
		**Output:**
		
		nil true
    **/
    
    public static function HasValue(tbl:AnyTable, value:Dynamic):Bool;
    
    
    /**
        Counts the amount of keys in a table. This should only be used when a table is not numerically and sequentially indexed. For those tables, consider the length (#) operator. 
		
		If you only want to test if the table is empty or not, use table.IsEmpty instead as it is a lot faster.
		
		Name | Description
		--- | ---
		`tbl` | The table to count the keys of.
		
		
		`**Returns:** The number of keyvalue pairs. This includes non-numeric and non-sequential keys, unlike the length ( #) operator.
		
		___
		### Lua Examples
		#### Example 1
		There are 4 keys in this table. So it will output "4"
		
		```lua 
		local Table = { A = "1", B = "2", C = "3", D = "4" }
		
		print( table.Count( Table ) )
		```
		
		#### Example 2
		Difference between the length (#) operator and this function.The length (#) operator is generally considered faster, but has limitations.
		
		```lua 
		local Table = { A = "1", B = "2", C = "3", D = "4" }
		
		print( table.Count( Table ), #Table ) -- #Table will return 0 because the table contains no numeric keys
		
		local Table2 = { "test1", "test2", "test3" } -- 1 = "test1", 2 = "test2"
		
		print( table.Count( Table2 ), #Table2 ) -- Both will be 3
		
		Table2[ 5 ] = "test5" -- Insert a new value at index 5, so index 4 does not exist
		
		-- table.Count here will return correct value, #Table2 will return 3 because
		-- the new value is non sequential ( there is nothing at index 4 )
		print( table.Count( Table2 ), #Table2 )
		```
    **/
    
    public static function Count(tbl:AnyTable):Float;
    
    
    /**
        Sorts a table by a named member
		
		Name | Description
		--- | ---
		`tab` | Table to sort
		`memberKey` | The key used to identify the member
		`ascending` | Whether or not the order should be ascending
		
		
		___
		### Lua Examples
		#### Example 1
		Orders a table by a member and prints it
		
		```lua 
		local tab = {
		    {Name = "Bill", Age = 13},
		    {Name = "Jill", Age = 14},
		    {Name = "Phil", Age = 8}
		}
		table.SortByMember(tab, "Age")
		
		for k, v in ipairs(tab) do
		    print(v.Name)
		end
		```
		**Output:**
		
		Jill Bill Phil
    **/
    
    public static function SortByMember(tab:AnyTable, memberKey:Dynamic, ?ascending:Bool):Void;
    
    
    /**
        Returns the highest numerical key.
		
		Name | Description
		--- | ---
		`tbl` | The table to search.
		
		
		`**Returns:** The highest numerical key.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates how this differs from the # operator.
		
		```lua 
		local tbl = {"One", "Two", [6] = "Six", [42] = "Answer to life, the universe, and everything"}
		
		PrintTable(tbl)
		print("\n" .. #tbl)
		print(table.maxn(tbl))
		```
		**Output:**
		
		1	=	One
		2	=	Two
		6	=	Six
		42	=	Answer to life, the universe, and everything
		
		2
		42
		 Whereas the length operator ( #) returns the highest sequential index, this returns the value of the highest numeric index.
    **/
    
    public static function maxn(tbl:AnyTable):Float;
    
    
    /**
        ***Deprecated:** Instead, use the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key.
		
		Returns the last key found in the given table
		
		Name | Description
		--- | ---
		`tab` | Table to retrieve key from
		
		
		`**Returns:** Key
    **/
    @:deprecated("Instead, use the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key.")
    public static function GetLastKey(tab:AnyTable):Dynamic;
    
    
    /**
        Copies any missing data from base to target, and sets the target's BaseClass member to the base table's pointer. 
		
		See table.Merge, which overrides existing values and doesn't add a BaseClass member. See also table.Add, which simply adds values of one table to another.
		
		**Bug:** BUG Sub-tables aren't inherited. The target's table value will take priority. Pull Request: #1304
		
		Name | Description
		--- | ---
		`target` | Table to copy data to
		`base` | Table to copy data from
		
		
		`**Returns:** Target
		
		___
		### Lua Examples
		#### Example 1
		Example of how this function works.
		
		```lua 
		local table1 = { "A", "Golden" }
		local table2 = { "Two", "Orange", "Apple" }
		table.Inherit( table1, table2 )
		PrintTable( table1 )
		```
    **/
    
    public static function Inherit(target:AnyTable, base:AnyTable):AnyTable;
    
    
    /**
        Returns all keys of a table.
		
		Name | Description
		--- | ---
		`tabl` | The table to get keys of
		
		
		`**Returns:** Table of keys
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		local tabl = {
		one = "A",
		two = "B",
		}
		PrintTable( table.GetKeys( tabl ) )
		```
		**Output:**
		
		1	=	one
		2	=	two
    **/
    
    public static function GetKeys(tabl:AnyTable):AnyTable;
    
    
    /**
        Converts Vectors, Angles and booleans to be able to be converted to and from key-values. table.DeSanitise does the opposite
		
		Name | Description
		--- | ---
		`tab` | Table to sanitise
		
		
		`**Returns:** Sanitised table
		
		___
		### Lua Examples
		#### Example 1
		Example of what this function does.
		
		```lua 
		local table1 = { "A", "Golden", Angle( 1, 2, 3 ), Vector( 1, 2, 3 ) }
		
		PrintTable( table.Sanitise( table1 ) )
		```
    **/
    
    public static function Sanitise(tab:AnyTable):AnyTable;
    
    
    /**
        Returns a reversed copy of a sequential table. Any non-sequential and non-numeric keyvalue pairs will not be copied.
		
		Name | Description
		--- | ---
		`tbl` | Table to reverse.
		
		
		`**Returns:** A reversed copy of the table.
		
		___
		### Lua Examples
		#### Example 1
		Creates a table and reverses it.
		
		```lua 
		local tbl = { "One", "Two", "Three", four = 4, [5] = "5" }
		
		PrintTable(tbl)
		print("")
		PrintTable(table.Reverse(tbl))
		```
		**Output:**
		
		1	=	One
		2	=	Two
		3	=	Three
		four	=	4
		5	=	5
		
		1	=	Three
		2	=	Two
		3	=	One
    **/
    
    public static function Reverse(tbl:AnyTable):AnyTable;
    
    
    /**
        Returns a random value from the supplied table.
		
		**Note:** This function iterates over the given table twice, therefore with sequential tables you should instead use following: mytable[ math.random( #mytable ) ]
		
		Name | Description
		--- | ---
		`haystack` | The table to choose from.
		
		
		Name | Description
		--- | ---
		`a` | A random value from the table.
		`b` | The key associated with the random value.
		
		
		___
		### Lua Examples
		#### Example 1
		A simple example of this function using two tables.
		
		```lua 
		color = { "green", "red", "blue", "yellow" }
		object = { "car", "house", "bike" }
		
		print( "I have a " .. table.Random( color ) .. " " .. table.Random( object ) .. "." )
		```
		**Output:**
		
		I have a green house.
		
		#### Example 2
		Example of using the alternative with sequential tables for performance reasons.
		
		```lua 
		websites = {"facepunch.com", "google.com", "steampowered.com"}
		print("I think the best website ever is " .. websites[math.random(1, #websites)] .. ".")
		```
		**Output:**
		
		I think the best website ever is google.com.
    **/
    
    public static function Random(haystack:AnyTable):TableLibRandomReturn;
    
    
    /**
        ***Deprecated:** Instead, iterate your table with ipairs, storing the previous value and checking for the target. Non-numerically indexed tables are not ordered.
		
		Returns the value positioned before the supplied value in a table. If it isn't found then the last element in the table is returned
		
		Name | Description
		--- | ---
		`tbl` | Table to search
		`value` | Value to return element before
		
		
		`**Returns:** Found element
		
		___
		### Lua Examples
		#### Example 1
		Print the previous item the value "b" of the table
		
		```lua 
		local tbl = {"a", "b", "c"}
		
		print(table.FindPrev(tbl, "b"))
		```
		**Output:**
		
		a in console
    **/
    @:deprecated("Instead, iterate your table with ipairs, storing the previous value and checking for the target. Non-numerically indexed tables are not ordered.")
    public static function FindPrev(tbl:AnyTable, value:Dynamic):Dynamic;
    
    
    /**
        Returns a list of keys sorted based on values of those keys. 
		
		For normal sorting see table.sort.
		
		Name | Description
		--- | ---
		`tab` | Table to sort. All values of this table must be of same type.
		`descending` | Should the order be descending?
		
		
		`**Returns:** A table of keys sorted by values from supplied table.
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function.
		
		```lua 
		local t = {}
		t['h'] = 2 -- Lowest value
		t['a'] = 150 -- Highest value
		t['x'] = 30
		
		PrintTable( table.SortByKey( t ) )
		PrintTable( table.SortByKey( t , true ) )
		```
		**Output:**
		
		1 = a
		2 = x
		3 = h 1 = h
		2 = x
		3 = a
    **/
    
    public static function SortByKey(tab:AnyTable, ?descending:Bool):AnyTable;
    
    
    /**
        Collapses a table with keyvalue structure
		
		Name | Description
		--- | ---
		`input` | Input table
		
		
		`**Returns:** Output table
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		local output = table.CollapseKeyValue( {
		    { Key = "mykey1", Value = "myvalue1" },
		    { Key = 123, Value = 1345 },
		    { Key = 1345, Value = "myvalue1" },
		} )
		```
		**Output:**
		
		local output = {
			[ "mykey1" ] = "myvalue1",
			[ 123 ] = 1345,
			[ 1345 ] = "myvalue1",
		}
    **/
    
    public static function CollapseKeyValue(input:AnyTable):AnyTable;
    
    
    /**
        Concatenates the contents of a table to a string.
		
		Name | Description
		--- | ---
		`tbl` | The table to concatenate.
		`concatenator` | A seperator to insert between strings
		`startPos` | The key to start at
		`endPos` | The key to end at
		
		
		`**Returns:** Concatenated values
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local Table = { "A", "simple", "table.concat", "test" }
		print( table.concat( Table ) )
		print( table.concat( Table, " " ) )
		print( table.concat( Table, " ", 3, 4 ) )
		```
		**Output:**
		
		Asimpletable.concattest
		A simple table.concat test
		table.concat test
    **/
    
    public static function concat(tbl:AnyTable, ?concatenator:String, ?startPos:Float, ?endPos:Float):String;
    
    
    /**
        Returns whether or not the table's keys are sequential
		
		Name | Description
		--- | ---
		`tab` | Table to check
		
		
		`**Returns:** Is sequential
    **/
    
    public static function IsSequential(tab:AnyTable):Bool;
    
    
    /**
        ***Deprecated:** Instead, iterate the table using ipairs or increment from the previous index using next. Non-numerically indexed tables are not ordered.
		
		Returns the value positioned after the supplied value in a table. If it isn't found then the first element in the table is returned
		
		Name | Description
		--- | ---
		`tbl` | Table to search
		`value` | Value to return element after
		
		
		`**Returns:** Found element
		
		___
		### Lua Examples
		#### Example 1
		Print the next element after the "b" value of the table
		
		```lua 
		local tbl = {"a", "b", "c"}
		
		print(table.FindNext(tbl, "b"))
		```
		**Output:**
		
		c in console
    **/
    @:deprecated("Instead, iterate the table using ipairs or increment from the previous index using next. Non-numerically indexed tables are not ordered.")
    public static function FindNext(tbl:AnyTable, value:Dynamic):Dynamic;
    
    
    /**
        ***Deprecated:** You should use pairs() instead.
		
		Iterates over a table and calls the given function for each key and value found. Unlike [table](https://wiki.garrysmod.com/page/Category:table). [foreach](https://wiki.garrysmod.com/page/table/foreach), this ignores the value returned by the function.
		
		Name | Description
		--- | ---
		`tab` | Table to iterate over.
		`callback` | Function to call for every key-value pair. Arguments passed are: any key any value
    **/
    @:deprecated("You should use pairs() instead.")
    public static function ForEach(tab:AnyTable, callback:Function):Void;
    
    
    /**
        Removes the first instance of a given value from the specified table with table.remove, then returns the key that the value was found at.
		
		Name | Description
		--- | ---
		`tbl` | The table that will be searched.
		`val` | The value to find within the table.
		
		
		`**Returns:** The key at which the value was found, or false if the value was not found.
    **/
    
    public static function RemoveByValue(tbl:AnyTable, val:Dynamic):Dynamic;
    
    
    /**
        Removes all values from a table.
		
		Name | Description
		--- | ---
		`tbl` | The table to empty.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local Table = {"String Value", "Another value", Var = "Non-integer key"}
		table.Empty(Table)
		print( table.Count(Table) )
		```
		**Output:**
		
		0
    **/
    
    public static function Empty(tbl:AnyTable):Void;
    
    
    /**
        ***Deprecated:** This was deprecated in Lua 5.1 and removed in 5.2. You should use ipairs() instead.
		
		Iterates for each numeric index in the table in order. This is inherited from the original Lua implementation and is deprecated in Lua as of 5.1; see here. You should use ipairs() instead.
		
		Name | Description
		--- | ---
		`table` | The table to iterate over.
		`func` | The function to run for each index.
    **/
    @:deprecated("This was deprecated in Lua 5.1 and removed in 5.2. You should use ipairs() instead.")
    public static function foreachi(table:AnyTable, func:Function):Void;
    
    
    /**
        ***Deprecated:** Instead, expect the first key to be 1. Non-numerically indexed tables are not ordered and do not have a first key.
		
		Returns the first key found in the given table
		
		Name | Description
		--- | ---
		`tab` | Table to retrieve key from
		
		
		`**Returns:** Key
    **/
    @:deprecated("Instead, expect the first key to be 1. Non-numerically indexed tables are not ordered and do not have a first key.")
    public static function GetFirstKey(tab:AnyTable):Dynamic;
    
    
    /**
        Returns the first key found to be containing the supplied value
		
		Name | Description
		--- | ---
		`tab` | Table to search
		`value` | Value to search for
		
		
		`**Returns:** Key
    **/
    
    public static function KeyFromValue(tab:AnyTable, value:Dynamic):Dynamic;
    
    
    /**
        Removes a value from a table and shifts any other values down to fill the gap.
		
		Name | Description
		--- | ---
		`tbl` | The table to remove the value from.
		`index` | The index of the value to remove.
		
		
		`**Returns:** The value that was removed.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		sentence = { "hello", "there", "my", "name", "is", "Player1" }
		print( table.remove( sentence ) ) -- Using no second arg removes the last value
		print( table.remove( sentence, 2 ) )
		PrintTable( sentence )
		```
    **/
    
    public static function remove(tbl:AnyTable, ?index:Float):Dynamic;
    
    
    /**
        ***Deprecated:** Instead, index the table with the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key.
		
		Returns the last value found in the given table
		
		Name | Description
		--- | ---
		`tab` | Table to retrieve value from
		
		
		`**Returns:** Value
    **/
    @:deprecated("Instead, index the table with the result of the length (#) operator, ensuring it is not zero. Non-numerically indexed tables are not ordered and do not have a last key.")
    public static function GetLastValue(tab:AnyTable):Dynamic;
    
    
    /**
        Merges the contents of the second table with the content in the first one. 
		
		See table.Inherit, which doesn't override existing values. See also table.Add, which simply adds values of one table to another.
		
		Name | Description
		--- | ---
		`destination` | The table you want the source table to merge with
		`source` | The table you want to merge with the destination table
		
		
		`**Returns:** Destination table
		
		___
		### Lua Examples
		#### Example 1
		"Merges" the content of the second table with the first one, overwriting any matching key/value pairs in the destination with the source's version and prints the resulting merge.
		
		```lua 
		local destination = {[1] = "A", [2] = "Golden", [3] = "Apple"}
		local source = {[1] = "Two", [2] = "Orange"}
		table.Merge( destination, source )
		PrintTable( destination )
		```
    **/
    
    public static function Merge(destination:AnyTable, source:AnyTable):AnyTable;
    
    
    /**
        Empties the target table, and merges all values from the source table into it.
		
		Name | Description
		--- | ---
		`source` | The table to copy from.
		`target` | The table to write to.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local Test1 = {A = "String keys", B = "Table 1"}
		local Test2 = {"Numeric keys", "Table 2"}
		table.CopyFromTo( Test2, Test1 )
		PrintTable( Test1 )
		```
		**Output:**
		
		1 = Numeric keys 2 = Table 2
    **/
    
    public static function CopyFromTo(source:AnyTable, target:AnyTable):Void;
    
    
    /**
        Inserts a value into a table at the end of the table or at the given position.
		
		Name | Description
		--- | ---
		`tbl` | The table to insert the variable into.
		`position` | The position in the table to insert the variable. If the third argument is nil this argument becomes the value to insert at the end of given table.
		`value` | The variable to insert into the table.
		
		
		`**Returns:** The index the object was placed at.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		sentence = { "hello", "there", "my", "name", "is", "drakehawke" }
		table.insert( sentence, "lol" )
		table.insert( sentence, 6, "not" )
		
		PrintTable( sentence )
		```
		**Output:**
		
		1	=	hello
		2	=	there
		3	=	my
		4	=	name
		5	=	is
		6	=	not
		7	=	drakehawke
		8	=	lol
    **/
    
    public static function insert(tbl:AnyTable, position:Float, value:Dynamic):Float;
    
    
    /**
        Returns whether or not the given table is empty. 
		
		This works on both sequential and non-sequential tables, and is a lot faster to use than
		
		Name | Description
		--- | ---
		`tab` | Table to check
		
		
		`**Returns:** Is empty
    **/
    
    public static function IsEmpty(tab:AnyTable):Bool;
    
    
    /**
        Changes all keys to sequential integers. This creates a new table object and does not affect the original.
		
		Name | Description
		--- | ---
		`table` | The original table to modify.
		`saveKeys` | Save the keys within each member table. This will insert a new field __key into each value, and should not be used if the table contains non-table values.
		
		
		`**Returns:** Table with integer keys.
		
		___
		### Lua Examples
		#### Example 1
		Changes all the table's keys to integer values
		
		```lua 
		local Table = {One = "A", Two = "B", Three = "C"}
		local Table2 = table.ClearKeys(Table)
		PrintTable(Table2)
		```
		**Output:**
		
		1 = A 2 = C 3 = B
		
		#### Example 2
		Clears a table of its keys, and preserves the old key names within each member.
		
		```lua 
		local tbl = {
		    FirstMember = { Name = "John Smith", Age  = 25 },
		    SecondMember = { Name = "Jane Doe", Age = 42 },
		    ThirdMember = { Name = "Joe Bloggs", Age = 39 }
		}
		print( "===== Before =====" )
		PrintTable( tbl )
		local tbl2 = table.ClearKeys( tbl, true )
		print( "===== After =====" )
		PrintTable( tbl2 )
		```
		**Output:**
		
		===== Before =====
		FirstMember:
				Name	=	John Smith
				Age	=	25
		SecondMember:
				Name	=	Jane Doe
				Age	=	42
		ThirdMember:
				Name	=	Joe Bloggs
				Age	=	39
		===== After =====
		1:
				Age	=	25
				Name	=	John Smith
				__key	=	FirstMember
		2:
				Age	=	39
				Name	=	Joe Bloggs
				__key	=	ThirdMember
		3:
				Age	=	42
				Name	=	Jane Doe
				__key	=	SecondMember
    **/
    
    public static function ClearKeys(table:AnyTable, ?saveKeys:Bool):AnyTable;
    
    
    /**
        Creates a deep copy and returns that copy.
		
		**Warning:** This function does NOT copy userdata, such as Vectors and Angles!
		
		Name | Description
		--- | ---
		`originalTable` | The table to be copied.
		
		
		`**Returns:** A deep copy of the original table
		
		___
		### Lua Examples
		#### Example 1
		Creates a deep copy of table A
		
		```lua 
		B = table.Copy(A)
		```
    **/
    
    public static function Copy(originalTable:AnyTable):AnyTable;
    
    
    /**
        ***Deprecated:** This was deprecated in Lua 5.1 and removed in 5.2. You should use pairs() instead.
		
		Iterates for each key-value pair in the table, calling the function with the key and value of the pair. If the function returns anything, the loop is broken. This is inherited from the original Lua implementation and is deprecated in Lua as of 5.1; see here. You should use pairs() instead. The GLua interpretation of this is table.ForEach.
		
		Name | Description
		--- | ---
		`tbl` | The table to iterate over.
		`callback` | The function to run for each key and value.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local food = { "Cake", "Pies", Delicious = "Cookies", Awesome = "Pizza" }
		table.foreach( food, function( key, value )
		 print( tostring(key) .." ".. value)
		end)
		```
		**Output:**
		
		1 Cake
		2 Pies
		Awesome Pizza
		Delicious Cookies
		
		#### Example 2
		Demonstrates the breaking effect if the callback returns a value.
		
		```lua 
		local tbl = { "One", "Two", "Three", "Four" }
		table.foreach( tbl, function( key, value )
		   print( key, value )
		   if key == 2 then return true end
		end)
		```
		**Output:**
		
		1    One
		2    Two
    **/
    @:deprecated("This was deprecated in Lua 5.1 and removed in 5.2. You should use pairs() instead.")
    public static function foreach(tbl:AnyTable, callback:Function):Void;
    
    
    /**
        Returns a table of keys containing the supplied value
		
		Name | Description
		--- | ---
		`tab` | Table to search
		`value` | Value to search for
		
		
		`**Returns:** Keys
    **/
    
    public static function KeysFromValue(tab:AnyTable, value:Dynamic):AnyTable;
    
    
    /**
        ***Deprecated:** This function was deprecated in Lua 5.1 and is removed in 5.2. Use the length (#) operator instead.
		
		Returns the length of the table.
		
		Name | Description
		--- | ---
		`tbl` | The table to check.
		
		
		`**Returns:** Sequential length.
    **/
    @:deprecated("This function was deprecated in Lua 5.1 and is removed in 5.2. Use the length (#) operator instead.")
    public static function getn(tbl:AnyTable):Float;
    
    
    /**
        Sorts a table either ascending or by the given sort function.
		
		Name | Description
		--- | ---
		`tbl` | The table to sort.
		`sorter` | If specified, the function will be called with 2 parameters each. Return true in this function if you want the first parameter to come first in the sorted array.
		
		
		___
		### Lua Examples
		#### Example 1
		Sorting table by an integer
		
		```lua 
		local TABLE = {
		    {"Jeff",8},
		    {"Peter",17},
		    {"Shay",11},
		    {"Janine",1}
		}
		
		table.sort(TABLE,function(a, b) return a[2] > b[2] end)
		```
		**Output:**
		
		Table going from highest number to lowest (1: Peter, 2: Shay, 3: Jeff, 4: Janine)
		
		#### Example 2
		Sorting a player table by a NWInt
		
		```lua 
		local PLAYERS = player.GetAll()
		
		table.sort(PLAYERS,function(a, b) return a:GetNWInt("Score") > b:GetNWInt("Score") end)
		```
		**Output:**
		
		Player table sorted by score going from highest to lowest
    **/
    
    public static function sort(tbl:AnyTable, sorter:Function):Void;
    
    
    /**
        Converts a table into a string
		
		Name | Description
		--- | ---
		`tbl` | The table to iterate over.
		`displayName` | Optional. A name for the table.
		`niceFormatting` | Adds new lines and tabs to the string.
		
		
		`**Returns:** The table formatted as a string.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local Table = { Red = "Apple", Green = "Celery", Yellow = "Banana"}
		local String = table.ToString( Table, "Fruit and Vegetable", true )
		print( String )
		```
		**Output:**
		
		Fruit and Vegetable	=	{
				Red	=	"Apple",
				Green	=	"Celery",
				Yellow	=	"Banana",
		}
    **/
    
    public static function ToString(tbl:AnyTable, displayName:String, niceFormatting:Bool):String;
    
    

}


@:multiReturn extern class TableLibRandomReturn {
var a:Dynamic;
var b:Dynamic;

}

