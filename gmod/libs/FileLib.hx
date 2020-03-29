package gmod.libs;


/**
    The file library provides functions for finding, reading and writing to files. The following path values are most commonly used:
**/
@:native("_G.file")extern class FileLib {
    
    /**
        Returns when the file or folder was lasted modified in Unix time.
		
		Name | Description
		--- | ---
		`path` | The file or folder path.
		`gamePath` | The game path to be used. "GAME" Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons "DATA" Data folder (garrysmod/data) "MOD" Strictly the game folder (garrysmod/), ignores mounting.
		
		
		`**Returns:** Seconds passed since Unix epoch.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the last modified date of file helloworld.txt
		
		```lua 
		print( os.date("%d.%m.%Y", file.Time("helloworld.txt", "DATA") ) )
		```
		**Output:**
		
		04.08.2012
		
		#### Example 2
		Prints out the last modified date of folder lua
		
		```lua 
		print( os.date( "%d.%m.%Y", file.Time( "lua", "GAME" ) ) )
		```
		**Output:**
		
		31.01.2016
    **/
    
    public static function Time(path:String, gamePath:String):Float;
    
    
    /**
        Returns a list of files and directories inside a single folder.
		
		Name | Description
		--- | ---
		`name` | The wildcard to search for. "models/*.mdl" will list .mdl files in the models/ folder.
		`path` | The path to look for the files and directories in. See this list for a list of valid paths.
		`sorting` | The sorting to be used, optional. "nameasc" sort the files ascending by name "namedesc" sort the files descending by name "dateasc" sort the files ascending by date "datedesc" sort the files descending by date
		
		
		Name | Description
		--- | ---
		`a` | A table of found files, or nil if the path is invalid
		`b` | A table of found directories, or nil if the path is invalid
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the first file and the first directory in the data folder.
		
		```lua 
		local files, directories = file.Find("*", "DATA")
		
		print( "File: " .. files[1], "Folder: " .. directories[1] )
		```
		**Output:**
		
		File: helloworld.txt Folder: ctp
    **/
    
    public static function Find(name:String, path:String, ?sorting:String):FileLibFindReturn;
    
    
    /**
        Attempts to open a file with the given mode.
		
		Name | Description
		--- | ---
		`fileName` | The files name. See file. Write for details on filename restrictions when writing to files.
		`fileMode` | The mode to open the file in. Possible values are: r - read mode w - write mode a - append mode rb - binary read mode wb - binary write mode ab - binary append mode
		`path` | The path type. See File Search Paths Common paths are: "GAME" - Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons "DATA" - Local to Data folder, has write access (garrysmod/data) "MOD" - Strictly the game folder (garrysmod/), ignores mounting.
		
		
		`**Returns:** The opened file object, or nil if it failed to open due to it not existing or being used by another process.
		
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
    
    public static function Open(fileName:String, fileMode:String, path:String):File;
    
    
    /**
        Deletes a file or empty folder that is relative to the data folder. You can't remove any files outside of data folder.
		
		Name | Description
		--- | ---
		`name` | The file name
		
		
		___
		### Lua Examples
		#### Example 1
		Deletes data/helloworld.txt file.
		
		```lua 
		file.Delete( "helloworld.txt" )
		```
    **/
    
    public static function Delete(name:String):Void;
    
    
    /**
        Appends a file relative to the data folder.
		
		Name | Description
		--- | ---
		`name` | The file's name.
		`content` | The content which should be appended to the file.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds "Append!" to helloworld.txt, then prints it.
		
		```lua 
		file.Append( "helloworld.txt", "Append!" )
		
		print( file.Read( "helloworld.txt", "DATA" ) )
		```
		**Output:**
		
		This is the content!Append!
    **/
    
    public static function Append(name:String, content:String):Void;
    
    
    /**
        Writes the given string to a file. Erases all previous data in the file. To add data without deleting previous data, use file.Append.
		
		Name | Description
		--- | ---
		`fileName` | The name of the file being written into. The path is relative to the data/ folder. This argument will be forced lowercase. The filename must end with one of the following: .txt .jpg .png .vtf .dat .json Restricted symbols are: " :
		`content` | The content that will be written into the file.
		
		
		___
		### Lua Examples
		#### Example 1
		Writes to data/helloworld.txt.
		
		```lua 
		file.Write( "helloworld.txt", "This is the content!" )
		```
    **/
    
    public static function Write(fileName:String, content:String):Void;
    
    
    /**
        Creates a directory that is relative to the data folder.
		
		Name | Description
		--- | ---
		`name` | The directory's name.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a directory named sample in the data folder.
		
		```lua 
		file.CreateDir("sample")
		```
		
		#### Example 2
		This function will create all subfolders you specify.
		
		```lua 
		file.CreateDir("a/b/c/d/e/f/g")
		```
		**Output:**
		
		A folder named "a" is created in the data folder, which contains the folder named "b", which contains a folder named "c", etc.
    **/
    
    public static function CreateDir(name:String):Void;
    
    
    /**
        Returns a boolean of whether the file or directory exists or not.
		
		Name | Description
		--- | ---
		`name` | The file or directory's name.
		`path` | The path of where to look for the file. "GAME" Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons "DATA" Data folder (garrysmod/data) "MOD" Strictly the game folder (garrysmod/), ignores mounting.
		
		
		`**Returns:** Returns true if the file exists and false if it is not.
		
		___
		### Lua Examples
		#### Example 1
		Prints whether the data folder exists in the base directory.
		
		```lua 
		print( file.Exists("data", "GAME") )
		```
		**Output:**
		
		true
    **/
    
    public static function Exists(name:String, path:String):Bool;
    
    
    /**
        Returns whether the given file is a directory or not.
		
		Name | Description
		--- | ---
		`fileName` | The file or directory's name.
		`path` | The path type.
		
		
		`**Returns:** True if the given path is a directory or false if it is a file.
		
		___
		### Lua Examples
		#### Example 1
		Prints if helloworld.txt is a directory.
		
		```lua 
		print( file.IsDir("helloworld.txt", "DATA") )
		```
		**Output:**
		
		false
    **/
    
    public static function IsDir(fileName:String, path:String):Bool;
    
    
    /**
        Returns the file's size in bytes. If the file is not found, returns -1.
		
		Name | Description
		--- | ---
		`fileName` | The file's name.
		`path` | The path type. "GAME" Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons "DATA" Data folder (garrysmod/data) "MOD" Strictly the game folder (garrysmod/), ignores mounting.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the size of helloworld.txt.
		
		```lua 
		print( file.Size("helloworld.txt", "DATA") )
		```
		**Output:**
		
		8
    **/
    
    public static function Size(fileName:String, path:String):Void;
    
    
    /**
        Attempts to rename a file with the given name to another given name. 
		
		This function is constrained to the data/ folder.
		
		Name | Description
		--- | ---
		`orignalFileName` | The original file or folder name. See file.Write for details on filename restrictions when writing to files. This argument will be forced lowercase.
		`targetFileName` | The target file or folder name. See file.Write for details on filename restrictions when writing to files. This argument will be forced lowercase.
		
		
		`**Returns:** True on success, false otherwise.
    **/
    
    public static function Rename(orignalFileName:String, targetFileName:String):Bool;
    
    
    /**
        Returns the content of a file. 
		
		Beware of casing -- some filesystems are case-sensitive. SRCDS on Linux seems to force file/directory creation to lowercase, but will not modify read operations.
		
		Name | Description
		--- | ---
		`fileName` | The name of the file.
		`path` | The path used to look up the file. "GAME" Structured like base folder (garrysmod/), searches all the mounted content (main folder, addons, mounted games etc) "LUA" or "lsv" - All Lua folders (lua/) including gamesmodes and addons "DATA" Data folder (garrysmod/data) "MOD" Strictly the game folder (garrysmod/), ignores mounting. It can also be a boolean: true = "GAME" false = "DATA"
		
		
		`**Returns:** The data from the file as a string, or nil if the file isn't found
		
		___
		### Lua Examples
		#### Example 1
		Prints out the content of helloworld.txt.
		
		```lua 
		print( file.Read("helloworld.txt", "DATA") )
		```
		**Output:**
		
		This is the content!
    **/
    
    public static function Read(fileName:String, ?path:String):String;
    
    

}


@:multiReturn extern class FileLibFindReturn {
var a:AnyTable;
var b:AnyTable;

}

