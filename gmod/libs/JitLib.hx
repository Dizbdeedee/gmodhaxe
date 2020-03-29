package gmod.libs;


/**
    Function to work with the LuaJIT functionality of gmod.
**/
@:native("_G.jit")extern class JitLib {
    
    /**
        Flushes the whole cache of compiled code.
    **/
    
    public static function flush():Void;
    
    
    /**
        Enables LuaJIT Lua compilation.
    **/
    
    public static function on():Void;
    
    
    /**
        Returns the status of the JIT compiler and the current optimizations enabled.
		
		Name | Description
		--- | ---
		`a` | Is JIT enabled
		`b` | Strings for CPU-specific features and enabled optimizations
    **/
    
    public static function status():JitLibStatusReturn;
    
    
    /**
        Return table fields:
		
		Name | Description
		--- | ---
		`tr` | trace index to retrieve snapshot for (gotten via jit. attach)
		`sn` | snapshot index for trace (starting from 0 to nexit - 1, nexit gotten via jit. util.traceinfo)
		
		
		`**Returns:** snapshot
    **/
    
    public static function util(tr:Float, sn:Float):AnyTable;
    
    
    /**
        Disables LuaJIT Lua compilation.
    **/
    
    public static function off():Void;
    
    
    /**
        JIT compiler optimization control. The opt sub-module provides the backend for the -O command line LuaJIT option. You can also use it programmatically, e.g.:
		
		Name | Description
		--- | ---
		`args` | 
    **/
    
    public static function opt(args:Rest<Dynamic>):Void;
    
    
    /**
        You can attach callbacks to a number of compiler events with jit.attach. The callback can be called:
		
		**Warning:** This function isn't officially documented on LuJIT wiki, use it at your own risk.
		
		Name | Description
		--- | ---
		`callback` | The callback function. The arguments passed to the callback depend on the event being reported: "bc": function func - The function that's just been recorded "trace": string what - description of the trace event: "flush", "start", "stop", "abort". Available for all events. number tr - The trace number. Not available for flush. function func - The function being traced. Available for start and abort. number pc - The program counter - the bytecode number of the function being recorded (if this a Lua function). Available for start and abort. number otr - start: the parent trace number if this is a side trace, abort: abort code string oex - start: the exit number for the parent trace, abort: abort reason (string) "record": number tr - The trace number. Not available for flush. function func - The function being traced. Available for start and abort. number pc - The program counter - the bytecode number of the function being recorded (if this a Lua function). Available for start and abort. number depth - The depth of the inlining of the current bytecode. "texit": number tr - The trace number. Not available for flush. number ex - The exit number number ngpr - The number of general-purpose and floating point registers that are active at the exit. number nfpr - The number of general-purpose and floating point registers that are active at the exit.
		`event` | The event to hook into.
    **/
    
    public static function attach(callback:Function, event:String):Void;
    
    

}


@:multiReturn extern class JitLibStatusReturn {
var a:Bool;
var b:Dynamic;

}

