package gmod.libs;


/**
    Coroutines are similar to threads, however they do not run simultaneously. They offer a way to split up tasks and dynamically pause & resume functions.
**/
@:native("_G.coroutine")extern class CoroutineLib {
    
    /**
        Creates a coroutine of the given function.
		
		Name | Description
		--- | ---
		`func` | The function for the coroutine to use
		
		
		`**Returns:** coroutine
		
		___
		### Lua Examples
		#### Example 1
		Display the location of each player in an endless loop, but only one player per frame.
		
		```lua 
		do
		    local function displayer()
		        local players
		        while true do -- endless loop: you must guarantee that coroutine.yield() is always called!
		            players = player.GetAll()
		            if not next( players ) then -- empty table
		                coroutine.yield() -- guarantee a pause in coroutine even with an empty table
		            else
		                for _, ply in pairs( players ) do
		                    coroutine.yield() -- We yield here so what you may do next will start immediatly when this for loop finishes.
		                    if IsValid( ply ) then -- The player ply may be disconnected now!
		                        print( ply:Nick(), "is located at", ply:GetPos() )
		                    end
		                end
		                
		            end
		        end
		    end
		    
		    local co
		    hook.Add( "Think", "DisplayPlayersLocation", function()
		        if not co or not coroutine.resume( co ) then
		            co = coroutine.create( displayer )
		            coroutine.resume( co )
		        end
		    end )
		end
		```
    **/
    
    public static function create(func:Function):Thread;
    
    
    /**
        Pauses the active coroutine and passes all additional variables to the call of coroutine.resume that resumed the coroutine last time, and returns all additional variables that were passed to the previous call of resume.
		
		Name | Description
		--- | ---
		`returnValue` | Arguments to be returned by the last call of coroutine. resume
		
		
		`**Returns:** Arguments that were set previously by coroutine. resume
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of using varargs as a return value.
		
		```lua 
		local co = coroutine.create( function()
		    coroutine.yield( "Hello world!" )
		end )
		print( coroutine.resume( co ) )
		```
		**Output:**
		
		true, "Hello world!"
    **/
    
    public static function yield(returnValue:Rest<Dynamic>):Rest<Dynamic>;
    
    
    /**
        Returns the status of the coroutine passed to it, the possible statuses are "suspended", "running", and "dead".
		
		Name | Description
		--- | ---
		`coroutine` | Coroutine to check the status of.
		
		
		`**Returns:** status
    **/
    
    public static function status(coroutine:Thread):String;
    
    
    /**
        Returns a function which calling is equivalent with calling coroutine.resume with the coroutine and all extra parameters.
		
		Name | Description
		--- | ---
		`coroutine` | Coroutine to resume.
		
		
		`**Returns:** func
    **/
    
    public static function wrap(coroutine:Function):Function;
    
    
    /**
        Resumes the given coroutine and passes the given vararg to either the function arguments or the coroutine.yield that is inside that function and returns whatever yield is called with the next time or by the final return in the function.
		
		Name | Description
		--- | ---
		`coroutine` | Coroutine to resume.
		`args` | Arguments to be returned by coroutine. yield.
		
		
		Name | Description
		--- | ---
		`a` | If the executed thread code had no errors occur within it.
		`b` | If an error occured, this will be a string containing the error message. Otherwise, this will be arguments that were yielded.
    **/
    
    public static function resume(coroutine:Thread, args:Rest<Dynamic>):CoroutineLibResumeReturn;
    
    
    /**
        Yields the coroutine for the given duration before continuing. 
		
		This only works inside a coroutine. 
		
		 This function uses CurTime instead of RealTime.
		
		Name | Description
		--- | ---
		`duration` | The number of seconds to wait
    **/
    
    public static function wait(duration:Float):Void;
    
    
    /**
        Returns the active coroutine or nil if we are not within a coroutine.
		
		`**Returns:** coroutine
    **/
    
    public static function running():Thread;
    
    

}


@:multiReturn extern class CoroutineLibResumeReturn {
var a:Bool;
var b:Rest<Dynamic>;

}

