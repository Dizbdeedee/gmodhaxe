package gmod.libs;


/**
    The debug library is intended to help you debug your scripts, however it also has several other powerful uses.
**/
@:native("_G.debug")extern class DebugLib {
    
    /**
        Returns the current hook settings of the passed thread. The thread argument can be omitted. This is unrelated to gamemode hooks. More information on hooks can be found at http://www.lua.org/pil/23.2.html
		
		Name | Description
		--- | ---
		`thread` | Which thread to retrieve its hook from
		
		
		Name | Description
		--- | ---
		`a` | Hook function
		`b` | Hook mask
		`c` | Hook count
    **/
    
    public static function gethook(?thread:Thread):DebugLibGethookReturn;
    
    
    /**
        Returns the environment of the passed object. This can be set with debug.setfenv
		
		Name | Description
		--- | ---
		`object` | Object to get environment of
		
		
		`**Returns:** Environment
    **/
    
    public static function getfenv(object:AnyTable):AnyTable;
    
    
    /**
        Sets the given function as a Lua hook. This is completely different to gamemode hooks. The thread argument can be completely omitted and calling this function with no arguments will remove the current hook. This is used by default for infinite loop detection. More information on hooks can be found at http://www.lua.org/pil/23.2.html 
		
		Hooks are not always ran when code that has been compiled by LuaJIT's JIT compiler is being executed. This means that relying on them for infinite loop protection is unwise.
		
		Name | Description
		--- | ---
		`thread` | Thread to set the hook on. This argument can be omited
		`hook` | Function for the hook to call
		`mask` | The hook's mask
		`count` | How often to call the hook (in instructions). 0 for every instruction
    **/
    
    public static function sethook(thread:Thread, hook:Function, mask:String, count:Float):Void;
    
    
    /**
        Returns the metatable of an object. This function ignores the metatable's __metatable field.
		
		Name | Description
		--- | ---
		`object` | The object to retrieve the metatable from.
		
		
		`**Returns:** The metatable of the given object.
    **/
    
    public static function getmetatable(object:Dynamic):AnyTable;
    
    
    /**
        Sets a local variable's value.
		
		Name | Description
		--- | ---
		`thread` | The thread
		`level` | The level above the thread. 0 is the function that was called (most always this function)'s arguments 1 is the thread that had called this function. 2 is the thread that had called the function that started the thread that called this function.
		`index` | The variable's index you want to get. 1 = the first local defined in the thread 2 = the second local defined in the thread
		`value` | The value to set the local to
		
		
		`**Returns:** The name of the local variable if the local at the index exists, otherwise nil is returned.
		
		___
		### Lua Examples
		#### Example 1
		Prints the local variables, sets them, then prints the variables again.
		
		```lua 
		local var1 = "Luke, I am not your father."
		local var2 = "PMFPMF"
		
		(function()
		    print("Getting the locals now!")
		    PrintTable({debug.getlocal(2, 1)})
		    PrintTable({debug.getlocal(2, 2)})
		
		    print("\nSetting the locals now!")
		    print(debug.setlocal(2, 1, "I'm actually your mother."))
		    print(debug.setlocal(2, 2, "Chemo-chi"))
		    print(debug.setlocal(2, 3, "nil should be returned here!"))
		
		    print("\nHere are the locals after being set!")
		    PrintTable({debug.getlocal(2, 1)})
		    PrintTable({debug.getlocal(2, 2)})
		end)()
		```
		**Output:**
		
		Getting the locals now!
		1	=	var1
		2	=	Luke, I am not your father.
		1	=	var2
		2	=	PMFPMF
		
		Setting the locals now!
		var1
		var2
		nil
		
		Here are the locals after being set!
		1	=	var1
		2	=	I'm actually your mother.
		1	=	var2
		2	=	Chemo-chi
    **/
    
    public static function setlocal(?thread:Thread, level:Float, index:Float, ?value:Dynamic):String;
    
    
    /**
        Returns an unique identifier for the upvalue indexed from func
		
		Name | Description
		--- | ---
		`func` | The function to index the upvalue from
		`index` | The index from func
		
		
		`**Returns:** A unique identifier
		
		___
		### Lua Examples
		#### Example 1
		Small example showing the type of the returned data.
		
		```lua 
		print(type(debug.upvalueid(hook.Add, 1)))
		```
		**Output:**
		
		userdata
    **/
    
    public static function upvalueid(func:Function, index:Float):Float;
    
    
    /**
        Sets the object's metatable. Unlike setmetatable, this function works regardless of whether the first object passed is a valid table or not; this function even works on primitive datatypes such as numbers, functions, and even nil.
		
		Name | Description
		--- | ---
		`object` | Object to set the metatable for.
		`metatable` | The metatable to set for the object. If this argument is nil, then the object's metatable is removed.
		
		
		`**Returns:** true if the object's metatable was set successfully.
    **/
    
    public static function setmetatable(object:Dynamic, metatable:AnyTable):Bool;
    
    
    /**
        Make the n1-th upvalue of the Lua closure f1 refer to the n2-th upvalue of the Lua closure f2.
		
		Name | Description
		--- | ---
		`f1` | 
		`n1` | 
		`f2` | 
		`n2` | 
    **/
    
    public static function upvaluejoin(f1:Function, n1:Float, f2:Function, n2:Float):Void;
    
    
    /**
        Sets the variable indexed from func
		
		Name | Description
		--- | ---
		`func` | The function to index the upvalue from
		`index` | The index from func
		`val` | The value to set the upvalue to.
		
		
		`**Returns:** Returns nil if there is no upvalue with the given index, otherwise it returns the upvalue's name.
		
		___
		### Lua Examples
		#### Example 1
		An example demonstrating a function overwrite.
		
		```lua 
		local function my_isfunction(f)
		    return type(f) == "function" or f == "coolguy"    
		end
		
		print(debug.setupvalue(hook.Add, 1, my_isfunction))
		```
    **/
    
    public static function setupvalue(func:Function, index:Float, ?val:Dynamic):String;
    
    
    /**
        Returns the internal Lua registry table. 
		
		The Lua registry is used by the engine and binary modules to create references to Lua values. Avoid creating entries into the registry with a number as the key, as they are reserved for the reference system.
		
		**Warning:** Improper editing of the registry can result in unintended side effects, including crashing of the game.
		
		`**Returns:** The Lua registry
    **/
    
    public static function getregistry():AnyTable;
    
    
    /**
        Returns a full execution stack trace.
		
		Name | Description
		--- | ---
		`thread` | Thread (ie. error object from xpcall error handler) to build traceback for.
		`message` | Appended at the beginning of the traceback.
		`level` | Which level to start the traceback.
		
		
		`**Returns:** A dump of the execution stack.
		
		___
		### Lua Examples
		#### Example 1
		Prints the traceback into console.
		
		```lua 
		print(debug.traceback())
		```
		**Output:**
		
		> print(debug.traceback())... stack traceback: lua_run:1: in main chunk
		
		#### Example 2
		Defines two functions that are later visible in the traceback. Enter "lua_run TracebackTest()" into the development console to achieve exact results.
		
		```lua 
		function TracebackTest()
		     AnotherTracebackFunction()
		end
		
		function AnotherTracebackFunction()
		     print(debug.traceback())
		end
		```
		**Output:**
		
		stack traceback:        lua_run:1: in function 'AnotherTracebackFunction'
		       lua_run:1: in function 'TracebackTest'
		 lua_run:1: in main chunk
    **/
    
    public static function traceback(?thread:Thread, ?message:String, ?level:Float):String;
    
    
    /**
        Enters an interactive mode with the user, running each string that the user enters. Using simple commands and other debug facilities, the user can inspect global and local variables, change their values, evaluate expressions, and so on. A line containing only the word cont finishes this function, so that the caller continues its execution.
    **/
    
    public static function debug():Void;
    
    
    /**
        Sets the environment of the passed object.
		
		Name | Description
		--- | ---
		`object` | Object to set environment of
		`env` | Environment to set
		
		
		`**Returns:** The object
		
		___
		### Lua Examples
		#### Example 1
		create a new environment and setfenv Display inside it
		
		```lua 
		local newenvironment = {}
		
		function newenvironment.log( msg )
		    print( msg )
		end
		
		local function Display()
		    log( "yay" )
		end
		
		debug.setfenv( Display , newenvironment )
		
		Display()
		```
    **/
    
    public static function setfenv(object:AnyTable, env:AnyTable):AnyTable;
    
    
    /**
        Used for getting variable values in an index from the passed function. This does nothing for C functions.
		
		Name | Description
		--- | ---
		`func` | Function to get the upvalue indexed from.
		`index` | The index in the upvalue array. The max number of entries can be found in debug. getinfo's " nups" key.
		
		
		Name | Description
		--- | ---
		`a` | Name of the upvalue. Will be nil if the index was out of range (< 1 or > debug. getinfo.nups), or the function was defined in C.
		`b` | Value of the upvalue.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the upvalues of some local functions.
		
		```lua 
		local foo = 5
		local bar = "hello"
		local test = { "table", true, "variable" }
		
		local function DoSomethingWithFoo()
		    -- This code won't be run but the function
		    -- has to reference the variable for
		    -- it to be counted as an upvalue
		    foo = foo + 1
		end
		
		local function DoSomethingWithFooAndBar()
		    foo = foo / 2
		    bar = bar .. " world"
		end
		
		local function DoSomethingWithBarAndTest()
		    test[1] = bar .. "reader!"
		end
		
		
		-- level = stack level to get local variables of
		-- returns a table with [[:Category:string|string]] keys representing the variable name
		local function GetUpvalues( func )
		    local info = debug.getinfo( func, "uS" )
		    local variables = {}
		
		    -- Upvalues can't be retrieved from C functions
		    if ( info != nil && info.what == "Lua" ) then
		        local upvalues = info.nups
		
		        for i = 1, upvalues do
		            local key, value = debug.getupvalue( func, i )
		            variables[ key ] = value
		        end
		    end
		
		    return variables
		end
		
		print( "DoSomethingWithFoo:" )
		PrintTable( GetUpvalues( DoSomethingWithFoo ) )
		
		print( "\nDoSomethingWithFooAndBar:" )
		PrintTable( GetUpvalues( DoSomethingWithFooAndBar ) )
		
		print( "\nDoSomethingWithBarAndTest:" )
		PrintTable( GetUpvalues( DoSomethingWithBarAndTest ) )
		```
		**Output:**
		
		DoSomethingWithFoo:
		foo	=	5
		
		DoSomethingWithFooAndBar:
		bar	=	hello
		foo	=	5
		
		DoSomethingWithBarAndTest:
		bar	=	hello
		test:
				1	=	table
				2	=	true
				3	=	variable
    **/
    
    public static function getupvalue(func:Function, index:DebugInfo):DebugLibGetupvalueReturn;
    
    
    /**
        Gets the name and value of a local variable indexed from the level
		
		**Warning:** When a function has a tailcall return, you cannot access the locals of this function
		
		**Note:** Variables with names starting with ( are internal variables.
		
		Name | Description
		--- | ---
		`thread` | The thread
		`level` | The level above the thread. 0 = the function that was called (most always this function)'s arguments 1 = the thread that had called this function. 2 = the thread that had called the function that started the thread that called this function. A function defined in Lua can also be passed as the level. The index will specify the parameter's name to be returned (a parameter will have a value of nil).
		`index` | The variable's index you want to get. 1 = the first local defined in the thread 2 = the second local defined in the thread etc...
		
		
		Name | Description
		--- | ---
		`a` | The name of the variable Sometimes this will be "(*temporary)" if the local variable had no name. NOTE Variables with names starting with ( are internal variables.
		`b` | The value of the local variable.
		
		
		___
		### Lua Examples
		#### Example 1
		Gets all the local variables of the current thread and stores them in a table.
		
		```lua 
		local name, value;
		local NIL = {} -- to represent nil variables
		local locals = {}
		local i = 1
		while( true ) do
		    name, value = debug.getlocal( 1, i )
		    if ( name == nil ) then break end
		    locals[ name ] = value == nil and NIL or value
		    i = i + 1
		end
		
		for k,v in pairs( locals ) do 
		    print( k, v )
		end
		```
		**Output:**
		
		locals	table: 0x274a8dc0
		value	table: 0x274a8d98
		NIL	table: 0x274a8d98
		name	table: 0x274a8d98
		i	5
		
		#### Example 2
		Prints the parameter names for hook.Add
		
		```lua 
		local print = print
		local getlocal = debug.getlocal
		
		local function PrintFunctionParameters(func)
		    local k = 2
		    local param = getlocal(func, 1)
		    while param ~= nil do
		        print(param)
		        param = getlocal(func, k)
		        k = k + 1
		    end
		end
		
		PrintFunctionParameters(hook.Add)
		```
		**Output:**
		
		event_name
		name
		func
    **/
    
    public static function getlocal(?thread:Thread, level:Float, index:Float):DebugLibGetlocalReturn;
    
    
    /**
        Prints out the lua function call stack to the console.
		
		___
		### Lua Examples
		#### Example 1
		Prints the current call stack.
		
		```lua 
		debug.Trace()
		```
		**Output:**
		
		Trace: 
		 1: Line 32 "Trace" lua/includes/extensions/debug.lua
		 2: Line 1 "(null)" LuaCmd
    **/
    
    public static function Trace():Void;
    
    
    /**
        Returns debug information about a function.
		
		Name | Description
		--- | ---
		`funcOrStackLevel` | Takes either a function or a number representing the stack level as an argument. Stack level 0 always corresponds to the debug.getinfo call, 1 would be the function calling debug.getinfo, and so on. Returns useful information about that function in a table.
		`fields` | A string whose characters specify the information to be retrieved. f - Populates the func field. l - Populates the currentline field. L - Populates the activelines field. n - Populates the name and namewhat fields - only works if stack level is passed rather than function pointer. S - Populates the location fields (lastlinedefined, linedefined, short_src, source and what). u - Populates the argument and upvalue fields (isvararg, nparams, nups)
		
		
		`**Returns:** A table as a DebugInfo structure containing information about the function you passed. Can return nil if the stack level didn't point to a valid stack frame.
		
		___
		### Lua Examples
		#### Example 1
		Let's find out information about net.Receive, such as which file it's defined in, the line it starts and the line it ends, and if it's defined in Lua, or C plus additional information.
		
		```lua 
		PrintTable( debug.getinfo( net.Receive ) )
		```
    **/
    
    public static function getinfo(funcOrStackLevel:Function, ?fields:String):DebugInfo;
    
    

}


@:multiReturn extern class DebugLibGetupvalueReturn {
var a:String;
var b:Dynamic;

}
@:multiReturn extern class DebugLibGetlocalReturn {
var a:String;
var b:Dynamic;

}
@:multiReturn extern class DebugLibGethookReturn {
var a:Function;
var b:String;
var c:Float;

}

