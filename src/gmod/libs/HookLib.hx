package gmod.libs;


import gmod.Gmod.AnyMultiReturn;
import gmod.Hook;

/**
    The hook library allows you to add hooks called by the game engine, allowing multiple scripts to modify game function.
**/
@:native("_G.hook")extern class HookLib {
    
    /**
        Removes the hook with the supplied identifier from the given event.
		
		Name | Description
		--- | ---
		`eventName` | The event name.
		`identifier` | The unique identifier of the hook to remove, usually a string.
		
		
		___
		### Lua Examples
		#### Example 1
		Darkens the player's screen for 15 seconds.
		
		```lua 
		hook.Add( "HUDPaint", "my_hook_identifier", function()
		    
		    surface.SetDrawColor( 0, 0, 0, 150 )
		    surface.DrawRect( 0, 0, ScrW(), ScrH() )
		    
		end )
		
		timer.Simple( 15, function()
		
		    hook.Remove( "HUDPaint", "my_hook_identifier" )
		
		end )
		```
		**Output:**
		
		After the hook gets removed, the dark overlay doesn't appear anymore.
    **/
    
    static function Remove<T:Function>(eventName:Hook<T>, identifier:Dynamic):Void;
    
    
    /**
        Add a hook to be called upon the given event occurring.
		
		**Warning:** Returning any value besides nil from the hook's function will stop other hooks of the same event down the loop from being executed. Only return a value when absolutely necessary and when you know what you are doing. It WILL break other addons.
		
		Name | Description
		--- | ---
		`eventName` | The event to hook on to, see GM Hooks and Sandbox Hooks
		`identifier` | The unique identifier, usually a string. This can be used elsewhere in the code to replace or remove the hook. The identifier should be unique so that you do not accidentally override some other mods hook, unless that's what you are trying to do. The identifier can be either a string, or a table/object with an IsValid function defined such as an Entity or Panel. numbers and booleans, for example, are not allowed. If the identifier is a table/object, it will be inserted in front of the other arguments in the callback and the hook will be called as long as it's valid. However, as soon as IsValid( identifier ) returns false, the hook will be removed.
		`func` | The function to be called, arguments given to it depend on the hook. WARNING Returning any value besides nil from the hook's function will stop other hooks of the same event down the loop from being executed. Only return a value when absolutely necessary and when you know what you are doing. It WILL break other addons.
		
		
		___
		### Lua Examples
		#### Example 1
		This will hook onto the "Think" event with the function onThink, printing to the console whenever the event occurs.
		
		```lua 
		local function onThink()
		    print( "onThink has been called" )
		end
		
		hook.Add( "Think", "Some unique name", onThink )
		```
		**Output:**
		
		"onThink has been called" repeating continuously.
		
		#### Example 2
		This works the same as above, but defines the function inside hook.Add rather than above it.
		
		```lua 
		hook.Add( "Think", "Another unique name", function()
		    print( "Think has been called" )
		end )
		```
		**Output:**
		
		"Think has been called" repeating continuously.
		
		#### Example 3
		This code demonstrates how you can add a table function with a 'self' argument, without the use of a wrapper function
		
		```lua 
		local myTable = {}
		function myTable:IsValid()
		    return true
		end
		
		function myTable:PlayerInitialSpawn(ply)
		    print( "CustomHook", self, ply )
		end
		
		hook.Add( "CustomHook" , myTable , myTable.PlayerInitialSpawn )
		hook.Run( "CustomHook" )
		```
		**Output:**
		
		"CustomHook table: 0x00000000 Player [1][PotatoMan]"
    **/
    static function Add<T:Function>(eventName:Hook<T>, identifier:Any, func:T):Void;
    
    
    /**
        Calls all hooks associated with the given event until one returns something other than nil, and then returns that data. 
		
		In almost all cases, you should use hook.Run instead - it calls hook.Call internally but supplies the gamemode table by itself, making your code neater.
		
		Name | Description
		--- | ---
		`eventName` | The event to call hooks for
		`gamemodeTable` | If the gamemode is specified, the gamemode hook within will be called, otherwise not
		`args` | The arguments to be passed to the hooks
		
		
		`**Returns:** Return data from called hooks. Limited to 6 return values
		
		___
		### Lua Examples
		#### Example 1
		Runs function DoSomething, which eventually calls the event "DoneDoingSomething", triggering the hooked function DoSomethingElse.
		
		```lua 
		function DoSomething()
		    --Does something
		    hook.Call("DoneDoingSomething")
		end
		
		function DoSomethingElse()
		    --Does something else, once the hook DoneDoingSomething is called.
		    print("Done!")
		end
		hook.Add( "DoneDoingSomething", "Does something else", DoSomethingElse )
		
		DoSomething()
		```
		**Output:**
		
		Done!
		
		#### Example 2
		You can also make custom functions controllable via hooks.
		
		```lua 
		function MakeCheese()
		    local shouldMakeCheese = hook.Call("MakeCheezPleez")
		
		    if shouldMakeCheese then
		        print("yay")
		    else
		        print("nay")
		    end
		end
		
		function MakeCheeseOrNot()
		    if #player.GetAll() >= 1 then
		        return true
		    else
		        return false
		    end
		end
		hook.Add( "MakeCheezPleez", "Does something else", MakeCheeseOrNot )
		
		MakeCheese()
		```
		**Output:**
		
		If there is players in the server, we print "yay". If there isn't, we print "nay"
		
		#### Example 3
		Calls the event "DoneDoingSomething" with args
		
		```lua 
		hook.Add("DoneDoingSomething", "Does something else", function(a, b)
		    print(a)
		    print(b)
		end)
		
		
		hook.Call("DoneDoingSomething", nil, "Hello", "Hey")
		```
		**Output:**
		
		Hello Hey
    **/
    
    static function Call<T:Function>(eventName:Hook<T>, gamemodeTable:AnyTable, args:Rest<Dynamic>):AnyMultiReturn;
    
    
    /**
        Returns a list of all the hooks registered with hook.Add.
		
		`**Returns:** A table of tables. See below for output example.
		
		___
		### Lua Examples
		#### Example 1
		Example of output table structure.
		
		```lua 
		PrintTable( hook.GetTable() )
		```
    **/
    
    static function GetTable():Table<String,Table<String,Function>>;
    
    
    /**
        Calls hooks associated with the given event. 
		
		Calls all hooks until one returns something other than nil and then returns that data. If no hook returns any data, it will try to call the GAMEMODE:<eventName> alternative, if one exists. 
		
		 This function internally calls hook.Call. 
		
		 See also: gamemode.Call - same as this, but does not call hooks if the gamemode hasn't defined the function.
		
		Name | Description
		--- | ---
		`eventName` | The event to call hooks for
		`args` | The arguments to be passed to the hooks
		
		
		`**Returns:** Returned data from called hooks
    **/
    static function Run<T:Function>(eventName:Hook<T>, args:Rest<Dynamic>):Dynamic;
    
    

}



