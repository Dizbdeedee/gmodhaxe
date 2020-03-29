package gmod.libs;


/**
    The timer library is a very useful set of functions which allow you to run a function periodically or after a given delay.
**/
@:native("_G.timer")extern class TimerLib {
    
    /**
        Stops and removes a timer created by timer.Create.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer to remove.
    **/
    
    public static function Remove(identifier:String):Void;
    
    
    /**
        Returns amount of time left (in seconds) before the timer executes its function.
		
		**Note:** If the timer is paused, the amount will be negative.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** The amount of time left (in seconds).
    **/
    
    public static function TimeLeft(identifier:Dynamic):Float;
    
    
    /**
        Unpauses the timer.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** false if the timer didn't exist or was already running, true otherwise.
    **/
    
    public static function UnPause(identifier:Dynamic):Bool;
    
    
    /**
        Creates a simple timer that runs the given function after a specified delay. 
		
		For a more advanced version that you can control after creation, see timer.Create.
		
		**Warning:** Timers won't advance while the client is timing out from the server.
		
		**Note:** Timers use CurTime for timing.
		
		Name | Description
		--- | ---
		`delay` | How long until the function should be ran (in seconds). Use 0 to have the function run in the next GM: Think.
		`func` | The function to run after the specified delay.
		
		
		___
		### Lua Examples
		#### Example 1
		Print "Hello World" after 5 seconds.
		
		```lua 
		timer.Simple( 5, function() print( "Hello World" ) end )
		```
		**Output:**
		
		Hello World
		
		#### Example 2
		Spawns 5 zombies and creates a timer.Simple that removes them in 11, 12, 13, 14, and 15 seconds.
		
		```lua 
		for i = 1, 5 do
		    local zombie = ents.Create("npc_zombie")
		    zombie:SetPos( Vector( i*40, 0 , 250 ) )
		    zombie:Spawn()
		
		    timer.Simple( 10 + i, function() zombie:Remove() end  )
		end
		```
		**Output:**
		
		--11 seconds into game 1st zombie disappears --12 seconds into game 2nd zombie disappears etc.
    **/
    
    public static function Simple(delay:Float, func:Function):Void;
    
    
    /**
        ***Deprecated:** You should be using timer. Remove instead.
		
		Stops and destroys the given timer. Alias of [timer](https://wiki.garrysmod.com/page/Category:timer). [Remove](https://wiki.garrysmod.com/page/timer/Remove).
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer to destroy.
    **/
    @:deprecated("You should be using timer. Remove instead.")
    public static function Destroy(identifier:String):Void;
    
    
    /**
        Creates a new timer that will repeat its function given amount of times. This function also requires the timer to be named, which allows you to control it after it was created via the timer library. 
		
		For a simple one-time timer with no identifiers, see timer.Simple.
		
		**Warning:** Timers won't advance while the client is timing out from the server.
		
		**Note:** Timers use CurTime for timing.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer to create. Must be unique. If a timer already exists with the same identifier, that timer will be updated to the new settings and reset.
		`delay` | The delay interval in seconds. If the delay is too small, the timer will fire on the next frame/tick.
		`repetitions` | The number of times to repeat the timer. Enter 0 for infinite repetitions.
		`func` | Function called when timer has finished the countdown.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a timer that has a 1 second delay and is only ran once ('UniqueName1'), a timer that has a 2 second delay and is ran continuously ('UniqueName2'), etc.This shows the different ways you can interact with functions.
		
		```lua 
		local function PrintSomething( text )
		    print( text )
		end
		
		local function PrintNoArguments()
		    print( "fun with timers!" )
		end
		
		local function CreateSomeTimers( )
		    timer.Create( "UniqueName1", 1, 1, function() print("inside") end )
		    timer.Create( "UniqueName2", 2, 0, function() PrintSomething("outside") end )
		    timer.Create( "UniqueName3", 5, 1, PrintNoArguments )
		end
		hook.Add( "Initialize", "Timer Example", CreateSomeTimers )
		```
		**Output:**
		
		inside -- 1 second outside -- 2 seconds outside -- 4 seconds fun with timers! -- 5 seconds outside -- 6 seconds outside -- 8 seconds
		
		#### Example 2
		Creates a timer that has 0.01 second delay, to demonstrate that the "minimum" delay of a timer is locked at the tickrate period (1/66 seconds).(As the example below shows, by setting the delay rate to 1/100 (0.01 seconds), the difference in time between the iterations of the timer should be 0.01 seconds, but instead, it is 0.149 (1/66) seconds).
		
		```lua 
		local tick = {} 
		local tick_key = 1 
		
		local function MinimumTimerDelay()    
		    local current_time = CurTime() 
		    if tick_key > 1 then 
		        print( "Timer Iteration #" .. tick_key - 1 .. " had a delay of " .. current_time - tick[tick_key - 1])
		    end
		    tick[tick_key] = current_time 
		    tick_key = tick_key + 1    
		end
		
		local function Timer()
		    timer.Create("Timer Delay", (1/100), 10, MinimumTimerDelay ) 
		end
		
		hook.Add("Initialize", "Commence Timers", Timer)
		```
		**Output:**
		
		Timer Iteration #1 had a delay of 0.014999389648438 Timer Iteration #2 had a delay of 0.014999389648438 Timer Iteration #3 had a delay of 0.014999389648438 Timer Iteration #4 had a delay of 0.0150146484375 Timer Iteration #5 had a delay of 0.014999389648438 Timer Iteration #6 had a delay of 0.014999389648438 Timer Iteration #7 had a delay of 0.014999389648438 Timer Iteration #8 had a delay of 0.014999389648438 Timer Iteration #9 had a delay of 0.014999389648438
    **/
    
    public static function Create(identifier:String, delay:Float, repetitions:Float, func:Function):Void;
    
    
    /**
        Pauses the given timer.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** false if the timer didn't exist or was already paused, true otherwise.
    **/
    
    public static function Pause(identifier:Dynamic):Bool;
    
    
    /**
        Restarts the given timer.
		
		**Warning:** Timers won't advance while the client is timing out from the server.
		
		**Note:** Timers use CurTime for timing.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** true if the timer exists, false if it doesn't.
    **/
    
    public static function Start(identifier:Dynamic):Bool;
    
    
    /**
        Returns amount of repetitions/executions left before the timer destroys itself.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** The amount of executions left.
    **/
    
    public static function RepsLeft(identifier:Dynamic):Float;
    
    
    /**
        ***Deprecated:** 
		
		This function does nothing.
    **/
    @:deprecated("")
    public static function Check():Void;
    
    
    /**
        Returns whenever the given timer exists or not.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** Returns true if the timer exists, false if it doesn't
		
		___
		### Lua Examples
		#### Example 1
		Checks it the timer exists
		
		```lua 
		if ( timer.Exists( "TimerName" ) ) then
		
		    -- The timer exists
		    print( "The timer exists" )
		    
		else
		    -- The timer doesn't exist
		    print( "The timer does not exist!" )
		
		    -- Create a timer
		    timer.Create( "TimerName", 1, 0, function() print( "I'm a Timer" ) end)
		end
		```
		**Output:**
		
		The timer does not exist! I'm a Timer I'm a Timer I'm a Timer I'm a Timer
    **/
    
    public static function Exists(identifier:String):Bool;
    
    
    /**
        Adjusts the timer if the timer with the given identifier exists.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer to adjust.
		`delay` | The delay interval in seconds.
		`repetitions` | Repetitions. Use 0 for infinite.
		`func` | The new function.
		
		
		`**Returns:** true if succeeded
    **/
    
    public static function Adjust(identifier:Dynamic, delay:Float, repetitions:Float, func:Function):Bool;
    
    
    /**
        Runs either timer.Pause or timer.UnPause based on the timer's current status.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** status of the timer.
    **/
    
    public static function Toggle(identifier:Dynamic):Bool;
    
    
    /**
        Stops the given timer and rewinds it.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the timer.
		
		
		`**Returns:** false if the timer didn't exist or was already stopped, true otherwise.
    **/
    
    public static function Stop(identifier:Dynamic):Bool;
    
    

}



