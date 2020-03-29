package gmod.libs;


/**
    The SQL library allows you to access powerful database software included with Garry's Mod. It is the preferred and fastest method of storing large amounts of data. The database is located in sv.db serverside and cl.db clientside, both in the Garry's Mod base folder. SQL is a whole scripting language in itself although relatively simple, it's something you'll need to read up on before using this library.
**/
@:native("_G.sql")extern class SqlLib {
    
    /**
        Performs the query like sql.Query, but returns the first row found. 
		
		Basically equivalent to
		
		Name | Description
		--- | ---
		`query` | The input query
		`row` | The row number. Say we receive back 5 rows, putting 3 as this argument will give us row #3.
		
		
		`**Returns:** The returned row.
    **/
    
    public static function QueryRow(query:String, ?row:Float):AnyTable;
    
    
    /**
        Performs a query on the local SQLite database, returns a table as result set, nil if result is empty and false on error.
		
		Name | Description
		--- | ---
		`query` | The query to execute.
		
		
		`**Returns:** false is returned if there is an error, nil if the query returned no data.
		
		___
		### Lua Examples
		#### Example 1
		Functions that are examples of saving and creating information into the database.
		
		```lua 
		function CreateTable()
		     sql.Query("CREATE TABLE player_data(SteamID TEXT, Money INTEGER)")
		end
		
		function NewPlayerToDataBase(ply)
		     sql.Query("INSERT INTO player_data(SteamID, Money) VALUES('"..ply:SteamID().."', 0)")
		end
		
		function SavePlayerToDatabase(ply, Money)
		     sql.Query("UPDATE player_data SET Money="..Money.." WHERE SteamID='"..ply:SteamID().."'")
		end
		```
    **/
    
    public static function Query(query:String):AnyTable;
    
    
    /**
        Returns if the table with the specified name exists.
		
		Name | Description
		--- | ---
		`tableName` | The name of the table to check.
		
		
		`**Returns:** exists
    **/
    
    public static function TableExists(tableName:String):Bool;
    
    
    /**
        Tells the engine to execute a series of queries queued for execution, must be preceded by sql.Begin 
		
		This is equivalent to
    **/
    
    public static function Commit():Void;
    
    
    /**
        Tells the engine a set of queries is coming. Will wait until sql.Commit is called to run them. This is most useful when you run more than 100+ queries. 
		
		This is equivalent to
    **/
    
    public static function Begin():Void;
    
    
    /**
        Returns the last error from a SQLite query.
		
		`**Returns:** error
    **/
    
    public static function LastError():String;
    
    
    /**
        Escapes dangerous characters and symbols from user input used in an SQLite SQL Query.
		
		**Note:** this function is not meant to be used with external database engines such as MySQL. Escaping strings with inadequate functions is dangerous!
		
		Name | Description
		--- | ---
		`string` | The string to be escaped.
		`bNoQuotes` | Set this as true, and the function will not wrap the input string in apostrophes.
		
		
		`**Returns:** The escaped input.
    **/
    
    public static function SQLStr(string:String, ?bNoQuotes:Bool):String;
    
    
    /**
        Performs the query like sql.QueryRow, but returns the first value found.
		
		Name | Description
		--- | ---
		`query` | The input query.
		
		
		`**Returns:** The returned value; the engine automatically converts numerical output to Lua numbers.
    **/
    
    public static function QueryValue(query:String):Dynamic;
    
    

}



