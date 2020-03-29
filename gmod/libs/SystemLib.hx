package gmod.libs;


/**
    The system library provides functions that allow you to gather information about the system running the game, such as operating system, uptime and battery level.
**/
@:native("_G.system")extern class SystemLib {
    
    /**
        Returns the country code of this computer, determined by the localisation settings of the OS.
		
		**Note:** This function does not work on Dedicated Servers and will instead return no value.
		
		`**Returns:** Two-letter country code, using ISO 3166-1 standard.
    **/
    
    public static function GetCountry():String;
    
    
    /**
        Returns the amount of seconds since the Steam user last moved their mouse. 
		
		This is a direct binding to ISteamUtils->GetSecondsSinceComputerActive, and is most likely related to Steam's automatic "Away" online status.
		
		**Note:** This function does not work on Dedicated Servers and will instead return no value.
		
		`**Returns:** The amount of seconds since the Steam user last moved their mouse.
    **/
    
    public static function UpTime():Float;
    
    
    /**
        Returns whether the current OS is Linux.
		
		`**Returns:** Whether or not the game is running on Linux.
    **/
    
    public static function IsLinux():Bool;
    
    
    /**
        Returns whether the current OS is Windows.
		
		`**Returns:** Whether the system the game runs on is Windows or not.
    **/
    
    public static function IsWindows():Bool;
    
    
    /**
        Returns whether or not the game window has focus. 
		
		Returns true 100% of the time on OS X.
		
		**Note:** This function does not work on dedicated servers and will instead return no value.
		
		**Bug:** BUG This will return true when minimized in windowed-mode. Issue Tracker: #2424
		
		`**Returns:** Whether or not the game window has focus.
    **/
    
    public static function HasFocus():Bool;
    
    #if client
    /**
        Returns whether the game is being run in a window or in fullscreen (you can change this by opening the menu, clicking 'Options', then clicking the 'Video' tab, and changing the Display Mode using the dropdown menu):
		
		`**Returns:** Is the game running in a window?
		
		___
		### Lua Examples
		#### Example 1
		If the game is windowed, then the game window will flash
		
		```lua 
		if system.IsWindowed() then
		    system.FlashWindow()
		end
		```
    **/
    
    public static function IsWindowed():Bool;
    #end
    
    /**
        Returns whether the current OS is OSX.
		
		`**Returns:** Whether or not the game is running on OSX.
    **/
    
    public static function IsOSX():Bool;
    
    
    /**
        Returns the synchronized Steam time. This is the number of seconds since the Unix epoch.
		
		**Note:** This function does not work on Dedicated Servers and will instead return no value.
		
		`**Returns:** Current Steam-synchronized Unix time.
    **/
    
    public static function SteamTime():Float;
    
    
    /**
        Returns the current battery power.
		
		`**Returns:** 0-100 if on battery power. If plugged in, the value will be 255 regardless of charging state.
    **/
    
    public static function BatteryPower():Float;
    
    #if client
    /**
        Flashes the window. Currently works only on Windows.
    **/
    
    public static function FlashWindow():Void;
    #end
    
    /**
        Returns the total uptime of the current application as reported by Steam. 
		
		This will return a similar value to SysTime.
		
		**Note:** This function does not work on Dedicated Servers and will instead return no value.
		
		`**Returns:** Seconds of game uptime as an integer.
    **/
    
    public static function AppTime():Float;
    
    

}



